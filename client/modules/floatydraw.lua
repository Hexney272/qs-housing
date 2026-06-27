local RenderTargetMethods = {}

function RenderTargetMethods.attach(self)
  if not self._properties.handle then
    if not IsNamedRendertargetRegistered(self._properties.targetName) then
      if not IsNamedRendertargetLinked(self._properties.model) then
        RegisterNamedRendertarget(self._properties.targetName, false)
        LinkNamedRendertarget(self._properties.model)
      end
    end
    self._properties.handle = GetNamedRendertargetRenderId(self._properties.targetName)
  end
  return self._properties.handle
end

function RenderTargetMethods.release(self)
  ReleaseNamedRendertarget(self._properties.targetName)
  self._properties.handle = nil
end

function RenderTargetMethods.select(self, callback)
  if not self._properties.handle then
    self:attach()
  end
  if self._properties.handle then
    SetTextRenderId(self._properties.handle)
    SetScriptGfxDrawOrder(self._properties.drawOrder)
    local success, err = pcall(callback)
    if not success then
      return err
    end
    SetTextRenderId(1)
  else
    return "Render target handle unavailable?!"
  end
end

local RenderTargetMetatable = {}
RenderTargetMetatable.__call = RenderTargetMethods.select

function RenderTargetMetatable.__index(self, key)
  return self._methods[key]
end

function RenderTarget(model, targetName, drawOrder)
  if type(model) == "string" then
    model = GetHashKey(model)
  end
  assert(IsModelValid(model), "RenderTarget requires a valid model as it's first argument!")
  assert(type(targetName) == "string", "RenderTarget requires a string for it's second argument, targetName!")
  if not drawOrder then
    drawOrder = 4
  end
  assert(type(drawOrder) == "number", "RenderTarget requires a number for it's third argument. drawOrder is usually 4 and can be left out.")

  local instance = {}
  instance._properties = {
    model = model,
    targetName = targetName,
    drawOrder = drawOrder
  }
  instance._methods = RenderTargetMethods
  setmetatable(instance, RenderTargetMetatable)
  instance:attach()
  return instance
end

local lastGameTimer = 0
local visibilitySphereRadius = 2.0
local currentTargetIndex = 1

local drawTargets = {
  [1]  = { model = -1528588652, name = "prop_x17_tv_scrn_01" },
  [2]  = { model = -684524750,  name = "prop_x17_tv_scrn_02" },
  [3]  = { model = 8834525,     name = "prop_x17_tv_scrn_03" },
  [4]  = { model = 583602785,   name = "prop_x17_tv_scrn_04" },
  [5]  = { model = -601553638,  name = "prop_x17_tv_scrn_05" },
  [6]  = { model = 240019820,   name = "prop_x17_tv_scrn_06" },
  [7]  = { model = -867605065,  name = "prop_x17_tv_scrn_07" },
  [8]  = { model = -1650456475, name = "prop_x17_tv_scrn_08" },
  [9]  = { model = -1345213240, name = "prop_x17_tv_scrn_09" },
  [10] = { model = 1481571468,  name = "prop_x17_tv_scrn_10" },
  [11] = { model = -473459841,  name = "prop_x17_tv_scrn_11" },
  [12] = { model = -167692302,  name = "prop_x17_tv_scrn_12" },
  [13] = { model = -1993253308, name = "prop_x17_tv_scrn_13" },
  [14] = { model = 1542587334,  name = "prop_x17_tv_scrn_14" },
  [15] = { model = 636360651,   name = "prop_x17_tv_scrn_15" },
  [16] = { model = 908867655,   name = "prop_x17_tv_scrn_16" },
  [17] = { model = -829757194,  name = "prop_x17_tv_scrn_17" },
  [18] = { model = -1605825421, name = "prop_x17_tv_scrn_18" },
  [19] = { model = 1794089409,  name = "prop_x17_tv_scrn_19" },
}

function FloatyDraw(position, heading, drawCallback)
  local adjustedPosition = position + vector3(0, 0, 0.5)

  if not IsSphereVisible(adjustedPosition, visibilitySphereRadius) then
    return "Not on screen"
  end

  local camCoord = GetFinalRenderedCamCoord()
  local distance = #(camCoord - position)

  if distance > 100 then
    return "Point out of range"
  end

  local direction = adjustedPosition - camCoord
  local angle = math.deg(math.atan(direction.y, direction.x))
  local angleDiff = angle - heading

  if angleDiff < 0 then
    if angleDiff > -180 then
      return "Not a visible angle"
    end
  end

  local gameTimer = GetGameTimer()

  if lastGameTimer == gameTimer then
    currentTargetIndex = currentTargetIndex + 1
  else
    currentTargetIndex = 1
  end

  local target = drawTargets[currentTargetIndex]

  if target then
    lastGameTimer = gameTimer

    if not target.rt then
      target.rt = RenderTarget(target.model, target.name)
    end

    if not target.entity or not DoesEntityExist(target.entity) then
      target.entity = CreateObjectNoOffset(target.model, position, false, false, false)
      SetEntityAsMissionEntity(target.entity, true, true)
      SetEntityCollision(target.entity, false, false)
      SetEntityAlpha(target.entity, 254)
      SetModelAsNoLongerNeeded(target.model)
    end

    SetEntityCoordsNoOffset(target.entity, position, false, false, false)
    SetEntityHeading(target.entity, heading)

    local err = target.rt(function()
      drawCallback(target.entity, distance)
    end)

    if err then
      print("FloatyDraw failed callback: " .. message)
      Citizen.Wait(1000)
      return "Failed callback: " .. message
    end
  else
    print("FloatyDraw ran out of draw targets! Can only do 19 at a time!")
    Citizen.Wait(1000)
    return "Too many targets!"
  end
end

AddEventHandler("onResourceStop", function(resourceName)
  if resourceName == GetCurrentResourceName() then
    for _, target in pairs(drawTargets) do
      if target.rt then
        target.rt:release()
      end
      if target.entity then
        if DoesEntityExist(target.entity) then
          DeleteEntity(target.entity)
        end
      end
    end
  end
end)
