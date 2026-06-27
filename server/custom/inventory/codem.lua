





if Config.Inventory ~= 'codem-inventory' then
    return
end

function SetItemMetaData(src, slot, meta)
    exports['codem-inventory']:SetItemMetadata(src, slot, meta)
end






