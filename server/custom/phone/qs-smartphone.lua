





if Config.Phone ~= 'qs-smartphone' then
    return
end

function GetPlayerPhone(source)
    local player = GetPlayerFromId(source)
    if Config.Framework == 'qb' then
        return player.PlayerData.charinfo.phone
    end
    return exports['qs-smartphone']:GetCurrentPhoneNumber(source)
end






