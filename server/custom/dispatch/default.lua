





if Config.Dispatch ~= 'default' then return end

RegisterNetEvent('housing:alarmDispatch', function(text, blipText)
    local src = source
    TriggerClientEvent('housing:alarmDispatch', -1, text, blipText)
end)






