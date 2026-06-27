local GREEN_BOX_POSITION = vec3(-2407.29736328125, -2023.800537109375, 690.6831665039062)
local OBJECT_OFFSET = vec3(0.0, 0.0, 0.5)
local MIN_CAMERA_DISTANCE = 3.0
local MAX_CAMERA_DISTANCE = 10.0
local ZOOM_SPEED = 15.0
local MOVE_SPEED = 2.0

_G.furnitureCreator = {
    visible = false,
    token = nil
}

function furnitureCreator:updateUI()
    if not self.visible then
        return
    end

    local furnitureData = table.deepclone(Config.Furniture)

    for _, category in pairs(furnitureData) do
        category.items = table.filter(category.items, function(item)
            return item.creator
        end)
    end

    SendReactMessage("toggle_furniture_creator", {
        visible = true,
        furniture = furnitureData
    })
end

function furnitureCreator:open()
    ToggleHud(false)
    self.visible = true
    SetNuiFocus(true, true)
    self:updateUI()
    Debug("Furniture Creator opened")
end

function furnitureCreator:close()
    if not self.visible then
        return
    end

    self.visible = false
    SendReactMessage("toggle_furniture_creator", { visible = false })
    ToggleHud(true)
    SetNuiFocus(false, false)
    Debug("Furniture Creator closed")
end

RegisterNetEvent("housing:syncFurnitureData", function(furnitureData)
    Config.Furniture = furnitureData
    InitializeFurnitures()
end)

RegisterCommand(Config.FurniCreatorCommand, function(source, args, rawCommand)
    local hasPermission = lib.callback.await("housing:hasPermission", 0)

    if not hasPermission then
        return Notification(i18n.t("no_permission"), "error")
    end

    furnitureCreator:open()
end)

PendingScreenshots = {}
ScreenshotResults = {}

function furnitureCreator:takeScreenshot(objectName)
    Wait(Config.FurniCreator.interval)

    if not self.token then
        self.token = lib.callback.await("housing:getFiveManageToken", false)
    end

    if not self.token then
        Notification(i18n.t("furniture_creator.token_not_set"), "error")
        return
    end

    PendingScreenshots[objectName] = {
        name = objectName,
        timestamp = GetGameTimer()
    }

    Notification(i18n.t("furniture_creator.uploading_image"), "info")

    exports["screenshot-basic"]:requestScreenshot({ encoding = "png" }, function(imageData)
        SendReactMessage("upload_image", {
            image = imageData,
            fiveManageToken = self.token,
            requestId = objectName
        })
    end)

    Debug("Screenshot Request Sent", objectName)
    return objectName
end

function furnitureCreator:hasPendingScreenshots()
    return nil ~= next(PendingScreenshots)
end

RegisterNUICallback("handle_uploaded_image", function(data, cb)
    local pendingData = PendingScreenshots[data.requestId]

    if not pendingData then
        Error("No data found for requestId", data.requestId)
        return cb("error")
    end

    ScreenshotResults[data.requestId] = {
        filePath = data.url,
        name = pendingData.name
    }

    Debug("Screenshot Results", ScreenshotResults[data.requestId], "data", data)

    PendingScreenshots[data.requestId] = nil
    Notification(i18n.t("furniture_creator.image_uploaded"), "success")
    cb("ok")
end)

function furnitureCreator:takeObjectScreenshot(objectName)
    if self.inGreenBox then
        return
    end

    -- Load and create green box model
    local greenBoxHash = joaat("qs_gradient_032")
    RequestModel(greenBoxHash)
    while not HasModelLoaded(greenBoxHash) do
        Wait(0)
    end

    self.greenBox = CreateObject(greenBoxHash, GREEN_BOX_POSITION.x, GREEN_BOX_POSITION.y, GREEN_BOX_POSITION.z, false, false, false)
    FreezeEntityPosition(self.greenBox, true)

    -- Load and create the target object model
    local objectHash = joaat(objectName)
    RequestModel(objectHash)
    while not HasModelLoaded(objectHash) do
        Wait(0)
    end

    local objectPosition = GREEN_BOX_POSITION + OBJECT_OFFSET
    self.object = CreateObject(objectHash, objectPosition.x, objectPosition.y, objectPosition.z, false, false, false)
    FreezeEntityPosition(self.object, true)
    SetEntityHeading(self.object, 0.0)

    self.inGreenBox = true

    -- Save player position and hide player
    self.initialPlayerCoords = GetEntityCoords(cache.ped)
    FreezeEntityPosition(cache.ped, true)
    SetEntityAlpha(cache.ped, 0, false)

    Wait(100)

    -- Calculate camera positioning based on model dimensions
    local objectCoords = GetEntityCoords(self.object)
    local minDim, maxDim = GetModelDimensions(objectHash)
    local modelSize = #(maxDim - minDim)
    local cameraDistance = math.min(modelSize * 2.5, MIN_CAMERA_DISTANCE)
    local cameraAngle = 0.0
    local heightOffset = (maxDim.z - minDim.z) / 2

    local targetCoords = GetEntityCoords(self.object)
    local cameraPos = vec3(
        targetCoords.x + cameraDistance * math.cos(cameraAngle),
        targetCoords.y + cameraDistance * math.sin(cameraAngle),
        targetCoords.z + heightOffset
    )

    -- Create and set up camera
    self.greenBoxCamera = Utils.CreateCamera("DEFAULT_SCRIPTED_CAMERA", cameraPos, vec3(0, 0, 0), true)
    SetCamCoord(self.greenBoxCamera, cameraPos.x, cameraPos.y, cameraPos.z)
    PointCamAtCoord(self.greenBoxCamera, targetCoords.x, targetCoords.y, targetCoords.z)

    -- Object manipulation variables
    local focusPoint = targetCoords
    local objectHeading = 0.0
    local rotationSpeed = 100.0
    local verticalOffset = 0.0
    local verticalSpeed = 0.5
    local moveOffsetX = 0.0
    local moveOffsetY = 0.0

    Utils.DrawInstructional({
        "zoom", "done", "cancel", "up", "rotate_z",
        { key = "forward", label = "Move Object Forward/Back (W/S)" },
        { key = "right", label = "Move Object Left/Right (A/D)" }
    })

    local confirmed = false

    while self.inGreenBox do
        DisableAllControlActions(0)
        SetEntityHeading(self.object, objectHeading)

        -- Forward/backward movement (W key - control 32)
        if IsDisabledControlPressed(0, 32) then
            local cosAngle = -math.cos(cameraAngle) * MOVE_SPEED * GetFrameTime()
            local sinAngle = -math.sin(cameraAngle) * MOVE_SPEED * GetFrameTime()
            moveOffsetX = moveOffsetX + cosAngle
            moveOffsetY = moveOffsetY + sinAngle
        elseif IsDisabledControlPressed(0, 8) then
            local cosAngle = math.cos(cameraAngle) * MOVE_SPEED * GetFrameTime()
            local sinAngle = math.sin(cameraAngle) * MOVE_SPEED * GetFrameTime()
            moveOffsetX = moveOffsetX + cosAngle
            moveOffsetY = moveOffsetY + sinAngle
        end

        -- Left/right movement (A key - control 34)
        if IsDisabledControlPressed(0, 34) then
            local cosAngle = -math.sin(cameraAngle) * MOVE_SPEED * GetFrameTime()
            local sinAngle = math.cos(cameraAngle) * MOVE_SPEED * GetFrameTime()
            moveOffsetX = moveOffsetX + cosAngle
            moveOffsetY = moveOffsetY + sinAngle
        elseif IsDisabledControlPressed(0, 9) then
            local cosAngle = math.sin(cameraAngle) * MOVE_SPEED * GetFrameTime()
            local sinAngle = -math.cos(cameraAngle) * MOVE_SPEED * GetFrameTime()
            moveOffsetX = moveOffsetX + cosAngle
            moveOffsetY = moveOffsetY + sinAngle
        end

        -- Apply object position
        SetEntityCoords(self.object, objectCoords.x + moveOffsetX, objectCoords.y + moveOffsetY, objectCoords.z + verticalOffset, false, false, false, false)

        -- Rotation (Z-axis)
        if IsDisabledControlPressed(0, ActionControls.rotate_z.codes[1]) then
            objectHeading = (objectHeading + rotationSpeed * GetFrameTime()) % 360
        elseif IsDisabledControlPressed(0, ActionControls.rotate_z.codes[2]) then
            objectHeading = (objectHeading - rotationSpeed * GetFrameTime()) % 360
        end

        -- Vertical movement (up/down)
        if IsDisabledControlPressed(0, ActionControls.up.codes[1]) then
            verticalOffset = verticalOffset + verticalSpeed * GetFrameTime()
        elseif IsDisabledControlPressed(0, ActionControls.up.codes[2]) then
            verticalOffset = verticalOffset - verticalSpeed * GetFrameTime()
        end

        -- Zoom in (scroll up)
        if IsDisabledControlPressed(0, ActionControls.rotate_z_scroll.codes[1]) then
            cameraDistance = math.max(MAX_CAMERA_DISTANCE, cameraDistance - ZOOM_SPEED * GetFrameTime())

            local camCoord = GetCamCoord(self.greenBoxCamera)
            local direction = vec3(focusPoint.x - camCoord.x, focusPoint.y - camCoord.y, focusPoint.z - camCoord.z)
            local magnitude = math.sqrt(direction.x ^ 2 + direction.y ^ 2 + direction.z ^ 2)

            if magnitude > 0.01 then
                local normalized = vec3(direction.x / magnitude, direction.y / magnitude, direction.z / magnitude)
                local newCamPos = vec3(
                    focusPoint.x - normalized.x * cameraDistance,
                    focusPoint.y - normalized.y * cameraDistance,
                    focusPoint.z - normalized.z * cameraDistance
                )
                SetCamCoord(self.greenBoxCamera, newCamPos.x, newCamPos.y, newCamPos.z)
            end
        -- Zoom out (scroll down)
        elseif IsDisabledControlPressed(0, ActionControls.rotate_z_scroll.codes[2]) then
            cameraDistance = math.min(MAX_CAMERA_DISTANCE, cameraDistance + ZOOM_SPEED * GetFrameTime())

            local camCoord = GetCamCoord(self.greenBoxCamera)
            local direction = vec3(focusPoint.x - camCoord.x, focusPoint.y - camCoord.y, focusPoint.z - camCoord.z)
            local magnitude = math.sqrt(direction.x ^ 2 + direction.y ^ 2 + direction.z ^ 2)

            if magnitude > 0.01 then
                local normalized = vec3(direction.x / magnitude, direction.y / magnitude, direction.z / magnitude)
                local newCamPos = vec3(
                    focusPoint.x - normalized.x * cameraDistance,
                    focusPoint.y - normalized.y * cameraDistance,
                    focusPoint.z - normalized.z * cameraDistance
                )
                SetCamCoord(self.greenBoxCamera, newCamPos.x, newCamPos.y, newCamPos.z)
            end
        end

        -- Confirm (done)
        if IsDisabledControlJustPressed(0, ActionControls.done.codes[1]) then
            confirmed = true
            self.inGreenBox = false
            break
        end

        -- Cancel
        if IsDisabledControlJustPressed(0, ActionControls.cancel.codes[1]) or IsDisabledControlJustPressed(0, 322) then
            self.inGreenBox = false
            Notification(i18n.t("furniture_creator.screenshot_cancelled"), "error")
            break
        end

        Wait(0)
    end

    Utils.RemoveInstructional()

    if confirmed then
        local requestId = self:takeScreenshot(objectName)
        if not requestId then
            return
        end

        while self:hasPendingScreenshots() do
            Wait(0)
        end

        local result = ScreenshotResults[requestId]
        self:destroyScreenshot()
        ScreenshotResults[requestId] = nil
        return result.filePath
    else
        self:destroyScreenshot()
        return nil
    end
end

function furnitureCreator:destroyScreenshot()
    if self.greenBox then
        if DoesEntityExist(self.greenBox) then
            DeleteEntity(self.greenBox)
            self.greenBox = nil
        end
    end

    if self.object then
        if DoesEntityExist(self.object) then
            DeleteEntity(self.object)
            self.object = nil
        end
    end

    if self.greenBoxCamera then
        Utils.DestroyFlyCam(self.greenBoxCamera)
        self.greenBoxCamera = nil
    end

    if self.initialPlayerCoords then
        SetEntityCoords(cache.ped, self.initialPlayerCoords.x, self.initialPlayerCoords.y, self.initialPlayerCoords.z, false, false, false, false)
        FreezeEntityPosition(cache.ped, false)
        SetEntityAlpha(cache.ped, 255, false)
        self.initialPlayerCoords = nil
    end

    self.inGreenBox = false
end

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        furnitureCreator:destroyScreenshot()
    end
end)
