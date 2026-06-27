





if Config.Garage ~= 'zerio-garage' then
    return
end

function TriggerAddHouseGarage(house, garageInfo)
    return
end

function TriggerHouseUpdateGarage(garages)
    return
end

function TriggerHouseRemoveGarage(house)
    return
end

local function toSpawnVector4(data)
    if type(data) ~= 'table' then
        return nil
    end

    local x = tonumber(data.x)
    local y = tonumber(data.y)
    local z = tonumber(data.z)
    local w = tonumber(data.w or data.h) or 0.0

    if not x or not y or not z then
        return nil
    end

    return vector4(x, y, z, w)
end

local function normalizeGarageSpawns(garage)
    if type(garage) ~= 'table' then
        return nil
    end

    local spawns = {}

    if type(garage.slots) == 'table' then
        for _, slot in pairs(garage.slots) do
            local spawn = toSpawnVector4(slot)
            if spawn then
                spawns[#spawns + 1] = spawn
            end
        end
    end

    if #spawns == 0 and type(garage.coords) == 'table' then
        local coordsSpawn = toSpawnVector4(garage.coords)
        if coordsSpawn then
            spawns[#spawns + 1] = coordsSpawn
        end
    end

    if #spawns == 0 then
        local singleSpawn = toSpawnVector4(garage)
        if singleSpawn then
            spawns[#spawns + 1] = singleSpawn
        end
    end

    if #spawns == 0 then
        return nil
    end

    if #spawns == 1 then
        return spawns[1]
    end

    return spawns
end

local function hasHouseAccess(src, houseId, houseData)
    if type(houseData) ~= 'table' then
        return false
    end

    local identifier = GetIdentifier(src)
    if not identifier then
        return false
    end

    if CheckHasKey and CheckHasKey(identifier, identifier, houseId, src) then
        return true
    end

    if houseData.locked == false then
        return true
    end

    return false
end

RegisterNetEvent('housing:server:openZerioGarage', function(houseId)
    local src = source
    if not houseId then
        return
    end

    if type(houseId) ~= 'string' then
        houseId = tostring(houseId)
    end

    local houseData = Config.Houses and Config.Houses[houseId]
    if not houseData or not houseData.garage then
        return
    end

    if not hasHouseAccess(src, houseId, houseData) then
        return
    end

    local spawns = normalizeGarageSpawns(houseData.garage)
    if not spawns then
        Notification(src, 'Garage spawn point is not configured.', 'error')
        return
    end

    local label = houseData.address or houseId
    exports['zerio-garage']:OpenHousingGarage(src, houseId, label, spawns)
end)

RegisterNetEvent('housing:server:storeZerioVehicle', function(houseId)
    local src = source
    if not houseId then
        return
    end

    if type(houseId) ~= 'string' then
        houseId = tostring(houseId)
    end

    local houseData = Config.Houses and Config.Houses[houseId]
    if not houseData or not houseData.garage then
        return
    end

    if not hasHouseAccess(src, houseId, houseData) then
        return
    end

    local label = houseData.address or houseId
    exports['zerio-garage']:StoreHousingVehicle(src, houseId, label)
end)






