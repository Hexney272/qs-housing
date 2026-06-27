





if Config.Dispatch ~= 'default' then return end

---@param houseName? string
function AlarmDispatch(houseName)
    local house = houseName or CurrentHouse
    if not house then return end
    local playerCoords = GetEntityCoords(cache.ped)
    local streetName = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    local street = GetStreetNameFromHashKey(streetName)
    local text = 'Alarm triggered in ' .. house .. ' house. Alarm Type: House Alarm Street: ' .. street
    local blipText = 'House Alarm Triggered'
    TriggerServerEvent('housing:alarmDispatch', text, blipText)
    print('Alarm Dispatched', text)
end

RegisterNetEvent('housing:alarmDispatch', function(text, blipText)
    if not table.includes(Config.PoliceJobs, GetJobName()) then return end
    local blip = Utils.CreateBlip({
        location = GetEntityCoords(cache.ped),
        sprite = 4,
        color = 1,
        scale = 1.5,
        display = 4,
        shortRange = false,
        highDetail = true,
        text = blipText
    })
    Notification(text, 'info')
    SetTimeout(10000, function()
        Utils.RemoveBlip(blip)
    end)
end)

function SensorDispatch()
    local house = CurrentHouse
    local playerCoords = GetEntityCoords(cache.ped)
    local streetName = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    local street = GetStreetNameFromHashKey(streetName)
    Debug('Sensor Dispatch', street)
    local text = 'Sensor activated in ' .. house .. ' house. Sensor Type: Motion Sensor Street: ' .. street
    local blipText = 'Motion Sensor Activated'
    TriggerServerEvent('housing:sensorDispatch', text, blipText)
end






