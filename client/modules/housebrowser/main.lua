_G.housebrowser = {
    visible = false,
    houses = {}
}

function housebrowser:collectHouses()
    local houseList = {}
    local browserData = lib.callback.await("housing:getHouseBrowserData", false)
    if not browserData then
        browserData = {}
    end

    for houseId, houseConfig in pairs(Config.Houses) do
        if houseConfig.hideFromBrowser then
            goto continue
        end

        if houseConfig.apartmentNumber then
            if "apt-0" ~= houseConfig.apartmentNumber then
                goto continue
            end
        end

        local serverData = browserData[houseId]
        if not serverData then
            serverData = {}
        end

        local rentable = serverData.rentable or false
        local purchasable = serverData.purchasable or false
        local owned = serverData.owned or false

        if owned and not rentable and not purchasable then
            goto continue
        end

        local enterCoords = houseConfig.coords.enter
        local houseType = "shell"
        if houseConfig.mlo then
            houseType = "mlo"
        elseif houseConfig.ipl then
            houseType = "ipl"
        end

        local sellType = "purchasable"
        local seller = nil
        if rentable then
            sellType = "rentable"
        elseif purchasable and owned then
            sellType = "player_selling"
            if serverData.ownerName then
                seller = { name = serverData.ownerName }
            end
        elseif purchasable then
            sellType = "purchasable"
        elseif not owned then
            sellType = "purchasable"
        end

        local owner = nil
        if owned then
            if serverData.ownerName then
                owner = {
                    name = serverData.ownerName,
                    phone = serverData.ownerPhone
                }
            end
        end

        local photos = houseConfig.photos
        if not photos then
            photos = {}
        end

        local description
        if type(houseConfig.description) == "string" and houseConfig.description ~= "" and houseConfig.description then
            description = houseConfig.description
        else
            description = i18n.t("housebrowser.no_description")
        end

        local furnished = nil
        if sellType == "player_selling" then
            furnished = serverData.saleFurnished
        end

        local isApartment = nil ~= houseConfig.apartmentCount
        local apartmentCount
        if isApartment and houseConfig.apartmentCount then
            apartmentCount = houseConfig.apartmentCount
        else
            apartmentCount = nil
        end

        local displayName = houseConfig.apartmentName
        if not displayName then
            displayName = houseId:gsub("_", " "):gsub("^%l", string.upper)
        end

        local address = houseConfig.address
        if not address then
            address = i18n.t("housebrowser.unknown_address")
        end

        local price = houseConfig.price
        if not price then
            price = 0
        end

        local locked = houseConfig.locked
        if not locked then
            locked = false
        end

        local houseEntry = {
            id = houseId,
            name = displayName,
            address = address,
            price = price,
            sellType = sellType,
            type = houseType,
            owned = owned,
            locked = locked,
            hasGarage = nil ~= houseConfig.garage,
            photos = photos,
            description = description,
            tier = houseConfig.tier,
            coords = {
                x = enterCoords.x,
                y = enterCoords.y,
                z = enterCoords.z
            },
            blip = houseConfig.blip,
            owner = owner,
            seller = seller,
            furnished = furnished,
            isApartment = isApartment,
            apartmentCount = apartmentCount
        }

        houseList[#houseList + 1] = houseEntry

        ::continue::
    end

    return houseList
end

function housebrowser:open()
    if self.visible then
        return
    end

    if IsNuiFocused() then
        return
    end

    self.houses = self:collectHouses()
    self.visible = true

    SetNuiFocus(true, true)
    ToggleHud(false)

    local minPrice = math.huge
    local maxPrice = 0

    for _, house in pairs(self.houses) do
        if minPrice > house.price then
            minPrice = house.price
        end
        if maxPrice < house.price then
            maxPrice = house.price
        end
    end

    if minPrice == math.huge then
        minPrice = 0
    end
    if maxPrice == 0 then
        maxPrice = 10000000
    end

    local ped = PlayerPedId()
    local playerCoords = GetEntityCoords(ped)

    SendReactMessage("toggle_house_browser", {
        visible = true,
        houses = self.houses,
        priceRange = { minPrice, maxPrice },
        playerCoords = {
            x = playerCoords.x,
            y = playerCoords.y,
            z = playerCoords.z
        }
    })

    Debug("HouseBrowser opened with", #self.houses, "houses")
end

function housebrowser:close()
    if not self.visible then
        return
    end

    self.visible = false
    SetNuiFocus(false, false)
    ToggleHud(true)
    SendReactMessage("toggle_house_browser", { visible = false })
    Debug("HouseBrowser closed")
end

function housebrowser:setWaypoint(houseName)
    local houseConfig = Config.Houses[houseName]
    if not houseConfig then
        return Notification(i18n.t("house_not_found"), "error")
    end

    local enterCoords = houseConfig.coords.enter
    if enterCoords and enterCoords.x and enterCoords.y then
        SetNewWaypoint(enterCoords.x, enterCoords.y)
        Notification(i18n.t("housebrowser.waypoint_set", { house = houseConfig.address }), "success")
    end
end

housebrowser.realeStateNPC = {
    ped = nil,
    spawned = false,
    blip = nil
}

local function getPedStreamingDistances(pedType, defaultSpawn, defaultDespawn)
    local pedStreamingConfig = Config.PedStreaming
    if not pedStreamingConfig then
        pedStreamingConfig = {}
    end

    local defaultConfig = pedStreamingConfig.default
    if not defaultConfig then
        defaultConfig = {}
    end

    local specificConfig = pedStreamingConfig[pedType]
    if not specificConfig then
        specificConfig = {}
    end

    local spawnDistance = specificConfig.spawnDistance
    if not spawnDistance then
        spawnDistance = defaultConfig.spawnDistance
        if not spawnDistance then
            spawnDistance = defaultSpawn
        end
    end

    local despawnDistance = specificConfig.despawnDistance
    if not despawnDistance then
        despawnDistance = defaultConfig.despawnDistance
        if not despawnDistance then
            despawnDistance = defaultDespawn
        end
    end

    if spawnDistance >= despawnDistance then
        despawnDistance = spawnDistance + 5.0
    end

    return spawnDistance, despawnDistance
end

function housebrowser:spawnRealeStateNPC()
    if self.realeStateNPC.spawned then
        if DoesEntityExist(self.realeStateNPC.ped) then
            return
        end
    end

    if not Config.RealeStateNPC or not Config.RealeStateNPC.enabled then
        return
    end

    local npcConfig = Config.RealeStateNPC
    local location = npcConfig.location

    lib.requestModel(npcConfig.pedModel, Config.DefaultRequestModelTimeout)

    local ped = CreatePed(28, npcConfig.pedModel, location.x, location.y, location.z - 1.0, location.w or 0.0, false, false)

    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityCollision(ped, false, false)
    SetPedRandomComponentVariation(ped, 0)
    SetPedRandomProps(ped)

    if npcConfig.anim and npcConfig.anim.dict and npcConfig.anim.name then
        lib.requestAnimDict(npcConfig.anim.dict)
        TaskPlayAnim(ped, npcConfig.anim.dict, npcConfig.anim.name, 8.0, -8.0, -1, 1, 0, false, false, false)
    end

    self.realeStateNPC.ped = ped
    self.realeStateNPC.spawned = true

    if npcConfig.blip and npcConfig.blip.enabled then
        local blipConfig = npcConfig.blip
        local blipText = blipConfig.text
        if not blipText then
            blipText = i18n.t("housebrowser.reale_state")
            if not blipText then
                blipText = "Real Estate"
            end
        end

        self.realeStateNPC.blip = Utils.CreateBlip({
            location = location,
            sprite = blipConfig.sprite or 374,
            color = blipConfig.color or 3,
            scale = blipConfig.scale or 0.8,
            text = blipText,
            shortRange = true
        })
    end

    SetModelAsNoLongerNeeded(npcConfig.pedModel)
end

function housebrowser:deleteRealeStateNPC()
    if self.realeStateNPC.ped then
        if DoesEntityExist(self.realeStateNPC.ped) then
            DeleteEntity(self.realeStateNPC.ped)
        end
    end

    if self.realeStateNPC.blip then
        Utils.RemoveBlip(self.realeStateNPC.blip)
    end

    self.realeStateNPC.ped = nil
    self.realeStateNPC.blip = nil
    self.realeStateNPC.spawned = false
end

if Config.HouseBrowserCommand then
    RegisterCommand("housebrowser", function(source, args, rawCommand)
        if IsNuiFocused() then
            return
        end
        housebrowser:open()
    end)
end

CreateThread(function()
    while true do
        Wait(1000)

        local npcConfig = Config.RealeStateNPC
        if not npcConfig or not npcConfig.enabled or not npcConfig.location then
            if housebrowser.realeStateNPC.spawned then
                housebrowser:deleteRealeStateNPC()
            end
            goto loopEnd
        end

        local spawnDistance, despawnDistance = getPedStreamingDistances("realEstate", 70.0, 85.0)
        local playerCoords = GetEntityCoords(cache.ped)
        local npcLocation = vec3(npcConfig.location.x, npcConfig.location.y, npcConfig.location.z)
        local distance = #(playerCoords - npcLocation)

        if spawnDistance >= distance then
            if not housebrowser.realeStateNPC.spawned then
                housebrowser:spawnRealeStateNPC()
            end
        elseif despawnDistance <= distance then
            if housebrowser.realeStateNPC.spawned then
                housebrowser:deleteRealeStateNPC()
            end
        end

        ::loopEnd::
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        housebrowser:deleteRealeStateNPC()
    end
end)

CreateThread(function()
    while true do
        local waitTime = 1000

        if housebrowser.realeStateNPC.spawned then
            if DoesEntityExist(housebrowser.realeStateNPC.ped) then
                local playerCoords = GetEntityCoords(cache.ped)
                local npcCoords = GetEntityCoords(housebrowser.realeStateNPC.ped)
                local distance = #(playerCoords - npcCoords)

                if distance < 2.0 then
                    waitTime = 0

                    local interactText = i18n.t("drawtext.reale_state_interact")
                    if not interactText then
                        interactText = "[E] - Open House Browser"
                    end

                    DrawText3D(npcCoords.x, npcCoords.y, npcCoords.z + 0.3, interactText, "reale_state_npc", "E")

                    if IsControlJustPressed(0, Keys.E) then
                        if IsNuiFocused() then
                            return
                        end
                        housebrowser:open()
                    end
                end
            end
        end

        Wait(waitTime)
    end
end)
