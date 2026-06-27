





if not Config.EnableMetaKey then
    return
end

local PlayerMetaKeyCache = {}
local META_KEY_CACHE_TIME = 5000

---@param source number
---@return table
function GetPlayerMetaKeys(source)
    local player = GetPlayerFromId(source)
    if not player then return {} end

    local items = GetItems(player)
    if not items then return {} end

    local metaKeys = {}
    for _, item in pairs(items) do
        if item.name == Config.MetaKeyItem then
            local meta = item.info or item.metadata or {}
            if meta.houseId then
                table.insert(metaKeys, {
                    houseId = meta.houseId,
                    houseName = meta.houseName or meta.houseId,
                    keyId = meta.keyId,
                    slot = item.slot,
                    givenBy = meta.givenBy,
                    givenAt = meta.givenAt
                })
            end
        end
    end

    return metaKeys
end

---@param house string
---@return MetaKey[]
function GetHouseMetaKeys(house)
    local result = db:getHouseMetaKeys(house)

    if not result or #result == 0 then
        return {}
    end

    local keys = {}
    for _, key in pairs(result) do
        table.insert(keys, {
            id = key.id,
            keyId = key.key_id,
            house = key.house,
            ownerIdentifier = key.owner_identifier,
            createdAt = key.created_at
        })
    end

    return keys
end

---@param source number
---@param house string
---@return boolean
function CheckHasMetaKey(source, house)
    if not Config.EnableMetaKey then return false end
    if not source or not house then return false end

    local cacheKey = source .. ':' .. house
    local cached = PlayerMetaKeyCache[cacheKey]
    if cached and (GetGameTimer() - cached.time) < META_KEY_CACHE_TIME then
        return cached.hasKey
    end

    local metaKeys = GetPlayerMetaKeys(source)
    local hasKey = false

    for _, key in pairs(metaKeys) do
        if key.houseId == house and key.keyId then
            local isValid = db:isMetaKeyValid(key.keyId, house)
            if isValid then
                hasKey = true
                break
            end
        end
    end

    PlayerMetaKeyCache[cacheKey] = {
        hasKey = hasKey,
        time = GetGameTimer()
    }

    Debug('CheckHasMetaKey', 'Source:', source, 'House:', house, 'HasKey:', hasKey)
    return hasKey
end

exports('CheckHasMetaKey', CheckHasMetaKey)

---@param source number
---@param house string
---@param identifier string
---@return string?
function CreateMetaKey(source, house, identifier)
    local houseData = Config.Houses[house]
    if not houseData then
        if source then
            Notification(source, i18n.t('metakey.house_not_found'), 'error')
        end
        return nil
    end

    local keyId = house .. '_' .. os.time() .. '_' .. math.random(1000, 9999)

    db:createMetaKey(house, keyId, identifier)
    Debug('CreateMetaKey', 'Created key with ID:', keyId, 'for house:', house)
    return keyId
end

---@param source number Player server ID
---@param house string House identifier
---@param keyId? string Optional key ID (if not provided, creates new)
---@return boolean Success
function GiveMetaKey(source, house, keyId)
    local houseData = Config.Houses[house]
    if not houseData then
        Notification(source, i18n.t('metakey.house_not_found'), 'error')
        return false
    end

    local identifier = GetIdentifier(source)

    if not keyId then
        local newKeyId = CreateMetaKey(source, house, identifier)
        if not newKeyId or type(newKeyId) ~= 'string' then
            Notification(source, i18n.t('metakey.create_failed'), 'error')
            return false
        end
        keyId = newKeyId -- @type string
    else
        local isValid = db:isMetaKeyValid(keyId, house)
        if not isValid then
            Notification(source, i18n.t('metakey.invalid_key'), 'error')
            return false
        end
    end

    local meta = {
        houseId = house,
        houseName = houseData.address or house,
        keyId = keyId,
        givenBy = identifier,
        givenAt = os.time()
    }

    local success = AddItem(source, Config.MetaKeyItem, 1, nil, meta)
    if success then
        Notification(source, i18n.t('metakey.received', { house = houseData.address or house }), 'success')
        ClearMetaKeyCache(source)
        Debug('GiveMetaKey', 'Source:', source, 'House:', house, 'KeyID:', keyId, 'Success')

        SendLog(DiscordWebhook, {
            title = 'Housing - Meta Key',
            description = 'Player received a meta key',
            fields = {
                { name = 'Player', value = GetPlayerName(source), inline = true },
                { name = 'House',  value = house,                 inline = true },
                { name = 'Key ID', value = keyId,                 inline = true }
            },
            color = WebhookColor
        })
        return true
    else
        Notification(source, i18n.t('metakey.inventory_full'), 'error')
        return false
    end
end

exports('GiveMetaKey', GiveMetaKey)

---@param source number Player server ID
---@param house string House identifier
---@return boolean Success
function RemoveMetaKey(source, house)
    local player = GetPlayerFromId(source)
    if not player then return false end

    local items = GetItems(player)
    if not items then return false end

    for _, item in pairs(items) do
        if item.name == Config.MetaKeyItem then
            local meta = item.info or item.metadata or {}
            if meta.houseId == house then
                RemoveItem(source, Config.MetaKeyItem, 1)
                Notification(source, i18n.t('metakey.removed'), 'info')
                ClearMetaKeyCache(source)
                Debug('RemoveMetaKey', 'Source:', source, 'House:', house, 'Success')
                return true
            end
        end
    end

    return false
end

exports('RemoveMetaKey', RemoveMetaKey)

---@param source number Player server ID
function ClearMetaKeyCache(source)
    for key, _ in pairs(PlayerMetaKeyCache) do
        if key:find('^' .. source .. ':') then
            PlayerMetaKeyCache[key] = nil
        end
    end
end

AddEventHandler('playerDropped', function()
    local src = source
    ClearMetaKeyCache(src)
end)

---@param house string House identifier
---@param keyId string Unique key ID
---@return boolean Success
function DeleteMetaKey(house, keyId)
    db:deleteMetaKey(keyId, house)
    Debug('DeleteMetaKey', 'Deleted key:', keyId, 'for house:', house)
    return true
end

---@param source number
---@param house string House identifier
---@return boolean
lib.callback.register('housing:createMetaKey', function(source, house)
    local identifier = GetIdentifier(source)

    if not Config.EnableMetaKey then
        Notification(source, i18n.t('metakey.system_disabled'), 'error')
        return false
    end

    if HouseOwnerIdentifierList[house] ~= identifier and HouseOwnerCitizenidList[house] ~= identifier then
        Notification(source, i18n.t('metakey.not_authorized'), 'error')
        return false
    end

    local price = Config.MetaKeyCreatePrice or 500
    local money = GetAccountMoney(source, Config.MoneyType)

    if money < price then
        Notification(source, i18n.t('no_money', { price = price }), 'error')
        return false
    end

    RemoveAccountMoney(source, Config.MoneyType, price)

    local newKeyId = CreateMetaKey(source, house, identifier)
    if not newKeyId or type(newKeyId) ~= 'string' then
        AddAccountMoney(source, Config.MoneyType, price)
        Notification(source, i18n.t('metakey.create_failed'), 'error')
        return false
    end
    local keyId = newKeyId -- @type string

    local success = GiveMetaKey(source, house, keyId)
    if success then
        Notification(source, i18n.t('metakey.created', { price = price }), 'success')

        SendLog(DiscordWebhook, {
            title = 'Housing - Meta Key Created',
            description = 'Player created a meta key',
            fields = {
                { name = 'Player', value = GetPlayerName(source), inline = true },
                { name = 'House',  value = house,                 inline = true },
                { name = 'Key ID', value = keyId,                 inline = true },
                { name = 'Price',  value = tostring(price),       inline = true }
            },
            color = WebhookColor
        })
    else
        AddAccountMoney(source, Config.MoneyType, price)
        Notification(source, i18n.t('metakey.create_failed'), 'error')
    end
    return true
end)

---@param source number
---@param house string
---@param keyId string
---@return boolean
lib.callback.register('housing:deleteMetaKey', function(source, house, keyId)
    local identifier = GetIdentifier(source)

    if not Config.EnableMetaKey then
        Notification(source, i18n.t('metakey.system_disabled'), 'error')
        return false
    end

    if HouseOwnerIdentifierList[house] ~= identifier and HouseOwnerCitizenidList[house] ~= identifier then
        Notification(source, i18n.t('metakey.not_authorized'), 'error')
        return false
    end

    local success = DeleteMetaKey(house, keyId)
    if success then
        Notification(source, i18n.t('metakey.deleted'), 'success')

        SendLog(DiscordWebhook, {
            title = 'Housing - Meta Key Deleted',
            description = 'Player deleted a meta key',
            fields = {
                { name = 'Player', value = GetPlayerName(source), inline = true },
                { name = 'House',  value = house,                 inline = true },
                { name = 'Key ID', value = keyId,                 inline = true }
            },
            color = WebhookColor
        })
    else
        Notification(source, i18n.t('metakey.delete_failed'), 'error')
    end
    return true
end)

RegisterServerCallback('housing:getHouseMetaKeys', function(source, cb, house)
    local identifier = GetIdentifier(source)

    if HouseOwnerIdentifierList[house] ~= identifier and HouseOwnerCitizenidList[house] ~= identifier then
        cb({})
        return
    end

    cb(GetHouseMetaKeys(house))
end)

RegisterNetEvent('housing:giveMetaKeyToPlayer', function(targetId, house)
    local src = source
    local identifier = GetIdentifier(src)

    if HouseOwnerIdentifierList[house] ~= identifier and HouseOwnerCitizenidList[house] ~= identifier then
        local isKeyholder = false
        if HouseKeyholdersList[house] then
            for _, cid in pairs(HouseKeyholdersList[house]) do
                if cid == identifier then
                    isKeyholder = true
                    break
                end
            end
        end

        if not isKeyholder then
            Notification(src, i18n.t('metakey.not_authorized'), 'error')
            return
        end
    end

    local targetPlayer = GetPlayerFromId(targetId)
    if not targetPlayer then
        Notification(src, i18n.t('metakey.player_offline'), 'error')
        return
    end

    local success = GiveMetaKey(targetId, house)
    if success then
        local firstName, lastName = GetCharacterName(targetId)
        Notification(src, i18n.t('metakey.given', { player = firstName .. ' ' .. lastName }), 'success')

        SendLog(DiscordWebhook, {
            title = 'Housing - Meta Key Transfer',
            description = 'Player gave a meta key to another player',
            fields = {
                { name = 'From',  value = GetPlayerName(src),      inline = true },
                { name = 'To',    value = GetPlayerName(targetId), inline = true },
                { name = 'House', value = house,                   inline = true }
            },
            color = WebhookColor
        })
    end
end)

---@param source number Player server ID
---@param house string House identifier
---@return boolean Whether player has a meta key for this house
function HasMetaKeyInInventory(source, house)
    local player = GetPlayerFromId(source)
    if not player then return false end

    local items = GetItems(player)
    if not items then return false end

    for _, item in pairs(items) do
        if item.name == Config.MetaKeyItem then
            local meta = item.info or item.metadata or {}
            if meta.houseId == house then
                return true
            end
        end
    end
    return false
end

RegisterUsableItem(Config.MetaKeyItem, function(source, item)
    local src = source
    local meta = item.info and item.info or item.metadata

    if not meta or not meta.houseId then
        Notification(src, i18n.t('metakey.invalid_key'), 'error')
        return
    end

    UseMetaKey(src, item)
end)

---@param source number
---@param item table
function UseMetaKey(source, item)
    local src = source
    local meta = item.info or item.metadata or {}

    if not meta.houseId or not meta.keyId then
        Notification(src, i18n.t('metakey.invalid_key'), 'error')
        return
    end

    local house = meta.houseId
    local houseData = Config.Houses[house]

    if not houseData then
        Notification(src, i18n.t('metakey.house_not_exists'), 'error')
        return
    end

    local isValid = db:isMetaKeyValid(meta.keyId, house)

    if not isValid then
        Notification(src, i18n.t('metakey.invalid_key'), 'error')
        return
    end

    local playerPed = GetPlayerPed(src)
    if playerPed and playerPed > 0 then
        local playerCoords = GetEntityCoords(playerPed)
        local enterCoords = houseData.coords.enter

        if enterCoords then
            local distance = #(playerCoords - vector3(enterCoords.x, enterCoords.y, enterCoords.z))

            if distance <= 2.0 then
                TriggerClientEvent('qb-houses:client:EnterHouse', src, houseData.ipl, house, {
                    isOwnedByMe = false,
                    haskey = true,
                    isOfficialOwner = false
                })
                Notification(src, i18n.t('metakey.entered_house', { house = meta.houseName or houseData.address or house }), 'success')
                return
            end
        end
    end

    Notification(src, i18n.t('metakey.key_info', { house = meta.houseName or house }), 'info')

    TriggerClientEvent('housing:showMetaKeyInfo', src, {
        houseId = house,
        houseName = meta.houseName or houseData.address or house,
        address = houseData.address,
        keyId = meta.keyId,
        givenAt = meta.givenAt
    })
end






