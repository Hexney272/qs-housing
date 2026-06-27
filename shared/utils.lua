
Utils = {}
Utils.RenderList = {}
Utils.Characters = {}
Utils.Numbers = {}

for i = 48, 57 do
  table.insert(Utils.Numbers, string.char(i))
end

for i = 65, 90 do
  table.insert(Utils.Characters, string.char(i))
end

for i = 97, 122 do
  table.insert(Utils.Characters, string.char(i))
end

function Utils.GenerateRandomUid(charCount, numCount)
  math.randomseed(GetGameTimer())
  local result = ""
  for i = 1, charCount do
    result = result .. Utils.Characters[math.random(#Utils.Characters)]
  end
  for i = 1, numCount do
    result = result .. Utils.Numbers[math.random(#Utils.Numbers)]
  end
  return result
end

function Utils.GenerateUniqueId(existingIds, charCount, numCount)
  local uid = Utils.GenerateRandomUid(charCount, numCount)
  while existingIds[uid] do
    uid = Utils.GenerateRandomUid(charCount, numCount)
  end
  return uid
end


function Utils.GetForwardVector(rotation)
  local rot = rotation * math.pi / 180.0
  local cosX = math.abs(math.cos(rot.x))
  return vec3(-math.sin(rot.z) * cosX, math.cos(rot.z) * cosX, math.sin(rot.x))
end

function Utils.SplitString(str, separator)
  local sep = separator or ":"
  local result = {}
  local pattern = string.format("([^%s]+)", sep)
  str:gsub(pattern, function(match)
    result[#result + 1] = match
  end)
  return result
end

function Utils.BreakString(str, maxLength)
  if not str then
    return ""
  end
  if maxLength >= #str then
    return str
  end
  local trimmed = string.sub(str, 1, maxLength)
  local spacePos = string.find(trimmed, " ", #trimmed - 5)
  if spacePos then
    trimmed = string.sub(trimmed, 1, spacePos - 1)
  end
  return trimmed .. "..."
end


function Utils.JsonEncode(data)
  local function convertForEncode(tbl)
    local result = {}
    for key, value in pairs(tbl) do
      local valueType = type(value)
      if "vector4" == valueType then
        result[key] = { x = value.x, y = value.y, z = value.z, w = value.w }
      elseif "vector3" == valueType then
        result[key] = { x = value.x, y = value.y, z = value.z }
      elseif "vector2" == valueType then
        result[key] = { x = value.x, y = value.y }
      elseif "table" == valueType then
        result[key] = __utilsJsonEncodeInternalDecode(value)
      else
        result[key] = value
      end
    end
    return result
  end
  __utilsJsonEncodeInternalDecode = convertForEncode
  return json.encode(convertForEncode(data))
end


function Utils.JsonDecode(jsonStr)
  local function convertForDecode(tbl)
    local result = {}
    for key, value in pairs(tbl) do
      if type(value) == "table" then
        if value.x and value.y and value.z and value.w then
          if Utils.TableCount(value) == 4 then
            result[key] = vector4(value.x, value.y, value.z, value.w)
          end
        elseif value.x and value.x and value.z then
          if Utils.TableCount(value) == 3 then
            result[key] = vector3(value.x, value.y, value.z)
          end
        elseif value.x and value.y then
          if Utils.TableCount(value) == 2 then
            result[key] = vector2(value.x, value.y)
          end
        else
          result[key] = __utilsJsonDecodeInternalDecode(value)
        end
      else
        result[key] = value
      end
    end
    return result
  end
  __utilsJsonDecodeInternalDecode = convertForDecode
  return convertForDecode(json.decode(jsonStr))
end


function Utils.TableCopy(tbl)
  local copy = {}
  for key, value in pairs(tbl) do
    if type(value) == "table" then
      copy[key] = Utils.TableCopy(value)
    else
      copy[key] = value
    end
  end
  return copy
end

function Utils.TableCount(tbl)
  local count = 0
  for _, _ in pairs(tbl) do
    count = count + 1
  end
  return count
end


function Utils.PrintT(tbl)
  local visited = {}
  local function printRecursive(obj, indent)
    local objStr = tostring(obj)
    if visited[objStr] then
      print(indent .. "*" .. tostring(obj))
    else
      visited[objStr] = true
      if type(obj) == "table" then
        for key, value in pairs(obj) do
          if type(value) == "table" then
            print(indent .. "[" .. key .. "] => " .. tostring(obj) .. " {")
            printRecursive(value, indent .. string.rep(" ", string.len(key) + 8))
            print(indent .. string.rep(" ", string.len(key) + 6) .. "}")
          else
            print(indent .. "[" .. key .. "] => " .. tostring(value))
          end
        end
      else
        print(indent .. tostring(obj))
      end
    end
  end
  printRecursive(tbl, "  ")
end

function Utils.Log(...)
  print(string.format("[%s]", Protected.ResourceName), ...)
end


function Utils.CreateBlip(opts)
  local blip = AddBlipForCoord(opts.location.x, opts.location.y, opts.location.z)
  local shortRange = false
  if opts.shortRange then
    shortRange = opts.shortRange
  end
  SetBlipSprite(blip, opts.sprite or 1)
  SetBlipColour(blip, opts.color or 4)
  SetBlipScale(blip, opts.scale or 1.0)
  SetBlipDisplay(blip, opts.display or 4)
  SetBlipAsShortRange(blip, shortRange)
  SetBlipHighDetail(blip, opts.highDetail or true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(opts.text)
  EndTextCommandSetBlipName(blip)
  return blip
end

function Utils.RemoveBlip(blip)
  RemoveBlip(blip)
end

function Utils.AddMarkerToRenderList(name, opts)
  if not name or opts then
    return
  end
  local entry = {}
  entry.name = name
  entry.type = "marker"
  entry.opts = opts
  table.insert(Utils.RenderList, entry)
  return entry
end


function Utils.RemoveMarkerFromRenderList(entry)
  for i, item in ipairs(Utils.RenderList) do
    if item == entry then
      table.remove(Utils.RenderList, i)
      return
    end
  end
end

function Utils.AddDrawTextToRenderList(name, opts)
  if not name or not opts then
    return
  end
  local entry = {}
  entry.name = name
  entry.type = "drawText"
  entry.opts = opts
  table.insert(Utils.RenderList, entry)
  return entry
end

function Utils.RemoveDrawTextFromRenderList(entry)
  for i, item in ipairs(Utils.RenderList) do
    if item == entry then
      table.remove(Utils.RenderList, i)
      return
    end
  end
end


function Utils.RotateVectorFlat(vec, angleDeg)
  angleDeg = angleDeg / 57.2958
  local cosA = math.cos(angleDeg)
  local sinA = math.sin(angleDeg)
  local vecType = type(vec)
  if "vector4" == vecType then
    return vector4(cosA * vec.x - sinA * vec.y, sinA * vec.x + cosA * vec.y, vec.z, vec.w)
  elseif "vector3" == vecType then
    return vector3(cosA * vec.x - sinA * vec.y, sinA * vec.x + cosA * vec.y, vec.z)
  elseif "vector2" == vecType then
    return vector2(cosA * vec.x - sinA * vec.y, sinA * vec.x + cosA * vec.y)
  end
end

function Utils.CreateCamera(camType, pos, rot, setActive, pointAtEntity, transitionTime)
  local cam = CreateCamWithParams(camType, pos.x, pos.y, pos.z, 0, 0, 0, 50.0)
  SetCamCoord(cam, pos.x, pos.y, pos.z)
  SetCamRot(cam, rot.x, rot.y, rot.z, 2)
  if setActive then
    SetCamActive(cam, true)
    RenderScriptCams(true, true, transitionTime or 0, true, true)
  end
  if pointAtEntity then
    PointCamAtEntity(cam, pointAtEntity)
  end
  return cam
end


function Utils.DrawMarker(opts)
  if not opts.location or not opts.location.x or not opts.location.y or not opts.location.z then
    return
  end
  DrawMarker(
    opts.type or 0,
    opts.location.x,
    opts.location.y,
    opts.location.z,
    (opts.direction and opts.direction.x) or 1.0,
    (opts.direction and opts.direction.y) or 0.0,
    (opts.direction and opts.direction.z) or 0.0,
    (opts.rotation and opts.rotation.x) or 1.0,
    (opts.rotation and opts.rotation.y) or 0.0,
    (opts.rotation and opts.rotation.z) or 0.0,
    (opts.scale and opts.scale.x) or 1.0,
    (opts.scale and opts.scale.y) or 1.0,
    (opts.scale and opts.scale.z) or 1.0,
    opts.red or 255,
    opts.green or 255,
    opts.blue or 255,
    opts.alpha or 255,
    opts.bobUpAndDown or false,
    (nil == opts.faceCamera) or opts.faceCamera,
    opts.p19 or 2,
    opts.rotate or false
  )
end


function Utils.ShowNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentSubstringPlayerName(text)
  DrawNotification(false, true)
end

function Utils.ShowHelpNotification(text)
  AddTextEntry("housingHelp", text)
  DisplayHelpTextThisFrame("housingHelp", false)
end

function Utils.DrawText3D(opts)
  local worldPos = vector3(opts.location.x, opts.location.y, opts.location.z)
  local onScreen, screenX, screenY = World3dToScreen2d(worldPos.x, worldPos.y, worldPos.z)
  local camCoords = GetGameplayCamCoords()
  local dist = GetDistanceBetweenCoords(camCoords, worldPos.x, worldPos.y, worldPos.z, true)
  local sizeVal = opts.size or 1
  local scale = sizeVal / dist * 2
  local fov = GetGameplayCamFov()
  scale = scale * (1 / fov * 100)
  if onScreen then
    SetTextScale(0.0 * scale, 0.55 * scale)
    SetTextFont(opts.font or 1)
    SetTextColour(opts.red or 255, opts.green or 255, opts.blue or 255, opts.alpha or 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(opts.text)
    DrawText(screenX, screenY)
  end
end


if IsDuplicityVersion() then
  function Utils.TriggerClientEvent(eventName, targetPlayer, ...)
    local fullEventName = string.format("%s:%s", Protected.ResourceName, eventName)
    TriggerClientEvent(fullEventName, targetPlayer, ...)
    if Config.Debug then
      Utils.Log(string.format("Triggering client event: %s (%i).", fullEventName, targetPlayer))
    end
  end

  function Utils.GetDatabaseName()
    local connStr = GetConvar("mysql_connection_string", "Empty")
    if not connStr or "Empty" == connStr then
      return false
    else
      local dbStart, dbEnd = string.find(connStr, "database=")
      if not dbStart or not dbEnd then
        local protoStart, protoEnd = string.find(connStr, "mysql://")
        if not protoStart or not protoEnd then
          return false
        else
          local _, atEnd = string.find(connStr, "@", protoEnd)
          local _, slashEnd = string.find(connStr, "/", atEnd + 1)
          local _, qEnd = string.find(connStr, "?")
          local nameEnd
          if qEnd then
            nameEnd = qEnd - 1
          else
            nameEnd = connStr:len()
          end
          return string.sub(connStr, slashEnd + 1, nameEnd)
        end
      else
        local _, semiEnd = string.find(connStr, ";", dbEnd)
        local nameEnd
        if semiEnd then
          nameEnd = semiEnd - 1
        else
          nameEnd = connStr:len()
        end
        return string.sub(connStr, dbEnd + 1, nameEnd)
      end
    end
  end


else
  function Utils.TriggerServerEvent(eventName, ...)
    local fullEventName = string.format("%s:%s", Protected.ResourceName, eventName)
    TriggerServerEvent(fullEventName, ...)
    if Config.Debug then
      Utils.Log(string.format("Triggering server event: %s.", fullEventName))
    end
  end
end

function Utils.RegisterNetEvent(eventName, handler)
  local fullEventName = string.format("%s:%s", Protected.ResourceName, eventName)
  RegisterNetEvent(fullEventName)
  if Config.Debug then
    Utils.Log(string.format("Net event %s registered.", fullEventName))
    AddEventHandler(fullEventName, function(...)
      Utils.Log(string.format("Net event %s triggered.", fullEventName))
      handler(...)
    end)
  else
    AddEventHandler(fullEventName, handler)
  end
end

function Utils.RegisterEvent(eventName, handler)
  local fullEventName = string.format("%s:%s", Protected.ResourceName, eventName)
  AddEventHandler(fullEventName, handler)
end


function Utils.DisableControlActions(...)
  local count = select("#", ...)
  for i = 1, count do
    local control = select(i, ...)
    DisableControlAction(0, control, true)
  end
end

function Utils.DrawEntityBoundingBox(entity, r, g, b, a)
  local bbox = Utils.GetEntityBoundingBox(entity)
  Utils.DrawBoundingBox(bbox, r, g, b, a)
end

function Utils.GetEntityBoundingBox(entity)
  local minDim, maxDim = GetModelDimensions(GetEntityModel(entity))
  local pad = 0.001
  local corners = {}
  corners[1] = GetOffsetFromEntityInWorldCoords(entity, minDim.x - pad, minDim.y - pad, minDim.z - pad)
  corners[2] = GetOffsetFromEntityInWorldCoords(entity, maxDim.x + pad, minDim.y - pad, minDim.z - pad)
  corners[3] = GetOffsetFromEntityInWorldCoords(entity, maxDim.x + pad, maxDim.y + pad, minDim.z - pad)
  corners[4] = GetOffsetFromEntityInWorldCoords(entity, minDim.x - pad, maxDim.y + pad, minDim.z - pad)
  corners[5] = GetOffsetFromEntityInWorldCoords(entity, minDim.x - pad, minDim.y - pad, maxDim.z + pad)
  corners[6] = GetOffsetFromEntityInWorldCoords(entity, maxDim.x + pad, minDim.y - pad, maxDim.z + pad)
  corners[7] = GetOffsetFromEntityInWorldCoords(entity, maxDim.x + pad, maxDim.y + pad, maxDim.z + pad)
  corners[8] = GetOffsetFromEntityInWorldCoords(entity, minDim.x - pad, maxDim.y + pad, maxDim.z + pad)
  return corners
end


function Utils.Get2DEntityBoundingBox(entity)
  local minDim, maxDim = GetModelDimensions(GetEntityModel(entity))
  local pad = 0.001
  local corners = {}
  corners[1] = GetOffsetFromEntityInWorldCoords(entity, minDim.x - pad, minDim.y - pad, minDim.z - pad)
  corners[2] = GetOffsetFromEntityInWorldCoords(entity, maxDim.x + pad, minDim.y - pad, minDim.z - pad)
  corners[3] = GetOffsetFromEntityInWorldCoords(entity, maxDim.x + pad, maxDim.y + pad, minDim.z - pad)
  corners[4] = GetOffsetFromEntityInWorldCoords(entity, minDim.x - pad, maxDim.y + pad, minDim.z - pad)
  return corners
end

function Utils.DrawBoundingBox(corners, r, g, b, a)
  local polyMatrix = Utils.GetBoundingBoxPolyMatrix(corners)
  local edgeMatrix = Utils.GetBoundingBoxEdgeMatrix(corners)
  Utils.DrawPolyMatrix(polyMatrix, r, g, b, a)
  Utils.DrawEdgeMatrix(edgeMatrix, 255, 255, 255, 255)
end

function Utils.GetBoundingBoxPolyMatrix(corners)
  local polys = {}
  polys[1] = { corners[3], corners[2], corners[1] }
  polys[2] = { corners[4], corners[3], corners[1] }
  polys[3] = { corners[5], corners[6], corners[7] }
  polys[4] = { corners[5], corners[7], corners[8] }
  polys[5] = { corners[3], corners[4], corners[7] }
  polys[6] = { corners[8], corners[7], corners[4] }
  polys[7] = { corners[1], corners[2], corners[5] }
  polys[8] = { corners[6], corners[5], corners[2] }
  polys[9] = { corners[2], corners[3], corners[6] }
  polys[10] = { corners[3], corners[7], corners[6] }
  polys[11] = { corners[5], corners[8], corners[4] }
  polys[12] = { corners[5], corners[4], corners[1] }
  return polys
end


function Utils.GetBoundingBoxEdgeMatrix(corners)
  local edges = {}
  edges[1] = { corners[1], corners[2] }
  edges[2] = { corners[2], corners[3] }
  edges[3] = { corners[3], corners[4] }
  edges[4] = { corners[4], corners[1] }
  edges[5] = { corners[5], corners[6] }
  edges[6] = { corners[6], corners[7] }
  edges[7] = { corners[7], corners[8] }
  edges[8] = { corners[8], corners[5] }
  edges[9] = { corners[1], corners[5] }
  edges[10] = { corners[2], corners[6] }
  edges[11] = { corners[3], corners[7] }
  edges[12] = { corners[4], corners[8] }
  return edges
end

function Utils.DrawPolyMatrix(polys, r, g, b, a)
  for i = 1, #polys do
    local tri = polys[i]
    DrawPoly(
      tri[1].x, tri[1].y, tri[1].z,
      tri[2].x, tri[2].y, tri[2].z,
      tri[3].x, tri[3].y, tri[3].z,
      r, g, b, a
    )
  end
end

function Utils.DrawEdgeMatrix(edges, r, g, b, a)
  for i = 1, #edges do
    local edge = edges[i]
    DrawLine(
      edge[1].x, edge[1].y, edge[1].z,
      edge[2].x, edge[2].y, edge[2].z,
      r, g, b, a
    )
  end
end


function Utils.DrawScaleform(scaleform)
  DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
end

function Utils.DisableControlAction(control)
  DisableControlAction(0, control, true)
end

function Utils.CreateInstructional(controls)
  local scaleform = Scaleforms.LoadMovie("INSTRUCTIONAL_BUTTONS")
  Scaleforms.PopVoid(scaleform, "CLEAR_ALL")
  Scaleforms.PopInt(scaleform, "SET_CLEAR_SPACE", 200)
  for i = 1, #controls do
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(i - 1)
    for j = 1, #controls[i].codes do
      _ENV["ScaleformMovieMethodAddParamPlayerNameString"](
        GetControlInstructionalButton(0, controls[i].codes[j], true)
      )
    end
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(controls[i].label)
    EndTextCommandScaleformString()
    PopScaleformMovieFunctionVoid()
  end
  Scaleforms.PopVoid(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
  return scaleform
end


function Utils.GetControls(controlList)
  local result = {}
  local count = #controlList
  for i = 1, count do
    local item = controlList[i]
    local control = nil
    if type(item) == "table" then
      control = ActionControls[item.key]
      if not control then
        Error("Utils.GetControls ::: " .. item.key .. " not found")
        return
      end
      control.label = item.label
    else
      control = ActionControls[item]
    end
    result[#result + 1] = control
  end
  return result
end

local camPositionChanged = false
local camRotationChanged = false

function Utils.HandleFlyCam(cam, opts)
  if not opts then
    opts = {}
  end
  local boundPos = opts.boundPos
  local boundDist = opts.boundDist
  if nil == opts.mouse then
    opts.mouse = true
  end
  if nil == opts.keyboard then
    opts.keyboard = true
  end


  local camPos = GetCamCoord(cam)
  local camRot = GetCamRot(cam, 2)
  local controls = ActionControls
  local camOpts = CameraOptions
  local mouseX = GetDisabledControlNormal(0, 1)
  local mouseY = GetDisabledControlNormal(0, 2)
  local rightVec, upVec, forwardVec, _ = GetCamMatrix(cam)
  local worldUp = vector3(0.0, 0.0, 1.0)
  local flatRight = norm(vector3(rightVec.x, rightVec.y, 0.0))
  local flatForward = norm(vector3(upVec.x, upVec.y, 0.0))
  local dt = GetFrameTime()

  if opts.keyboard then
    if IsDisabledControlPressed(0, controls.up.codes[2]) then
      camPos = camPos + worldUp * (camOpts.climbSpeed * dt)
      camPositionChanged = true
    elseif IsDisabledControlPressed(0, controls.up.codes[1]) then
      camPos = camPos - worldUp * (camOpts.climbSpeed * dt)
      camPositionChanged = true
    end
    if IsDisabledControlPressed(0, controls.forward.codes[2]) then
      camPos = camPos + flatForward * (camOpts.moveSpeed * dt)
      camPositionChanged = true
    elseif IsDisabledControlPressed(0, controls.forward.codes[1]) then
      camPos = camPos - flatForward * (camOpts.moveSpeed * dt)
      camPositionChanged = true
    end
    if IsDisabledControlPressed(0, controls.right.codes[1]) then
      camPos = camPos + flatRight * (camOpts.moveSpeed * dt)
      camPositionChanged = true
    elseif IsDisabledControlPressed(0, controls.right.codes[2]) then
      camPos = camPos - flatRight * (camOpts.moveSpeed * dt)
      camPositionChanged = true
    end
  end


  if opts.mouse then
    if 0.0 ~= mouseY then
      local newRotX = math.max(-80.0, math.min(80.0, camRot.x - mouseY * camOpts.lookSpeedX * dt))
      camRot = vector3(newRotX, camRot.y, camRot.z)
      camRotationChanged = true
    end
    if 0.0 ~= mouseX then
      camRot = vector3(camRot.x, camRot.y, camRot.z - mouseX * camOpts.lookSpeedY * dt)
      camRotationChanged = true
    end
  end

  if camPositionChanged then
    SetCamCoord(cam, camPos)
  end
  if camRotationChanged then
    SetCamRot(cam, camRot, 2)
  end

  if boundPos and boundDist then
    local distFromBound = #(camPos - boundPos)
    if boundDist < distFromBound then
      local dir = norm(camPos - boundPos)
      camPos = boundPos + dir * boundDist
      SetCamCoord(cam, camPos)
    end
  end

  if opts.updatePlayerCoords then
    SetEntityCoords(cache.ped, camPos.x, camPos.y, camPos.z, false, false, false, false)
    SetEntityHeading(cache.ped, camRot.z)
  end

  return camPos, camRot
end


function Utils.DestroyFlyCam(cam, transitionTime)
  if not transitionTime then
    transitionTime = 0
  end
  SetCamActive(cam, false)
  RenderScriptCams(false, true, transitionTime, true, true)
  DestroyCam(cam, false)
  SetFocusEntity(cache.ped)
end

function Utils.ScreenToWorld()
  local camRot = GetGameplayCamRot(0)
  local camCoord = GetGameplayCamCoord()
  local cursorX = GetControlNormal(0, 239)
  local cursorY = GetControlNormal(0, 240)
  local cursor = vector2(cursorX, cursorY)
  local worldPos, direction = Utils.ScreenRelToWorld(camCoord, camRot, cursor)
  local destination = camCoord + direction * 50.0
  local ray = StartShapeTestRay(worldPos.x, worldPos.y, worldPos.z, destination.x, destination.y, destination.z, -1, 0, 4)
  local _, hit, hitCoords, _, hitEntity = GetShapeTestResult(ray)
  return hit, hitCoords, hitEntity
end


function Utils.ScreenRelToWorld(camPos, camRot, screenCoord)
  local direction = Utils.RotationToDirection(camRot)
  local rotUp = vector3(camRot.x + 1.0, camRot.y, camRot.z)
  local rotDown = vector3(camRot.x - 1.0, camRot.y, camRot.z)
  local rotLeft = vector3(camRot.x, camRot.y, camRot.z - 1.0)
  local rotRight = vector3(camRot.x, camRot.y, camRot.z + 1.0)

  local dirUp = Utils.RotationToDirection(rotRight)
  local dirDown = Utils.RotationToDirection(rotLeft)
  local verticalDelta = dirUp - dirDown

  local dirRight = Utils.RotationToDirection(rotUp)
  local dirLeft = Utils.RotationToDirection(rotDown)
  local horizontalDelta = dirRight - dirLeft

  local roll = -camRot.y * math.pi / 180.0
  local vertRotated = verticalDelta * math.cos(roll) - horizontalDelta * math.sin(roll)
  local horizRotated = verticalDelta * math.sin(roll) + horizontalDelta * math.cos(roll)

  local worldPoint = camPos + direction * 1.0
  local offsetPoint = worldPoint + vertRotated + horizRotated

  local screenOffset = Utils.World3DToScreen2D(offsetPoint)
  local screenCenter = Utils.World3DToScreen2D(worldPoint)

  local scaleX = (screenCoord.x - screenCenter.x) / (screenOffset.x - screenCenter.x)
  local scaleY = (screenCoord.y - screenCenter.y) / (screenOffset.y - screenCenter.y)

  local worldResult = worldPoint + vertRotated * scaleX + horizRotated * scaleY
  local dirResult = direction + vertRotated * scaleX + horizRotated * scaleY

  return worldResult, dirResult
end


function Utils.RotationToDirection(rotation)
  local radX = rotation.x * math.pi / 180.0
  local radZ = rotation.z * math.pi / 180.0
  local cosX = math.abs(math.cos(radX))
  return vector3(-math.sin(radZ) * cosX, math.cos(radZ) * cosX, math.sin(radX))
end

function Utils.World3DToScreen2D(worldCoord)
  local _, screenX, screenY = GetScreenCoordFromWorldCoord(worldCoord.x, worldCoord.y, worldCoord.z)
  return vector2(screenX, screenY)
end

function Utils.CreateObject(model, position)
  if type(model) == "string" then
    model = joaat(model) or model
  end
  lib.requestModel(model, Config.DefaultRequestModelTimeout)
  RequestModel(model)
  while not HasModelLoaded(model) do
    Wait(0)
  end
  local obj = CreateObject(model, position.x, position.y, position.z, false, false, false)
  SetModelAsNoLongerNeeded(model)
  return obj
end


local function iterateEntities(findFirst, findNext, endFind)
  local results = {}
  local handle, entity = findFirst()
  while entity do
    results[#results + 1] = entity
    entity = findNext(handle)
  end
  endFind(handle)
  return results
end

function Utils.GetAllPeds()
  return iterateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function Utils.GetAllObjects()
  return iterateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function Utils.GetAllVehicles()
  return iterateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function Utils.FindNthInString(str, pattern, n)
  local startPos = nil
  local endPos = nil
  for i = 1, n do
    startPos, endPos = str:find(pattern, endPos and (endPos + 1) or 0)
  end
  return startPos, endPos
end


function RotationToDirection(rotation)
  local radZ = math.rad(rotation.z)
  local radX = math.rad(rotation.x)
  local cosX = math.abs(math.cos(radX))
  return vector3(-math.sin(radZ) * cosX, math.cos(radZ) * cosX, math.sin(radX))
end

function Utils.GetCamera()
  local cam = {}
  cam.coords = GetFinalRenderedCamCoord()
  cam.rotation = GetFinalRenderedCamRot(2)
  return cam
end

function ScreenRelToWorld(camPos, camRot, screenCoord)
  local dist = 1000.0
  local direction = RotationToDirection(camRot)
  local rotUp = camRot + vector3(dist, 0, 0)
  local rotDown = camRot + vector3(-dist, 0, 0)
  local rotLeft = camRot + vector3(0, 0, -dist)
  local rotRight = camRot + vector3(0, 0, dist)

  local dirUp = RotationToDirection(rotRight)
  local dirDown = RotationToDirection(rotLeft)
  local verticalDelta = dirUp - dirDown

  local dirRight = RotationToDirection(rotUp)
  local dirLeft = RotationToDirection(rotDown)
  local horizontalDelta = dirRight - dirLeft

  local roll = math.rad(camRot.y)
  roll = -roll
  local vertRotated = verticalDelta * math.cos(roll) - horizontalDelta * math.sin(roll)
  local horizRotated = verticalDelta * math.sin(roll) + horizontalDelta * math.cos(roll)

  local worldPoint = camPos + direction * dist
  local offsetPoint = worldPoint + vertRotated + horizRotated


  local _, offX, offY = GetScreenCoordFromWorldCoord(offsetPoint.x, offsetPoint.y, offsetPoint.z)
  local screenOff = {}
  screenOff.X = offX
  screenOff.Y = offY
  if not (screenOff and offX) or not offY then
    return camPos + direction * dist
  end

  local centerPoint = camPos + direction * dist
  local _, cenX, cenY = GetScreenCoordFromWorldCoord(centerPoint.x, centerPoint.y, centerPoint.z)
  local screenCen = {}
  screenCen.X = cenX
  screenCen.Y = cenY
  if not (screenCen and cenX) or not cenY then
    return camPos + direction * dist
  end

  local epsilon = 1.0E-5
  if epsilon > math.abs(screenOff.X - screenCen.X) or epsilon > math.abs(screenOff.Y - screenCen.Y) then
    return camPos + direction * dist
  end

  local scaleX = (screenCoord.x - screenCen.X) / (screenOff.X - screenCen.X)
  local scaleY = (screenCoord.y - screenCen.Y) / (screenOff.Y - screenCen.Y)

  return camPos + direction * dist + vertRotated * scaleX + horizRotated * scaleY
end

function LocationInWorld(targetPos, cam, flags)
  local camCoord = GetCamCoord(cam)
  local ped = cache.ped
  local ray = StartShapeTestRay(camCoord.x, camCoord.y, camCoord.z, targetPos.x, targetPos.y, targetPos.z, flags, ped, 0)
  local _, hit, hitCoords, _, hitEntity = GetShapeTestResult(ray)
  currentCoords = hitCoords
  return hit, hitCoords, hitEntity
end


function Utils.getCursorHitCoords(ignorePed)
  local cursorX = GetDisabledControlNormal(0, 239)
  local cursorY = GetDisabledControlNormal(0, 240)
  local worldOrigin, worldDir = GetWorldCoordFromScreenCoord(cursorX, cursorY)
  local startPos = worldOrigin
  local endPos = worldOrigin + worldDir * 120
  local ray = StartShapeTestSweptSphere(
    startPos.x, startPos.y, startPos.z,
    endPos.x, endPos.y, endPos.z,
    0.01, 17, ignorePed or cache.ped, 4
  )
  local status, hit, hitCoords, _, hitEntity = GetShapeTestResult(ray)
  if not status then
    return nil, nil
  end
  return hitCoords, hitEntity
end

function string.includes(str, pattern)
  if type(pattern) == "string" then
    return str == pattern
  elseif type(pattern) == "table" then
    for _, v in ipairs(pattern) do
      if str == v then
        return true
      end
    end
    return false
  end
end


Keys = {}
Keys.ESC = 322
Keys.F1 = 288
Keys.F2 = 289
Keys.F3 = 170
Keys.F5 = 166
Keys.F6 = 167
Keys.F7 = 168
Keys.F8 = 169
Keys.F9 = 56
Keys.F10 = 57
Keys["~"] = 243
Keys["1"] = 157
Keys["2"] = 158
Keys["3"] = 160
Keys["4"] = 164
Keys["5"] = 165
Keys["6"] = 159
Keys["7"] = 161
Keys["8"] = 162
Keys["9"] = 163
Keys["-"] = 84
Keys["="] = 83
Keys.BACKSPACE = 177
Keys.TAB = 37
Keys.Q = 44
Keys.W = 32
Keys.E = 38
Keys.R = 45
Keys.T = 245
Keys.Y = 246
Keys.U = 303
Keys.P = 199
Keys["["] = 39
Keys["]"] = 40
Keys.ENTER = 18
Keys.CAPS = 137
Keys.A = 34
Keys.S = 8
Keys.D = 9
Keys.F = 23
Keys.G = 47
Keys.H = 74
Keys.K = 311
Keys.L = 182
Keys.LEFTSHIFT = 21
Keys.Z = 20
Keys.X = 73
Keys.C = 26
Keys.V = 0
Keys.B = 29
Keys.N = 249
Keys.M = 244


Keys[","] = 82
Keys["."] = 81
Keys.LEFTCTRL = 36
Keys.LEFTALT = 19
Keys.SPACE = 22
Keys.RIGHTCTRL = 70
Keys.HOME = 213
Keys.PAGEUP = 10
Keys.PAGEDOWN = 11
Keys.DELETE = 178
Keys.LEFT = 174
Keys.RIGHT = 175
Keys.TOP = 27
Keys.DOWN = 173
Keys.NENTER = 201
Keys.N4 = 108
Keys.N5 = 60
Keys.N6 = 107
Keys["N+"] = 96
Keys["N-"] = 97
Keys.N7 = 117
Keys.N8 = 61
Keys.N9 = 118

DrawingInstructional = false

function Utils.DrawInstructional(controlList)
  if DrawingInstructional then
    Debug("Instructional", "Instructional already being drawn, updating keys.")
    return
  end
  CreateThread(function()
    DrawingInstructional = true
    while DrawingInstructional do
      Wait(0)
      local controls = Utils.GetControls(controlList)
      local scaleform = Utils.CreateInstructional(controls)
      Utils.DrawScaleform(scaleform)
    end
  end)
end

function Utils.RemoveInstructional()
  DrawingInstructional = false
end


local savedClothes = {}

function Utils.stripPlayer()
  local ped = cache.ped
  ToggleInventoryClothing(true)
  local clothes = {}
  clothes["t-shirt"] = {
    item = GetPedDrawableVariation(ped, 8),
    texture = GetPedTextureVariation(ped, 8)
  }
  clothes.torso2 = {
    item = GetPedDrawableVariation(ped, 11),
    texture = GetPedTextureVariation(ped, 11)
  }
  clothes.arms = {
    item = GetPedDrawableVariation(ped, 3),
    texture = GetPedTextureVariation(ped, 3)
  }
  clothes.pants = {
    item = GetPedDrawableVariation(ped, 4),
    texture = GetPedTextureVariation(ped, 4)
  }
  clothes.shoes = {
    item = GetPedDrawableVariation(ped, 6),
    texture = GetPedTextureVariation(ped, 6)
  }
  savedClothes = clothes

  local nakedClothes = Config.NakedPlayerClothes
  local model = GetEntityModel(ped)
  local gender
  if model == joaat("mp_m_freemode_01") then
    gender = "Male"
  else
    gender = "Female"
  end
  Utils.wearClothes(nakedClothes[gender])
end

function Utils.wearClothes(clothes)
  local ped = cache.ped
  SetPedComponentVariation(ped, 8, clothes["t-shirt"].item, clothes["t-shirt"].texture, 0)
  SetPedComponentVariation(ped, 11, clothes.torso2.item, clothes.torso2.texture, 0)
  SetPedComponentVariation(ped, 3, clothes.arms.item, clothes.arms.texture, 0)
  SetPedComponentVariation(ped, 4, clothes.pants.item, clothes.pants.texture, 0)
  SetPedComponentVariation(ped, 6, clothes.shoes.item, clothes.shoes.texture, 0)
end

function Utils.restorePlayerClothes()
  ToggleInventoryClothing(true)
  Utils.wearClothes(savedClothes)
  savedClothes = {}
  ToggleInventoryClothing(false)
end
