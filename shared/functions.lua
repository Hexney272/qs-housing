
local numbers = {}
local characters = {}

for i = 48, 57 do
  table.insert(numbers, string.char(i))
end

for i = 65, 90 do
  table.insert(characters, string.char(i))
end

for i = 97, 122 do
  table.insert(characters, string.char(i))
end

function GetRandomNumber(length)
  Citizen.Wait(0)
  if length > 0 then
    local result = GetRandomNumber(length - 1)
    local index = math.random(1, #numbers)
    local char = numbers[index]
    result = result .. char
    return result
  else
    return ""
  end
end

function GetRandomLetter(length)
  Citizen.Wait(0)
  if length > 0 then
    local result = GetRandomLetter(length - 1)
    local index = math.random(1, #characters)
    local char = characters[index]
    result = result .. char
    return result
  else
    return ""
  end
end

function MathTrim(str)
  if str then
    return string.gsub(str, "^%s*(.-)%s*$", "%1")
  else
    return nil
  end
end

local resourceVersion = GetResourceMetadata(GetCurrentResourceName(), "version", 0)

function Debug(...)
  if Config.Debug then
    local args = {}
    local a1, a2, a3, a4, a5, a6, a7, a8 = ...
    args[1] = a1
    args[2] = a2
    args[3] = a3
    args[4] = a4
    args[5] = a5
    args[6] = a6
    args[7] = a7
    args[8] = a8
    for i, v in ipairs(args) do
      if type(v) == "table" then
        args[i] = json.encode(v)
      end
    end
    print("^5[DEBUG " .. resourceVersion .. "]^7", table.unpack(args))
  end
end

function Warning(...)
  local msg = "^3HOUSING WARNING:^0 "
  local args = {}
  local a1, a2, a3, a4, a5, a6, a7 = ...
  args[1] = a1
  args[2] = a2
  args[3] = a3
  args[4] = a4
  args[5] = a5
  args[6] = a6
  args[7] = a7
  for _, v in pairs(args) do
    msg = msg .. tostring(v) .. "\t"
  end
  print(msg)
end

function Info(...)
  local msg = "^5HOUSING INFO:^0 "
  local args = {}
  local a1, a2, a3, a4, a5, a6, a7 = ...
  args[1] = a1
  args[2] = a2
  args[3] = a3
  args[4] = a4
  args[5] = a5
  args[6] = a6
  args[7] = a7
  for _, v in pairs(args) do
    if type(v) == "table" then
      msg = msg .. json.encode(v) .. "\t"
    else
      msg = msg .. tostring(v) .. "\t"
    end
  end
  print(msg)
end

function Error(...)
  local msg = "^1HOUSING ERROR:^0 "
  local args = {}
  local a1, a2, a3, a4, a5, a6, a7 = ...
  args[1] = a1
  args[2] = a2
  args[3] = a3
  args[4] = a4
  args[5] = a5
  args[6] = a6
  args[7] = a7
  for _, v in pairs(args) do
    if type(v) == "table" then
      msg = msg .. json.encode(v) .. "\t"
    else
      msg = msg .. tostring(v) .. "\t"
    end
  end
  print(msg)
end

function LoopError(...)
  local errorMsg = table.unpack({...})
  CreateThread(function()
    while true do
      print("^1[ERROR]^7", errorMsg)
      Wait(2000)
    end
  end)
end

function table.includes(tbl, value)
  if not tbl then
    return false
  end
  for _, v in pairs(tbl) do
    if v == value then
      return true
    end
  end
  return false
end

function table.find(tbl, predicate)
  if not tbl then
    return false, false
  end
  for key, value in pairs(tbl) do
    if type(predicate) == "function" then
      if predicate(value, key) then
        return value, key
      end
    elseif value == predicate then
      return value, key
    end
  end
  return false, false
end

function string.split(str, separator)
  local sep = separator or ":"
  local result = {}
  local pattern = string.format("([^%s]+)", sep)
  str:gsub(pattern, function(match)
    result[#result + 1] = match
  end)
  return result
end

function table.filter(tbl, predicate)
  local result = {}
  for key, value in pairs(tbl) do
    if predicate(value, key, tbl) then
      result[#result + 1] = value
    end
  end
  return result
end

function table.map(tbl, callback)
  local result = {}
  for key, value in pairs(tbl) do
    result[#result + 1] = callback(value, key, tbl)
  end
  return result
end

function table.slice(tbl, startIdx, endIdx, step)
  local result = {}
  local s = startIdx or 1
  local e = endIdx or #tbl
  local st = step or 1
  for i = s, e, st do
    result[#result + 1] = tbl[i]
  end
  return result
end

function DependencyCheck(resources)
  for name, value in pairs(resources) do
    local state = GetResourceState(name)
    if state:find("started") ~= nil then
      return value
    end
  end
  return false
end

function FormatTime(seconds)
  if seconds < 60 then
    return seconds .. " seconds"
  else
    if seconds < 3600 then
      return math.floor(seconds / 60) .. " min"
    else
      if seconds < 86400 then
        return math.floor(seconds / 3600) .. " hours"
      else
        return math.floor(seconds / 86400) .. " days"
      end
    end
  end
end

function GetCoordsWithOffset(origin, offset)
  local offsetX = offset.x
  local offsetY = offset.y
  local newX = origin.x
  newX = newX + offsetX * math.cos(math.rad(origin.w + 90))
  newX = newX - offsetY * math.sin(math.rad(origin.w + 90))
  local newY = origin.y
  newY = newY + offsetX * math.sin(math.rad(origin.w + 90))
  newY = newY + offsetY * math.cos(math.rad(origin.w + 90))
  local newZ = origin.z + offset.z
  return vec4(newX, newY, newZ, origin.w)
end

function RotationToDirection(rotation)
  local radians = {}
  radians.x = math.pi / 180 * rotation.x
  radians.y = math.pi / 180 * rotation.y
  radians.z = math.pi / 180 * rotation.z
  local direction = {}
  direction.x = -math.sin(radians.z) * math.abs(math.cos(radians.x))
  direction.y = math.cos(radians.z) * math.abs(math.cos(radians.x))
  direction.z = math.sin(radians.x)
  return direction
end

function RayCastGamePlayCamera(distance)
  local camRot = GetGameplayCamRot()
  local camCoord = GetGameplayCamCoord()
  local direction = RotationToDirection(camRot)
  local destination = {}
  destination.x = camCoord.x + direction.x * distance
  destination.y = camCoord.y + direction.y * distance
  destination.z = camCoord.z + direction.z * distance
  local coords = vec3(destination.x, destination.y, destination.z)
  return coords, camRot
end

function GetClosestPlayer(coords, maxDistance)
  local closestPlayer = nil
  local closestDist = maxDistance
  for _, playerId in pairs(GetActivePlayers()) do
    local playerCoords = GetEntityCoords(GetPlayerPed(playerId))
    Debug("GetClosestPlayer", playerCoords, coords)
    local dist = #(playerCoords - coords)
    if closestDist > dist then
      closestDist = dist
      closestPlayer = playerId
    end
  end
  return closestPlayer
end

function GetRelativePosition(entity, position, distance)
  local entityCoords = GetEntityCoords(entity)
  local forward = GetEntityForwardVector(entity)
  local up = vector3(0.0, 0.0, 1.0)
  local right = vector3(-forward.y, forward.x, 0.0)
  local minDim, maxDim = GetModelDimensions(GetEntityModel(entity))
  local height = (maxDim.z - minDim.z) * 2
  local width = (maxDim.x - minDim.x) * 2
  local length = maxDim.y - minDim.y

  local offsets = {}
  offsets["front-left"] = forward * distance - right * (width * 0.5 + distance * 0.5)
  offsets["front-middle"] = forward * distance
  offsets["front-right"] = forward * distance + right * (width * 0.5 + distance * 0.5)
  offsets["back-left"] = -forward * distance - right * (width * 0.5 + distance * 0.5)
  offsets["back-middle"] = -forward * distance
  offsets["back-right"] = -forward * distance + right * (width * 0.5 + distance * 0.5)
  offsets.left = -right * (width * 0.5 + distance)
  offsets.right = right * (width * 0.5 + distance)
  offsets["top-left"] = forward * distance - right * (width * 0.5 + distance * 0.5) + up * (height + distance)
  offsets["top-middle"] = up * distance
  offsets["top-right"] = forward * distance + right * (width * 0.5 + distance * 0.5) + up * (height + distance)
  offsets.center = vector3(0.0, 0.0, height)
  offsets["front-left-diagonal"] = forward * distance * 0.7 - right * (width * 0.5 + distance * 0.7)
  offsets["front-right-diagonal"] = forward * distance * 0.7 + right * (width * 0.5 + distance * 0.7)
  offsets["back-left-diagonal"] = -forward * distance * 0.7 - right * (width * 0.5 + distance * 0.7)
  offsets["back-right-diagonal"] = -forward * distance * 0.7 + right * (width * 0.5 + distance * 0.7)

  return entityCoords + offsets[position]
end
