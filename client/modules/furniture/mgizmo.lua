local IsControlPressed = IsControlPressed
local IsDisabledControlPressed = IsDisabledControlPressed
local getCursorHitCoords = Utils.getCursorHitCoords
local SetEntityCoords = SetEntityCoords
local SetEntityHeading = SetEntityHeading

_G.mgizmo = {}

function mgizmo.selectEntity(self)
    decorate:instructional({
        { key = "rotate_z", label = "Rotate Z +/-" }
    })

    local coords = GetEntityCoords(self.entity)
    self.lastCoords = coords
end

function mgizmo.deselectEntity(self)
    if not self.entity then return end
    self.entity = nil
    self.decorateData = nil
    decorate:instructional()
end

local rotateZCodes = ActionControls.rotate_z.codes

function mgizmo.updateEntity(self)
    if not self.entity then return end

    for i = 1, #rotateZCodes do
        DisableControlAction(0, rotateZCodes[i], true)
    end

    if IsDisabledControlPressed(0, rotateZCodes[1]) then
        SetEntityHeading(self.entity, GetEntityHeading(self.entity) + 0.3)
    elseif IsDisabledControlPressed(0, rotateZCodes[2]) then
        SetEntityHeading(self.entity, GetEntityHeading(self.entity) - 0.3)
    end

    local hitCoords, hitEntity = getCursorHitCoords(self.entity)
    if not hitCoords or not hitEntity then
        return Debug("mgizmo:updateEntity hitCoords or hitEntity is nil")
    end

    if self.lastCoords ~= hitCoords then
        self.lastCoords = hitCoords
        SetEntityCoords(self.entity, hitCoords.x, hitCoords.y, hitCoords.z)
    end
end

function mgizmo.loop(self)
    CreateThread(function()
        while true do
            if not decorate.active then break end
            if decorate.mode ~= "mgizmo" then break end

            Wait(0)

            if IsControlJustPressed(0, 24) or IsDisabledControlJustPressed(0, 24) then
                decorate:selectEntity(self.entity)
            elseif IsControlPressed(0, 24) or IsDisabledControlPressed(0, 24) then
                self:updateEntity()
            elseif IsControlJustReleased(0, 24) or IsDisabledControlJustReleased(0, 24) then
                self:deselectEntity()
            end
        end
    end)
end
