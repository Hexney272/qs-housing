





RegisterNetEvent('qb-houses:server:RegisterStash', function(id, slots, weight)
    if not id or not slots or not weight then return end
    
    exports['jaksam_inventory']:RegisterStashOX(id, slots, weight)
    -- exports['jaksam_inventory']:RegisterStashOX(id, ('Casa %s'):format(id), slots, weight)
end)






