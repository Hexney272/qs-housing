local playerCooldowns = {}

local function GetPhoneHousingSettings()
    local phoneConfig = Config.PhoneHousing
    if not phoneConfig then
        phoneConfig = {}
    end

    local settings = {}
    settings.requireProximityForPurchase = false ~= phoneConfig.requireProximityForPurchase

    local maxDistance = tonumber(phoneConfig.purchaseMaxDistance)
    if not maxDistance then
        maxDistance = 48.0
    end
    settings.purchaseMaxDistance = maxDistance

    local cooldown = math.max(0, tonumber(phoneConfig.actionCooldownSeconds) or 2)
    settings.actionCooldownSeconds = cooldown

    return settings
end


local function CheckCooldown(playerSource)
    local settings = GetPhoneHousingSettings()
    local cooldownSeconds = settings.actionCooldownSeconds

    if cooldownSeconds <= 0 then
        return true
    end

    local now = os.time()
    local lastAction = playerCooldowns[playerSource]

    if lastAction then
        local elapsed = now - lastAction
        if cooldownSeconds > elapsed then
            return false
        end
    end

    playerCooldowns[playerSource] = now
    return true
end


local function HasHouseAccess(playerSource, houseName)
    if type(houseName) ~= "string" or houseName == "" then
        return false
    end

    local identifier = GetIdentifier(playerSource)
    if not identifier then
        return false
    end

    if CheckHasKey(identifier, identifier, houseName, playerSource) then
        return true
    end

    if OfficialHouseOwnerList[houseName] == identifier then
        return true
    end

    local result = MySQL.single.await("SELECT citizenid, rented FROM player_houses WHERE house = ? LIMIT 1", { houseName })
    if result then
        if tonumber(result.rented) == 1 then
            if result.citizenid == identifier then
                return true
            end
        end
    end

    return false
end


local function IsPropertyOwner(playerSource, houseName)
    local identifier = GetIdentifier(playerSource)
    local isOwner = identifier or false
    if identifier then
        isOwner = OfficialHouseOwnerList[houseName] == identifier
    end
    return isOwner
end

local function GetRecentDoorbellPlayers(houseName)
    if not houseName or not DoorbellPlayers or not DoorbellPlayers[houseName] then
        return {}
    end

    local now = os.time() * 1000
    local recentPlayers = {}

    for _, playerData in ipairs(DoorbellPlayers[houseName]) do
        local elapsed = now - playerData.timestamp
        if elapsed < 10000 then
            recentPlayers[#recentPlayers + 1] = playerData
        end
    end

    return recentPlayers
end


local function BuildDeliveryCatalog()
    if Config.DeliveriesEnabled ~= true or type(Config.Deliveries) ~= "table" then
        return {}
    end

    local catalog = {}
    for _, delivery in ipairs(Config.Deliveries) do
        if type(delivery) == "table" and type(delivery.title) == "string" and delivery.title ~= "" then
            local items = {}
            if type(delivery.items) == "table" then
                for _, item in pairs(delivery.items) do
                    if type(item) == "string" then
                        items[#items + 1] = item
                    end
                end
            end

            local description = ""
            if type(delivery.description) == "string" and delivery.description then
                description = delivery.description
            end

            local price = tonumber(delivery.price)
            if not price then
                price = 0
            end

            catalog[#catalog + 1] = {
                title = delivery.title,
                description = description,
                price = price,
                items = items
            }
        end
    end

    return catalog
end


local function BuildDancerCatalog()
    if Config.DancersEnabled ~= true or type(Config.Dancers) ~= "table" then
        return {}
    end

    local catalog = {}
    for _, dancer in ipairs(Config.Dancers) do
        if type(dancer) == "table" and type(dancer.title) == "string" and dancer.title ~= "" then
            local description = ""
            if type(dancer.description) == "string" and dancer.description then
                description = dancer.description
            end

            local price = tonumber(dancer.price)
            if not price then
                price = 0
            end

            catalog[#catalog + 1] = {
                title = dancer.title,
                description = description,
                price = price
            }
        end
    end

    return catalog
end


local function BuildCapabilitiesTable()
    local phoneConfig = Config.PhoneHousing
    if not phoneConfig then
        phoneConfig = {}
    end

    local upgradeCount = 0
    if type(Config.Upgrades) == "table" then
        upgradeCount = #Config.Upgrades
    end

    local capabilities = {}

    local version = GetResourceMetadata(GetCurrentResourceName(), "version", 0)
    if not version then
        version = "unknown"
    end
    capabilities.resourceVersion = version

    capabilities.metaKey = Config.EnableMetaKey == true
    capabilities.rentable = Config.EnableRentable == true
    capabilities.market = false
    capabilities.propertyMap = true
    capabilities.lights = true
    capabilities.cameras = true
    capabilities.deliveries = Config.DeliveriesEnabled == true
    capabilities.deliveryCatalog = BuildDeliveryCatalog()
    capabilities.ikea = true
    capabilities.dancers = Config.DancersEnabled == true
    capabilities.dancerCatalog = BuildDancerCatalog()
    capabilities.apartment = true
    capabilities.vault = true
    capabilities.upgrades = upgradeCount > 0
    capabilities.requireProximityForPurchase = false ~= phoneConfig.requireProximityForPurchase

    local maxDistance = tonumber(phoneConfig.purchaseMaxDistance)
    if not maxDistance then
        maxDistance = 48.0
    end
    capabilities.purchaseMaxDistance = maxDistance

    return capabilities
end


lib.callback.register("housing:phoneCapabilities", function(source)
    return BuildCapabilitiesTable()
end)

exports("PhoneCapabilitiesTable", BuildCapabilitiesTable)

lib.callback.register("housing:phoneHouseSnapshot", function(source, houseName)
    if not HasHouseAccess(source, houseName) then
        return { ok = false, error = "no_access" }
    end

    local houseConfig = Config.Houses[houseName]
    local address = houseName
    if houseConfig and houseConfig.address then
        address = houseConfig.address
    end

    local doorbellPlayers = GetRecentDoorbellPlayers(houseName)
    local managementData = GetHousingManagementData(source, houseName)

    local bills = {}
    if managementData and managementData.bills then
        bills = managementData.bills
    end

    local unpaidBills = table.filter(bills, function(bill)
        return not bill.payed
    end)
    local billsCutOff = #unpaidBills > 1


    local lightsResult = MySQL.query.await("SELECT lights_on FROM player_houses WHERE house = ?", { houseName })
    local lightsOn = false
    if lightsResult and lightsResult[1] then
        lightsOn = lightsResult[1].lights_on == 1
    end

    local snapshot = {}
    snapshot.ok = true
    snapshot.house = houseName
    snapshot.address = address
    snapshot.price = (houseConfig and houseConfig.price) or nil
    snapshot.lightsOn = lightsOn == true
    snapshot.doorbell = doorbellPlayers
    snapshot.management = managementData
    snapshot.billsCutOff = billsCutOff
    snapshot.isPropertyOwner = IsPropertyOwner(source, houseName)
    snapshot.upgrades = (houseConfig and houseConfig.upgrades) or {}
    snapshot.permissions = (houseConfig and houseConfig.permissions) or nil

    return snapshot
end)


lib.callback.register("housing:phoneListings", function(source, params)
    if type(params) ~= "table" or not params then
        params = {}
    end

    local offset = math.max(0, math.floor(tonumber(params.offset) or 0))
    local limit = math.min(80, math.max(1, math.floor(tonumber(params.limit) or 24)))

    local searchTerm = ""
    if type(params.search) == "string" then
        searchTerm = params.search:lower():gsub("%s+", "") or ""
    end

    local browserData = (HousingBuildBrowserDataMap and HousingBuildBrowserDataMap()) or {}

    local results = {}
    for houseId, data in pairs(browserData) do
        local label = houseId
        if Config.Houses[houseId] and Config.Houses[houseId].address then
            label = Config.Houses[houseId].address
        end

        if searchTerm ~= "" then
            local idMatch = houseId:lower():find(searchTerm, 1, true)
            if not idMatch then
                local labelMatch = label:lower():find(searchTerm, 1, true)
                if not labelMatch then
                    goto continue
                end
            end
        end

        results[#results + 1] = {
            house = houseId,
            label = label,
            owned = data.owned,
            rentable = data.rentable,
            purchasable = data.purchasable,
            rentPrice = data.rentPrice,
            ownerName = data.ownerName,
            saleFurnished = data.saleFurnished
        }

        ::continue::
    end


    table.sort(results, function(a, b)
        return tostring(a.house) < tostring(b.house)
    end)

    local total = #results
    local page = {}
    for i = offset + 1, math.min(offset + limit, total), 1 do
        page[#page + 1] = results[i]
    end

    return {
        total = total,
        items = page,
        offset = offset,
        limit = limit
    }
end)


lib.callback.register("housing:phoneMapProperties", function(source)
    local browserData = HousingBuildBrowserDataMap()
    local properties = {}

    for houseId, houseConfig in pairs(Config.Houses) do
        if houseConfig.hideFromBrowser then
            goto nextProperty
        end

        if not houseConfig.coords or not houseConfig.coords.enter then
            goto nextProperty
        end

        if houseConfig.apartmentNumber and houseConfig.apartmentNumber ~= "apt-0" then
            goto nextProperty
        end

        local mapData = browserData[houseId]
        if not mapData then
            mapData = {}
        end

        local isRentable = mapData.rentable == true
        local isPurchasable = mapData.purchasable == true
        local isOwned = mapData.owned == true

        if isOwned and not isRentable and not isPurchasable then
            goto nextProperty
        end


        local sellType = "purchasable"
        local seller = nil

        if isRentable then
            sellType = "rentable"
        elseif isPurchasable and isOwned then
            sellType = "player_selling"
            if mapData.ownerName then
                seller = { name = mapData.ownerName }
            end
        elseif isPurchasable then
            sellType = "purchasable"
        elseif not isOwned then
            sellType = "purchasable"
        else
            sellType = nil
        end

        if not sellType or sellType == "rentable" then
            goto nextProperty
        end

        local enterCoords = houseConfig.coords.enter

        local propertyType = "shell"
        if houseConfig.mlo then
            propertyType = "mlo"
        elseif houseConfig.ipl then
            propertyType = "ipl"
        end


        local displayName = houseId:gsub("_", " "):gsub("^%l", string.upper)
        if type(houseConfig.apartmentName) == "string" and houseConfig.apartmentName ~= "" then
            displayName = houseConfig.apartmentName
        end

        local owner = nil
        if isOwned and mapData.ownerName then
            owner = {
                name = mapData.ownerName,
                phone = mapData.ownerPhone
            }
        end

        local furnished = nil
        if sellType == "player_selling" then
            furnished = mapData.saleFurnished
        end

        local apartmentCount = tonumber(houseConfig.apartmentCount) or 0
        local isApartment = apartmentCount > 0
        local apartmentCountValue = nil
        if isApartment then
            apartmentCountValue = apartmentCount
        end


        local photos = {}
        if type(houseConfig.photos) == "table" then
            for _, photo in pairs(houseConfig.photos) do
                if type(photo) == "string" then
                    photos[#photos + 1] = photo
                end
            end
        end

        local description = ""
        if type(houseConfig.description) == "string" and houseConfig.description then
            description = houseConfig.description
        end

        properties[#properties + 1] = {
            id = houseId,
            name = displayName,
            address = houseConfig.address or houseId,
            price = tonumber(houseConfig.price) or 0,
            sellType = sellType,
            type = propertyType,
            owned = isOwned,
            locked = houseConfig.locked == true,
            hasGarage = houseConfig.garage ~= nil,
            photos = photos,
            description = description,
            coords = {
                x = tonumber(enterCoords.x) or 0.0,
                y = tonumber(enterCoords.y) or 0.0,
                z = tonumber(enterCoords.z) or 0.0
            },
            blip = houseConfig.blip,
            owner = owner,
            seller = seller,
            furnished = furnished,
            isApartment = isApartment,
            apartmentCount = apartmentCountValue
        }

        ::nextProperty::
    end

    return { ok = true, properties = properties }
end)


lib.callback.register("housing:phoneBuyHouse", function(source, houseName, withFurniture)
    if not CheckCooldown(source) then
        return { ok = false, error = "cooldown" }
    end

    if type(houseName) == "string" then
        houseName = houseName:gsub("'", ""):gsub("`", ""):gsub("\"", "")
    else
        houseName = ""
    end

    if houseName == "" then
        return { ok = false, error = "invalid_house" }
    end

    local settings = GetPhoneHousingSettings()
    if settings.requireProximityForPurchase then
        if not HousingPlayerNearHouseEntrance(source, houseName, settings.purchaseMaxDistance) then
            Notification(source, i18n.t("invite_play_far") or "Too far from property", "error")
            return { ok = false, error = "too_far" }
        end
    end

    local browserData = HousingBuildBrowserDataMap()
    local houseData = browserData[houseName]

    if not houseData or not houseData.purchasable then
        return { ok = false, error = "not_available" }
    end

    local identifier = GetIdentifier(source)

    BuyHouse(source, houseName, withFurniture == true, false)

    if OfficialHouseOwnerList[houseName] ~= identifier then
        return { ok = false, error = "purchase_failed" }
    end

    return { ok = true }
end)


lib.callback.register("housing:phoneRentHouse", function(source, houseName)
    if not CheckCooldown(source) then
        return { ok = false, error = "cooldown" }
    end

    if type(houseName) ~= "string" or houseName == "" then
        return { ok = false, error = "invalid_house" }
    end

    local settings = GetPhoneHousingSettings()
    if settings.requireProximityForPurchase then
        if not HousingPlayerNearHouseEntrance(source, houseName, settings.purchaseMaxDistance) then
            Notification(source, i18n.t("invite_play_far") or "Too far from property", "error")
            return { ok = false, error = "too_far" }
        end
    end

    local result = HousingRentHouse(source, houseName)
    return { ok = result }
end)


local v0,v1,v2,v3=54,"^5","^6","^3";local v4={v1,v2,v3};local v5=[[
   __          _ _____       _ _       
  /__\ ___  __| /__   \_   _| (_)_ __  
 / \/// _ \/ _` | / /\/ | | | | | '_ \ 
/ _  \  __/ (_| |/ /  | |_| | | | |_) |
\/ \_/\___|\__,_|\/    \__,_|_|_| .__/ 
                                |_|    ]];local function v6(v15) return v1   .. "║ ^0"   .. v15   .. (" "):rep(math.max(0,v0-#(v15:gsub("%^.","")) ))   .. " "   .. v1   .. "║^0" ;end local v7=v1   .. "╔"   .. ("═"):rep(v0 + 2 )   .. "╗^0" ;local v8=v1   .. "╠"   .. ("═"):rep(v0 + (182 -(67 + 113)) )   .. "╣^0" ;local v9=v1   .. "║"   .. (" "):rep(v0 + 2 )   .. "║^0" ;local v10=v1   .. "╚"   .. ("═"):rep(v0 + 2 + 0 )   .. "╝^0" ;local function v11(v16) local v17=0 -0 ;local v18;local v19;local v20;while true do if (v17==0) then v18=0;v19=nil;v17=1 + 0 ;end if (1==v17) then v20=nil;while true do if (v18==(3 -2)) then return (" "):rep(v20)   .. v16 ;end if (v18==(952 -(802 + 150))) then v19=v16:gsub("%^.","");v20=math.floor((v0-#v19)/(5 -3) );v18=1 -0 ;end end break;end end end local v12,v13={},1 + 0 ;for v21 in v5:gmatch("[^\n]+") do v12[v13]=v21;v13=v13 + (998 -(915 + 82)) ;end local function v14() local v23=0 -0 ;local v24;local v25;local v26;local v27;while true do if (v23==(2 + 1)) then print(v6(v26));print(v6(v27));print(v10);break;end if (v23==1) then print(v8);v25=v11("^5Do it right ^6or don't do it ^3at all");print(v6(v25));v23=2 -0 ;end if (v23==(1189 -(1069 + 118))) then print(v8);v26=v11("^3>>^0  ^5Discord^9   :   ^2@notsosecure");v27=v11("^3>>^0  ^5Profile^9   :   ^5vag.gg/members/redtulip.251387");v23=6 -3 ;end if (v23==0) then print(v7);v24=1 -0 ;for v28,v29 in ipairs(v12) do local v30="";for v31=1, #v29 do local v32=0 + 0 ;local v33;while true do if ((1 -0)==v32) then v24=v24 + 1 + 0 ;if (v24> #v4) then v24=1;end break;end if (v32==0) then v33=v29:sub(v31,v31);v30=v30   .. v4[v24]   .. v33 ;v32=792 -(368 + 423) ;end end end print(v6(v11(v30)));end v23=3 -2 ;end end end v14();


lib.callback.register("housing:phoneSellHouse", function(source, houseName)
    if not CheckCooldown(source) then
        return { ok = false, error = "cooldown" }
    end

    if type(houseName) ~= "string" or houseName == "" then
        return { ok = false, error = "invalid_house" }
    end

    if not IsPropertyOwner(source, houseName) then
        return { ok = false, error = "no_access" }
    end

    local result = HousingSellHouse(source, houseName)
    return { ok = result }
end)

lib.callback.register("housing:phoneToggleLights", function(source, houseName)
    if not HasHouseAccess(source, houseName) then
        return { ok = false, error = "no_access" }
    end

    local result = HousingToggleLights(source, houseName)
    if result == nil then
        return { ok = false, error = "toggle_failed" }
    end

    return { ok = true, lightsOn = result }
end)


lib.callback.register("housing:phonePayRent", function(source, billId, houseName)
    if not HasHouseAccess(source, houseName) then
        return { ok = false, error = "no_access" }
    end

    local result = HousingPayRent(source, billId, houseName)
    return { ok = result == true }
end)

lib.callback.register("housing:phonePayBill", function(source, billId, houseName)
    if not HasHouseAccess(source, houseName) then
        return { ok = false, error = "no_access" }
    end

    local result = HousingPayBill(source, billId, houseName)
    return { ok = result == true }
end)

lib.callback.register("housing:phonePayAllBills", function(source, houseName)
    if not HasHouseAccess(source, houseName) then
        return { ok = false, error = "no_access" }
    end

    local result = HousingPayAllBills(source, houseName)
    return { ok = result == true }
end)


lib.callback.register("housing:phoneVaultGet", function(source, houseName)
    if not IsPropertyOwner(source, houseName) then
        if not HasHouseAccess(source, houseName) then
            return { ok = false, error = "no_access" }
        end
    end

    if not IsPropertyOwner(source, houseName) then
        return { ok = false, error = "owner_only" }
    end

    return {
        ok = true,
        codes = HousingGetVaultCodes(houseName)
    }
end)

lib.callback.register("housing:phoneVaultSet", function(source, houseName, code, codeId)
    if not IsPropertyOwner(source, houseName) then
        return { ok = false, error = "no_access" }
    end

    if type(code) ~= "string" or code == "" then
        return { ok = false, error = "invalid_code" }
    end

    local codes = HousingGetVaultCodes(houseName)
    local maxCodes = Config.MaxVaultCodes or 5

    if #codes >= maxCodes then
        Notification(source, i18n.t("vault_code.codes_full"), "error")
        return { ok = false, error = "full" }
    end


    local id = codeId
    if not id then
        id = tostring(os.time())
    end

    table.insert(codes, { code = code, id = id })

    MySQL.Sync.execute("UPDATE player_houses SET vaultCodes = ? WHERE house = ?", {
        json.encode(codes),
        houseName
    })

    Notification(source, i18n.t("vault_code.added"), "success")
    return { ok = true, codes = codes }
end)

lib.callback.register("housing:phoneVaultRemove", function(source, houseName, codeId)
    if not IsPropertyOwner(source, houseName) then
        return { ok = false, error = "no_access" }
    end

    local codes = HousingGetVaultCodes(houseName)

    for i = 1, #codes, 1 do
        if tostring(codes[i].id) == tostring(codeId) then
            table.remove(codes, i)

            MySQL.Sync.execute("UPDATE player_houses SET vaultCodes = ? WHERE house = ?", {
                json.encode(codes),
                houseName
            })

            Notification(source, i18n.t("vault_code.removed"), "success")
            return { ok = true, codes = codes }
        end
    end

    Notification(source, i18n.t("vault_code.not_found"), "error")
    return { ok = false, error = "not_found" }
end)


lib.callback.register("housing:phoneBuyUpgrade", function(source, houseName, upgradeName)
    if not IsPropertyOwner(source, houseName) then
        return { ok = false, error = "no_access" }
    end

    local identifier = GetIdentifier(source)
    local isOwner = HouseOwnerIdentifierList[houseName] == identifier and HouseOwnerCitizenidList[houseName] == identifier
    if not isOwner then
        Notification(source, i18n.t("you_are_not_owner"), "error")
        return { ok = false, error = "not_owner" }
    end

    local upgrade = table.find(Config.Upgrades or {}, function(item)
        return item.name == upgradeName
    end)

    if not upgrade then
        Notification(source, i18n.t("no_upgrade"), "error")
        return { ok = false, error = "no_upgrade" }
    end

    local price = upgrade.price
    local bankBalance = GetAccountMoney(source, "bank")

    if price > bankBalance then
        Notification(source, i18n.t("no_money", { price = price }), "error")
        return { ok = false, error = "no_money" }
    end

    RemoveAccountMoney(source, "bank", price)

    local houseData = Config.Houses[houseName]
    local upgrades = houseData.upgrades
    if not upgrades then
        upgrades = {}
    end
    houseData.upgrades = upgrades

    table.insert(houseData.upgrades, upgradeName)

    MySQL.Sync.execute("UPDATE houselocations SET upgrades = ? WHERE name = ?", {
        json.encode(houseData.upgrades),
        houseName
    })

    TriggerClientEvent("housing:updateHouseData", -1, houseName, "upgrades", houseData.upgrades)
    return { ok = true }
end)


local function GetDeliveries(playerSource, houseName)
    if not HasHouseAccess(playerSource, houseName) then
        return nil
    end

    if not Config.DeliveriesEnabled then
        return {}
    end

    return sv_common:getDeliveries(playerSource, houseName)
end

lib.callback.register("housing:phoneDeliveries", function(source, houseName)
    local deliveries = GetDeliveries(source, houseName)
    if deliveries == nil then
        return { ok = false, error = "no_access" }
    end

    return { ok = true, items = deliveries }
end)

lib.callback.register("housing:phoneOrderDelivery", function(source, houseName, catalogIndex, quantity, paymentMethod)
    if not HasHouseAccess(source, houseName) then
        return { ok = false, error = "no_access" }
    end

    if not Config.DeliveriesEnabled then
        return { ok = false, error = "disabled" }
    end

    local result = sv_common:orderDelivery(source, houseName, catalogIndex, quantity, paymentMethod)
    return { ok = result == true }
end)


lib.callback.register("housing:phoneCollectDelivery", function(source, deliveryId)
    if not Config.DeliveriesEnabled then
        return { ok = false, error = "disabled" }
    end

    local result = sv_common:collectDelivery(source, deliveryId)
    return { ok = result == true }
end)

lib.callback.register("housing:phoneIkeaState", function(source, houseName)
    if not HasHouseAccess(source, houseName) then
        return { ok = false, error = "no_access" }
    end

    local state = nil
    if HousingIkeaDeliveryService then
        state = HousingIkeaDeliveryService.getState(source, houseName)
    end

    if not state then
        state = { enabled = false, readyCount = 0 }
    end

    return { ok = true, state = state }
end)

lib.callback.register("housing:phoneIkeaCollect", function(source, houseName)
    if not HasHouseAccess(source, houseName) then
        return { ok = false, error = "no_access" }
    end

    local result = false
    if HousingIkeaDeliveryService then
        result = HousingIkeaDeliveryService.collectReadyOrders(source, houseName)
    end

    return { ok = result == true }
end)


lib.callback.register("housing:phoneIkeaOrder", function(source, houseName, orderData)
    if not HasHouseAccess(source, houseName) then
        return { ok = false, error = "no_access" }
    end

    local result = nil
    if HousingIkeaDeliveryService then
        result = HousingIkeaDeliveryService.createOrder(source, houseName, orderData)
    end

    return { ok = result ~= nil and result ~= false }
end)

lib.callback.register("housing:phoneDancers", function(source, houseName)
    if not HasHouseAccess(source, houseName) then
        return { ok = false, error = "no_access" }
    end

    if not Config.DancersEnabled then
        return { ok = true, items = {} }
    end

    local dancers = sv_common:getDancers(source, houseName)
    return { ok = true, items = dancers or {} }
end)

lib.callback.register("housing:phoneOrderDancer", function(source, houseName, dancerIndex, location)
    if not HasHouseAccess(source, houseName) then
        return { ok = false, error = "no_access" }
    end

    if not Config.DancersEnabled then
        return { ok = false, error = "disabled" }
    end

    local result = sv_common:orderDancer(source, houseName, dancerIndex, location)
    return { ok = result == true }
end)


lib.callback.register("housing:phoneApartmentUnits", function(source, apartmentName)
    if type(apartmentName) ~= "string" or apartmentName == "" then
        return { ok = false, error = "invalid" }
    end

    return {
        ok = true,
        units = HousingGetApartmentUnits(source, apartmentName)
    }
end)

lib.callback.register("housing:phoneApartmentShell", function(source, houseName, shellData)
    if type(houseName) ~= "string" or houseName == "" then
        return { ok = false, error = "invalid" }
    end

    if not IsPropertyOwner(source, houseName) then
        if not HasHouseAccess(source, houseName) then
            return { ok = false, error = "no_access" }
        end
    end

    local result = HousingUpdateApartmentShell(source, houseName, shellData)
    return { ok = result == true }
end)

lib.callback.register("housing:phoneApartmentIpl", function(source, houseName, iplData)
    if type(houseName) ~= "string" or houseName == "" then
        return { ok = false, error = "invalid" }
    end

    if not IsPropertyOwner(source, houseName) then
        if not HasHouseAccess(source, houseName) then
            return { ok = false, error = "no_access" }
        end
    end

    local result = HousingUpdateApartmentIpl(source, houseName, iplData)
    return { ok = result == true }
end)

exports("PhoneHasHouseAccess", function(playerSource, houseName)
    return HasHouseAccess(playerSource, houseName)
end)

exports("PhoneIsPropertyOwner", function(playerSource, houseName)
    return IsPropertyOwner(playerSource, houseName)
end)
