TestNotMLO = false
ShowRoomDefaultCoords = false
ShowingHouse = false

local function roundNumber(value)
    return math.floor(value + 0.5)
end

-- Pre-cache translated strings for draw text prompts
local textFurnitureEvent = i18n.t("drawtext.furniture_data_event")
local textStash = i18n.t("drawtext.stash")
local textVaultAccess = i18n.t("drawtext.vault_access")
local textWardrobe = i18n.t("drawtext.wardrobe")
local textDeleteIllegal = i18n.t("drawtext.delete_illegal")
local textCooking = i18n.t("drawtext.cooking")
local textSink = i18n.t("drawtext.sink")
local textToilet = i18n.t("drawtext.toilet")
local textBathtub = i18n.t("drawtext.bathtub")
local textShower = i18n.t("drawtext.shower")
local textStealFurniture = i18n.t("drawtext.steal_furniture")
local textLogout = i18n.t("drawtext.logout")
local textExitHouse = i18n.t("drawtext.exit_house")
local textShowerExit = i18n.t("drawtext.shower_exit")
local textEnterHouse = i18n.t("drawtext.enter_house")
local textEnterApartments = i18n.t("drawtext.enter_apartments")
local textConstruction = i18n.t("drawtext.construction")
local textViewContract = i18n.t("drawtext.view_contract")
local textViewRental = i18n.t("drawtext.view_rental")
local textShowHouse = i18n.t("drawtext.show_house")
local textRingDoor = i18n.t("drawtext.ring_door")


-- ShowRoomLoop: Manages the timer for house visit/showroom mode
local function ShowRoomLoopFunc()
    ShowingHouse = true
    local remainingTime = 60000 * Config.TestRemTime

    CreateThread(function()
        while ShowingHouse do
            local seconds = remainingTime / 1000
            DrawGenericText(i18n.t("drawtext.visit_time", { time = roundNumber(seconds) }))
            if IsControlJustPressed(0, Keys.G) then
                remainingTime = 1000
            end
            Wait(0)
        end
    end)

    CreateThread(function()
        while ShowingHouse do
            remainingTime = remainingTime - 1000
            if remainingTime <= 0 then
                Notification(i18n.t("visit_ended"), "info")
                if not TestNotMLO then
                    DoScreenFadeOut(500)
                    Wait(500)
                    SetEntityCoords(cache.ped, ShowRoomDefaultCoords)
                    ShowingHouse = false
                    Wait(1000)
                    DoScreenFadeIn(500)
                else
                    local houseData = Config.Houses[EnteredHouse]
                    if houseData.ipl then
                        LeaveIplHouse(EnteredHouse, true)
                    else
                        LeaveHouse()
                    end
                end
            end
            Wait(1000)
        end
    end)
end
ShowRoomLoop = ShowRoomLoopFunc


-- Check if a furniture object model is a cooker
local function isCookerObject(objectModel)
    if not Config.Furniture then
        return false
    end
    for category, categoryData in pairs(Config.Furniture) do
        if "navigation" ~= category then
            if categoryData.items then
                for _, item in pairs(categoryData.items) do
                    if item.object == objectModel then
                        if item.cooker then
                            return true
                        end
                    end
                    if item.colors then
                        for _, color in pairs(item.colors) do
                            if color.object == objectModel then
                                if item.cooker then
                                    return true
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return false
end


-- Get sink data for a furniture object model
function GetSinkData(objectModel)
    if not Config.Furniture then
        return nil
    end
    for category, categoryData in pairs(Config.Furniture) do
        if "navigation" ~= category then
            if categoryData.items then
                for _, item in pairs(categoryData.items) do
                    if item.object == objectModel then
                        if item.sink then
                            return item.sink
                        end
                    end
                    if item.colors then
                        for _, color in pairs(item.colors) do
                            if color.object == objectModel then
                                if item.sink then
                                    return item.sink
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return nil
end


-- Get bath data for a furniture object model
function GetBathData(objectModel)
    if not Config.Furniture then
        return nil
    end
    for category, categoryData in pairs(Config.Furniture) do
        if "navigation" ~= category then
            if categoryData.items then
                for _, item in pairs(categoryData.items) do
                    if item.object == objectModel then
                        if item.bath then
                            return item.bath
                        end
                    end
                    if item.colors then
                        for _, color in pairs(item.colors) do
                            if color.object == objectModel then
                                if item.bath then
                                    return item.bath
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return nil
end


-- Get toilet data for a furniture object model
function GetToiletData(objectModel)
    if not Config.Furniture then
        return nil
    end
    for category, categoryData in pairs(Config.Furniture) do
        if "navigation" ~= category then
            if categoryData.items then
                for _, item in pairs(categoryData.items) do
                    if item.object == objectModel then
                        if item.toilet then
                            return item.toilet
                        end
                    end
                    if item.colors then
                        for _, color in pairs(item.colors) do
                            if color.object == objectModel then
                                if item.toilet then
                                    return item.toilet
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return nil
end


-- Furniture interaction loop: handles all placed furniture interactions
local function furnitureInteractionLoop()
    local sleepTime = nil
    local playerCoords = GetEntityCoords(cache.ped)
    local houseId = CurrentHouse
    local isPolice = table.contains(Config.PoliceJobs, GetJobName())
    local houseConfig = Config.Houses[houseId]

    if not houseId then return sleepTime end
    if not decorate.objects then return sleepTime end

    for idx, obj in pairs(decorate.objects) do
        local objPos = vec3(obj.coords.x, obj.coords.y, obj.coords.z)
        local distance = #(objPos - playerCoords)

        if distance <= 2.0 then
            local dynamicFurniture = Config.DynamicFurnitures[obj.modelName]
            local illegalFurniture = Config.IllegalFurnitures[obj.modelName]
            local isCooker = isCookerObject(obj.modelName)
            local sinkData = GetSinkData(obj.modelName)
            local bathData = GetBathData(obj.modelName)
            local toiletData = GetToiletData(obj.modelName)


            -- Cooking interaction
            if isCooker then
                if obj.handle and DoesEntityExist(obj.handle) then
                    local textPos = GetOffsetFromEntityInWorldCoords(obj.handle, 0.0, 0.0, 0.3)
                    sleepTime = 0
                    DrawText3D(textPos.x, textPos.y, textPos.z, textCooking, "cooking_interaction", "E")
                    if IsControlJustPressed(0, Keys.E) then
                        common:openCooking(Config.CookingRecipes)
                    end
                end
            end

            -- Sink interaction
            if sinkData then
                if obj.handle and DoesEntityExist(obj.handle) then
                    local textPos = GetOffsetFromEntityInWorldCoords(obj.handle, 0.0, 0.0, 0.3)
                    sleepTime = 0
                    DrawText3D(textPos.x, textPos.y, textPos.z, textSink, "sink_interaction", "E")
                    if IsControlJustPressed(0, Keys.E) then
                        common:useSink(obj.handle, sinkData)
                    end
                end
            end


            -- Bathtub interaction
            if bathData then
                if obj.handle and DoesEntityExist(obj.handle) then
                    local textPos = GetOffsetFromEntityInWorldCoords(obj.handle, 0.0, 0.0, 0.3)
                    sleepTime = 0
                    local bathtubExitText = i18n.t("drawtext.bathtub_exit")
                    local displayText = (common.bathtub.isInBathtub and bathtubExitText) or textBathtub
                    DrawText3D(textPos.x, textPos.y, textPos.z, displayText, "bathtub_interaction", "E")
                    if IsControlJustPressed(0, Keys.E) then
                        common:useBathtub(obj.handle, bathData)
                    end
                end
            end

            -- Toilet interaction
            if toiletData then
                if obj.handle and DoesEntityExist(obj.handle) then
                    local textPos = GetOffsetFromEntityInWorldCoords(obj.handle, 0.0, 0.0, 0.3)
                    sleepTime = 0
                    DrawText3D(textPos.x, textPos.y, textPos.z, textToilet, "toilet_interaction", "E")
                    if IsControlJustPressed(0, Keys.E) then
                        common:useToilet(obj.handle, toiletData)
                    end
                end
            end


            -- Dynamic furniture interactions (stash, wardrobe, custom event)
            if dynamicFurniture then
                if dynamicFurniture.offset then
                    local textPos = GetOffsetFromEntityInWorldCoords(obj.handle, dynamicFurniture.offset.x, dynamicFurniture.offset.y, dynamicFurniture.offset.z)

                    if dynamicFurniture.event then
                        -- Custom event trigger
                        sleepTime = 0
                        DrawText3D(textPos.x, textPos.y, textPos.z, textFurnitureEvent, "interactorid", "E")
                        if IsControlJustPressed(0, Keys.E) then
                            local uniqId = obj.uniq
                            TriggerEvent(dynamicFurniture.event, uniqId)
                        end
                    elseif "stash" == dynamicFurniture.type then
                        -- Stash access
                        sleepTime = 0
                        DrawText3D(textPos.x, textPos.y, textPos.z, textStash, "stash_access", "E")

                        -- Vault access (if upgraded and owner)
                        if table.includes(houseConfig.upgrades, "vault") then
                            if CurrentHouseData.isOfficialOwner then
                                DrawText3D(textPos.x, textPos.y, textPos.z + 0.4, textVaultAccess, "bault_access", "G")
                                if IsControlJustPressed(0, Keys.G) then
                                    OpenVaultCodeMenu(obj.id)
                                end
                            end
                        end


                        -- Open stash on E press
                        if IsControlJustPressed(0, Keys.E) then
                            local storageId = GetFurnitureStorageId(obj.id)
                            if storageId then
                                if CanAccessStash(obj.id) then
                                    Debug("stashKey", storageId)
                                    openStash(dynamicFurniture.stash, storageId)
                                end
                            end
                        end
                    elseif "wardrobe" == dynamicFurniture.type then
                        -- Wardrobe access
                        sleepTime = 0
                        DrawText3D(textPos.x, textPos.y, textPos.z, textWardrobe, "open_wardrobe", "E")
                        if IsControlJustPressed(0, Keys.E) then
                            openWardrobe()
                        end
                    end
                end
            end


            -- Illegal furniture deletion (police only)
            if illegalFurniture and isPolice then
                local textPos = GetOffsetFromEntityInWorldCoords(obj.handle, illegalFurniture.offset.x, illegalFurniture.offset.y, illegalFurniture.offset.z)
                sleepTime = 0
                DrawText3D(textPos.x, textPos.y, textPos.z, textDeleteIllegal, "stash_access_illegal", "E")
                if IsControlJustPressed(0, Keys.E) then
                    DoorAnim()
                    for objIdx, decorObj in pairs(decorate.objects) do
                        if decorObj.uniq == obj.uniq then
                            TriggerServerEvent("housing:deleteObject", CurrentHouse, objIdx)
                            Debug("Deleted furniture: " .. decorObj.uniq)
                        end
                    end
                end
            end


            -- Steal furniture (robbery)
            if houseConfig.IsRammed then
                if obj.handle and DoesEntityExist(obj.handle) then
                    if not common.robbery.carryingFurniture then
                        local textPos = GetOffsetFromEntityInWorldCoords(obj.handle, 0.0, 0.0, 0.8)
                        sleepTime = 0
                        DrawText3D(textPos.x, textPos.y, textPos.z, textStealFurniture, "steal_furniture", "H")
                        if IsControlJustPressed(0, Keys.H) then
                            common:pickupFurniture(obj.handle, {
                                id = obj.id,
                                uniq = obj.uniq,
                                modelName = obj.modelName,
                                coords = obj.coords
                            })
                            Wait(100)
                        end
                    end
                end
            end
        end
    end

    return sleepTime
end


-- Inside house interaction loop: stash, wardrobe, logout, exit, shell interactions
local function insideHouseLoop()
    local sleepTime = nil
    local houseConfig = Config.Houses[CurrentHouse]

    if EnteringHouse then
        return sleepTime
    end

    local playerCoords = GetEntityCoords(cache.ped)

    -- Static stash point
    if CurrentHouseData.stash then
        local stashPos = vec3(CurrentHouseData.stash.x, CurrentHouseData.stash.y, CurrentHouseData.stash.z)
        local dist = #(playerCoords - stashPos)
        if dist < 2.5 then
            sleepTime = 0
            DrawText3D(stashPos.x, stashPos.y, stashPos.z, textStash, "stash_access2", "E")

            if table.includes(houseConfig.upgrades, "vault") then
                if CurrentHouseData.isOfficialOwner then
                    DrawText3D(stashPos.x, stashPos.y, stashPos.z + 0.4, textVaultAccess, "vault_access2", "G")
                    if IsControlJustPressed(0, Keys.G) then
                        OpenVaultCodeMenu()
                    end
                end
            end

            if IsControlJustPressed(0, Keys.E) then
                if CanAccessStash() then
                    openStash()
                end
            end
        end
    end


    -- Static wardrobe point
    if CurrentHouseData.wardrobe then
        local wardrobePos = vec3(CurrentHouseData.wardrobe.x, CurrentHouseData.wardrobe.y, CurrentHouseData.wardrobe.z)
        local dist = #(playerCoords - wardrobePos)
        if dist < 1.5 then
            sleepTime = 0
            DrawText3D(CurrentHouseData.wardrobe.x, CurrentHouseData.wardrobe.y, CurrentHouseData.wardrobe.z, textWardrobe, "wardrobe_open2", "E")
            if IsControlJustPressed(0, Keys.E) then
                openWardrobe()
            end
        end
    end

    -- Logout point
    if CurrentHouseData.logout then
        local logoutPos = vec3(CurrentHouseData.logout.x, CurrentHouseData.logout.y, CurrentHouseData.logout.z)
        local dist = #(playerCoords - logoutPos)
        if dist < 1.5 then
            sleepTime = 0
            DrawText3D(logoutPos.x, logoutPos.y, logoutPos.z, textLogout, "logout_spot", "E")
            if IsControlJustPressed(0, Keys.E) then
                DoScreenFadeOut(250)
                while not IsScreenFadedOut() do
                    Wait(10)
                end
                DespawnInterior(HouseObj, function()
                    local house = CurrentHouse
                    WeatherSyncEvent(false)
                    local enterCoords = Config.Houses[house].coords.enter
                    SetEntityCoords(cache.ped, enterCoords.x, enterCoords.y, enterCoords.z + 0.5)
                    SetEntityHeading(cache.ped, Config.Houses[house].coords.enter.h)
                    inOwned = false
                    TriggerServerEvent("qb-houses:server:LogoutLocation")
                end)
            end
        end
    end


    -- Exit point determination
    local exitPos = nil
    if houseConfig.mlo then
        if not common.robbery.carryingFurniture then
            return sleepTime
        end
        exitPos = vec3(houseConfig.coords.enter.x, houseConfig.coords.enter.y, houseConfig.coords.enter.z)
    elseif houseConfig.ipl then
        exitPos = vec3(houseConfig.ipl.exit.x, houseConfig.ipl.exit.y, houseConfig.ipl.exit.z)
    else
        if not houseConfig.coords.exit then
            return sleepTime
        end
        exitPos = vec3(houseConfig.coords.exit.x, houseConfig.coords.exit.y, houseConfig.coords.exit.z)
    end

    -- Exit house interaction
    if exitPos then
        local dist = #(playerCoords - vec3(exitPos.x, exitPos.y, exitPos.z))
        if dist <= 2 then
            sleepTime = 0

            -- Steal furniture at exit
            if common.robbery.carryingFurniture then
                local stealText = i18n.t("drawtext.steal_at_exit")
                DrawText3D(exitPos.x, exitPos.y, exitPos.z + 0.3, stealText, "steal_at_exit", "H")
                if IsControlJustPressed(0, Keys.H) then
                    common:stealAtExit(CurrentHouse)
                end
            end

            -- Exit house draw text
            if not Config.DisableHouseEnterExitDrawText then
                DrawText3D(exitPos.x, exitPos.y, exitPos.z, textExitHouse, "exit_house", "E")
            end

            if IsControlJustPressed(0, Keys.E) then
                quickMenu:open()
            end
        end
    end


    -- Shell-based interactions (shower, sink, toilet, cooking)
    if not houseConfig.ipl then
        if houseConfig.tier then
            local shellConfig = Config.Shells[houseConfig.tier]
            if shellConfig then
                local shellCoords = houseConfig.coords.shellCoords
                local shellPos = vec3(shellCoords.x, shellCoords.y, shellCoords.z)
                local shellHeading = shellCoords.h or 0.0

                -- Shell shower interaction
                if shellConfig.shower then
                    local animOffset = shellConfig.shower.animationOffset or vec4(0.0, 0.0, 0.0, 0.0)
                    local showerPos = GetCoordsWithOffset(vec4(shellPos.x, shellPos.y, shellPos.z, shellHeading), vec3(animOffset.x, animOffset.y, animOffset.z))
                    local dist = #(playerCoords - vec3(showerPos.x, showerPos.y, showerPos.z))
                    if dist <= 1.0 then
                        sleepTime = 0
                        local displayText = (common.shower.isInShower and textShowerExit) or textShower
                        local interactionId = common.shower.isInShower and "shower_interaction_exit" or "shower_interaction"
                        DrawText3D(showerPos.x, showerPos.y, showerPos.z, displayText, interactionId, "E")
                        if IsControlJustPressed(0, Keys.E) then
                            common:useShower(shellCoords, shellHeading, shellConfig.shower)
                        end
                    end
                end


                -- Shell sink interaction
                if shellConfig.sink then
                    local animOffset = shellConfig.sink.animationOffset or vec4(0.0, 0.0, 0.0, 0.0)
                    local sinkPos = GetCoordsWithOffset(vec4(shellPos.x, shellPos.y, shellPos.z, shellHeading), vec3(animOffset.x, animOffset.y, animOffset.z))
                    local dist = #(playerCoords - vec3(sinkPos.x, sinkPos.y, sinkPos.z))
                    if dist <= 1.0 then
                        sleepTime = 0
                        DrawText3D(sinkPos.x, sinkPos.y, sinkPos.z, textSink, "sink_shell_interaction", "E")
                        if IsControlJustPressed(0, Keys.E) then
                            common:useSink(shellCoords, shellConfig.sink, shellHeading)
                        end
                    end
                end

                -- Shell toilet interaction
                if shellConfig.toilet then
                    local animOffset = shellConfig.toilet.animationOffset
                    local toiletPos = GetCoordsWithOffset(vec4(shellPos.x, shellPos.y, shellPos.z, shellHeading), vec3(animOffset.x, animOffset.y, animOffset.z))
                    local dist = #(playerCoords - vec3(toiletPos.x, toiletPos.y, toiletPos.z))
                    if dist <= 1.0 then
                        sleepTime = 0
                        DrawText3D(toiletPos.x, toiletPos.y, toiletPos.z, textToilet, "toilet_shell_interaction", "E")
                        if IsControlJustPressed(0, Keys.E) then
                            common:useToilet(shellCoords, shellConfig.toilet, shellHeading)
                        end
                    end
                end


                -- Shell cooking interaction
                if shellConfig.cooking then
                    local animOffset = shellConfig.cooking.animationOffset or vec4(0.0, 0.0, 0.0, 0.0)
                    local cookingPos = GetCoordsWithOffset(vec4(shellPos.x, shellPos.y, shellPos.z, shellHeading), vec3(animOffset.x, animOffset.y, animOffset.z))
                    local dist = #(playerCoords - vec3(cookingPos.x, cookingPos.y, cookingPos.z))
                    if dist <= 2.0 then
                        sleepTime = 0
                        DrawText3D(cookingPos.x, cookingPos.y, cookingPos.z, textCooking, "cooking_shell_interaction", "E")
                        if IsControlJustPressed(0, Keys.E) then
                            local recipes = shellConfig.cooking.recipes or Config.CookingRecipes
                            common:openCooking(recipes)
                        end
                    end
                end
            end
        end
    end


    -- IPL-based interactions (shower, sink, toilet, cooking)
    if houseConfig.ipl then
        if houseConfig.ipl.houseName then
            local iplData = Config.IplData[houseConfig.ipl.houseName]
            if iplData then
                local iplCoords = iplData.iplCoords

                -- IPL shower interaction
                if iplData.shower then
                    local animOffset = iplData.shower.animationOffset or vec4(0.0, 0.0, 0.0, 0.0)
                    local showerPos = GetCoordsWithOffset(vec4(iplCoords.x, iplCoords.y, iplCoords.z, 0.0), vec3(animOffset.x, animOffset.y, animOffset.z))
                    local dist = #(playerCoords - vec3(showerPos.x, showerPos.y, showerPos.z))
                    if dist <= 1.0 then
                        sleepTime = 0
                        local showerExitText = i18n.t("drawtext.shower_exit")
                        local displayText = (common.shower.isInShower and showerExitText) or textShower
                        DrawText3D(showerPos.x, showerPos.y, showerPos.z, displayText, "shower_ipl_interaction", "E")
                        if IsControlJustPressed(0, Keys.E) then
                            common:useShower(iplCoords, 0.0, iplData.shower)
                        end
                    end
                end


                -- IPL sink interaction
                if iplData.sink then
                    local animOffset = iplData.sink.animationOffset or vec4(0.0, 0.0, 0.0, 0.0)
                    local sinkPos = GetCoordsWithOffset(vec4(iplCoords.x, iplCoords.y, iplCoords.z, 0.0), vec3(animOffset.x, animOffset.y, animOffset.z))
                    local dist = #(playerCoords - vec3(sinkPos.x, sinkPos.y, sinkPos.z))
                    if dist <= 1.0 then
                        sleepTime = 0
                        DrawText3D(sinkPos.x, sinkPos.y, sinkPos.z, textSink, "sink_ipl_interaction", "E")
                        if IsControlJustPressed(0, Keys.E) then
                            common:useSink(iplCoords, iplData.sink, 0.0)
                        end
                    end
                end

                -- IPL toilet interaction
                if iplData.toilet then
                    local animOffset = iplData.toilet.animationOffset or vec4(0.0, 0.0, 0.0, 0.0)
                    local toiletPos = GetCoordsWithOffset(vec4(iplCoords.x, iplCoords.y, iplCoords.z, 0.0), vec3(animOffset.x, animOffset.y, animOffset.z))
                    local dist = #(playerCoords - vec3(toiletPos.x, toiletPos.y, toiletPos.z))
                    if dist <= 1.0 then
                        sleepTime = 0
                        DrawText3D(toiletPos.x, toiletPos.y, toiletPos.z, textToilet, "toilet_ipl_interaction", "E")
                        if IsControlJustPressed(0, Keys.E) then
                            common:useToilet(iplCoords, iplData.toilet, 0.0)
                        end
                    end
                end


                -- IPL cooking interaction
                if iplData.cooking then
                    local animOffset = iplData.cooking.animationOffset or vec4(0.0, 0.0, 0.0, 0.0)
                    local cookingPos = GetCoordsWithOffset(vec4(iplCoords.x, iplCoords.y, iplCoords.z, 0.0), vec3(animOffset.x, animOffset.y, animOffset.z))
                    local dist = #(playerCoords - vec3(cookingPos.x, cookingPos.y, cookingPos.z))
                    if dist <= 2.0 then
                        sleepTime = 0
                        DrawText3D(cookingPos.x, cookingPos.y, cookingPos.z, textCooking, "cooking_ipl_interaction", "E")
                        if IsControlJustPressed(0, Keys.E) then
                            local recipes = iplData.cooking.recipes or Config.CookingRecipes
                            common:openCooking(recipes)
                        end
                    end
                end
            end
        end
    end

    return sleepTime
end


-- Enter house loop (outside, non-MLO)
local function enterHouseLoop()
    local sleepTime = nil
    local houseConfig = Config.Houses[CurrentHouse]

    if houseConfig.mlo then
        return sleepTime
    end

    local playerCoords = GetEntityCoords(cache.ped)
    local enterPos = vec3(houseConfig.coords.enter.x, houseConfig.coords.enter.y, houseConfig.coords.enter.z)
    local dist = #(playerCoords - enterPos)

    if dist < 1.5 then
        sleepTime = 0
        if not Config.DisableHouseEnterExitDrawText then
            DrawText3D(enterPos.x, enterPos.y, enterPos.z, textEnterHouse, "enter_this_house", "E")
        end
        if IsControlJustPressed(0, Keys.E) then
            TriggerEvent("qb-houses:client:EnterHouse", houseConfig.ipl)
        end
    end

    return sleepTime
end


-- Apartment entrance loop
local function enterApartmentLoop()
    local sleepTime = 0
    local houseConfig = Config.Houses[CurrentHouse]
    local enterPos = vec3(houseConfig.coords.enter.x, houseConfig.coords.enter.y, houseConfig.coords.enter.z)

    DrawText3D(enterPos.x, enterPos.y, enterPos.z, textEnterApartments, "enter_this_apartment", "E")
    if IsControlJustPressed(0, Keys.E) then
        OpenApartmentMenu()
    end

    return sleepTime
end


-- RedTulip credit print block
local v0,v1,v2,v3=54,"^5","^6","^3";local v4={v1,v2,v3};local v5=[[
   __          _ _____       _ _       
  /__\ ___  __| /__   \_   _| (_)_ __  
 / \/// _ \/ _` | / /\/ | | | | | '_ \ 
/ _  \  __/ (_| |/ /  | |_| | | | |_) |
\/ \_/\___|\__,_|\/    \__,_|_|_| .__/ 
                                |_|    ]];local function v6(v15) return v1   .. "║ ^0"   .. v15   .. (" "):rep(math.max(0,v0-#(v15:gsub("%^.","")) ))   .. " "   .. v1   .. "║^0" ;end local v7=v1   .. "╔"   .. ("═"):rep(v0 + 2 )   .. "╗^0" ;local v8=v1   .. "╠"   .. ("═"):rep(v0 + (182 -(67 + 113)) )   .. "╣^0" ;local v9=v1   .. "║"   .. (" "):rep(v0 + 2 )   .. "║^0" ;local v10=v1   .. "╚"   .. ("═"):rep(v0 + 2 + 0 )   .. "╝^0" ;local function v11(v16) local v17=0 -0 ;local v18;local v19;local v20;while true do if (v17==0) then v18=0;v19=nil;v17=1 + 0 ;end if (1==v17) then v20=nil;while true do if (v18==(3 -2)) then return (" "):rep(v20)   .. v16 ;end if (v18==(952 -(802 + 150))) then v19=v16:gsub("%^.","");v20=math.floor((v0-#v19)/(5 -3) );v18=1 -0 ;end end break;end end end local v12,v13={},1 + 0 ;for v21 in v5:gmatch("[^\n]+") do v12[v13]=v21;v13=v13 + (998 -(915 + 82)) ;end local function v14() local v23=0 -0 ;local v24;local v25;local v26;local v27;while true do if (v23==(2 + 1)) then print(v6(v26));print(v6(v27));print(v10);break;end if (v23==1) then print(v8);v25=v11("^5Do it right ^6or don't do it ^3at all");print(v6(v25));v23=2 -0 ;end if (v23==(1189 -(1069 + 118))) then print(v8);v26=v11("^3>>^0  ^5Discord^9   :   ^2@notsosecure");v27=v11("^3>>^0  ^5Profile^9   :   ^5vag.gg/members/redtulip.251387");v23=6 -3 ;end if (v23==0) then print(v7);v24=1 -0 ;for v28,v29 in ipairs(v12) do local v30="";for v31=1, #v29 do local v32=0 + 0 ;local v33;while true do if ((1 -0)==v32) then v24=v24 + 1 + 0 ;if (v24> #v4) then v24=1;end break;end if (v32==0) then v33=v29:sub(v31,v31);v30=v30   .. v4[v24]   .. v33 ;v32=792 -(368 + 423) ;end end end print(v6(v11(v30)));end v23=3 -2 ;end end end v14();


-- Construction display loop
local function constructionLoop()
    local houseConfig = Config.Houses[CurrentHouse]
    local enterPos = vec3(houseConfig.coords.enter.x, houseConfig.coords.enter.y, houseConfig.coords.enter.z)

    DrawText3D(enterPos.x, enterPos.y, enterPos.z, textConstruction, "finalize_construction", "E")
    if IsControlJustPressed(0, Keys.E) then
        TriggerServerEvent("housing:showConstructionRemaining", CurrentHouse)
    end

    return 0
end


-- Contract/locked house interaction loop
local function lockedHouseLoop()
    local sleepTime = nil

    if not CurrentHouse then
        return sleepTime
    end

    local houseConfig = Config.Houses[CurrentHouse]
    local enterPos = vec3(houseConfig.coords.enter.x, houseConfig.coords.enter.y, houseConfig.coords.enter.z)
    local playerCoords = GetEntityCoords(cache.ped)
    local dist = #(playerCoords - enterPos)

    if dist < 1.5 then
        if houseConfig.construction then
            return constructionLoop()
        end

        if houseConfig.locked then
            sleepTime = 0

            if houseConfig.apartmentNumber then
                return enterApartmentLoop()
            end

            -- Show house button
            DrawText3D(enterPos.x, enterPos.y, enterPos.z + 0.2, textShowHouse, "show_house", "G")
            if IsControlJustPressed(0, Keys.G) then
                InspectHouse(houseConfig)
            end

            -- Contract / rental viewing
            local contractText = textViewContract
            if CurrentHouseData.rentable then
                contractText = textViewRental
            end
            DrawText3D(enterPos.x, enterPos.y, enterPos.z, contractText, "open_contract_type", "E")
            if IsControlJustPressed(0, Keys.E) then
                if CurrentHouseData.rentable then
                    TriggerServerEvent("qb-houses:server:viewHouse", CurrentHouse, true)
                else
                    TriggerServerEvent("qb-houses:server:viewHouse", CurrentHouse)
                end
            end
        end
    end

    return sleepTime
end


-- Door bell / outside owned house loop
local function outsideOwnedHouseLoop()
    local sleepTime = nil

    -- If house is owned but rentable/purchasable, show locked house UI instead
    if CurrentHouseData.isOwned then
        if not CurrentHouseData.rentable then
            if not CurrentHouseData.purchasable then
                goto continueToOwned
            end
        end
    end
    return lockedHouseLoop()

    ::continueToOwned::
    local houseConfig = Config.Houses[CurrentHouse]

    -- MLO houses don't show outside UI
    if houseConfig.mlo then
        return sleepTime
    end

    local playerCoords = GetEntityCoords(cache.ped)

    if CurrentHouse then
        if CurrentHouseData.isOwned then
            if not Config.Houses[CurrentHouse].IsRammed then
                if not CurrentHouseData.rentable then
                    if not CurrentHouseData.purchasable then
                        local enterPos = vec3(
                            Config.Houses[CurrentHouse].coords.enter.x,
                            Config.Houses[CurrentHouse].coords.enter.y,
                            Config.Houses[CurrentHouse].coords.enter.z
                        )
                        local dist = #(playerCoords - enterPos)
                        if dist < 1.5 then
                            sleepTime = 0
                            DrawText3D(enterPos.x, enterPos.y, enterPos.z + 0.4, textRingDoor, "ring_door", "G")
                            if IsControlJustPressed(0, 47) then
                                TriggerEvent("qb-houses:client:RequestRing")
                            end
                        end
                    end
                end
            end
        end
    end

    return sleepTime
end


-- Main interaction thread (non-target mode)
if not Config.UseTarget then
    CreateThread(function()
        while true do
            local sleepTime = 1250

            if not CurrentHouse then
                -- No house nearby, sleep long
            elseif FrontCam then
                -- Front cam active, skip interactions
            else
                local houseConfig = Config.Houses[CurrentHouse]
                if not houseConfig then
                    CurrentHouse = nil
                    Debug("House data not found, clearing house.")
                else
                    if CurrentHouseData.haskey or Config.Houses[CurrentHouse].IsRammed or not Config.Houses[CurrentHouse].locked then
                        -- Player has key or house is rammed/unlocked: show enter + interior interactions
                        local result = enterHouseLoop()
                        sleepTime = result or sleepTime

                        if not result then
                            -- fallthrough
                        end
                    else
                        -- House is locked, player doesn't have key
                        local result = outsideOwnedHouseLoop()
                        sleepTime = result or sleepTime

                        if not result then
                            -- fallthrough
                        end
                    end

                    -- Furniture interactions (always checked when inside)
                    local result = furnitureInteractionLoop()
                    sleepTime = result or sleepTime

                    -- Inside house interactions (always checked when inside)
                    result = insideHouseLoop()
                    sleepTime = result or sleepTime
                end
            end

            Wait(sleepTime)
        end
    end)
end


-- MLO Door management
MLODoorsData = {}

-- Calculate midpoint between two vectors
local function getMidpoint(pos1, pos2)
    return vec3(
        (pos1.x + pos2.x) / 2,
        (pos1.y + pos2.y) / 2,
        (pos1.z + pos2.z) / 2
    )
end

-- Get center position of a door object using its model dimensions
local function getDoorCenterPosition(coords, hash)
    if not hash or not IsModelValid(hash) then
        return coords
    end

    local doorEntity = GetClosestObjectOfType(coords.x, coords.y, coords.z, 1.0, hash, false, false, false)
    if not doorEntity or doorEntity == 0 then
        return coords
    end

    local entityCoords = GetEntityCoords(doorEntity)
    local minDim, maxDim = GetModelDimensions(hash)
    local centerOffset = vec3(
        (minDim.x + maxDim.x) / 2,
        (minDim.y + maxDim.y) / 2,
        (minDim.z + maxDim.z) / 2
    )

    local heading = GetEntityHeading(doorEntity)
    local rad = heading * (math.pi / 180)
    local sinH = math.sin(rad)
    local cosH = math.cos(rad)

    local rotatedX = cosH * centerOffset.x - sinH * centerOffset.y
    local rotatedY = sinH * centerOffset.x + cosH * centerOffset.y

    return vec3(entityCoords.x + rotatedX, entityCoords.y + rotatedY, entityCoords.z + centerOffset.z)
end


-- Initialize MLO door data for a house
local function initMLODoors(houseId)
    local mloDoors = table.deepclone(Config.Houses[houseId].mlo)
    MLODoorsData[houseId] = {}

    for _, doorData in pairs(mloDoors) do
        local doorCoords = vec3(doorData.coords.x, doorData.coords.y, doorData.coords.z)
        local doors = {}
        doors[1] = { tempHandle = doorData.tempHandle, locked = doorData.locked }

        -- Find a paired door nearby (double doors)
        local pairedDoor, pairedIndex = table.find(mloDoors, function(otherDoor, otherIndex)
            local otherPos = vec3(otherDoor.coords.x, otherDoor.coords.y, otherDoor.coords.z)
            return #(otherPos - doorCoords) < Config.DoorDuplicateDistance
        end)

        if pairedDoor then
            table.insert(doors, { tempHandle = pairedDoor.tempHandle, locked = pairedDoor.locked })
            table.remove(mloDoors, pairedIndex)

            local center1 = getDoorCenterPosition(doorCoords, doorData.hash)
            local center2 = getDoorCenterPosition(vec3(pairedDoor.coords.x, pairedDoor.coords.y, pairedDoor.coords.z), pairedDoor.hash)
            doorCoords = getMidpoint(center1, center2)
        else
            doorCoords = getDoorCenterPosition(doorCoords, doorData.hash)
        end

        table.insert(MLODoorsData[houseId], {
            coords = doorCoords,
            doors = doors,
            locked = doorData.locked
        })
    end
end


-- MLO Door interaction thread (non-target mode)
if not Config.UseTarget then
    CreateThread(function()
        while true do
            local sleepTime = 1250
            local playerCoords = GetEntityCoords(cache.ped)

            if CurrentHouse and CurrentHouseData.haskey then
                local houseConfig = Config.Houses[CurrentHouse]
                if houseConfig then
                    if houseConfig.mlo then
                        -- Initialize door data if not yet done
                        if not MLODoorsData[CurrentHouse] then
                            initMLODoors(CurrentHouse)
                        end

                        for _, doorEntry in pairs(MLODoorsData[CurrentHouse]) do
                            local dist = #(doorEntry.coords - playerCoords)
                            if dist <= Config.DoorDistance then
                                sleepTime = 0

                                local statusText
                                if doorEntry.locked then
                                    statusText = i18n.t("drawtext.door_unlock")
                                else
                                    statusText = i18n.t("drawtext.door_lock")
                                end

                                local doorText = i18n.t("drawtext.door", { status = statusText })
                                DrawText3D(doorEntry.coords.x, doorEntry.coords.y, doorEntry.coords.z, doorText, "open_mlo_door", "E")

                                if IsControlJustPressed(0, 38) then
                                    DoorAnim()
                                    local newLockState = not doorEntry.locked
                                    TriggerServerEvent("qb-houses:SyncDoor", CurrentHouse, doorEntry.doors, newLockState)
                                end
                            end
                        end
                    end
                end
            end

            Wait(sleepTime)
        end
    end)
end
