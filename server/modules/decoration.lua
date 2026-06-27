local decorationCache = {}
local decorationUsedBy = {}
local WALLART_LIMIT = 6

local function FindFurnitureConfig(modelName)
    for _, category in pairs(Config.Furniture) do
        if type(category) == "table" then
            if category.items then
                for _, item in pairs(category.items) do
                    if item.object == modelName then
                        return item
                    end
                    if item.colors then
                        for _, colorVariant in pairs(item.colors) do
                            if colorVariant.object == modelName then
                                return colorVariant
                            end
                        end
                    end
                end
            end
        end
    end
end

local function IsWallart(modelName)
    local furnitureItem = FindFurnitureConfig(modelName)
    if furnitureItem then
        if furnitureItem.type == "wallart" then
            return true, furnitureItem.wallart
        end
    end
    return false, nil
end

local function GetCachedDecorations(house)
    if not decorationCache[house] then
        local objects = db.getObjects(house)
        if not objects then
            objects = {}
        end
        decorationCache[house] = objects
    end
    return decorationCache[house]
end

local function CountWallart(house)
    local decorations = GetCachedDecorations(house)
    local count = 0
    for i = 1, #decorations do
        local isWall = IsWallart(decorations[i].modelName)
        if isWall then
            count = count + 1
        end
    end
    return count
end

local function SaveObject(playerId, house, objectData)
    local houseConfig = Config.Houses[house]
    if not houseConfig then
        if playerId > 0 then
            Notification(playerId, i18n.t("decorate.invalid_data"), "error")
        end
        return false
    end

    local isWall, wallartConfig = IsWallart(objectData.modelName)
    if isWall then
        local hasWallartUpgrade = table.includes(houseConfig.upgrades or {}, "wallart")
        if not hasWallartUpgrade then
            if playerId > 0 then
                Notification(playerId, i18n.t("decorate.wallart_upgrade_required"), "error")
            end
            return false
        end

        local wallartCount = CountWallart(house)
        if wallartCount >= WALLART_LIMIT then
            if playerId > 0 then
                Notification(playerId, i18n.t("decorate.wallart_limit_reached", { limit = WALLART_LIMIT }), "error")
            end
            return false
        end

        local wallartData = objectData.wallartData or {}
        objectData.wallartData = wallartData

        local url
        if type(objectData.wallartData.url) == "string" then
            url = objectData.wallartData.url:match("^%s*(.-)%s*$")
        end
        if not url then
            if wallartConfig and wallartConfig.defaultUrl then
                url = wallartConfig.defaultUrl
            else
                url = ""
            end
        end
        objectData.wallartData.url = url

        local textureName
        if wallartConfig and wallartConfig.textureName then
            textureName = wallartConfig.textureName
        else
            textureName = objectData.wallartData.textureName
        end
        objectData.wallartData.textureName = textureName

        local textureDict
        if wallartConfig and wallartConfig.textureDict then
            textureDict = wallartConfig.textureDict
        else
            textureDict = objectData.wallartData.textureDict
        end
        objectData.wallartData.textureDict = textureDict
    else
        objectData.wallartData = nil
    end

    local identifier
    if playerId == 0 then
        identifier = "server"
    else
        identifier = tostring(GetIdentifier(playerId) or "")
    end

    objectData.created = os.time()

    local insertedId = db.saveObject(identifier, objectData)
    objectData.id = insertedId

    decorationCache[house] = decorationCache[house] or {}
    decorationCache[house][#decorationCache[house] + 1] = objectData

    TriggerClientEvent("housing:addObject", -1, house, objectData)
    Debug("housing:saveObject", "Saved", house, "Id", insertedId, "Data", objectData)
    return true
end

function addDecorationBatchToHouse(playerId, house, objects)
    if not objects or #objects == 0 then
        return false, {}
    end

    local identifier
    if playerId == 0 then
        identifier = "server"
    else
        identifier = tostring(GetIdentifier(playerId) or "")
    end

    local createdTime = os.time()
    local createdSql = os.date("%Y-%m-%d %H:%M:%S")

    local preparedObjects = {}
    for i = 1, #objects do
        local obj = objects[i]
        local prepared = {}
        prepared.modelName = obj.modelName
        prepared.coords = obj.coords or vec3(0.0, 0.0, 0.0)
        prepared.rotation = obj.rotation or vec3(0.0, 0.0, 0.0)
        prepared.inStash = false ~= obj.inStash
        prepared.inHouse = true == obj.inHouse
        prepared.house = house
        prepared.lightData = obj.lightData
        prepared.price = obj.price
        prepared.created = createdTime
        prepared.createdSql = createdSql
        preparedObjects[#preparedObjects + 1] = prepared
    end

    local insertedIds = db.saveObjectsBatch(identifier, preparedObjects)
    if not insertedIds or #insertedIds == 0 then
        return false, {}
    end

    local cachedObjects = decorationCache[house] or {}
    decorationCache[house] = cachedObjects

    local freshObjects = db.getObjects(house) or {}

    local existingIds = {}
    for i = 1, #cachedObjects do
        if cachedObjects[i] and cachedObjects[i].id then
            existingIds[cachedObjects[i].id] = true
        end
    end

    local newObjects = {}
    for i = 1, #freshObjects do
        local obj = freshObjects[i]
        if obj and obj.id then
            if not existingIds[obj.id] then
                cachedObjects[#cachedObjects + 1] = obj
                TriggerClientEvent("housing:addObject", -1, house, obj)
                existingIds[obj.id] = true
                newObjects[#newObjects + 1] = obj
            end
        end
    end

    Debug("housing:addDecorationBatchToHouse", "Saved", house, "Count", #newObjects)
    return true, newObjects
end

lib.callback.register("housing:saveObject", function(source, house, objectData)
    return SaveObject(source, house, objectData)
end)

exports("addDecorationToHouse", function(house, objectData)
    return SaveObject(0, house, objectData)
end)

exports("addDecorationBatchToHouse", function(house, objects)
    return addDecorationBatchToHouse(0, house, objects)
end)

local ALLOWED_UPDATE_FIELDS = {
    coords = true,
    rotation = true,
    inStash = true,
    lightData = true,
    wallartData = true,
}

RegisterNetEvent("housing:updateObject", function(house, objectId, updates)
    local src = source

    if not updates then
        return Notification(src, i18n.t("decorate.invalid_data"), "error")
    end

    local invalidField = table.find(updates, function(_, key)
        return not ALLOWED_UPDATE_FIELDS[key]
    end)

    if invalidField then
        Notification(src, i18n.t("decorate.invalid_data"), "error")
        Debug("unsecured", invalidField)
        return Debug("housing:updateObject", "User trying to exploit update profile event", src, updates)
    end

    local cachedObject = table.find(decorationCache[house], function(obj)
        return obj.id == objectId
    end)

    if not cachedObject then
        return Notification(src, i18n.t("decorate.invalid_object"), "error")
    end

    local success = db.updateObject(objectId, updates)
    if not success then
        Notification(src, i18n.t("decorate.failed_update"), "error")
        return
    end

    for key, value in pairs(updates) do
        if value then
            if type(value) == "string" and (key == "coords" or key == "rotation" or key == "lightData" or key == "wallartData") then
                Debug("housing:updateObject", "Decoding", key, value)
                updates[key] = json.decode(value)
            end
        end
        cachedObject[key] = updates[key]
    end

    TriggerClientEvent("housing:updateObject", -1, house, objectId, updates)
    Debug("housing:updateObject", "Updated", house, "Id", objectId, "data", updates)
end)

local function GetFurniturePrice(modelName)
    for categoryKey, category in pairs(Config.Furniture) do
        if categoryKey ~= "navigation" then
            for _, item in pairs(category.items) do
                if item.object == modelName then
                    return item.price
                end
                if item.colors then
                    for _, colorVariant in pairs(item.colors) do
                        if colorVariant.object == modelName then
                            return colorVariant.price
                        end
                    end
                end
            end
        end
    end
end

RegisterNetEvent("housing:decorate:sellFurniture", function(house, objectId)
    local src = source

    local cachedObject = table.find(decorationCache[house], function(obj)
        return obj.id == objectId
    end)

    if not cachedObject then
        return Notification(src, i18n.t("decorate.invalid_object"), "error")
    end

    local deleted = db.deleteObject(objectId)
    if not deleted then
        Notification(src, i18n.t("decorate.failed_sell"), "error")
        return
    end

    local price = cachedObject.price
    if not price then
        price = GetFurniturePrice(cachedObject.modelName)
    end

    local sellPrice = price * Config.SellObjectCommision

    AddAccountMoney(src, Config.MoneyType, sellPrice)

    decorationCache[house] = table.filter(decorationCache[house], function(obj)
        return obj.id ~= objectId
    end)

    TriggerClientEvent("housing:decorate:sellFurniture", -1, house, objectId)
    Notification(src, i18n.t("decorate.sold_furniture", { price = sellPrice }), "success")

    SendLog(DiscordWebhook, {
        title = "Housing",
        description = "Player sold a furniture",
        fields = {
            { name = "Player", value = GetPlayerName(src), inline = true },
            { name = "House", value = house, inline = true },
            { name = "Model", value = cachedObject.modelName, inline = true },
            { name = "Price", value = tostring(sellPrice), inline = true },
        },
        color = WebhookColor,
    })
end)

local function LoadDecorations(house)
    if not decorationCache[house] then
        local objects = db.getObjects(house)
        decorationCache[house] = objects or {}
    end

    for key, value in pairs(decorationCache) do
        if key == "coords" then
            if type(value) == "string" then
                decorationCache[key] = json.decode(value)
                Error("If you see this error please report this ERROR TO THE QUASAR. It will not affect the server but it will help us to improve the script. Thank you!")
            end
        elseif key == "rotation" then
            if type(value) == "string" then
                decorationCache[key] = json.decode(value)
                Error("If you see this error please report this ERROR TO THE QUASAR. It will not affect the server but it will help us to improve the script. Thank you!")
            end
        elseif key == "lightData" then
            if type(value) == "string" then
                decorationCache[key] = json.decode(value)
                Error("If you see this error please report this ERROR TO THE QUASAR. It will not affect the server but it will help us to improve the script. Thank you!")
            end
        elseif key == "wallartData" then
            if type(value) == "string" then
                decorationCache[key] = json.decode(value)
                Error("If you see this error please report this ERROR TO THE QUASAR. It will not affect the server but it will help us to improve the script. Thank you!")
            end
        end
    end

    return decorationCache[house] or {}
end

function ClearHouseDecoration(house)
    decorationCache[house] = nil
    Debug("ClearHouseDecoration", house)
end

lib.callback.register("housing:getDecorations", function(source, house)
    local decorations = LoadDecorations(house)
    return decorations or {}
end)

lib.callback.register("housing:buyDecorationObject", function(source, price)
    local balance = GetAccountMoney(source, Config.MoneyType)

    if price <= balance then
        RemoveAccountMoney(source, Config.MoneyType, price)

        local resourceState = GetResourceState("qs-inventory")
        if resourceState:find("started") then
            if Config.EnableQuests then
                local questResult = exports["qs-inventory"]:UpdateQuestProgress(source, "buy_furniture", 10)
                if questResult then
                    Debug("Quest \"buy_furniture\" progress updated")
                else
                    Debug("Failed to update quest \"buy_furniture\"")
                end
            end
        end

        return true
    end

    return false
end)

RegisterCommand("revert_decorations", function(source, args)
    if source ~= 0 then
        return Error("This command can only be executed from the server console.")
    end
    db.revertDecorations()
end)

lib.callback.register("housing:decorate:getDecorationAvailable", function(source, house)
    local usedBy = decorationUsedBy[house]
    Debug("housing:decorate:getDecorationAvailable", house, "UsedBy", usedBy)
    return usedBy or true
end)

RegisterNetEvent("housing:decorate:updateDecorationUsedBy", function(house, isUsing)
    local src = source
    local value
    if isUsing and src then
        value = src
    else
        value = nil
    end
    decorationUsedBy[house] = value
    Debug("housing:decorate:updateDecorationUsedBy", house, "UsedBy", isUsing)
end)

AddEventHandler("playerDropped", function()
    local src = source
    for house, playerId in pairs(decorationUsedBy) do
        if playerId == src then
            decorationUsedBy[house] = nil
        end
    end
end)
