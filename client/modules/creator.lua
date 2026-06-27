local function IsPointInsideEntityBounds(entity, point)
    local model = GetEntityModel(entity)
    local min, max = GetModelDimensions(model)
    local coords = GetEntityCoords(entity)

    local sizeX = max.x - min.x
    local sizeY = max.y - min.y
    local sizeZ = max.z - min.z

    local boundsMin = vec3(coords.x - sizeX, coords.y - sizeY, coords.z - sizeZ)
    local boundsMax = vec3(coords.x + sizeX, coords.y + sizeY, coords.z + sizeZ)

    return point.x >= boundsMin.x
end

local DrawTextLabels = {
    entry = i18n.t("drawtext.entry_point"),
    board = i18n.t("drawtext.board_point"),
    shell = i18n.t("drawtext.shell_point"),
    exit = i18n.t("drawtext.exit_point"),
    customHouse = i18n.t("drawtext.house_point"),
}

local function SpawnShellObject(position, shellIndex, heading)
    local shellData = Config.Shells[shellIndex]
    if not shellData then
        shellData = Config.Shells[1]
    end

    local modelHash = joaat(shellData.model)
    lib.requestModel(modelHash, Config.DefaultRequestModelTimeout)

    local object = CreateObject(modelHash, position.x, position.y, position.z, false, true, true)
    SetEntityCollision(object, false, false)
    SetEntityCompletelyDisableCollision(object, true, false)
    FreezeEntityPosition(object, true)
    SetEntityInvincible(object, true)
    SetEntityDrawOutline(object, true)
    SetModelAsNoLongerNeeded(modelHash)
    SetEntityDrawOutlineColor(0, 255, 0, 255)

    if heading then
        SetEntityHeading(object, heading)
    end

    return object
end

local function SpawnHouseObject(position, objectIndex, heading, isIsland)
    local objectList
    if isIsland and Config.Islands then
        objectList = Config.Islands
    else
        objectList = Config.HouseObjects
    end

    local objectData = objectList[objectIndex]
    if not objectData then
        objectData = objectList[1]
    end

    local modelHash = joaat(objectData.model)
    lib.requestModel(modelHash, Config.DefaultRequestModelTimeout)

    local object = CreateObject(modelHash, position.x, position.y, position.z, false, true, true)
    SetEntityCollision(object, false, false)
    SetEntityCompletelyDisableCollision(object, true, false)
    FreezeEntityPosition(object, true)
    SetEntityInvincible(object, true)
    SetEntityDrawOutline(object, true)
    SetModelAsNoLongerNeeded(modelHash)
    SetEntityDrawOutlineColor(0, 255, 0, 255)

    if heading then
        SetEntityHeading(object, heading)
    end

    return object
end

local function RayCastSelectorImpl(mode, options)
    local ped = cache.ped
    local rightVector, forwardVector, upVector, pedPosition = GetEntityMatrix(ped)
    local pedHeading = GetEntityHeading(ped)

    local camPosition = pedPosition + upVector * 2

    local camOffset = options and options.camOffset
    if camOffset then
        camPosition = pedPosition + camOffset
    end

    if "shell" == mode then
        camPosition = pedPosition - Config.MinZOffset
    elseif "exit" == mode then
        local exitCoords = vec3(options.coords.x, options.coords.y, options.coords.z)
        camPosition = exitCoords + upVector * 2
    end

    local camRotation = vector3(-35.0, 0.0, 0.0)
    local camera = Utils.CreateCamera("DEFAULT_SCRIPTED_CAMERA", camPosition, camRotation, true)

    local controlNames = {"done", "cancel", "up", "right", "forward", "rotate_z"}

    if "shell" == mode then
        controlNames[#controlNames + 1] = "increase_z"
        controlNames[#controlNames + 1] = "change_shell"
        controlNames[#controlNames + 1] = "decrease_z"
    elseif "customHouse" == mode then
        ActionControls.rotate_z_scroll.label = i18n.t("creator.raycast.scroll_position_z")
        controlNames[#controlNames + 1] = "rotate_z_scroll"
    end

    local controls = Utils.GetControls(controlNames)
    local instructionalScaleform = Utils.CreateInstructional(controls)

    EnabledMouseMovement = true

    local result = nil
    local drawTextLabel = DrawTextLabels[mode]
    local previewEntity = nil
    local entityHeading = nil
    local zOverride = nil
    local shellEntity = nil
    local currentIndex = 1

    local function ConfirmSelection()
        lib.hideMenu()

        if mode:includes({"entry", "board", "shell", "customHouse"}) then
            local coords = GetEntityCoords(previewEntity)
            local heading = GetEntityHeading(previewEntity)
            result = vec4(coords.x, coords.y, coords.z, heading)
            DeleteEntity(previewEntity)
        elseif "exit" == mode then
            local coords = GetEntityCoords(previewEntity)
            local heading = GetEntityHeading(previewEntity)
            result = vec4(coords.x, coords.y, coords.z, heading)
            DeleteEntity(shellEntity)
            DeleteEntity(previewEntity)
        end
    end

    local function FinishAndReturn()
        ConfirmSelection()
        EnableAllControlActions(0)
        Utils.DestroyFlyCam(camera)
        RefreshPolyZones()

        if "shell" == mode or "customHouse" == mode then
            return currentIndex, result
        end

        return result
    end

    -- Initialize preview entity based on mode
    if "entry" == mode then
        result = vec4(pedPosition.x, pedPosition.y, pedPosition.z, pedHeading)
        previewEntity = ClonePed(cache.ped, false, false, true)
        SetEntityAlpha(previewEntity, Config.CreatorAlpha, false)
        entityHeading = pedHeading
    elseif "board" == mode then
        local boardHash = joaat(Config.BoardObject)
        lib.requestModel(boardHash, Config.DefaultRequestModelTimeout)
        previewEntity = CreateObject(joaat(Config.BoardObject), pedPosition.x, pedPosition.y, pedPosition.z, false, true, true)
        SetEntityAlpha(previewEntity, Config.CreatorAlpha, false)
        SetModelAsNoLongerNeeded(boardHash)
        entityHeading = pedHeading
    elseif "shell" == mode then
        previewEntity = SpawnShellObject(pedPosition, currentIndex, pedHeading)
        entityHeading = pedHeading
    elseif "exit" == mode then
        previewEntity = ClonePed(cache.ped, false, false, true)
        SetEntityAlpha(previewEntity, Config.CreatorAlpha, false)
        shellEntity = SpawnShellObject(options.coords, options.tier, options.coords.w)
        entityHeading = options.coords.w
    elseif "customHouse" == mode then
        previewEntity = SpawnHouseObject(pedPosition, currentIndex, pedHeading, options and options.isIsland)
        entityHeading = pedHeading
    end

    -- Determine object list for cycling
    local objectList
    if "customHouse" == mode and (options and options.isIsland) and Config.Islands then
        objectList = Config.Islands
    else
        objectList = Config.HouseObjects
    end

    while true do
        Wait(0)
        DisableAllControlActions(0)

        local newCamPos, newCamRot = Utils.HandleFlyCam(camera)
        camRotation = newCamRot
        camPosition = newCamPos

        local frameTime = GetFrameTime()
        local camRight, camForward, camUp, camPos = GetCamMatrix(camera)

        local hitCoords = nil
        local hitStatus = nil
        local hitNormal = nil
        local hitResult = nil
        local hitEntity = nil

        if "shell" == mode then
            hitCoords = camPos + camForward * 25.0
        else
            local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(
                camPos.x, camPos.y, camPos.z,
                camPos.x + camForward.x * 100.0,
                camPos.y + camForward.y * 100.0,
                camPos.z + camForward.z * 100.0,
                4294967295, previewEntity, 7
            )
            hitResult, hitStatus, hitCoords, hitNormal, hitEntity = GetShapeTestResult(rayHandle)
        end

        -- Done button pressed
        if IsDisabledControlJustPressed(0, ActionControls.done.codes[1]) then
            if "exit" == mode then
                if IsPointInsideEntityBounds(shellEntity, hitCoords) then
                    return FinishAndReturn()
                else
                    Notification(i18n.t("coords_not_in_shell"), "error")
                end
            else
                local needsInsideCheck = Config.NeedToBeInsidePoints[mode]
                if not needsInsideCheck then
                    return FinishAndReturn()
                else
                    if creator:isInPoints(hitCoords) then
                        return FinishAndReturn()
                    else
                        Notification(i18n.t("polyzone_nearby"), "error")
                    end
                end
            end
        end

        -- Cancel button pressed
        if IsDisabledControlJustPressed(0, ActionControls.cancel.codes[1]) or IsDisabledControlJustPressed(0, 322) then
            ConfirmSelection()
            EnableAllControlActions(0)
            Utils.DestroyFlyCam(camera)
            RefreshPolyZones()
            return false
        end

        -- Shell/CustomHouse specific controls (Z offset and model cycling)
        if mode:includes({"shell", "customHouse"}) then
            -- Increase Z (move down)
            if IsDisabledControlPressed(0, ActionControls.increase_z.codes[1]) then
                zOverride = zOverride or hitCoords.z
                zOverride = zOverride - 0.1
            end

            -- Increase Z (move up)
            if IsDisabledControlPressed(0, ActionControls.increase_z.codes[2]) then
                zOverride = zOverride or hitCoords.z
                zOverride = zOverride + 0.1
            end

            -- Change shell/house (next)
            if IsDisabledControlJustPressed(0, ActionControls.change_shell.codes[1]) then
                local maxCount
                if "shell" == mode then
                    maxCount = #Config.Shells
                else
                    maxCount = #objectList
                end

                if maxCount >= currentIndex + 1 then
                    currentIndex = currentIndex + 1
                else
                    currentIndex = 1
                end

                local currentPos = GetEntityCoords(previewEntity)
                DeleteEntity(previewEntity)

                if "shell" == mode then
                    previewEntity = SpawnShellObject(currentPos, currentIndex, entityHeading)
                else
                    previewEntity = SpawnHouseObject(currentPos, currentIndex, entityHeading, options and options.isIsland)
                end
            end

            -- Change shell/house (previous)
            if IsDisabledControlJustPressed(0, ActionControls.change_shell.codes[2]) then
                local maxCount
                if "shell" == mode then
                    maxCount = #Config.Shells
                else
                    maxCount = #objectList
                end

                if currentIndex - 1 > 0 then
                    currentIndex = currentIndex - 1
                else
                    currentIndex = maxCount
                end

                local currentPos = GetEntityCoords(previewEntity)
                DeleteEntity(previewEntity)

                if "shell" == mode then
                    previewEntity = SpawnShellObject(currentPos, currentIndex, entityHeading)
                else
                    previewEntity = SpawnHouseObject(currentPos, currentIndex, entityHeading, options and options.isIsland)
                end
            end
        end

        -- Rotate Z (clockwise)
        if IsDisabledControlPressed(0, ActionControls.rotate_z.codes[1]) then
            if mode:includes({"entry", "board", "shell", "exit", "customHouse"}) then
                entityHeading = entityHeading + 1.0
            end
        end

        -- Rotate Z (counter-clockwise)
        if IsDisabledControlPressed(0, ActionControls.rotate_z.codes[2]) then
            if mode:includes({"entry", "board", "shell", "exit", "customHouse"}) then
                entityHeading = entityHeading - 1.0
            end
        end

        -- Update entity position and heading
        SetEntityCoords(previewEntity, hitCoords.x, hitCoords.y, zOverride or hitCoords.z, false, false, false, false)
        SetEntityHeading(previewEntity, entityHeading)

        -- Draw visual indicators (not for shell mode)
        if "shell" ~= mode then
            DrawLine(hitCoords.x, hitCoords.y, hitCoords.z, hitCoords.x, hitCoords.y, hitCoords.z + 10.0, 255, 0, 0, 255)
            DrawText3Ds(hitCoords.x, hitCoords.y, hitCoords.z + 1.0, drawTextLabel)
        end

        Utils.DrawScaleform(instructionalScaleform)
    end
end

RayCastSelector = RayCastSelectorImpl

local function RayCastGetMLOImpl()
    local doors = {}
    local ped = cache.ped
    local rightVector, forwardVector, upVector, pedPosition = GetEntityMatrix(ped)

    local camPosition = pedPosition + upVector * 2
    local camRotation = vector3(-35.0, 0.0, 0.0)
    local lastDoorCoords = false

    local camera = Utils.CreateCamera("DEFAULT_SCRIPTED_CAMERA", camPosition, camRotation, true)

    local controls = Utils.GetControls({"done", "cancel", "add_point", "undo_point"})
    local instructionalScaleform = Utils.CreateInstructional(controls)

    EnabledMouseMovement = true

    local markerColor = {r = 116, g = 189, b = 252, a = 100}

    while true do
        Wait(0)

        -- Done button
        if IsDisabledControlJustPressed(0, ActionControls.done.codes[1]) then
            if #doors > 0 then
                EnableAllControlActions(0)
                Utils.DestroyFlyCam(camera)

                for _, door in pairs(doors) do
                    SetEntityDrawOutline(door.tempHandle, false)
                end

                return doors
            else
                Notification(i18n.t("choose_door"), "error")
            end
        end

        -- Cancel button
        if IsDisabledControlJustPressed(0, ActionControls.cancel.codes[1]) or IsDisabledControlJustPressed(0, 322) then
            EnableAllControlActions(0)
            Utils.DestroyFlyCam(camera)

            for _, door in pairs(doors) do
                SetEntityDrawOutline(door.tempHandle, false)
            end

            return false
        end

        DisableAllControlActions(0)

        local newCamPos, newCamRot = Utils.HandleFlyCam(camera)
        camRotation = newCamRot
        camPosition = newCamPos

        local frameTime = GetFrameTime()
        local camRight, camForward, camUp, camPos = GetCamMatrix(camera)

        local rayHandle = StartShapeTestRay(
            camPos.x, camPos.y, camPos.z,
            camPos.x + camForward.x * 100.0,
            camPos.y + camForward.y * 100.0,
            camPos.z + camForward.z * 100.0,
            -1, ped, 0
        )

        local hitResult, hitStatus, hitCoords, hitNormal, hitEntity = GetShapeTestResult(rayHandle)

        -- Add point button
        if IsDisabledControlJustPressed(0, ActionControls.add_point.codes[1]) then
            if hitEntity then
                if IsEntityAnObject(hitEntity) then
                    local entityCoords = GetEntityCoords(hitEntity)

                    if lastDoorCoords and entityCoords == lastDoorCoords then
                        Notification(i18n.t("door_already_added"), "info")
                    else
                        table.insert(doors, {
                            hash = GetEntityModel(hitEntity),
                            coords = entityCoords,
                            h = GetEntityHeading(hitEntity),
                            locked = true,
                            obj = nil,
                            tempHandle = hitEntity,
                        })

                        lastDoorCoords = entityCoords

                        Notification(i18n.t("creator.new_door"), "success")
                        SetEntityDrawOutline(hitEntity, true)
                        SetEntityDrawOutlineColor(0, 255, 0, 255)
                    end
                end
            else
                Notification(i18n.t("choose_door"), "error")
            end
        end

        -- Undo point button
        if IsDisabledControlJustPressed(0, ActionControls.undo_point.codes[1]) then
            if #doors > 0 then
                local lastDoor = doors[#doors]
                SetEntityDrawOutline(lastDoor.tempHandle, false)
                table.remove(doors, #doors)
                lastDoorCoords = false
                Notification(i18n.t("door_removed"), "success")
            else
                Notification(i18n.t("no_doors"), "error")
            end
        end

        -- Draw marker on hovered object
        if hitEntity then
            if IsEntityAnObject(hitEntity) then
                local entityCoords = GetEntityCoords(hitEntity)
                DrawMarker(21, entityCoords.x, entityCoords.y, entityCoords.z + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 255, false, true, 2, nil, nil, false)
            end
        end

        -- Draw crosshair line
        DrawLine(hitCoords.x, hitCoords.y, hitCoords.z, hitCoords.x, hitCoords.y, hitCoords.z + 1.0, 255, 0, 0, 255)

        Utils.DrawScaleform(instructionalScaleform)
    end
end

RayCastGetMLO = RayCastGetMLOImpl
