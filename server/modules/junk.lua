local junkTimers = {}
local housePlayers = {}

local function getRandomJunkModel()
  local objects = Config.JunkObjects
  local index = math.random(1, #objects)
  return objects[index]
end

local function hasPlayersInHouse(houseName)
  local players = housePlayers[houseName]
  if players then
    return #players > 0
  end
  return players
end

local function insertJunkRecord(houseName)
  local model = getRandomJunkModel()
  local insertId = MySQL.insert.await(
    "INSERT INTO house_junk (house, model, coords) VALUES (?, ?, NULL)",
    { houseName, model }
  )
  if insertId then
    return insertId
  end
  return nil
end

local function deleteJunkRecord(junkId)
  local affectedRows = MySQL.update.await(
    "DELETE FROM house_junk WHERE id = ?",
    { junkId }
  )
  return affectedRows > 0
end

local function updateJunkCoords(junkId, coords)
  if not coords or not coords.x or not coords.y or not coords.z then
    return false
  end

  local coordsJson = json.encode({ x = coords.x, y = coords.y, z = coords.z })
  local affectedRows = MySQL.update.await(
    "UPDATE house_junk SET coords = ? WHERE id = ?",
    { coordsJson, junkId }
  )
  return affectedRows > 0
end

local function getJunkForHouse(houseName)
  local rows = MySQL.query.await(
    "SELECT * FROM house_junk WHERE house = ?",
    { houseName }
  )

  local junkItems = {}
  for _, row in ipairs(rows or {}) do
    local coords = nil
    if row.coords then
      coords = json.decode(row.coords)
      if not coords then
        coords = nil
      end
    end

    table.insert(junkItems, {
      id = row.id,
      house = row.house,
      model = row.model,
      coords = coords,
      created_at = row.created_at,
    })
  end

  return junkItems
end

local function getJunkCount(houseName)
  local count = MySQL.scalar.await(
    "SELECT COUNT(*) FROM house_junk WHERE house = ?",
    { houseName }
  )
  return count or 0
end

local function spawnJunkForHouse(houseName)
  if not Config.Cleaning then
    return
  end

  local houseConfig = Config.Houses[houseName]
  if not houseConfig then
    Debug("spawnJunkForHouse - No house data for:", houseName)
    return
  end

  local maxJunk = Config.MaxJunkPerHouse or 10
  local currentCount = getJunkCount(houseName)

  if maxJunk <= currentCount then
    Debug("spawnJunkForHouse - Max junk reached for:", houseName, currentCount, "/", maxJunk)
    return
  end

  local insertId = insertJunkRecord(houseName)
  if insertId then
    local model = getRandomJunkModel()
    local junkData = {
      id = insertId,
      house = houseName,
      model = model,
      coords = nil,
    }

    if hasPlayersInHouse(houseName) then
      for _, playerId in ipairs(housePlayers[houseName]) do
        TriggerClientEvent("housing:junk:spawn", playerId, junkData)
      end
    end
  end
end

local function startJunkTimer(houseName)
  if junkTimers[houseName] then
    return
  end

  if not Config.Cleaning then
    return
  end

  local delay = Config.JunkObjectTime
  junkTimers[houseName] = SetTimeout(delay, function()
    if not junkTimers[houseName] then
      return
    end
    junkTimers[houseName] = nil
    spawnJunkForHouse(houseName)
    startJunkTimer(houseName)
  end)
end

local function stopJunkTimer(houseName)
  if junkTimers[houseName] then
    junkTimers[houseName] = nil
  end
end

local function playerEnteredHouse(playerId, houseName)
  if not housePlayers[houseName] then
    housePlayers[houseName] = {}
  end

  for _, existingPlayer in ipairs(housePlayers[houseName]) do
    if existingPlayer == playerId then
      return
    end
  end

  table.insert(housePlayers[houseName], playerId)

  if #housePlayers[houseName] == 1 then
    startJunkTimer(houseName)
  end

  Debug("Player", playerId, "entered house:", houseName, "total players:", #housePlayers[houseName])
end

local function playerLeftHouse(playerId, houseName)
  if not housePlayers[houseName] then
    return
  end

  for i, existingPlayer in ipairs(housePlayers[houseName]) do
    if existingPlayer == playerId then
      table.remove(housePlayers[houseName], i)
      break
    end
  end

  if #housePlayers[houseName] == 0 then
    stopJunkTimer(houseName)
    housePlayers[houseName] = nil
  end

  local remainingCount
  if housePlayers[houseName] and #housePlayers[houseName] then
    remainingCount = #housePlayers[houseName]
  else
    remainingCount = 0
  end
  Debug("Player", playerId, "left house:", houseName, "remaining:", remainingCount)
end

lib.callback.register("housing:junk:getForHouse", function(source, houseName)
  return getJunkForHouse(houseName)
end)

lib.callback.register("housing:junk:updateCoords", function(source, junkId, coords)
  if not junkId or not coords then
    return false
  end

  if type(coords) == "table" and coords.x and coords.y and coords.z then
    goto valid
  end

  Debug("housing:junk:updateCoords - Invalid coords structure:", coords)
  return false

  ::valid::
  return updateJunkCoords(junkId, coords)
end)

lib.callback.register("housing:junk:remove", function(source, junkId, houseName)
  if not junkId then
    return false
  end

  local success = deleteJunkRecord(junkId)

  if success then
    local players = housePlayers[houseName]
    if players then
      for _, playerId in ipairs(housePlayers[houseName]) do
        if playerId ~= source then
          TriggerClientEvent("housing:junk:remove", playerId, junkId)
        end
      end
    end

    SendLog(DiscordWebhook, {
      title = "Housing - Junk",
      description = "Player cleaned junk",
      fields = {
        { name = "Player", value = GetPlayerName(source), inline = true },
        { name = "House", value = houseName or "Unknown", inline = true },
        { name = "Junk ID", value = tostring(junkId), inline = true },
      },
      color = WebhookColor,
    })
  end

  return success
end)

AddEventHandler("housing:setInside", function(houseName, isInside)
  local src = source

  if not Config.Cleaning then
    return
  end

  if type(houseName) == "table" then
    houseName = houseName.house or houseName.name
  end

  if not houseName then
    return
  end

  if isInside then
    playerEnteredHouse(src, houseName)
  else
    playerLeftHouse(src, houseName)
  end
end)

AddEventHandler("playerDropped", function(reason)
  local src = source

  for houseName, players in pairs(housePlayers) do
    for i, playerId in ipairs(players) do
      if playerId == src then
        table.remove(players, i)
        if #players == 0 then
          stopJunkTimer(houseName)
          housePlayers[houseName] = nil
        end
        break
      end
    end
  end
end)

if Config.Cleaning then
  CreateThread(function()
    while true do
      local deleted = MySQL.update.await(
        "DELETE FROM house_junk WHERE created_at < DATE_SUB(NOW(), INTERVAL 7 DAY)"
      )
      if deleted and deleted > 0 then
        Debug("Cleaned up", deleted, "old junk entries")
      end
      Wait(86400000)
    end
  end)
end
