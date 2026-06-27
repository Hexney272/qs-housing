local function getPedStreamingDistances(pedKey, defaultSpawn, defaultDespawn)
    local streamingConfig = Config.PedStreaming or {}
    local defaults = streamingConfig.default or {}
    local pedConfig = streamingConfig[pedKey] or {}

    local spawnDistance = pedConfig.spawnDistance or defaults.spawnDistance or defaultSpawn
    local despawnDistance = pedConfig.despawnDistance or defaults.despawnDistance or defaultDespawn

    if spawnDistance >= despawnDistance then
        despawnDistance = spawnDistance + 5.0
    end

    return spawnDistance, despawnDistance
end

_G.ikeaDelivery = {}

local state = {}
state.entity = nil
state.ped = nil
state.house = nil
state.coords = nil
state.readyCount = 0
state.collecting = false


local serverCallbacks = {}

function serverCallbacks.getState(houseId)
    return lib.callback.await("housing:getIkeaDeliveryState", false, houseId)
end

function serverCallbacks.collect(houseId, cb)
    lib.callback("housing:collectIkeaFurnitureOrders", false, cb, houseId)
end

local internal = {}

function internal.clearEntity()
    if state.entity and DoesEntityExist(state.entity) then
        DeleteEntity(state.entity)
    end
    if state.ped and DoesEntityExist(state.ped) then
        DeleteEntity(state.ped)
    end
    state.entity = nil
    state.ped = nil
    state.house = nil
    state.coords = nil
    state.readyCount = 0
    state.collecting = false
end


function internal.spawnOrUpdate(houseId, point, readyCount)
    local boxModel = Config.IkeaDeliveryBoxModel or "v_ind_meatboxsml_02"
    local pedModel = Config.IkeaDeliveryPedModel or "s_m_m_dockwork_01"
    local pedAnim = Config.IkeaDeliveryPedAnim or { dict = "anim@heists@box_carry@", name = "idle" }
    local attachConfig = Config.IkeaDeliveryPedAttach or {}

    local spawnPos = vec3(point.x, point.y, point.z)
    local heading = point.w or 0.0

    -- Check if already spawned at same location
    if state.entity and DoesEntityExist(state.entity) then
        if state.ped and DoesEntityExist(state.ped) then
            if state.house == houseId and state.coords then
                if #(state.coords - spawnPos) < 0.05 then
                    state.readyCount = readyCount
                    return
                end
            end
            internal.clearEntity()
        end
    end

    local boxHash = joaat(boxModel)
    local pedHash = joaat(pedModel)
    lib.requestModel(boxHash, Config.DefaultRequestModelTimeout)
    lib.requestModel(pedHash, Config.DefaultRequestModelTimeout)


    local ped = CreatePed(4, pedHash, spawnPos.x, spawnPos.y, spawnPos.z - 1.0, heading, false, false)
    SetEntityAsMissionEntity(ped, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetPedCanRagdoll(ped, false)
    SetEntityHeading(ped, heading)

    if pedAnim.dict and pedAnim.name then
        lib.requestAnimDict(pedAnim.dict)
        TaskPlayAnim(ped, pedAnim.dict, pedAnim.name, 8.0, -8.0, -1, 1, 0, false, false, false)
    end

    local box = CreateObject(boxHash, spawnPos.x, spawnPos.y, spawnPos.z, false, false, false)
    SetEntityAsMissionEntity(box, true, true)
    SetEntityInvincible(box, true)
    SetEntityCompletelyDisableCollision(box, true, false)

    local boneId = tonumber(attachConfig.bone) or 18905
    local attachPos = attachConfig.pos or vec3(0.11, -0.02, -0.02)
    local attachRot = attachConfig.rot or vec3(-35.0, 0.0, 20.0)


    AttachEntityToEntity(box, ped, GetPedBoneIndex(ped, boneId),
        attachPos.x or 0.11, attachPos.y or -0.02, attachPos.z or -0.02,
        attachRot.x or -35.0, attachRot.y or 0.0, attachRot.z or 20.0,
        false, false, false, false, 2, true)

    SetModelAsNoLongerNeeded(boxHash)
    SetModelAsNoLongerNeeded(pedHash)

    state.entity = box
    state.ped = ped
    state.house = houseId
    state.coords = spawnPos
    state.readyCount = readyCount
end

function ikeaDelivery.sync(houseId)
    if false == Config.IkeaDeliveryEnabled then
        internal.clearEntity()
        return
    end

    local house = houseId or CurrentHouse
    if not house or not CurrentHouseData.haskey then
        internal.clearEntity()
        return
    end


    local deliveryState = serverCallbacks.getState(house)

    local hasActiveDelivery = deliveryState and deliveryState.enabled and deliveryState.hasPoint
        and (deliveryState.readyCount or 0) > 0 and deliveryState.point

    if not hasActiveDelivery then
        if deliveryState and deliveryState.enabled and false == deliveryState.hasPoint then
            local count = deliveryState.readyCount or 0
            if count > 0 then
                Notification(i18n.t("delivery.ikea_point_missing"), "info")
            end
        end

        internal.clearEntity()
        return
    end

    local spawnDist = getPedStreamingDistances("ikeaDelivery", 55.0, 65.0)
    local playerCoords = GetEntityCoords(cache.ped)
    local pointVec = vec3(deliveryState.point.x, deliveryState.point.y, deliveryState.point.z)
    local dist = #(playerCoords - pointVec)

    if spawnDist < dist then
        if state.entity or state.ped then
            internal.clearEntity()
        end
        return
    end

    internal.spawnOrUpdate(house, deliveryState.point, deliveryState.readyCount)
end


local events = {}

function events.onReady(houseId, count, hasPoint)
    if false == Config.IkeaDeliveryEnabled then return end
    if CurrentHouse ~= houseId then return end

    if hasPoint then
        local readyCount = count or 0
        if readyCount > 0 then
            ikeaDelivery.sync(houseId)
            return
        end
    end

    internal.clearEntity()
end

function events.onCollected(houseId)
    if not houseId or CurrentHouse ~= houseId then return end
    internal.clearEntity()
end

function events.onLocationRefresh(houseId, _, locationType)
    if 8 ~= locationType then return end
    if not houseId or CurrentHouse ~= houseId then return end

    CreateThread(function()
        Wait(200)
        ikeaDelivery.sync(houseId)
    end)
end

RegisterNetEvent("housing:ikeaDeliveryReady", events.onReady)
RegisterNetEvent("housing:ikeaDeliveryCollected", events.onCollected)
RegisterNetEvent("qb-houses:client:refreshLocations", events.onLocationRefresh)


AddEventHandler("housing:onEnterHouse", function(houseId)
    ikeaDelivery.sync(houseId)
end)

AddEventHandler("housing:onExitHouse", function()
    internal.clearEntity()
end)

AddEventHandler("housing:handleEnterZone", function(houseId)
    ikeaDelivery.sync(houseId)
end)

AddEventHandler("housing:handleExitZone", function()
    internal.clearEntity()
end)

CreateThread(function()
    local lastSyncTime = 0

    while true do
        local sleepTime = 1000

        -- If entities don't exist, periodically try to sync
        if not (state.entity and state.ped and DoesEntityExist(state.entity) and DoesEntityExist(state.ped)) then
            if CurrentHouse and CurrentHouseData.haskey then
                local now = GetGameTimer()
                if now - lastSyncTime >= 3000 then
                    ikeaDelivery.sync(CurrentHouse)
                    lastSyncTime = now
                end
            end
        end


        -- Handle interaction when entities exist
        if state.entity and DoesEntityExist(state.entity) and state.ped and DoesEntityExist(state.ped) and state.coords and CurrentHouse == state.house then
            local pedAnim = Config.IkeaDeliveryPedAnim or { dict = "anim@heists@box_carry@", name = "idle" }
            local playerCoords = GetEntityCoords(cache.ped)
            local dist = #(playerCoords - state.coords)
            local _, despawnDist = getPedStreamingDistances("ikeaDelivery", 55.0, 65.0)

            if dist >= despawnDist then
                internal.clearEntity()
            else
                -- Ensure animation is playing
                if pedAnim.dict and pedAnim.name then
                    if not IsEntityPlayingAnim(state.ped, pedAnim.dict, pedAnim.name, 3) then
                        lib.requestAnimDict(pedAnim.dict)
                        TaskPlayAnim(state.ped, pedAnim.dict, pedAnim.name, 8.0, -8.0, -1, 1, 0, false, false, false)
                    end
                end

                if dist < 2.0 then
                    sleepTime = 0
                    DrawText3D(state.coords.x, state.coords.y, state.coords.z + 0.35,
                        i18n.t("drawtext.collect_ikea_delivery"), "collect_ikea_delivery", "E")

                    if IsControlJustPressed(0, Keys.E) then
                        if not state.collecting then
                            state.collecting = true
                            local house = CurrentHouse
                            if not house then
                                state.collecting = false
                            else
                                serverCallbacks.collect(house, function(success)
                                    if success then
                                        Notification(i18n.t("delivery.collected"), "success")
                                        internal.clearEntity()
                                    else
                                        Notification(i18n.t("delivery.no_delivered_orders"), "info")
                                    end
                                    state.collecting = false
                                end)
                            end
                        end
                    end
                end
            end
        end

        Wait(sleepTime)
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    internal.clearEntity()
end)
