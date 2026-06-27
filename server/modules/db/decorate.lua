local queries = {}

queries.INSERT_OBJECT = [[
        INSERT INTO house_decorations (creator, house, modelName, coords, rotation, inStash, inHouse, created, uniq, lightData, wallartData, price)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ]]

queries.DELETE_OBJECT = [[
        DELETE FROM house_decorations WHERE id = ?
    ]]

queries.SELECT_OBJECTS = [[
        SELECT * FROM house_decorations WHERE house = ?
    ]]

local function generateUniqId()
    local randomNum = math.random(100000, 999999)
    return ("decor_%s_%s_%s"):format(os.time(), GetGameTimer(), randomNum)
end

function db.saveObject(creator, objectData)
    local uniq = objectData.uniq
    if not uniq then
        uniq = generateUniqId()
    end
    objectData.uniq = uniq

    local lightDataJson
    if objectData.lightData then
        lightDataJson = json.encode(objectData.lightData)
        if not lightDataJson then
            lightDataJson = json.encode({})
        end
    else
        lightDataJson = json.encode({})
    end

    local wallartDataJson
    if objectData.wallartData then
        wallartDataJson = json.encode(objectData.wallartData)
        if not wallartDataJson then
            wallartDataJson = json.encode({})
        end
    else
        wallartDataJson = json.encode({})
    end

    local inStash = objectData.inStash and 1 or 0
    local inHouse = objectData.inHouse and 1 or 0
    local createdDate = os.date("%Y-%m-%d %H:%M:%S")
    local price = objectData.price or 0

    local insertId = MySQL.insert.await(queries.INSERT_OBJECT, {
        creator,
        objectData.house,
        objectData.modelName,
        json.encode(objectData.coords),
        json.encode(objectData.rotation),
        inStash,
        inHouse,
        createdDate,
        uniq,
        lightDataJson,
        wallartDataJson,
        price,
    })

    Debug("db.saveObject", "Saved", objectData.insideId, "Id", insertId, "Data", objectData)
    return insertId
end

function db.saveObjectsBatch(creator, objects)
    local count = #objects
    if count == 0 then
        return {}
    end

    local createdDate = os.date("%Y-%m-%d %H:%M:%S")
    local flatParams = {}
    local valuePlaceholders = {}

    for i = 1, count do
        local obj = objects[i]

        local uniq = obj.uniq
        if not uniq then
            uniq = generateUniqId()
        end
        obj.uniq = uniq

        local lightDataJson
        if obj.lightData then
            lightDataJson = json.encode(obj.lightData)
            if not lightDataJson then
                lightDataJson = json.encode({})
            end
        else
            lightDataJson = json.encode({})
        end

        local wallartDataJson
        if obj.wallartData then
            wallartDataJson = json.encode(obj.wallartData)
            if not wallartDataJson then
                wallartDataJson = json.encode({})
            end
        else
            wallartDataJson = json.encode({})
        end

        local inStash = obj.inStash and 1 or 0
        local inHouse = obj.inHouse and 1 or 0
        local price = obj.price or 0

        local rowParams = {
            creator,
            obj.house,
            obj.modelName,
            json.encode(obj.coords),
            json.encode(obj.rotation),
            inStash,
            inHouse,
            createdDate,
            uniq,
            lightDataJson,
            wallartDataJson,
            price,
        }

        for j = 1, #rowParams do
            flatParams[#flatParams + 1] = rowParams[j]
        end

        valuePlaceholders[i] = "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    end

    local queryTemplate = [[
        INSERT INTO house_decorations (creator, house, modelName, coords, rotation, inStash, inHouse, created, uniq, lightData, wallartData, price)
        VALUES %s
    ]]
    local query = queryTemplate:format(table.concat(valuePlaceholders, ", "))

    local result = MySQL.insert.await(query, flatParams)
    if not result then
        return {}
    end

    return objects
end

function db.getObjects(houseId)
    local rows = MySQL.query.await(queries.SELECT_OBJECTS, { houseId })

    for i = 1, #rows do
        local row = rows[i]
        row.coords = json.decode(rows[i].coords)
        row.rotation = json.decode(rows[i].rotation)
        row.created = os.time(os.date("*t", math.floor(rows[i].created / 1000)))

        local uniq = rows[i].uniq
        if not uniq then
            uniq = tostring("house_" .. rows[i].id)
        end
        row.uniq = uniq

        local lightData = rows[i].lightData
        if lightData then
            lightData = json.decode(rows[i].lightData)
        end
        row.lightData = lightData

        local wallartData = rows[i].wallartData
        if wallartData then
            wallartData = json.decode(rows[i].wallartData)
            if not wallartData then
                wallartData = nil
            end
        else
            wallartData = nil
        end
        row.wallartData = wallartData
    end

    return rows
end

function db.updateObject(objectId, data)
    if not data then
        Debug("db.updateObject", "No data to update")
        return false
    end

    Debug("db.updateObject", data)

    local query = "UPDATE house_decorations SET"
    local params = {}

    for key, value in pairs(data) do
        query = query .. (" `%s` = :%s,"):format(key, key)

        if false == value and "inStash" ~= key and "inHouse" ~= key then
            value = nil
            Debug("db.updateObject", "Set", key, "to nil because of false")
        end

        if "wallartData" == key then
            if type(value) == "table" then
                value = json.encode(value)
            end
        end

        params[key] = value
    end

    query = query:sub(1, -2)
    query = query .. " WHERE id = :id"
    params.id = objectId

    Debug("params", params)
    return MySQL.update.await(query, params)
end

function db.deleteObject(objectId)
    MySQL.prepare(queries.DELETE_OBJECT, { objectId })
    return true
end

function db.deleteAllObjects(houseId)
    Debug("db.deleteAllObjects", houseId)
    ClearHouseDecoration(houseId)
    MySQL.prepare.await("DELETE FROM house_decorations WHERE house = ?", { houseId })
    return true
end

function db.revertDecorations()
    local transactions = {}

    local houses = MySQL.query.await("SELECT decorations, house, owner FROM player_houses")
    Debug("houseDecorations", houses)

    for _, houseRow in pairs(houses) do
        if not houseRow.decorations then
            Warning("db.revertDecorations", "No decorations found for house we are going to skip it", houseRow.house)
        else
            local decorations = json.decode(houseRow.decorations)
            if not decorations then
                Debug("db.revertDecorations", "No decorations found for house we are going to skip it", houseRow.house)
            else
                for _, decoration in pairs(decorations) do
                    table.insert(transactions, {
                        query = queries.INSERT_OBJECT,
                        values = {
                            houseRow.owner,
                            houseRow.house,
                            decoration.hashname,
                            json.encode({ x = decoration.x, y = decoration.y, z = decoration.z }),
                            json.encode({ x = decoration.rotx, y = decoration.roty, z = decoration.rotz }),
                            decoration.inStash and 1 or 0,
                            decoration.inHouse and 1 or 0,
                            os.date("%Y-%m-%d %H:%M:%S"),
                            decoration.uniq,
                            json.encode(decoration.lightData or {}),
                            json.encode({}),
                            0,
                        },
                    })
                end
            end
        end
    end

    local success = MySQL.Sync.transaction(transactions)
    if success then
        Debug("db.revertDecorations", "Success")
    else
        Debug("db.revertDecorations", "Failed")
    end

    MySQL.query("ALTER TABLE player_houses DROP COLUMN decorations")
    LoopError("We drop the decorations column on your sql. Restart the script! Decorations have been reverted!")
end

CreateThread(function()
    local columnExists = MySQL.scalar.await([[
        SELECT COUNT(*)
        FROM information_schema.COLUMNS
        WHERE TABLE_SCHEMA = DATABASE()
          AND TABLE_NAME = 'house_decorations'
          AND COLUMN_NAME = 'wallartData'
    ]])

    if columnExists and columnExists > 0 then
        return
    end

    MySQL.query.await("ALTER TABLE house_decorations ADD COLUMN wallartData LONGTEXT NULL")
end)
