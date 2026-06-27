local DisablePlayerFiring = DisablePlayerFiring
local IsControlJustPressed = IsControlJustPressed
local IsDisabledControlJustPressed = IsDisabledControlJustPressed
local IsControlJustReleased = IsControlJustReleased
local IsDisabledControlJustReleased = IsDisabledControlJustReleased
local getCursorHitCoords = Utils.getCursorHitCoords

local decorateState = {
    active = false,
    currentObject = nil,
    hide = false,
    focus = false,
    keepInput = false,
    objects = {},
    currentPage = "dynamic",
    mode = "mgizmo",
    freeCamera = false,
    cameraFocus = false,
}


_G.decorate = setmetatable({}, {
    __index = function(_, key)
        return decorateState[key]
    end,
    __newindex = function(_, key, value)
        decorateState[key] = value
        if key == "currentObject" then
            if value then
                if decorateState.currentPage == "stash" then
                    SendReactMessage("select_stash_item", value.stashId)
                end
                if DoesEntityExist(value.handle) then
                    decorate:selectEntity(value.handle)
                else
                    decorate:deselectEntity()
                end
            else
                decorate:deselectEntity()
            end
        end
    end,
})


function decorate.instructional(self, extraButtons)
    if not self.active then return end

    if DrawingInstructional then
        DrawingInstructional = false
    end

    local buttons = {
        { key = "place_object_on_ground", label = ActionControls.place_object_on_ground.label },
        { key = "toggle_cursor", label = ActionControls.toggle_cursor.label },
        { key = "toggle_free_mode", label = ActionControls.toggle_free_mode.label },
        { key = "toggle_editor_mode", label = ActionControls.toggle_editor_mode.label },
        { key = "toggle_gizmo_mode", label = ActionControls.toggle_gizmo_mode.label },
        { key = "toggle_free_camera", label = ActionControls.toggle_free_camera.label },
    }

    local hasStashId = self.currentObject and self.currentObject.stashId
    if not hasStashId then
        buttons[#buttons + 1] = { key = "done", label = ActionControls.done.label }
    end

    if extraButtons then
        for _, btn in pairs(extraButtons) do
            buttons[#buttons + 1] = btn
        end
    end

    Utils.DrawInstructional(buttons)
end


function decorate.open(self)
    if self.active then
        return Debug("decorate:open ::: decorate is already active")
    end

    if not CurrentHouse then
        return Notification(i18n.t("decorate.not_in_garage"), "error")
    end

    if cleanerRobot and cleanerRobot.hasActiveCleaningRobot then
        if cleanerRobot:hasActiveCleaningRobot() then
            return Notification(i18n.t("decorate.robot_not_docked"), "error")
        end
    end

    local isAvailable = lib.callback.await("housing:decorate:getDecorationAvailable", false, CurrentHouse)
    if not isAvailable then
        return Notification(i18n.t("decorate.decoration_not_available"), "error")
    end

    TriggerServerEvent("housing:decorate:updateDecorationUsedBy", CurrentHouse, true)

    self.active = true
    self:toggleFreeCamera(true)
    self:setFocus(true)
    DisableIdleCamera(true)
    self:getObjects(CurrentHouse)

    SendReactMessage("toggle_decorate_menu", {
        visible = true,
        navigation = Config.FurnitureNavigation,
        furniture = Config.Furniture,
        enableShop = Config.EnableF3Shop,
    })

    ToggleHud(false)
    TriggerServerEvent("housing:fiveguard:freecam", true)
    self:instructional()
    gizmo:handleCameraUpdate()
    mgizmo:loop()
    self:handleControls()
    self:checkDistance()
end


function decorate.close(self)
    if not self.active then return end

    self.active = false
    ToggleHud(true)
    DisableIdleCamera(false)
    self:removeCurrentObject()
    Utils.RemoveInstructional()
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    SendReactMessage("toggle_decorate_menu", { visible = false })
    self.focus = false
    self.keepInput = false
    DrawingInstructional = false
    TriggerServerEvent("housing:fiveguard:freecam", false)
    TriggerServerEvent("housing:decorate:updateDecorationUsedBy", CurrentHouse, false)
end

function decorate.checkDistance(self)
    if not Config.MaximumDistanceForDecorate then return end

    local startCoords = GetEntityCoords(cache.ped)

    CreateThread(function()
        while true do
            if not self.active then break end
            if not CurrentHouse then break end

            local camCoords = GetFinalRenderedCamCoord()
            local dist = #(camCoords - startCoords)

            if dist > Config.MaximumDistanceForDecorate then
                Notification(i18n.t("decorate.too_far"), "error")
                self:close()
            end

            Wait(500)
        end
    end)
end


function decorate.selectEntity(self, entityHandle)
    local activeGizmo
    if decorate.mode == "gizmo" and gizmo then
        activeGizmo = gizmo
    else
        activeGizmo = mgizmo
    end

    if entityHandle then
        if not DoesEntityExist(entityHandle) then
            activeGizmo.entity = nil
            activeGizmo.decorateData = nil
            return
        end
    end

    local targetEntity = nil
    if entityHandle then
        targetEntity = entityHandle
    else
        local hitCoords, hitEntity = getCursorHitCoords()
        if hitCoords and hitEntity and hitEntity ~= 0 then
            targetEntity = hitEntity
        end
    end

    if not targetEntity then return end

    if decorate.currentPage ~= "stash" and not entityHandle then
        local currentHandle = decorate.currentObject and decorate.currentObject.handle
        if currentHandle ~= targetEntity then
            return Notification(i18n.t("decorate.you_cant_select_entity"), "error")
        end
    end

    local objectData = decorate:getObjectData(targetEntity)
    if not entityHandle and not objectData then return end

    activeGizmo.entity = targetEntity
    activeGizmo.decorateData = objectData

    local currentHandle = decorate.currentObject and decorate.currentObject.handle
    if currentHandle ~= targetEntity then
        decorate.currentObject = {
            handle = targetEntity,
            modelName = objectData.modelName,
            stashId = objectData.id,
        }
    end

    activeGizmo:selectEntity()
    self:instructional()
end


function decorate.deselectEntity(self)
    gizmo:deselectEntity()
    self:instructional()
end

function decorate.getCamCoords(self)
    return GetFinalRenderedCamCoord()
end

function decorate.getCamRot(self)
    return GetFinalRenderedCamRot(2)
end

function decorate.toggleHideDecorate(self)
    self.hide = not self.hide
    SendReactMessage("toggle_hide_decorate", self.hide)
    if self.hide then
        self:setFocus(true, true)
    else
        self:setFocus(true, false)
    end
end


function decorate.setFocus(self, focusState, keepInputState)
    local newFocus = focusState
    if not focusState or not focusState then
        newFocus = not self.focus
    end

    self.focus = newFocus
    SetNuiFocus(self.focus, self.focus)

    if nil ~= keepInputState then
        self.keepInput = keepInputState
    else
        self.keepInput = not self.focus
    end

    self.keepInput = keepInputState
    SetNuiFocusKeepInput(self.keepInput)

    if not self.keepInput then
        if self.mode == "mgizmo" then
            self:toggleGizmoMode("gizmo")
            Debug("setFocus ::: toggleGizmoMode to gizmo because keepInput is false")
        end
    end
end

function decorate.placeObjectOnGround(self)
    local currentObj = decorate.currentObject
    if not currentObj or not currentObj.handle then return end

    PlaceObjectOnGroundProperly(decorate.currentObject.handle)
    gizmo:updateGizmoEntity()
end


function decorate.toggleGizmoMode(self, targetMode)
    if self.mode == "gizmo" and not self.keepInput then
        return Debug("toggleGizmoMode ::: mgizmo mode is enabled and keepInput is true, so we do not toggle mode")
    end

    if targetMode then
        if targetMode == self.mode then
            return Debug("toggleGizmoMode ::: mode is already same", "mode", targetMode)
        end
        self.mode = targetMode
    else
        self.mode = (self.mode == "gizmo") and "mgizmo" or "gizmo"
    end

    SendReactMessage("toggle_gizmo_mode", self.mode)
    Notification(i18n.t("decorate.gizmo_mode_toggled", { mode = self.mode }), "info")

    gizmo:deselectEntity()
    mgizmo:deselectEntity()

    if self.mode == "gizmo" then
        gizmo:handleCameraUpdate()
    else
        mgizmo:loop()
    end
end


LIGHT_ITEMS = Config.Furniture.light.items

local originalDynamicFurnitures = table.deepclone(Config.DynamicFurnitures)
local onlyInsideModels = {}

function InitializeFurnitures()
    Config.DynamicFurnitures = table.deepclone(originalDynamicFurnitures)
    Config.DoorModels = {}
    onlyInsideModels = {}

    for category, categoryData in pairs(Config.Furniture) do
        if category ~= "navigation" then
            for _, item in pairs(categoryData.items) do
                if item.type then
                    Config.DynamicFurnitures[item.object] = item
                end
                if item.isDoor then
                    Config.DoorModels[item.object] = item
                end
                if item.onlyInside then
                    onlyInsideModels[item.object] = true
                end
                if item.colors then
                    for _, colorVariant in pairs(item.colors) do
                        if colorVariant.type then
                            Config.DynamicFurnitures[colorVariant.object] = colorVariant
                        end
                        if item.isDoor then
                            Config.DoorModels[colorVariant.object] = colorVariant
                        end
                        if item.onlyInside then
                            onlyInsideModels[colorVariant.object] = true
                        end
                    end
                end
            end
        end
    end
end

function IsOnlyInsideModel(modelName)
    return onlyInsideModels[modelName] == true
end

CreateThread(InitializeFurnitures)


local wallartTextures = {}
local wallartObjectMap = {}

local function getObjectKey(objectData)
    return tostring(objectData.id or objectData.uniq or objectData.modelName)
end

local function getWallartConfig(modelName)
    local furnitureData = Config.DynamicFurnitures[modelName]
    if furnitureData and furnitureData.type == "wallart" then
        return furnitureData.wallart
    end
    return nil
end

local function makeTextureKey(textureDict, textureName)
    return ("%s:%s"):format(textureDict, textureName)
end

local function makeTxdName(textureKey)
    local sanitized = textureKey:gsub("[^%w_]", "_")
    return ("wallart_%s"):format(sanitized)
end


local function removeWallartTexture(objectData)
    local objKey = getObjectKey(objectData)
    local textureKey = wallartObjectMap[objKey]
    if not textureKey then return end

    wallartObjectMap[objKey] = nil

    local stillUsed = table.find(wallartObjectMap, function(v)
        return v == textureKey
    end)
    if stillUsed then return end

    local texData = wallartTextures[textureKey]
    if not texData then return end

    if texData.duiObj then
        DestroyDui(texData.duiObj)
    end
    wallartTextures[textureKey] = nil
end

local function ApplyWallartTexture(objectData)
    Debug("ApplyWallartTexture ::: Applying wallart texture", "objectData", objectData)

    local wallartConfig = getWallartConfig(objectData.modelName)
    if not wallartConfig then
        return false
    end

    local wallartData = objectData.wallartData or {}
    local textureDict = wallartData.textureDict or wallartConfig.textureDict
    local textureName = wallartData.textureName or wallartConfig.textureName

    if not textureDict or not textureName then
        return false
    end

    local url = wallartData.url or wallartConfig.defaultUrl
    if type(url) ~= "string" then
        return false
    end

    url = url:match("^%s*(.-)%s*$")
    if url == "" then
        return false
    end


    -- Update objectData wallart fields
    if not objectData.wallartData then
        objectData.wallartData = {}
    end
    objectData.wallartData.url = url
    objectData.wallartData.textureName = textureName
    objectData.wallartData.textureDict = textureDict

    local textureKey = makeTextureKey(textureDict, textureName)
    local objKey = getObjectKey(objectData)

    local existing = wallartTextures[textureKey]
    if existing and existing.url == url then
        wallartObjectMap[objKey] = textureKey
        return true
    end

    if existing and existing.duiObj then
        DestroyDui(existing.duiObj)
    end

    local txdName = makeTxdName(textureKey)
    local txdHandle = CreateRuntimeTxd(txdName)
    local duiObj = CreateDui(url, 512, 512)

    local timeout = GetGameTimer() + 12500
    while true do
        if IsDuiAvailable(duiObj) then break end
        if not (timeout > GetGameTimer()) then break end
        Wait(50)
    end

    if not IsDuiAvailable(duiObj) then
        Debug("ApplyWallartTexture ::: Dui is not available", "url", url)
        DestroyDui(duiObj)
        return false
    end


    local duiHandle = GetDuiHandle(duiObj)
    CreateRuntimeTextureFromDuiHandle(txdHandle, "skin", duiHandle)
    AddReplaceTexture(textureDict, textureName, txdName, "skin")

    Debug("ApplyWallartTexture ::: Added replace texture",
        "textureDict", textureDict, "textureName", textureName, "txdName", txdName)

    wallartTextures[textureKey] = {
        txdName = txdName,
        duiObj = duiObj,
        url = url,
    }
    wallartObjectMap[objKey] = textureKey
    return true
end

function decorate.applyWallartTexture(self, objectData)
    return ApplyWallartTexture(objectData)
end

local function DestroyAllWallartTextures()
    for _, texData in pairs(wallartTextures) do
        if texData.duiObj then
            DestroyDui(texData.duiObj)
        end
    end
    wallartTextures = {}
    wallartObjectMap = {}
end


local CAMERA_LERP_SPEED = 0.01

function decorate.handleControls(self)
    CreateThread(function()
        local lastHandle = 0
        while true do
            if not self.active then break end

            DisablePlayerFiring(cache.playerId, true)

            -- Outline current object
            local currentHandle = self.currentObject and self.currentObject.handle
            if lastHandle ~= currentHandle then
                SetEntityDrawOutline(lastHandle, false)
                local newHandle = self.currentObject and self.currentObject.handle
                SetEntityDrawOutline(newHandle, true)
                SetEntityDrawOutlineColor(0, 180, 255, 255)
            end
            lastHandle = self.currentObject and self.currentObject.handle

            -- Toggle cursor
            local toggleCursorCode = ActionControls.toggle_cursor.codes[1]
            if IsControlJustPressed(0, toggleCursorCode) or IsDisabledControlJustPressed(0, toggleCursorCode) then
                self:setFocus(true)
            end

            -- Toggle free camera
            local freeCamCode = ActionControls.toggle_free_camera.codes[1]
            if IsControlJustPressed(0, freeCamCode) or IsDisabledControlJustPressed(0, freeCamCode) then
                self:toggleFreeCamera()
            end


            -- Done button (buy object)
            local doneCode = ActionControls.done.codes[1]
            if IsControlJustPressed(0, doneCode) or IsDisabledControlJustPressed(0, doneCode) then
                local hasStashId = self.currentObject and self.currentObject.stashId
                if not hasStashId then
                    self:openBuyObjectModal()
                end
            end

            -- Place object on ground
            if lastHandle then
                local groundCode = ActionControls.place_object_on_ground.codes[1]
                if IsControlJustReleased(0, groundCode) or IsDisabledControlJustReleased(0, groundCode) then
                    self:placeObjectOnGround()
                end
            end

            Wait(0)
        end
    end)
end


RegisterNetEvent("housing:decorate:open", function()
    if not CurrentHouse then
        return Notification(i18n.t("decorate.not_in_house"), "error")
    end

    local houseConfig = Config.Houses[CurrentHouse]
    if not houseConfig then
        return Notification(i18n.t("decorate.invalid_data"), "error")
    end

    if Config.DecorateOnlyAccessForOwner then
        if not CurrentHouseData.isOwnedByMe then
            return Notification(i18n.t("you_are_not_owner"), "error")
        end
    end

    if CurrentHouseData.billsCutOff then
        return Notification(i18n.t("decorate.bills_cut_off"), "error")
    end

    if not CurrentHouseData.haskey then
        return Notification(i18n.t("decorate.not_key_holder"), "error")
    end

    decorate:open()
end)


function decorate.toggleFreeCamera(self, enable)
    if nil ~= enable then
        self.freeCamera = enable
    else
        self.freeCamera = not self.freeCamera
    end

    if not self.freeCamera then return end

    SetPlayerControl(cache.playerId, false, 0)

    local _, _, up, pos = GetEntityMatrix(cache.ped)
    local camPos = pos + up
    local camRot = GetEntityRotation(cache.ped)

    local cam = Utils.CreateCamera("DEFAULT_SCRIPTED_CAMERA", camPos, camRot, true, nil, 1000)

    self:instructional({
        { key = "focus_free_camera", label = "Focus Object" }
    })

    self.cameraFocus = false

    CreateThread(function()
        while true do
            if not self.active then break end
            if not self.freeCamera then break end

            local newPos, newRot = Utils.HandleFlyCam(cam, { mouse = not self.cameraFocus })
            camRot = newRot
            camPos = newPos

            DisableAllControlActions(0)


            -- Toggle camera focus with F key
            if IsDisabledControlJustPressed(0, Keys.F) then
                if self.mode == "gizmo" then
                    self.cameraFocus = not self.cameraFocus
                else
                    Notification(i18n.t("decorate.focus_object_not_supported"), "error")
                end
            end

            if self.cameraFocus and self.mode == "mgizmo" then
                self.cameraFocus = false
            end

            if self.cameraFocus then
                local objHandle = self.currentObject and self.currentObject.handle
                if objHandle and objHandle and DoesEntityExist(objHandle) then
                    local entityCoords = GetEntityCoords(objHandle)
                    local entityModel = GetEntityModel(objHandle)
                    local minDim, maxDim = GetModelDimensions(entityModel)
                    local dimSize = #(maxDim - minDim)
                    local orbitRadius = math.max(dimSize * 2.0, 3.0)
                    local entityHeight = maxDim.z - minDim.z

                    local distToEntity = #(camPos - entityCoords)
                    local dirToEntity = entityCoords - camPos


                    -- Calculate target rotation to look at entity
                    local targetRot = vec3(
                        math.deg(math.asin(dirToEntity.z / #dirToEntity)),
                        0.0,
                        math.deg(math.atan(-dirToEntity.x, dirToEntity.y))
                    )

                    -- Smoothly interpolate camera rotation
                    local smoothRot = vec3(
                        camRot.x + (targetRot.x - camRot.x) * CAMERA_LERP_SPEED,
                        camRot.y + (targetRot.y - camRot.y) * CAMERA_LERP_SPEED,
                        camRot.z + (targetRot.z - camRot.z) * CAMERA_LERP_SPEED
                    )
                    SetCamRot(cam, smoothRot.x, smoothRot.y, smoothRot.z, 2)

                    -- Keep camera at appropriate distance
                    if distToEntity > orbitRadius * 1.5 or distToEntity < orbitRadius * 0.5 then
                        local normalizedDir = dirToEntity / distToEntity
                        local targetPos = entityCoords - normalizedDir * orbitRadius
                        local smoothPos = vec3(
                            camPos.x + (targetPos.x - camPos.x) * CAMERA_LERP_SPEED * 0.5,
                            camPos.y + (targetPos.y - camPos.y) * CAMERA_LERP_SPEED * 0.5,
                            camPos.z + (targetPos.z - camPos.z) * CAMERA_LERP_SPEED * 0.5
                        )
                        SetCamCoord(cam, smoothPos.x, smoothPos.y, smoothPos.z)
                        camPos = smoothPos
                    end


                    -- Auto-orbit when very close
                    if distToEntity < orbitRadius * 0.7 then
                        local orbitSpeed = 0.3
                        local time = GetGameTimer() / 1000.0 * orbitSpeed
                        local radius = orbitRadius * 0.8
                        local orbitTarget = vec3(
                            entityCoords.x + math.cos(time) * radius,
                            entityCoords.y + math.sin(time) * radius,
                            entityCoords.z + entityHeight
                        )
                        local smoothOrbit = vec3(
                            camPos.x + (orbitTarget.x - camPos.x) * 0.05,
                            camPos.y + (orbitTarget.y - camPos.y) * 0.05,
                            camPos.z + (orbitTarget.z - camPos.z) * 0.05
                        )
                        SetCamCoord(cam, smoothOrbit.x, smoothOrbit.y, smoothOrbit.z)
                    end
                end
            end

            Wait(0)
        end

        Utils.DestroyFlyCam(cam, 1000)
        SetPlayerControl(cache.playerId, true, 0)
        self:instructional()
    end)
end


function decorate.removeCurrentObject(self)
    if not decorate.currentObject then return end

    local handle = decorate.currentObject and decorate.currentObject.handle
    if handle then
        if not decorate.currentObject.stashId then
            DeleteObject(decorate.currentObject.handle)
        end
    end

    gizmo:deselectEntity()
    decorate.currentObject = nil
    SendReactMessage("remove_current_object")
    Debug("Removed current object", decorate.currentObject)
end

exports("inDecorate", function()
    return decorate.active
end)

function decorate.getObjectData(self, entityHandle)
    local currentObj = self.currentObject
    if currentObj and currentObj.handle then
        if entityHandle == currentObj.handle then
            return currentObj
        end
    end

    for _, obj in pairs(decorate.objects) do
        if obj.handle and DoesEntityExist(obj.handle) then
            if obj.handle == entityHandle then
                return obj
            end
        end
    end

    return false
end


function decorate.saveCurrentObject(self)
    Debug("saveCurrentObject", "Current object", decorate.currentObject)
    if not self.currentObject then return end

    local saveData = {
        modelName = self.currentObject.modelName,
        coords = GetEntityCoords(self.currentObject.handle),
        rotation = GetEntityRotation(self.currentObject.handle),
        handle = self.currentObject.handle,
        inStash = false,
        inHouse = nil ~= EnteredHouse,
        house = CurrentHouse,
        price = self.currentObject.price,
        wallartData = self.currentObject.wallartData,
    }

    self:removeCurrentObject()
    return lib.callback.await("housing:saveObject", false, CurrentHouse, saveData)
end

function decorate.destroyObjects(self)
    local objectsCopy = table.deepclone(decorate.objects)
    decorate.objects = {}

    for _, obj in pairs(objectsCopy) do
        RemoveSpawnedObject(obj)
    end

    if cleanerRobot then
        cleanerRobot:stopInteractionLoop()
        cleanerRobot:cleanAll()
    end
end

function decorate.refreshObjects(self)
    for _, obj in pairs(decorate.objects) do
        RemoveSpawnedObject(obj)
    end
end


function decorate.saveObjects(self)
    for _, obj in pairs(decorate.objects) do
        if obj.spawned and DoesEntityExist(obj.handle) then
            local coords = GetEntityCoords(obj.handle)
            local rotation = GetEntityRotation(obj.handle)
            local currentCoords = vec3(coords.x, coords.y, coords.z)
            local currentRotation = vec3(rotation.x, rotation.y, rotation.z)

            local coordsChanged = currentCoords.x ~= obj.coords.x
            local rotationChanged = currentRotation.x ~= obj.rotation.x

            if not coordsChanged or not rotationChanged then
                -- nothing to update
            else
                obj.coords = coords
                obj.rotation = rotation
                TriggerServerEvent("housing:updateObject", CurrentHouse, obj.id, {
                    coords = json.encode(coords),
                    rotation = json.encode(rotation),
                })
            end
        end
    end
end

function decorate.openBuyObjectModal(self)
    if not self.currentObject then return end
    SendReactMessage("open_buy_object_modal")
end


RegisterNetEvent("housing:updateObject", function(house, objectId, updateData)
    if CurrentHouse ~= house then
        return Debug("housing:updateObject ::: house is not same", "CurrentHouse", CurrentHouse, "house", house)
    end

    local objectEntry = table.find(decorate.objects, function(obj)
        return obj.id == objectId
    end)

    if not objectEntry then
        Error("housing:updateObject :: Object not found", "id", objectId)
        return
    end

    for key, value in pairs(updateData) do
        if key == "coords" then
            if objectEntry.spawned then
                Debug("housing:updateObject ::: SetEntityCoords", "object", objectEntry.handle, "coords", value)
                SetEntityCoords(objectEntry.handle, value.x, value.y, value.z, false, false, false, false)
            end
        elseif key == "rotation" then
            if objectEntry.spawned then
                Debug("housing:updateObject ::: SetEntityRotation", "object", objectEntry.handle, "rotation", value)
                SetEntityRotation(objectEntry.handle, value.x, value.y, value.z, 0, false)
            end
        end

        objectEntry[key] = value

        if key == "wallartData" then
            if objectEntry.spawned then
                ApplyWallartTexture(objectEntry)
            end
        end

        Debug("Updated object", "object", objectEntry.id, "key", key, "value", value)
    end
end)


function RemoveSpawnedObject(objectData)
    if not objectData.spawned then
        return false
    end

    if cleanerRobot and objectData.id then
        if cleanerRobot:isCleanerModel(objectData.modelName) then
            cleanerRobot:despawn(objectData.id)
        end
    end

    removeWallartTexture(objectData)
    DeleteObject(objectData.handle)
    objectData.spawned = false
end

RegisterNetEvent("housing:decorate:sellFurniture", function(house, objectId)
    if CurrentHouse ~= house then
        return Debug("housing:decorate:sellFurniture ::: house is not same", "house", house, "CurrentHouse", CurrentHouse)
    end

    local objectEntry = table.find(decorate.objects, function(obj)
        return obj.id == objectId
    end)

    if not objectEntry then
        Error("housing:decorate:sellFurniture ::: Object not found", "id", objectId)
        return
    end

    RemoveSpawnedObject(objectEntry)

    decorate.objects = table.filter(decorate.objects, function(obj)
        return obj.id ~= objectId
    end)

    Debug("housing:decorate:sellFurniture", "object is deleted from cache", objectEntry.id)
end)


RegisterNetEvent("housing:addObject", function(house, objectData)
    if CurrentHouse ~= house then
        return Debug("housing:addObject ::: house is not same", "house", house, "CurrentHouse", CurrentHouse)
    end

    decorate.objects[#decorate.objects + 1] = objectData
    Debug("Added object to data", "data", objectData)
end)

RegisterNetEvent("housing:removeFurniture", function(house, objectId)
    if CurrentHouse ~= house then return end
    if not decorate.objects then return end

    for idx, obj in pairs(decorate.objects) do
        if obj.id == objectId then
            if cleanerRobot then
                if cleanerRobot:isCleanerModel(obj.modelName) then
                    cleanerRobot:despawn(objectId)
                end
            end

            if obj.handle and DoesEntityExist(obj.handle) then
                DeleteObject(obj.handle)
            end

            decorate.objects[idx] = nil
            Debug("Removed furniture:", objectId)
            break
        end
    end
end)


function SpawnObject(modelName, coords, rotation)
    local modelHash = joaat(modelName)
    lib.requestModel(modelHash, Config.DefaultRequestModelTimeout)

    local handle = CreateObject(modelHash, coords.x, coords.y, coords.z, false, false, false)
    SetEntityAlpha(handle, 0, false)

    CreateThread(function()
        for alpha = 0, 255, 51 do
            Wait(50)
            SetEntityAlpha(handle, alpha, false)
        end
    end)

    if rotation then
        SetEntityRotation(handle, rotation.x, rotation.y, rotation.z, 0, false)
    end

    SetEntityAsMissionEntity(handle, true, true)
    SetEntityInvincible(handle, true)
    SetEntityCompletelyDisableCollision(handle, true, false)

    if not (Config.DynamicDoors and Config.DoorModels[modelName]) then
        FreezeEntityPosition(handle, true)
    end

    SetModelAsNoLongerNeeded(modelHash)
    Wait(0)
    SetEntityCoords(handle, coords.x, coords.y, coords.z, false, false, false, false)

    return handle
end


function decorate.getObjects(self, house)
    self:destroyObjects()

    local objects = lib.callback.await("housing:getDecorations", 0, house)
    self.objects = objects

    if cleanerRobot and CurrentHouse and EnteredHouse then
        CreateThread(function()
            Wait(500)

            if not decorate.objects then return end

            for _, obj in pairs(decorate.objects) do
                if obj.spawned and obj.handle and DoesEntityExist(obj.handle) then
                    if cleanerRobot:isCleanerModel(obj.modelName) then
                        cleanerRobot:spawnForDecoration(obj, CurrentHouse)
                    end
                end
            end

            if cleanerRobot:hasRobots() then
                if not Config.UseTarget then
                    cleanerRobot:startInteractionLoop()
                end
            end
        end)
    end
end

exports("refreshCurrentDecorations", function()
    return decorate:refreshObjects()
end)

exports("initCurrentDecorations", function()
    if not CurrentHouse then
        return Debug("initDecorations ::: No Current House")
    end
    return decorate:getObjects(CurrentHouse)
end)


-- Light rendering system
local lightObjects = {}
local lightModelNames = {}

CreateThread(function()
    for _, lightItem in pairs(LIGHT_ITEMS) do
        table.insert(lightModelNames, lightItem.object)
    end

    while true do
        if not decorate.objects then
            lightObjects = {}
        else
            lightObjects = table.deepclone(table.filter(decorate.objects, function(obj)
                return table.includes(lightModelNames, obj.modelName)
            end))

            for idx, obj in pairs(lightObjects) do
                if obj.handle and DoesEntityExist(obj.handle) then
                    if not obj.inside or CurrentHouse then
                        local rotation = GetEntityRotation(obj.handle)
                        local coords = GetEntityCoords(obj.handle)
                        local direction = RotationToDirection(rotation)
                        lightObjects[idx].position = coords
                        lightObjects[idx].direction = direction
                    end
                end
            end
        end

        Wait(500)
    end
end)


CreateThread(function()
    while true do
        local waitTime = 1250

        if not CurrentHouseData.billsCutOff and CurrentHouseData.lightsOn then
            for _, obj in pairs(lightObjects) do
                if obj.handle and DoesEntityExist(obj.handle) then
                    if obj.lightData then
                        if not (obj.lightData and obj.lightData.active) then
                            goto continue
                        end
                    end

                    if obj.position then
                        waitTime = 0
                        local position = obj.position
                        local direction = obj.direction

                        local rgb = (obj.lightData and obj.lightData.rgb) or { r = 255, g = 255, b = 255 }
                        local intensity = (obj.lightData and obj.lightData.intensity) or Config.DefaultLightIntensity
                        intensity = intensity + 0.0

                        DrawSpotLight(
                            position.x, position.y, position.z,
                            direction.x, direction.y, direction.z,
                            rgb.r, rgb.g, rgb.b,
                            100.0, 20.0, 1.0,
                            intensity, 0.0
                        )
                    end
                end
                ::continue::
            end
        end

        Wait(waitTime)
    end
end)


-- Main decoration spawning/despawning loop
CreateThread(function()
    while true do
        local waitTime = decorate.active and 300 or 1250
        local playerCoords = GetEntityCoords(cache.ped)

        if not decorate.objects then
            Wait(waitTime)
        else
            for _, obj in pairs(decorate.objects) do
                if obj.inStash then
                    if obj.spawned then
                        DeleteObject(obj.handle)
                        obj.spawned = false
                        Debug("Deleted object because its setted to inStash", "object", obj.handle)
                    end
                elseif not obj.coords then
                    Error("Object coords is nil we skipping it.", "object", obj)
                else
                    if IsOnlyInsideModel(obj.modelName) then
                        if not EnteredHouse then
                            if obj.spawned then
                                RemoveSpawnedObject(obj)
                                Debug("Deleted onlyInside object because player left the house", "object", obj.handle)
                            end
                        end
                    else
                        obj.coords = vec3(obj.coords.x, obj.coords.y, obj.coords.z)


                        -- Handle objects at origin (from shop/ikea)
                        if obj.coords.x == 0.0 and obj.coords.y == 0.0 and obj.coords.z == 0.0 then
                            if decorate.active then
                                local camera = Utils.GetCamera()
                                local camCoords = camera.coords
                                local camRotation = camera.rotation
                                local forward = Utils.GetForwardVector(camRotation)
                                local newPos = camCoords + forward * 5.0
                                Debug("Load Decorations : Object is from ikea. We setted it to camera center", "v", obj)
                                obj.coords = vec3(newPos.x, newPos.y, newPos.z)
                                decorate:saveObjects()
                            end
                        end

                        local dist = #(playerCoords - obj.coords)

                        if dist <= Config.SpawnDistance then
                            if not obj.spawned then
                                local handle = SpawnObject(obj.modelName, obj.coords, obj.rotation)
                                if handle then
                                    obj.handle = handle
                                    ApplyWallartTexture(obj)


                                    -- Re-select entity if it matches current selected stash object
                                    local selectedStashId = decorate.currentObject and decorate.currentObject.stashId
                                    if selectedStashId == obj.id then
                                        decorate.currentObject.handle = handle
                                        decorate:selectEntity(handle)
                                    end

                                    -- Handle cleaner robot spawning
                                    if cleanerRobot and CurrentHouse and EnteredHouse then
                                        if cleanerRobot:isCleanerModel(obj.modelName) then
                                            cleanerRobot:spawnForDecoration(obj, CurrentHouse)
                                            if cleanerRobot:hasRobots() then
                                                if not Config.UseTarget then
                                                    cleanerRobot:startInteractionLoop()
                                                end
                                            end
                                        end
                                    end
                                else
                                    obj.handle = 0
                                    Warning("This model is not loaded. Please check if the model is valid. if its not delete it from the list", obj.modelName)
                                end
                                obj.spawned = true
                            end
                        elseif dist > Config.SpawnDistance then
                            if obj.spawned then
                                RemoveSpawnedObject(obj)
                                Debug("Deleted object", "object", obj.handle)
                            end
                        end
                    end
                end
            end

            Wait(waitTime)
        end
    end
end)


exports("AddFurniture", function(category, item)
    local invokingResource = GetInvokingResource()
    Error("AddFurniture ::: This export is moved to server side. Please use exports['qs-housing']:AddFurniture(category, item) instead. on the server side. Resource", invokingResource)
end)

exports("AddShell", function(shellData)
    Config.Shells[#Config.Shells + 1] = shellData
    Debug("Added shell", shellData)
end)

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    decorate:destroyObjects()
    decorate:close()
    DestroyAllWallartTextures()
end)
