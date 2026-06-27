





if Config.Inventory ~= 'qb-inventory' then
    return
end

function SetItemMetaData(src, slot, meta)
    local player = GetPlayerFromId(src)
    local items = GetItems(player)
    if not items then return end
    for k, v in pairs(items) do
        if v.slot == slot then
            v.info = meta
            break
        end
    end
    player.Functions.SetInventory(items)
end






