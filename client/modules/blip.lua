Blips = {}

local blipCache = {}
local lastDisplayedHouses = {}
local maxClosestBlips = 70
local ownedBlipCategory = 11
local defaultBlipCategory = 10

function DeleteBlips(houseId)
    if houseId then
        local blipEntry, blipIndex = table.find(Blips, function(entry)
            return entry.house == houseId
        end)

        if blipEntry then
            RemoveBlip(blipEntry.blip)
            table.remove(Blips, blipIndex)
            Debug("Blip", "Removed blip for house " .. houseId)
            return
        end

        Debug("Blip", "Blip for house " .. houseId .. " not found")
        return
    end

    for _, entry in pairs(Blips) do
        RemoveBlip(entry.blip)
    end

    Blips = {}
end

local function getDistance(pos1, pos2)
    local a = vec3(pos1.x, pos1.y, pos1.z)
    local b = vec3(pos2.x, pos2.y, pos2.z)
    return #(a - b)
end

local function arraysEqual(arr1, arr2)
    if #arr1 ~= #arr2 then
        return false
    end

    local lookup = {}
    for _, value in ipairs(arr2) do
        lookup[value] = true
    end

    for _, value in ipairs(arr1) do
        if not lookup[value] then
            return false
        end
    end

    return true
end

local function updateClosestBlips()
    if not Config.ShowClosestBlips or Config.DisableAllHouseBlips then
        return
    end

    local playerCoords = GetEntityCoords(cache.ped)
    local ownedHouses = {}
    local otherHouses = {}

    for houseId, cacheData in pairs(blipCache) do
        local distance = getDistance(playerCoords, cacheData.coords)
        local entry = {
            house = houseId,
            distance = distance,
            cacheData = cacheData,
        }

        if cacheData.ownedByMe then
            table.insert(ownedHouses, entry)
        else
            table.insert(otherHouses, entry)
        end
    end

    table.sort(ownedHouses, function(a, b)
        return a.distance < b.distance
    end)

    table.sort(otherHouses, function(a, b)
        return a.distance < b.distance
    end)

    local housesToShow = {}

    for _, entry in ipairs(ownedHouses) do
        table.insert(housesToShow, entry.house)
    end

    local remainingSlots = maxClosestBlips - #housesToShow
    local otherCount = math.min(remainingSlots, #otherHouses)

    for i = 1, otherCount do
        table.insert(housesToShow, otherHouses[i].house)
    end

    if arraysEqual(housesToShow, lastDisplayedHouses) then
        return
    end

    lastDisplayedHouses = {}
    for _, houseId in ipairs(housesToShow) do
        table.insert(lastDisplayedHouses, houseId)
    end

    DeleteBlips()

    for _, houseId in ipairs(housesToShow) do
        local data = blipCache[houseId]
        if data then
            local blipHandle = Utils.CreateBlip({
                location = data.coords,
                sprite = data.sprite,
                color = data.color,
                scale = data.scale,
                text = data.text,
                shortRange = true,
            })

            if data.blipColor then
                SetBlipColour(blipHandle, data.blipColor)
            end

            if Config.CategoryBlips then
                SetBlipCategory(blipHandle, data.category or defaultBlipCategory)
            end

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(data.blipName)
            EndTextCommandSetBlipName(blipHandle)

            table.insert(Blips, { house = houseId, blip = blipHandle })
        end
    end
end

CreateThread(function()
    while true do
        Wait(500)
        if Config.ShowClosestBlips and not Config.DisableAllHouseBlips then
            updateClosestBlips()
        end
    end
end)

local blipConfig = Config.Blip

function CreateBlips(houseId)
    if Config.DisableAllHouseBlips then
        blipCache = {}
        lastDisplayedHouses = {}
        return
    end

    DeleteBlips(houseId)

    TriggerServerCallback("qb-houses:server:getPlayerHouses", function(playerHouses)
        local houses

        if houseId then
            houses = { [houseId] = Config.Houses[houseId] }
            if not houses then
                houses = Config.Houses
            end
        else
            houses = Config.Houses
        end

        if Config.ShowClosestBlips and not houseId then
            blipCache = {}
            lastDisplayedHouses = {}

            for houseKey, houseData in pairs(houses) do
                if houseData.apartmentNumber then
                    if "apt-0" ~= houseData.apartmentNumber then
                        goto continue_closest
                    end
                end

                do
                    local blipData = houseData.blip
                    if not houseData.address then
                        houseData.address = "Unknown"
                    end

                    local blipText = i18n.t("blip.house")
                    local ownershipData = nil

                    if houseData.apartmentNumber then
                        ownershipData = table.find(playerHouses, function(entry)
                            return houseData.apartmentName == entry.house:gsub("-apt%-%d+", "")
                        end)
                    else
                        ownershipData = table.find(playerHouses, function(entry)
                            return entry.house == houseKey
                        end)
                    end

                    if not blipData and not ownershipData then
                        Debug("Blip", "No blip data and no owned house", "house", houseKey)
                    else
                        local isRenter = false
                        local isOfficialOwner = false
                        local blipColor = nil
                        local isOwnedByMe = false
                        local category = defaultBlipCategory

                        if ownershipData then
                            isRenter = ownershipData.citizenid == GetIdentifier()
                            isOfficialOwner = ownershipData.owner == GetIdentifier()
                            local isRentable = ownershipData.rentable
                            local isPurchasable = ownershipData.purchasable

                            isOwnedByMe = isRenter or isOwnedByMe
                            if not isRenter then
                                isOwnedByMe = isOfficialOwner
                            end

                            if isOwnedByMe then
                                if ownedBlipCategory then
                                    category = ownedBlipCategory or category
                                end
                            end
                            category = defaultBlipCategory

                            if not isOwnedByMe and not blipData then
                                Debug("Blip", "No blip data and no owned house", "house", houseKey)
                            else
                                if isOfficialOwner then
                                    if not blipConfig.officialOwned.enabled then
                                        Debug("House is official owned but blip is disabled", "house", houseKey)
                                    else
                                        blipColor = blipConfig.officialOwned.color
                                        blipText = i18n.t("blip.your_house")
                                        if isRentable then
                                            blipText = i18n.t("blip.your_house_rentable")
                                        end
                                    end
                                elseif isRenter then
                                    if not blipConfig.owned.enabled then
                                        Debug("House is owned but blip is disabled", "house", houseKey)
                                    else
                                        blipColor = blipConfig.owned.color
                                        blipText = i18n.t("blip.your_house_rental")
                                    end
                                elseif isRentable then
                                    if not blipConfig.rentable.enabled then
                                        Debug("House is rentable but blip is disabled", "house", houseKey)
                                    else
                                        blipColor = blipConfig.rentable.color
                                        blipText = i18n.t("blip.house_for_rent")
                                    end
                                elseif isPurchasable then
                                    if not blipConfig.purchasable.enabled then
                                        Debug("House is purchasable but blip is disabled", "house", houseKey)
                                    else
                                        blipColor = blipConfig.purchasable.color
                                        blipText = i18n.t("blip.house_available_for_purchase")
                                    end
                                else
                                    if not blipConfig.ownedOther.enabled then
                                        Debug("House is owned by other player but blip is disabled", "house", houseKey)
                                        goto continue_closest
                                    end
                                end
                            end
                        else
                            if not Config.Blip.forSale.enabled then
                                Debug("House no owner and blip for sale disabled", "house", houseKey)
                                goto continue_closest
                            end
                        end

                        if not Config.GroupBlips then
                            blipText = blipText .. " " .. houseData.address
                        end

                        blipCache[houseKey] = {
                            coords = houseData.coords.enter,
                            sprite = (blipData and blipData.sprite) or 40,
                            color = (blipData and blipData.color) or 15,
                            scale = (blipData and blipData.scale and blipData.scale + 0.0) or 0.58,
                            text = (blipData and blipData.name and blipData.name ~= "" and blipData.name) or blipText,
                            blipColor = blipColor,
                            blipName = (blipData and blipData.name) or blipText,
                            ownedByMe = isOwnedByMe,
                            category = category,
                        }
                    end
                end

                ::continue_closest::
            end

            local cacheCount = 0
            for _ in pairs(blipCache) do
                cacheCount = cacheCount + 1
            end

            Debug("Blip", "Cached " .. cacheCount .. " blips for distance-based display")
            return
        end

        -- Non-closest-blips mode: create all blips immediately
        for houseKey, houseData in pairs(houses) do
            if houseData.apartmentNumber then
                if "apt-0" ~= houseData.apartmentNumber then
                    goto continue_all
                end
            end

            do
                local blipData = houseData.blip
                if not houseData.address then
                    houseData.address = "Unknown"
                end

                local blipText = i18n.t("blip.house")
                local blipHandle = nil
                local ownershipData = nil
                local blipCategory = defaultBlipCategory

                if houseData.apartmentNumber then
                    ownershipData = table.find(playerHouses, function(entry)
                        return houseData.apartmentName == entry.house:gsub("-apt%-%d+", "")
                    end)
                else
                    ownershipData = table.find(playerHouses, function(entry)
                        return entry.house == houseKey
                    end)
                end

                if not blipData and not ownershipData then
                    Debug("Blip", "No blip data and no owned house", "house", houseKey)
                else
                    blipHandle = Utils.CreateBlip({
                        location = houseData.coords.enter,
                        sprite = (blipData and blipData.sprite) or 40,
                        color = (blipData and blipData.color) or 15,
                        scale = (blipData and blipData.scale and blipData.scale + 0.0) or 0.58,
                        text = (blipData and blipData.name and blipData.name ~= "" and blipData.name) or blipText,
                        shortRange = true,
                    })

                    if ownershipData then
                        local isRenter = ownershipData.citizenid == GetIdentifier()
                        local isOfficialOwner = ownershipData.owner == GetIdentifier()
                        local isRentable = ownershipData.rentable
                        local isPurchasable = ownershipData.purchasable

                        local isOwnedByMe = isRenter or false
                        if not isRenter then
                            isOwnedByMe = isOfficialOwner
                        end

                        if isOwnedByMe then
                            if ownedBlipCategory then
                                blipCategory = ownedBlipCategory or blipCategory
                            end
                        end
                        blipCategory = defaultBlipCategory

                        if not isOwnedByMe and not blipData then
                            Debug("Blip", "No blip data and no owned house", "house", houseKey)
                            RemoveBlip(blipHandle)
                        else
                            if isOfficialOwner then
                                if not blipConfig.officialOwned.enabled then
                                    Debug("House is official owned but blip is disabled", "house", houseKey)
                                    RemoveBlip(blipHandle)
                                else
                                    SetBlipColour(blipHandle, blipConfig.officialOwned.color)
                                    blipText = i18n.t("blip.your_house")
                                    if isRentable then
                                        blipText = i18n.t("blip.your_house_rentable")
                                    end
                                end
                            elseif isRenter then
                                if not blipConfig.owned.enabled then
                                    Debug("House is owned but blip is disabled", "house", houseKey)
                                    RemoveBlip(blipHandle)
                                else
                                    SetBlipColour(blipHandle, blipConfig.owned.color)
                                    blipText = i18n.t("blip.your_house_rental")
                                end
                            elseif isRentable then
                                if not blipConfig.rentable.enabled then
                                    Debug("House is rentable but blip is disabled", "house", houseKey)
                                    RemoveBlip(blipHandle)
                                else
                                    SetBlipColour(blipHandle, blipConfig.rentable.color)
                                    blipText = i18n.t("blip.house_for_rent")
                                end
                            elseif isPurchasable then
                                if not blipConfig.purchasable.enabled then
                                    Debug("House is purchasable but blip is disabled", "house", houseKey)
                                    RemoveBlip(blipHandle)
                                else
                                    SetBlipColour(blipHandle, blipConfig.purchasable.color)
                                    blipText = i18n.t("blip.house_available_for_purchase")
                                end
                            else
                                if not blipConfig.ownedOther.enabled then
                                    Debug("House is owned by other player but blip is disabled", "house", houseKey)
                                    RemoveBlip(blipHandle)
                                    goto continue_all
                                end
                            end
                        end
                    else
                        if not Config.Blip.forSale.enabled then
                            Debug("House no owner and blip for sale disabled", "house", houseKey)
                            RemoveBlip(blipHandle)
                            goto continue_all
                        end
                    end

                    if Config.CategoryBlips then
                        SetBlipCategory(blipHandle, blipCategory)
                    end

                    if not Config.GroupBlips then
                        blipText = blipText .. " " .. houseData.address
                    end

                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentSubstringPlayerName((blipData and blipData.name) or blipText)
                    EndTextCommandSetBlipName(blipHandle)

                    table.insert(Blips, { house = houseKey, blip = blipHandle })
                end
            end

            ::continue_all::
        end
    end, houseId)
end
