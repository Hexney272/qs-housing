





if Config.Inventory ~= 'ox_inventory' then
    return
end

OxInventory = exports['ox_inventory']

function SetItemMetaData(src, slot, meta)
    OxInventory:SetMetadata(src, slot, meta)
end

exports('useHouseKey', function(event, item, inventory, slot, data)
    if event == 'usingItem' then
        local itemSlot = exports.ox_inventory:GetSlot(inventory.id, slot)
        if itemSlot then
            local meta = itemSlot.metadata or {}

            -- Check if this is a valid meta key
            if not meta.houseId then
                Notification(inventory.id, i18n.t('metakey.invalid_key'), 'error')
                return
            end

            UseMetaKey(inventory.id, itemSlot)
        end
    end
end)






