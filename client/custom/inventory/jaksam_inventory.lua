





if Config.Inventory ~= 'jaksam_inventory' then
    return
end

function ToggleInventoryClothing(state)
end

function openStash(customData, uniq)
    local data = customData or Config.DefaultStashData
    local house = CurrentHouse
    local houseData = Config.Houses[house]

    if not customData then
        if houseData.ipl then
            data = houseData.ipl.stash or data
        else
            local shellData = Config.Shells[houseData.tier]
            if shellData then
                data = shellData.stash or data
            end
        end
    end

    uniq = uniq or house
    uniq = uniq:gsub('-', '_')

    local maxweight = data.maxweight or 10000
    local slots     = data.slots or 30 

    local opened = exports['ox_inventory']:openInventory('stash', uniq)

    if not opened then
        TriggerServerEvent('qb-houses:server:RegisterStash', uniq, slots, maxweight)

        exports['ox_inventory']:openInventory('stash', uniq)
        
        Debug('Ox Stash', 'Registering new stash & opening', uniq)
    end
end

exports('lockpick', function()
    local jobCount = TriggerServerCallbackSync('housing:checkTotalJobCount')
    
    if jobCount < Config.RequiredCop then
        Notification(i18n.t('not_enough_police'), 'error')
        return
    end
    
    TriggerEvent('qb-houses:client:lockpick')
end)






