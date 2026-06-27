local Junk = lib.class("Junk")
local MAX_COORD_ATTEMPTS = 15

function Junk:constructor()
    self.objects = {}
    self.active = false
    self.isLoopRunning = false
    self.pendingCoordUpdates = {}
    return self
end

function Junk:spawnObject(model, coords)
    local modelHash = joaat(model)
    lib.requestModel(modelHash, Config.DefaultRequestModelTimeout)

    if not HasModelLoaded(modelHash) then
        Debug("Junk:spawnObject - Model not loaded:", model)
        return nil
    end

    local groundZ = self:getGroundZ(coords)
    local spawnPos = vec3(coords.x, coords.y, groundZ)

    local entity = CreateObject(modelHash, spawnPos.x, spawnPos.y, spawnPos.z, false, false, false)
    if not DoesEntityExist(entity) then
        Debug("Junk:spawnObject - Failed to create object:", model)
        SetModelAsNoLongerNeeded(modelHash)
        return nil
    end

    PlaceObjectOnGroundProperly(entity)
    FreezeEntityPosition(entity, true)
    SetEntityAsMissionEntity(entity, false, true)
    SetModelAsNoLongerNeeded(modelHash)

    local heading = math.random(0, 360)
    SetEntityHeading(entity, heading + 0.0)

    Debug("Junk:spawnObject - Spawned:", model, "at", spawnPos, "handle:", entity)
    return entity
end

function Junk:getGroundZ(coords)
    local z = coords.z
    local found, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z + 5.0, false)
    if found and groundZ then
        z = groundZ
    end
    return z
end

function Junk:getHouseTypeInfo(houseId)
    local houseData = Config.Houses[houseId]
    if not houseData then
        return false, nil, nil, nil
    end

    local shellCoords = houseData.coords.shellCoords
    local ipl = nil ~= houseData.ipl and houseData.ipl

    if ipl then
        local shellConfig = Config.Shells[houseData.tier]
        if shellConfig and shellConfig.model then
            local shellHash = joaat(shellConfig.model)
            lib.requestModel(shellHash, Config.DefaultRequestModelTimeout)

            if HasModelLoaded(shellHash) then
                local minDim, maxDim = GetModelDimensions(shellHash)
                local center = vec3(shellCoords.x, shellCoords.y, shellCoords.z)
                SetModelAsNoLongerNeeded(shellHash)
                Debug("Junk:getHouseTypeInfo - Shell dimensions:", minDim, maxDim)
                return true, center, minDim, maxDim
            end
        end
    end

    return false, nil, nil, nil
end

function Junk:generateRandomCoords(houseId)
    local houseData = Config.Houses[houseId]
    if not houseData then
        Debug("Junk:generateRandomCoords - No house data for:", houseId)
        return nil
    end

    local exitCoords = houseData.coords.exit
    if not exitCoords then
        Debug("Junk:generateRandomCoords - No exit coords for:", houseId)
        return nil
    end

    local playerCoords = GetEntityCoords(cache.ped)
    local currentInterior = GetInteriorAtCoords(playerCoords.x, playerCoords.y, playerCoords.z)

    local hasShell, shellCenter, shellMin, shellMax = self:getHouseTypeInfo(houseId)

    for attempt = 1, MAX_COORD_ATTEMPTS, 1 do
        local candidate = nil

        if hasShell and shellCenter and shellMin and shellMax then
            local scaleFactor = 0.7
            local halfExtentX = (shellMax.x - shellMin.x) / 2 * scaleFactor
            local halfExtentY = (shellMax.y - shellMin.y) / 2 * scaleFactor
            local minRadius = 1.5

            local angle = math.random() * 2 * math.pi
            local maxRadius = math.min(halfExtentX, halfExtentY)
            local radius = minRadius + math.random() * (maxRadius - minRadius)

            candidate = vec3(
                shellCenter.x + math.cos(angle) * radius,
                shellCenter.y + math.sin(angle) * radius,
                exitCoords.z
            )
        else
            local cx = exitCoords.x
            local cy = exitCoords.y
            local cz = exitCoords.z
            local maxRadius = 6.0
            local minRadius = 1.5

            local angle = math.random() * 2 * math.pi
            local radius = minRadius + math.random() * (maxRadius - minRadius)

            candidate = vec3(
                cx + math.cos(angle) * radius,
                cy + math.sin(angle) * radius,
                cz
            )

            local candidateInterior = GetInteriorAtCoords(candidate.x, candidate.y, candidate.z)
            if candidateInterior ~= currentInterior then
                Debug("Junk:generateRandomCoords - Interior mismatch, attempt:", attempt)
            else
                local found, groundZ = GetGroundZFor_3dCoord(candidate.x, candidate.y, candidate.z + 5.0, false)
                if found and groundZ then
                    candidate = vec3(candidate.x, candidate.y, groundZ)
                end

                local dist = #(candidate - vec3(exitCoords.x, exitCoords.y, exitCoords.z))
                if dist < 20.0 then
                    Debug("Junk:generateRandomCoords - Generated coords:", candidate, "for house:", houseId, "attempt:", attempt)
                    return candidate
                end
            end
        end
    end

    Debug("Junk:generateRandomCoords - Failed to generate valid coords after", MAX_COORD_ATTEMPTS, "attempts")
    return nil
end

function Junk:spawnSingle(junkData, skipCoordUpdate)
    if junkData.spawned and junkData.handle and DoesEntityExist(junkData.handle) then
        Debug("Junk:spawnSingle - Already spawned:", junkData.id)
        return
    end

    local coords = junkData.coords
    local generatedNew = false

    if not coords then
        coords = self:generateRandomCoords(junkData.house)
        if not coords then
            Debug("Junk:spawnSingle - Failed to generate coords for:", junkData.id)
            return
        end
        generatedNew = true
    end

    local handle = self:spawnObject(junkData.model, coords)
    if handle then
        junkData.coords = coords
        junkData.handle = handle
        junkData.spawned = true
        self.objects[junkData.id] = junkData
        Debug("Junk:spawnSingle - Spawned junk:", junkData.id, junkData.model)

        if generatedNew and not skipCoordUpdate then
            if not self.pendingCoordUpdates[junkData.id] then
                self.pendingCoordUpdates[junkData.id] = true
                lib.callback("housing:junk:updateCoords", false, function(success)
                    self.pendingCoordUpdates[junkData.id] = nil
                    if success then
                        Debug("Junk:spawnSingle - Saved coords to server:", junkData.id)
                    else
                        Debug("Junk:spawnSingle - Failed to save coords to server:", junkData.id)
                    end
                end, junkData.id, { x = coords.x, y = coords.y, z = coords.z })
            end
        end
    end
end

function Junk:despawn(id)
    local obj = self.objects[id]
    if not obj then
        return
    end

    if obj.handle and DoesEntityExist(obj.handle) then
        DeleteEntity(obj.handle)
        Debug("Junk:despawn - Despawned:", id)
    end

    obj.handle = nil
    obj.spawned = false
end

function Junk:fadeOutAndRemove(id, duration)
    local obj = self.objects[id]
    if not obj then
        return
    end

    local handle = obj.handle
    if not handle or not DoesEntityExist(handle) then
        self.objects[id] = nil
        self.pendingCoordUpdates[id] = nil
        return
    end

    if not duration then
        duration = 500
    end

    local startTime = GetGameTimer()
    local startAlpha = GetEntityAlpha(handle)
    SetEntityAlpha(handle, startAlpha, false)

    CreateThread(function()
        while true do
            if not DoesEntityExist(handle) then
                break
            end

            local elapsed = GetGameTimer() - startTime
            local progress = math.min(elapsed / duration, 1.0)
            local currentAlpha = math.floor(startAlpha * (1.0 - progress))
            SetEntityAlpha(handle, currentAlpha, false)

            if progress >= 1.0 then
                Wait(50)
                if DoesEntityExist(handle) then
                    DeleteEntity(handle)
                end
                break
            end

            Wait(0)
        end

        if obj then
            obj.handle = nil
            obj.spawned = false
        end

        self.objects[id] = nil
        self.pendingCoordUpdates[id] = nil
        Debug("Junk:fadeOutAndRemove - Fade-out complete and removed:", id)
    end)
end

function Junk:remove(id, animate)
    local obj = self.objects[id]
    if not obj then
        return
    end

    if nil == animate then
        animate = true
    end

    if animate then
        if obj.handle and DoesEntityExist(obj.handle) then
            self:fadeOutAndRemove(id, 500)
        end
    else
        self:despawn(id)
        self.objects[id] = nil
        self.pendingCoordUpdates[id] = nil
        Debug("Junk:remove - Removed from local cache:", id)
    end
end

function Junk:loadForHouse(houseId)
    if not Config.Cleaning then
        Debug("Junk:loadForHouse - Cleaning is disabled")
        return
    end

    local junkList = lib.callback.await("housing:junk:getForHouse", false, houseId)
    if not junkList or #junkList == 0 then
        Debug("Junk:loadForHouse - No junk for house:", houseId)
        return
    end

    local needsCoords = {}
    local hasCoords = {}

    for _, item in ipairs(junkList) do
        local junkObj = {
            id = item.id,
            house = item.house,
            model = item.model,
            spawned = false,
        }

        local coords = item.coords
        if coords and vec3(coords.x, coords.y, coords.z) then
            junkObj.coords = vec3(coords.x, coords.y, coords.z)
        else
            junkObj.coords = nil
        end

        if junkObj.coords then
            table.insert(hasCoords, junkObj)
        else
            table.insert(needsCoords, junkObj)
        end
    end

    for _, junkObj in ipairs(hasCoords) do
        self:spawnSingle(junkObj, true)
    end

    if #needsCoords > 0 then
        CreateThread(function()
            for _, junkObj in ipairs(needsCoords) do
                if not EnteredHouse or EnteredHouse ~= houseId then
                    Debug("Junk:loadForHouse - Left house during processing")
                    return
                end

                local coords = self:generateRandomCoords(junkObj.house)
                if coords then
                    junkObj.coords = coords
                    self.pendingCoordUpdates[junkObj.id] = true

                    local success = lib.callback.await("housing:junk:updateCoords", false, junkObj.id, { x = coords.x, y = coords.y, z = coords.z })
                    self.pendingCoordUpdates[junkObj.id] = nil

                    if success then
                        self:spawnSingle(junkObj, true)
                        Debug("Junk:loadForHouse - Processed junk:", junkObj.id)
                    else
                        Debug("Junk:loadForHouse - Failed to update coords for:", junkObj.id)
                    end
                end

                Wait(50)
            end
        end)
    end

    Debug("Junk:loadForHouse - Loaded", #junkList, "junk objects for house:", houseId)
end

function Junk:unloadForHouse(houseId)
    for id, obj in pairs(self.objects) do
        if obj.house == houseId then
            self:despawn(id)
            self.objects[id] = nil
        end
    end
    self.pendingCoordUpdates = {}
    Debug("Junk:unloadForHouse - Unloaded all junk for house:", houseId)
end

function Junk:cleanAll()
    for id in pairs(self.objects) do
        self:despawn(id)
    end
    self.objects = {}
    self.pendingCoordUpdates = {}
    Debug("Junk:cleanAll - Cleaned all junk")
end

function Junk:pickup(id, houseId)
    if not CurrentHouseData or not CurrentHouseData.haskey then
        Notification(i18n.t("junk.no_permission"), "error")
        return
    end

    local obj = self.objects[id]
    if not obj then
        Notification(i18n.t("junk.not_found"), "error")
        return
    end

    local animDict = "amb@world_human_janitor@male@idle_a"
    local animName = "idle_a"
    local broomHash = joaat("prop_tool_broom")
    lib.requestModel(broomHash)

    local belowCoords = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 0.0, -5.0)
    local broomProp = CreateObject(broomHash, belowCoords.x, belowCoords.y, belowCoords.z, true, true, true)

    lib.requestAnimDict(animDict)
    TaskPlayAnim(cache.ped, animDict, animName, 8.0, -8.0, -1, 0, 0, false, false, false)

    AttachEntityToEntity(broomProp, cache.ped, GetPedBoneIndex(cache.ped, 28422),
        -0.005, 0.0, 0.0, 360.0, 360.0, 0.0, 1, 1, 0, 1, 0, 1)

    local completed = lib.progressCircle({
        duration = 3000,
        label = i18n.t("junk.cleaning"),
        position = "bottom",
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true,
        },
    })

    if completed then
        ClearPedTasks(cache.ped)
        DeleteEntity(broomProp)

        local success = lib.callback.await("housing:junk:remove", false, id, houseId)
        if success then
            self:remove(id)
            Notification(i18n.t("junk.cleaned"), "success")
        else
            Notification(i18n.t("junk.failed"), "error")
        end
    else
        ClearPedTasks(cache.ped)
        Notification(i18n.t("junk.cancelled"), "info")
    end
end

function Junk:get(id)
    return self.objects[id]
end

function Junk:getAll()
    return self.objects
end

function Junk:findNearby()
    local playerCoords = GetEntityCoords(cache.ped)
    local closestId = nil
    local closestDist = 2.0

    for id, obj in pairs(self.objects) do
        if obj.spawned and obj.handle and DoesEntityExist(obj.handle) then
            local objCoords = GetEntityCoords(obj.handle)
            local dist = #(playerCoords - objCoords)
            if closestDist > dist then
                closestDist = dist
                closestId = id
            end
        end
    end

    return closestId
end

local pressToCleanText = i18n.t("junk.press_to_clean")

function Junk:startInteractionLoop()
    if self.isLoopRunning then
        return
    end

    self.active = true
    self.isLoopRunning = true

    CreateThread(function()
        while true do
            if not self.active then break end
            if not EnteredHouse then break end

            local nearbyId = self:findNearby()
            local sleepTime = 500

            if nearbyId then
                if not Config.UseTarget then
                    local obj = self.objects[nearbyId]
                    if obj and obj.handle and DoesEntityExist(obj.handle) then
                        sleepTime = 0
                        local objCoords = GetEntityCoords(obj.handle)
                        DrawText3D(objCoords.x, objCoords.y, objCoords.z + 0.3, pressToCleanText, "clean_junk", "E")

                        if IsControlJustPressed(0, Keys.E) then
                            self:pickup(nearbyId, EnteredHouse)
                        end
                    end
                end
            end

            Wait(sleepTime)
        end

        self.isLoopRunning = false
        self.active = false
    end)
end

function Junk:stopInteractionLoop()
    self.active = false
end

_G.junk = Junk:new()

RegisterNetEvent("housing:junk:spawn", function(data)
    if not EnteredHouse or EnteredHouse ~= data.house then
        return
    end

    local junkObj = {
        id = data.id,
        house = data.house,
        model = data.model,
        coords = nil,
        spawned = false,
    }

    junk:spawnSingle(junkObj)
    Debug("housing:junk:spawn - New junk spawned:", data.id)
end)

RegisterNetEvent("housing:junk:remove", function(id)
    junk:remove(id)
    Debug("housing:junk:remove - Junk removed:", id)
end)

AddEventHandler("housing:onEnterHouse", function(houseId)
    if not Config.Cleaning then
        return
    end
    Wait(1000)
    junk:loadForHouse(houseId)
    junk:startInteractionLoop()
end)

AddEventHandler("housing:onExitHouse", function(houseId)
    junk:stopInteractionLoop()
    junk:cleanAll()
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        junk:cleanAll()
    end
end)
