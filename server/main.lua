-- qs-housing server/main.lua (deobfuscated)

-- Initialize furniture data into Config
Config.Furniture = db.getMergedFurnitureData()

-- Initialize furniture shops
function InitFurnitureShops()
  local shopData = db.getFurnitureShops()
  Config.FurnitureShops = db.expandFurnitureShopCategories(shopData)
  Debug("InitFurnitureShops", "Loaded", #Config.FurnitureShops, "furniture shops")
end

InitFurnitureShops()

-- Global state variables
local housesInitialized = false
local houseObjects = {}
HouseGarages = {}
local rentableHousesMap = {}
local purchasableHousesMap = {}
PlayerInHouseZones = {}
HouseOwnerIdentifierList = {}
OfficialHouseOwnerList = {}
HouseOwnerCitizenidList = {}
HouseKeyholdersList = {}
local securityCamState = {}

-- Helper: coerce a value to boolean with a default
local function coerceToBoolean(value, default)
  if nil == value then
    return default
  end
  if "boolean" == type(value) then
    return value
  end
  if "number" == type(value) then
    return 1 == value
  end
  if "string" == type(value) then
    local lower = value:lower()
    if "1" == lower or "true" == lower then
      return true
    end
    if "0" == lower or "false" == lower then
      return false
    end
  end
  return default
end


-- Ensure DB columns exist
local function ensureAssistantZoneMessagesColumn()
  local result = MySQL.query.await("SHOW COLUMNS FROM houselocations LIKE ?", { "assistantZoneMessagesEnabled" })
  if result and result[1] then
    return
  end
  MySQL.query.await("ALTER TABLE houselocations ADD COLUMN assistantZoneMessagesEnabled TINYINT(1) NOT NULL DEFAULT 1")
  Debug("ensureAssistantZoneMessagesColumn", "assistantZoneMessagesEnabled column created")
end

local function ensureRentNextChargeAtColumn()
  local result = MySQL.query.await("SHOW COLUMNS FROM player_houses LIKE ?", { "rentNextChargeAt" })
  if result and result[1] then
    return
  end
  MySQL.query.await("ALTER TABLE player_houses ADD COLUMN rentNextChargeAt DATETIME NULL DEFAULT NULL")
  Debug("ensureRentNextChargeAtColumn", "rentNextChargeAt column created")
end

-- Valid payment methods lookup
local validPaymentMethods = {
  money = true,
  bank = true,
  cash = true,
  black_money = true,
}


function getHousePaymentMethod(houseName)
  local houseData = Config.Houses[houseName]
  local method
  if houseData and houseData.paymentMethod then
    method = houseData.paymentMethod
  else
    method = Config.MoneyType
    if not method then
      method = "bank"
    end
  end
  if "string" ~= type(method) or "" == method then
    method = Config.MoneyType or method
    if not Config.MoneyType then
      method = "bank"
    end
  end
  if not validPaymentMethods[method] then
    Error("getHousePaymentMethod", "Invalid payment method, using fallback", houseName, method)
    method = Config.MoneyType or method
    if not Config.MoneyType then
      method = "bank"
    end
  end
  return method
end

function getHouseMoney(playerSource, houseName)
  return GetAccountMoney(playerSource, getHousePaymentMethod(houseName))
end

function removeHouseMoney(playerSource, houseName, amount)
  RemoveAccountMoney(playerSource, getHousePaymentMethod(houseName), amount)
end

function removeHouseMoneyFromIdentifier(identifier, houseName, amount, useBank)
  return RemoveMoneyFromAccount(identifier, amount, useBank, getHousePaymentMethod(houseName))
end


-- Check if rent scheduler is in monthly UTC anniversary mode
local function isMonthlyUTCAnniversaryMode()
  local scheduler = Config.RentScheduler
  if scheduler and false ~= scheduler.Enabled then
    return scheduler.Mode == "monthly_utc_anniversary"
  end
  return false
end

-- Backfill missing rent due dates for anniversary mode
local function backfillRentNextChargeAt()
  if not isMonthlyUTCAnniversaryMode() then
    return
  end
  MySQL.update.await([[
		UPDATE player_houses ph
		LEFT JOIN (
			SELECT house, MAX(`date`) AS last_rent_date
			FROM house_rents
			GROUP BY house
		) hr ON ph.house = hr.house
		SET ph.rentNextChargeAt = DATE_ADD(COALESCE(hr.last_rent_date, UTC_TIMESTAMP()), INTERVAL 1 MONTH)
		WHERE ph.rented = 1 AND ph.rentNextChargeAt IS NULL
	]])
  Debug("backfillRentNextChargeAt", "Backfilled missing rent due dates")
end

function Notification(playerSource, message, notifType)
  TriggerClientEvent("housing:notification", playerSource, message, notifType)
end


-- Player enters house zone tracking
RegisterNetEvent("housing:enterHouseZone", function(houseName)
  local src = source
  if not PlayerInHouseZones[houseName] then
    PlayerInHouseZones[houseName] = {}
  end
  PlayerInHouseZones[houseName][src] = true
  Debug("housing:enterHouseZone", "Player entered house zone", src, houseName)
end)

-- Player exits house zone tracking
RegisterNetEvent("housing:exitHouseZone", function(houseName)
  local src = source
  local zonePlayers = PlayerInHouseZones[houseName]
  if zonePlayers then
    zonePlayers[src] = nil
    if not next(PlayerInHouseZones[houseName]) then
      PlayerInHouseZones[houseName] = nil
    end
  end
  Debug("housing:exitHouseZone", "Player exited house zone", src, houseName)
end)


-- House alarm sound event
RegisterNetEvent("housing:server:houseAlarmSound", function(houseName)
  if "string" ~= type(houseName) then
    return
  end
  local houseData = Config.Houses[houseName]
  if not houseData or not houseData.coords or not houseData.coords.enter then
    return
  end
  if not table.includes(houseData.upgrades or {}, "alarm") then
    return
  end
  local enterCoords = houseData.coords.enter
  local housePos = vector3(enterCoords.x, enterCoords.y, enterCoords.z)
  local duration = Config.HouseAlarmDurationMs or 35000
  local hearRange = Config.HouseAlarmHearRange or 80.0

  for _, playerId in ipairs(GetPlayers()) do
    local pid = tonumber(playerId)
    if pid then
      local ped = GetPlayerPed(pid)
      if ped and 0 ~= ped then
        local pedCoords = GetEntityCoords(ped)
        local dist = #(pedCoords - housePos)
        if hearRange >= dist then
          TriggerClientEvent("housing:client:houseAlarmSound", pid, housePos, duration, hearRange)
        end
      end
    end
  end
end)


function BroadcastToPlayersInHouseZone(houseName, eventName, ...)
  local zonePlayers = PlayerInHouseZones[houseName]
  if not zonePlayers then
    return
  end
  for playerId in pairs(zonePlayers) do
    TriggerClientEvent(eventName, playerId, ...)
  end
end

-- Normalize house data (polyzone, mlo, shell coords)
local function normalizeHouseData(houseData)
  if not houseData.coords.PolyZone.thickness then
    houseData.coords.PolyZone.thickness = 600.0
  end
  if houseData.coords.PolyZone.points then
    for idx, point in pairs(houseData.coords.PolyZone.points) do
      houseData.coords.PolyZone.points[idx] = vec3(point.x, point.y, point.z or 0.0)
    end
  end
  -- Flatten MLO entries
  local flatMlo = {}
  if houseData.mlo then
    for _, mloEntry in pairs(houseData.mlo) do
      if not mloEntry.coords then
        for _, coord in pairs(mloEntry) do
          table.insert(flatMlo, coord)
        end
      else
        flatMlo = houseData.mlo
      end
    end
    houseData.mlo = flatMlo
  end
  -- Convert interiorCoords to shellCoords if not present
  if not houseData.coords.shellCoords then
    if houseData.coords.interiorCoords then
      local ic = houseData.coords.interiorCoords
      houseData.coords.shellCoords = vec4(ic.x, ic.y, ic.z, ic.w or ic.h)
    end
  end
  return houseData
end


-- Build a house config object from a database row
local function buildHouseFromRow(index, row)
  local mlo = (row.mlo and json.decode(row.mlo)) or false
  local ipl = (row.ipl and json.decode(row.ipl)) or false
  local garage = (nil ~= row.garage and json.decode(row.garage)) or {}
  local garageShell = (row.garageShell and json.decode(row.garageShell)) or {}
  local hasOwner = 1 == row.has_owner

  if not row.id then
    Error("House id is not set, for this house", row.name, "We set randomly id")
    row.id = math.random(1, 1000000)
  end

  local house = {}
  house.id = row.id
  house.coords = json.decode(row.coords)
  house.owned = hasOwner
  house.price = row.price
  house.defaultPrice = row.defaultPrice
  house.locked = true
  house.address = row.label
  house.tier = row.tier
  house.garage = garage
  house.mlo = mlo
  house.ipl = ipl
  house.creator = row.creator
  house.board = (row.board and json.decode(row.board)) or nil
  house.creatorJob = row.creatorJob
  house.blip = (row.blip and json.decode(row.blip)) or nil
  house.permissions = (row.permissions and json.decode(row.permissions)) or nil
  house.upgrades = (row.upgrades and json.decode(row.upgrades)) or nil
  house.apartmentNumber = row.name:match("apt%-%d+")
  house.apartmentName = row.name:gsub("-apt%-%d+", "")
  house.apartmentCount = (0 ~= row.apartmentCount and row.apartmentCount) or nil
  house.paymentMethod = row.paymentMethod or "cash"
  house.doorbellSound = (row.doorbellSound and "" ~= row.doorbellSound and row.doorbellSound) or nil
  house.assistantZoneMessagesEnabled = coerceToBoolean(row.assistantZoneMessagesEnabled, true)
  house.allowPlantInside = coerceToBoolean(row.allowPlantInside, true)
  house.allowPlantOutside = coerceToBoolean(row.allowPlantOutside, true)
  house.photos = (row.photos and json.decode(row.photos)) or {}
  house.description = row.description or ""
  house.hideFromBrowser = row.hideFromBrowser

  house = normalizeHouseData(house)

  HouseGarages[row.name] = {
    label = row.label,
    takeVehicle = garage,
    shell = garageShell,
  }
  return house
end


-- Initialize all houses from config + database
function InitHouses()
  local houses = {}
  if "table" ~= type(Config.Houses) then
    LoopError("Config.Houses is not a table, please check your config.", Config.Houses)
    return
  end
  -- Validate config houses and set up garages
  for name, data in pairs(Config.Houses) do
    local pz = data.coords and data.coords.PolyZone
    if not pz then
      Error("Please add PolyZone to this house, otherwise you cant use this house.", name)
    elseif not (data.coords and data.coords.exit) then
      Error("Please add exit coords to this house, otherwise you cant use this house.", name)
    elseif not (data.coords and data.coords.shellCoords) then
      Error("Please add shellCoords to this house, otherwise you cant use this house.", name)
    elseif not (data.coords and data.coords.interiorCoords) then
      Error("Please add interiorCoords to this house, otherwise you cant use this house.", name)
    else
      HouseGarages[name] = { label = name, takeVehicle = data.garage, shell = data.garageShell }
      if data then
        data.assistantZoneMessagesEnabled = false ~= data.assistantZoneMessagesEnabled
        data.allowPlantInside = false ~= data.allowPlantInside
        data.allowPlantOutside = false ~= data.allowPlantOutside
        houses[name] = data
      end
    end
  end

  -- Load houses from database
  local query = [[
		SELECT houselocations.*,
		       CASE WHEN player_houses.house IS NOT NULL THEN 1 ELSE 0 END as has_owner
		FROM houselocations
		LEFT JOIN player_houses ON houselocations.name = player_houses.house
	]]
  local dbRows = MySQL.Sync.fetchAll(query)
  if dbRows[1] then
    Debug("InitHouses", "Found houses in database, initializing..")
    for idx, row in pairs(dbRows) do
      houses[row.name] = buildHouseFromRow(idx, row)
    end
  end

  Config.Houses = houses
  TriggerHouseUpdateGarage(HouseGarages)
  Debug("Initialized houses", #dbRows)
end


-- Player connected event - wait for houses to init, then load player
RegisterNetEvent("housing:playerConnected", function()
  local src = source
  while not housesInitialized do
    Error("Waiting for houses to be initialized")
    Wait(100)
  end
  HandleLoadPlayer(src)
  TriggerClientEvent("housing:syncFurnitureData", src, Config.Furniture)
  TriggerClientEvent("housing:syncFurnitureShops", src, Config.FurnitureShops)
  local identifier = GetIdentifier(src)
  -- identifier loaded
  Debug("housing:playerConnected", src)
end)

-- Main initialization thread
CreateThread(function()
  ensureAssistantZoneMessagesColumn()
  ensureRentNextChargeAtColumn()
  backfillRentNextChargeAt()

  -- Load house objects from DB
  local objects = MySQL.Sync.fetchAll("SELECT * FROM house_objects")
  for _, obj in pairs(objects) do
    obj.coords = json.decode(obj.coords)
    if obj.created then
      obj.created = os.time(os.date("*t", math.floor(obj.created / 1000)))
    end
    local construction = obj.construction
    if construction then
      construction = Config.Constructions[obj.construction]
    end
    obj.construction = construction
  end
  houseObjects = objects
  Debug("Initialized house objects", houseObjects)

  InitHouses()
  housesInitialized = true
end)


-- Initialize a single house from DB
function InitHouse(houseName)
  local query = [[
		SELECT houselocations.*,
		       CASE WHEN player_houses.house IS NOT NULL THEN 1 ELSE 0 END as has_owner
		FROM houselocations
		LEFT JOIN player_houses ON houselocations.name = player_houses.house
		WHERE houselocations.name = ?
	]]
  local rows = MySQL.Sync.fetchAll(query, { houseName })
  if not rows[1] then
    return Error("InitHouse", "House not found", houseName)
  end
  Config.Houses[houseName] = buildHouseFromRow(1, rows[1])
  Debug("config.garage", Config.Garage)
  TriggerClientEvent("housing:setHouse", -1, houseName, Config.Houses[houseName])
  TriggerAddHouseGarage(houseName, HouseGarages[houseName])
  Debug("InitHouse", "Initialized house", houseName, Config.Houses[houseName])
end

-- Send house data to a connecting player
function HandleLoadPlayer(playerSource)
  TriggerHouseUpdateGarage(HouseGarages, playerSource)
  TriggerLatentClientEvent("housing:initHouses", playerSource, 10485760, Config.Houses)
  TriggerClientEvent("qb-houses:SetIplData", playerSource, iplHouses)
  Debug("PlayerLoaded", "Player Loaded: ", playerSource)
end

RegisterCommand("houseload", function(source, args, rawCommand)
  HandleLoadPlayer(source)
end)


-- Routing tables
PlayerDefaultRoutings = {}
HouseRoutings = {}

RegisterNetEvent("housing:routePlayerToDefault", function(routeData)
  local src = source
  RouteDefault(src, routeData)
end)

-- Security camera toggle
RegisterNetEvent("housing:toggleInSecurityCam", function(enabled)
  local src = source
  Debug("housing:toggleInSecurityCam", "Toggling security cam", enabled)
  if not enabled then
    securityCamState[src] = nil
    TriggerClientEvent("housing:toggleInSecurityCam", -1, src, "deleted")
    return
  end
  TriggerClientEvent("housing:toggleInSecurityCam", -1, src, true)
end)

-- Get house objects callback
RegisterServerCallback("qb-houses:server:GetHouseObjects", function(source, cb)
  cb(houseObjects)
end)


-- Create a house object (prop/furniture placed outside)
function CreateHouseObject(playerSource, data)
  local identifier = GetIdentifier(playerSource)
  local newObj = {
    creator = identifier,
    coords = data.coords,
    model = data.model,
    house = data.house,
    created = os.time(),
  }
  if Config.Construction then
    newObj.construction = Config.Constructions[data.model]
  end

  local result = MySQL.Sync.fetchAll(
    "INSERT INTO house_objects (creator, coords, model, house, construction) VALUES (?, ?, ?, ?, ?)",
    { identifier, json.encode(data.coords), data.model, data.house or "", (newObj.construction and data.model) or nil }
  )
  newObj.id = result.insertId
  table.insert(houseObjects, newObj)
  TriggerClientEvent("qb-houses:client:createHouseObject", -1, newObj)
  Debug("qb-houses:server:createHouseObject", "Created house object", newObj)
end

-- Delete all house objects for a given house
function DeleteHouseObject(houseName)
  MySQL.query.await("DELETE FROM house_objects WHERE house = ?", { houseName })
  houseObjects = table.filter(houseObjects, function(obj)
    return obj.house ~= houseName
  end)
  TriggerClientEvent("housing:deleteHouseObject", -1, houseName)
  Debug("housing:deleteHouseObject", "Deleted house object", houseName)
  return true
end


-- Decoration mode tracking
local decoModeState = {}

RegisterNetEvent("qb-houses:UpdateDecoMode", function(houseName, upvalData)
  local src = source
  decoModeState[houseName] = { src = src, upval = upvalData }
end)

RegisterServerCallback("qb-houses:GetDecoMode", function(source, cb, houseName)
  local state = decoModeState and decoModeState[houseName]
  if state then
    state = state.upval
  end
  if state then
    return cb(false)
  end
  cb(true)
end)

-- Player dropped handler - cleanup state
AddEventHandler("playerDropped", function(reason)
  local src = source

  -- Clean security cam state
  if securityCamState[src] then
    securityCamState[src] = nil
    TriggerClientEvent("housing:toggleInSecurityCam", -1, src, "deleted")
  end

  -- Clean decoration mode
  for houseName, state in pairs(decoModeState) do
    if state.src == src then
      decoModeState[houseName] = nil
    end
  end

  -- Clean house routings
  for houseName, routing in pairs(HouseRoutings) do
    local players = routing.players
    for idx, pid in pairs(players) do
      if pid == src then
        table.remove(players, idx)
      end
    end
    if 0 == #players then
      HouseRoutings[houseName] = nil
    end
  end

  PlayerDefaultRoutings[src] = nil

  -- Clean player in house zones
  for houseName, zonePlayers in pairs(PlayerInHouseZones) do
    if zonePlayers[src] then
      PlayerInHouseZones[houseName] = table.filter(zonePlayers, function(_, key)
        return key ~= src
      end)
    end
  end
end)


-- Sync MLO door lock state
RegisterNetEvent("qb-houses:SyncDoor", function(houseName, doors, locked)
  local src = source
  if "table" ~= type(doors) then
    doors = { doors }
  end
  Debug("sync doors", locked, "mlo", Config.Houses[houseName].mlo, "doors", doors)

  for _, door in pairs(doors) do
    local foundDoor, foundIdx = table.find(Config.Houses[houseName].mlo, function(mloDoor)
      return mloDoor.tempHandle == door.tempHandle
    end)
    Debug("door", foundDoor, foundIdx)
    if foundDoor then
      Config.Houses[houseName].mlo[foundIdx].locked = locked
    end
  end

  MySQL.Sync.execute("UPDATE houselocations SET mlo = ? WHERE name = ?", { json.encode(Config.Houses[houseName].mlo), houseName })
  TriggerClientEvent("housing:updateHouseData", -1, houseName, "mlo", Config.Houses[houseName].mlo)
end)

-- Toggle all MLO doors
RegisterNetEvent("qb-houses:mloToggleAllDoors", function(houseName, locked)
  local src = source
  for idx, door in pairs(Config.Houses[houseName].mlo) do
    Config.Houses[houseName].mlo[idx].locked = locked
  end
  MySQL.Sync.execute("UPDATE houselocations SET mlo = ? WHERE name = ?", { json.encode(Config.Houses[houseName].mlo), houseName })
  TriggerClientEvent("housing:updateHouseData", -1, houseName, "mlo", Config.Houses[houseName].mlo)
end)


-- Phone: Get player houses
RegisterServerCallback("qb-phone:server:GetPlayerHouses", function(src, cb)
  local identifier = GetIdentifier(src)
  local firstName, lastName = GetCharacterName(src)
  local charInfo = { firstname = firstName, lastname = lastName }

  if not charInfo then
    print("name not exists")
    return cb({})
  end

  local playerHouses = {}
  local rows = MySQL.Sync.fetchAll("SELECT * FROM player_houses WHERE citizenid = ?", { identifier })

  if rows and rows[1] then
    for idx, row in pairs(rows) do
      local garageData = Config.Houses[row.house].garage
      local tier = Config.Houses[row.house].tier
      local houseIdx = #playerHouses + 1
      local entry = {
        name = row.house,
        keyholders = {},
        owner = identifier,
        price = Config.Houses[row.house].price,
        label = Config.Houses[row.house].address,
        tier = tier or "",
        garage = (garageData and garageData.x and garageData) or nil,
      }
      playerHouses[houseIdx] = entry

      if "null" ~= row.keyholders then
        row.keyholders = json.decode(row.keyholders)
        if row.keyholders then
          for _, khId in pairs(row.keyholders) do
            local khFirst, khLast = GetCharacterFromIdentifier(khId)
            local khEntry = {
              charinfo = { firstname = khFirst, lastname = khLast },
              citizenid = khId,
              name = khFirst .. " " .. khLast,
            }
            playerHouses[idx].keyholders[#playerHouses[idx].keyholders + 1] = khEntry
          end
        else
          playerHouses[idx].keyholders = { { charinfo = { firstname = charInfo.firstname, lastname = charInfo.lastname }, citizenid = identifier, name = GetPlayerName(src) } }
        end
      else
        playerHouses[idx].keyholders = { { charinfo = { firstname = charInfo.firstname, lastname = charInfo.lastname }, citizenid = identifier, name = GetPlayerName(src) } }
      end
    end
    SetTimeout(100, function()
      cb(playerHouses)
    end)
  else
    cb({})
  end
end)


-- Phone: Get player SQL name
RegisterServerCallback("qb-phone:GetPlayerSqlName", function(source, cb, targetSource)
  local firstName, lastName = GetCharacterName(targetSource)
  return cb({ firstname = firstName, lastname = lastName })
end)

-- Phone: Get house keys
RegisterServerCallback("qb-phone:server:GetHouseKeys", function(src, cb)
  local identifier = GetIdentifier(src)
  local houseKeys = {}
  local allHouses = MySQL.Sync.fetchAll("SELECT * FROM player_houses", {})

  for _, row in pairs(allHouses) do
    if "null" ~= row.keyholders then
      row.keyholders = json.decode(row.keyholders)
      for _, khId in pairs(row.keyholders) do
        if khId == identifier then
          if row.citizenid ~= identifier then
            houseKeys[#houseKeys + 1] = { HouseData = Config.Houses[row.house] }
          end
        end
      end
    end
    if row.citizenid == identifier then
      houseKeys[#houseKeys + 1] = { HouseData = Config.Houses[row.house] }
    end
  end
  cb(houseKeys)
end)

-- Buy decoration object callback
RegisterServerCallback("qb-houses:buyDecorationObject", function(src, cb, price)
  local money = GetAccountMoney(src, Config.MoneyType)
  if price <= money then
    RemoveAccountMoney(src, Config.MoneyType, price)
    SendLog(DiscordWebhook, {
      title = "Housing",
      description = "Player bought a decoration object",
      fields = {
        { name = "Player", value = GetPlayerName(src), inline = true },
        { name = "Price", value = price, inline = true },
      },
      color = WebhookColor,
    })
    cb(true)
  else
    cb(false)
  end
end)


-- View house (calculate fees and display)
RegisterServerEvent("qb-houses:server:viewHouse")
AddEventHandler("qb-houses:server:viewHouse", function(houseName, isRent)
  local src = source
  local firstName, lastName = GetCharacterName(src)
  local price = Config.Houses[houseName].price

  if isRent then
    local rentData = MySQL.Sync.fetchAll("SELECT rentPrice FROM `player_houses` WHERE `house` = ?", { houseName })
    if rentData[1] then
      if rentData[1].rentPrice then
        price = rentData[1].rentPrice
      end
    else
      print("no rent price")
      return
    end
  end

  price = tonumber(price)
  local brokerFee = Config.BrokerFee(price)
  local bankFee = Config.BankFee(price)
  local taxes = Config.Taxes(price)

  if Config.UseMathCeilOnFees then
    brokerFee = math.ceil(brokerFee)
    bankFee = math.ceil(bankFee)
    taxes = math.ceil(taxes)
    price = math.ceil(price)
  end

  TriggerClientEvent("qb-houses:client:viewHouse", src, price, brokerFee, bankFee, taxes, firstName, lastName, isRent)
end)


-- Count how many houses an identifier owns
local function getOwnedHouseCount(identifier)
  local result = MySQL.Sync.fetchAll("SELECT COUNT(*) as count FROM player_houses WHERE owner = ?", { identifier })
  return result[1].count
end

-- Buy a whole apartment complex
function BuyWholeApartment(playerSource, houseName, rentPrice)
  local identifier = GetIdentifier(playerSource)
  local apartmentBaseName = houseName:gsub("-apt%-%d+", "")
  local queries = {}

  if not Config.CreatedRentableHousesManageable then
    identifier = "realestate"
    Debug("BuyWholeApartment ::: We did set the identifier to realestate because you set CreatedRentableHousesManageable to false")
  end

  for name, data in pairs(Config.Houses) do
    if data.apartmentName == apartmentBaseName then
      if "apt-0" ~= data.apartmentNumber then
        HouseKeyholdersList[name] = { identifier }
        table.insert(queries, {
          query = "INSERT INTO `player_houses` (`house`, `citizenid`, `owner`, `keyholders`, `credit`, `creditPrice`, `rentable`, `rentPrice`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
          parameters = { name, identifier, identifier, json.encode(HouseKeyholdersList[name]), 0, 0, 1, rentPrice },
        })
        HouseOwnerIdentifierList[name] = identifier
        HouseOwnerCitizenidList[name] = identifier
        OfficialHouseOwnerList[name] = identifier
        rentableHousesMap[name] = true
        Config.Houses[name].owned = true
        Debug("Bought apartment", name, "house name", houseName)
      end
    end
  end

  local txResult = MySQL.Sync.transaction(queries)
  if not txResult then
    Error("BuyWholeApartment", "Failed to buy apartment", houseName)
    return
  end
  Debug("Bought whole apartment", apartmentBaseName, "house name", houseName)
  TriggerClientEvent("housing:refreshHouse", playerSource, apartmentBaseName .. "-apt-0")
end


-- Buy a house
function BuyHouse(playerSource, houseName, isCredit, isRentable)
  -- Sanitize house name
  houseName = houseName:gsub("'", ""):gsub("`", ""):gsub('"', "")

  local identifier = GetIdentifier(playerSource)
  local houseData = Config.Houses[houseName]
  local basePrice = houseData.price
  local brokerFee = Config.BrokerFee(basePrice)
  local bankFee = Config.BankFee(basePrice)
  local taxes = Config.Taxes(basePrice)
  local totalPrice = math.ceil(basePrice + brokerFee + bankFee + taxes)
  local creditAmount = totalPrice * Config.CreditEq
  local paymentMethod = getHousePaymentMethod(houseName)
  local playerMoney = GetAccountMoney(playerSource, paymentMethod)
  local ownedCount = getOwnedHouseCount(identifier)

  if not isRentable then
    if ownedCount >= Config.MaxOwnedHouses then
      Notification(playerSource, i18n.t("max_houses_reached", { limit = Config.MaxOwnedHouses }), "error")
      return Error("BuyHouse", "Max houses reached", ownedCount)
    end
    if not isCredit and totalPrice > playerMoney then
      Notification(playerSource, i18n.t("no_money", { price = totalPrice }), "error")
      return Error("BuyHouse", "No money", playerMoney)
    end
    if isCredit and creditAmount > playerMoney then
      Notification(playerSource, i18n.t("no_money", { price = creditAmount }), "error")
      return Error("BuyHouse", "No credit", playerMoney)
    end
  end

  -- Check house exists in DB
  local houseRows = MySQL.Sync.fetchAll("SELECT * FROM houselocations WHERE name = ?", { houseName })
  if not houseRows[1] then
    Error("BuyHouse", "House not found", houseName)
    return
  end

  -- Check if already owned / purchasable
  local ownerRows = MySQL.Sync.fetchAll("SELECT owner, purchasable, sale_furnished FROM `player_houses` WHERE `house` = ?", { houseName })
  local ownerRow = ownerRows[1]
  local isPurchasable = ownerRow and ownerRow.purchasable

  if ownerRow and not isPurchasable then
    Notification(playerSource, i18n.t("house_already_owned") or "This house is already owned!", "error")
    return Error("BuyHouse", "House already owned and not for sale", houseName)
  end


  -- Handle buying from another player
  if isPurchasable then
    local veto = HouseTransactionVeto.Run({
      action = "buy_from_player",
      buyerSource = playerSource,
      sellerIdentifier = ownerRow.owner,
      house = houseName,
      price = basePrice,
      isCredit = isCredit or false,
      saleFurnished = 1 == ownerRow.sale_furnished,
    })
    if not veto.allowed then
      Notification(playerSource, veto.reason or i18n.t("house_already_owned"), "error")
      return
    end
    -- Pay seller
    AddMoneyToAccount(ownerRow.owner, basePrice, true)
    local sellerSource = GetPlayerFromIdentifier(ownerRow.owner)
    if sellerSource then
      Notification(playerSource, i18n.t("sold_house", { price = basePrice }), "success")
    end
    -- Handle furniture
    if not ownerRow.sale_furnished then
      MySQL.Sync.execute("DELETE FROM house_decorations WHERE house = ?", { houseName })
      ClearHouseDecoration(houseName)
      Debug("BuyHouse", "Deleted decorations for unfurnished sale", houseName)
    else
      Debug("BuyHouse", "Keeping decorations for furnished sale", houseName)
    end
    -- Remove old owner record
    MySQL.Sync.execute("DELETE FROM `player_houses` WHERE `house` = ?", { houseName })
    TriggerClientEvent("qb-houses:requiredLeaveHouse", -1, houseName)
    purchasableHousesMap[houseName] = nil
    if Config.Houses[houseName] then
      Config.Houses[houseName].saleFurnished = nil
    end
  end


  -- Pay creator if first sale
  Debug("BuyHouse creator got money", houseRows[1].creatorGotMoney)
  if not ownerRow and not isRentable then
    if not houseRows[1].creatorGotMoney then
      if "none" == Config.Society then
        if houseData.creator then
          AddMoneyToAccount(houseData.creator, totalPrice, true)
        end
      end
      local creatorJob = Config.Houses[houseName].creatorJob
      if creatorJob then
        AddMoneyToSociety(playerSource, creatorJob, totalPrice * Config.SocietyCommision)
        Debug("qb-houses:server:buyHouse", "Added money to society", creatorJob, totalPrice)
      else
        Debug("qb-houses:server:buyHouse", "No creator job", creatorJob)
      end
    end
  end

  -- If rentable purchase, adjust identifier
  local isRentableFlag = nil
  if isRentable then
    if not Config.CreatedRentableHousesManageable then
      isRentableFlag = true
      identifier = "realestate"
      Debug("We did set the identifier to realestate because you set CreatedRentableHousesManageable to false")
    end
  end

  -- Set keyholders
  HouseKeyholdersList[houseName] = {}
  HouseKeyholdersList[houseName][1] = identifier

  -- Calculate credit remaining
  local creditRemaining = (isCredit and (totalPrice - creditAmount)) or 0


  -- Insert player_houses record
  MySQL.Sync.execute(
    "INSERT INTO `player_houses` (`house`, `citizenid`, `owner`, `keyholders`, `credit`, `creditPrice`, `rentable`, `rentPrice`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
    { houseName, identifier, identifier, json.encode(HouseKeyholdersList[houseName]), creditRemaining, creditAmount, isRentableFlag, totalPrice }
  )
  MySQL.Sync.execute("UPDATE `houselocations` SET `creatorGotMoney` = 1 WHERE `name` = '" .. houseName .. "'")

  -- Update state
  HouseOwnerIdentifierList[houseName] = identifier
  HouseOwnerCitizenidList[houseName] = identifier
  OfficialHouseOwnerList[houseName] = identifier
  if isRentableFlag then
    rentableHousesMap[houseName] = true
  end

  TriggerEvent("bb-garages:server:buyHouseGarage", houseName, identifier, playerSource)
  Debug("Bought a house for $" .. totalPrice .. " House: ", houseName, "Creator", houseData.creator)

  -- Deduct money from buyer
  if not isRentable then
    RemoveAccountMoney(playerSource, paymentMethod, (isCredit and creditAmount) or totalPrice)
    TriggerEvent("housing:handleBuyHouse", playerSource, houseName, totalPrice, isCredit)
  end

  InitHouse(houseName)

  -- Quest progress
  local qsInvState = GetResourceState("qs-inventory")
  if qsInvState:find("started") then
    if Config.EnableQuests then
      local questResult = exports["qs-inventory"]:UpdateQuestProgress(playerSource, "buy_house", 100)
      if questResult then
        Debug("Quest \"buy_house\" progress updated")
      else
        Debug("Failed to update quest \"buy_house\"")
      end
    end
  end


  -- Discord log
  SendLog(DiscordWebhook, {
    title = "Housing",
    description = "Player bought a house",
    fields = {
      { name = "Player", value = GetPlayerName(playerSource), inline = true },
      { name = "House", value = houseName, inline = true },
      { name = "Price", value = totalPrice, inline = true },
    },
    color = WebhookColor,
  })

  -- m-Insurance integration
  if Config.MInsurance then
    exports["m-Insurance"]:GiveHomeInsurance(playerSource, identifier, 1, houseName)
  end
end

-- Server event wrapper for BuyHouse
RegisterServerEvent("qb-houses:server:buyHouse")
AddEventHandler("qb-houses:server:buyHouse", function(houseName, isCredit)
  BuyHouse(source, houseName, isCredit)
end)


-- Rent a house
function HousingRentHouse(playerSource, houseName)
  if not Config.EnableRentable then
    Notification(playerSource, i18n.t("rent.disabled"), "error")
    Debug("qb-houses:rentHouse", "Rentable houses are disabled")
    return false
  end

  local identifier = GetIdentifier(playerSource)
  local rows = MySQL.Sync.fetchAll("SELECT * FROM player_houses WHERE house = ? AND rentable = 1", { houseName })
  if not rows[1] then
    Notification(playerSource, i18n.t("rent.cant_rent"), "error")
    Debug("qb-houses:rentHouse", "Cant rent house", houseName)
    return false
  end

  local rentPrice = rows[1].rentPrice
  local money = getHouseMoney(playerSource, houseName)

  if rentPrice <= money then
    local updateQuery = "UPDATE player_houses SET citizenid = ?, rentable = NULL, rented = 1, keyholders = ?"
    local params = { identifier, json.encode({}) }

    if isMonthlyUTCAnniversaryMode() then
      updateQuery = updateQuery .. ", rentNextChargeAt = DATE_ADD(UTC_TIMESTAMP(), INTERVAL 1 MONTH)"
    end
    updateQuery = updateQuery .. " WHERE id = ?"
    params[#params + 1] = rows[1].id

    MySQL.Sync.execute(updateQuery, params)
    rentableHousesMap[houseName] = nil
    HouseOwnerIdentifierList[houseName] = identifier
    HouseOwnerCitizenidList[houseName] = identifier

    Notification(playerSource, i18n.t("rent.you_rented_house"), "success")
    TriggerClientEvent("housing:refreshHouse", -1, houseName)
    Debug("qb-houses:rentHouse", "Rented house", houseName)

    SendLog(DiscordWebhook, {
      title = "Housing",
      description = "Player rented a house",
      fields = {
        { name = "Player", value = GetPlayerName(playerSource), inline = true },
        { name = "House", value = houseName, inline = true },
        { name = "Price", value = rows[1].rentPrice, inline = true },
      },
      color = WebhookColor,
    })
    return true
  end

  Notification(playerSource, i18n.t("no_money", { price = rows[1].rentPrice }), "error")
  return false
end

RegisterNetEvent("qb-houses:rentHouse", function(houseName)
  HousingRentHouse(source, houseName)
end)


-- Sell house to bank
function HousingSellHouse(playerSource, houseName)
  local identifier = GetIdentifier(playerSource)
  local rows = MySQL.Sync.fetchAll("SELECT * FROM player_houses WHERE house = ? AND owner = ?", { houseName, identifier })
  if not rows[1] then
    Notification(playerSource, i18n.t("cant_sell_house"), "error")
    return false
  end
  if 1 == rows[1].rented then
    Notification(playerSource, i18n.t("cant_sell_rented"), "error")
    return false
  end
  if rows[1].credit then
    if tonumber(rows[1].credit) > 0 then
      Notification(playerSource, i18n.t("house_has_credit"), "error")
      return false
    end
  end

  local veto = HouseTransactionVeto.Run({ action = "sell_bank", source = playerSource, house = houseName })
  if not veto.allowed then
    Notification(playerSource, veto.reason or i18n.t("cant_sell_house"), "error")
    return false
  end

  MySQL.Sync.execute("DELETE FROM player_houses WHERE id = ?", { rows[1].id })
  MySQL.Sync.execute("UPDATE `houselocations` SET `price` = houselocations.defaultPrice WHERE `name` = ?", { houseName })
  Notification(playerSource, i18n.t("house_sold"), "success")

  local defaultPrice = Config.Houses[houseName].defaultPrice
  AddAccountMoney(playerSource, "bank", defaultPrice / 2)

  -- Clear all state
  HouseOwnerCitizenidList[houseName] = nil
  HouseOwnerIdentifierList[houseName] = nil
  OfficialHouseOwnerList[houseName] = nil
  HouseKeyholdersList[houseName] = nil
  rentableHousesMap[houseName] = nil
  purchasableHousesMap[houseName] = nil
  Config.Houses[houseName].price = Config.Houses[houseName].defaultPrice
  Config.Houses[houseName].owned = false

  InitHouse(houseName)
  TriggerClientEvent("qb-houses:requiredLeaveHouse", -1, houseName)

  SendLog(DiscordWebhook, {
    title = "Housing",
    description = "Player sold a house",
    fields = {
      { name = "Player", value = GetPlayerName(playerSource), inline = true },
      { name = "House", value = houseName, inline = true },
      { name = "Price", value = defaultPrice, inline = true },
    },
    color = WebhookColor,
  })
  Debug("qb-houses:sellHouse", "Sold house", houseName)
  return true
end

RegisterNetEvent("qb-houses:sellHouse", function(houseName)
  HousingSellHouse(source, houseName)
end)


-- Check if player is near house entrance
function HousingPlayerNearHouseEntrance(playerSource, houseName, maxDist)
  local ped = GetPlayerPed(playerSource)
  if not ped or 0 == ped then
    return false
  end
  local houseData = Config.Houses[houseName]
  if not houseData or not houseData.coords or not houseData.coords.enter then
    return false
  end
  local enter = houseData.coords.enter
  local ex = enter.x or enter[1]
  local ey = enter.y or enter[2]
  local ez = enter.z or enter[3] or 0.0
  if "number" ~= type(ex) or "number" ~= type(ey) then
    return false
  end
  local pedCoords = GetEntityCoords(ped)
  maxDist = maxDist or 48.0
  local housePos = vector3(ex + 0.0, ey + 0.0, ez + 0.0)
  return maxDist >= #(pedCoords - housePos)
end


-- Sell house to another player (put on market)
RegisterNetEvent("qb-houses:sellHouseToPlayer", function(houseName, salePrice, saleOptions)
  local src = source
  local identifier = GetIdentifier(src)
  local rows = MySQL.Sync.fetchAll("SELECT * FROM player_houses WHERE house = ? AND owner = ?", { houseName, identifier })
  if not rows[1] then
    return Notification(src, i18n.t("cant_sell_house"), "error")
  end
  if 1 == rows[1].rented then
    return Notification(src, i18n.t("cant_sell_rented"), "error")
  end
  if rows[1].credit and tonumber(rows[1].credit) > 0 then
    return Notification(src, i18n.t("house_has_credit"), "error")
  end
  if rentableHousesMap[houseName] then
    return Notification(src, i18n.t("cant_sell_rentable"), "error")
  end

  local veto = HouseTransactionVeto.Run({
    action = "list_player_sale",
    source = src,
    house = houseName,
    price = salePrice,
    saleOptions = saleOptions or {},
  })
  if not veto.allowed then
    return Notification(src, veto.reason or i18n.t("cant_sell_house"), "error")
  end

  if not saleOptions then saleOptions = {} end
  local photosJson = json.encode(saleOptions.photos or {})
  local description = saleOptions.description or ""
  local furnished = (false ~= saleOptions.furnished) and 1 or 0
  local hidden = saleOptions.hideFromBrowser and 1 or 0

  MySQL.Sync.execute("UPDATE player_houses SET purchasable = 1, sale_furnished = ? WHERE house = ?", { furnished, houseName })
  MySQL.Sync.execute([[
		UPDATE houselocations SET
			price = ?,
			photos = ?,
			description = ?,
			hideFromBrowser = ?
		WHERE name = ?
	]], { salePrice, photosJson, description, hidden, houseName })

  Notification(src, i18n.t("house_is_sale_now"), "info")
  purchasableHousesMap[houseName] = true
  Config.Houses[houseName].price = salePrice
  Config.Houses[houseName].photos = saleOptions.photos or {}
  Config.Houses[houseName].description = description
  Config.Houses[houseName].hideFromBrowser = 1 == hidden
  Config.Houses[houseName].saleFurnished = 1 == furnished

  TriggerClientEvent("housing:updateHouseData", -1, houseName, "price", salePrice)
  TriggerClientEvent("housing:updateHouseData", -1, houseName, "photos", Config.Houses[houseName].photos)
  TriggerClientEvent("housing:updateHouseData", -1, houseName, "description", Config.Houses[houseName].description)
  TriggerClientEvent("housing:updateHouseData", -1, houseName, "hideFromBrowser", Config.Houses[houseName].hideFromBrowser)
  TriggerClientEvent("housing:updateHouseData", -1, houseName, "saleFurnished", Config.Houses[houseName].saleFurnished)
  TriggerClientEvent("housing:refreshHouse", -1, houseName)

  SendLog(DiscordWebhook, {
    title = "Housing",
    description = "Player put a house for sale",
    fields = {
      { name = "Player", value = GetPlayerName(src), inline = true },
      { name = "House", value = houseName, inline = true },
      { name = "Price", value = salePrice, inline = true },
      { name = "Furnished", value = tostring(1 == furnished), inline = true },
      { name = "Hidden", value = tostring(1 == hidden), inline = true },
    },
    color = WebhookColor,
  })
end)


-- Cancel house sale
RegisterNetEvent("qb-houses:cancelSellHouse", function(houseName)
  local src = source
  local identifier = GetIdentifier(src)
  Debug("qb-houses:cancelSellHouse", "Canceling sale", houseName)
  local rows = MySQL.Sync.fetchAll("SELECT * FROM player_houses WHERE house = ? AND owner = ?", { houseName, identifier })
  if not rows[1] then
    return Notification(src, i18n.t("you_are_not_owner"), "error")
  end
  if 1 ~= rows[1].purchasable then
    return Notification(src, i18n.t("house_is_not_for_sale"), "error")
  end
  MySQL.Sync.execute("UPDATE player_houses SET purchasable = NULL, sale_furnished = NULL WHERE house = ?", { houseName })
  MySQL.Sync.execute("UPDATE houselocations SET price = defaultPrice WHERE name = ?", { houseName })
  Notification(src, i18n.t("house_no_longer_for_sale"), "info")
  purchasableHousesMap[houseName] = nil
  Config.Houses[houseName].price = Config.Houses[houseName].defaultPrice
  Config.Houses[houseName].photos = {}
  Config.Houses[houseName].description = ""
  Config.Houses[houseName].hideFromBrowser = false
  Config.Houses[houseName].saleFurnished = nil
  TriggerClientEvent("housing:updateHouseData", -1, houseName, "price", Config.Houses[houseName].defaultPrice)
  TriggerClientEvent("qb-houses:requiredLeaveHouse", -1, houseName)
  TriggerClientEvent("housing:refreshHouse", -1, houseName)
  SendLog(DiscordWebhook, {
    title = "Housing",
    description = "Player canceled a house sale",
    fields = {
      { name = "Player", value = GetPlayerName(src), inline = true },
      { name = "House", value = houseName, inline = true },
    },
    color = WebhookColor,
  })
end)


-- Transfer house to another player
RegisterNetEvent("housing:transferHouse", function(targetSource, houseName)
  local src = source
  local srcIdentifier = GetIdentifier(src)
  local targetIdentifier = GetIdentifier(targetSource)
  if not targetIdentifier then
    return Notification(src, i18n.t("player_not_found"), "error")
  end
  local rows = MySQL.Sync.fetchAll("SELECT * FROM player_houses WHERE house = ? AND owner = ?", { houseName, srcIdentifier })
  if not rows[1] then
    return Notification(src, i18n.t("you_are_not_owner"), "error")
  end
  if 1 == rows[1].rented then
    return Notification(src, i18n.t("cant_transfer_rented"), "error")
  end
  if rows[1].credit and tonumber(rows[1].credit) > 0 then
    return Notification(src, i18n.t("house_has_credit"), "error")
  end
  if 1 == rows[1].purchasable then
    return Notification(src, i18n.t("cant_transfer_for_sale"), "error")
  end
  if 1 == rows[1].rentable then
    return Notification(src, i18n.t("cant_transfer_for_rent"), "error")
  end

  local veto = HouseTransactionVeto.Run({
    action = "transfer",
    fromSource = src,
    toSource = targetSource,
    toIdentifier = targetIdentifier,
    house = houseName,
  })
  if not veto.allowed then
    return Notification(src, veto.reason or i18n.t("cant_transfer_rented"), "error")
  end

  MySQL.Sync.execute("UPDATE player_houses SET owner = ?, citizenid = ? WHERE house = ?", { targetIdentifier, targetIdentifier, houseName })
  HouseOwnerIdentifierList[houseName] = targetIdentifier
  HouseOwnerCitizenidList[houseName] = targetIdentifier
  OfficialHouseOwnerList[houseName] = targetIdentifier
  HouseKeyholdersList[houseName] = nil

  local targetFirst, targetLast = GetCharacterName(targetSource)
  local targetName
  if targetFirst and targetLast then
    targetName = targetFirst .. " " .. targetLast
  else
    targetName = GetPlayerName(targetSource)
  end

  Notification(src, i18n.t("house_transferred", { player = targetName }), "success")
  Notification(targetSource, i18n.t("house_received", { house = Config.Houses[houseName].address or houseName }), "success")
  TriggerClientEvent("qb-houses:requiredLeaveHouse", src, houseName)
  TriggerClientEvent("housing:refreshHouse", -1, houseName)

  SendLog(DiscordWebhook, {
    title = "Housing",
    description = "Player transferred a house to another player",
    fields = {
      { name = "From", value = GetPlayerName(src), inline = true },
      { name = "To", value = targetName, inline = true },
      { name = "House", value = houseName, inline = true },
    },
    color = WebhookColor,
  })
end)


-- Delete apartment (all units)
local function deleteApartmentHouses(houseName)
  local baseName = houseName:gsub("-apt%-%d+", "")
  local queries = {}
  local deletedNames = {}

  for name, data in pairs(Config.Houses) do
    if data.apartmentName == baseName then
      table.insert(queries, { query = "DELETE FROM player_houses WHERE house = ?", parameters = { name } })
      table.insert(queries, { query = "DELETE FROM `houselocations` WHERE `name` = ?", parameters = { name } })
      table.insert(queries, { query = "DELETE FROM house_decorations WHERE house = ?", parameters = { name } })
      ClearHouseDecoration(name)
      table.insert(deletedNames, name)
      HouseOwnerCitizenidList[name] = nil
      HouseOwnerIdentifierList[name] = nil
      OfficialHouseOwnerList[name] = nil
      HouseKeyholdersList[name] = nil
      rentableHousesMap[name] = nil
      purchasableHousesMap[name] = nil
      Config.Houses[name] = nil
      Debug("Delete Apartment House", "Deleted house", name)
    end
  end

  local txResult = MySQL.Sync.transaction(queries)
  if not txResult then
    Debug("DeleteHouse", "Failed to delete apartment houses", houseName)
    return false
  end

  for i = 1, #deletedNames do
    HousingBatteryBridge_Unregister(deletedNames[i])
  end
  TriggerClientEvent("housing:setHouse", -1, deletedNames, nil)
  TriggerClientEvent("qb-houses:requiredLeaveHouse", -1, deletedNames)
  return true
end


-- Delete a single house
function DeleteHouse(houseName)
  local houseData = Config.Houses[houseName]
  if not houseData then
    Error("DeleteHouse", "House not found", houseName)
    return false
  end
  if houseData.apartmentNumber then
    return deleteApartmentHouses(houseName)
  end

  DeleteHouseObject(houseName)
  local rows = MySQL.Sync.fetchAll("SELECT * FROM houselocations WHERE name = ?", { houseName })
  if not rows[1] then
    return false
  end
  MySQL.Sync.execute("DELETE FROM player_houses WHERE house = ?", { houseName })
  MySQL.Sync.execute("DELETE FROM `houselocations` WHERE `name` = ?", { houseName })
  db.deleteAllObjects(houseName)
  TriggerClientEvent("qb-houses:requiredLeaveHouse", -1, houseName)
  HouseOwnerCitizenidList[houseName] = nil
  HouseOwnerIdentifierList[houseName] = nil
  OfficialHouseOwnerList[houseName] = nil
  HouseKeyholdersList[houseName] = nil
  rentableHousesMap[houseName] = nil
  purchasableHousesMap[houseName] = nil
  HousingBatteryBridge_Unregister(houseName)
  Config.Houses[houseName] = nil
  TriggerHouseRemoveGarage(houseName)
  TriggerClientEvent("housing:setHouse", -1, houseName, nil)
  Debug("DeleteHouse", "Deleted house", houseName)
  return true
end

RegisterNetEvent("qb-houses:deleteHouse", function(houseName)
  local src = source
  if not HasPermission(src) then
    print(src, "Tried to exploit qb-houses:deleteHouse")
    return
  end
  local success = DeleteHouse(houseName)
  if not success then
    return Notification(source, i18n.t("house_not_found"), "error")
  end
  Notification(source, i18n.t("house_deleted"), "success")
end)

exports("deleteHouse", DeleteHouse)


-- Remove renter from a house
local function removeRenter(houseName, keepRentable)
  Debug("removeRenter", "Removing renter", houseName, keepRentable)
  MySQL.Sync.execute(
    "UPDATE player_houses SET citizenid = player_houses.owner, rented = NULL, rentable = ?, rent_furnished = NULL, stash = NULL, outfit = NULL, logout = NULL, decorateStash = NULL, charge = NULL, tablet = NULL, rentNextChargeAt = NULL WHERE house = ?",
    { keepRentable and 1 or nil, houseName }
  )
  HousingBatteryBridge_Unregister(houseName)
  MySQL.Sync.execute("DELETE FROM house_rents WHERE house = ?", { houseName })

  if not keepRentable then
    MySQL.Sync.execute([[
			UPDATE houselocations SET
				photos = '[]',
				description = '',
				hideFromBrowser = 0
			WHERE name = ?
		]], { houseName })
    Config.Houses[houseName].photos = {}
    Config.Houses[houseName].description = ""
    Config.Houses[houseName].hideFromBrowser = false
    Config.Houses[houseName].rentFurnished = nil
    TriggerClientEvent("housing:updateHouseData", -1, houseName, "photos", {})
    TriggerClientEvent("housing:updateHouseData", -1, houseName, "description", "")
    TriggerClientEvent("housing:updateHouseData", -1, houseName, "hideFromBrowser", false)
    TriggerClientEvent("housing:updateHouseData", -1, houseName, "rentFurnished", nil)
  end

  local updatedRows = MySQL.Sync.fetchAll("SELECT * FROM player_houses WHERE house = ?", { houseName })
  HouseOwnerIdentifierList[houseName] = updatedRows[1].owner
  HouseOwnerCitizenidList[houseName] = updatedRows[1].owner
  OfficialHouseOwnerList[houseName] = updatedRows[1].owner
  rentableHousesMap[houseName] = keepRentable

  SendLog(DiscordWebhook, {
    title = "Housing",
    description = "Player removed a renter from a house",
    fields = {
      { name = "House", value = houseName, inline = true },
      { name = "Owner", value = updatedRows[1].owner, inline = true },
    },
    color = WebhookColor,
  })
  TriggerClientEvent("housing:refreshHouse", -1, houseName)
end


-- Admin check callback
lib.callback.register("housing:isAdmin", function(source)
  return PlayerIsAdmin(source)
end)

-- Admin: evict renter
RegisterNetEvent("housing:hireRenter", function(houseName)
  local src = source
  if not PlayerIsAdmin(src) then
    return Notification(src, i18n.t("no_permission"), "error")
  end
  local rows = MySQL.Sync.fetchAll("SELECT * FROM player_houses WHERE house = ?", { houseName })
  if not rows[1] then
    return Notification(src, i18n.t("house_not_found"), "error")
  end
  if rows[1].rentable and not rows[1].rented then
    removeRenter(houseName, false)
    Notification(src, i18n.t("rent.house_is_no_longer_rented"), "success")
    return
  end
  if not rows[1].rented then
    return Notification(src, i18n.t("rent.house_is_not_rented"), "error")
  end
  local tenantSource = GetPlayerSourceFromIdentifier(rows[1].citizenid)
  if tenantSource then
    Notification(tenantSource, i18n.t("rent.hired_by_admin"), "info")
  end
  removeRenter(houseName, true)
  Notification(src, i18n.t("rent.hired_success"), "info")
  SendLog(DiscordWebhook, {
    title = "Housing",
    description = "Admin evicted a renter from a house",
    fields = {
      { name = "House", value = houseName, inline = true },
      { name = "Owner", value = rows[1].owner, inline = true },
      { name = "Tenant", value = rows[1].citizenid, inline = true },
      { name = "Admin", value = GetPlayerName(src), inline = true },
    },
    color = WebhookColor,
  })
end)


-- Owner dispossess (evict) renter
RegisterNetEvent("qb-houses:disspossesHouse", function(houseName)
  local src = source
  local identifier = GetIdentifier(src)
  local rows = MySQL.Sync.fetchAll("SELECT * FROM player_houses WHERE house = ? AND owner = ?", { houseName, identifier })
  if not rows[1] then
    return Notification(src, i18n.t("you_are_not_owner"), "error")
  end
  if rows[1].rentable and not rows[1].rented then
    removeRenter(houseName, false)
    Notification(src, i18n.t("rent.house_is_no_longer_rented"), "success")
    return
  end
  if not rows[1].rented then
    return Notification(src, i18n.t("rent.house_is_not_rented"), "error")
  end
  -- Check for unpaid rents
  local unpaidRents = MySQL.Sync.fetchAll("SELECT * FROM house_rents WHERE house = ? AND payed = 0", { houseName })
  if not unpaidRents[1] then
    return Notification(src, i18n.t("rent.cant_evict_renter"), "info")
  end
  local tenantSource = GetPlayerSourceFromIdentifier(rows[1].citizenid)
  if tenantSource then
    Notification(tenantSource, i18n.t("rent.evict_success"), "info")
  end
  removeRenter(houseName, true)
  Notification(src, i18n.t("left_house"), "info")
  SendLog(DiscordWebhook, {
    title = "Housing",
    description = "Player evicted a renter from a house",
    fields = {
      { name = "House", value = houseName, inline = true },
      { name = "Owner", value = rows[1].owner, inline = true },
      { name = "Tenant", value = rows[1].citizenid, inline = true },
    },
    color = WebhookColor,
  })
end)


-- Pay rent
function HousingPayRent(playerSource, rentId, houseName)
  local money = getHouseMoney(playerSource, houseName)
  local rentRows = MySQL.Sync.fetchAll("SELECT * FROM house_rents WHERE id = ? AND house = ?", { rentId, houseName })
  if not rentRows[1] then
    Notification(playerSource, i18n.t("rent.not_found"), "error")
    return false
  end
  if 1 == rentRows[1].payed then
    Notification(playerSource, i18n.t("rent.already_paid"), "error")
    return false
  end
  local houseRows = MySQL.Sync.fetchAll("SELECT * FROM player_houses WHERE house = ? AND citizenid = ? AND rented = 1", { houseName, GetIdentifier(playerSource) })
  if not houseRows[1] then
    Notification(playerSource, i18n.t("rent.you_are_not_tenant"), "error")
    return false
  end
  local rentPrice = houseRows[1].rentPrice
  if money < rentPrice then
    Notification(playerSource, i18n.t("no_money", { price = houseRows[1].rentPrice }), "error")
    return false
  end
  removeHouseMoney(playerSource, houseName, houseRows[1].rentPrice)
  MySQL.Sync.execute("UPDATE house_rents SET payed = 1 WHERE id = ?", { rentId })
  Notification(playerSource, i18n.t("rent.payment_success", { price = houseRows[1].rentPrice }), "success")
  SendLog(DiscordWebhook, {
    title = "Housing",
    description = "Player paid the rent",
    fields = {
      { name = "House", value = houseName, inline = true },
      { name = "Owner", value = houseRows[1].owner, inline = true },
      { name = "Tenant", value = GetPlayerName(playerSource), inline = true },
      { name = "Price", value = houseRows[1].rentPrice, inline = true },
    },
    color = WebhookColor,
  })
  Debug("housing:payRent", "Paid rent", houseName, "rent id", rentId)
  return true
end

lib.callback.register("housing:payRent", HousingPayRent)


-- Pay a single bill
function HousingPayBill(playerSource, billId, houseName)
  local money = GetAccountMoney(playerSource, Config.MoneyType)
  local bill = db.getBill(billId)
  if not bill then
    Notification(playerSource, "Bill not found", "error")
    return false
  end
  if bill.payed then
    Notification(playerSource, "Bill already paid", "error")
    return false
  end
  local total = tonumber(bill.total) or 0
  if money < total then
    Notification(playerSource, i18n.t("no_money", { price = total }), "error")
    return false
  end
  RemoveAccountMoney(playerSource, Config.MoneyType, total)
  db:payBill(billId, houseName, GetIdentifier(playerSource))
  Notification(playerSource, i18n.t("management.bills.you_paid_bills", { price = total }), "success")
  SendLog(DiscordWebhook, {
    title = "Housing",
    description = "Player paid the house bills",
    fields = {
      { name = "House", value = houseName, inline = true },
      { name = "Tenant", value = GetPlayerName(playerSource), inline = true },
      { name = "Total", value = total, inline = true },
    },
    color = WebhookColor,
  })
  Debug("housing:payBill", "Paid bill", houseName, "bill id", billId)
  return true
end

lib.callback.register("housing:payBill", HousingPayBill)


-- Pay all bills
function HousingPayAllBills(playerSource, houseName)
  local money = GetAccountMoney(playerSource, Config.MoneyType)
  local allBills = db:getBills(houseName)
  local unpaidBills = {}
  for _, bill in ipairs(allBills) do
    if not bill.payed then
      table.insert(unpaidBills, bill)
    end
  end
  if 0 == #unpaidBills then
    Notification(playerSource, i18n.t("management.bills.no_unpaid_bills"), "info")
    return false
  end
  local total = 0
  for _, bill in ipairs(unpaidBills) do
    total = total + (tonumber(bill.total) or 0)
  end
  if money < total then
    Notification(playerSource, i18n.t("no_money", { price = total }), "error")
    return false
  end
  local identifier = GetIdentifier(playerSource)
  db:payAllBills(houseName, identifier)
  RemoveAccountMoney(playerSource, Config.MoneyType, total)
  Notification(playerSource, i18n.t("management.bills.you_paid_all_bills", { price = total, count = #unpaidBills }), "success")
  SendLog(DiscordWebhook, {
    title = "Housing",
    description = "Player paid all house bills",
    fields = {
      { name = "House", value = houseName, inline = true },
      { name = "Player", value = GetPlayerName(playerSource), inline = true },
      { name = "Total", value = total, inline = true },
      { name = "Count", value = #unpaidBills, inline = true },
    },
    color = WebhookColor,
  })
  Debug("housing:payAllBills", "Paid all bills", houseName, "total", total, "count", #unpaidBills)
  return true
end

lib.callback.register("housing:payAllBills", HousingPayAllBills)


-- Get management data for a house
function GetHousingManagementData(playerSource, houseName)
  if "string" ~= type(houseName) or "" == houseName then
    return nil
  end
  local identifier = GetIdentifier(playerSource)
  if not identifier then
    return nil
  end
  local row = MySQL.single.await("SELECT citizenid, rented, owner FROM player_houses WHERE house = ? LIMIT 1", { houseName })
  local isOwner = OfficialHouseOwnerList[houseName] == identifier
  local isRented = row and (1 == tonumber(row.rented))
  local hasKey = CheckHasKey(identifier, identifier, houseName, playerSource)

  if not isOwner and not isRented and not hasKey then
    Notification(playerSource, i18n.t("not_have_keys"), "error")
    return nil
  end

  local bills = db:getBills(houseName)
  local rents = GetRents(houseName)

  if isRented and not isOwner then
    return { bills = bills, rents = rents, keyholders = {}, metaKeys = {} }
  end
  if isOwner then
    local metaKeys = {}
    if Config.EnableMetaKey then
      metaKeys = GetHouseMetaKeys(houseName) or {}
    end
    return { bills = bills, rents = rents, keyholders = GetKeyHolders(playerSource, houseName), metaKeys = metaKeys }
  end
  return { bills = {}, rents = {}, keyholders = {}, metaKeys = {} }
end

lib.callback.register("housing:getManagementData", GetHousingManagementData)


-- Get lights status
lib.callback.register("housing:getLightsStatus", function(source, houseName)
  if not houseName then return false end
  local result = MySQL.query.await("SELECT lights_on FROM player_houses WHERE house = ?", { houseName })
  if result and result[1] then
    return result[1].lights_on
  end
  return false
end)

-- Toggle lights
function HousingToggleLights(playerSource, houseName)
  if not houseName then return nil end
  local identifier = GetIdentifier(playerSource)
  if not identifier then return nil end

  local keyholders = HouseKeyholdersList[houseName] or {}
  local hasKey = table.includes(keyholders, identifier)
  local isOwner = HouseOwnerIdentifierList[houseName] == identifier
  if not hasKey and not isOwner then
    Notification(playerSource, i18n.t("not_have_keys"), "error")
    return nil
  end

  local result = MySQL.query.await("SELECT lights_on, lights_on_since FROM player_houses WHERE house = ?", { houseName })
  if not result or not result[1] then
    return nil
  end

  local currentState = result[1].lights_on
  local newState = not currentState
  if newState then
    MySQL.update.await("UPDATE player_houses SET lights_on = 1, lights_on_since = ? WHERE house = ?", { os.time(), houseName })
  else
    MySQL.update.await("UPDATE player_houses SET lights_on = 0, lights_on_since = NULL WHERE house = ?", { houseName })
  end
  TriggerClientEvent("housing:syncLightsStatus", -1, houseName, newState)
  Debug("housing:toggleLights", "Toggled lights", houseName, "newStatus", newState)
  return newState
end

lib.callback.register("housing:toggleLights", HousingToggleLights)


-- Auto eviction for unpaid bills
local function autoEvictOwner(houseName, unpaidCount)
  local ownerIdentifier = HouseOwnerIdentifierList[houseName]
  if not ownerIdentifier then return false end

  MySQL.Sync.execute("DELETE FROM player_houses WHERE house = ?", { houseName })
  MySQL.Sync.execute("DELETE FROM house_bills WHERE house = ? AND payed = 0", { houseName })
  HouseOwnerCitizenidList[houseName] = nil
  HouseOwnerIdentifierList[houseName] = nil
  OfficialHouseOwnerList[houseName] = nil
  HouseKeyholdersList[houseName] = nil
  rentableHousesMap[houseName] = nil
  purchasableHousesMap[houseName] = nil
  TriggerClientEvent("qb-houses:requiredLeaveHouse", -1, houseName)
  InitHouse(houseName)

  if Config.Bills.AutoEviction.NotifyOnEviction then
    local ownerSource = GetPlayerSourceFromIdentifier(ownerIdentifier)
    if ownerSource then
      Notification(ownerSource, i18n.t("management.bills.auto_eviction_notice", { house = houseName, count = unpaidCount }), "error")
    end
  end

  SendLog(DiscordWebhook, {
    title = "Housing - Auto Eviction",
    description = "House owner was automatically evicted due to unpaid bills",
    fields = {
      { name = "House", value = houseName, inline = true },
      { name = "Owner", value = ownerIdentifier, inline = true },
      { name = "Unpaid Bills", value = tostring(unpaidCount), inline = true },
    },
    color = 15158332,
  })
  Debug("AutoEviction", "Evicted owner from house", houseName, "unpaid bills:", unpaidCount)
  return true
end

-- Warn owner about pending eviction
local function warnOwnerAboutEviction(houseName, unpaidCount, maxUnpaid)
  local ownerIdentifier = HouseOwnerIdentifierList[houseName]
  if not ownerIdentifier then return end
  local ownerSource = GetPlayerSourceFromIdentifier(ownerIdentifier)
  if ownerSource then
    Notification(ownerSource, i18n.t("management.bills.eviction_warning", { house = houseName, unpaid = unpaidCount, remaining = maxUnpaid - unpaidCount }), "info")
  end
end


-- Bills generation thread
if Config.Bills and Config.Bills.Enabled then
  CreateThread(function()
    local intervalMs = (Config.Bills.IntervalHours or 72) * 60 * 60 * 1000
    while true do
      Wait(intervalMs)
      local billQueries = {}
      local updateQueries = {}
      local houseRows = MySQL.query.await("SELECT house, lights_on, lights_on_since FROM player_houses")
      local now = os.time()
      local autoEvictEnabled = Config.Bills.AutoEviction and Config.Bills.AutoEviction.Enabled
      local maxUnpaid = (Config.Bills.AutoEviction and Config.Bills.AutoEviction.MaxUnpaidBills) or 60
      local notifyAtBills = (Config.Bills.AutoEviction and Config.Bills.AutoEviction.NotifyOwnerAtBills) or {}
      local unpaidCounts = {}

      if autoEvictEnabled then
        local unpaidRows = MySQL.query.await("SELECT house, COUNT(*) as count FROM house_bills WHERE payed = 0 GROUP BY house")
        for _, row in ipairs(unpaidRows or {}) do
          unpaidCounts[row.house] = row.count
        end
      end

      for i = 1, #houseRows do
        local row = houseRows[i]
        local houseName = row.house
        if houseName then
          if autoEvictEnabled then
            local count = (unpaidCounts[houseName] or 0) + 1
            if maxUnpaid <= count then
              Debug("AutoEviction", "Checking eviction for", houseName, "unpaid:", count, "max:", maxUnpaid)
              if autoEvictOwner(houseName, count) then
                -- evicted, skip bill generation
              end
            else
              -- Check warning thresholds
              for _, threshold in ipairs(notifyAtBills) do
                if count == threshold then
                  warnOwnerAboutEviction(houseName, count, maxUnpaid)
                  break
                end
              end
              -- Calculate electricity cost
              local electricity = 0
              if row.lights_on and row.lights_on_since then
                local hoursOn = (now - row.lights_on_since) / 3600
                local kwPerHour = (Config.Bills.Electricity and Config.Bills.Electricity.kilowattPerHour) or 1.5
                local pricePerKw = (Config.Bills.Electricity and Config.Bills.Electricity.pricePerKilowatt) or 50
                electricity = math.floor(hoursOn * kwPerHour * pricePerKw)
                updateQueries[#updateQueries + 1] = { query = "UPDATE player_houses SET lights_on_since = ? WHERE house = ?", parameters = { now, houseName } }
              end
              local water = math.random(Config.Bills.RandomRanges.water.min, Config.Bills.RandomRanges.water.max)
              local internet = math.random(Config.Bills.RandomRanges.internet.min, Config.Bills.RandomRanges.internet.max)
              local total = electricity + water + internet
              local breakdown = json.encode({ electricity = electricity, water = water, internet = internet })
              billQueries[#billQueries + 1] = { query = "INSERT INTO house_bills (house, total, breakdown, payed) VALUES (?, ?, ?, 0)", parameters = { houseName, total, breakdown } }
              Debug("bills", "created", houseName, total, "electricity", electricity)
            end
          end
        end
      end

      if #billQueries > 0 then
        MySQL.transaction.await(billQueries)
      end
      if #updateQueries > 0 then
        MySQL.transaction.await(updateQueries)
      end
      db:clearCache("bills")
    end
  end)
end


-- Tenant leaves rented house voluntarily
RegisterNetEvent("qb-houses:leftHouse", function(houseName)
  local src = source
  local identifier = GetIdentifier(src)
  local rows = MySQL.Sync.fetchAll("SELECT * FROM player_houses WHERE house = ? AND citizenid = ? AND rented = 1", { houseName, identifier })
  if not rows[1] then
    return Notification(src, i18n.t("rent.you_are_not_tenant"), "error")
  end
  Notification(src, i18n.t("left_house"), "info")
  local ownerSource = GetPlayerSourceFromIdentifier(rows[1].owner)
  if ownerSource then
    Notification(ownerSource, i18n.t("rent.tenant_left", { house = houseName }), "error")
  end
  SendLog(DiscordWebhook, {
    title = "Housing",
    description = "Player left a rented house",
    fields = {
      { name = "House", value = houseName, inline = true },
      { name = "Owner", value = rows[1].owner, inline = true },
      { name = "Tenant", value = GetPlayerName(src), inline = true },
    },
    color = WebhookColor,
  })
  removeRenter(houseName, true)
end)


-- Lease house (put up for rent)
RegisterNetEvent("housing:lease", function(houseName, rentPrice, leaseOptions)
  local src = source
  if not Config.EnableRentable then
    Notification(src, i18n.t("rent.disabled"), "error")
    Debug("housing:lease", "Rentable houses are disabled")
    return
  end
  local identifier = GetIdentifier(src)
  local hasPermission = HasPermission(src)

  local query = "SELECT * FROM player_houses WHERE house = ? AND owner = ? AND rented IS NULL"
  local params = { houseName, identifier }

  if not Config.CreatedRentableHousesManageable and hasPermission then
    query = "SELECT * FROM player_houses WHERE house = ? AND rented IS NULL"
    params = { houseName }
    Debug("housing:lease", "Realestate is leasing")
  end

  local rows = MySQL.Sync.fetchAll(query, params)
  if not rows[1] then
    return Notification(src, i18n.t("rent.no_owner_or_renter"), "error")
  end
  if purchasableHousesMap[houseName] then
    return Notification(src, i18n.t("rent.in_sell"), "error")
  end

  if not leaseOptions then leaseOptions = {} end
  local photosJson = json.encode(leaseOptions.photos or {})
  local description = leaseOptions.description or ""
  local furnished = (false ~= leaseOptions.furnished) and 1 or 0
  local hidden = leaseOptions.hideFromBrowser and 1 or 0

  MySQL.Sync.execute("UPDATE player_houses SET citizenid = player_houses.owner, rentable = 1, rentPrice = ?, rent_furnished = ? WHERE id = ?", { rentPrice, furnished, rows[1].id })
  MySQL.Sync.execute([[
		UPDATE houselocations SET
			photos = ?,
			description = ?,
			hideFromBrowser = ?
		WHERE name = ?
	]], { photosJson, description, hidden, houseName })

  rentableHousesMap[houseName] = true
  Config.Houses[houseName].photos = leaseOptions.photos or {}
  Config.Houses[houseName].description = description
  Config.Houses[houseName].hideFromBrowser = 1 == hidden
  Config.Houses[houseName].rentFurnished = 1 == furnished

  TriggerClientEvent("housing:updateHouseData", -1, houseName, "photos", Config.Houses[houseName].photos)
  TriggerClientEvent("housing:updateHouseData", -1, houseName, "description", Config.Houses[houseName].description)
  TriggerClientEvent("housing:updateHouseData", -1, houseName, "hideFromBrowser", Config.Houses[houseName].hideFromBrowser)
  TriggerClientEvent("housing:updateHouseData", -1, houseName, "rentFurnished", Config.Houses[houseName].rentFurnished)
  Notification(src, i18n.t("rent.rented"), "success")
  TriggerClientEvent("housing:refreshHouse", -1, houseName)

  SendLog(DiscordWebhook, {
    title = "Housing",
    description = "Player rented a house",
    fields = {
      { name = "House", value = houseName, inline = true },
      { name = "Owner", value = rows[1].owner, inline = true },
      { name = "Tenant", value = GetPlayerName(src), inline = true },
      { name = "Price", value = rentPrice, inline = true },
      { name = "Furnished", value = tostring(1 == furnished), inline = true },
      { name = "Hidden", value = tostring(1 == hidden), inline = true },
    },
    color = WebhookColor,
  })
end)


-- Get rents for a house
function GetRents(houseName)
  local rents = {}
  local houseRows = MySQL.Sync.fetchAll("SELECT * FROM player_houses WHERE house = ?", { houseName })
  if not houseRows[1] then
    Debug("housing:getRents", "No house found", houseName)
    return rents
  end
  local rentRows = MySQL.Sync.fetchAll("SELECT * FROM house_rents WHERE house = ? ORDER BY payed ASC, date DESC LIMIT 50", { houseName })
  if not rentRows[1] then
    return rents
  end
  local firstName, lastName = GetCharacterFromIdentifier(rentRows[1].identifier)
  for _, row in pairs(rentRows) do
    table.insert(rents, {
      id = row.id,
      name = firstName .. " " .. lastName,
      identifier = row.identifier,
      payed = 1 == row.payed,
      date = row.date,
      price = houseRows[1].rentPrice,
    })
  end
  return rents
end

-- Create a rent record
function CreateHouseRent(houseName, identifier, payed)
  local payedVal = payed and 1 or 0
  MySQL.Sync.execute("INSERT INTO house_rents (house, identifier, payed) VALUES (?, ?, ?)", { houseName, identifier, payedVal })
  TriggerEvent("housing:handleRentPayment", houseName, identifier, payedVal)
end


-- Process rent charge for a single house
local function processRentCharge(houseRow, updateDueDate)
  local rentPrice = houseRow.rentPrice
  local houseName = houseRow.house
  local houseConfig = Config.Houses[houseName]
  if not houseConfig or not rentPrice then return end

  local isCreatorOwned = houseConfig.creator == houseRow.owner
  local payMethod = getHousePaymentMethod(houseName)
  local tenantSource = GetPlayerSourceFromIdentifier(houseRow.citizenid)
  local paid = false

  if tenantSource then
    local money = GetAccountMoney(tenantSource, payMethod)
    if rentPrice <= money then
      RemoveAccountMoney(tenantSource, payMethod, rentPrice)
      Notification(tenantSource, i18n.t("rent.payment_success", { price = rentPrice }), "success")
      paid = true
    else
      CreateHouseRent(houseName, houseRow.citizenid, false)
      Notification(tenantSource, i18n.t("rent.payment_failed", { price = rentPrice }), "error")
    end
  else
    local result = removeHouseMoneyFromIdentifier(houseRow.citizenid, houseName, rentPrice)
    paid = true == result
    if not paid then
      CreateHouseRent(houseName, houseRow.citizenid, false)
    end
  end

  if paid then
    if isCreatorOwned then
      if "none" == Config.Society and houseConfig.creator then
        Debug("Please specify a society in the config otherwise realestate jobs will not get the money")
      end
      if houseConfig.creatorJob then
        AddMoneyToSociety(tenantSource or houseRow.citizenid, houseConfig.creatorJob, rentPrice)
        Debug("processRentCharge", "Added money to society", houseConfig.creatorJob, rentPrice)
      else
        Debug("processRentCharge", "No creator job", houseConfig.creatorJob)
      end
    else
      AddMoneyToAccount(houseRow.owner, rentPrice)
    end
    CreateHouseRent(houseName, houseRow.citizenid, true)
  end

  if updateDueDate and houseRow.id then
    MySQL.update.await("UPDATE player_houses SET rentNextChargeAt = DATE_ADD(COALESCE(rentNextChargeAt, UTC_TIMESTAMP()), INTERVAL 1 MONTH) WHERE id = ?", { houseRow.id })
  end
end


-- Charge all rented houses (legacy mode)
local function chargeAllRentedHouses()
  local rows = MySQL.Sync.fetchAll("SELECT id, house, rentPrice, citizenid, owner FROM player_houses WHERE rented = 1")
  for _, row in pairs(rows) do
    processRentCharge(row, false)
  end
end

-- Charge due rented houses (anniversary mode)
local function chargeDueRentedHouses()
  local rows = MySQL.Sync.fetchAll([[
		SELECT id, house, rentPrice, citizenid, owner
		FROM player_houses
		WHERE rented = 1 AND rentNextChargeAt IS NOT NULL AND rentNextChargeAt <= UTC_TIMESTAMP()
	]])
  for _, row in pairs(rows) do
    processRentCharge(row, true)
  end
end

-- Run the appropriate rent charge logic
local function runRentCharges()
  if isMonthlyUTCAnniversaryMode() then
    chargeDueRentedHouses()
  else
    chargeAllRentedHouses()
  end
end

-- Clean old unpaid rent records
local function cleanOldRentRecords()
  MySQL.Sync.execute("DELETE FROM house_rents WHERE date < DATE_SUB(UTC_TIMESTAMP(), INTERVAL 10 DAY) AND payed = 0")
end

-- Rent scheduler thread
if Config.EnableRentable then
  CreateThread(function()
    Wait(5000)
    if isMonthlyUTCAnniversaryMode() then
      local pollMinutes = (Config.RentScheduler and Config.RentScheduler.PollMinutes) or 5
      if pollMinutes < 1 then pollMinutes = 1 end
      while true do
        Wait(pollMinutes * 60000)
        runRentCharges()
        cleanOldRentRecords()
      end
    else
      while true do
        Wait(Config.RentTime * 60000)
        runRentCharges()
        cleanOldRentRecords()
      end
    end
  end)
end


-- Credit payment thread
CreateThread(function()
  while true do
    Wait(Config.CreditTime * 60000)
    local rows = MySQL.Sync.fetchAll("SELECT credit, creditPrice, citizenid, house FROM player_houses")
    for i = 1, #rows do
      local credit = rows[i].credit
      if credit and "" ~= credit then
        local creditRemaining = tonumber(rows[i].credit)
        local creditPayment = tonumber(rows[i].creditPrice)
        if creditRemaining > 0 and creditPayment then
          local playerSource = GetPlayerSourceFromIdentifier(rows[i].citizenid)
          if playerSource then
            RemoveAccountMoney(playerSource, "bank", creditPayment)
            Notification(playerSource, i18n.t("rent.pay_mortgage", { price = creditPayment, remaining = creditRemaining - creditPayment }), "success")
            if creditRemaining - creditPayment < 0 then
              AddAccountMoney(playerSource, "bank", creditPayment - creditRemaining)
              Notification(playerSource, i18n.t("rent.transfer_account", { price = creditPayment - creditRemaining }), "info")
            end
          else
            local refund = (creditRemaining - creditPayment < 0) and (creditPayment - creditRemaining) or 0
            RemoveMoneyFromAccount(rows[i].citizenid, creditPayment, true)
            AddMoneyToAccount(rows[i].citizenid, refund)
          end
          local newCredit = (creditRemaining - creditPayment <= 0) and 0 or (creditRemaining - creditPayment)
          MySQL.Sync.execute("UPDATE player_houses SET credit = ? WHERE house = ?", { newCredit, rows[i].house })
        end
      end
    end
  end
end)


-- Transfer house via phone
RegisterServerCallback("qb-phone:server:TransferCid", function(source, cb, targetSource, houseData)
  local targetIdentifier = GetIdentifier(targetSource)
  if targetIdentifier then
    local playerData = GetPlayerSQLDataFromIdentifier(targetIdentifier)
    if playerData then
      local houseName = houseData.name
      MySQL.Sync.execute("UPDATE player_houses SET citizenid = @iden, keyholders = @keyholders WHERE house = @house", { ["@iden"] = targetIdentifier, ["@keyholders"] = "null", ["@house"] = houseName })
      TriggerClientEvent("qb-phone:client:sendMessageee", targetSource)
      HouseKeyholdersList[houseName] = { targetIdentifier }
      HouseOwnerCitizenidList[houseName] = targetIdentifier
      HouseOwnerIdentifierList[houseName] = targetIdentifier
      OfficialHouseOwnerList[houseName] = targetIdentifier
      TriggerClientEvent("housing:refreshHouse", -1, houseName)
      cb(true)
    else
      cb(false)
    end
  else
    cb(false)
  end
end)

-- Lock/unlock house
RegisterServerEvent("qb-houses:server:lockHouse")
AddEventHandler("qb-houses:server:lockHouse", function(houseName, locked)
  TriggerClientEvent("qb-houses:client:lockHouse", -1, houseName, locked)
end)

-- Set ram state
RegisterServerEvent("qb-houses:server:SetRamState")
AddEventHandler("qb-houses:server:SetRamState", function(state, houseName)
  Config.Houses[houseName].IsRaming = state
  TriggerClientEvent("qb-houses:server:SetRamState", -1, state, houseName)
end)


-- Check if player has key access to a house
local function playerHasKeyAccess(playerSource, identifier, houseName)
  local hasKey = CheckHasKey(identifier, identifier, houseName, playerSource)
  return hasKey and true or false
end

-- Get house data callback
RegisterServerCallback("houses:getHouseData", function(src, cb, houseName)
  local identifier = GetIdentifier(src)
  local hasKey = playerHasKeyAccess(src, identifier, houseName)
  local isOwned = nil ~= HouseOwnerIdentifierList[houseName]
  local isRentable = rentableHousesMap[houseName]
  local isPurchasable = purchasableHousesMap[houseName]
  local isOfficialOwner = nil ~= OfficialHouseOwnerList[houseName]
  local isOwnedByMe = HouseOwnerIdentifierList[houseName] == identifier

  local unpaidBills = table.filter(db:getBills(houseName), function(bill) return not bill.payed end)
  local billsCutOff = #unpaidBills > 1

  local lightsOn = false
  local lightsResult = MySQL.query.await("SELECT lights_on FROM player_houses WHERE house = ?", { houseName })
  if lightsResult and lightsResult[1] then
    lightsOn = lightsResult[1].lights_on
  end

  cb({
    haskey = hasKey,
    isOwned = isOwned,
    rentable = isRentable,
    purchasable = isPurchasable,
    isOfficialOwner = isOfficialOwner,
    isOwnedByMe = isOwnedByMe,
    billsCutOff = billsCutOff,
    lightsOn = lightsOn,
  })
end)


-- Build browser data map for all houses
function HousingBuildBrowserDataMap()
  local browserData = {}
  -- Get sale_furnished data
  local saleFurnishedMap = {}
  local saleRows = MySQL.Sync.fetchAll("SELECT house, sale_furnished FROM player_houses WHERE purchasable = 1")
  for _, row in ipairs(saleRows or {}) do
    saleFurnishedMap[row.house] = row.sale_furnished
  end

  for name, data in pairs(Config.Houses) do
    -- Skip apartment sub-units (not apt-0)
    if data.apartmentNumber and "apt-0" ~= data.apartmentNumber then
      -- skip
    else
      local isOwned = nil ~= HouseOwnerIdentifierList[name]
      local isRentable = rentableHousesMap[name] or false
      local isPurchasable = purchasableHousesMap[name] or false

      -- Handle apartment complexes
      if data.apartmentCount and data.apartmentCount > 0 then
        local aptBase = data.apartmentName or name:gsub("-apt%-0$", "")
        local anyRentable = false
        local anyPurchasable = false
        local ownedUnits = 0
        for unit = 1, data.apartmentCount do
          local unitName = aptBase .. "-apt-" .. unit
          if rentableHousesMap[unitName] then anyRentable = true end
          if purchasableHousesMap[unitName] then anyPurchasable = true end
          if nil ~= HouseOwnerIdentifierList[unitName] and nil ~= HouseOwnerCitizenidList[unitName] then
            ownedUnits = ownedUnits + 1
          end
        end
        isOwned = ownedUnits >= data.apartmentCount
        isPurchasable = anyPurchasable or (ownedUnits < data.apartmentCount)
        isRentable = anyRentable
      end

      -- Skip hidden houses that are purchasable
      if isPurchasable and data.hideFromBrowser then
        -- skip from browser
      else
        -- Get owner name
        local ownerName = nil
        if isOwned then
          local ownerId = HouseOwnerIdentifierList[name]
          if ownerId then
            local first, last = GetCharacterFromIdentifier(ownerId)
            if first and last then
              ownerName = first .. " " .. last
            else
              local ownerSrc = GetPlayerFromIdentifier(ownerId)
              if ownerSrc then
                local f2, l2 = GetCharacterName(ownerSrc.source)
                if f2 and l2 then
                  ownerName = f2 .. " " .. l2
                else
                  ownerName = "Unknown Owner"
                end
              else
                ownerName = "Unknown Owner"
              end
            end
          end
        end

        local rentPrice = nil
        if isRentable and data.price then
          rentPrice = data.price
        end

        browserData[name] = {
          owned = isOwned,
          rentable = isRentable,
          purchasable = isPurchasable,
          rentPrice = rentPrice,
          ownerName = ownerName,
          ownerPhone = nil,
          saleFurnished = saleFurnishedMap[name],
        }
      end
    end
  end
  return browserData
end

lib.callback.register("housing:getHouseBrowserData", function(source)
  return HousingBuildBrowserDataMap()
end)


-- Get apartments data for apartment complex
RegisterServerCallback("housing:getApartmentsData", function(src, cb, houseName, showRented)
  local apartments = {}
  local identifier = GetIdentifier(src)
  local baseName = houseName:gsub("-apt%-%d+", "")

  for name, data in pairs(Config.Houses) do
    if data.apartmentName == baseName and "apt-0" ~= data.apartmentNumber then
      local hasKey = playerHasKeyAccess(src, identifier, name)
      local isOwned = nil ~= HouseOwnerIdentifierList[name]
      local isRentable = rentableHousesMap[name]
      local isPurchasable = purchasableHousesMap[name]
      local isOwnedByMe = HouseOwnerIdentifierList[name] == identifier
      local isOfficialOwner = nil ~= OfficialHouseOwnerList[name]
      local isRented = false
      local ownerName = nil

      if showRented then
        local unitRows = MySQL.Sync.fetchAll("SELECT * FROM player_houses WHERE house = ?", { name })
        if unitRows[1] then
          isRented = 1 == unitRows[1].rented
        end
      end
      if isOwned then
        ownerName = GetCharacterFromIdentifier(HouseOwnerCitizenidList[name])
      end

      table.insert(apartments, {
        id = data.id,
        house = name,
        haskey = hasKey,
        isOwned = isOwned,
        rentable = isRentable,
        purchasable = isPurchasable,
        isOfficialOwner = isOfficialOwner,
        isOwnedByMe = isOwnedByMe,
        rented = isRented,
        ownerName = ownerName or "Unknown Owner",
      })
    end
  end

  table.sort(apartments, function(a, b)
    if a.isOwnedByMe and not b.isOwnedByMe then return true end
    if not a.isOwnedByMe and b.isOwnedByMe then return false end
    return a.house < b.house
  end)
  cb(apartments)
end)

-- Get house owner
RegisterServerCallback("qb-houses:server:getHouseOwner", function(source, cb, houseName)
  cb(HouseOwnerCitizenidList[houseName])
end)


-- Get keyholders for a house
function GetKeyHolders(playerSource, houseName)
  local result = {}
  local identifier = GetIdentifier(playerSource)
  local keyholders = HouseKeyholdersList[houseName]
  if nil ~= keyholders then
    for i = 1, #keyholders do
      local isOwner = HouseOwnerIdentifierList[houseName] == keyholders[i]
      if identifier ~= keyholders[i] and not isOwner then
        local first, last = GetCharacterFromIdentifier(keyholders[i])
        table.insert(result, { firstname = first, lastname = last, citizenid = keyholders[i] })
      end
    end
  end
  return result
end

-- Check if a player has a key to a house
function CheckHasKey(identifier, citizenid, houseName, playerSource)
  Debug("CheckHasKey info:", json.encode(identifier), json.encode(citizenid), json.encode(houseName))
  if nil ~= HouseOwnerIdentifierList[houseName] and nil ~= HouseOwnerCitizenidList[houseName] then
    if HouseOwnerIdentifierList[houseName] == identifier and HouseOwnerCitizenidList[houseName] == citizenid then
      return true
    else
      if nil ~= HouseKeyholdersList[houseName] then
        for i = 1, #HouseKeyholdersList[houseName] do
          if HouseKeyholdersList[houseName][i] == citizenid then
            return true
          end
        end
      end
    end
  end
  -- Meta key check
  if Config.EnableMetaKey and Config.MetaKeyCheckOnEntry and playerSource then
    if CheckHasMetaKey and CheckHasMetaKey(playerSource, houseName) then
      Debug("CheckHasKey: Player has meta key for house:", houseName)
      return true
    end
  end
  return false
end

exports("CheckHasKey", CheckHasKey)


-- Load keyholders and owner data from DB on resource start
CreateThread(function()
  MySQL.Async.fetchAll("SELECT * FROM player_houses", {}, function(rows)
    if nil ~= rows then
      for _, row in pairs(rows) do
        HouseOwnerIdentifierList[row.house] = row.citizenid
        HouseOwnerCitizenidList[row.house] = row.citizenid
        OfficialHouseOwnerList[row.house] = row.owner
        rentableHousesMap[row.house] = row.rentable
        purchasableHousesMap[row.house] = row.purchasable
        HouseKeyholdersList[row.house] = json.decode(row.keyholders)
      end
    end
  end)
end)

-- Open door for invited player
RegisterServerEvent("qb-houses:server:OpenDoor")
AddEventHandler("qb-houses:server:OpenDoor", function(targetPlayerId, houseName)
  local src = source
  local targetSrc = GetPlayerSourceFromSource(targetPlayerId)
  if targetSrc then
    local housePos = vec3(Config.Houses[houseName].coords.enter.x, Config.Houses[houseName].coords.enter.y, Config.Houses[houseName].coords.enter.z)
    local targetPed = GetPlayerPed(targetSrc)
    local targetCoords = GetEntityCoords(targetPed)
    if #(targetCoords - housePos) < 2.0 then
      TriggerClientEvent("qb-houses:client:SpawnInApartment", targetSrc, houseName)
    else
      Notification(src, i18n.t("invite_play_far_other"), "error")
      Notification(targetSrc, i18n.t("invite_play_far"), "error")
    end
  end
end)


-- Doorbell system
local doorbellCooldowns = {}
DoorbellPlayers = {}

RegisterServerEvent("qb-houses:server:RingDoor")
AddEventHandler("qb-houses:server:RingDoor", function(houseName)
  local src = source
  local identifier = GetIdentifier(src)
  if not identifier then return end

  local cooldownKey = houseName .. ":" .. identifier
  local now = os.time()
  if doorbellCooldowns[cooldownKey] and (now - doorbellCooldowns[cooldownKey]) < 10 then
    return
  end
  doorbellCooldowns[cooldownKey] = now
  SetTimeout(10000, function() doorbellCooldowns[cooldownKey] = nil end)

  local firstName, lastName = GetCharacterName(src)
  local playerName = GetPlayerName(src)

  if not DoorbellPlayers[houseName] then
    DoorbellPlayers[houseName] = {}
  end

  local entry = {
    id = src,
    firstname = firstName or "",
    lastname = lastName or "",
    name = playerName or "",
    timestamp = now * 1000,
  }

  -- Update or insert
  local found = false
  for idx, existing in ipairs(DoorbellPlayers[houseName]) do
    if existing.id == src then
      DoorbellPlayers[houseName][idx] = entry
      found = true
      break
    end
  end
  if not found then
    table.insert(DoorbellPlayers[houseName], entry)
  end

  -- Auto-remove after 10 seconds
  SetTimeout(10000, function()
    if DoorbellPlayers[houseName] then
      for idx, p in ipairs(DoorbellPlayers[houseName]) do
        if p.id == src then
          table.remove(DoorbellPlayers[houseName], idx)
          break
        end
      end
      if #DoorbellPlayers[houseName] == 0 then
        DoorbellPlayers[houseName] = nil
      end
    end
  end)

  TriggerClientEvent("qb-houses:client:RingDoor", -1, src, houseName)
end)

-- Get doorbell players
lib.callback.register("housing:getDoorbellPlayers", function(source, houseName)
  if not houseName or not DoorbellPlayers[houseName] then
    return {}
  end
  local now = os.time() * 1000
  local result = {}
  for _, entry in ipairs(DoorbellPlayers[houseName]) do
    if (now - entry.timestamp) < 10000 then
      table.insert(result, entry)
    end
  end
  return result
end)


-- Save stash location
RegisterNetEvent("qb-houses:saveStash", function(houseName, stashData)
  local rows = MySQL.Sync.fetchAll("select * from player_houses where house = @hosue", { ["@house"] = houseName })
  if not rows[1] then return end
  local stashes = json.decode(rows[1].decorateStash)
  if not stashes or not stashes[1] then stashes = {} end
  table.insert(stashes, stashData)
  MySQL.Sync.execute("update player_houses SET decorateStash = @newStash where house = @house", { ["@house"] = houseName, ["@newStash"] = stashes })
end)

-- Get decorate stashes
RegisterServerCallback("qb-houses:server:getHouseDecorateStashes", function(source, cb, houseName)
  local rows = MySQL.Sync.fetchAll("SELECT * FROM `player_houses` WHERE `house` = '" .. houseName .. "'")
  if nil ~= rows[1] then
    if nil ~= rows[1].decorateStash then
      cb(json.decode(rows[1].decorateStash))
    else
      cb(false)
    end
  else
    cb(false)
  end
end)

-- Get house locations (stash, outfit, logout, charge, tablet)
lib.callback.register("housing:getLocations", function(source, houseName)
  Debug("house", houseName)
  local result = MySQL.query.await("SELECT stash, outfit, logout, charge, tablet FROM `player_houses` WHERE `house` = ?", { houseName })
  local row = (result and result[1]) or nil
  if not row then
    Debug("getlocations", result)
    return nil
  end
  -- Also get delivery coords from houselocations
  local locRow = MySQL.single.await("SELECT coords FROM `houselocations` WHERE `name` = ? LIMIT 1", { houseName })
  if locRow and locRow.coords then
    local coords = json.decode(locRow.coords) or {}
    if coords.delivery then
      row.delivery = json.encode(coords.delivery)
    end
  end
  Debug("getlocations", row)
  return row
end)


-- Get player houses (for callbacks)
RegisterServerCallback("qb-houses:server:getPlayerHouses", function(src, cb, filterHouse)
  local query = "SELECT house, owner, citizenid, rented, rentable, purchasable FROM player_houses"
  if filterHouse then
    query = query .. " WHERE house = ?"
  end
  local rows = MySQL.Sync.fetchAll(query, filterHouse and { filterHouse } or {})
  cb(rows)
end)

-- Set location (stash=1, outfit=2, logout=3, charge=4, delivery=8, tablet=9, tv=6, sit=7)
RegisterServerEvent("qb-houses:server:setLocation")
AddEventHandler("qb-houses:server:setLocation", function(coords, houseName, locationType)
  local src = source
  local coordsJson = json.encode(coords)
  local broadcastCoords = coordsJson

  if 1 == locationType then
    MySQL.update.await("UPDATE `player_houses` SET `stash` = ? WHERE `house` = ?", { coordsJson, houseName })
    -- Quest: place_home_stash
    if GetResourceState("qs-inventory"):find("started") and Config.EnableQuests then
      local ok = exports["qs-inventory"]:UpdateQuestProgress(src, "place_home_stash", 100)
      Debug(ok and "Quest \"place_home_stash\" progress updated" or "Failed to update quest \"place_home_stash\"")
    end
  elseif 2 == locationType then
    MySQL.update.await("UPDATE `player_houses` SET `outfit` = ? WHERE `house` = ?", { coordsJson, houseName })
    if GetResourceState("qs-inventory"):find("started") and Config.EnableQuests then
      local ok = exports["qs-inventory"]:UpdateQuestProgress(src, "place_home_wardrobe", 100)
      Debug(ok and "Quest \"place_home_wardrobe\" progress updated" or "Failed to update quest \"place_home_wardrobe\"")
    end
  elseif 3 == locationType then
    MySQL.update.await("UPDATE `player_houses` SET `logout` = ? WHERE `house` = ?", { coordsJson, houseName })
  elseif 4 == locationType then
    MySQL.update.await("UPDATE `player_houses` SET `charge` = ? WHERE `house` = ?", { coordsJson, houseName })
    if GetResourceState("qs-inventory"):find("started") and Config.EnableQuests then
      local ok = exports["qs-inventory"]:UpdateQuestProgress(src, "place_phone_charger", 100)
      Debug(ok and "Quest \"place_phone_charger\" progress updated" or "Failed to update quest \"place_phone_charger\"")
    end
    HousingBatteryBridge_Register(houseName, coords)
  elseif 8 == locationType then
    -- Delivery location stored in houselocations.coords
    local locRow = MySQL.single.await("SELECT coords FROM `houselocations` WHERE `name` = ? LIMIT 1", { houseName })
    local existingCoords = (locRow and locRow.coords and json.decode(locRow.coords)) or {}
    existingCoords.delivery = { x = tonumber(coords.x) or coords.x, y = tonumber(coords.y) or coords.y, z = tonumber(coords.z) or coords.z, w = tonumber(coords.w) or 0.0 }
    MySQL.update.await("UPDATE `houselocations` SET `coords` = ? WHERE `name` = ?", { json.encode(existingCoords), houseName })
    broadcastCoords = json.encode(existingCoords.delivery)
  elseif 9 == locationType then
    MySQL.update.await("UPDATE `player_houses` SET `tablet` = ? WHERE `house` = ?", { coordsJson, houseName })
  elseif 6 == locationType then
    local rows = MySQL.Sync.fetchAll("SELECT console FROM `player_houses` WHERE `house` = ?", { houseName })
    local console = json.decode(rows[1].console) or {}
    console.tv = coords
    MySQL.Sync.execute("UPDATE `player_houses` SET `console` = '" .. json.encode(console) .. "' WHERE `house` = '" .. houseName .. "'")
  elseif 7 == locationType then
    local rows = MySQL.Sync.fetchAll("SELECT console FROM `player_houses` WHERE `house` = ?", { houseName })
    local console = json.decode(rows[1].console) or {}
    console.sit = coords
    MySQL.Sync.execute("UPDATE `player_houses` SET `console` = '" .. json.encode(console) .. "' WHERE `house` = '" .. houseName .. "'")
  end

  Debug("refresh locations, type: " .. locationType .. " house: " .. houseName .. " coords: " .. tostring(broadcastCoords) .. "")

  -- For delivery (type 8), only notify players inside house
  if 8 == locationType then
    local targets = {}
    local seen = {}
    if src and src > 0 then
      seen[src] = true
      targets[#targets + 1] = src
    end
    local routing = HouseRoutings and HouseRoutings[houseName]
    if routing and type(routing.players) == "table" then
      for i = 1, #routing.players do
        local pid = tonumber(routing.players[i])
        if pid and not seen[pid] then
          if DoesPlayerExist(tostring(pid)) > 0 then
            seen[pid] = true
            targets[#targets + 1] = pid
          end
        end
      end
    end
    for i = 1, #targets do
      TriggerClientEvent("qb-houses:client:refreshLocations", targets[i], houseName, broadcastCoords, locationType)
    end
  else
    TriggerClientEvent("qb-houses:client:refreshLocations", -1, houseName, broadcastCoords, locationType)
  end
end)


-- Get credit state
RegisterServerCallback("qb-houses:GetCreditState", function(source, cb, houseName)
  local rows = MySQL.Sync.fetchAll("SELECT * FROM player_houses WHERE house = ?", { houseName })
  local row = rows[1]
  local credit = row and row.credit
  if credit and tonumber(credit) > 0 then
    cb(true)
  else
    cb(false)
  end
end)

-- Set inside state
RegisterServerEvent("housing:setInside")
AddEventHandler("housing:setInside", function(houseName, inside)
  UpdateInside(source, houseName, inside)
end)

-- Get console data
RegisterServerCallback("qb-houses:getConsoleData", function(source, cb, houseName)
  local rows = MySQL.Sync.fetchAll("SELECT console FROM player_houses WHERE house = ?", { houseName })
  if not rows[1] then
    return cb({})
  end
  cb(json.decode(rows[1].console) or {})
end)

-- Phone new: get player houses
RegisterServerCallback("phone_new:server:GetPlayerHouses", function(src, cb)
  local playerHouses = {}
  local keyholderData = {}
  local identifier = GetIdentifier(src)

  MySQL.Async.fetchAll("SELECT * FROM `player_houses` WHERE `citizenid` = '" .. identifier .. "'", {}, function(rows)
    if nil ~= rows[1] then
      for idx, row in pairs(rows) do
        row.keyholders = json.decode(row.keyholders)
        if nil ~= row.keyholders then
          if next(row.keyholders) then
            for khIdx, khId in pairs(row.keyholders) do
              local sqlData = GetPlayerSQLDataFromIdentifier(khId)
              if sqlData then
                keyholderData[khIdx] = sqlData
              end
            end
          end
        else
          keyholderData[1] = identifier
        end
        table.insert(playerHouses, {
          name = row.house,
          keyholders = keyholderData,
          owner = row.citizenid,
          price = Config.Houses[row.house].price,
          label = Config.Houses[row.house].address,
          tier = Config.Houses[row.house].tier,
          garage = Config.Houses[row.house].garage,
        })
      end
      cb(playerHouses)
    end
  end)
end)


-- Utility functions
function SplitStringToArray(str)
  local result = {}
  for word in str:gmatch("%S+") do
    result[#result + 1] = word
  end
  return result
end

function escape_sqli(str)
  local replacements = { ['"'] = '\\"', ["'"] = "\\'" }
  return str:gsub("['\"']", replacements)
end

-- Storm ram / raid item
if Config.EnableRaid then
  RegisterUsableItem(Config.StomRamItem, function(src, item)
    local jobName = GetJobName(src)
    if table.contains(Config.PoliceJobs, jobName) then
      TriggerClientEvent("qb-houses:client:HomeInvasion", src)
    else
      Notification(src, i18n.t("stormram"), "error")
    end
  end)
end

-- Count players with a specific job
local function countPlayersWithJob(jobList)
  local players = GetPlayers()
  local count = 0
  for _, pid in ipairs(players) do
    local job = GetJobName(pid)
    if table.contains(jobList, job) then
      count = count + 1
    end
  end
  return count
end

RegisterServerCallback("housing:checkTotalJobCount", function(source, cb)
  cb(countPlayersWithJob(Config.PoliceJobs))
end)

RegisterNetEvent("housing:removeItem", function(itemName, amount)
  RemoveItem(source, itemName, amount)
end)

-- Robbery item
if Config.EnableRobbery then
  RegisterUsableItem(Config.RobberyItem, function(src, item)
    local policeCount = countPlayersWithJob(Config.PoliceJobs)
    if policeCount < Config.RequiredCop then
      Notification(src, i18n.t("not_enough_police"), "error")
    end
    TriggerClientEvent("qb-houses:client:lockpick", src)
  end)
end


-- Set house rammed state
RegisterServerEvent("qb-houses:server:SetHouseRammed")
AddEventHandler("qb-houses:server:SetHouseRammed", function(state, houseName)
  Config.Houses[houseName].IsRammed = state
  TriggerClientEvent("qb-houses:client:SetHouseRammed", -1, state, houseName)
end)

-- Register stash (ox_inventory)
RegisterServerEvent("qb-houses:server:RegisterStash")
AddEventHandler("qb-houses:server:RegisterStash", function(stashName, slots, weight)
  exports.ox_inventory:RegisterStash(stashName, "stash" .. stashName, slots, weight, false)
end)

-- ESX: get player dressing
RegisterServerCallback("qb-houses:server:getPlayerDressing", function(src, cb)
  local player = GetPlayerFromId(src)
  if player then
    TriggerEvent("esx_datastore:getDataStore", "property", player.identifier, function(store)
      local count = store.count("dressing")
      local labels = {}
      for i = 1, count do
        local outfit = store.get("dressing", i)
        table.insert(labels, outfit.label)
      end
      cb(labels)
    end)
  end
end)

-- ESX: get player outfit
RegisterServerCallback("qb-houses:server:getPlayerOutfit", function(src, cb, outfitIndex)
  local player = GetPlayerFromId(src)
  if player then
    TriggerEvent("esx_datastore:getDataStore", "property", player.identifier, function(store)
      local outfit = store.get("dressing", outfitIndex)
      cb(outfit.skin)
    end)
  end
end)

-- ESX: remove outfit
RegisterServerEvent("qb-houses:server:removeOutfit")
AddEventHandler("qb-houses:server:removeOutfit", function(outfitIndex)
  local player = GetPlayerFromId(source)
  if player then
    TriggerEvent("esx_datastore:getDataStore", "property", player.identifier, function(store)
      local outfits = store.get("dressing")
      if nil == outfits then outfits = {} end
      table.remove(outfits, outfitIndex)
      store.set("dressing", outfits)
    end)
  end
end)


-- ESX: withdraw item from house
RegisterServerEvent("qb-houses:server:withdrawItem")
AddEventHandler("qb-houses:server:withdrawItem", function(itemType, itemName, amount, extra)
  local src = source
  local player = GetPlayerFromId(src)
  local identifier = player.identifier
  if "item" == itemType then
    TriggerEvent("esx_addoninventory:getInventory", "property", identifier, function(inventory)
      if player.canCarryItem(itemName, amount) then
        local item = inventory.getItem(itemName)
        if item.count >= amount then
          player.addInventoryItem(itemName, amount)
          inventory.removeItem(itemName, amount)
        end
      end
    end)
  elseif "weapon" == itemType then
    TriggerEvent("esx_datastore:getDataStore", "property", identifier, function(store)
      local weapons = store.get("weapons") or {}
      for i = 1, #weapons do
        if weapons[i].name == itemName then
          table.remove(weapons, i)
          store.set("weapons", weapons)
          player.addWeapon(itemName, amount)
          break
        end
      end
    end)
  end
end)

-- ESX: store item in house
RegisterServerEvent("qb-houses:server:storeItem")
AddEventHandler("qb-houses:server:storeItem", function(itemType, itemName, amount, extra)
  local src = source
  local player = GetPlayerFromId(src)
  local identifier = player.identifier
  if "item" == itemType then
    local invItem = player.getInventoryItem(itemName)
    if amount <= invItem.count then
      TriggerEvent("esx_addoninventory:getInventory", "property", identifier, function(inventory)
        player.removeInventoryItem(itemName, amount)
        inventory.addItem(itemName, amount)
      end)
    end
  elseif "weapon" == itemType then
    local loadout = player.getLoadout()
    local hasWeapon = false
    for _, weapon in pairs(loadout) do
      if weapon.name == itemName then
        hasWeapon = true
        break
      end
    end
    if hasWeapon then
      TriggerEvent("esx_datastore:getDataStore", "property", identifier, function(store)
        local weapons = store.get("weapons") or {}
        table.insert(weapons, { name = itemName, ammo = amount })
        store.set("weapons", weapons)
        player.removeWeapon(itemName)
      end)
    end
  end
end)


-- ESX: get inventory
RegisterServerCallback("qb-houses:server:getInventory", function(src, cb)
  local player = GetPlayerFromId(src)
  if player then
    cb({ items = player.inventory, weapons = player.getLoadout() })
  end
end)

-- ESX: get black money
RegisterServerCallback("qb-houses:server:getBlackMoney", function(src, cb)
  local player = GetPlayerFromId(src)
  if player then
    TriggerEvent("esx_addonaccount:getAccount", "property", player.identifier, function(account)
      cb(account.money)
    end)
  end
end)

-- ESX: deposit black money
RegisterServerCallback("qb-houses:server:depositBlackMoney", function(src, cb, amount)
  local player = GetPlayerFromId(src)
  if player then
    local blackMoney = player.getAccount("black_money").money
    if amount and amount > 0 and amount <= blackMoney then
      player.removeAccountMoney("black_money", amount)
      TriggerEvent("esx_addonaccount:getAccount", "property", player.identifier, function(account)
        account.addMoney(amount)
        cb(true)
      end)
    else
      cb(false)
    end
  end
end)

-- ESX: withdraw black money
RegisterServerCallback("qb-houses:server:withdrawBlackMoney", function(src, cb, amount)
  local player = GetPlayerFromId(src)
  if player and amount and amount > 0 then
    TriggerEvent("esx_addonaccount:getAccount", "property", player.identifier, function(account)
      if account.money >= amount then
        account.removeMoney(amount)
        player.addAccountMoney("black_money", amount)
        cb(true)
      else
        cb(false)
      end
    end)
  end
end)

-- ESX: get house inventory
RegisterServerCallback("qb-houses:server:getHouseInventory", function(src, cb, houseName)
  local player = GetPlayerFromId(src)
  if player then
    local items = {}
    local weapons = {}
    TriggerEvent("esx_addoninventory:getInventory", "property", player.identifier, function(inventory)
      items = inventory.items
    end)
    TriggerEvent("esx_datastore:getDataStore", "property", player.identifier, function(store)
      weapons = store.get("weapons") or {}
    end)
    cb({ items = items, weapons = weapons })
  end
end)


-- Open stash (qb-inventory)
RegisterNetEvent("housing:openStash", function(stashType, stashData)
  exports["qb-inventory"]:OpenInventory(source, stashType, stashData)
end)

-- Update exit coords
RegisterNetEvent("housing:updateExitCoords", function(houseName, exitCoords)
  local src = source
  Debug("housing:updateExitCoords", "Updating exit coords", houseName, exitCoords)
  Config.Houses[houseName].coords.exit = exitCoords
  MySQL.Sync.execute("UPDATE houselocations SET coords = ? WHERE name = ?", { json.encode(Config.Houses[houseName].coords), houseName })
  TriggerClientEvent("housing:updateHouseData", -1, houseName, "coords", Config.Houses[houseName].coords)
end)

-- Discord webhook log
function SendLog(webhookUrl, embed)
  embed.author = { name = "HOUSE LOG", icon_url = "https://img.gta5-mods.com/q75/images/motel-arrangement/3a516a-1.png" }
  embed.footer = { text = "HOUSING" }
  embed.timestamp = os.date("%Y-%m-%dT%H:%M:%S")
  PerformHttpRequest(webhookUrl, function(status, text, headers) end, "POST", json.encode({
    username = "QS",
    embeds = { embed },
    avatar_url = "https://img.gta5-mods.com/q75/images/motel-arrangement/3a516a-1.png",
  }), { ["Content-Type"] = "application/json" }, {})
end

-- Vault codes
function HousingGetVaultCodes(houseName)
  local rows = MySQL.Sync.fetchAll("SELECT vaultCodes FROM player_houses WHERE house = ?", { houseName })
  if rows[1] then
    return json.decode(rows[1].vaultCodes) or {}
  end
  return {}
end

RegisterServerCallback("housing:getVaultCodes", function(src, cb, houseName)
  cb(HousingGetVaultCodes(houseName))
end)


-- Set vault code
RegisterNetEvent("housing:setVaultCode", function(data)
  local src = source
  local codes = HousingGetVaultCodes(data.house)
  if #codes >= Config.MaxVaultCodes then
    Notification(src, i18n.t("vault_code.codes_full"), "error")
    return
  end
  table.insert(codes, { code = data.code, id = data.id })
  MySQL.Sync.execute("UPDATE player_houses SET vaultCodes = ? WHERE house = ?", { json.encode(codes), data.house })
  Notification(src, i18n.t("vault_code.added"), "success")
end)

-- Remove vault code
RegisterNetEvent("housing:removeVaultCode", function(data)
  local src = source
  local codes = HousingGetVaultCodes(data.house)
  for i = 1, #codes do
    if tostring(codes[i].id) == tostring(data.id) then
      table.remove(codes, i)
      MySQL.Sync.execute("UPDATE player_houses SET vaultCodes = ? WHERE house = ?", { json.encode(codes), data.house })
      Notification(src, i18n.t("vault_code.removed"), "success")
      return
    end
  end
  Notification(src, i18n.t("vault_code.not_found"), "error")
end)

-- Construction timer
if Config.Construction then
  CreateThread(function()
    while true do
      for _, obj in pairs(houseObjects) do
        if obj.construction then
          local elapsed = os.difftime(os.time(), obj.created)
          if elapsed >= obj.construction.duration then
            obj.construction = nil
            MySQL.Sync.execute("UPDATE house_objects SET construction = NULL WHERE id = ?", { obj.id })
            TriggerClientEvent("housing:updateHouseObject", -1, obj.id, obj)
            Debug("housing:construction", "Construction finished", obj.id)
          end
        end
      end
      Wait(2000)
    end
  end)
end


-- Show construction remaining time
RegisterNetEvent("housing:showConstructionRemaining", function(houseName)
  local src = source
  local obj = table.find(houseObjects, function(o) return o.house == houseName end)
  if not obj then
    Notification(src, i18n.t("construction.not_found"), "error")
    return
  end
  if not obj.construction then
    Notification(src, i18n.t("construction.finished"), "info")
    return
  end
  local elapsed = os.difftime(os.time(), obj.created)
  local remaining = obj.construction.duration - elapsed
  Notification(src, i18n.t("construction.remaining", { remaining = remaining }), "info")
end)

-- Handle buy house event (for external integrations)
AddEventHandler("housing:handleBuyHouse", function(playerSource, houseName, price, isCredit)
  Debug("housing:handleBuyHouse", "Buying house", "Source", playerSource, houseName, price, isCredit)
end)

-- Permission check
function HasPermission(playerSource)
  local jobName = GetJobName(playerSource)
  local jobGrade = GetJobGrade(playerSource)
  local isAdmin = PlayerIsAdmin(playerSource)

  if isAdmin and Config.AllowAdminsToCreateHouses then
    return true
  end

  for _, jobEntry in pairs(Config.CreatorJobs) do
    if jobEntry.job == jobName then
      if jobEntry.grade then
        if not table.contains(jobEntry.grade, jobGrade) then
          goto continue
        end
      end
      return true
    end
    ::continue::
  end
  return false
end

lib.callback.register("housing:hasPermission", function(source, data)
  return PlayerIsAdmin(source, data)
end)


-- Resource name verification
Citizen.CreateThread(function()
  local resourceName = GetCurrentResourceName()
  if "qs-housing" == resourceName then
    verify = true
  end
  if true ~= verify then
    repeat
      Citizen.Wait(3000)
      print("^1[ERROR]^0: You have renamed the script! ^4qs-housing^0 must not be renamed.")
      print("^3[WARNING]^0: If you rename the script, your console will freeze and you won\xE2\x80\x99t be able to access the game.")
      Citizen.Wait(5000)
      while true do end
    until true == verify
  end
end)

-- Initialize player names for nearby player list
function InitPlayersName(players)
  for idx, player in pairs(players) do
    local first, last = GetCharacterName(player.id)
    if not first or not last then
      first = ""
      last = ""
    end
    players[idx].name = first .. " " .. last
  end
  return players
end

-- Get nearby players
lib.callback.register("housing:getNearbyPlayers", function(source)
  local myPed = GetPlayerPed(source)
  local myCoords = GetEntityCoords(myPed)
  local nearby = {}

  for _, pid in pairs(GetPlayers()) do
    local otherPed = GetPlayerPed(pid)
    local otherCoords = GetEntityCoords(otherPed)
    local dist = #(myCoords - otherCoords)
    pid = tonumber(pid)
    if dist < 10.0 and pid ~= source then
      table.insert(nearby, { id = pid, distance = dist })
    end
  end

  table.sort(nearby, function(a, b) return a.distance < b.distance end)
  return InitPlayersName(nearby)
end)


-- Get player houses by source
function GetPlayerHouses(playerSource)
  local identifier = GetIdentifier(playerSource)
  local houses = {}
  local rows = MySQL.Sync.fetchAll("SELECT * FROM player_houses WHERE citizenid = ?", { identifier })
  if rows and rows[1] then
    for _, row in pairs(rows) do
      houses[#houses + 1] = row.house
    end
  end
  return houses
end

exports("GetPlayerHouses", GetPlayerHouses)

-- Get player properties by identifier (for GPS/maps)
function GetPlayerPropertiesByIdentifier(identifier)
  if not identifier then return {} end
  local properties = {}
  local rows = MySQL.Sync.fetchAll("SELECT house FROM player_houses WHERE citizenid = ?", { identifier })
  if not rows or not rows[1] then return properties end

  for _, row in pairs(rows) do
    local houseName = row.house
    local houseConfig = houseName and Config.Houses[houseName]
    local enterCoords = houseConfig and houseConfig.coords and houseConfig.coords.enter
    if enterCoords then
      properties[#properties + 1] = {
        house = houseName,
        label = houseConfig.address or houseName,
        address = houseConfig.address or houseName,
        coords = {
          x = enterCoords.x,
          y = enterCoords.y,
          z = enterCoords.z,
          h = enterCoords.h or enterCoords.w or 0.0,
        },
        image = houseConfig.image,
        description = houseConfig.description,
      }
    end
  end
  return properties
end

exports("GetPlayerPropertiesByIdentifier", GetPlayerPropertiesByIdentifier)


-- Clear player inside state by identifier (for logout/disconnect cleanup)
function ClearPlayerInsideByIdentifier(identifier)
  if not identifier then return false end
  if "esx" == Config.Framework then
    MySQL.Sync.execute("UPDATE users SET inside = NULL WHERE identifier = ?", { identifier })
    return true
  end
  -- QB framework
  local row = MySQL.single.await("SELECT metadata FROM players WHERE citizenid = ? LIMIT 1", { identifier })
  if not row then return false end
  local metadata = (row.metadata and json.decode(row.metadata)) or {}
  if "table" ~= type(metadata) then metadata = {} end
  metadata.currentHouseId = nil
  MySQL.Sync.execute("UPDATE players SET metadata = ? WHERE citizenid = ?", { json.encode(metadata), identifier })
  return true
end

exports("ClearPlayerInsideByIdentifier", ClearPlayerInsideByIdentifier)

-- Get apartment units (admin only)
function HousingGetApartmentUnits(source, houseName)
  if not PlayerIsAdmin(source) then return {} end
  return db.getApartmentUnits(houseName)
end

lib.callback.register("housing:getApartmentUnits", HousingGetApartmentUnits)

-- Update apartment shell (admin only)
function HousingUpdateApartmentShell(source, houseName, shellData)
  if not PlayerIsAdmin(source) then return false end
  return db.updateApartmentShell(houseName, shellData)
end

lib.callback.register("housing:updateApartmentShell", HousingUpdateApartmentShell)

-- Update apartment IPL (admin only)
function HousingUpdateApartmentIpl(source, houseName, iplData)
  if not PlayerIsAdmin(source) then return false end
  return db.updateApartmentIpl(houseName, iplData)
end

lib.callback.register("housing:updateApartmentIpl", HousingUpdateApartmentIpl)

-- Export: Get player inside house
exports("GetPlayerInsideHouse", function(playerSource)
  return GetPlayerInsideHouse(playerSource)
end)
