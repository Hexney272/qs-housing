local SQL = {}

SQL.INSERT_ORDER = [[
        INSERT INTO house_furniture_orders (house, buyer_identifier, model_name, price, payload_json, status, deliver_at, created_at, updated_at)
        VALUES (?, ?, ?, ?, ?, 'pending', ?, NOW(), NOW())
    ]]

SQL.SELECT_READY_ORDERS = [[
        SELECT id, model_name, price, payload_json
        FROM house_furniture_orders
        WHERE house = ? AND status = 'ready'
        ORDER BY id ASC
    ]]

SQL.SELECT_READY_COUNT = [[
        SELECT COUNT(*) AS count
        FROM house_furniture_orders
        WHERE house = ? AND status = 'ready'
    ]]

SQL.SELECT_READY_COUNTS_FOR_HOUSES = [[
        SELECT house, COUNT(*) AS count
        FROM house_furniture_orders
        WHERE status = 'ready' AND house IN (%s)
        GROUP BY house
    ]]

SQL.SELECT_HOUSES_WITH_DUE_ORDERS = [[
        SELECT DISTINCT house
        FROM house_furniture_orders
        WHERE status = 'pending' AND deliver_at <= NOW()
    ]]

SQL.UPDATE_DUE_TO_READY = [[
        UPDATE house_furniture_orders
        SET status = 'ready', updated_at = NOW()
        WHERE status = 'pending' AND deliver_at <= NOW()
    ]]

function db.createFurnitureOrder(orderData)
    local payloadJson = json.encode(orderData.payload or {})

    return MySQL.insert.await(SQL.INSERT_ORDER, {
        orderData.house,
        orderData.buyerIdentifier,
        orderData.modelName,
        orderData.price,
        payloadJson,
        orderData.deliverAt
    })
end

function db.getReadyFurnitureOrderCount(house)
    local result = MySQL.single.await(SQL.SELECT_READY_COUNT, { house })
    if result then
        return result.count or 0
    end
    return 0
end

function db.getReadyFurnitureOrderCounts(houses)
    local counts = {}

    if not houses or #houses == 0 then
        return counts
    end

    local placeholders = {}
    local params = {}

    for i = 1, #houses do
        placeholders[#placeholders + 1] = "?"
        params[#params + 1] = houses[i]
        counts[houses[i]] = 0
    end

    local query = SQL.SELECT_READY_COUNTS_FOR_HOUSES:format(table.concat(placeholders, ","))
    local rows = MySQL.query.await(query, params)
    if not rows then
        rows = {}
    end

    for i = 1, #rows do
        local row = rows[i]
        if row.house then
            counts[row.house] = tonumber(row.count) or 0
        end
    end

    return counts
end

function db.getReadyFurnitureOrders(house)
    local results = MySQL.query.await(SQL.SELECT_READY_ORDERS, { house })
    if not results then
        results = {}
    end
    return results
end

function db.markFurnitureOrdersDelivered(orderIds, house)
    if #orderIds == 0 then
        return false
    end

    local placeholders = {}
    local params = { house }

    for i = 1, #orderIds do
        placeholders[#placeholders + 1] = "?"
        params[#params + 1] = orderIds[i]
    end

    local query = [[
 
        UPDATE house_furniture_orders
        SET status = 'delivered', delivered_at = NOW(), updated_at = NOW()
        WHERE house = ? AND status = 'ready' AND id IN (%s)
    ]]
    query = query:format(table.concat(placeholders, ","))

    local affectedRows = MySQL.update.await(query, params)
    if not affectedRows then
        affectedRows = 0
    end

    return affectedRows == #orderIds
end

function db.claimReadyFurnitureOrders(house)
    local orders = db.getReadyFurnitureOrders(house)

    if #orders == 0 then
        return false, {}, {}
    end

    local orderIds = {}
    for i = 1, #orders do
        orderIds[#orderIds + 1] = orders[i].id
    end

    local success = db.markFurnitureOrdersDelivered(orderIds, house)
    if not success then
        return false, {}, {}
    end

    return true, orders, orderIds
end

function db.revertFurnitureOrdersToReady(orderIds, house)
    if #orderIds == 0 then
        return false
    end

    local placeholders = {}
    local params = { house }

    for i = 1, #orderIds do
        placeholders[#placeholders + 1] = "?"
        params[#params + 1] = orderIds[i]
    end

    local query = [[
 
        UPDATE house_furniture_orders
        SET status = 'ready', updated_at = NOW()
        WHERE house = ? AND status = 'delivered' AND id IN (%s)
    ]]
    query = query:format(table.concat(placeholders, ","))

    local affectedRows = MySQL.update.await(query, params)
    if not affectedRows then
        affectedRows = 0
    end

    return affectedRows == #orderIds
end

function db.updateFurnitureOrdersToReady()
    local dueOrders = MySQL.query.await(SQL.SELECT_HOUSES_WITH_DUE_ORDERS)
    if not dueOrders then
        dueOrders = {}
    end

    if #dueOrders == 0 then
        return {}
    end

    MySQL.update.await(SQL.UPDATE_DUE_TO_READY)

    local affectedHouses = {}
    local seen = {}

    for i = 1, #dueOrders do
        local house = dueOrders[i].house
        if house then
            if not seen[house] then
                seen[house] = true
                affectedHouses[#affectedHouses + 1] = house
            end
        end
    end

    return affectedHouses
end
