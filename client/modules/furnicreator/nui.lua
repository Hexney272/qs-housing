local function isObjectValid(item, categoryName)
    Debug("isObjectValid", item, categoryName)

    local objectHash = joaat(item.object)

    if not IsModelValid(objectHash) then
        Notification(i18n.t("furniture_creator.object_is_not_valid", { object = item.object }), "error")
        return false
    end

    if categoryName then
        local category = Config.Furniture[categoryName]
        if category then
            local existingItem = table.find(Config.Furniture[categoryName].items, function(existing)
                return existing.object == item.object
            end)

            if existingItem then
                if existingItem.id ~= item.id then
                    Notification(i18n.t("furniture_creator.object_already_in_category", {
                        object = item.object,
                        category = categoryName
                    }), "error")
                    return false
                end
            end
        end
    end

    return true
end

RegisterNUICallback("create_furniture_item", function(data, cb)
    if not isObjectValid(data.item, data.category) then
        return cb(false)
    end

    Debug("create_furniture_item", data)

    local success = lib.callback.await("housing:createFurnitureItem", false, data)

    if success then
        Notification(i18n.t("furniture_creator.item_created"), "success")
    else
        Notification(i18n.t("furniture_creator.item_create_failed"), "error")
    end

    cb(success)
end)

RegisterNUICallback("update_furniture_item", function(data, cb)
    if not isObjectValid(data.item, data.category) then
        return cb(false)
    end

    Debug("update_furniture_item", data)

    local success = lib.callback.await("housing:updateFurnitureItem", false, data)

    if success then
        Notification(i18n.t("furniture_creator.item_updated"), "success")
    else
        Notification(i18n.t("furniture_creator.item_update_failed"), "error")
    end

    cb(success)
end)

RegisterNUICallback("remove_furniture_item", function(data, cb)
    Debug("remove_furniture_item", data)

    if not data.id then
        Notification(i18n.t("furniture_creator.cannot_delete_config_item"), "error")
        return cb(false)
    end

    local success = lib.callback.await("housing:removeFurnitureItem", false, data)

    if success then
        Notification(i18n.t("furniture_creator.item_removed"), "success")
        furnitureCreator:updateUI()
    else
        Notification(i18n.t("furniture_creator.item_remove_failed"), "error")
    end

    cb(success)
end)

RegisterNetEvent("housing:syncFurnitureItem", function(action, categoryName, itemData)
    local debugObject = itemData.object or itemData
    Debug("housing:syncFurnitureItem", action, categoryName, debugObject)

    if action == "create" then
        local category = Config.Furniture[categoryName]
        if not category then
            Error("housing:syncFurnitureItem", "Category not found", categoryName)
            return
        end
        table.insert(Config.Furniture[categoryName].items, itemData)

    elseif action == "update" then
        local category = Config.Furniture[categoryName]
        if category then
            for index, existingItem in pairs(Config.Furniture[categoryName].items) do
                if existingItem.id == itemData.id then
                    Config.Furniture[categoryName].items[index] = itemData
                    break
                end
            end
        end

    elseif action == "delete" then
        local category = Config.Furniture[categoryName]
        if category then
            Config.Furniture[categoryName].items = table.filter(Config.Furniture[categoryName].items, function(existingItem)
                return existingItem.id ~= itemData.id
            end)
        end
    end

    furnitureCreator:updateUI()
    InitializeFurnitures()

    Debug("Config.Furniture updated:", action, categoryName, itemData.object or itemData)
end)

RegisterNUICallback("furniture_take_screenshot", function(objectName, cb)
    if not objectName then
        Notification(i18n.t("furniture_creator.object_required"), "error")
        furnitureCreator:open()
        return cb(nil)
    end

    local objectHash = joaat(objectName)

    if not IsModelValid(objectHash) then
        Notification(i18n.t("furniture_creator.object_is_not_valid", { object = objectName }), "error")
        furnitureCreator:open()
        return cb(nil)
    end

    local screenshotUrl = furnitureCreator:takeObjectScreenshot(objectName)
    furnitureCreator:open()
    cb(screenshotUrl)
end)
