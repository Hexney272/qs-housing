local gizmoData = {}
local gizmoUtils = {}
gizmoData.utils = gizmoUtils

_G.gizmo = gizmoData

function gizmo.handleCameraUpdate(self)
    CreateThread(function()
        while true do
            if not decorate.active then break end
            if decorate.mode ~= "gizmo" then break end

            SendNUIMessage({
                action = "set_camera_position",
                data = {
                    position = GetFinalRenderedCamCoord(),
                    rotation = GetFinalRenderedCamRot(2)
                }
            })

            Wait(0)
        end
    end)
end

function gizmo.selectEntity(self)
    local coords = GetEntityCoords(self.entity)
    local rotation = GetEntityRotation(self.entity)

    SendReactMessage("set_gizmo_entity", {
        handle = self.entity,
        position = coords,
        rotation = rotation
    })

    self.maxZ = coords.z + 10.0

    CreateThread(function()
        while true do
            if not self.entity then break end
            if not DoesEntityExist(self.entity) then break end
            Wait(0)
        end
        SendReactMessage("set_gizmo_entity", nil)
    end)
end

function gizmo.deselectEntity(self)
    self.entity = nil
end

RegisterNUICallback("select_decorate_entity", function(data, cb)
    cb(1)

    if decorate.mode ~= "gizmo" then
        return Debug("gizmo:selectEntity gizmo mode is not enabled, so we do not select entity")
    end

    decorate:selectEntity()
end)

function gizmo.setEditorMode(self, mode)
    SendReactMessage("set_gizmo_editor_mode", mode)
end

RegisterNUICallback("set_gizmo_editor_mode", function(data, cb)
    cb(1)
    gizmo:setEditorMode(data)
end)

function gizmo.updateGizmoEntity(self)
    if not self.entity or not DoesEntityExist(self.entity) then
        return Error("updateGizmoEntity", "Entity does not exist", self.entity)
    end

    local coords = GetEntityCoords(self.entity)
    local rotation = GetEntityRotation(self.entity)

    SendReactMessage("set_gizmo_entity", {
        handle = self.entity,
        position = coords,
        rotation = rotation
    })
end

RegisterNUICallback("move_entity", function(data, cb)
    cb(1)

    if not data.handle or not DoesEntityExist(data.handle) then
        return Error("move_entity", "Entity does not exist", data.handle)
    end

    if data.position then
        data.position.z = math.min(data.position.z, gizmo.maxZ)
        SetEntityCoordsNoOffset(data.handle, data.position.x, data.position.y, data.position.z, false, false, false)
    end

    if data.rotation then
        SetEntityRotation(data.handle, data.rotation.x, data.rotation.y, data.rotation.z, 0, false)
    end

    SendReactMessage("set_gizmo_entity", data)
end)
