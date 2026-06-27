local alarmCounter = 0
local currentSoundId = nil

local function TriggerAlarm(houseId)
    if not houseId then
        return
    end
    AlarmDispatch(houseId)
    TriggerServerEvent("housing:server:houseAlarmSound", houseId)
end

RegisterNetEvent("housing:client:houseAlarmSound", function(coords, duration, hearRange)
    if not duration then
        duration = Config.HouseAlarmDurationMs
    end
    if not hearRange then
        hearRange = Config.HouseAlarmHearRange
    end

    local playerCoords = GetEntityCoords(cache.ped)
    local distance = #(playerCoords - coords)
    if hearRange < distance then
        return
    end

    if currentSoundId then
        StopSound(currentSoundId)
        ReleaseSoundId(currentSoundId)
        currentSoundId = nil
    end

    alarmCounter = alarmCounter + 1
    local myCounter = alarmCounter
    local soundId = GetSoundId()
    currentSoundId = soundId

    local soundName = Config.HouseAlarmSoundName
    if not soundName then
        soundName = "VEHICLES_HORNS_AMBULANCE_WARNING"
    end

    local maxRange = math.max(1, math.floor(hearRange))

    PlaySoundFromCoord(soundId, soundName, coords.x, coords.y, coords.z, nil, false, maxRange, false)

    CreateThread(function()
        local startTime = GetGameTimer()
        while true do
            local elapsed = GetGameTimer() - startTime
            if not (elapsed < duration) then
                break
            end
            if myCounter ~= alarmCounter then
                if currentSoundId ~= soundId then
                    return
                end
                StopSound(soundId)
                ReleaseSoundId(soundId)
                if currentSoundId == soundId then
                    currentSoundId = nil
                end
                return
            end
            Wait(200)
        end
        if myCounter == alarmCounter then
            StopSound(soundId)
            ReleaseSoundId(soundId)
            if currentSoundId == soundId then
                currentSoundId = nil
            end
        end
    end)
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end
    if currentSoundId then
        StopSound(currentSoundId)
        ReleaseSoundId(currentSoundId)
        currentSoundId = nil
    end
    alarmCounter = alarmCounter + 1
end)

local function HandleRamResult(houseId, success)
    local houseData = Config.Houses[houseId]
    if not houseData then
        return print("houseData not found")
    end

    if table.includes(houseData.upgrades, "alarm") then
        TriggerAlarm(houseId)
    end

    if success then
        if houseData.mlo then
            DoLockpickAnimation(houseId, false)
            local nearbyDoor, doorIndex = table.find(houseData.mlo, function(door)
                local doorPos = vec3(door.coords.x, door.coords.y, door.coords.z)
                local playerCoords = GetEntityCoords(cache.ped)
                local dist = #(playerCoords - doorPos)
                return dist < Config.DoorDistance
            end)
            if not nearbyDoor then
                return Notification(i18n.t("no_doors"), "error")
            end
            TriggerServerEvent("qb-houses:SyncDoor", houseId, { nearbyDoor }, false)
        else
            TriggerServerEvent("qb-houses:server:lockHouse", false, houseId)
        end
        TriggerServerEvent("qb-houses:server:SetHouseRammed", true, houseId)
        DoRamAnimation(false)
        Notification(i18n.t("success_ram"), "success")
    else
        TriggerServerEvent("qb-houses:server:SetRamState", false, houseId)
        DoRamAnimation(false)
        Notification(i18n.t("fail_ram"), "error")
    end
end

local function DoRamSkillCheck(houseId)
    local success = lib.skillCheck(
        { "easy", "easy", { areaSize = 70, speedMultiplier = 1 }, "easy" },
        { "z", "q", "s", "d" }
    )
    HandleRamResult(houseId, success)
end

local function AttemptRamDoor(houseId)
    local playerCoords = GetEntityCoords(cache.ped)

    if not houseId then
        houseId = CurrentHouse
    end
    if not houseId then
        return Notification(i18n.t("house_not_found"), "error")
    end

    local houseData = Config.Houses[houseId]
    if not houseData then
        return print("houseData not found")
    end

    if Config.RequireOwnerOnline then
        local ownerOnline = lib.callback.await("housing:isOwnerOnline", false, houseId)
        if not ownerOnline then
            return Notification(i18n.t("robbery.owner_not_online"), "error")
        end
    end

    if houseData.mlo then
        local nearbyDoor = GetMLONearbyDoor(houseId)
        if not nearbyDoor then
            return Notification(i18n.t("no_doors"), "error")
        end
    else
        local enterPos = vec3(houseData.coords.enter.x, houseData.coords.enter.y, houseData.coords.enter.z)
        local dist = #(playerCoords - enterPos)
        if dist > 1 then
            return Notification(i18n.t("house_not_found"), "error")
        end
    end

    if nil == houseData.IsRaming then
        Config.Houses[houseId].IsRaming = false
    end

    if not houseData.mlo then
        if not houseData.locked then
            Notification(i18n.t("already_open"), "error")
            return
        end
    end

    if not houseData.IsRaming then
        DoRamAnimation(true)
        DoRamSkillCheck(houseId)
        TriggerServerEvent("qb-houses:server:SetRamState", true, houseId)
    else
        Notification(i18n.t("force_door"), "error")
    end
end

RamDoor = AttemptRamDoor

RegisterNetEvent("qb-houses:client:HomeInvasion")
AddEventHandler("qb-houses:client:HomeInvasion", function()
    local houseData = Config.Houses[CurrentHouse]
    if not CurrentHouse then
        return Notification(i18n.t("house_not_found"), "error")
    end
    if not houseData then
        return print("houseData not found")
    end

    if houseData.apartmentNumber then
        OpenApartmentMenu("police")
    else
        RamDoor()
    end
end)

local function HandleLockpickResult(houseId, success)
    if success then
        local houseData = Config.Houses[houseId]
        DoLockpickAnimation(houseId, false)
        if houseData.mlo then
            local nearbyDoor, doorIndex = table.find(houseData.mlo, function(door)
                local doorPos = vec3(door.coords.x, door.coords.y, door.coords.z)
                local playerCoords = GetEntityCoords(cache.ped)
                local dist = #(playerCoords - doorPos)
                return dist < Config.DoorDistance
            end)
            if not nearbyDoor then
                return Notification(i18n.t("no_doors"), "error")
            end
            TriggerServerEvent("qb-houses:SyncDoor", houseId, { nearbyDoor }, false)
        else
            TriggerServerEvent("qb-houses:server:lockHouse", false, houseId)
        end
        TriggerServerEvent("qb-houses:server:SetHouseRammed", true, houseId)
        Notification(i18n.t("success_lockpick"), "success")
    else
        DoLockpickAnimation(houseId, false)
        Notification(i18n.t("fail_struggle"), "error")
    end
end

local function DoLockpickSkillCheck(houseId)
    local success = lib.skillCheck(
        { "easy", "easy", { areaSize = 70, speedMultiplier = 1 }, "easy" },
        { "z", "q", "s", "d" }
    )
    HandleLockpickResult(houseId, success)
end

local function AttemptLockPick(houseId)
    local playerCoords = GetEntityCoords(cache.ped)

    if not houseId then
        houseId = CurrentHouse
    end
    if not houseId then
        return Notification(i18n.t("house_not_found"), "error")
    end

    local houseData = Config.Houses[houseId]
    if not houseData then
        return print("houseData not found")
    end

    if Config.RequireOwnerOnline then
        local ownerOnline = lib.callback.await("housing:isOwnerOnline", false, houseId)
        if not ownerOnline then
            return Notification(i18n.t("robbery.owner_not_online"), "error")
        end
    end

    if houseData.mlo then
        local nearbyDoor = GetMLONearbyDoor(houseId)
        if not nearbyDoor then
            return Notification(i18n.t("no_doors"), "error")
        end
    else
        local enterPos = vec3(houseData.coords.enter.x, houseData.coords.enter.y, houseData.coords.enter.z)
        local dist = #(playerCoords - enterPos)
        if dist > 1 then
            return Notification(i18n.t("house_not_found"), "error")
        end
    end

    if nil == houseData.IsRaming then
        Config.Houses[houseId].IsRaming = false
    end

    if not houseData.mlo then
        if not houseData.locked then
            Notification(i18n.t("already_open"), "error")
            return
        end
    end

    if not houseData.IsRaming then
        TriggerServerEvent("housing:removeItem", Config.RobberyItem, 1)
        DoLockpickAnimation(houseId, true)
        DoLockpickSkillCheck(houseId)
    else
        Notification(i18n.t("force_door"), "error")
    end
end

LockPick = AttemptLockPick

RegisterNetEvent("qb-houses:client:lockpick")
AddEventHandler("qb-houses:client:lockpick", function()
    local houseData = Config.Houses[CurrentHouse]
    if not CurrentHouse then
        return Notification(i18n.t("house_not_found"), "error")
    end
    if not houseData then
        return print("houseData not found")
    end

    if houseData.apartmentNumber then
        OpenApartmentMenu("lockpick")
    else
        LockPick()
    end
end)

RegisterNetEvent("qb-houses:client:SetRamState")
AddEventHandler("qb-houses:client:SetRamState", function(state, houseId)
    Config.Houses[houseId].IsRaming = state
end)

RegisterNetEvent("qb-houses:client:SetHouseRammed")
AddEventHandler("qb-houses:client:SetHouseRammed", function(state, houseId)
    Config.Houses[houseId].IsRammed = state
end)

RegisterNetEvent("qb-houses:client:ResetHouse")
AddEventHandler("qb-houses:client:ResetHouse", function()
    local ped = cache.ped
    if nil ~= CurrentHouse then
        local houseData = Config.Houses[CurrentHouse]
        if nil == houseData.IsRammed then
            Config.Houses[CurrentHouse].IsRammed = false
            TriggerServerEvent("qb-houses:server:SetHouseRammed", false, CurrentHouse)
            TriggerServerEvent("qb-houses:server:SetRamState", false, CurrentHouse)
        end

        if Config.Houses[CurrentHouse].IsRammed then
            DoorAnim()
            TriggerServerEvent("qb-houses:server:SetHouseRammed", false, CurrentHouse)
            TriggerServerEvent("qb-houses:server:SetRamState", false, CurrentHouse)
            TriggerServerEvent("qb-houses:server:lockHouse", true, CurrentHouse)
            RamsDone = 0
            Notification(i18n.t("door_fixed"), "success")
        else
            Notification(i18n.t("door_not_broken"), "error")
        end
    end
end)

function DoLockpickAnimation(houseId, play)
    local ped = cache.ped
    local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
    local animName = "machinic_loop_mechandplayer"

    local houseData = Config.Houses[houseId]
    if not houseData then
        return print("houseData not found")
    end

    if table.includes(houseData.upgrades, "alarm") then
        TriggerAlarm(houseId)
    end

    if play then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(1)
        end
        TaskPlayAnim(ped, animDict, animName, 8.0, 8.0, -1, 1, -1, false, false, false)
    else
        ClearPedTasksImmediately(ped)
    end
end

function GetMLONearbyDoor(houseId)
    local houseData = Config.Houses[houseId]
    if not houseData.mlo then
        return nil
    end

    for doorIndex, door in pairs(houseData.mlo) do
        local playerCoords = GetEntityCoords(cache.ped)
        local doorPos = vec3(door.coords.x, door.coords.y, door.coords.z)
        local dist = #(playerCoords - doorPos)
        if dist < 2.0 then
            if door.locked then
                return doorIndex
            end
        end
    end

    return nil
end
