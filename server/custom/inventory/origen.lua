





if Config.Inventory ~= 'origen_inventory' then
    return
end

function SetItemMetaData(src, slot, meta)
    exports['origen_inventory']:setMetadata(src, slot, meta)
end






