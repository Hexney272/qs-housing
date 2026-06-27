local activeCleaners = {}

local function IsCleanerActive(house, decorationId)
    if activeCleaners[house] then
        if activeCleaners[house][decorationId] then
            return true, activeCleaners[house][decorationId].ownerId
        end
    end
    return false, nil
end

local function StartCleaner(playerId, house, decorationId, modelName)
    local isActive, _ = IsCleanerActive(house, decorationId)
    if isActive then
        return false, "already_active"
    end

    if not activeCleaners[house] then
        activeCleaners[house] = {}
    end

    activeCleaners[house][decorationId] = {
        decorationId = decorationId,
        house = house,
        ownerId = playerId,
        networkId = 0,
        modelName = modelName,
    }

    TriggerClientEvent("housing:cleaner:setDecorationAlpha", -1, house, decorationId, 0)
    Debug("Cleaner started", "house", house, "decorationId", decorationId, "owner", playerId)

    return true, nil
end

local function UpdateCleanerNetworkId(playerId, house, decorationId, networkId)
    if activeCleaners[house] then
        if activeCleaners[house][decorationId] then
            if activeCleaners[house][decorationId].ownerId == playerId then
                activeCleaners[house][decorationId].networkId = networkId
                Debug("Cleaner network ID updated", "house", house, "decorationId", decorationId, "networkId", networkId)
            end
        end
    end
end

local function StopCleaner(playerId, house, decorationId)
    if not activeCleaners[house] or not activeCleaners[house][decorationId] then
        return false
    end

    local cleanerData = activeCleaners[house][decorationId]

    if playerId > 0 then
        if cleanerData.ownerId ~= playerId then
            return false
        end
    end

    TriggerClientEvent("housing:cleaner:setDecorationAlpha", -1, house, decorationId, 255)

    if cleanerData.ownerId > 0 then
        TriggerClientEvent("housing:cleaner:deleteNetworkedRobot", cleanerData.ownerId, house, decorationId)
    end

    activeCleaners[house][decorationId] = nil

    if next(activeCleaners[house]) == nil then
        activeCleaners[house] = nil
    end

    Debug("Cleaner stopped", "house", house, "decorationId", decorationId)
    return true
end

local function StopAllCleanersForPlayer(playerId)
    for house, decorations in pairs(activeCleaners) do
        for decorationId, cleanerData in pairs(decorations) do
            if cleanerData.ownerId == playerId then
                StopCleaner(0, house, decorationId)
            end
        end
    end
end

lib.callback.register("housing:cleaner:start", function(source, house, decorationId, modelName)
    local success, reason = StartCleaner(source, house, decorationId, modelName)
    return success, reason
end)

lib.callback.register("housing:cleaner:stop", function(source, house, decorationId)
    return StopCleaner(source, house, decorationId)
end)

lib.callback.register("housing:cleaner:isActive", function(source, house, decorationId)
    local isActive, ownerId = IsCleanerActive(house, decorationId)
    return isActive, ownerId
end)

RegisterNetEvent("housing:cleaner:updateNetworkId", function(house, decorationId, networkId)
    local src = source
    UpdateCleanerNetworkId(src, house, decorationId, networkId)
end)

RegisterNetEvent("housing:cleaner:stopped", function(house, decorationId)
    local src = source
    StopCleaner(src, house, decorationId)
end)

AddEventHandler("housing:setInside", function(_, isInside)
    local src = source
    if not isInside then
        StopAllCleanersForPlayer(src)
    end
end)

AddEventHandler("playerDropped", function()
    local src = source
    StopAllCleanersForPlayer(src)
end)
