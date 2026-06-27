





if Config.Inventory ~= 'tgiann-inventory' then
    return
end

function SetItemMetaData(src, slot, info)
    local item = exports['tgiann-inventory']:GetItemBySlot(src, slot)
    if not item then return end
    exports['tgiann-inventory']:UpdateItemMetadata(src, item.name, item.slot, info)
end






