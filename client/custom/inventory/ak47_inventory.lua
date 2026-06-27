





if Config.Inventory ~= 'ak47_inventory' then
    return
end

function ToggleInventoryClothing(state)
end

local ak47_inventory = exports['ak47_inventory']

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

    ak47_inventory:OpenInventory({
        identifier = 'stash:' .. uniq,
        label = 'Housing Stash',
        type = 'stash',
        maxWeight = data.maxweight or 10000,
        slots = data.slots or 30,
    })
end

exports('lockpick', function()
    local jobCount = TriggerServerCallbackSync('housing:checkTotalJobCount')

    if jobCount < Config.RequiredCop then
        Notification(i18n.t('not_enough_police'), 'error')
        return
    end

    TriggerEvent('qb-houses:client:lockpick')
end)






