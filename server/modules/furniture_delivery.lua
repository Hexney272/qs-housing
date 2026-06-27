local DeliveryConfig = {}

function DeliveryConfig.isEnabled()
  return false ~= Config.IkeaDeliveryEnabled
end

function DeliveryConfig.getDelayMinutes()
  return Config.IkeaDeliveryDelayMinutes
end

function DeliveryConfig.getStatusCheckMs()
  local ms = tonumber(Config.IkeaDeliveryStatusCheckMs) or 15000
  return math.max(5000, ms)
end

local houseCache = {}
local collectingLock = {}

local function parseCoords(raw)
  if type(raw) ~= "table" then
    return nil
  end

  local x = tonumber(raw.x)
  local y = tonumber(raw.y)
  local z = tonumber(raw.z)

  if not (x and y) or not z then
    return nil
  end

  local result = { x = x, y = y, z = z }
  result.w = tonumber(raw.w) or 0.0
  return result
end

local function validateString(value)
  if type(value) ~= "string" or "" == value then
    return nil
  end
  return value
end

local AccessCheck = {}

function AccessCheck.canAccessHouse(source, houseName)
  local identifier = GetIdentifier(source)
  if not identifier then
    return false
  end
  return true == CheckHasKey(identifier, identifier, houseName, source)
end

function AccessCheck.isHouseOwner(source, houseName)
  local identifier = GetIdentifier(source)
  if not identifier then
    return false
  end

  local row = MySQL.single.await(
    "SELECT owner, citizenid FROM player_houses WHERE house = ? LIMIT 1",
    { houseName }
  )
  if not row then
    return false
  end

  return row.owner == identifier
end

local OrderRepo = {}

function OrderRepo.getReadyCount(houseName)
  local count, err = db.getReadyFurnitureOrderCount(houseName)
  local result = tonumber(count, err) or 0
  return math.max(0, result)
end

function OrderRepo.getReadyCounts(houseNames)
  return db.getReadyFurnitureOrderCounts(houseNames)
end

function OrderRepo.createOrder(source, houseName, orderData)
  local modelName = tostring(orderData.modelName or "")
  local price = tonumber(orderData.price) or 0
  local buyerIdentifier = tostring(GetIdentifier(source) or "")

  if "" == buyerIdentifier or "" == modelName or price <= 0 then
    return false
  end

  local balance = GetAccountMoney(source, Config.MoneyType)
  if price > balance then
    return false
  end

  RemoveAccountMoney(source, Config.MoneyType, price)

  local delaySeconds = DeliveryConfig.getDelayMinutes() * 60
  local deliverAt = tostring(os.date("%Y-%m-%d %H:%M:%S", os.time() + delaySeconds))

  local success = db.createFurnitureOrder({
    house = houseName,
    buyerIdentifier = buyerIdentifier,
    modelName = modelName,
    price = price,
    payload = { inStash = true, inHouse = false },
    deliverAt = deliverAt,
  })

  if not success then
    AddAccountMoney(source, Config.MoneyType, price)
    return false
  end

  return true
end

function OrderRepo.claimReadyOrders(houseName)
  return db.claimReadyFurnitureOrders(houseName)
end

function OrderRepo.revertOrders(orderIds, houseName)
  return db.revertFurnitureOrdersToReady(orderIds, houseName)
end

function OrderRepo.promotePendingOrders()
  return db.updateFurnitureOrdersToReady()
end

local HouseState = {}

function HouseState.ensure(houseName)
  local cached = houseCache[houseName]
  if cached then
    return cached
  end

  local houseConfig = Config.Houses[houseName]
  local deliveryCoords = nil
  if houseConfig then
    if type(houseConfig.coords) == "table" then
      deliveryCoords = houseConfig.coords.delivery
    end
  end

  local state = {
    point = parseCoords(deliveryCoords),
    readyCount = nil,
    lastUpdate = os.time(),
  }

  houseCache[houseName] = state
  return state
end

function HouseState.getHydrated(houseName)
  local state = HouseState.ensure(houseName)

  if nil == state.readyCount then
    state.readyCount = OrderRepo.getReadyCount(houseName)
    state.lastUpdate = os.time()
  end

  return state
end

function HouseState.setReadyCount(houseName, count)
  local state = HouseState.ensure(houseName)
  state.readyCount = math.max(0, tonumber(count) or 0)
  state.lastUpdate = os.time()
end

function HouseState.setPoint(houseName, coords)
  local state = HouseState.ensure(houseName)
  state.point = parseCoords(coords)
  state.lastUpdate = os.time()
end

local Notifier = {}

function Notifier.publishState(houseName, state)
  Debug("IkeaDeliveryNotifier.publishState", houseName, state)

  if state.point then
    local readyCount = state.readyCount or 0
    if readyCount > 0 then
      Debug("IkeaDeliveryNotifier.publishState.ready", houseName, state.readyCount, state.point)
      BroadcastToPlayersInHouseZone(houseName, "housing:ikeaDeliveryReady", houseName, state.readyCount, state.point)
      return
    end
  end

  Debug("IkeaDeliveryNotifier.publishState.collected", houseName)
  BroadcastToPlayersInHouseZone(houseName, "housing:ikeaDeliveryCollected", houseName)
end

local HousingIkeaDeliveryService = {}
_G.HousingIkeaDeliveryService = HousingIkeaDeliveryService

function HousingIkeaDeliveryService.createOrder(source, houseName, orderData)
  if not DeliveryConfig.isEnabled() then
    return false
  end

  if not orderData or type(orderData) ~= "table" then
    return false
  end

  local validHouse = validateString(houseName)
  if not validHouse then
    return false
  end

  if not AccessCheck.isHouseOwner(source, validHouse) then
    return false
  end

  if not OrderRepo.createOrder(source, validHouse, orderData) then
    return false
  end

  local resourceState = GetResourceState("qs-inventory")
  if resourceState:find("started") then
    if Config.EnableQuests then
      exports["qs-inventory"]:UpdateQuestProgress(source, "buy_furniture", 10)
    end
  end

  return true
end

function HousingIkeaDeliveryService.getState(source, houseName)
  if not DeliveryConfig.isEnabled() then
    return { enabled = false, readyCount = 0 }
  end

  local validHouse = validateString(houseName)
  if not validHouse then
    return { enabled = false, readyCount = 0 }
  end

  if not AccessCheck.canAccessHouse(source, validHouse) then
    return { enabled = true, readyCount = 0 }
  end

  local state = HouseState.getHydrated(validHouse)

  if not state.point then
    return {
      enabled = true,
      hasPoint = false,
      readyCount = state.readyCount or 0,
    }
  end

  return {
    enabled = true,
    hasPoint = true,
    readyCount = state.readyCount or 0,
    point = state.point,
  }
end

local function parseOrderToDecoration(orderRow)
  local payload
  if orderRow.payload_json then
    payload = json.decode(orderRow.payload_json)
    if not payload then
      payload = {}
    end
  else
    payload = {}
  end

  return {
    modelName = orderRow.model_name,
    price = orderRow.price,
    inStash = false ~= payload.inStash,
    inHouse = true == payload.inHouse,
    coords = vec3(0.0, 0.0, 0.0),
    rotation = vec3(0.0, 0.0, 0.0),
  }
end

function HousingIkeaDeliveryService.collectReadyOrders(source, houseName)
  if not DeliveryConfig.isEnabled() then
    return false
  end

  local validHouse = validateString(houseName)
  if not validHouse then
    return false
  end

  if not AccessCheck.canAccessHouse(source, validHouse) then
    return false
  end

  local state = HouseState.getHydrated(validHouse)
  if not state.point then
    return false
  end

  -- Prevent concurrent collection
  if collectingLock[validHouse] then
    return false
  end
  collectingLock[validHouse] = true

  local success, orders, orderIds = OrderRepo.claimReadyOrders(validHouse)
  if not success then
    collectingLock[validHouse] = nil
    return false
  end

  local decorations = {}
  for i = 1, #orders do
    decorations[#decorations + 1] = parseOrderToDecoration(orders[i])
  end

  local addResult = addDecorationBatchToHouse(source, validHouse, decorations)
  if not addResult then
    OrderRepo.revertOrders(orderIds, validHouse)
    collectingLock[validHouse] = nil
    return false
  end

  local newCount = OrderRepo.getReadyCount(validHouse)
  HouseState.setReadyCount(validHouse, newCount)
  Notifier.publishState(validHouse, HouseState.ensure(validHouse))

  collectingLock[validHouse] = nil
  return true
end

function HousingIkeaDeliveryService.syncDeliveryPoint(houseName, coords)
  local validHouse = validateString(houseName)
  if not validHouse then
    return
  end

  HouseState.setPoint(validHouse, coords)
  local state = HouseState.getHydrated(validHouse)
  Notifier.publishState(validHouse, state)
end

function HousingIkeaDeliveryService.processDueOrders()
  if not DeliveryConfig.isEnabled() then
    return
  end

  local promotedHouses = OrderRepo.promotePendingOrders()
  if #promotedHouses == 0 then
    return
  end

  local readyCounts = OrderRepo.getReadyCounts(promotedHouses)

  for i = 1, #promotedHouses do
    local houseName = promotedHouses[i]
    HouseState.setReadyCount(houseName, readyCounts[houseName] or 0)
    BroadcastToPlayersInHouseZone(houseName, "housing:playDoorbell", houseName)
    Notifier.publishState(houseName, HouseState.ensure(houseName))
  end
end

lib.callback.register("housing:createFurnitureOrder", function(source, houseName, orderData)
  return HousingIkeaDeliveryService.createOrder(source, houseName, orderData)
end)

lib.callback.register("housing:getIkeaDeliveryState", function(source, houseName)
  return HousingIkeaDeliveryService.getState(source, houseName)
end)

lib.callback.register("housing:collectIkeaFurnitureOrders", function(source, houseName)
  return HousingIkeaDeliveryService.collectReadyOrders(source, houseName)
end)

AddEventHandler("qb-houses:server:setLocation", function(coords, houseName, locationType)
  if 8 ~= locationType then
    return
  end
  HousingIkeaDeliveryService.syncDeliveryPoint(houseName, coords)
end)

AddEventHandler("housing:syncIkeaDeliveryPoint", function(houseName, coords)
  HousingIkeaDeliveryService.syncDeliveryPoint(houseName, coords)
end)

CreateThread(function()
  while true do
    Wait(DeliveryConfig.getStatusCheckMs())
    HousingIkeaDeliveryService.processDueOrders()
  end
end)
