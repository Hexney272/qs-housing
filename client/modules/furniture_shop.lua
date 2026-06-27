local currentCamera = nil
local previewObject = nil
local currentObjectData = nil
local selectedHouse = nil
local currentShopData = nil
local shopActive = false
local blips = {}

local function RefreshBlips()
    for _, blip in pairs(blips) do
        RemoveBlip(blip)
    end
    blips = {}

    for _, shop in pairs(Config.FurnitureShops) do
        if shop.blip and shop.blip.active then
            local blipData = shop.blip
            local newBlip = Utils.CreateBlip({
                location = shop.enter,
                sprite = blipData.sprite,
                color = blipData.color,
                label = blipData.label,
                scale = blipData.scale,
                text = blipData.label,
                shortRange = true,
            })
            blips[#blips + 1] = newBlip
        end
    end
end

CreateThread(function()
    RefreshBlips()
end)

RegisterNetEvent("housing:syncFurnitureShops", function(shops)
    Config.FurnitureShops = shops or {}
    RefreshBlips()
    Debug("housing:syncFurnitureShops", "Synced", #Config.FurnitureShops, "shops")
end)

local function CloseShop()
    if previewObject then
        DeleteObject(previewObject)
        previewObject = nil
    end

    if currentCamera then
        RenderScriptCams(false, false, 0, true, true)
        SetCamActive(currentCamera, false)
        DestroyCam(currentCamera, false)
        currentCamera = nil
    end

    currentObjectData = nil
    selectedHouse = nil
    currentShopData = nil
    shopActive = false
    ToggleHud(true)
    SetNuiFocus(false, false)
end

local function OpenShop(shopData)
    local playerHouses = TriggerServerCallbackSync("qb-houses:server:getPlayerHouses")

    if not playerHouses or #playerHouses == 0 then
        Notification(i18n.t("creator.left_panel.no_houses_found"), "error")
        return
    end

    local ownedHouse = table.find(playerHouses, function(house)
        return house.owner == GetIdentifier()
    end)

    if not ownedHouse then
        Notification(i18n.t("creator.left_panel.no_houses_found"), "error")
        return
    end

    currentShopData = shopData
    shopActive = true

    local houseOptions = {}
    for _, house in pairs(playerHouses) do
        if house.owner == GetIdentifier() then
            local houseConfig = Config.Houses[house.house]
            table.insert(houseOptions, {
                label = houseConfig.address,
                description = houseConfig.address,
                name = house.house,
            })
        end
    end

    if #houseOptions == 0 then
        Notification(i18n.t("creator.left_panel.no_houses_found"), "error")
        CloseShop()
        return
    end

    if houseOptions[1] and houseOptions[1].name then
        selectedHouse = houseOptions[1].name
    else
        selectedHouse = nil
    end

    local categories = {}
    for _, categoryName in pairs(shopData.categories) do
        local furnitureCategory = Config.Furniture[categoryName]
        if furnitureCategory then
            categories[categoryName] = {
                label = furnitureCategory.label,
                img = furnitureCategory.img,
                items = furnitureCategory.items,
            }
        end
    end

    ToggleHud(false)
    SetNuiFocus(true, true)
    SendReactMessage("toggle_furniture_shop", {
        visible = true,
        shopName = shopData.name,
        categories = categories,
        houses = houseOptions,
        selectedHouse = selectedHouse,
    })
end

RegisterNUICallback("furniture_shop:close", function(data, cb)
    CloseShop()
    SendReactMessage("toggle_furniture_shop", { visible = false })
    cb("ok")
end)

RegisterNUICallback("furniture_shop:select_item", function(data, cb)
    if not shopActive or not currentShopData then
        return cb("ok")
    end

    local category = data.category
    local itemIndex = data.itemIndex
    local colorObject = data.colorObject

    if not Config.Furniture[category] or not Config.Furniture[category].items[itemIndex] then
        return cb("ok")
    end

    local item = Config.Furniture[category].items[itemIndex]

    if colorObject then
        if item.colors then
            local colorVariant = table.find(item.colors, function(color)
                return color.object == colorObject
            end)

            if colorVariant then
                currentObjectData = {
                    object = colorVariant.object,
                    label = colorVariant.label,
                    price = colorVariant.price,
                    description = item.description,
                    img = item.img,
                    type = colorVariant.type or item.type,
                    stash = colorVariant.stash or item.stash,
                    offset = colorVariant.offset or item.offset,
                    colorlabel = colorVariant.label,
                }
            else
                if item.object == colorObject then
                    currentObjectData = item
                else
                    currentObjectData = item
                end
            end
        end
    else
        currentObjectData = item
    end

    cb("ok")
end)

RegisterNUICallback("furniture_shop:select_house", function(data, cb)
    if not shopActive then
        return cb("ok")
    end

    selectedHouse = data.houseName
    cb("ok")
end)

RegisterNUICallback("furniture_shop:buy_item", function(data, cb)
    if not shopActive or not currentObjectData or not selectedHouse then
        Debug("furniture_shop:buy_item", "Not shop active or current object data or selected house", shopActive, currentObjectData, selectedHouse)
        return cb(false)
    end

    local modelName
    if data and data.colorObject then
        modelName = data.colorObject
    else
        modelName = currentObjectData.object
    end

    local price = currentObjectData.price

    if IsOnlyInsideModel(modelName) then
        if not EnteredHouse then
            Notification(i18n.t("decorate.only_inside_purchase"), "error")
            return cb(false)
        end
    end

    local success = lib.callback.await("housing:createFurnitureOrder", 0, selectedHouse, {
        modelName = modelName,
        price = price,
    })

    if not success then
        Notification(i18n.t("no_money", { price = price }), "error")
        return cb(false)
    end

    Notification(i18n.t("furniture_shop.item_purchased"), "success")
    cb(true)
end)

local enterShopText = i18n.t("drawtext.enter_furniture_shop")

CreateThread(function()
    while true do
        local sleepTime = 1250
        local playerCoords = GetEntityCoords(cache.ped)

        for _, shop in pairs(Config.FurnitureShops) do
            local distance = #(playerCoords - shop.enter)
            if distance < 2.0 then
                sleepTime = 0
                DrawText3D(shop.enter.x, shop.enter.y, shop.enter.z, enterShopText, "open_ikea", "E")

                if IsControlJustPressed(0, Keys.E) then
                    OpenShop(shop)
                end
            end
        end

        Wait(sleepTime)
    end
end)
