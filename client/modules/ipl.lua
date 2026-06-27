CreatorStartedPosition = nil

function showCaseOfIplHouse(index)
    local currentIndex = index or 1

    local iplData = Config.IplData[currentIndex]
    local iplExport = iplData and iplData.export

    if iplData.defaultTheme then
        local interior = iplExport()
        iplExport = interior
        interior.Style.Set(interior.Style.Theme[iplData.defaultTheme], true)
    end

    DoScreenFadeOut(300)

    local ped = cache.ped
    Wait(500)

    local iplCoords = Config.IplData[currentIndex].iplCoords
    if not iplCoords then
        return
    end

    Wait(300)
    SetEntityVisible(ped, false)
    SetEntityCoords(ped, vec3(iplCoords.x, iplCoords.y, iplCoords.z + 1.0))
    ClearFocus()

    local rotation = vector3(0.0, 0.0, 0.0)
    local camera = Utils.CreateCamera("DEFAULT_SCRIPTED_CAMERA", vec3(iplCoords.x, iplCoords.y, iplCoords.z + 1.0), rotation, true, false)

    DoScreenFadeIn(200)

    local function exitShowcase()
        DoScreenFadeOut(300)
        Wait(500)
        SetEntityCoords(ped, CreatorStartedPosition)
        SetEntityVisible(ped, true)
        EnableAllControlActions(0)
        Utils.DestroyFlyCam(camera)
        Wait(1000)
        DoScreenFadeIn(300)
        return currentIndex
    end

    local controls = Utils.GetControls({"rightApt", "done", "cancel", "leftApt"})
    local instructional = Utils.CreateInstructional(controls)

    local nextIndex = currentIndex + 1
    if nextIndex > #Config.IplData then
        nextIndex = 1
    end

    local prevIndex = currentIndex - 1
    if prevIndex < 1 then
        prevIndex = #Config.IplData
    end

    EnabledMouseMovement = true

    while camera do
        Utils.HandleFlyCam(camera, { mouse = true, keyboard = false })

        if IsDisabledControlJustPressed(0, ActionControls.done.codes[1]) then
            return exitShowcase()
        end

        if IsDisabledControlPressed(0, ActionControls.cancel.codes[1]) or IsDisabledControlJustPressed(0, 322) then
            DoScreenFadeOut(300)
            Wait(1000)
            Utils.DestroyFlyCam(camera)
            SetEntityCoords(ped, CreatorStartedPosition)
            SetEntityVisible(ped, true)
            Wait(500)
            DoScreenFadeIn(300)
            return nil
        end

        if IsDisabledControlPressed(0, Keys.LEFT) then
            DoScreenFadeOut(300)
            Wait(500)
            Utils.DestroyFlyCam(camera)
            return showCaseOfIplHouse(prevIndex)
        end

        if IsDisabledControlPressed(0, Keys.RIGHT) then
            DoScreenFadeOut(300)
            Wait(500)
            Utils.DestroyFlyCam(camera)
            return showCaseOfIplHouse(nextIndex)
        end

        Utils.DrawScaleform(instructional)
        Wait(0)
    end
end

RegisterNetEvent("qb-houses:UpdateTheme", function(theme, houseId)
    DoScreenFadeOut(300)
    Wait(500)

    local houseConfig = Config.Houses[houseId]
    local ipl = houseConfig.ipl
    local iplData = Config.IplData[ipl.houseName]
    local iplExport = iplData and iplData.export

    if iplExport then
        local interior = iplExport()
        interior.Style.Set(theme, true)
    end

    SetEntityCoords(cache.ped, GetEntityCoords(cache.ped))
    Wait(1000)
    DoScreenFadeIn(400)
end)

function LeaveIplHouse(houseId, fromShowHouse)
    if FrontCam then
        return
    end

    if not Config.DisableInteractSound then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    end

    DoorAnim()
    Wait(250)
    DoScreenFadeOut(250)
    Wait(500)

    if fromShowHouse then
        inOwned = false
        ShowingHouse = false
    end

    TriggerServerEvent("qb-houses:leaveIplHouse", EnteredHouse)
    Wait(250)

    if Target then
        Target:destroyExit()
    end

    DoScreenFadeIn(250)

    local enterCoords = Config.Houses[EnteredHouse].coords.enter
    SetEntityCoords(cache.ped, enterCoords.x, enterCoords.y, enterCoords.z + 0.2)
    SetEntityHeading(cache.ped, Config.Houses[EnteredHouse].coords.enter.h)

    TriggerServerEvent("housing:routePlayerToDefault", houseId)
    TriggerServerEvent("housing:setInside", houseId, false)
    TriggerEvent("housing:onExitHouse", houseId)

    EnteredHouse = nil
    Invited = false

    TriggerServerEvent("qs-housing:disableAntiTeleport")
    SetArtificialLightsState(false)
end

function EnterIplHouse(houseId, isOwned)
    local houseConfig = Config.Houses[houseId]
    if not houseConfig then
        print("House not found")
        return
    end

    local ipl = houseConfig.ipl
    EnteredHouse = houseId

    if not CurrentHouse then
        Debug("enterIplHouse ::: Forcing to set current house")
        HandleEnterPoly(houseId)
    end

    if not Config.DisableInteractSound then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    end

    TriggerServerEvent("qs-housing:enableAntiTeleport")
    DoorAnim()
    DoScreenFadeOut(250)
    Wait(400)

    decorate:getObjects(houseId)

    local hasKey = CurrentHouseData.haskey
    local notInvited = not Invited and hasKey
    local hasSensor = table.includes(houseConfig.upgrades, "sensor")

    if hasSensor and notInvited then
        SensorDispatch()
    end

    local iplData = Config.IplData[ipl.houseName]
    local iplExport = iplData and iplData.export

    if iplExport then
        local interior = iplExport()
        interior.Style.Set(ipl.theme, true)
    end

    if Target then
        Target:initExit()
    end

    TriggerServerEvent("qb-houses:enterIplHouse", houseId)
    Wait(100)

    EnteringHouse = true
    lib.callback.await("housing:routePlayer", false, houseId)

    TriggerServerEvent("housing:setInside", houseId, true)
    Wait(100)
    EnteringHouse = false

    if isOwned then
        inOwned = true
    end

    SetEntityCoords(cache.ped, ipl.exit.x, ipl.exit.y, ipl.exit.z)
    DoScreenFadeIn(500)
    Wait(100)

    decorate:getObjects(houseId)
    InitHouseInteractions(houseId)
    TriggerEvent("qb-weed:client:getHousePlants", houseId)

    if CurrentHouseData.billsCutOff or not CurrentHouseData.lightsOn then
        SetArtificialLightsState(true)
        SetArtificialLightsStateAffectsVehicles(false)
    end

    TriggerEvent("housing:onEnterHouse", houseId)

    CreateThread(function()
        local zoneConfig = Config.IplData[ipl.houseName].zone
        if not zoneConfig then
            return
        end

        local zone = lib.zones.poly({
            name = "ipl_zone_" .. houseId,
            points = zoneConfig.points,
            thickness = 600.0,
            debug = Config.ZonesDebug,
            onExit = function(self)
                SetEntityCoords(cache.ped, ipl.exit.x, ipl.exit.y, ipl.exit.z)
                Notification(i18n.t("do_not_leave_the_zone"), "error")
                Wait(100)
            end
        })

        while EnteredHouse == houseId do
            Wait(0)
        end

        zone:remove()
    end)
end
