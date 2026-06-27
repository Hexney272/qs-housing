_G.sv_common = {}

-- Dancer system
local dancersByHouse = {}
local dancerIdCounter = 0

local function NextDancerId()
    dancerIdCounter = dancerIdCounter + 1
    return dancerIdCounter
end

function sv_common:getDancers(source, house)
    if not house then
        return {}
    end

    local houseDancers = dancersByHouse[house]
    if not houseDancers then
        houseDancers = {}
    end

    local result = {}
    for _, dancer in ipairs(houseDancers) do
        table.insert(result, {
            id = dancer.id,
            title = dancer.title,
            pedModel = dancer.pedModel,
            anim = dancer.anim,
            orderedAt = dancer.orderedAt,
            status = dancer.status,
            deliveryTime = dancer.deliveryTime,
            coords = dancer.coords,
        })
    end
    return result
end

local function GetDancerDeliveryTime(dancerTitle)
    for _, dancer in ipairs(Config.Dancers) do
        if dancer.title == dancerTitle then
            if dancer.deliveryTime then
                if type(dancer.deliveryTime) == "number" then
                    return dancer.deliveryTime
                end
                if type(dancer.deliveryTime) == "table" then
                    if dancer.deliveryTime.min and dancer.deliveryTime.max then
                        return math.random(dancer.deliveryTime.min, dancer.deliveryTime.max)
                    end
                end
            end
            break
        end
    end
    return math.random(5, 10)
end

function sv_common:orderDancer(source, house, dancerTitle, price)
    if not house or not dancerTitle or not price then
        return false
    end

    local bankBalance = GetAccountMoney(source, "bank")
    if price > bankBalance then
        return false
    end

    RemoveAccountMoney(source, "bank", price)

    local deliveryMinutes = GetDancerDeliveryTime(dancerTitle)
    local deliveryTimestamp = os.time() + (deliveryMinutes * 60)
    local orderedAt = os.date("%Y-%m-%d %H:%M:%S")
    local dancerId = NextDancerId()

    local dancerConfig = nil
    for _, dancer in ipairs(Config.Dancers) do
        if dancer.title == dancerTitle then
            dancerConfig = dancer
            break
        end
    end

    if not dancerConfig then
        return false
    end

    if not dancersByHouse[house] then
        dancersByHouse[house] = {}
    end

    local newDancer = {
        id = dancerId,
        title = dancerTitle,
        pedModel = dancerConfig.pedModel,
        anim = dancerConfig.anim,
        time = dancerConfig.time,
        orderedAt = orderedAt,
        status = "pending",
        deliveryTime = deliveryTimestamp,
        house = house,
        coords = nil,
    }

    table.insert(dancersByHouse[house], newDancer)

    SetTimeout(deliveryMinutes * 60 * 1000, function()
        if dancersByHouse[house] then
            for _, dancer in ipairs(dancersByHouse[house]) do
                if dancer.id == dancerId then
                    dancer.status = "delivered"
                    break
                end
            end
        end
        TriggerClientEvent("housing:playDoorbell", -1, house)
    end)

    return true
end

function sv_common:placeDancer(source, dancerId, coords)
    if not dancerId or not coords then
        return false
    end

    local foundDancer = nil
    local foundHouse = nil

    for houseName, dancers in pairs(dancersByHouse) do
        for _, dancer in pairs(dancers) do
            if dancer.id == dancerId then
                if dancer.status == "delivered" then
                    foundDancer = dancer
                    foundHouse = houseName
                    break
                end
            end
        end
        if foundDancer then
            break
        end
    end

    if not foundDancer then
        return false
    end

    foundDancer.coords = coords
    foundDancer.status = "placed"

    if foundDancer.time then
        SetTimeout(foundDancer.time, function()
            if dancersByHouse[foundHouse] then
                for idx, dancer in pairs(dancersByHouse[foundHouse]) do
                    if dancer.id == dancerId then
                        table.remove(dancersByHouse[foundHouse], idx)
                        break
                    end
                end
                if dancersByHouse[foundHouse] then
                    if #dancersByHouse[foundHouse] == 0 then
                        dancersByHouse[foundHouse] = nil
                    end
                end
                TriggerClientEvent("housing:removeDancer", source, foundHouse, dancerId)
            end
        end)
    end

    TriggerClientEvent("housing:spawnDancer", source, foundDancer)
    return true
end

function sv_common:removeDancer(source, dancerId)
    if not dancerId then
        return false
    end

    local foundDancer = nil
    local foundHouse = nil

    for houseName, dancers in pairs(dancersByHouse) do
        for _, dancer in pairs(dancers) do
            if dancer.id == dancerId then
                foundDancer = dancer
                foundHouse = houseName
                break
            end
        end
        if foundDancer then
            break
        end
    end

    if not foundDancer then
        return false
    end

    if foundHouse then
        if dancersByHouse[foundHouse] then
            for idx, dancer in pairs(dancersByHouse[foundHouse]) do
                if dancer.id == dancerId then
                    table.remove(dancersByHouse[foundHouse], idx)
                    break
                end
            end
            if #dancersByHouse[foundHouse] == 0 then
                dancersByHouse[foundHouse] = nil
            end
            TriggerClientEvent("housing:removeDancer", source, foundHouse, dancerId)
        end
    end

    return true
end

lib.callback.register("housing:getDancers", function(source, house)
    if not Config.DancersEnabled then
        return {}
    end
    return sv_common:getDancers(source, house)
end)

lib.callback.register("housing:orderDancer", function(source, house, dancerTitle, price)
    if not Config.DancersEnabled then
        return false
    end
    return sv_common:orderDancer(source, house, dancerTitle, price)
end)

lib.callback.register("housing:placeDancer", function(source, dancerId, coords)
    if not Config.DancersEnabled then
        return false
    end
    return sv_common:placeDancer(source, dancerId, coords)
end)

lib.callback.register("housing:removeDancer", function(source, dancerId)
    if not Config.DancersEnabled then
        return false
    end
    return sv_common:removeDancer(source, dancerId)
end)

-- Delivery system
local deliveriesByHouse = {}
local deliveryIdCounter = 0

local function NextDeliveryId()
    deliveryIdCounter = deliveryIdCounter + 1
    return deliveryIdCounter
end

function sv_common:getDeliveries(source, house)
    if not house then
        return {}
    end

    local houseDeliveries = deliveriesByHouse[house]
    if not houseDeliveries then
        houseDeliveries = {}
    end

    local result = {}
    for _, delivery in ipairs(houseDeliveries) do
        table.insert(result, {
            id = delivery.id,
            title = delivery.title,
            items = delivery.items,
            orderedAt = delivery.orderedAt,
            status = delivery.status,
            deliveryTime = delivery.deliveryTime,
        })
    end
    return result
end

local function GetDeliveryTime(deliveryTitle)
    for _, delivery in ipairs(Config.Deliveries) do
        if delivery.title == deliveryTitle then
            if delivery.deliveryTime then
                if type(delivery.deliveryTime) == "number" then
                    return delivery.deliveryTime
                end
                if type(delivery.deliveryTime) == "table" then
                    if delivery.deliveryTime.min and delivery.deliveryTime.max then
                        return math.random(delivery.deliveryTime.min, delivery.deliveryTime.max)
                    end
                end
            end
            break
        end
    end
    return math.random(5, 10)
end

function sv_common:orderDelivery(source, house, deliveryTitle, price, items)
    if not house or not deliveryTitle or not price or not items then
        return false
    end

    local bankBalance = GetAccountMoney(source, "bank")
    if price > bankBalance then
        return false
    end

    RemoveAccountMoney(source, "bank", price)

    local deliveryMinutes = GetDeliveryTime(deliveryTitle)
    local deliveryTimestamp = os.time() + (deliveryMinutes * 60)
    local orderedAt = os.date("%Y-%m-%d %H:%M:%S")
    local deliveryId = NextDeliveryId()

    if not deliveriesByHouse[house] then
        deliveriesByHouse[house] = {}
    end

    local newDelivery = {
        id = deliveryId,
        title = deliveryTitle,
        items = items,
        orderedAt = orderedAt,
        status = "pending",
        deliveryTime = deliveryTimestamp,
        house = house,
    }

    table.insert(deliveriesByHouse[house], newDelivery)

    SetTimeout(deliveryMinutes * 60 * 1000, function()
        if deliveriesByHouse[house] then
            for _, delivery in ipairs(deliveriesByHouse[house]) do
                if delivery.id == deliveryId then
                    delivery.status = "delivered"
                    break
                end
            end
        end
        TriggerClientEvent("housing:playDoorbell", -1, house)
    end)

    return true
end

function sv_common:collectDelivery(source, deliveryId)
    if not deliveryId then
        return false
    end

    local foundDelivery = nil
    local foundHouse = nil

    for houseName, deliveries in pairs(deliveriesByHouse) do
        for _, delivery in pairs(deliveries) do
            if delivery.id == deliveryId then
                if delivery.status == "delivered" then
                    foundDelivery = delivery
                    foundHouse = houseName
                    break
                end
            end
        end
        if foundDelivery then
            break
        end
    end

    if not foundDelivery then
        return false
    end

    for _, item in pairs(foundDelivery.items) do
        AddItem(source, item, 1)
    end

    if foundHouse then
        if deliveriesByHouse[foundHouse] then
            for idx, delivery in pairs(deliveriesByHouse[foundHouse]) do
                if delivery.id == deliveryId then
                    table.remove(deliveriesByHouse[foundHouse], idx)
                    break
                end
            end
            if #deliveriesByHouse[foundHouse] == 0 then
                deliveriesByHouse[foundHouse] = nil
            end
        end
    end

    return true
end

lib.callback.register("housing:getDeliveries", function(source, house)
    if not Config.DeliveriesEnabled then
        return {}
    end
    return sv_common:getDeliveries(source, house)
end)

lib.callback.register("housing:orderDelivery", function(source, house, deliveryTitle, price, items)
    if not Config.DeliveriesEnabled then
        return false
    end
    return sv_common:orderDelivery(source, house, deliveryTitle, price, items)
end)

lib.callback.register("housing:collectDelivery", function(source, deliveryId)
    if not Config.DeliveriesEnabled then
        return false
    end
    return sv_common:collectDelivery(source, deliveryId)
end)

-- Cooking system
function sv_common:cook(source, recipeName)
    local playerId = source

    if not Config.CookingRecipes then
        Notification(playerId, i18n.t("cooking.no_recipes") or "No recipes available", "error")
        return false
    end

    local recipe = table.find(Config.CookingRecipes, function(r)
        return r.title == recipeName
    end)

    if not recipe then
        Notification(playerId, i18n.t("cooking.recipe_not_found") or "Recipe not found", "error")
        return false
    end

    local playerData = GetPlayerFromId(playerId)
    if not playerData then
        return false
    end

    local playerItems = GetItems(playerData)
    if not playerItems then
        return false
    end

    for ingredientName, requiredAmount in pairs(recipe.ingredients) do
        local playerHas = 0
        for _, item in pairs(playerItems) do
            if item.name == ingredientName then
                playerHas = item.count or item.amount or 0
                break
            end
        end

        if requiredAmount > playerHas then
            local message = i18n.t("cooking.missing_ingredient", { item = ingredientName, amount = requiredAmount })
            if not message then
                message = string.format("You need %d %s", requiredAmount, ingredientName)
            end
            Notification(playerId, message, "error")
            return false
        end
    end

    for ingredientName, requiredAmount in pairs(recipe.ingredients) do
        RemoveItem(playerId, ingredientName, requiredAmount)
    end

    TriggerClientEvent("housing:startCooking", playerId, recipe)
    return true
end

function sv_common:finishCooking(source, recipeName)
    local playerId = source

    if not Config.CookingRecipes then
        return
    end

    local recipe = table.find(Config.CookingRecipes, function(r)
        return r.title == recipeName
    end)

    if not recipe then
        return
    end

    for itemName, amount in pairs(recipe.rewards) do
        AddItem(playerId, itemName, amount)
    end

    local message = i18n.t("cooking.cooked", { item = recipeName })
    if not message then
        message = string.format("You cooked %s!", recipeName)
    end
    Notification(playerId, message, "success")
end

lib.callback.register("housing:cook", function(source, recipeName)
    return sv_common:cook(source, recipeName)
end)

RegisterNetEvent("housing:finishCooking", function(recipeName)
    local src = source
    sv_common:finishCooking(src, recipeName)
end)

-- Robbery / Stolen furniture system
function sv_common:getStolenFurniture(source)
    local playerId = source
    local identifier = GetIdentifier(playerId)

    if not identifier then
        return {}
    end

    local rows = MySQL.query.await(
        "SELECT * FROM house_stolen_furniture WHERE identifier = ?",
        { identifier }
    )

    if not rows then
        return {}
    end

    for i = 1, #rows do
        local originalPrice = 0

        if Config.Furniture then
            for categoryKey, category in pairs(Config.Furniture) do
                if categoryKey ~= "navigation" then
                    if category.items then
                        for _, item in pairs(category.items) do
                            if item.object == rows[i].model_name then
                                originalPrice = item.price or 0
                                break
                            end
                            if item.colors then
                                for _, colorVariant in pairs(item.colors) do
                                    if colorVariant.object == rows[i].model_name then
                                        originalPrice = item.price or 0
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        rows[i].price = originalPrice
        rows[i].sellPrice = math.floor(originalPrice * (Config.Robbery.sell.price or 0.1))
    end

    return rows
end

function sv_common:sellFurniture(source, furnitureId)
    local playerId = source
    local identifier = GetIdentifier(playerId)

    if not furnitureId then
        return false
    end

    local row = MySQL.single.await(
        "SELECT * FROM house_stolen_furniture WHERE id = ? AND identifier = ?",
        { furnitureId, identifier }
    )

    if not row then
        Notification(playerId, i18n.t("robbery.furniture_not_found") or "Furniture not found", "error")
        return false
    end

    local originalPrice = 0
    if Config.Furniture then
        for categoryKey, category in pairs(Config.Furniture) do
            if categoryKey ~= "navigation" then
                if category.items then
                    for _, item in pairs(category.items) do
                        if item.object == row.model_name then
                            originalPrice = item.price or 0
                            break
                        end
                        if item.colors then
                            for _, colorVariant in pairs(item.colors) do
                                if colorVariant.object == row.model_name then
                                    originalPrice = item.price or 0
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    local sellPrice = math.floor(originalPrice * (Config.Robbery.sell.price or 0.1))

    AddAccountMoney(playerId, "money", sellPrice)
    MySQL.update.await("DELETE FROM house_stolen_furniture WHERE id = ?", { furnitureId })

    local message = i18n.t("robbery.furniture_sold", { price = sellPrice })
    if not message then
        message = string.format("Furniture sold for $%d", sellPrice)
    end
    Notification(playerId, message, "success")

    return true
end

function sv_common:stealFurniture(source, house, decorationId, decorationData)
    local playerId = source
    local identifier = GetIdentifier(playerId)

    if not house or not decorationId or not decorationData then
        return
    end

    MySQL.update.await(
        "DELETE FROM house_decorations WHERE id = ? AND house = ?",
        { decorationId, house }
    )

    ClearHouseDecoration(house)

    MySQL.insert.await(
        "INSERT INTO house_stolen_furniture (identifier, house, model_name, stolen_at) VALUES (?, ?, ?, ?)",
        { identifier, house, decorationData.modelName, os.date("%Y-%m-%d %H:%M:%S") }
    )

    TriggerClientEvent("housing:removeFurniture", -1, house, decorationId)
    Notification(playerId, i18n.t("robbery.furniture_stolen") or "Furniture stolen!", "success")
end

lib.callback.register("housing:robbery:getStolenFurniture", function(source)
    return sv_common:getStolenFurniture(source)
end)

RegisterNetEvent("housing:robbery:sellFurniture", function(furnitureId)
    local src = source
    sv_common:sellFurniture(src, furnitureId)
end)

RegisterNetEvent("housing:robbery:stealFurniture", function(house, decorationId, decorationData)
    local src = source
    sv_common:stealFurniture(src, house, decorationId, decorationData)
end)
