local IsDisabledControlJustPressed = IsDisabledControlJustPressed
local IsDisabledControlPressed = IsDisabledControlPressed
local DrawLine = DrawLine
local DrawPoly = DrawPoly
local ActionControls = ActionControls

_G.creator = {
  raycast = {
    flags = {
      ped = 17,
      vehicle = 17,
      object = 1
    },
    defaults = {
      models = {
        ped = "mp_m_freemode_01",
        vehicle = "t20",
        object = "prop_paper_bag_01"
      }
    },
    entities = {
      ped = 1,
      vehicle = 2,
      object = 3
    },
    minPointLength = Config.MinPointLength,
    height = 25.0,
    points = {}
  },
  temp = {},
  photo = {
    isInShell = false,
    initialPlayerCoords = nil,
    initialCameraPos = nil
  }
}


function creator:updateUI()
  if not self.visible then
    return
  end

  local houses = {}
  local playerCoords = GetEntityCoords(cache.ped)

  for houseName, houseData in pairs(Config.Houses) do
    if houseData.creator then
      if houseData.apartmentNumber then
        if "apt-0" ~= houseData.apartmentNumber then
          -- skip non-primary apartments
        end
      else
        local showOnMapObj = table.find(HouseObjects, function(obj)
          return obj.house == houseName and obj.isIsland
        end)

        local islandObj = table.find(HouseObjects, function(obj)
          return obj.house == houseName
        end)

        local houseType = nil
        if houseData.mlo then
          houseType = "mlo"
        elseif houseData.ipl then
          houseType = "ipl"
        else
          houseType = "shell"
        end

        houseData.type = houseType
        houseData.name = houseName

        houseData.showOnMap = {
          enable = showOnMapObj and true or false,
          data = showOnMapObj and {
            model = showOnMapObj.model,
            coords = showOnMapObj.coords
          }
        }

        houseData.island = {
          enable = islandObj and true or false,
          data = islandObj and {
            model = islandObj.model,
            coords = islandObj.coords
          }
        }


        if houseData.coords and houseData.coords.enter then
          local enter = houseData.coords.enter
          local enterVec = vector3(enter.x, enter.y, enter.z)
          houseData.distance = #(playerCoords - enterVec)
        else
          houseData.distance = 999999.0
        end

        houses[#houses + 1] = houseData
      end
    end
  end

  SendReactMessage("toggle_creator", {
    visible = true,
    data = {
      houses = houses,
      jobs = self.jobs,
      job = GetJobName(),
      furnitureShops = Config.FurnitureShops,
      furnitureCategories = self.furnitureCategories
    }
  })
end


function creator:destroyTempEntities()
  if self.temp.island then
    DeleteEntity(self.temp.island)
    self.temp.island = nil
  end

  if self.temp.houseObject then
    DeleteEntity(self.temp.houseObject)
    self.temp.houseObject = nil
  end

  Debug("creator:destroyTemp", self.temp)
end

function creator:spawnTempEntities()
  self:destroyTempEntities()

  if self.raycast.island then
    self.temp.island = SpawnHouseObject(
      self.raycast.island.model,
      self.raycast.island.coords,
      self.raycast.island.coords.w
    )
  end

  if self.raycast.houseObject then
    self.temp.houseObject = SpawnHouseObject(
      self.raycast.houseObject.model,
      self.raycast.houseObject.coords,
      self.raycast.houseObject.coords.w
    )
  end

  Debug("creator:spawnTempEntities", self.temp)
end


function creator:open()
  if raycast.active then
    return Notification(i18n.t("raycast.must_be_completed"), "error")
  end

  if not self.jobs then
    local serverData = lib.callback.await("housing:getCreatorData", false)
    if not serverData then
      return Error("creator:open", "No data returned from server. Did you follow the docs?", serverData)
    end
    self.jobs = serverData.jobs
    self.furnitureCategories = serverData.furnitureCategories
  end

  ToggleHud(false)
  self.visible = true
  SetNuiFocus(true, true)
  self:updateUI()
  Debug("Creator opened")
end

function creator:close()
  if not self.visible then
    return
  end

  self.visible = false
  SendReactMessage("toggle_creator", { visible = false })
  ToggleHud(true)
  Debug("Creator closed")
end


RegisterCommand("realestate", function(source, args, rawCommand)
  if IsNuiFocused() then
    return
  end

  local hasPermission = lib.callback.await("housing:hasPermission", false)
  if not hasPermission then
    return Debug("You do not have isAdmin permissions")
  end

  creator:open()
end)

if Config.OpenJobMenu then
  RegisterKeyMapping("realestate", "Real estate menu", "keyboard", Config.OpenJobMenu)
end


function creator:getPointLength(points)
  local totalLength = 0.0

  for i = 1, #points do
    local nextPoint = points[i + 1] or points[1]
    local segment = points[i] - nextPoint
    totalLength = totalLength + #segment
  end

  return totalLength
end

function creator:drawRectangle(corners, zonePoints)
  local length = self:getPointLength(zonePoints)
  local numPoints = #zonePoints

  local isComplete = numPoints >= 4
  local r = isComplete and 0 or 255
  local g = isComplete and 255 or 40
  local b = isComplete and 0 or 24

  DrawPoly(
    corners[1].x, corners[1].y, corners[1].z,
    corners[2].x, corners[2].y, corners[2].z,
    corners[3].x, corners[3].y, corners[3].z,
    r, g, b, 100
  )
  DrawPoly(
    corners[2].x, corners[2].y, corners[2].z,
    corners[1].x, corners[1].y, corners[1].z,
    corners[3].x, corners[3].y, corners[3].z,
    r, g, b, 100
  )
  DrawPoly(
    corners[1].x, corners[1].y, corners[1].z,
    corners[4].x, corners[4].y, corners[4].z,
    corners[3].x, corners[3].y, corners[3].z,
    r, g, b, 100
  )
  DrawPoly(
    corners[4].x, corners[4].y, corners[4].z,
    corners[1].x, corners[1].y, corners[1].z,
    corners[3].x, corners[3].y, corners[3].z,
    r, g, b, 100
  )
end


function creator:drawLines()
  local halfHeight = vec(0, 0, self.raycast.height / 2)

  for i = 1, #self.raycast.points do
    local zCoord = self.raycast.zCoords or self.raycast.points[i].z

    self.raycast.points[i] = vec(self.raycast.points[i].x, self.raycast.points[i].y, zCoord)

    local top = self.raycast.points[i] + halfHeight
    local bottom = self.raycast.points[i] - halfHeight

    local nextPoint = self.raycast.points[i + 1]
    local nextTop
    if nextPoint then
      nextPoint = vec(self.raycast.points[i + 1].x, self.raycast.points[i + 1].y, zCoord)
      nextTop = nextPoint
    else
      nextTop = self.raycast.points[1]
    end
    nextTop = nextTop + halfHeight

    local nextBottom
    if self.raycast.points[i + 1] then
      nextBottom = vec(self.raycast.points[i + 1].x, self.raycast.points[i + 1].y, zCoord)
    else
      nextBottom = self.raycast.points[1]
    end
    nextBottom = nextBottom - halfHeight

    local currentPoint = self.raycast.points[i]
    local nextPointRaw
    if self.raycast.points[i + 1] then
      nextPointRaw = vec(self.raycast.points[i + 1].x, self.raycast.points[i + 1].y, zCoord)
    else
      nextPointRaw = self.raycast.points[1]
    end

    DrawLine(top.x, top.y, top.z, bottom.x, bottom.y, bottom.z, 255, 42, 24, 225)
    DrawLine(top.x, top.y, top.z, nextTop.x, nextTop.y, nextTop.z, 255, 42, 24, 225)
    DrawLine(bottom.x, bottom.y, bottom.z, nextBottom.x, nextBottom.y, nextBottom.z, 255, 42, 24, 225)
    DrawLine(currentPoint.x, currentPoint.y, currentPoint.z, nextPointRaw.x, nextPointRaw.y, nextPointRaw.z, 255, 42, 24, 225)

    self:drawRectangle({ top, bottom, nextBottom, nextTop }, self.raycast.points)
  end
end


function creator:isPointInAnyZone(point)
  for _, zone in pairs(HouseZones) do
    if zone:contains(point) then
      return true
    end
  end
  return false
end


function creator:raycastRectangle()
  self.raycast.points = {}

  local playerCoords = GetEntityCoords(cache.ped)
  self.raycast.zCoords = math.round(playerCoords.z) + 0.0
  self.raycast.height = 25.0

  ActionControls.leftClick.label = i18n.t("creator.raycast.add_point")
  ActionControls.rotate_z_scroll.label = i18n.t("creator.raycast.point_size")

  Notification(i18n.t("creator.raycast.info"), "info")

  raycast:freeCamera(function(cam)
    creator:drawLines()

    if IsDisabledControlJustPressed(0, ActionControls.cancel.codes[1]) or IsDisabledControlJustPressed(0, 322) then
      cam:destroy()
    end

    if IsDisabledControlJustPressed(0, ActionControls.done.codes[1]) then
      if not self.raycast.points then
        Notification(i18n.t("creator.raycast.no_point_selected"), "error")
      else
        cam:destroy()
      end
    end

    if IsDisabledControlJustPressed(0, ActionControls.leftClick.codes[1]) then
      if cam.hit then
        if self:isPointInAnyZone(cam.coords) then
          Notification(i18n.t("creator.raycast.point_in_another_zone"), "error")
        else
          self.raycast.points[#self.raycast.points + 1] = vec3(cam.coords.x, cam.coords.y, cam.coords.z)
        end
      end
    end

    if IsDisabledControlJustPressed(0, ActionControls.undo_point.codes[1]) then
      if #self.raycast.points > 0 then
        self.raycast.points[#self.raycast.points] = nil
      end
    end

    if IsDisabledControlPressed(0, ActionControls.boundary_height.codes[1]) then
      self.raycast.height = self.raycast.height + 15.0 * GetFrameTime()
    elseif IsDisabledControlPressed(0, ActionControls.boundary_height.codes[2]) then
      self.raycast.height = self.raycast.height - 15.0 * GetFrameTime()
    end
  end, { "done", "undo_point", "leftClick", "cancel", "boundary_height" })

  self.raycast.zCoords = nil

  if #self.raycast.points < 4 then
    return nil
  end

  return {
    points = self.raycast.points,
    thickness = self.raycast.height
  }
end


function creator:isInPoints(testCoord)
  local points = self.raycast.points
  local heightTolerance = self.raycast.height / 2.4
  local numPoints = #points

  if numPoints < 3 then
    return false
  end

  local minZ = points[1].z
  local maxZ = points[1].z

  for i = 2, #points do
    local z = points[i].z
    if minZ > z then minZ = z end
    if maxZ < z then maxZ = z end
  end

  if testCoord.z < (minZ - heightTolerance) or testCoord.z > (maxZ + heightTolerance) then
    return false
  end

  local testX = testCoord.x
  local testY = testCoord.y
  local inside = false

  for i = 1, #points do
    local j = i + 1
    if j > #points then j = 1 end

    local xi = points[i].x
    local yi = points[i].y
    local xj = points[j].x
    local yj = points[j].y

    if (testY < yi) ~= (testY < yj) then
      local intersectX = (xj - xi) * (testY - yi) / (yj - yi) + xi
      if testX < intersectX then
        inside = not inside
      end
    end
  end

  return inside
end


function creator:selectPoint(pointType, count, options)
  Debug("creator:selectPoint")

  if #self.raycast.points == 0 then
    if not (options and options.externalUsage) then
      return Notification(i18n.t("creator.no_points_selected"), "error")
    end
  end

  if not pointType then pointType = "empty" end
  if not count then count = 1 end
  if not options then options = {} end

  local selectedPoints = {}
  local currentHeading = 0
  local attachedObjects = {}

  if not options.points then
    options.points = {}
  end

  local entityFlag = self.raycast.flags[pointType]

  if "empty" ~= pointType then
    if not options.model then
      options.model = creator.raycast.defaults.models[pointType]
    end
    lib.requestModel(options.model, Config.DefaultRequestModelTimeout)
  end

  local function spawnEntity(model, coords)
    if not model then model = options.model end
    if not coords then coords = vec4(0, 0, 0, 0) end

    local entity = nil

    if "empty" == pointType then
      return entity
    end

    if "ped" == pointType then
      entity = CreatePed(28, model, coords.x, coords.y, coords.z, coords.w, false, false)
    elseif "vehicle" == pointType then
      entity = CreateVehicle(model, coords.x, coords.y, coords.z, coords.w, false, true)
    elseif "object" == pointType then
      entity = CreateObject(model, coords.x, coords.y, coords.z, false, false)
      if coords.w then
        SetEntityHeading(entity, coords.w)
      end
    end

    Wait(0)
    FreezeEntityPosition(entity, true)
    SetEntityInvincible(entity, true)
    return entity
  end


  local function applyPedOptions(pedEntity)
    if "ped" ~= pointType or not pedEntity then return end
    if not DoesEntityExist(pedEntity) then return end

    if options.ped and options.ped.anim then
      local anim = options.ped.anim
      if anim.dict and anim.name then
        lib.requestAnimDict(anim.dict, 3000)
        TaskPlayAnim(pedEntity, anim.dict, anim.name, 8.0, -8.0, -1, 1, 0, false, false, false)
      end
    end

    if options.ped and options.ped.attachObject then
      local attachInfo = options.ped.attachObject
      if attachInfo.model then
        local attachHash = joaat(attachInfo.model)
        lib.requestModel(attachHash, Config.DefaultRequestModelTimeout)

        local pedCoords = GetEntityCoords(pedEntity)
        local attachObj = CreateObject(attachHash, pedCoords.x, pedCoords.y, pedCoords.z, false, false, false)

        SetEntityAsMissionEntity(attachObj, true, true)
        SetEntityInvincible(attachObj, true)
        SetEntityCompletelyDisableCollision(attachObj, true, false)

        local boneIndex = tonumber(attachInfo.bone) or 18905
        local pos = vec3(attachInfo.pos.x, attachInfo.pos.y, attachInfo.pos.z)
        local rot = vec3(attachInfo.rot.x, attachInfo.rot.y, attachInfo.rot.z)

        AttachEntityToEntity(
          attachObj, pedEntity, GetPedBoneIndex(pedEntity, boneIndex),
          pos.x, pos.y, pos.z,
          rot.x, rot.y, rot.z,
          false, false, false, false, 2, true
        )

        attachedObjects[#attachedObjects + 1] = attachObj
        SetModelAsNoLongerNeeded(attachHash)
      end
    end
  end

  local previewEntity = spawnEntity()
  applyPedOptions(previewEntity)


  local controls = { "leftClick" }

  if "empty" ~= pointType then
    controls[#controls + 1] = "rotate_z"

    for _, pointData in pairs(options.points) do
      if pointData.model then
        lib.requestModel(pointData.model, Config.DefaultRequestModelTimeout)
        pointData.handle = spawnEntity(joaat(pointData.model), pointData.coords)
        SetEntityDrawOutline(pointData.handle, true)
        if pointData.coords.w then
          SetEntityHeading(pointData.handle, pointData.coords.w)
        end
      end
    end
  end

  ActionControls.leftClick.label = i18n.t("creator.raycast.add_point")
  ActionControls.rotate_z.label = i18n.t("creator.raycast.rotate_z_scroll")

  local startCamera
  if options.freeCamera and raycast.freeCamera then
    startCamera = raycast.freeCamera
  else
    startCamera = raycast.gameplayCamera
  end


  startCamera(raycast, function(cam)
    DisableControlAction(0, 25, true)
    DisableControlAction(0, 20, true)
    DisableControlAction(0, 73, true)

    for _, pointData in pairs(options.points) do
      DrawMarker(
        28, pointData.coords.x, pointData.coords.y, pointData.coords.z,
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
        0.2, 0.2, 0.2, 255, 42, 24, 100,
        false, false, 0, true, false, false, false
      )
    end

    creator:drawLines()

    if not cam.hit then
      return
    end

    if previewEntity then
      if cam.lastCoords ~= cam.coords then
        SetEntityCoords(previewEntity, cam.coords.x, cam.coords.y, cam.coords.z, false, false, true)
      end
    end

    if IsDisabledControlJustPressed(0, 24) then
      if not creator:isInPoints(cam.coords) then
        if not (options and options.externalUsage) then
          return Notification(i18n.t("creator.raycast.not_in_points"), "error")
        end
      end

      if options and options.checkInside then
        if not options.checkInside(cam.coords) then
          return Notification(i18n.t("creator.raycast.not_in_points"), "error")
        end
      end

      local selectedCoord = vec3(cam.coords.x, cam.coords.y, cam.coords.z)
      local newHandle = nil

      if "empty" ~= pointType then
        local entityCoords = GetEntityCoords(previewEntity)
        local entityHeading = GetEntityHeading(previewEntity)
        selectedCoord = vec4(entityCoords.x, entityCoords.y, entityCoords.z, entityHeading)
        newHandle = spawnEntity(nil, selectedCoord)
        applyPedOptions(newHandle)
        SetEntityAlpha(newHandle, 170, false)
      end

      selectedPoints[#selectedPoints + 1] = { coords = selectedCoord, handle = newHandle }

      if #selectedPoints == count then
        Notification(i18n.t("creator.raycast.completed"), "info")
        cam:destroy()
      else
        Notification(i18n.t("creator.raycast.selected_point", { count = #selectedPoints }), "info")
      end
    end


    if "empty" ~= pointType then
      if IsDisabledControlPressed(0, 20) then
        currentHeading = (currentHeading + 0.5) % 360
        SetEntityHeading(previewEntity, currentHeading)
      elseif IsDisabledControlPressed(0, 73) then
        currentHeading = (currentHeading - 0.5) % 360
        SetEntityHeading(previewEntity, currentHeading)
      end
    end
  end, controls, entityFlag, previewEntity)

  -- Cleanup
  for _, point in pairs(selectedPoints) do
    if point.handle then
      DeleteEntity(point.handle)
    end
  end

  for _, obj in pairs(attachedObjects) do
    if obj and DoesEntityExist(obj) then
      DeleteEntity(obj)
    end
  end

  for _, pointData in pairs(options.points) do
    if pointData.model then
      DeleteEntity(pointData.handle)
      SetModelAsNoLongerNeeded(pointData.model)
    end
  end

  Utils.RemoveInstructional()

  if previewEntity then
    DeleteEntity(previewEntity)
    SetModelAsNoLongerNeeded(options.model)
  end

  return table.map(selectedPoints, function(point)
    return point.coords
  end)
end


function creator:selectEntity(entityType, count, options)
  if #self.raycast.points == 0 then
    return Notification(i18n.t("creator.no_points_selected"), "error")
  end

  assert(entityType, "creator:selectEntity ::: entityType is required")
  if not count then count = 1 end
  if not options then options = {} end

  local selectedEntities = {}
  local lastEntity = 0
  local pedEntity = nil
  local offset = vec4(0, 0, 0, 0)

  ActionControls.leftClick.label = i18n.t("creator.raycast.select_entity")

  if not options.disabledEntities then
    options.disabledEntities = {}
  end

  local controls = { "leftClick" }

  for _, entity in pairs(options.disabledEntities) do
    SetEntityDrawOutline(entity, true)
  end

  if options.ped then
    lib.requestModel(options.ped.model, Config.DefaultRequestModelTimeout)
    pedEntity = CreatePed(28, options.ped.model, 0, 0, 0, 0, false, false)

    SetEntityVisible(pedEntity, false, false)
    SetEntityInvincible(pedEntity, true)
    FreezeEntityPosition(pedEntity, true)
    SetEntityCompletelyDisableCollision(pedEntity, true, false)

    local anim = options.ped.anim
    lib.requestAnimDict(anim.dict, 3000)
    TaskPlayAnim(pedEntity, anim.dict, anim.name, 8.0, 1.0, -1, 1, 0, false, false, false)
    RemoveAnimDict(anim.dict)

    options.disabledEntities[#options.disabledEntities + 1] = pedEntity
    controls[#controls + 1] = "rotate_z"
    controls[#controls + 1] = "offset_z"
  end

  Notification(i18n.t("creator.raycast.select_entity_info", { entityType = entityType }), "info")


  raycast:gameplayCamera(function(cam)
    DisableControlAction(0, ActionControls.rotate_z.codes[1], true)
    DisableControlAction(0, ActionControls.rotate_z.codes[2], true)
    DisableControlAction(0, ActionControls.offset_z.codes[1], true)
    DisableControlAction(0, ActionControls.offset_z.codes[2], true)

    creator:drawLines()

    if pedEntity then
      Utils.DrawEntityBoundingBox(pedEntity, 255, 42, 24, 100)
    end

    local entityChanged = lastEntity ~= cam.entity

    if entityChanged then
      if not table.contains(options.disabledEntities, lastEntity) then
        SetEntityDrawOutline(lastEntity, false)
        if pedEntity then
          SetEntityVisible(pedEntity, false, false)
        end
      end
    end

    lastEntity = cam.entity

    if cam.hit and cam.entity then
      if entityChanged then
        if not table.contains(options.disabledEntities, lastEntity) then
          SetEntityDrawOutline(cam.entity, true)
          if pedEntity then
            local entityCoords = GetEntityCoords(cam.entity)
            entityCoords = entityCoords + offset.xyz
            SetEntityCoords(pedEntity, entityCoords.x, entityCoords.y, entityCoords.z, false, false, false, false)
            SetEntityVisible(pedEntity, true, false)
            SetEntityHeading(pedEntity, GetEntityHeading(cam.entity) + offset.w)
          end
        end
      end

      if pedEntity then
        if IsDisabledControlPressed(0, ActionControls.rotate_z.codes[1]) then
          offset = offset + vec4(0, 0, 0, 0.5)
          lastEntity = 0
        elseif IsDisabledControlPressed(0, ActionControls.rotate_z.codes[2]) then
          offset = offset + vec4(0, 0, 0, -0.5)
          lastEntity = 0
        end

        if IsDisabledControlPressed(0, ActionControls.offset_z.codes[1]) then
          offset = offset + vec4(0, 0, 0.005, 0)
          lastEntity = 0
        elseif IsDisabledControlPressed(0, ActionControls.offset_z.codes[2]) then
          offset = offset + vec4(0, 0, -0.005, 0)
          lastEntity = 0
        end
      end


      if IsDisabledControlJustPressed(0, ActionControls.leftClick.codes[1]) then
        if not creator:isInPoints(GetEntityCoords(cam.entity)) then
          return Notification(i18n.t("creator.raycast.not_in_points"), "error")
        end

        if table.contains(options.disabledEntities, cam.entity) then
          return Notification(i18n.t("creator.raycast.entity_disabled"), "error")
        end

        local entityCoords = GetEntityCoords(cam.entity)
        local entityHeading = GetEntityHeading(cam.entity)

        selectedEntities[#selectedEntities + 1] = {
          entity = cam.entity,
          coords = vec4(entityCoords.x, entityCoords.y, entityCoords.z, entityHeading) + offset
        }

        if #selectedEntities == count then
          Notification(i18n.t("creator.raycast.completed"), "info")
          cam:destroy()
        else
          Notification(i18n.t("creator.raycast.selected_entity", { count = #selectedEntities }), "info")
        end
      end
    end
  end, controls)

  SetEntityDrawOutline(lastEntity, false)

  for _, entity in pairs(options.disabledEntities) do
    SetEntityDrawOutline(entity, false)
  end

  if pedEntity then
    DeleteEntity(pedEntity)
    SetModelAsNoLongerNeeded(options.ped.model)
  end

  if not (#selectedEntities > 0) or not selectedEntities then
    return nil
  end

  return selectedEntities
end


function creator:selectHouseObject()
  local tier, coords = RayCastSelector("customHouse")

  if not tier or not coords then
    return Notification(i18n.t("creator.no_points_selected"), "error")
  end

  return {
    tier = tier,
    coords = coords
  }
end


function creator:startPhotoMode(houseName, houseType, houseTier, shellCoords, exitCoords)
  self:spawnTempEntities()
  DisplayRadar(false)

  self.photo.houseData = {
    name = houseName,
    type = houseType,
    tier = houseTier,
    shellCoords = shellCoords,
    exitCoords = exitCoords
  }

  self.photo.initialPlayerCoords = GetEntityCoords(cache.ped)
  self.photo.isInShell = false

  if "shell" == houseType and houseTier and shellCoords then
    local shellConfig = Config.Shells[houseTier]
    if shellConfig then
      lib.requestModel(shellConfig.model, Config.DefaultRequestModelTimeout)

      local shellObj = CreateObject(
        joaat(shellConfig.model),
        shellCoords.x, shellCoords.y, shellCoords.z,
        false, false, false
      )

      SetEntityHeading(shellObj, shellCoords.h or 0.0)
      FreezeEntityPosition(shellObj, true)
      SetEntityCompletelyDisableCollision(shellObj, true, false)
      SetEntityInvincible(shellObj, true)
      SetModelAsNoLongerNeeded(shellConfig.model)

      self.photo.shellData = {
        objects = { shellObj },
        model = shellConfig.model
      }
    end
  end

  creator:close()
  SendReactMessage("toggle_photo_mode", { visible = true })

  local uploadedUrl = nil


  raycast:freeCamera(function(cam)
    -- Take screenshot (Enter key - control 191)
    if IsDisabledControlJustPressed(0, 191) then
      local presignedUrl = lib.callback.await("housing:getPresignedUrl", false, "image")

      if not presignedUrl then
        return Notification(i18n.t("creator.photos.token_not_set"), "error")
      end

      SendReactMessage("toggle_photo_mode", { visible = true, loading = true })

      local p = promise.new()

      exports["screenshot-basic"]:requestScreenshotUpload(presignedUrl, "file", function(response)
        local decoded = json.decode(response)

        if not (decoded and decoded.data) then
          p:resolve(false)
          return Notification(i18n.t("creator.photos.upload_failed"), "error")
        end

        p:resolve(decoded.data.url)
        uploadedUrl = decoded.data.url
      end)

      Citizen.Await(p)
      cam:destroy()
    end

    -- Toggle shell teleport (F key - control 23)
    if "shell" == houseType then
      if IsDisabledControlJustPressed(0, 23) then
        if self.photo.shellData and exitCoords then
          if not self.photo.isInShell then
            local pos = vec3(exitCoords.x, exitCoords.y, exitCoords.z)
            SetEntityCoords(cache.ped, pos.x, pos.y, pos.z, false, false, false, false)
            SetEntityHeading(cache.ped, exitCoords.w or 0.0)

            if cam.camera then
              local _, _, fwd, _ = GetEntityMatrix(cache.ped)
              cam.camPos = pos + fwd * 2.0
              SetCamCoord(cam.camera, cam.camPos.x, cam.camPos.y, cam.camPos.z)
            end

            self.photo.isInShell = true
          else
            local initialCoords = self.photo.initialPlayerCoords
            if initialCoords then
              SetEntityCoords(cache.ped, initialCoords.x, initialCoords.y, initialCoords.z, false, false, false, false)

              if cam.camera then
                local _, _, fwd, _ = GetEntityMatrix(cache.ped)
                cam.camPos = initialCoords + fwd * 2
                SetCamCoord(cam.camera, cam.camPos.x, cam.camPos.y, cam.camPos.z)
              end
            end

            self.photo.isInShell = false
          end
        end
      end
    end

    -- Cancel (Backspace - control 322)
    if IsDisabledControlJustPressed(0, 322) then
      cam:destroy()
    end
  end, nil, { line = false, scaleform = false })

  self:destroyPhotoMode()
  return uploadedUrl
end


function creator:destroyPhotoMode()
  if self.photo.isInShell then
    local initialCoords = self.photo.initialPlayerCoords
    if initialCoords then
      SetEntityCoords(cache.ped, initialCoords.x, initialCoords.y, initialCoords.z, false, false, false, false)
    end
  end

  if self.photo.shellData and self.photo.shellData.objects then
    for _, obj in pairs(self.photo.shellData.objects) do
      if DoesEntityExist(obj) then
        DeleteObject(obj)
      end
    end
    self.photo.shellData = nil
  end

  DisplayRadar(true)
  SendReactMessage("toggle_photo_mode", { visible = false })

  self.photo.houseData = nil
  self.photo.shellData = nil
  self.photo.isInShell = false
  self.photo.initialPlayerCoords = nil
  self.photo.initialCameraPos = nil
  self:destroyTempEntities()
end


RegisterNUICallback("creator_take_photo", function(data, cb)
  local houseName = data.houseName
  local houseType = data.houseType
  local houseTier = data.houseTier
  local shellCoords = data.shellCoords
  local exitCoords = data.exitCoords

  if not houseName then
    Notification(i18n.t("creator.photos.house_name_required"), "error")
    creator:open()
    return cb(nil)
  end

  local photoUrl = creator:startPhotoMode(houseName, houseType, houseTier, shellCoords, exitCoords)
  creator:open()
  cb(photoUrl)
end)
