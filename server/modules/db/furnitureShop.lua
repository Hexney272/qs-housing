local db = db

function db.getFurnitureShops()
    local rows = MySQL.query.await("SELECT * FROM qs_housing_furniture_shops ORDER BY id")

    if not rows then
        return {}
    end

    local shops = {}

    for _, row in ipairs(rows) do
        local enter = json.decode(row.enter)

        local blip = row.blip
        if blip then
            blip = json.decode(row.blip)
            if not blip then blip = nil end
        else
            blip = nil
        end

        local categories = row.categories
        if categories then
            categories = json.decode(row.categories)
            if not categories then categories = "all" end
        else
            categories = "all"
        end

        shops[#shops + 1] = {
            id = row.id,
            name = row.name,
            enter = vec3(enter.x, enter.y, enter.z),
            blip = blip,
            categories = categories,
            creator = row.creator,
        }
    end

    Debug("db.getFurnitureShops", "Loaded", #shops, "shops")
    return shops
end

function db.expandFurnitureShopCategories(shops)
    for i, shop in pairs(shops) do
        if shop.categories == "all" then
            shops[i].categories = {}
            for categoryKey in pairs(Config.Furniture) do
                if categoryKey ~= "navigation" then
                    shops[i].categories[#shops[i].categories + 1] = categoryKey
                end
            end
        end
    end
    return shops
end

function db.createFurnitureShop(source, data)
    assert(data, "db.createFurnitureShop data must be provided")
    assert(data.name, "db.createFurnitureShop name is required")
    assert(data.enter, "db.createFurnitureShop enter is required")

    local identifier = GetIdentifier(source)
    assert(identifier, "db.createFurnitureShop identifier is nil")

    local query = [[
        INSERT INTO qs_housing_furniture_shops
        (`name`, `enter`, `blip`, `categories`, `creator`)
        VALUES (?, ?, ?, ?, ?)
    ]]

    local categoriesJson = data.categories
    if type(categoriesJson) == "table" then
        categoriesJson = json.encode(categoriesJson)
    elseif categoriesJson == "all" then
        categoriesJson = json.encode("all")
    else
        categoriesJson = json.encode("all")
    end

    local blipJson = data.blip
    if blipJson then
        blipJson = json.encode(data.blip)
        if not blipJson then blipJson = nil end
    else
        blipJson = nil
    end

    local insertedId = MySQL.insert.await(query, {
        data.name,
        json.encode(data.enter),
        blipJson,
        categoriesJson,
        identifier
    })

    Debug("db.createFurnitureShop", "Inserted", insertedId, "Name", data.name)
    return insertedId
end

function db.updateFurnitureShop(source, data)
    assert(data, "db.updateFurnitureShop data must be provided")
    assert(data.id, "db.updateFurnitureShop id is required")

    local identifier = GetIdentifier(source)
    assert(identifier, "db.updateFurnitureShop identifier is nil")

    local categoriesJson = data.categories
    if type(categoriesJson) == "table" then
        categoriesJson = json.encode(categoriesJson)
    elseif categoriesJson == "all" then
        categoriesJson = json.encode("all")
    else
        categoriesJson = json.encode("all")
    end

    local query = [[
        UPDATE qs_housing_furniture_shops
        SET `name` = ?, `enter` = ?, `blip` = ?, `categories` = ?
        WHERE `id` = ?
    ]]

    local blipJson = data.blip
    if blipJson then
        blipJson = json.encode(data.blip)
        if not blipJson then blipJson = nil end
    else
        blipJson = nil
    end

    local affectedRows = MySQL.update.await(query, {
        data.name,
        json.encode(data.enter),
        blipJson,
        categoriesJson,
        data.id
    })

    Debug("db.updateFurnitureShop", "Updated", affectedRows, "ID", data.id)
    return affectedRows > 0
end

function db.removeFurnitureShop(id, source)
    assert(id, "db.removeFurnitureShop id is nil")

    local identifier = GetIdentifier(source)
    assert(identifier, "db.removeFurnitureShop identifier is nil")

    local affectedRows = MySQL.update.await("DELETE FROM qs_housing_furniture_shops WHERE id = ?", { id })
    Debug("db.removeFurnitureShop", "Deleted", affectedRows, "ID", id)
    return affectedRows > 0
end
