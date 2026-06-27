iplHouses = {}

local function findPlayerIndex(houseName, playerId)
  local houseData = iplHouses[houseName]
  if not houseData then
    return false
  end

  for index, id in pairs(iplHouses[houseName].players) do
    if id == playerId then
      return index
    end
  end

  return false
end

local function leaveIplHouse(houseName)
  local src = source
  local playerIndex = findPlayerIndex(houseName, src)
  if not playerIndex then
    return
  end

  table.remove(iplHouses[houseName].players, playerIndex)
  TriggerClientEvent("qb-houses:SetIplData", -1, iplHouses)
end

RegisterNetEvent("qb-houses:enterIplHouse", function(houseName)
  local src = source

  local result = MySQL.Sync.fetchAll("select * from player_houses where house = ? limit 1", { houseName })
  local row = result[1]
  if not row then
    return
  end

  local ownerId = row.citizenid

  if not iplHouses[houseName] then
    iplHouses[houseName] = {
      houseOwner = ownerId,
      players = {},
    }
  end

  table.insert(iplHouses[houseName].players, src)
  TriggerClientEvent("qb-houses:SetIplData", -1, iplHouses)
end)

RegisterNetEvent("qb-houses:UpdateIplTheme", function(theme, houseName)
  local iplData = Config.Houses[houseName].ipl
  iplData.theme = theme

  MySQL.Sync.execute("UPDATE houselocations SET ipl = ? WHERE name = ?", {
    json.encode(iplData),
    houseName,
  })

  TriggerClientEvent("housing:updateHouseData", -1, houseName, "ipl", iplData)

  if not iplHouses[houseName] then
    return
  end

  for _, playerId in pairs(iplHouses[houseName].players) do
    TriggerClientEvent("qb-houses:UpdateTheme", playerId, theme, houseName)
  end
end)

RegisterNetEvent("qb-houses:leaveIplHouse", leaveIplHouse)

AddEventHandler("playerDropped", function(reason)
  local src = source

  if not next(iplHouses) then
    return
  end

  for houseName, houseData in pairs(iplHouses) do
    for index, playerId in pairs(houseData.players) do
      if playerId == src then
        table.remove(houseData.players, index)
      end
    end
  end

  TriggerClientEvent("qb-houses:SetIplData", -1, iplHouses)
end)
