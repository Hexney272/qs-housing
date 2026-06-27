_G.management = {}

local managementBlocker = nil

RegisterNUICallback("fast-action", function(data, cb)
    local action = data.action
    Debug("fast-action", action)

    if "decorate" == action then
        if CurrentApartment then
            Notification(i18n.t("creator.polyzone_nearby"), "error")
            return cb("error")
        end
        TriggerEvent("housing:decorate:open")
    elseif "wardrobe" == action then
        if CurrentApartment then
            Notification(i18n.t("creator.polyzone_nearby"), "error")
            return cb("error")
        end
        SetLocation("wardrobe")
    elseif "charge" == action then
        if CurrentApartment then
            Notification(i18n.t("creator.polyzone_nearby"), "error")
            return cb("error")
        end

        local phoneState = GetResourceState("qs-smartphone")
        if "started" ~= phoneState then
            local proState = GetResourceState("qs-smartphone-pro")
            if "started" ~= proState then
                Notification(i18n.t("management.missing_best_phone"), "error")
                return cb("error")
            end
        end
        SetLocation("charge")
    elseif "storage" == action then
        if CurrentApartment then
            Notification(i18n.t("creator.polyzone_nearby"), "error")
            return cb("error")
        end
        SetLocation("stash")
    elseif "delivery" == action then
        if CurrentApartment then
            Notification(i18n.t("creator.polyzone_nearby"), "error")
            return cb("error")
        end

        creator:spawnTempEntities()
        local points = creator:selectPoint("ped", 1, {
            model = Config.IkeaDeliveryPedModel,
            ped = {
                anim = Config.IkeaDeliveryPedAnim,
                attachObject = {
                    model = Config.IkeaDeliveryBoxModel,
                    bone = Config.IkeaDeliveryPedAttach.bone,
                    pos = Config.IkeaDeliveryPedAttach.pos,
                    rot = Config.IkeaDeliveryPedAttach.rot,
                },
            },
            externalUsage = true,
        })
        creator:destroyTempEntities()


        if not points or not points[1] then
            Notification(i18n.t("quick_menu.delivery_point_cancelled"), "info")
            return cb("ok")
        end

        local point = points[1]
        local coords = {
            x = point.x,
            y = point.y,
            z = point.z,
            w = point.w or 0.0,
        }

        TriggerServerEvent("qb-houses:server:setLocation", coords, CurrentHouse, 8)
        Notification(i18n.t("quick_menu.delivery_point_saved"), "success")
    elseif "fix-door" == action then
        TriggerEvent("qb-houses:client:ResetHouse")
    elseif "toggle-door" == action then
        TriggerEvent("qb-houses:client:toggleDoorlock")
    elseif "rent" == action then
        TriggerServerEvent("housing:lease", CurrentHouse, tonumber(data.price), {
            photos = data.photos or {},
            description = data.description or "",
            furnished = false ~= data.furnished,
            hideFromBrowser = data.hideFromBrowser or false,
        })
    elseif "cancel-rent" == action then
        TriggerServerEvent("qb-houses:disspossesHouse", CurrentHouse)
    elseif "sell-bank" == action then
        if CurrentHouseData.billsCutOff then
            Notification(i18n.t("pay_your_bills"), "error")
            return cb("error")
        end
        TriggerServerEvent("qb-houses:sellHouse", CurrentHouse)

    elseif "sell-player" == action then
        if CurrentHouseData.billsCutOff then
            Notification(i18n.t("pay_your_bills"), "error")
            return cb("error")
        end
        TriggerServerEvent("qb-houses:sellHouseToPlayer", CurrentHouse, tonumber(data.price), {
            photos = data.photos or {},
            description = data.description or "",
            furnished = false ~= data.furnished,
            hideFromBrowser = data.hideFromBrowser or false,
        })
    elseif "leave" == action then
        if CurrentHouseData.billsCutOff then
            Notification(i18n.t("pay_your_bills"), "error")
            return cb("error")
        end
        TriggerServerEvent("qb-houses:leftHouse", CurrentHouse)
    elseif "cancel-sell-house" == action then
        TriggerServerEvent("qb-houses:cancelSellHouse", CurrentHouse)
    end

    cb("ok")
end)

_G.sellHousePhoto = {}
sellHousePhoto.active = false
sellHousePhoto.isInside = false
sellHousePhoto.initialPlayerCoords = nil
sellHousePhoto.spawnedShell = nil
sellHousePhoto.wasInsideBeforePhoto = false


local function teleportToShellInterior(houseConfig, cameraState)
    local shellCoords = houseConfig.coords.shellCoords
    local exitCoords = houseConfig.coords.exit
    local tier = houseConfig.tier
    local shellConfig = Config.Shells[tier]

    if not shellConfig or not exitCoords then
        return false
    end

    if not sellHousePhoto.wasInsideBeforePhoto then
        lib.requestModel(shellConfig.model, Config.DefaultRequestModelTimeout)
        local shell = CreateObject(joaat(shellConfig.model), shellCoords.x, shellCoords.y, shellCoords.z, false, false, false)
        SetEntityHeading(shell, shellCoords.h or 0.0)
        FreezeEntityPosition(shell, true)
        SetModelAsNoLongerNeeded(shellConfig.model)
        sellHousePhoto.spawnedShell = shell
    end

    local targetPos = vec3(exitCoords.x, exitCoords.y, exitCoords.z)
    SetEntityCoords(cache.ped, targetPos.x, targetPos.y, targetPos.z, false, false, false, false)
    SetEntityHeading(cache.ped, exitCoords.w or exitCoords.h or 0.0)

    if cameraState and cameraState.camera then
        local _, _, fwd, _ = GetEntityMatrix(cache.ped)
        local camPos = targetPos + fwd * 2.0
        cameraState.camPos = camPos
        SetCamCoord(cameraState.camera, camPos.x, camPos.y, camPos.z)
    end

    sellHousePhoto.isInside = true
    return true
end


local function returnFromShellInterior(cameraState)
    local savedCoords = sellHousePhoto.initialPlayerCoords
    if savedCoords then
        SetEntityCoords(cache.ped, savedCoords.x, savedCoords.y, savedCoords.z, false, false, false, false)
        if cameraState and cameraState.camera then
            local _, _, fwd, _ = GetEntityMatrix(cache.ped)
            local camPos = savedCoords + fwd * 2
            cameraState.camPos = camPos
            SetCamCoord(cameraState.camera, camPos.x, camPos.y, camPos.z)
        end
    end
    sellHousePhoto.isInside = false
end

local function teleportToIplInterior(houseConfig, cameraState)
    local ipl = houseConfig.ipl
    if not ipl or not ipl.exit then
        return false
    end

    local iplData = Config.IplData[ipl.houseName]
    if iplData and iplData.export then
        local exportResult = iplData.export()
        if exportResult and exportResult.Style and ipl.theme then
            exportResult.Style.Set(ipl.theme, true)
        end
    end

    local targetPos = vec3(ipl.exit.x, ipl.exit.y, ipl.exit.z)
    SetEntityCoords(cache.ped, targetPos.x, targetPos.y, targetPos.z, false, false, false, false)

    if cameraState and cameraState.camera then
        local _, _, fwd, _ = GetEntityMatrix(cache.ped)
        local camPos = targetPos + fwd * 2.0
        cameraState.camPos = camPos
        SetCamCoord(cameraState.camera, camPos.x, camPos.y, camPos.z)
    end

    sellHousePhoto.isInside = true
    return true
end


local function returnFromIplInterior(cameraState)
    local savedCoords = sellHousePhoto.initialPlayerCoords
    if savedCoords then
        SetEntityCoords(cache.ped, savedCoords.x, savedCoords.y, savedCoords.z, false, false, false, false)
        if cameraState and cameraState.camera then
            local _, _, fwd, _ = GetEntityMatrix(cache.ped)
            local camPos = savedCoords + fwd * 2
            cameraState.camPos = camPos
            SetCamCoord(cameraState.camera, camPos.x, camPos.y, camPos.z)
        end
    end
    sellHousePhoto.isInside = false
end

local function cleanupPhotoMode()
    if sellHousePhoto.isInside and sellHousePhoto.initialPlayerCoords then
        local coords = sellHousePhoto.initialPlayerCoords
        SetEntityCoords(cache.ped, coords.x, coords.y, coords.z, false, false, false, false)
    end

    if sellHousePhoto.spawnedShell then
        if DoesEntityExist(sellHousePhoto.spawnedShell) then
            DeleteObject(sellHousePhoto.spawnedShell)
            sellHousePhoto.spawnedShell = nil
        end
    end

    DisplayRadar(true)
    SendReactMessage("toggle_photo_mode", { visible = false })
    sellHousePhoto.active = false
    sellHousePhoto.isInside = false
    sellHousePhoto.initialPlayerCoords = nil
    sellHousePhoto.wasInsideBeforePhoto = false
end


RegisterNUICallback("sell_house_take_photo", function(data, cb)
    if not CurrentHouse then
        return cb(nil)
    end

    local houseConfig = Config.Houses[CurrentHouse]
    if not houseConfig then
        return cb(nil)
    end

    sellHousePhoto.active = true
    sellHousePhoto.isInside = false
    sellHousePhoto.initialPlayerCoords = GetEntityCoords(cache.ped)
    sellHousePhoto.spawnedShell = nil
    sellHousePhoto.wasInsideBeforePhoto = (EnteredHouse == CurrentHouse)

    -- Determine if house has shell coords
    local hasShellCoords = houseConfig.coords
        and houseConfig.coords.shellCoords
        and houseConfig.coords.exit
        and not houseConfig.mlo
        and not houseConfig.ipl

    local hasIplExit = houseConfig.ipl and houseConfig.ipl.exit
    local canTeleport = hasShellCoords or hasIplExit

    management:close()
    SetNuiFocus(false, false)
    DisplayRadar(false)
    SendReactMessage("toggle_photo_mode", { visible = true })

    local photoUrl = nil

    raycast:freeCamera(function(cam)
        -- Take photo on Enter/mouse click
        if IsDisabledControlJustPressed(0, 191) then
            local presignedUrl = lib.callback.await("housing:getPresignedUrl", false, "image")
            if not presignedUrl then
                Notification(i18n.t("creator.photos.token_not_set"), "error")
                cam:destroy()
                return
            end

            SendReactMessage("toggle_photo_mode", { visible = true, loading = true })


            local p = promise.new()
            exports["screenshot-basic"]:requestScreenshotUpload(presignedUrl, "file", function(response)
                local decoded = json.decode(response)
                if not decoded or not decoded.data then
                    p:resolve(nil)
                    Notification(i18n.t("creator.photos.upload_failed"), "error")
                    return
                end
                p:resolve(decoded.data.url)
                photoUrl = decoded.data.url
            end)
            Citizen.Await(p)
            cam:destroy()
        end

        -- Toggle interior/exterior with F key
        if canTeleport then
            if IsDisabledControlJustPressed(0, 23) then
                if not sellHousePhoto.isInside then
                    if hasShellCoords then
                        teleportToShellInterior(houseConfig, cam)
                    elseif hasIplExit then
                        teleportToIplInterior(houseConfig, cam)
                    end
                else
                    if hasShellCoords then
                        returnFromShellInterior(cam)
                    elseif hasIplExit then
                        returnFromIplInterior(cam)
                    end
                end
            end
        end

        -- Cancel with Escape/Backspace
        if IsDisabledControlJustPressed(0, 322) then
            cam:destroy()
        end
    end, nil, { line = false, scaleform = false })

    cleanupPhotoMode()
    Wait(100)


    local mgmtData = lib.callback.await("housing:getManagementData", false, CurrentHouse)
    if mgmtData then
        mgmtData.openSellHouseModal = true
        management:open(mgmtData)
    end

    cb(photoUrl)
end)

local locationEventMap = {}
locationEventMap.wardrobe = "setoutfit"
locationEventMap.stash = "setstash"
locationEventMap.charge = "setCharge"
locationEventMap.tablet = "setTablet"

local setLocationText = i18n.t("drawtext.set_location")

function SetLocation(locationType, skipDrawText)
    CreateThread(function()
        -- Wait for any management blocker to clear
        while managementBlocker do
            Wait(0)
        end

        if skipDrawText then
            TriggerEvent("qb-houses:client:setLocation", { id = locationEventMap[locationType] })
            return
        end

        while true do
            if not CurrentHouse then break end
            if managementBlocker then break end

            Wait(0)
            GetEntityCoords(cache.ped)
            DrawGenericText(setLocationText)

            if IsControlJustPressed(0, 47) then
                TriggerEvent("qb-houses:client:setLocation", { id = locationEventMap[locationType] })
                break
            end
        end
    end)
end


local function hasCameraUpgrade()
    if not CurrentHouse then
        return false
    end

    local houseConfig = Config.Houses[CurrentHouse]
    if not houseConfig then
        return false
    end

    return table.includes(houseConfig.upgrades or {}, "camera")
end

local function setTabletLocation()
    if CurrentApartment then
        Notification(i18n.t("creator.polyzone_nearby"), "error")
        return false
    end

    if not hasCameraUpgrade() then
        Notification(i18n.t("management.camera_upgrade_required"), "error")
        return false
    end

    if management and management.visible then
        management:close()
        SetNuiFocus(false, false)
        Wait(100)
    end

    SetLocation("tablet", true)
    return true
end

local cameraItems = Config.Furniture.camera.items


function GetCameras()
    local cameras = {}
    for id, obj in pairs(decorate.objects) do
        local found = table.find(cameraItems, function(item)
            return item.object == obj.modelName
        end)
        if found then
            table.insert(cameras, { id = id })
        end
    end
    return cameras
end

local function getIplThemes(iplConfig)
    local themeName = nil
    local iplData = Config.IplData[iplConfig.houseName]
    if not iplData then
        return nil
    end

    local themes = iplData.themes
    if not themes then
        return nil
    end

    local exportResult = iplData.export()
    for _, theme in pairs(iplData.themes) do
        local themeData = exportResult.Style.Theme[theme.value]
        if themeData.interiorId == iplConfig.theme.interiorId then
            themeName = theme.value
            break
        end
    end

    return iplData.themes, themeName
end


local function getLights()
    local lights = {}
    for id, obj in pairs(decorate.objects) do
        local found = table.find(LIGHT_ITEMS, function(item)
            return item.object == obj.modelName
        end)
        if found then
            local lightData = obj.lightData
            local name = lightData and lightData.name
            if not name then
                name = i18n.t("management.light_name", { id = id })
            end

            local color = lightData and lightData.color
            if not color then
                color = "white"
            end

            local intensity = lightData and lightData.intensity
            if not intensity then
                intensity = Config.DefaultLightIntensity
            end

            local active = lightData and lightData.active
            if nil == active then
                active = true
            end
            if not active and lightData then
                active = lightData.active
            end

            table.insert(lights, {
                id = id,
                name = name,
                color = color,
                intensity = intensity,
                active = active,
            })
        end
    end
    return lights
end


function management.updateUI(self, houseId)
    if not self.visible then return end
    if not self.data then return end
    if houseId and self.house ~= houseId then return end

    if self.data.ipl then
        local themes, currentTheme = getIplThemes(self.data.ipl)
        self.data.currentTheme = currentTheme
        self.data.themes = themes
    end

    local mgmtData = lib.callback.await("housing:getManagementData", false, CurrentHouse)
    local houseConfig = Config.Houses[CurrentHouse]

    self.data.holders = mgmtData.keyholders
    self.data.cameras = GetCameras()
    self.data.rentals = mgmtData.rents
    self.data.bills = mgmtData.bills
    self.data.metaKeys = mgmtData.metaKeys or {}
    self.data.upgrades = self.data.upgrades or {}
    self.data.lights = getLights()
    self.data.isOfficialOwner = CurrentHouseData.isOfficialOwner
    self.data.purchasable = CurrentHouseData.purchasable

    local defaultSound = Config.DoorBellSounds[1].value
    local configuredSound = houseConfig and houseConfig.doorbellSound
    self.data.doorbellSound = (configuredSound and configuredSound ~= "" and configuredSound) or defaultSound

    self.data.assistantZoneMessagesEnabled = not houseConfig
    self.data.deliveriesEnabled = Config.DeliveriesEnabled
    self.data.dancersEnabled = Config.DancersEnabled


    local deliveries
    if Config.DeliveriesEnabled then
        deliveries = common:getDeliveries()
    end
    if not deliveries then
        deliveries = { available = {}, pending = {} }
    end
    self.data.deliveries = deliveries

    local dancers
    if Config.DancersEnabled then
        dancers = common:getDancers()
    end
    if not dancers then
        dancers = { available = {}, pending = {} }
    end
    self.data.dancers = dancers

    self.data.visible = true
    self.data.isMlo = houseConfig.mlo
    self.data.photos = houseConfig.photos or {}
    self.data.description = houseConfig.description or ""
    self.data.defaultPrice = houseConfig.defaultPrice or 0

    SendReactMessage("toggle_management", self.data)
end

function management.open(self, data)
    if self.visible then
        return Debug("management:open ::: management is already visible")
    end

    self.house = CurrentHouse
    local openSellModal = data.openSellHouseModal
    data.openSellHouseModal = nil
    self.data = data
    self.visible = true

    self:updateUI()

    if openSellModal then
        self.data.openSellHouseModal = true
        SendReactMessage("toggle_management", self.data)
        self.data.openSellHouseModal = nil
    end

    SetNuiFocus(true, true)
end


RegisterNUICallback("watch_camera", function(cameraId, cb)
    local obj = decorate.objects[cameraId]
    if not obj then
        Notification(i18n.t("management.camera_not_found"), "error")
        return cb("error")
    end

    local camCoords = {
        x = obj.coords.x,
        y = obj.coords.y,
        z = obj.coords.z,
        h = obj.rotation.z,
    }
    FrontDoorCam(camCoords, obj.inHouse)
    cb("ok")
end)

exports("GetSecurityCameras", GetCameras)

exports("WatchSecurityCamera", function(cameraId)
    local id = tonumber(cameraId)
    if not id then
        return false
    end

    local obj = decorate.objects[id]
    if not obj then
        return false
    end

    local camCoords = {
        x = obj.coords.x,
        y = obj.coords.y,
        z = obj.coords.z,
        h = obj.rotation.z,
    }
    FrontDoorCam(camCoords, obj.inHouse)
    return true
end)


RegisterNUICallback("get_nearby_players", function(data, cb)
    local players = lib.callback.await("housing:getNearbyPlayers", false)
    cb(players)
end)

RegisterNUICallback("give_keys", function(data, cb)
    local success = lib.callback.await("housing:giveKey", false, data, CurrentHouse)
    if success then
        management:updateUI()
    else
        Notification(i18n.t("keyholders.keys_not_given"), "error")
    end
    cb(success)
end)

RegisterNUICallback("give_meta_key", function(data, cb)
    if not Config.EnableMetaKey then
        Notification(i18n.t("no_permission"), "error")
        return cb(false)
    end
    TriggerServerEvent("housing:giveMetaKeyToPlayer", data, CurrentHouse)
    cb("ok")
end)

RegisterNUICallback("transfer_house", function(data, cb)
    if not CurrentHouseData.isOfficialOwner then
        Notification(i18n.t("you_are_not_owner"), "error")
        return cb(false)
    end
    TriggerServerEvent("housing:transferHouse", data, CurrentHouse)
    management:close()
    SetNuiFocus(false, false)
    cb("ok")
end)


RegisterNUICallback("take_keys", function(data, cb)
    local success = lib.callback.await("housing:takeKey", false, CurrentHouse, data)
    if success then
        cb(true)
    else
        Notification(i18n.t("keyholders.keys_not_removed"), "error")
        cb(false)
    end
end)

RegisterNUICallback("buy_theme", function(themeValue, cb)
    local houseConfig = Config.Houses[CurrentHouse]
    local iplConfig = houseConfig.ipl
    local iplData = Config.IplData[iplConfig.houseName]
    local exportResult = iplData.export()

    if not iplData then
        Notification(i18n.t("management.no_themes"), "error")
        return
    end

    local themeData = exportResult.Style.Theme[themeValue]
    local themeEntry = table.find(iplData.themes, function(t)
        return t.value == themeValue
    end)

    if not themeEntry then
        Notification(i18n.t("management.no_themes"), "error")
        return
    end

    TriggerServerCallback("qb-houses:buyDecorationObject", function(success)
        if not success then
            Notification(i18n.t("no_money", { price = themeEntry.price }), "error")
            return
        end
        TriggerServerEvent("qb-houses:UpdateIplTheme", themeData, CurrentHouse)
    end, themeEntry.price)
    cb("ok")
end)


RegisterNUICallback("buy_upgrade", function(upgradeName, cb)
    local upgrade = table.find(Config.Upgrades, function(u)
        return u.name == upgradeName
    end)

    if not upgrade then
        cb(false)
        Notification(i18n.t("upgrade_not_found"), "error")
        return
    end

    TriggerServerCallback("housing:buyUpgrade", function(success)
        if not success then
            cb(false)
            return
        end
        management:updateUI()
        if "camera" == upgradeName then
            setTabletLocation()
        end
        cb("ok")
    end, CurrentHouse, upgradeName)
end)

RegisterNUICallback("set_upgrade_location", function(data, cb)
    local upgrade = data and data.upgrade
    if "camera" ~= upgrade then
        cb(false)
        return
    end
    cb(setTabletLocation())
end)


local lastLightToggleTime = nil

RegisterNUICallback("toggle_light", function(data, cb)
    if lastLightToggleTime then
        local elapsed = GetGameTimer() - lastLightToggleTime
        if elapsed < 1000 then
            Notification(i18n.t("decorate.light_waiting"), "error")
            return cb(false)
        end
    end

    lastLightToggleTime = GetGameTimer()

    local id = data.id
    local status = data.status
    local obj = decorate.objects[id]

    if not obj then
        Notification(i18n.t("decorate.light_not_found"), "error")
        return
    end

    decorate.objects[id].lightData = decorate.objects[id].lightData or {}
    decorate.objects[id].lightData.active = status

    TriggerServerEvent("housing:updateObject", CurrentHouse, decorate.objects[id].id, {
        lightData = json.encode(decorate.objects[id].lightData),
    })
    cb("ok")
end)


RegisterNUICallback("save_light", function(data, cb)
    local id = data.id
    local name = data.name
    local color = data.color
    local intensity = data.intensity
    local rgb = data.rgb

    local obj = decorate.objects[id]
    if not obj then
        Notification(i18n.t("decorate.light_not_found"), "error")
        return
    end

    local existingActive = obj and obj.lightData and obj.lightData.active
    if not existingActive then
        existingActive = true
    end

    decorate.objects[id].lightData = {
        name = name,
        color = color,
        rgb = rgb,
        intensity = intensity,
        active = existingActive,
    }

    TriggerServerEvent("housing:updateObject", CurrentHouse, decorate.objects[id].id, {
        lightData = json.encode(decorate.objects[id].lightData),
    })
    cb("ok")
end)

function management.close(self)
    if not self.visible then return end

    ToggleHud(true)
    self.visible = false
    self.data = nil
    SendReactMessage("toggle_management", { visible = false })
    managementBlocker = nil
    RefreshClosestHouse()
end


RegisterNUICallback("pay_rent", function(data, cb)
    local success = lib.callback.await("housing:payRent", 0, data, CurrentHouse)
    cb("ok")
    if not success then return end
    management:updateUI()
end)

RegisterNUICallback("pay_bill", function(data, cb)
    local success = lib.callback.await("housing:payBill", 0, data, CurrentHouse)
    cb("ok")
    if not success then return end
    management:updateUI()
end)

RegisterNUICallback("pay_all_bills", function(data, cb)
    local success = lib.callback.await("housing:payAllBills", 0, CurrentHouse)
    cb("ok")
    if not success then return end
    management:updateUI()
end)

RegisterNUICallback("update_key_permissions", function(data, cb)
    local permissions = data.permissions
    local houseConfig = Config.Houses[CurrentHouse]
    if not houseConfig then
        Notification(i18n.t("management.no_house_data"), "error")
        return
    end
    houseConfig.permissions = permissions
    TriggerServerEvent("housing:updatePermissions", CurrentHouse, permissions)
    cb("ok")
end)


RegisterNUICallback("update_doorbell_sound", function(data, cb)
    local doorbellSound = data.doorbellSound
    local houseConfig = Config.Houses[CurrentHouse]
    if not houseConfig then
        Notification(i18n.t("management.no_house_data"), "error")
        return
    end

    local hasUpgrade = table.includes(houseConfig.upgrades or {}, "doorbell")
    if not hasUpgrade then
        local msg = i18n.t("management.settings.doorbell.upgrade_required")
            or "You need to purchase the Custom Doorbell upgrade to change the doorbell sound."
        Notification(msg, "error")
        return cb("ok")
    end

    houseConfig.doorbellSound = doorbellSound
    TriggerServerEvent("housing:updateDoorbellSound", CurrentHouse, doorbellSound)
    cb("ok")
end)

RegisterNUICallback("update_assistant_zone_messages", function(data, cb)
    local enabled = data and data.enabled
    local houseConfig = Config.Houses[CurrentHouse]
    if not houseConfig then
        Notification(i18n.t("management.no_house_data"), "error")
        return
    end

    if "boolean" ~= type(enabled) then
        enabled = true
    end

    houseConfig.assistantZoneMessagesEnabled = enabled
    TriggerServerEvent("housing:updateAssistantZoneMessages", CurrentHouse, enabled)
    cb("ok")
end)


RegisterNUICallback("create_meta_key", function(data, cb)
    if not Config.EnableMetaKey then
        Notification(i18n.t("metakey.system_disabled"), "error")
        return cb(false)
    end
    lib.callback.await("housing:createMetaKey", false, CurrentHouse)
    management:updateUI()
    cb("ok")
end)

RegisterNUICallback("delete_meta_key", function(data, cb)
    if not Config.EnableMetaKey then
        Notification(i18n.t("metakey.system_disabled"), "error")
        return cb(false)
    end
    lib.callback.await("housing:deleteMetaKey", false, CurrentHouse, data)
    management:updateUI()
    cb("ok")
end)

RegisterNUICallback("play_house_music", function(data, cb)
    local houseConfig = Config.Houses[CurrentHouse]
    if not houseConfig then
        Notification(i18n.t("management.no_house_data"), "error")
        return
    end

    if not EnteredHouse and not houseConfig.mlo then
        Notification(i18n.t("management.music.not_in_house"), "error")
        return cb("error")
    end

    local url = data.url
    local volume = data.volume or 0.5

    if not url or "" == url then
        TriggerServerEvent("housing:server:houseMusicVolume", CurrentHouse, volume)
        HouseSoundVolume = volume
    else
        TriggerServerEvent("housing:server:houseMusicPlay", CurrentHouse, url, volume)
        HouseSoundPlaying = true
        HouseSoundUrl = url
        HouseSoundVolume = volume
    end
    cb("ok")
end)


RegisterNUICallback("update_house_music_volume", function(data, cb)
    if not EnteredHouse or EnteredHouse ~= CurrentHouse then
        return cb("error")
    end

    local volume = data.volume or 0.5
    TriggerServerEvent("housing:server:houseMusicVolume", CurrentHouse, volume)
    HouseSoundVolume = volume
    cb("ok")
end)

RegisterNUICallback("stop_house_music", function(data, cb)
    local house = EnteredHouse or CurrentHouse
    if house then
        TriggerServerEvent("housing:server:houseMusicStop", house)
    end
    HouseSoundPlaying = false
    HouseSoundUrl = ""
    cb("ok")
end)

RegisterNUICallback("open_quick_menu", function(data, cb)
    management:close()
    SetNuiFocus(false, false)
    Wait(100)
    quickMenu:open()
    cb("ok")
end)
