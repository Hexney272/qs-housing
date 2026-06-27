_G.quickMenu = {}

function quickMenu.open(self)
    if not CurrentHouse then return end

    local houseConfig = Config.Houses[CurrentHouse]
    if not houseConfig then return end

    local hasKey = CurrentHouseData.haskey or false
    local cameras = GetCameras()
    local hasCamera = #cameras > 0

    local deliveredDeliveries = {}
    local deliveryCount = 0
    local hasDeliveries = false

    if Config.DeliveriesEnabled then
        local deliveries = common:getDeliveries()
        for _, delivery in ipairs(deliveries.pending) do
            if "delivered" == delivery.status then
                deliveryCount = deliveryCount + 1
                table.insert(deliveredDeliveries, delivery)
            end
        end
        hasDeliveries = deliveryCount > 0
    end


    local deliveredDancers = {}
    local dancerCount = 0
    local hasDancers = false

    if Config.DancersEnabled then
        local dancers = common:getDancers()
        for _, dancer in ipairs(dancers.pending) do
            if "delivered" == dancer.status then
                dancerCount = dancerCount + 1
                table.insert(deliveredDancers, dancer)
            end
        end
        hasDancers = dancerCount > 0
    end

    local doorbellPlayers = lib.callback.await("housing:getDoorbellPlayers", false, CurrentHouse)
    local lightsOn = lib.callback.await("housing:getLightsStatus", false, CurrentHouse)
    local isMlo = houseConfig.mlo

    SendReactMessage("toggle_quick_menu", {
        visible = true,
        name = CurrentHouse,
        address = houseConfig.address,
        locked = houseConfig.locked or false,
        hasCamera = hasCamera,
        deliveriesEnabled = Config.DeliveriesEnabled,
        dancersEnabled = Config.DancersEnabled,
        hasDeliveries = hasDeliveries,
        deliveryCount = deliveryCount,
        deliveredDeliveries = deliveredDeliveries,
        hasDancers = hasDancers,
        dancerCount = dancerCount,
        deliveredDancers = deliveredDancers,
        doorbellPlayers = doorbellPlayers or {},
        hasKey = hasKey,
        isMlo = isMlo,
        lightsOn = lightsOn or false,
    })
    SetNuiFocus(true, true)
end


function quickMenu.close(self)
    SendReactMessage("toggle_quick_menu", { visible = false })
    SetNuiFocus(false, false)
end

RegisterNUICallback("quick_menu:toggle_lock", function(data, cb)
    TriggerEvent("qb-houses:client:toggleDoorlock")
    cb("ok")
end)

RegisterNUICallback("quick_menu:toggle_lights", function(data, cb)
    if not CurrentHouse then
        return cb(nil)
    end

    lib.callback("housing:toggleLights", false, function(result)
        if nil ~= result then
            CurrentHouseData.lightsOn = result
            quickMenu:open()
        end
        cb(result)
    end, CurrentHouse)
end)

RegisterNUICallback("front_door_camera", function(data, cb)
    local houseConfig = Config.Houses[EnteredHouse]
    if not houseConfig then
        return cb("error")
    end

    local enterCoords = houseConfig.coords.enter
    FrontDoorCam(vec3(enterCoords.x, enterCoords.y, enterCoords.z + 1.0))
    cb("ok")
end)


RegisterNUICallback("quick_menu:deliveries", function(data, cb)
    if not Config.DeliveriesEnabled then
        return cb("ok")
    end

    local deliveries = common:getDeliveries()
    local delivered = {}
    for _, item in ipairs(deliveries.pending) do
        if "delivered" == item.status then
            table.insert(delivered, item)
        end
    end

    if 0 == #delivered then
        Notification(i18n.t("delivery.no_delivered_orders"), "info")
        return cb("ok")
    end

    local hasKey = CurrentHouseData.haskey or false
    local doorbellPlayers = lib.callback.await("housing:getDoorbellPlayers", false, CurrentHouse)
    local houseConfig = Config.Houses[CurrentHouse]

    local dancers = common:getDancers()
    local deliveredDancers = {}
    for _, dancer in ipairs(dancers.pending) do
        if "delivered" == dancer.status then
            table.insert(deliveredDancers, dancer)
        end
    end

    local lightsOn = lib.callback.await("housing:getLightsStatus", false, CurrentHouse)

    SendReactMessage("toggle_quick_menu", {
        visible = true,
        name = CurrentHouse,
        address = houseConfig.address,
        locked = houseConfig.locked or false,
        hasCamera = #GetCameras() > 0,
        deliveriesEnabled = Config.DeliveriesEnabled,
        dancersEnabled = Config.DancersEnabled,
        hasDeliveries = true,
        deliveryCount = #delivered,
        deliveredDeliveries = delivered,
        hasDancers = #deliveredDancers > 0,
        dancerCount = #deliveredDancers,
        deliveredDancers = deliveredDancers,
        doorbellPlayers = doorbellPlayers or {},
        hasKey = hasKey,
        isMlo = houseConfig.mlo,
        lightsOn = lightsOn or false,
    })
    cb("ok")
end)


RegisterNUICallback("quick_menu:collect_delivery", function(data, cb)
    if not Config.DeliveriesEnabled then
        return cb(false)
    end

    lib.callback("housing:collectDelivery", false, function(success)
        if success then
            Notification(i18n.t("delivery.collected"), "success")
            quickMenu:open()
        else
            Notification(i18n.t("no_permission"), "error")
        end
        cb(success)
    end, data)
end)

RegisterNUICallback("quick_menu:leave", function(data, cb)
    local houseConfig = Config.Houses[EnteredHouse]
    quickMenu:close()

    if houseConfig then
        if houseConfig.ipl then
            LeaveIplHouse(EnteredHouse, inOwned)
        else
            LeaveHouse()
        end
    else
        LeaveHouse()
    end
    cb("ok")
end)

RegisterNUICallback("quick_menu:invite_player", function(data, cb)
    if not EnteredHouse then
        return cb("error")
    end
    TriggerServerEvent("qb-houses:server:OpenDoor", data, EnteredHouse)
    cb("ok")
end)


RegisterNUICallback("quick_menu:dancers", function(data, cb)
    if not Config.DancersEnabled then
        return cb("ok")
    end

    local dancers = common:getDancers()
    local delivered = {}
    for _, dancer in ipairs(dancers.pending) do
        if "delivered" == dancer.status then
            table.insert(delivered, dancer)
        end
    end

    if 0 == #delivered then
        Notification(i18n.t("dancers.no_delivered_orders"), "info")
        return cb("ok")
    end

    local hasKey = CurrentHouseData.haskey or false
    local doorbellPlayers = lib.callback.await("housing:getDoorbellPlayers", false, CurrentHouse)
    local houseConfig = Config.Houses[CurrentHouse]

    local deliveries = common:getDeliveries()
    local deliveredDeliveries = {}
    for _, item in ipairs(deliveries.pending) do
        if "delivered" == item.status then
            table.insert(deliveredDeliveries, item)
        end
    end

    local lightsOn = lib.callback.await("housing:getLightsStatus", false, CurrentHouse)

    SendReactMessage("toggle_quick_menu", {
        visible = true,
        name = CurrentHouse,
        address = houseConfig.address,
        locked = houseConfig.locked or false,
        hasCamera = #GetCameras() > 0,
        deliveriesEnabled = Config.DeliveriesEnabled,
        dancersEnabled = Config.DancersEnabled,
        hasDeliveries = #deliveredDeliveries > 0,
        deliveryCount = #deliveredDeliveries,
        deliveredDeliveries = deliveredDeliveries,
        hasDancers = true,
        dancerCount = #delivered,
        deliveredDancers = delivered,
        doorbellPlayers = doorbellPlayers or {},
        hasKey = hasKey,
        isMlo = houseConfig.mlo,
        lightsOn = lightsOn or false,
    })
    cb("ok")
end)


RegisterNUICallback("quick_menu:place_dancer", function(data, cb)
    if not Config.DancersEnabled then
        return cb("error")
    end

    local dancerId = data.dancerId
    if not CurrentHouse then
        return cb("error")
    end

    local dancers = common:getDancers()
    local foundDancer = nil
    for _, dancer in ipairs(dancers.pending) do
        if dancer.id == dancerId and "delivered" == dancer.status then
            foundDancer = dancer
            break
        end
    end

    if not foundDancer then
        Notification(i18n.t("dancers.not_found"), "error")
        return cb("error")
    end

    creator:spawnTempEntities()
    local points = creator:selectPoint("ped", 1, {
        model = foundDancer.pedModel,
        ped = {
            model = foundDancer.pedModel,
            anim = foundDancer.anim,
        },
        externalUsage = true,
    })
    creator:destroyTempEntities()

    if not points or not points[1] then
        Notification(i18n.t("dancers.placement_cancelled"), "info")
        return cb("cancelled")
    end

    local point = points[1]
    local coords = {
        x = point.x,
        y = point.y,
        z = point.z,
        w = point.w or 0.0,
    }

    lib.callback("housing:placeDancer", false, function(success)
        if success then
            Notification(i18n.t("dancers.placed"), "success")
        else
            Notification(i18n.t("dancers.place_failed"), "error")
        end
        cb(success)
    end, dancerId, coords)
end)
