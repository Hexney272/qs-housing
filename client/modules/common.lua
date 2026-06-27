_G.common = {}

function common:GetShowerAnimDict(isFemale)
    if isFemale then
        return "ANIM@MP_YACHT@SHOWER@FEMALE@"
    end
    return "ANIM@MP_YACHT@SHOWER@MALE@"
end

function common:GetShowerIdleAnim(isFemale, index)
    local prefix
    if isFemale then
        prefix = "shower_idle_"
    else
        prefix = "male_shower_idle_"
    end
    local suffixes = { "a", "b", "c", "d" }
    local suffix = suffixes[index] or "a"
    return prefix .. suffix
end

common.bathtub = { isInBathtub = false }

local bathtubState = {
    waterFallPtfx = nil,
    waterObject = nil,
    objectHandle = nil,
    fillThreadActive = false,
}

common.shower = { isInShower = false }

local showerState = {
    ptfxHandle = nil,
    animDict = nil,
    animName = nil,
}


function common:useShower(coords, heading, options)
    if not coords or not options then
        return
    end

    if self.shower.isInShower then
        if showerState.ptfxHandle then
            StopParticleFxLooped(showerState.ptfxHandle, false)
            showerState.ptfxHandle = nil
        end
        self.shower.isInShower = false
        showerState.animDict = nil
        showerState.animName = nil
        return
    end

    local ptfxOffset = options.ptfxOffset or vec3(0.0, 0.0, 0.0)
    local animationOffset = options.animationOffset or vec4(0.0, 0.0, 0.0, 0.0)

    local pos = vec3(coords.x, coords.y, coords.z)
    local h = heading or 0.0
    if not heading then
        h = 0.0
    end

    local ptfxCoords = GetCoordsWithOffset(vec4(pos.x, pos.y, pos.z, h), ptfxOffset)
    local animCoords = GetCoordsWithOffset(vec4(pos.x, pos.y, pos.z, h), vec3(animationOffset.x, animationOffset.y, animationOffset.z))

    RequestNamedPtfxAsset("scr_mp_house")
    while not HasNamedPtfxAssetLoaded("scr_mp_house") do
        Wait(0)
    end
    UseParticleFxAssetNextCall("scr_mp_house")

    local pedModel = GetEntityModel(cache.ped)
    local femaleHash = joaat("mp_f_freemode_01")
    local isFemale = pedModel == femaleHash

    local animDict = self:GetShowerAnimDict(isFemale)
    local animName = self:GetShowerIdleAnim(isFemale, 1)

    lib.requestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(0)
    end


    SetEntityCoords(cache.ped, animCoords.x, animCoords.y, animCoords.z, false, false, false, false)

    local finalHeading = animationOffset.w or 0.0
    finalHeading = (h + finalHeading) % 360.0
    SetEntityHeading(cache.ped, finalHeading)

    lib.playAnim(cache.ped, animDict, animName, 8.0, -8.0, -1, 1, 0, false)

    local ptfxHandle = StartParticleFxLoopedAtCoord("ent_amb_shower", ptfxCoords.x, ptfxCoords.y, ptfxCoords.z, -45.0, 0.0, 0.0, 1.0, false, false, false, false)

    Utils.stripPlayer()

    self.shower.isInShower = true
    showerState.ptfxHandle = ptfxHandle
    showerState.animDict = animDict
    showerState.animName = animName

    CreateThread(function()
        while self.shower.isInShower do
            Wait(100)
            if not IsEntityPlayingAnim(cache.ped, animDict, animName, 3) then
                lib.playAnim(cache.ped, animDict, animName, 8.0, -8.0, -1, 1, 0, false)
            end
        end
        Utils.restorePlayerClothes()
        ClearPedTasksImmediately(cache.ped)
    end)
end


function common:useSink(entity, options, heading)
    if not options then
        return
    end

    local ptfxOffset = options.ptfxOffset or vec3(0.0, 0.0, 0.0)
    local ptfxCoords = nil

    if type(entity) == "number" then
        if DoesEntityExist(entity) then
            ptfxCoords = GetOffsetFromEntityInWorldCoords(entity, ptfxOffset.x, ptfxOffset.y, ptfxOffset.z)
        end
    else
        local h = heading or 0.0
        if not heading then
            h = 0.0
        end
        local pos = vec3(entity.x, entity.y, entity.z)
        ptfxCoords = GetCoordsWithOffset(vec4(pos.x, pos.y, pos.z, h), ptfxOffset)
    end

    RequestNamedPtfxAsset("scr_mp_house")
    while not HasNamedPtfxAssetLoaded("scr_mp_house") do
        Wait(0)
    end
    UseParticleFxAssetNextCall("scr_mp_house")

    local animationOffset = options.animationOffset or vec4(0.0, 0.0, 0.0, 0.0)
    local pedCoords = nil

    if type(entity) == "number" then
        if DoesEntityExist(entity) then
            pedCoords = GetEntityCoords(cache.ped)
        end
    else
        local h = heading or 0.0
        if not heading then
            h = 0.0
        end
        local pos = vec3(entity.x, entity.y, entity.z)
        pedCoords = GetCoordsWithOffset(vec4(pos.x, pos.y, pos.z, h), vec3(animationOffset.x, animationOffset.y, animationOffset.z))
        SetEntityCoords(cache.ped, pedCoords.x, pedCoords.y, pedCoords.z - 0.7, false, false, false, false)
        local finalHeading = animationOffset.w or 0.0
        finalHeading = (h + finalHeading) % 360.0
        SetEntityHeading(cache.ped, finalHeading)
    end


    lib.playAnim(cache.ped, "missheist_agency3aig_23", "urinal_sink_loop", 8.0, -8.0, -1, 1, 0, false)

    local ptfxHandle = StartParticleFxLoopedAtCoord("ent_amb_shower", ptfxCoords.x, ptfxCoords.y, ptfxCoords.z, -45.0, 0.0, 0.0, 0.2, false, false, false, false)

    Wait(5000)
    StopParticleFxLooped(ptfxHandle, false)
    ClearPedTasks(cache.ped)
end

function common:GetToiletAnimDict(isFemale)
    if isFemale then
        return "timetable@ron@ig_3_couch"
    end
    return "misscarsteal2peeing"
end

function common:GetToiletAnimName(isFemale)
    if isFemale then
        return "base"
    end
    return "peeing_loop"
end

local toiletFemaleOffset = vec4(-0.3, 0.0, 0.0, 0.0)


function common:useToilet(entity, options, heading)
    if not options then
        return
    end

    local pedModel = GetEntityModel(cache.ped)
    local femaleHash = joaat("mp_f_freemode_01")
    local isFemale = pedModel == femaleHash

    local animationOffset = options.animationOffset or vec4(0.0, 0.0, 0.0, 0.0)

    local entityPos = nil
    local pedPos = nil
    local finalHeading = nil

    if type(entity) == "number" then
        if DoesEntityExist(entity) then
            local entityCoords = GetEntityCoords(entity)
            local entityHeading = GetEntityHeading(entity)
            entityPos = vec4(entityCoords.x, entityCoords.y, entityCoords.z, entityHeading)
            toiletFemaleOffset = vec4(0.3, 0.0, 0.0, 0.0)
        end
    else
        local h = heading or 0.0
        if not heading then
            h = 0.0
        end
        entityPos = vec4(entity.x, entity.y, entity.z, h)
        toiletFemaleOffset = vec4(-0.3, 0.0, 0.0, 0.0)
    end

    local baseHeading = entityPos.w
    local headingOffset = animationOffset.w or 0.0
    finalHeading = baseHeading + headingOffset

    if isFemale then
        finalHeading = (finalHeading - 180.0) % 360.0
    end

    if isFemale then
        animationOffset = vec4(
            animationOffset.x + toiletFemaleOffset.x,
            animationOffset.y + toiletFemaleOffset.y,
            animationOffset.z + toiletFemaleOffset.z,
            animationOffset.w
        )
    end


    pedPos = GetCoordsWithOffset(entityPos, vec3(animationOffset.x, animationOffset.y, animationOffset.z))

    SetEntityCoords(cache.ped, pedPos.x, pedPos.y, pedPos.z - 0.7, false, false, false, false)
    SetEntityHeading(cache.ped, finalHeading)

    local animDict = self:GetToiletAnimDict(isFemale)
    local animName = self:GetToiletAnimName(isFemale)

    lib.requestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(0)
    end

    lib.playAnim(cache.ped, animDict, animName, 8.0, -8.0, -1, 1, 0, false)

    local peePtfx = nil
    if not isFemale then
        RequestNamedPtfxAsset("scr_amb_chop")
        while not HasNamedPtfxAssetLoaded("scr_amb_chop") do
            Wait(0)
        end
        UseParticleFxAssetNextCall("scr_amb_chop")
        peePtfx = StartParticleFxLoopedOnEntity("ent_anim_dog_peeing", cache.ped, -0.05, 0.3, 0.0, 0.0, 90.0, 90.0, 1.0, false, false, false)
    end

    Wait(5000)

    if peePtfx then
        StopParticleFxLooped(peePtfx, false)
    end
    ClearPedTasks(cache.ped)
end


function common:useBathtub(entity, options)
    if not (entity and DoesEntityExist(entity)) then
        return
    end
    if not options then
        return
    end

    if self.bathtub.isInBathtub then
        if bathtubState.waterFallPtfx then
            StopParticleFxLooped(bathtubState.waterFallPtfx, false)
            bathtubState.waterFallPtfx = nil
        end
        if bathtubState.waterObject then
            if DoesEntityExist(bathtubState.waterObject) then
                DeleteObject(bathtubState.waterObject)
                bathtubState.waterObject = nil
            end
        end
        bathtubState.fillThreadActive = false
        ClearPedTasks(cache.ped)
        self.bathtub.isInBathtub = false
        bathtubState.objectHandle = nil
        return
    end

    local animationOffset = options.animationOffset
    local waterFallOffset = options.waterFallOffset
    local fillOffset = options.fillOffset

    local entityCoords = GetEntityCoords(entity)
    local entityHeading = GetEntityHeading(entity)

    local animPos = GetOffsetFromEntityInWorldCoords(entity, animationOffset.x, animationOffset.y, animationOffset.z)

    RequestNamedPtfxAsset("scr_mp_house")
    while not HasNamedPtfxAssetLoaded("scr_mp_house") do
        Wait(0)
    end
    UseParticleFxAssetNextCall("scr_mp_house")


    SetEntityCoords(cache.ped, animPos.x, animPos.y, animPos.z, false, false, false, false)
    SetEntityHeading(cache.ped, entityHeading + animationOffset.w)

    lib.playAnim(cache.ped, "timetable@jimmy@mics3_ig_15@", "mics3_15_base_jimmy", 8.0, -8.0, -1, 1, 0, false)

    local waterFallPos = GetOffsetFromEntityInWorldCoords(entity, waterFallOffset.x, waterFallOffset.y, waterFallOffset.z)
    local ptfxHandle = StartParticleFxLoopedAtCoord("ent_amb_shower", waterFallPos.x, waterFallPos.y, waterFallPos.z, -45.0, 0.0, 0.0, 0.3, false, false, false, false)

    local fillPos = GetOffsetFromEntityInWorldCoords(entity, fillOffset.x, fillOffset.y, fillOffset.z)

    local waterModel = joaat("custom_water_01")
    lib.requestModel(waterModel, Config.DefaultRequestModelTimeout)

    local baseZ = fillPos.z
    local targetHeight = baseZ + 0.3
    local waterObj = CreateObject(waterModel, fillPos.x, fillPos.y, baseZ, false, false, false)

    SetEntityCompletelyDisableCollision(waterObj, true, false)
    FreezeEntityPosition(waterObj, false)
    SetEntityInvincible(waterObj, true)
    SetEntityAsMissionEntity(waterObj, true, true)
    SetEntityHeading(waterObj, entityHeading)

    bathtubState.waterObject = waterObj
    bathtubState.fillThreadActive = true


    CreateThread(function()
        local fillDuration = 15000
        local startTime = GetGameTimer()

        while bathtubState.fillThreadActive and self.bathtub.isInBathtub and DoesEntityExist(entity) and DoesEntityExist(waterObj) do
            local elapsed = GetGameTimer() - startTime
            local progress = math.min(elapsed / fillDuration, 1.0)

            local eased
            if progress < 0.5 then
                eased = 2.0 * progress * progress
            else
                local inv = 1.0 - progress
                eased = 1.0 - (2.0 * inv * inv)
            end

            local currentZ = baseZ + eased * targetHeight
            local objCoords = GetEntityCoords(waterObj)
            SetEntityCoords(waterObj, objCoords.x, objCoords.y, currentZ, false, false, false, false)
            Wait(16)
        end
    end)

    self.bathtub.isInBathtub = true
    bathtubState.waterFallPtfx = ptfxHandle
    bathtubState.objectHandle = entity
end

common.cooking = { isCooking = false }


function common:openCooking(recipes)
    if self.cooking.isCooking then
        return
    end
    if not recipes then
        recipes = Config.CookingRecipes
    end
    SendReactMessage("toggle_cooking", { visible = true, recipes = recipes })
    SetNuiFocus(true, true)
end

local scenarioObjectHashes = {
    -598185919, -1412276716, -1254540419, 692857360, 1027109416,
    -1555713785, -1630172026, -960996301, -708789241, 2017086435,
    974883178, -245386275, -533655168, -1109340972, -801803927,
    591916419, -1425058769, -461945070, -693032058, 2010247122,
    1151364435, -1934174148, 176137803, -2013814998, -1910604593,
    1338703913, -334989242, -839348691, 679927467, -66965919,
    -110986183, -1199910959, -113902346, -127739306, 1360563376,
    2052737670, -1010290664, -580196246, -969349845,
}


function common:cleanScenarioObjects(ped)
    local pedCoords = GetEntityCoords(ped)
    for i = 1, #scenarioObjectHashes do
        local obj = GetClosestObjectOfType(pedCoords.x, pedCoords.y, pedCoords.z, 1.0, scenarioObjectHashes[i], false, true, true)
        if DoesEntityExist(obj) then
            SetEntityAsMissionEntity(obj, false, false)
            DeleteObject(obj)
        end
    end
end

function common:startCooking(recipe)
    if not recipe then
        return
    end
    self.cooking.isCooking = true

    local pedCoords = GetEntityCoords(cache.ped)
    local pedHeading = GetEntityHeading(cache.ped)

    TaskStartScenarioAtPosition(cache.ped, "PROP_HUMAN_BBQ", pedCoords.x, pedCoords.y, pedCoords.z, pedHeading, -1, false, true)

    local label = i18n.t("cooking.cooking", { item = recipe.title })
    if not label then
        label = string.format("Cooking %s...", recipe.title)
    end

    local success = lib.progressCircle({
        duration = recipe.time,
        label = label,
        position = "bottom",
        useWhileDead = false,
        canCancel = true,
        disable = { car = true, move = true, combat = true },
    })


    if success then
        ClearPedTasks(cache.ped)
        TriggerServerEvent("housing:finishCooking", recipe.title)
    else
        ClearPedTasks(cache.ped)
        local msg = i18n.t("cooking.cancelled") or "Cooking cancelled"
        Notification(msg, "error")
    end

    self:cleanScenarioObjects(cache.ped)
    self.cooking.isCooking = false
end

RegisterNUICallback("cooking:cook", function(data, cb)
    local recipe = data.recipe
    if not recipe then
        cb(false)
        return
    end

    SendReactMessage("toggle_cooking", { visible = false, recipes = {} })
    SetNuiFocus(false, false)

    local result = lib.callback.await("housing:cook", false, recipe)
    if result then
        cb("ok")
    else
        cb(false)
    end
end)

RegisterNUICallback("cooking:close", function(data, cb)
    SendReactMessage("toggle_cooking", { visible = false, recipes = {} })
    SetNuiFocus(false, false)
    cb("ok")
end)


common.dancers = {}

local activeDancers = {}

local function cleanupAllDancers()
    for _, dancer in pairs(activeDancers) do
        if dancer.ped and DoesEntityExist(dancer.ped) then
            DeleteEntity(dancer.ped)
        end
    end
    activeDancers = {}
end

local function getStreamingDistances(pedType, defaultSpawn, defaultDespawn)
    local pedStreaming = Config.PedStreaming or {}
    local defaults = pedStreaming.default or {}
    local specific = pedStreaming[pedType] or {}

    local spawnDistance = specific.spawnDistance or defaults.spawnDistance or defaultSpawn
    local despawnDistance = specific.despawnDistance or defaults.despawnDistance or defaultDespawn

    if spawnDistance >= despawnDistance then
        despawnDistance = spawnDistance + 5.0
    end

    return spawnDistance, despawnDistance
end

local function getDistanceToDancer(dancerData)
    local dancerPos = vec3(dancerData.coords.x, dancerData.coords.y, dancerData.coords.z)
    local playerPos = GetEntityCoords(cache.ped)
    return #(playerPos - dancerPos)
end


local function spawnDancerPed(dancerData)
    local pedModel = dancerData.pedModel
    local coords = dancerData.coords
    local animDict = dancerData.anim and dancerData.anim.dict or nil
    local animName = dancerData.anim and dancerData.anim.name or nil

    if not pedModel or not coords then
        return nil, animDict, animName
    end

    lib.requestModel(pedModel, Config.DefaultRequestModelTimeout)

    local heading = 0.0
    if type(coords) == "table" then
        heading = coords.w or coords.heading or 0.0
    end

    local ped = CreatePed(28, pedModel, coords.x, coords.y, coords.z - 1.0, heading, true, false)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityCollision(ped, false, false)
    SetPedDefaultComponentVariation(ped)
    SetPedRandomProps(ped)

    if animDict and animName then
        lib.requestAnimDict(animDict)
        TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, 1, 0, false, false, false)
    end

    SetModelAsNoLongerNeeded(pedModel)
    return ped, animDict, animName
end


local function getAvailableDancers()
    local dancers = {}
    for _, dancer in ipairs(Config.Dancers) do
        table.insert(dancers, {
            title = dancer.title,
            description = dancer.description,
            price = dancer.price,
            pedModel = dancer.pedModel,
            anim = dancer.anim,
            image = dancer.image,
            time = dancer.time,
        })
    end
    return dancers
end

function common:getDancers()
    local pending = lib.callback.await("housing:getDancers", false, CurrentHouse)
    local result = {}
    result.available = getAvailableDancers()
    result.pending = pending or {}
    return result
end

function common:spawnDancer(dancerData)
    if not (dancerData and dancerData.coords) then
        return
    end

    if not (CurrentHouse and CurrentHouse == dancerData.house) then
        return
    end

    local spawnDist = getStreamingDistances("dancers", 35.0, 45.0)

    local ped = nil
    local animDict = dancerData.anim and dancerData.anim.dict or nil
    local animName = dancerData.anim and dancerData.anim.name or nil

    local distance = getDistanceToDancer(dancerData)
    if spawnDist >= distance then
        ped, animDict, animName = spawnDancerPed(dancerData)
    end

    activeDancers[dancerData.id] = {
        data = dancerData,
        ped = ped,
        animDict = animDict,
        animName = animName,
    }
end


function common:removeDancer(dancerId)
    local dancer = activeDancers[dancerId]
    if not dancer then
        return
    end

    if dancer.ped and DoesEntityExist(dancer.ped) then
        DeleteEntity(dancer.ped)
    end

    activeDancers[dancerId] = nil
end

function common:cleanupRuntimeOnHouseExit()
    local ped = cache.ped

    if showerState.ptfxHandle then
        StopParticleFxLooped(showerState.ptfxHandle, false)
        showerState.ptfxHandle = nil
    end
    self.shower.isInShower = false
    showerState.animDict = nil
    showerState.animName = nil

    if bathtubState.waterFallPtfx then
        StopParticleFxLooped(bathtubState.waterFallPtfx, false)
        bathtubState.waterFallPtfx = nil
    end
    if bathtubState.waterObject then
        if DoesEntityExist(bathtubState.waterObject) then
            DeleteObject(bathtubState.waterObject)
            bathtubState.waterObject = nil
        end
    end
    bathtubState.objectHandle = nil
    bathtubState.fillThreadActive = false
    self.bathtub.isInBathtub = false

    cleanupAllDancers()


    if self.robbery.carryingFurniture then
        local carriedObj = self.robbery.carriedObject
        if carriedObj and DoesEntityExist(carriedObj) then
            DetachEntity(carriedObj, false, false)
            SetEntityCompletelyDisableCollision(carriedObj, false, false)
            FreezeEntityPosition(carriedObj, true)
        end
    end
    self.robbery.carryingFurniture = false
    self.robbery.carriedObject = nil
    self.robbery.carriedObjectData = nil

    if ped and DoesEntityExist(ped) then
        self:cleanScenarioObjects(ped)
        ClearPedTasksImmediately(ped)
    end
end

function common:dancersTick()
    CreateThread(function()
        while CurrentHouse do
            Wait(1000)
            if CurrentHouse then
                local spawnDist, despawnDist = getStreamingDistances("dancers", 35.0, 45.0)

                for _, dancer in pairs(activeDancers) do
                    if dancer.data and dancer.data.coords and dancer.data.house == CurrentHouse then
                        local distance = getDistanceToDancer(dancer.data)

                        if dancer.ped and DoesEntityExist(dancer.ped) then
                            if despawnDist <= distance then
                                DeleteEntity(dancer.ped)
                                dancer.ped = nil
                            end
                        else
                            local pedExists = dancer.ped and DoesEntityExist(dancer.ped)
                            if not pedExists and spawnDist >= distance then
                                dancer.ped, dancer.animDict, dancer.animName = spawnDancerPed(dancer.data)
                            end
                        end
                    end


                    if dancer.ped and DoesEntityExist(dancer.ped) then
                        if dancer.animDict and dancer.animName then
                            if not IsEntityPlayingAnim(dancer.ped, dancer.animDict, dancer.animName, 3) then
                                TaskPlayAnim(dancer.ped, dancer.animDict, dancer.animName, 8.0, -8.0, -1, 1, 0, false, false, false)
                            end
                        end
                    else
                        dancer.ped = nil
                    end
                end
            end
        end
    end)
end

RegisterNUICallback("dancers:order", function(data, cb)
    if not Config.DancersEnabled then
        return cb(false)
    end

    local title = data.title
    local price = data.price

    local success = lib.callback.await("housing:orderDancer", false, CurrentHouse, title, price)
    if success then
        Notification(i18n.t("dancers.order_placed"), "success")
        management:updateUI()
    else
        Notification(i18n.t("no_money", { price = price }), "error")
    end
    cb(success)
end)


RegisterNUICallback("dancers:place", function(data, cb)
    if not Config.DancersEnabled then
        return cb(false)
    end

    local dancerId = data.dancerId
    local coords = data.coords

    local success = lib.callback.await("housing:placeDancer", false, dancerId, coords)
    if success then
        Notification(i18n.t("dancers.placed"), "success")
        management:updateUI()
    else
        Notification(i18n.t("dancers.place_failed"), "error")
    end
    cb(success)
end)

RegisterNUICallback("dancers:remove", function(data, cb)
    if not Config.DancersEnabled then
        return cb(false)
    end

    local success = lib.callback.await("housing:removeDancer", false, data)
    if success then
        Notification(i18n.t("dancers.removed"), "success")
        management:updateUI()
    else
        Notification(i18n.t("dancers.remove_failed"), "error")
    end
    cb(success)
end)

RegisterNetEvent("housing:spawnDancer", function(dancerData)
    common:spawnDancer(dancerData)
end)

RegisterNetEvent("housing:removeDancer", function(dancerId)
    common:removeDancer(dancerId)
end)


AddEventHandler("housing:onExitHouse", function()
    common:cleanupRuntimeOnHouseExit()
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        common:cleanupRuntimeOnHouseExit()
    end
end)

local function getAvailableDeliveries()
    local deliveries = {}
    for _, delivery in ipairs(Config.Deliveries) do
        table.insert(deliveries, {
            title = delivery.title,
            description = delivery.description,
            price = delivery.price,
            items = delivery.items,
        })
    end
    return deliveries
end

function common:getDeliveries()
    local pending = lib.callback.await("housing:getDeliveries", false, CurrentHouse)
    local result = {}
    result.available = getAvailableDeliveries()
    result.pending = pending or {}
    return result
end


RegisterNUICallback("delivery:order", function(data, cb)
    if not Config.DeliveriesEnabled then
        return cb(false)
    end

    local title = data.title
    local price = data.price
    local items = data.items

    lib.callback("housing:orderDelivery", false, function(success)
        if success then
            Notification(i18n.t("delivery.order_placed"), "success")
            management:updateUI()
        else
            Notification(i18n.t("no_money", { price = price }), "error")
        end
        cb(success)
    end, CurrentHouse, title, price, items)
end)

RegisterNUICallback("delivery:collect", function(data, cb)
    if not Config.DeliveriesEnabled then
        return cb(false)
    end

    lib.callback("housing:collectDelivery", false, function(success)
        if success then
            Notification(i18n.t("delivery.collected"), "success")
            management:updateUI()
        else
            Notification(i18n.t("no_permission"), "error")
        end
        cb(success)
    end, data)
end)


common.robbery = {
    carryingFurniture = false,
    carriedObject = nil,
    carriedObjectData = nil,
}

local CARRY_ANIM_DICT = "anim@heists@box_carry@"
local CARRY_ANIM_NAME = "idle"

function common:startCarryingFurniture(object, objectData)
    if self.robbery.carryingFurniture then
        return
    end
    if not DoesEntityExist(object) then
        return
    end

    lib.requestAnimDict(CARRY_ANIM_DICT)
    TaskPlayAnim(cache.ped, CARRY_ANIM_DICT, CARRY_ANIM_NAME, 8.0, -8.0, -1, 49, 0, false, false, false)

    local boneIndex = GetPedBoneIndex(cache.ped, 18905)
    AttachEntityToEntity(object, cache.ped, boneIndex, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
    SetEntityCompletelyDisableCollision(object, true, false)
    FreezeEntityPosition(object, false)

    self.robbery.carryingFurniture = true
    self.robbery.carriedObject = object
    self.robbery.carriedObjectData = objectData

    Notification(i18n.t("robbery.carrying_furniture"), "info")
end


function common:stopCarryingFurniture(placeOnGround)
    if not self.robbery.carryingFurniture then
        return
    end

    local carriedObj = self.robbery.carriedObject
    local carriedData = self.robbery.carriedObjectData

    if carriedObj and DoesEntityExist(carriedObj) then
        DetachEntity(carriedObj, false, false)
        if placeOnGround then
            local pedCoords = GetEntityCoords(cache.ped)
            SetEntityCoords(carriedObj, pedCoords.x, pedCoords.y, pedCoords.z, false, false, false, false)
            PlaceObjectOnGroundProperly(carriedObj)
            SetEntityCompletelyDisableCollision(carriedObj, false, false)
            FreezeEntityPosition(carriedObj, true)
        end
    end

    ClearPedTasks(cache.ped)
    self.robbery.carryingFurniture = false
    self.robbery.carriedObject = nil
    self.robbery.carriedObjectData = nil
    Notification(i18n.t("robbery.dropped_furniture"), "info")
end

function common:pickupFurniture(object, objectData)
    if self.robbery.carryingFurniture then
        return
    end
    if not DoesEntityExist(object) then
        return
    end
    self:startCarryingFurniture(object, objectData)
end


function common:stealAtExit(houseId)
    if not self.robbery.carryingFurniture then
        return
    end
    if not self.robbery.carriedObjectData then
        return
    end

    local carriedObj = self.robbery.carriedObject
    local carriedData = self.robbery.carriedObjectData

    if carriedObj and DoesEntityExist(carriedObj) then
        DeleteObject(carriedObj)
    end

    ClearPedTasks(cache.ped)
    self.robbery.carryingFurniture = false
    self.robbery.carriedObject = nil

    if carriedData and carriedData.id then
        TriggerServerEvent("housing:robbery:stealFurniture", houseId, carriedData.id, carriedData)
    end

    self.robbery.carriedObjectData = nil
    Notification(i18n.t("robbery.furniture_stolen"), "success")
end

RegisterNetEvent("housing:startCooking", function(recipe)
    common:startCooking(recipe)
end)


CreateThread(function()
    while true do
        local sleepTime = 500
        local ped = cache.ped

        if common.robbery.carryingFurniture then
            if DoesEntityExist(ped) then
                sleepTime = 0
                if not IsEntityPlayingAnim(ped, CARRY_ANIM_DICT, CARRY_ANIM_NAME, 3) then
                    TaskPlayAnim(ped, CARRY_ANIM_DICT, CARRY_ANIM_NAME, 8.0, -8.0, -1, 49, 0, false, false, false)
                end

                local houseData = Config.Houses[CurrentHouse]
                if houseData then
                    local pedCoords = GetEntityCoords(ped)
                    local exitCoords = nil

                    if houseData.mlo then
                        exitCoords = vec3(houseData.coords.enter.x, houseData.coords.enter.y, houseData.coords.enter.z)
                    elseif houseData.ipl then
                        exitCoords = vec3(houseData.ipl.exit.x, houseData.ipl.exit.y, houseData.ipl.exit.z)
                    elseif houseData.coords.exit then
                        exitCoords = vec3(houseData.coords.exit.x, houseData.coords.exit.y, houseData.coords.exit.z)
                    end

                    local nearExit = exitCoords and #(pedCoords - exitCoords) <= 2

                    if IsControlJustPressed(0, Keys.E) and not nearExit then
                        common:stopCarryingFurniture(true)
                    end
                else
                    if IsControlJustPressed(0, Keys.E) then
                        common:stopCarryingFurniture(true)
                    end
                end
            end
        end

        Wait(sleepTime)
    end
end)


common.robberyNPC = {
    ped = nil,
    spawned = false,
    blip = nil,
}

function common:spawnRobberyNPC()
    if self.robberyNPC.spawned and DoesEntityExist(self.robberyNPC.ped) then
        return
    end

    if not (Config.Robbery and Config.Robbery.sell and Config.Robbery.sell.enabled) then
        return
    end

    local sellConfig = Config.Robbery.sell
    local location = sellConfig.location

    lib.requestModel(sellConfig.pedModel, Config.DefaultRequestModelTimeout)
    local ped = CreatePed(28, sellConfig.pedModel, location.x, location.y, location.z - 1.0, location.w or 0.0, false, false)

    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityCollision(ped, false, false)
    SetPedRandomComponentVariation(ped, 0)
    SetPedRandomProps(ped)

    if sellConfig.anim and sellConfig.anim.dict and sellConfig.anim.name then
        lib.requestAnimDict(sellConfig.anim.dict)
        TaskPlayAnim(ped, sellConfig.anim.dict, sellConfig.anim.name, 8.0, -8.0, -1, 1, 0, false, false, false)
    end

    self.robberyNPC.ped = ped
    self.robberyNPC.spawned = true


    if sellConfig.blip and sellConfig.blip.enabled then
        local blipConfig = sellConfig.blip
        local blipText = blipConfig.text or i18n.t("robbery.blip_name") or "Fence"

        self.robberyNPC.blip = Utils.CreateBlip({
            location = location,
            sprite = blipConfig.sprite or 1,
            color = blipConfig.color or 4,
            scale = blipConfig.scale or 1.0,
            text = blipText,
            shortRange = true,
        })
    end

    SetModelAsNoLongerNeeded(sellConfig.pedModel)
end

function common:deleteRobberyNPC()
    if self.robberyNPC.ped and DoesEntityExist(self.robberyNPC.ped) then
        DeleteEntity(self.robberyNPC.ped)
    end
    if self.robberyNPC.blip then
        Utils.RemoveBlip(self.robberyNPC.blip)
    end
    self.robberyNPC.ped = nil
    self.robberyNPC.blip = nil
    self.robberyNPC.spawned = false
end


CreateThread(function()
    while true do
        Wait(1000)

        local robberyConfig = Config.Robbery
        local sellConfig = robberyConfig and robberyConfig.sell

        if not (sellConfig and sellConfig.enabled and sellConfig.location) then
            if common.robberyNPC.spawned then
                common:deleteRobberyNPC()
            end
        else
            local spawnDist, despawnDist = getStreamingDistances("robbery", 70.0, 85.0)
            local playerPos = GetEntityCoords(cache.ped)
            local npcPos = vec3(sellConfig.location.x, sellConfig.location.y, sellConfig.location.z)
            local distance = #(playerPos - npcPos)

            if spawnDist >= distance then
                if not common.robberyNPC.spawned then
                    common:spawnRobberyNPC()
                end
            elseif despawnDist <= distance then
                if common.robberyNPC.spawned then
                    common:deleteRobberyNPC()
                end
            end
        end
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        common:deleteRobberyNPC()
    end
end)


CreateThread(function()
    while true do
        local sleepTime = 1000

        if common.robberyNPC.spawned and DoesEntityExist(common.robberyNPC.ped) then
            local playerPos = GetEntityCoords(cache.ped)
            local npcPos = GetEntityCoords(common.robberyNPC.ped)
            local distance = #(playerPos - npcPos)

            if distance < 2.0 then
                sleepTime = 0
                local drawText = i18n.t("drawtext.sell_furniture")
                DrawText3D(npcPos.x, npcPos.y, npcPos.z + 0.3, drawText, "sell_furniture_npc", "E")

                if IsControlJustPressed(0, Keys.E) then
                    local stolenFurniture = lib.callback.await("housing:robbery:getStolenFurniture", false)
                    if not stolenFurniture or #stolenFurniture == 0 then
                        Notification(i18n.t("robbery.no_stolen_furniture") or "You have no stolen furniture", "error")
                    else
                        SendReactMessage("toggle_robbery_sell", { visible = true, furniture = stolenFurniture })
                        SetNuiFocus(true, true)
                    end
                end
            end
        end

        Wait(sleepTime)
    end
end)

RegisterNUICallback("robbery_sell:close", function(data, cb)
    SendReactMessage("toggle_robbery_sell", { visible = false, furniture = {} })
    SetNuiFocus(false, false)
    cb("ok")
end)

RegisterNUICallback("robbery_sell:sell", function(data, cb)
    local furnitureId = data.furnitureId
    if not furnitureId then
        cb(false)
        return
    end
    TriggerServerEvent("housing:robbery:sellFurniture", furnitureId)
    cb("ok")
end)
