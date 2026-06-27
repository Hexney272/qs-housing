





if not Config.UseTarget then
    return
end

local target_name = GetResourceState('ox_target'):find('started') and 'qtarget' or 'qb-target'
local registeredModels = {}

local function SafeAddTargetModel(models, options)
    local key = type(models) == 'table' and table.concat(models, '_') or tostring(models)

    if registeredModels[key] then
        return
    end

    registeredModels[key] = true
    SafeAddTargetModel(models, options)
end

---@class Target
---@field houses table
Target = {
    zones = {},
}

local function checkKey()
    if CurrentHouse ~= nil and CurrentHouseData.haskey then
        return true
    end
    return false
end

local lastMLODoors = {}

function Target:initMLODoors(key)
    local houseData = self.houses[key]
    if not houseData then return end
    if not houseData.mlo then return end
    local hashes = {}
    for doorId, data in pairs(houseData.mlo) do
        local has = table.find(hashes, function(v)
            return v == data.hash
        end)
        if not has then
            table.insert(hashes, data.hash)
        end
    end
    lastMLODoors = hashes
    local confirmed = {}
    SafeAddTargetModel(hashes, {
        options = {
            {
                icon = 'fa-solid fa-door-open',
                label = i18n.t('target.toggle_door'),
                action = function(entity)
                    local coords = GetEntityCoords(entity)
                    local finded, doorId = table.find(houseData.mlo, function(door)
                        local doorCoords = vec3(door.coords.x, door.coords.y, door.coords.z)
                        local distance = #(coords - doorCoords)
                        return distance < Config.DoorDistance
                    end)
                    if not finded then return end
                    local doorData = houseData.mlo[doorId]
                    if not checkKey() then return Notification(i18n.t('not_have_keys'), 'error') end
                    DoorAnim()
                    TriggerServerEvent('qb-houses:SyncDoor', CurrentHouse, { finded }, not doorData.locked)
                end,
                canInteract = function(entity)
                    if not CurrentHouse then
                        return false
                    end
                    if confirmed[entity] then
                        return true
                    end
                    local coords = GetEntityCoords(entity)
                    local finded = table.find(houseData.mlo, function(door)
                        local doorCoords = vec3(door.coords.x, door.coords.y, door.coords.z)
                        local distance = #(coords - doorCoords)
                        return distance < Config.DoorDistance
                    end)
                    if not finded then
                        return false
                    end
                    confirmed[entity] = finded
                    return true
                end
            },
        },
        distance = 2.5
    })
end

local function IsCookerModel(modelName)
    if not Config.Furniture then return false end
    for categoryKey, categoryData in pairs(Config.Furniture) do
        if categoryKey ~= 'navigation' and categoryData.items then
            for _, item in pairs(categoryData.items) do
                if item.object == modelName and item.cooker then
                    return true
                end
                if item.colors then
                    for _, color in pairs(item.colors) do
                        if color.object == modelName and item.cooker then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end

local function getDecorationFromEntity(entity)
    local decorations = decorate.objects
    if not decorations then return nil end
    return table.find(decorations, function(decoration)
        return joaat(decoration.modelName) == GetEntityModel(entity) and decoration.handle == entity
    end)
end

local function getModelNameFromEntity(entity)
    local decorationData = getDecorationFromEntity(entity)
    if decorationData then
        return decorationData.modelName
    end
    return nil
end

function Target:initObjectInteractions()
    local hashes = {}
    for a, x in pairs(Config.DynamicFurnitures) do
        table.insert(hashes, joaat(a))
    end

    SafeAddTargetModel(hashes, {
        options = {
            {
                icon = 'fa-solid fa-magnifying-glass',
                label = i18n.t('target.furniture_interaction'),
                action = function(entity)
                    local decorations = decorate.objects
                    if not decorations then return end
                    local decorationData = table.find(decorations, function(decoration)
                        return joaat(decoration.modelName) == GetEntityModel(entity) and decoration.handle == entity
                    end)
                    local objectData = table.find(Config.DynamicFurnitures, function(furniData, key)
                        return joaat(key) == GetEntityModel(entity)
                    end)
                    if not objectData then return print('No objectData') end
                    if not decorationData then return print('No decorationData') end
                    if objectData.event then
                        local uniq = decorationData.uniq
                        TriggerEvent(objectData.event, uniq)
                        return
                    end
                    if objectData.type == 'stash' then
                        local stashKey = GetFurnitureStorageId(decorationData.id)
                        if stashKey and CanAccessStash(decorationData.id) then
                            openStash(objectData.stash, stashKey)
                        end
                    elseif objectData.type == 'wardrobe' then
                        openWardrobe()
                    end
                end,
                canInteract = function(entity, distance, data)
                    local house = CurrentHouse
                    if not house then
                        return false
                    end
                    return true
                end,
            },
            {
                icon = 'fa-solid fa-magnifying-glass',
                label = i18n.t('target.vault_set_code'),
                action = function(entity)
                    local house = CurrentHouse
                    local decorations = decorate.objects
                    if not decorations then
                        Notification(i18n.t('target.vault_cannot_decorations'), 'error')
                        return
                    end
                    local decorationData = table.find(decorations, function(decoration)
                        return joaat(decoration.modelName) == GetEntityModel(entity) and decoration.handle == entity
                    end)
                    local objectData = table.find(Config.DynamicFurnitures, function(furniData, key)
                        return joaat(key) == GetEntityModel(entity)
                    end)
                    if not objectData then
                        Notification(i18n.t('target.vault_cannot_object_data'), 'error')
                        return
                    end
                    if not decorationData then
                        Notification(i18n.t('target.vault_cannot_decoration_data'), 'error')
                        return
                    end
                    if objectData.type == 'stash' then
                        OpenVaultCodeMenu(decorationData.id)
                        return
                    end
                    Notification(i18n.t('target.vault_cannot_set_code'), 'error')
                end,
                canInteract = function(entity, distance, data)
                    if not CurrentHouseData.isOfficialOwner then return false end
                    local houseData = Config.Houses[CurrentHouse]
                    return table.includes(houseData.upgrades, 'vault')
                end,
            }
        },
        distance = Config.TargetLength,
    })
    Target.initObjectInteractions = nil
end

function Target:initFurnitureInteractions()
    local allHashes = {}
    if Config.Furniture then
        for categoryKey, categoryData in pairs(Config.Furniture) do
            if categoryKey ~= 'navigation' and categoryData.items then
                for _, item in pairs(categoryData.items) do
                    if item.object then
                        table.insert(allHashes, joaat(item.object))
                    end
                    if item.colors then
                        for _, color in pairs(item.colors) do
                            if color.object then
                                table.insert(allHashes, joaat(color.object))
                            end
                        end
                    end
                end
            end
        end
    end

    if #allHashes == 0 then return end

    SafeAddTargetModel(allHashes, {
        options = {
            -- Cooking interaction
            {
                icon = 'fa-solid fa-fire-burner',
                label = i18n.t('target.cooking_interaction'),
                action = function(entity)
                    common:openCooking(Config.CookingRecipes)
                end,
                canInteract = function(entity, distance, data)
                    if not CurrentHouse then return false end
                    local modelName = getModelNameFromEntity(entity)
                    if not modelName then return false end
                    return IsCookerModel(modelName)
                end,
            },
            -- Sink interaction
            {
                icon = 'fa-solid fa-faucet',
                label = i18n.t('target.sink_interaction'),
                action = function(entity)
                    local modelName = getModelNameFromEntity(entity)
                    if not modelName then return end
                    local sinkData = GetSinkData(modelName)
                    if sinkData then
                        common:useSink(entity, sinkData)
                    end
                end,
                canInteract = function(entity, distance, data)
                    if not CurrentHouse then return false end
                    local modelName = getModelNameFromEntity(entity)
                    if not modelName then return false end
                    return GetSinkData(modelName) ~= nil
                end,
            },
            -- Bathtub interaction (enter)
            {
                icon = 'fa-solid fa-bath',
                label = i18n.t('target.bathtub_interaction'),
                action = function(entity)
                    local modelName = getModelNameFromEntity(entity)
                    if not modelName then return end
                    local bathData = GetBathData(modelName)
                    if bathData then
                        common:useBathtub(entity, bathData)
                    end
                end,
                canInteract = function(entity, distance, data)
                    if not CurrentHouse then return false end
                    if common.bathtub and common.bathtub.isInBathtub then return false end
                    local modelName = getModelNameFromEntity(entity)
                    if not modelName then return false end
                    return GetBathData(modelName) ~= nil
                end,
            },
            -- Bathtub exit interaction
            {
                icon = 'fa-solid fa-door-open',
                label = i18n.t('target.bathtub_exit'),
                action = function(entity)
                    local modelName = getModelNameFromEntity(entity)
                    if not modelName then return end
                    local bathData = GetBathData(modelName)
                    if bathData then
                        common:useBathtub(entity, bathData)
                    end
                end,
                canInteract = function(entity, distance, data)
                    if not CurrentHouse then return false end
                    if not common.bathtub or not common.bathtub.isInBathtub then return false end
                    local modelName = getModelNameFromEntity(entity)
                    if not modelName then return false end
                    return GetBathData(modelName) ~= nil
                end,
            },
            -- Toilet interaction
            {
                icon = 'fa-solid fa-toilet',
                label = i18n.t('target.toilet_interaction'),
                action = function(entity)
                    local modelName = getModelNameFromEntity(entity)
                    if not modelName then return end
                    local toiletData = GetToiletData(modelName)
                    if toiletData then
                        common:useToilet(entity, toiletData)
                    end
                end,
                canInteract = function(entity, distance, data)
                    if not CurrentHouse then return false end
                    local modelName = getModelNameFromEntity(entity)
                    if not modelName then return false end
                    return GetToiletData(modelName) ~= nil
                end,
            },
            -- Steal furniture interaction
            {
                icon = 'fa-solid fa-hand-holding',
                label = i18n.t('target.steal_furniture'),
                action = function(entity)
                    local decorationData = getDecorationFromEntity(entity)
                    if decorationData then
                        common:pickupFurniture(entity, {
                            id = decorationData.id,
                            uniq = decorationData.uniq,
                            modelName = decorationData.modelName,
                            coords = decorationData.coords
                        })
                    end
                end,
                canInteract = function(entity, distance, data)
                    if not CurrentHouse then return false end
                    local houseData = Config.Houses[CurrentHouse]
                    if not houseData or not houseData.IsRammed then return false end
                    if common.robbery and common.robbery.carryingFurniture then return false end
                    local decorationData = getDecorationFromEntity(entity)
                    return decorationData ~= nil
                end,
            },
        },
        distance = 2.0
    })
    Target.initFurnitureInteractions = nil
end

local function checkHouseHasOwner()
    if not CurrentHouseData.isOwned or CurrentHouseData.rentable or CurrentHouseData.purchasable then return false end
    return true
end

function Target:initOutside(key)
    local houseData = self.houses[key]
    local enterCoords = vec3(houseData.coords.enter.x, houseData.coords.enter.y, houseData.coords.enter.z)
    local options = {}
    if houseData.apartmentNumber then
        table.insert(options, {
            icon = 'fa-solid fa-magnifying-glass',
            label = i18n.t('target.show_apartments'),
            action = function()
                OpenApartmentMenu()
            end,
            canInteract = function(entity, distance, data)
                if checkHouseHasOwner() then return false end
                return true
            end,
        })
    elseif not houseData.apartmentNumber then
        options = {
            {
                icon = 'fa-solid fa-magnifying-glass',
                label = i18n.t('target.show_house'),
                action = function()
                    InspectHouse(houseData)
                end,
                canInteract = function(entity, distance, data)
                    if checkHouseHasOwner() then return false end
                    return true
                end,
            },
            {
                icon = 'fas fa-file-contract',
                label = i18n.t('target.view_house'),
                action = function()
                    if CurrentHouseData.rentable then
                        TriggerServerEvent('qb-houses:server:viewHouse', CurrentHouse, true)
                    else
                        TriggerServerEvent('qb-houses:server:viewHouse', CurrentHouse)
                    end
                end,
                canInteract = function(entity, distance, data)
                    if checkHouseHasOwner() then return false end
                    return true
                end,
            },
            {
                icon = 'fa-solid fa-door-open',
                label = i18n.t('target.enter_house'),
                action = function()
                    TriggerEvent('qb-houses:client:EnterHouse', houseData.ipl)
                end,
                canInteract = function(entity, distance, data)
                    if not CurrentHouse then return false end
                    if Config.Houses[CurrentHouse].mlo then return false end
                    if not checkHouseHasOwner() then return false end
                    if not CurrentHouseData.haskey and not Config.Houses[CurrentHouse].IsRammed then return false end
                    return true
                end,
            },
            {
                icon = 'fa-solid fa-bell',
                label = i18n.t('target.request_ring'),
                action = function()
                    TriggerEvent('qb-houses:client:RequestRing')
                end,
                canInteract = function(entity, distance, data)
                    if not CurrentHouse then return false end
                    if Config.Houses[CurrentHouse].mlo then return false end
                    if not checkHouseHasOwner() then return false end
                    if CurrentHouseData.haskey or Config.Houses[CurrentHouse].IsRammed then return false end
                    return true
                end,
            },
        }
    end
    if #options == 0 then return end
    exports[target_name]:AddBoxZone('house_outside' .. key, enterCoords, Config.TargetLength, Config.TargetWidth, {
        name = 'house_outside' .. key,
        heading = 90.0,
        debugPoly = Config.ZoneDebug,
        minZ = enterCoords.z - 15.0,
        maxZ = enterCoords.z + 5.0,
    }, {
        options = options,
        distance = 2.5
    })
    table.insert(self.zones, 'house_outside' .. key)
end

function Target:destroyExit()
    exports[target_name]:RemoveZone('house_exit')
end

function Target:initExit()
    local houseData = Config.Houses[EnteredHouse]
    if not houseData then
        Error('Target:initExit ::: No house data', EnteredHouse)
        return
    end
    self:destroyExit()
    local exitCoords
    if houseData.mlo then
        exitCoords = vec3(houseData.coords.enter.x, houseData.coords.enter.y, houseData.coords.enter.z)
    elseif houseData.ipl then
        exitCoords = vec3(houseData.ipl.exit.x, houseData.ipl.exit.y, houseData.ipl.exit.z)
    else
        if not houseData.coords.exit then return end
        exitCoords = vec3(houseData.coords.exit.x, houseData.coords.exit.y, houseData.coords.exit.z)
    end
    exports[target_name]:AddBoxZone('house_exit', exitCoords, Config.TargetLength, Config.TargetWidth, {
        name = 'house_exit',
        heading = 90.0,
        debugPoly = Config.ZoneDebug,
        minZ = exitCoords.z - 15.0,
        maxZ = exitCoords.z + 5.0,
    }, {
        options = {
            {
                icon = 'fa-solid fa-door-open',
                label = i18n.t('target.exit_house'),
                action = function()
                    quickMenu:open()
                end,
                canInteract = function(entity, distance, data)
                    return true
                end,
            },
            {
                icon = 'fa-solid fa-hand-holding',
                label = i18n.t('target.steal_at_exit'),
                action = function()
                    common:stealAtExit(CurrentHouse)
                end,
                canInteract = function(entity, distance, data)
                    return common.robbery.carryingFurniture
                end,
            },
            {
                icon = 'fa-solid fa-bell',
                label = i18n.t('target.ring_doorbell'),
                action = function()
                    TriggerServerEvent('qb-houses:server:OpenDoor', CurrentDoorBell, CurrentHouse)
                    CurrentDoorBell = 0
                end,
                canInteract = function(entity, distance, data)
                    return CurrentDoorBell ~= 0
                end,
            },
            {
                icon = 'fa-solid fa-video',
                label = i18n.t('target.access_camera'),
                action = function()
                    FrontDoorCam(vec3(houseData.coords.enter.x, houseData.coords.enter.y, houseData.coords.enter.z + 1.0))
                end,
                canInteract = function(entity, distance, data)
                    if houseData.ipl then return false end
                    return not inOwned
                end,
            },
        },
        distance = 2.5
    })
    table.insert(self.zones, 'house_exit')
end

function Target:initWardrobe()
    local wardrobe = CurrentHouseData.wardrobe
    if not wardrobe then return Debug('Target:initWardrobe ::: No wardrobe coords') end
    exports[target_name]:AddBoxZone('house_wardrobe', wardrobe, Config.TargetLength, Config.TargetWidth, {
        name = 'house_wardrobe',
        heading = 90.0,
        debugPoly = Config.ZoneDebug,
        minZ = wardrobe.z - 15.0,
        maxZ = wardrobe.z + 5.0,
    }, {
        options = {
            {
                icon = 'fa-solid fa-magnifying-glass',
                label = i18n.t('target.access_wardrobe'),
                action = function()
                    openWardrobe()
                end,
                canInteract = function(entity, distance, data)
                    return true
                end,
            },
        },
        distance = 2.5
    })
end

function Target:initStash()
    local stash = CurrentHouseData.stash
    if not stash then return Debug('Target:initStash ::: No stash coords') end
    exports[target_name]:AddBoxZone('house_stash', stash, Config.TargetLength, Config.TargetWidth, {
        name = 'house_stash',
        heading = 90.0,
        debugPoly = Config.ZoneDebug,
        minZ = stash.z - 15.0,
        maxZ = stash.z + 5.0,
    }, {
        options = {
            {
                icon = 'fa-solid fa-magnifying-glass',
                label = i18n.t('target.access_stash'),
                action = function()
                    if CanAccessStash() then
                        openStash()
                    end
                end,
                canInteract = function(entity, distance, data)
                    return true
                end,
            },
            {
                icon = 'fa-solid fa-key',
                label = i18n.t('target.vault_set_code'),
                action = function()
                    OpenVaultCodeMenu()
                end,
                canInteract = function(entity, distance, data)
                    if not CurrentHouseData.isOfficialOwner then return false end
                    local houseData = Config.Houses[CurrentHouse]
                    return table.includes(houseData.upgrades, 'vault')
                end,
            }
        },
        distance = 2.5
    })
end

function Target:initLogout()
    local logout = CurrentHouseData.logout
    if not logout then return Debug('Target:initLogout ::: No logout coords') end
    exports[target_name]:AddBoxZone('house_logout', logout, Config.TargetLength, Config.TargetWidth, {
        name = 'house_logout',
        heading = 90.0,
        debugPoly = Config.ZoneDebug,
        minZ = logout.z - 15.0,
        maxZ = logout.z + 5.0,
    }, {
        options = {
            {
                icon = 'fa-solid fa-magnifying-glass',
                label = i18n.t('target.logout_interaction'),
                action = function()
                    DoScreenFadeOut(250)
                    while not IsScreenFadedOut() do Wait(10) end
                    DespawnInterior(HouseObj, function()
                        WeatherSyncEvent(false) -- Weather Events

                        local house = CurrentHouse
                        SetEntityCoords(cache.ped, Config.Houses[house].coords.enter.x, Config.Houses[house].coords.enter.y, Config.Houses[house].coords.enter.z + 0.5)
                        SetEntityHeading(cache.ped, Config.Houses[house].coords.enter.h)
                        inOwned = false
                        TriggerServerEvent('qb-houses:server:LogoutLocation')
                    end)
                end,
                canInteract = function(entity, distance, data)
                    return true
                end,
            },
        },
        distance = 2.5
    })
end

function Target:destroyTablet()
    exports[target_name]:RemoveZone('house_tablet')
end

function Target:initTablet()
    self:destroyTablet()
end

function Target:init()
    for k, v in pairs(self.zones) do
        exports[target_name]:RemoveZone(v)
    end
    self.zones = {}
    exports[target_name]:RemoveTargetModel(lastMLODoors)
    for k, v in pairs(self.houses) do
        self:initOutside(k)
        self:initMLODoors(k)
    end
end

local registeredJunk = {}

CreateThread(function()
    if not Config.Cleaning then return end

    while true do
        Wait(1000)

        if not EnteredHouse then goto continue end
        if not CurrentHouseData or not CurrentHouseData.haskey then goto continue end

        for id, junkObj in pairs(junk:getAll()) do
            if junkObj.coords and not junkObj.zone then
                junkObj.zone = exports.ox_target:addSphereZone({
                    coords = junkObj.coords,
                    radius = 1.3,
                    debug = false,
                    options = {
                        {
                            icon = 'fas fa-broom',
                            label = i18n.t('junk.target_clean'),
                            onSelect = function()
                                junk:pickup(id, EnteredHouse)

                                if junkObj.zone then
                                    exports.ox_target:removeZone(junkObj.zone)
                                    junkObj.zone = nil
                                end
                            end
                        }
                    }
                })
            end
        end

        ::continue::
    end
end)

function Target:initShower(coords, shellCoords, shellHeading, showerData)
    if not coords then return Debug('Target:initShower ::: No shower coords') end
    exports[target_name]:AddBoxZone('house_shower', coords, Config.TargetLength, Config.TargetWidth, {
        name = 'house_shower',
        heading = 90.0,
        debugPoly = Config.ZoneDebug,
        minZ = coords.z - 15.0,
        maxZ = coords.z + 5.0,
    }, {
        options = {
            {
                icon = 'fa-solid fa-shower',
                label = i18n.t('target.shower_interaction'),
                action = function()
                    common:useShower(shellCoords, shellHeading, showerData)
                end,
                canInteract = function(entity, distance, data)
                    return not common.shower.isInShower
                end,
            },
            {
                icon = 'fa-solid fa-door-open',
                label = i18n.t('target.shower_exit'),
                action = function()
                    common:useShower(shellCoords, shellHeading, showerData)
                end,
                canInteract = function(entity, distance, data)
                    return common.shower.isInShower
                end,
            },
        },
        distance = 2.5
    })
    table.insert(self.zones, 'house_shower')
end

function Target:initSink(coords, shellCoords, shellHeading, sinkData)
    if not coords then return Debug('Target:initSink ::: No sink coords') end
    exports[target_name]:AddBoxZone('house_sink', coords, Config.TargetLength, Config.TargetWidth, {
        name = 'house_sink',
        heading = 90.0,
        debugPoly = Config.ZoneDebug,
        minZ = coords.z - 15.0,
        maxZ = coords.z + 5.0,
    }, {
        options = {
            {
                icon = 'fa-solid fa-faucet',
                label = i18n.t('target.sink_interaction'),
                action = function()
                    common:useSink(shellCoords, sinkData, shellHeading)
                end,
                canInteract = function(entity, distance, data)
                    return true
                end,
            },
        },
        distance = 2.5
    })
    table.insert(self.zones, 'house_sink')
end

function Target:initToilet(coords, shellCoords, shellHeading, toiletData)
    if not coords then return Debug('Target:initToilet ::: No toilet coords') end
    exports[target_name]:AddBoxZone('house_toilet', coords, Config.TargetLength, Config.TargetWidth, {
        name = 'house_toilet',
        heading = 90.0,
        debugPoly = Config.ZoneDebug,
        minZ = coords.z - 15.0,
        maxZ = coords.z + 5.0,
    }, {
        options = {
            {
                icon = 'fa-solid fa-toilet',
                label = i18n.t('target.toilet_interaction'),
                action = function()
                    common:useToilet(shellCoords, toiletData, shellHeading)
                end,
                canInteract = function(entity, distance, data)
                    return true
                end,
            },
        },
        distance = 2.5
    })
    table.insert(self.zones, 'house_toilet')
end

function Target:initCooking(coords, recipes)
    if not coords then return Debug('Target:initCooking ::: No cooking coords') end
    exports[target_name]:AddBoxZone('house_cooking', coords, Config.TargetLength, Config.TargetWidth, {
        name = 'house_cooking',
        heading = 90.0,
        debugPoly = Config.ZoneDebug,
        minZ = coords.z - 15.0,
        maxZ = coords.z + 5.0,
    }, {
        options = {
            {
                icon = 'fa-solid fa-fire-burner',
                label = i18n.t('target.cooking_interaction'),
                action = function()
                    common:openCooking(recipes)
                end,
                canInteract = function(entity, distance, data)
                    return true
                end,
            },
        },
        distance = 2.5
    })
    table.insert(self.zones, 'house_cooking')
end

function Target:initShellInteractions()
    local houseData = Config.Houses[EnteredHouse]
    if not houseData then return end
    if houseData.mlo then return end
    if houseData.ipl then return end
    if not houseData.tier then return end

    local shellData = Config.Shells[houseData.tier]
    if not shellData then return end

    local shellCoords = houseData.coords.shellCoords
    local shellPos = vec3(shellCoords.x, shellCoords.y, shellCoords.z)
    local shellHeading = shellCoords.h or 0.0

    if shellData.shower then
        local showerOffset = shellData.shower.animationOffset or vec4(0.0, 0.0, 0.0, 0.0)
        local showerCoords = GetCoordsWithOffset(vec4(shellPos.x, shellPos.y, shellPos.z, shellHeading), vec3(showerOffset.x, showerOffset.y, showerOffset.z))
        Target:initShower(vec3(showerCoords.x, showerCoords.y, showerCoords.z), shellCoords, shellHeading, shellData.shower)
    end

    if shellData.sink then
        local sinkOffset = shellData.sink.animationOffset or vec4(0.0, 0.0, 0.0, 0.0)
        local sinkCoords = GetCoordsWithOffset(vec4(shellPos.x, shellPos.y, shellPos.z, shellHeading), vec3(sinkOffset.x, sinkOffset.y, sinkOffset.z))
        Target:initSink(vec3(sinkCoords.x, sinkCoords.y, sinkCoords.z), shellCoords, shellHeading, shellData.sink)
    end

    if shellData.toilet then
        local toiletOffset = shellData.toilet.animationOffset or vec4(0.0, 0.0, 0.0, 0.0)
        local toiletCoords = GetCoordsWithOffset(vec4(shellPos.x, shellPos.y, shellPos.z, shellHeading), vec3(toiletOffset.x, toiletOffset.y, toiletOffset.z))
        Target:initToilet(vec3(toiletCoords.x, toiletCoords.y, toiletCoords.z), shellCoords, shellHeading, shellData.toilet)
    end

    if shellData.cooking then
        local cookingOffset = shellData.cooking.animationOffset or vec4(0.0, 0.0, 0.0, 0.0)
        local cookingCoords = GetCoordsWithOffset(vec4(shellPos.x, shellPos.y, shellPos.z, shellHeading), vec3(cookingOffset.x, cookingOffset.y, cookingOffset.z))
        local recipes = shellData.cooking.recipes or Config.CookingRecipes
        Target:initCooking(vec3(cookingCoords.x, cookingCoords.y, cookingCoords.z), recipes)
    end

    Debug('Target:initShellInteractions')
end

function Target:initIplInteractions()
    local houseData = Config.Houses[EnteredHouse]
    if not houseData then return end
    if not houseData.ipl then return end
    if not houseData.ipl.houseName then return end

    local iplData = Config.IplData[houseData.ipl.houseName]
    if not iplData then return end

    local iplCoords = iplData.iplCoords

    if iplData.shower then
        local showerOffset = iplData.shower.animationOffset or vec4(0.0, 0.0, 0.0, 0.0)
        local showerCoords = GetCoordsWithOffset(vec4(iplCoords.x, iplCoords.y, iplCoords.z, 0.0), vec3(showerOffset.x, showerOffset.y, showerOffset.z))
        Target:initShower(vec3(showerCoords.x, showerCoords.y, showerCoords.z), iplCoords, 0.0, iplData.shower)
    end

    if iplData.sink then
        local sinkOffset = iplData.sink.animationOffset or vec4(0.0, 0.0, 0.0, 0.0)
        local sinkCoords = GetCoordsWithOffset(vec4(iplCoords.x, iplCoords.y, iplCoords.z, 0.0), vec3(sinkOffset.x, sinkOffset.y, sinkOffset.z))
        Target:initSink(vec3(sinkCoords.x, sinkCoords.y, sinkCoords.z), iplCoords, 0.0, iplData.sink)
    end

    if iplData.toilet then
        local toiletOffset = iplData.toilet.animationOffset or vec4(0.0, 0.0, 0.0, 0.0)
        local toiletCoords = GetCoordsWithOffset(vec4(iplCoords.x, iplCoords.y, iplCoords.z, 0.0), vec3(toiletOffset.x, toiletOffset.y, toiletOffset.z))
        Target:initToilet(vec3(toiletCoords.x, toiletCoords.y, toiletCoords.z), iplCoords, 0.0, iplData.toilet)
    end

    if iplData.cooking then
        local cookingOffset = iplData.cooking.animationOffset or vec4(0.0, 0.0, 0.0, 0.0)
        local cookingCoords = GetCoordsWithOffset(vec4(iplCoords.x, iplCoords.y, iplCoords.z, 0.0), vec3(cookingOffset.x, cookingOffset.y, cookingOffset.z))
        local recipes = iplData.cooking.recipes or Config.CookingRecipes
        Target:initCooking(vec3(cookingCoords.x, cookingCoords.y, cookingCoords.z), recipes)
    end

    Debug('Target:initIplInteractions')
end

function Target:destroyInteractionZones()
    exports[target_name]:RemoveZone('house_shower')
    exports[target_name]:RemoveZone('house_sink')
    exports[target_name]:RemoveZone('house_toilet')
    exports[target_name]:RemoveZone('house_cooking')
end

function Target:initInsideInteractions()
    exports[target_name]:RemoveZone('house_wardrobe')
    exports[target_name]:RemoveZone('house_stash')
    exports[target_name]:RemoveZone('house_logout')
    Target:destroyTablet()
    Target:destroyInteractionZones()
    Target:initWardrobe()
    Target:initStash()
    Target:initLogout()
    Target:initTablet()
    Target:initShellInteractions()
    Target:initIplInteractions()
    Debug('Target:initInsideInteractions')
end

function Target:formatHouses()
    self.houses = table.filter(self.houses, function(house)
        return not house.apartmentNumber or house.apartmentNumber == 'apt-0'
    end)
end

RegisterNetEvent('housing:initHouses', function(houseConfig)
    Target.houses = houseConfig
    Target:formatHouses()
    Target:init()

    if not modelsRegistered then
        modelsRegistered = true

        if Target.initObjectInteractions then
            Target:initObjectInteractions()
        end

        if Target.initFurnitureInteractions then
            Target:initFurnitureInteractions()
        end
    end
end)






