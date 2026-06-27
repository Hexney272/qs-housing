local sincos = require("glm").sincos
local rad = require("glm").rad
local abs = math.abs
local GetFinalRenderedCamCoord = GetFinalRenderedCamCoord
local GetFinalRenderedCamRot = GetFinalRenderedCamRot
local GetEntityCoords = GetEntityCoords
local DisableAllControlActions = DisableAllControlActions
local DrawLine = DrawLine
local GetCamMatrix = GetCamMatrix
local CreateCamera = Utils.CreateCamera
local HandleFlyCam = Utils.HandleFlyCam
local DrawScaleform = Utils.DrawScaleform

_G.raycast = {
    cameraOptions = {
        controls = { "up", "right", "forward" }
    }
}

function raycast.getForwardVector(self)
    local sc, cc = sincos(rad(GetFinalRenderedCamRot(2)))
    return vec3(-sc.z * abs(cc.x), cc.z * abs(cc.x), sc.x)
end

function raycast.gameplayCamera(self, fn, controls, flags, ignoreEntity)
    assert(type(fn) == "function", "raycast:gameplayCamera ::: fn must be a function")

    if not controls then
        controls = {}
    end

    self.controls = Utils.GetControls(controls)
    self.scaleform = Utils.CreateInstructional(self.controls)
    self.active = true

    if not flags then
        flags = 17
    end

    while self.active do
        DisablePlayerFiring(cache.playerId, true)

        local camCoords = GetFinalRenderedCamCoord()
        local forwardVector = self:getForwardVector()
        local targetCoords = camCoords + (forwardVector * 50.0)

        local entityToIgnore = ignoreEntity or cache.ped
        local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(
            camCoords.x, camCoords.y, camCoords.z,
            targetCoords.x, targetCoords.y, targetCoords.z,
            flags, entityToIgnore, 4
        )

        local pedCoords = GetEntityCoords(cache.ped)
        local _, hitStatus, hitCoords, _, hitEntity, _ = GetShapeTestResultIncludingMaterial(rayHandle)

        local didHit = 1 == hitStatus
        local resolvedEntity = hitEntity
        if 0 == hitEntity or not hitEntity then
            resolvedEntity = nil
        end

        self.coords = hitCoords
        self.entity = resolvedEntity
        self.hit = didHit

        if self.hit then
            DrawMarker(28,
                self.coords.x, self.coords.y, self.coords.z,
                0.0, 0.0, 0.0,
                0.0, 0.0, 0.0,
                0.2, 0.2, 0.2,
                255, 42, 24, 100,
                false, false, 0, true, false, false, false
            )
            DrawLine(
                pedCoords.x, pedCoords.y, pedCoords.z,
                self.coords.x, self.coords.y, self.coords.z,
                255, 42, 24, 100
            )
        end

        fn(self)
        DrawScaleform(self.scaleform)

        self.lastCoords = self.coords
        Wait(0)
    end
end

function raycast.freeCamera(self, fn, extraControls, options)
    assert(type(fn) == "function", "raycast:camera ::: fn must be a function")

    if not (options and type(options) == "table") then
        options = { line = true, scaleform = true }
    end

    local _, rightVector, upVector, entityPos = GetEntityMatrix(cache.ped)
    local camStartPos = entityPos + (upVector * 2)
    local camStartRot = GetEntityRotation(cache.ped)

    self.camRot = camStartRot
    self.camPos = camStartPos

    self.camera = CreateCamera("DEFAULT_SCRIPTED_CAMERA", self.camPos, self.camRot, true, nil, 1000)
    self.active = true

    SetPlayerControl(cache.playerId, false, 0)

    local controlsList = table.deepclone(self.cameraOptions.controls)
    if extraControls then
        for _, control in pairs(extraControls) do
            controlsList[#controlsList + 1] = control
        end
    end

    self.controls = Utils.GetControls(controlsList)
    self.scaleform = Utils.CreateInstructional(self.controls)

    while self.active do
        DisableAllControlActions(0)

        local newPos, newRot = HandleFlyCam(self.camera)
        self.camRot = newRot
        self.camPos = newPos

        local _, forwardVec, _, _ = GetCamMatrix(self.camera)
        local targetCoords = vec3(
            self.camPos.x + forwardVec.x * 100.0,
            self.camPos.y + forwardVec.y * 100.0,
            self.camPos.z + forwardVec.z * 100.0
        )

        local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(
            self.camPos.x, self.camPos.y, self.camPos.z,
            targetCoords.x, targetCoords.y, targetCoords.z,
            17, cache.ped, 4
        )

        local _, hitStatus, hitCoords, _, hitEntity, _ = GetShapeTestResultIncludingMaterial(rayHandle)
        local didHit = 1 == hitStatus

        self.coords = hitCoords
        self.entity = hitEntity
        self.hit = didHit

        if options.line then
            DrawLine(
                self.coords.x - 0.3, self.coords.y, self.coords.z,
                self.coords.x + 0.3, self.coords.y, self.coords.z,
                255, 0, 0, 255
            )
            DrawLine(
                self.coords.x, self.coords.y, self.coords.z,
                self.coords.x, self.coords.y, self.coords.z + 0.3,
                255, 0, 0, 255
            )
            DrawLine(
                self.coords.x, self.coords.y - 0.3, self.coords.z,
                self.coords.x, self.coords.y + 0.3, self.coords.z,
                255, 0, 0, 255
            )
        end

        if options.scaleform then
            DrawScaleform(self.scaleform)
        end

        fn(self)
        Wait(0)
    end
end

function raycast.destroy(self)
    self.active = false

    if self.camera then
        Utils.DestroyFlyCam(self.camera, 1000)
        self.camera = nil
        SetPlayerControl(cache.playerId, true, 0)
    end
end

AddEventHandler("onResourceStop", function(resourceName)
    local currentResource = GetCurrentResourceName()
    if resourceName == currentResource then
        raycast:destroy()
    end
end)
