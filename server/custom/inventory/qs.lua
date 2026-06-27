





if Config.Inventory ~= 'qs-inventory' then
    return
end

function SetItemMetaData(src, slot, meta)
    exports['qs-inventory']:SetItemMetadata(src, slot, meta)
end






