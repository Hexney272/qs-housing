





if Config.Inventory ~= 'codem-inventory' then
    return
end

function ToggleInventoryClothing(state)
end

function openStash(customData, uniq)
    local data = customData or Config.DefaultStashData
    local house = CurrentHouse
    local houseData = Config.Houses[house]

    if not customData then
        if houseData and houseData.ipl then
            data = houseData.ipl.stash or data
        else
            local shellData = houseData and Config.Shells[houseData.tier]
            if shellData then
                data = shellData.stash or data
            end
        end
    end

    uniq = uniq or house
    uniq = tostring(uniq or 'house'):gsub('-', '_')
    local name = 'stash_' .. uniq
    local maxweight = data.maxweight or 10000
    local slots = data.slots or 30

    print('[INFO] Open stash CodeM:', name, 'MaxWeight:', maxweight, 'Slots:', slots)
    TriggerServerEvent('codem-inventory:server:openstash', name, slots, maxweight, name)
end






