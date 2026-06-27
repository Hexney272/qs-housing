





RegisterCommand('houseMenu', function()
    -- if IsNuiFocused() then return end -- Disabled because some chat scripts like 0resmonchat stuck here.
    if Config.DisableHouseMenuKeybind then return end
    if decorate.active then return end
    if not CurrentHouse then return end
    local house = Config.Houses[CurrentHouse]
    if house.apartmentNumber and not EnteredHouse then
        OpenMyApartments()
        return
    end
    if not CurrentHouseData.haskey and not CurrentHouseData.isOfficialOwner then return Notification(i18n.t('not_have_keys'), 'error') end
    management:open(house)
end, false)

if not Config.DisableHouseMenuKeybind then
    RegisterKeyMapping('houseMenu', 'House Menu', 'keyboard', Config.OpenHouseMenu)
end

RegisterNetEvent('housing:onExitHouse', function(house)
    if house then
        DestroyHouseSound(house, false)
    end
end)

function DoRamAnimation(bool)
    local ped = cache.ped
    local dict = 'missheistfbi3b_ig7'
    local anim = 'lift_fibagent_loop'

    if bool then
        lib.requestAnimDict(dict)
        TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 1, -1, false, false, false)
        RemoveAnimDict(dict)
    else
        lib.requestAnimDict(dict)
        TaskPlayAnim(ped, dict, 'exit', 8.0, 8.0, -1, 1, -1, false, false, false)
        RemoveAnimDict(dict)
    end
end

HouseSoundPlaying = false
HouseSoundVolume = 0.5
HouseSoundUrl = ''

---@param house string
---@param link string
---@param volume? number
function PlayHouseSound(house, link, volume)
    if not link or link == '' then
        return
    end
    TriggerServerEvent('housing:server:houseMusicPlay', house, link, volume or 0.5)
    HouseSoundPlaying = true
    HouseSoundUrl = link
    HouseSoundVolume = volume or HouseSoundVolume
end

---@param house string
---@param syncServer? boolean If false, only clear local UI state (e.g. when exiting interior).
function DestroyHouseSound(house, syncServer)
    if syncServer == nil then syncServer = true end
    if syncServer and house then
        TriggerServerEvent('housing:server:houseMusicStop', house)
    end
    HouseSoundPlaying = false
    HouseSoundUrl = ''
end

---@param house string
---@param volume number
function UpdateHouseSoundVolume(house, volume)
    HouseSoundVolume = volume or HouseSoundVolume
    TriggerServerEvent('housing:server:houseMusicVolume', house, HouseSoundVolume)
end






