lib.callback.register("housing:getCreatorData", function(source)
    if not HasPermission(source) then
        Error("housing:getCreatorData", "Player does not have permission to get creator data")
        return nil
    end

    local furnitureCategories = {}
    for key, category in pairs(Config.Furniture) do
        if key ~= "navigation" then
            furnitureCategories[#furnitureCategories + 1] = {
                key = key,
                label = category.label,
            }
        end
    end

    local result = {}
    result.jobs = GetJobsData()
    result.furnitureShops = Config.FurnitureShops
    result.furnitureCategories = furnitureCategories
    return result
end)

function GetGarageStreetId(streetName)
    local rows = MySQL.Sync.fetchAll(
        "SELECT COUNT(*) as count FROM player_garages WHERE name LIKE ?",
        { "%" .. streetName .. "%" }
    )
    return rows[1].count + 1
end

lib.callback.register("housing:createHouse", function(source, address, data)
    if not HasPermission(source) then
        Error("housing:createHouse", "Player does not have permission to create house")
        return false
    end

    if Config.Houses[data.name] then
        Notification(source, i18n.t("creator.house_already_exists"), "error")
        return false
    end

    local apartmentCount = data.apartmentCount and tonumber(data.apartmentCount) or nil
    data.apartmentCount = apartmentCount

    if data.apartmentCount then
        if data.apartmentCount > Config.MaxApartmentCount then
            Error("This player tried to create more than the max apartment count", source, "We are decreasing the apartment count to the max")
            data.apartmentCount = Config.MaxApartmentCount
        end
    end

    if data.apartmentCount then
        data.garage = nil
        data.garageShell = nil
    end

    local firstName, lastName = GetCharacterName(source)
    local fullName = firstName .. " " .. lastName
    local phone = GetPlayerPhone(source)
    local jobName = GetJobName(source)

    local board = {}
    board.object = Config.BoardObject
    board.coords = data.board
    board.name = fullName or "Unknown"
    board.phone = phone or "Unknown"
    data.board = board

    address = address:gsub("%'", "")

    data.price = (data.price and tonumber(data.price)) or 0
    data.tier = (data.tier and tonumber(data.tier)) or 0
    data.address = address

    db.createHouse(source, jobName, data)

    if data.island and data.island.enable then
        CreateHouseObject(source, {
            house = data.name,
            coords = data.island.data.coords,
            model = data.island.data.model,
        })
    end

    if data.showOnMap and data.showOnMap.enable then
        CreateHouseObject(source, {
            house = data.name,
            coords = data.showOnMap.data.coords,
            model = data.showOnMap.data.model,
        })
    end

    return true
end)

lib.callback.register("housing:updateHouse", function(source, data)
    if not HasPermission(source) then
        Error("housing:updateHouse", "Player does not have permission to update house")
        return false
    end

    assert(data.name, "housing:updateHouse data.name is nil")

    if data.apartmentCount then
        data.garage = nil
        data.garageShell = nil
    end

    local firstName, lastName = GetCharacterName(source)
    local fullName = firstName .. " " .. lastName
    local phone = GetPlayerPhone(source)

    local board = {}
    board.object = Config.BoardObject

    local boardCoords
    if data.board and data.board.coords and data.board.coords.x then
        boardCoords = vec4(data.board.coords.x, data.board.coords.y, data.board.coords.z, data.board.coords.w)
    end
    board.coords = boardCoords or data.board
    board.name = fullName or "Unknown"
    board.phone = phone or "Unknown"
    data.board = board

    data.price = (data.price and tonumber(data.price)) or 0
    data.tier = (data.tier and tonumber(data.tier)) or 0

    DeleteHouseObject(data.name)

    if data.island and data.island.enable then
        CreateHouseObject(source, {
            house = data.name,
            coords = data.island.data.coords,
            model = data.island.data.model,
        })
    end

    if data.showOnMap and data.showOnMap.enable then
        CreateHouseObject(source, {
            house = data.name,
            coords = data.showOnMap.data.coords,
            model = data.showOnMap.data.model,
        })
    end

    db.updateHouse(source, data)
    return true
end)

lib.callback.register("housing:removeHouse", function(source, house)
    if not HasPermission(source) then
        Error("housing:removeHouse", "Player does not have permission to remove house")
        return false
    end

    assert(house, "housing:removeHouse house is nil")

    local success = DeleteHouse(house)
    if not success then
        Error("housing:removeHouse", "Failed to remove house", house)
        return false
    end

    Notification(source, i18n.t("house_deleted"), "success")
    return true
end)

lib.callback.register("housing:createFurnitureShop", function(source, data)
    if not HasPermission(source) then
        Error("housing:createFurnitureShop", "Player does not have permission")
        return false
    end

    assert(data, "housing:createFurnitureShop data is nil")
    assert(data.name, "housing:createFurnitureShop data.name is nil")

    local shopId = db.createFurnitureShop(source, data)
    if not shopId then
        Error("housing:createFurnitureShop", "Failed to create furniture shop")
        return false
    end

    InitFurnitureShops()
    TriggerClientEvent("housing:syncFurnitureShops", -1, Config.FurnitureShops)
    Notification(source, i18n.t("creator.furniture_shop_created"), "success")
    Debug("housing:createFurnitureShop", "Created", data.name, "ID", shopId)
    return true
end)

lib.callback.register("housing:updateFurnitureShop", function(source, data)
    if not HasPermission(source) then
        Error("housing:updateFurnitureShop", "Player does not have permission")
        return false
    end

    assert(data, "housing:updateFurnitureShop data is nil")
    assert(data.id, "housing:updateFurnitureShop data.id is nil")

    local success = db.updateFurnitureShop(source, data)
    if not success then
        Error("housing:updateFurnitureShop", "Failed to update furniture shop")
        return false
    end

    InitFurnitureShops()
    TriggerClientEvent("housing:syncFurnitureShops", -1, Config.FurnitureShops)
    Notification(source, i18n.t("creator.furniture_shop_updated"), "success")
    Debug("housing:updateFurnitureShop", "Updated", data.id)
    return true
end)

lib.callback.register("housing:removeFurnitureShop", function(source, shopId)
    if not HasPermission(source) then
        Error("housing:removeFurnitureShop", "Player does not have permission")
        return false
    end

    assert(shopId, "housing:removeFurnitureShop id is nil")

    local success = db.removeFurnitureShop(shopId, source)
    if not success then
        Error("housing:removeFurnitureShop", "Failed to remove furniture shop")
        return false
    end

    InitFurnitureShops()
    TriggerClientEvent("housing:syncFurnitureShops", -1, Config.FurnitureShops)
    Notification(source, i18n.t("creator.furniture_shop_deleted"), "success")
    Debug("housing:removeFurnitureShop", "Removed", shopId)
    return true
end)

lib.callback.register("housing:removeHouseOwner", function(source, house)
    if not HasPermission(source) then
        Error("housing:removeHouseOwner", "Player does not have permission to remove house owner")
        return false
    end

    assert(house, "housing:removeHouseOwner house is nil")

    local ownerIdentifier = HouseOwnerIdentifierList[house]
    if not ownerIdentifier then
        Notification(source, i18n.t("creator.house_has_no_owner"), "error")
        return false
    end

    MySQL.Sync.execute("DELETE FROM player_houses WHERE house = ?", { house })

    HouseOwnerCitizenidList[house] = nil
    HouseOwnerIdentifierList[house] = nil
    OfficialHouseOwnerList[house] = nil
    HouseKeyholdersList[house] = nil

    TriggerClientEvent("qb-houses:requiredLeaveHouse", -1, house)
    InitHouse(house)
    Notification(source, i18n.t("creator.owner_removed"), "success")
    return true
end)
