local db = db

function db.getFurnitureItems()
    local results = MySQL.query.await("SELECT * FROM qs_housing_furnitures ORDER BY category_key, label")
    if not results then
        return {}
    end
    return results
end

function db.getFurnitureItemsByCategory(categoryKey)
    local results = MySQL.query.await("SELECT * FROM qs_housing_furnitures WHERE category_key = ? ORDER BY label", { categoryKey })
    if not results then
        return {}
    end
    return results
end

function db.createFurnitureItem(source, data)
    assert(data, "db.createFurnitureItem data must be provided")
    assert(data.category, "db.createFurnitureItem category is required")
    assert(data.item, "db.createFurnitureItem item is required")

    local identifier = GetIdentifier(source)
    assert(identifier, "db.createFurnitureItem identifier is nil")

    local item = data.item
    local query = [[
        INSERT INTO qs_housing_furnitures
        (`creator`, `category_key`, `object`, `label`, `description`, `price`, `img`, `colorlabel`, `type`, `stash`, `offset`, `colors`)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ]]

    local offset = item.offset
    if not offset then
        offset = { x = 0.0, y = 0.0, z = 0.0 }
    end
    item.offset = offset

    local description = item.description
    if not description then description = "" end

    local price = item.price
    if not price then price = 0 end

    local img = item.img
    if not img then img = "" end

    local colorlabel = item.colorlabel
    if not colorlabel then colorlabel = "" end

    local stashJson = item.stash
    if stashJson then
        stashJson = json.encode(item.stash)
        if not stashJson then stashJson = nil end
    else
        stashJson = nil
    end

    local offsetJson = json.encode(item.offset)

    local colorsJson = item.colors
    if colorsJson then
        colorsJson = json.encode(item.colors)
        if not colorsJson then colorsJson = "[]" end
    else
        colorsJson = "[]"
    end

    local insertedId = MySQL.insert.await(query, {
        identifier,
        data.category,
        item.object,
        item.label,
        description,
        price,
        img,
        colorlabel,
        item.type,
        stashJson,
        offsetJson,
        colorsJson
    })

    Debug("db.createFurnitureItem", "Inserted", insertedId, "Category", data.category, "Object", item.object)
    return insertedId
end

function db.updateFurnitureItem(source, data)
    assert(data, "db.updateFurnitureItem data must be provided")
    assert(data.item, "db.updateFurnitureItem item is required")
    assert(data.item.id, "db.updateFurnitureItem item.id is required")

    local identifier = GetIdentifier(source)
    assert(identifier, "db.updateFurnitureItem identifier is nil")

    local item = data.item
    local query = [[
        UPDATE qs_housing_furnitures
        SET `category_key` = ?, `object` = ?, `label` = ?, `description` = ?, `price` = ?,
            `img` = ?, `colorlabel` = ?, `type` = ?, `stash` = ?, `offset` = ?, `colors` = ?
        WHERE id = ?
    ]]

    local offset = item.offset
    if not offset then
        offset = { x = 0.0, y = 0.0, z = 0.0 }
    end
    item.offset = offset

    local description = item.description
    if not description then description = "" end

    local price = item.price
    if not price then price = 0 end

    local img = item.img
    if not img then img = "" end

    local colorlabel = item.colorlabel
    if not colorlabel then colorlabel = "" end

    local stashJson = item.stash
    if stashJson then
        stashJson = json.encode(item.stash)
        if not stashJson then stashJson = nil end
    else
        stashJson = nil
    end

    local offsetJson = json.encode(item.offset)

    local colorsJson = item.colors
    if colorsJson then
        colorsJson = json.encode(item.colors)
        if not colorsJson then colorsJson = "[]" end
    else
        colorsJson = "[]"
    end

    local affectedRows = MySQL.update.await(query, {
        data.category,
        item.object,
        item.label,
        description,
        price,
        img,
        colorlabel,
        item.type,
        stashJson,
        offsetJson,
        colorsJson,
        item.id
    })

    Debug("db.updateFurnitureItem", "Updated", affectedRows, "ID", item.id, "Object", item.object)
    return affectedRows > 0
end

function db.removeFurnitureItem(id, source)
    assert(id, "db.removeFurnitureItem id is nil")

    local identifier = GetIdentifier(source)
    assert(identifier, "db.removeFurnitureItem identifier is nil")

    local affectedRows = MySQL.update.await("DELETE FROM qs_housing_furnitures WHERE id = ? AND creator = ?", { id, identifier })
    Debug("db.removeFurnitureItem", "Deleted", affectedRows, "ID", id)
    return affectedRows > 0
end

function db.getMergedFurnitureData()
    local dbItems = db.getFurnitureItems()
    local furnitureConfig = table.clone(Config.Furniture)
    if not furnitureConfig then
        furnitureConfig = {}
    end

    for _, row in ipairs(dbItems) do
        local categoryKey = row.category_key
        local category = furnitureConfig[categoryKey]

        if not category then
            Error("db.getMergedFurnitureData", "Category not found", categoryKey)
        else
            -- Decode JSON fields
            local stash = row.stash
            if stash then
                stash = json.decode(row.stash)
                if not stash then stash = nil end
            else
                stash = nil
            end
            row.stash = stash

            local offset = row.offset
            if offset then
                offset = json.decode(row.offset)
                if not offset then offset = nil end
            else
                offset = nil
            end
            row.offset = offset

            local colors = row.colors
            if colors then
                colors = json.decode(row.colors)
                if not colors then colors = nil end
            else
                colors = nil
            end
            row.colors = colors

            -- Build furniture item entry
            local entry = {
                id = row.id,
                object = row.object,
                label = row.label,
                description = row.description,
                price = row.price,
                img = row.img,
                colorlabel = row.colorlabel,
                type = row.type,
                key = categoryKey,
                creator = true,
                stash = row.stash,
                offset = row.offset,
                colors = row.colors,
            }

            -- Find existing item with the same object in the category
            local existingIndex = nil
            for i, existingItem in ipairs(furnitureConfig[categoryKey].items) do
                if existingItem.object == entry.object then
                    existingIndex = i
                    break
                end
            end

            if existingIndex then
                furnitureConfig[categoryKey].items[existingIndex] = entry
            else
                table.insert(furnitureConfig[categoryKey].items, entry)
            end
        end
    end

    return furnitureConfig
end
