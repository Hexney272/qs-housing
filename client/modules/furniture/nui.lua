RegisterNUICallback("toggle_hide_decorate", function(data, cb)
    decorate:toggleHideDecorate()
    cb("ok")
end)

RegisterNUICallback("spawn_object", function(data, cb)
    if not decorate.active then
        return cb("ok")
    end

    decorate:removeCurrentObject()

    if IsOnlyInsideModel(data.modelName) then
        if not EnteredHouse then
            Notification(i18n.t("decorate.only_inside_purchase"), "error")
            return cb("ok")
        end
    end

    local lightItem = table.find(LIGHT_ITEMS, function(item)
        return item.object == data.modelName
    end)

    local camCoords = decorate:getCamCoords()
    local camRot = decorate:getCamRot()
    local forwardVector = Utils.GetForwardVector(camRot)
    local spawnPos = camCoords + forwardVector * 5.0

    local handle = SpawnObject(data.modelName, spawnPos, vec3(0.0, 0.0, 0.0))
    cb(handle)

    if not handle then
        return Notification("Object is not spawned", "error")
    end

    decorate.currentObject = {
        modelName = data.modelName,
        handle = handle,
        price = data.price
    }

    Debug("Spawned object", "decorate.currentObject", decorate.currentObject)

    if not lightItem then return end

    while true do
        local currentObj = decorate.currentObject
        if not currentObj or not currentObj.handle then break end

        Wait(0)

        local rotation = GetEntityRotation(currentObj.handle)
        local coords = GetEntityCoords(currentObj.handle)
        local direction = RotationToDirection(rotation)

        DrawSpotLight(
            coords.x, coords.y, coords.z,
            direction.x, direction.y, direction.z,
            255, 255, 255,
            100.0, 20.0, 1.0,
            Config.DefaultLightIntensity, 0.0
        )
    end
end)

RegisterNUICallback("place_object_on_ground", function(data, cb)
    local currentObj = decorate.currentObject
    if not currentObj or not currentObj.handle then
        return cb("ok")
    end

    decorate:placeObjectOnGround()
    cb("ok")
end)

RegisterNUICallback("set_current_page", function(data, cb)
    decorate.currentPage = data
    cb("ok")
end)

RegisterNUICallback("toggle_cursor", function(data, cb)
    decorate:setFocus()
    cb("ok")
end)

RegisterNUICallback("save_locations", function(data, cb)
    decorate:saveObjects()
    cb("ok")
end)

RegisterNUICallback("sell_current_object", function(data, cb)
    local stashId = decorate.currentObject and decorate.currentObject.stashId
    if not stashId then
        Error("sell_current_object", "Selected object id is nil", decorate.currentObject and decorate.currentObject.stashId)
        return
    end

    local objectData = table.find(decorate.objects, function(obj)
        return obj.id == decorate.currentObject.stashId
    end)

    if not objectData then
        Error("sell_current_object", "Object not found", decorate.currentObject.stashId)
        return
    end

    TriggerServerEvent("housing:decorate:sellFurniture", CurrentHouse, decorate.currentObject.stashId)
    decorate:removeCurrentObject()
    cb("ok")
end)

RegisterNUICallback("update_stash", function(data, cb)
    local objectId = data.id
    if not objectId then
        objectId = decorate.currentObject and decorate.currentObject.stashId
    end

    if not objectId then
        Error("update_stash", "Selected object id is nil", decorate.currentObject and decorate.currentObject.stashId)
        return cb("ok")
    end

    data.id = nil

    if data.wallartData then
        if type(data.wallartData.url) == "string" then
            data.wallartData.url = data.wallartData.url:match("^%s*(.-)%s*$")
        end
    end

    local objectEntry = table.find(decorate.objects, function(obj)
        return obj.id == objectId
    end)

    if objectEntry then
        for key, value in pairs(data) do
            objectEntry[key] = value
        end
        if data.wallartData then
            if objectEntry.spawned then
                decorate:applyWallartTexture(objectEntry)
            end
        end
    end

    if decorate.currentObject then
        if decorate.currentObject.stashId == objectId then
            for key, value in pairs(data) do
                decorate.currentObject[key] = value
            end
        end
    end

    TriggerServerEvent("housing:updateObject", CurrentHouse, objectId, data)
    cb("ok")
end)

local function isWallartModel(modelName)
    local furnitureData = Config.DynamicFurnitures[modelName]
    if furnitureData then
        return furnitureData.type == "wallart"
    end
    return false
end

local function countWallartObjects()
    local count = 0
    for i = 1, #decorate.objects do
        if isWallartModel(decorate.objects[i].modelName) then
            count = count + 1
        end
    end
    return count
end

RegisterNUICallback("buy_object", function(data, cb)
    if not decorate.currentObject then
        Error("buy_object", "Current object is nil", decorate.currentObject)
        return cb("ok")
    end

    if IsOnlyInsideModel(decorate.currentObject.modelName) then
        if not EnteredHouse then
            Notification(i18n.t("decorate.only_inside_purchase"), "error")
            return cb("ok")
        end
    end

    local houseConfig = Config.Houses[CurrentHouse]
    if not houseConfig then
        Debug("buy_object", "House data not found", CurrentHouse)
        return cb("ok")
    end

    local modelName = decorate.currentObject.modelName
    local dynamicData = Config.DynamicFurnitures[modelName]
    local isWallart = false
    if dynamicData then
        isWallart = dynamicData.type == "wallart"
    end

    if isWallart then
        local hasWallartUpgrade = table.includes(houseConfig.upgrades or {}, "wallart")
        if not hasWallartUpgrade then
            cb("ok")
            return Notification(i18n.t("decorate.wallart_upgrade_required"), "error")
        end
    end

    local hasFurnitureUpgrade = table.includes(houseConfig.upgrades or {}, "furniture")
    if hasFurnitureUpgrade then
        local objectCount = #decorate.objects
        if objectCount >= Config.FurnitureLimits.upgrade then
            cb("ok")
            return Notification("You have reached the maximum number of furniture items", "error")
        end
    elseif not hasFurnitureUpgrade then
        local objectCount = #decorate.objects
        if objectCount >= Config.FurnitureLimits.normal then
            cb("ok")
            return Notification("You have reached the maximum number of furniture items. You can upgrade your property to increase the limit.", "error")
        end
    end

    if isWallart then
        local wallartCount = countWallartObjects()
        if wallartCount >= 6 then
            cb("ok")
            return Notification(i18n.t("decorate.wallart_limit_reached", { limit = 6 }), "error")
        end
    end

    if isWallart then
        local wallartConfig = dynamicData.wallart
        if wallartConfig then
            decorate.currentObject.wallartData = {
                url = wallartConfig.defaultUrl or "",
                textureName = wallartConfig.textureName,
                textureDict = wallartConfig.textureDict
            }
        end
    end

    Debug("buy_object", "Current object", decorate.currentObject)

    local purchaseResult = lib.callback.await("housing:buyDecorationObject", false, decorate.currentObject.price)
    if not purchaseResult then
        decorate:removeCurrentObject()
        cb("ok")
        return
    end

    decorate:saveCurrentObject()
    cb("ok")
end)

RegisterNUICallback("get_owned_objects", function(data, cb)
    cb(decorate.objects)
end)

RegisterNUICallback("select_owned_object", function(data, cb)
    local objectData = table.find(decorate.objects, function(obj)
        return obj.id == data
    end)

    if not objectData then
        Error("select_owned_object", "Object not found", data)
        return
    end

    decorate.currentObject = {
        handle = objectData.handle,
        modelName = objectData.modelName,
        stashId = objectData.id,
        wallartData = objectData.wallartData
    }

    Debug("Selected object", "data", objectData, "objectData", objectData)
    cb(true)
end)

RegisterNUICallback("deselect_owned_object", function(data, cb)
    decorate:removeCurrentObject()
    decorate:refreshObjects()
    cb(true)
end)

RegisterNUICallback("remove_current_object", function(data, cb)
    decorate:removeCurrentObject()
    cb("ok")
end)

local cameraSpeedKeyMap = {
    x = "lookSpeedX",
    y = "lookSpeedY",
    speed = "moveSpeed"
}

RegisterNUICallback("updateCameraSpeed", function(data, cb)
    local optionKey = cameraSpeedKeyMap[data.type]
    CameraOptions[optionKey] = data.value
end)

RegisterNUICallback("toggle_gizmo_mode", function(data, cb)
    decorate:toggleGizmoMode()
    cb("ok")
end)

RegisterNUICallback("toggle_free_camera", function(data, cb)
    decorate:toggleFreeCamera()
    cb("ok")
end)

RegisterNUICallback("open_buy_object_modal", function(data, cb)
    decorate:openBuyObjectModal()
    cb("ok")
end)
