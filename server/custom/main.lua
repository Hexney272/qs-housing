





lib.callback.register('housing:routePlayer', function(source, house)
    local src = source
    if HouseRoutings[house] then
        local id = HouseRoutings[house].id
        table.insert(HouseRoutings[house].players, src)
        SetPlayerRoutingBucket(src, id)
        return
    end
    local houseData = Config.Houses[house]
    local id = math.random(1, 100000)
    if houseData?.id then
        id = houseData.id
    else
        Error('housing:routePlayer', 'House id not found', house)
    end
    PlayerDefaultRoutings[src] = GetPlayerRoutingBucket(src)
    HouseRoutings[house] = {
        id = id,
        house = house,
        players = { src }
    }
    Debug('housing:routePlayer', 'Setting player routing bucket', src, id)
    SetPlayerRoutingBucket(src, id)
end)

function RouteDefault(source, house)
    local src = source
    Debug('RouteDefault', 'Routing player to default', src, house)
    if not HouseRoutings[house] then return print('RouteDefault', 'houseRoutings[house] not exists') end
    local players = HouseRoutings[house].players
    SetPlayerRoutingBucket(src, PlayerDefaultRoutings[src])
    for k, v in pairs(players) do
        if v == src then
            table.remove(players, k)
        end
    end
    if #players == 0 then
        HouseRoutings[house] = nil
    end
    PlayerDefaultRoutings[src] = nil
end

local securedFileTypes = {
    'image',
    'audio',
    'video'
}

---@param source number
---@param fileType string
---@return string
lib.callback.register('housing:getPresignedUrl', function(source, fileType)
    if not table.includes(securedFileTypes, fileType) then
        Error('Invalid file type', fileType, 'source', source)
        return ''
    end
    local url = ('https://fmapi.net/api/v2/presigned-url?fileType=%s'):format(fileType)
    local promise = promise.new()
    PerformHttpRequest(url, function(err, text, headers)
        local data = json.decode(text)
        if not data then
            return promise:resolve('')
        end
        if data.status ~= 'ok' then
            Error('Failed to get presigned url', data)
            return promise:resolve('')
        end
        promise:resolve(data.data.presignedUrl)
    end, 'GET', nil, {
        Authorization = Config.FiveManageToken
    })
    return Citizen.Await(promise)
end)

lib.callback.register('housing:getFiveManageToken', function(source)
    if Config.FiveManageToken == '' then
        Error('housing:getFiveManageToken', 'FiveManage token is not set. Please set it in config/fivemanage.lua.')
        return nil
    end
    if not HasPermission(source) then
        Error('housing:getFiveManageToken', 'Player does not have permission to get five manage token')
        return nil
    end
    return Config.FiveManageToken
end)

lib.callback.register('housing:isOwnerOnline', function(source, house)
    if not Config.RequireOwnerOnline then return true end
    if not house then return false end
    local ownerIdentifier = HouseOwnerIdentifierList[house]
    if not ownerIdentifier then return true end
    local ownerSource = GetPlayerSourceFromIdentifier(ownerIdentifier)
    return ownerSource ~= false and ownerSource ~= nil
end)

RegisterNetEvent('qs-housing:enableAntiTeleport')
AddEventHandler('qs-housing:enableAntiTeleport', function()
    local src = source
    if not Config.FiveGuard then return end
    local result, errorText = exports[Config.FiveGuard]:SetTempPermission(
        src,        -- Player source
        'Client',   -- Category
        'BypassTeleport', -- Permission
        true,       -- Allow?
        false       -- Ignore static permissions
    )
end)

RegisterNetEvent('housing:fiveguard:freecam', function(toggle)
    local src = source

    if not Config.FiveGuard then return end
    exports[Config.FiveGuard]:SetTempPermission(src, 'Client', 'BypassFreecam', toggle, toggle, false)
    exports[Config.FiveGuard]:SetTempPermission(src, 'Client', 'BypassNoclip', toggle, toggle, false)
end)

RegisterNetEvent('qs-housing:disableAntiTeleport')
AddEventHandler('qs-housing:disableAntiTeleport', function()
    local src = source
    if not Config.FiveGuard then return end
    local result, errorText = exports[Config.FiveGuard]:SetTempPermission(
        src,        -- Player source
        'Client',   -- Category
        'BypassTeleport', -- Permission
        false,      -- Allow?
        false       -- Ignore static permissions
    )
end)






