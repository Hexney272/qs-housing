





if Config.Inventory ~= 'core_inventory' then
    return
end

function SetItemMetaData(src, slot, meta)
    local PlayerIdentifier = GetIdentifier(src) -- assuming you have a function that return player idetifier from src
    exports.core_inventory:updateMetadata('content-' .. PlayerIdentifier:gsub(':', ''), meta.id, meta)
end






