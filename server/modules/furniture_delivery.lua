





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1
L0_1 = {}
function L1_1()
  local L0_2, L1_2
  L0_2 = Config
  L0_2 = L0_2.IkeaDeliveryEnabled
  L0_2 = false ~= L0_2
  return L0_2
end
L0_1.isEnabled = L1_1
function L1_1()
  local L0_2, L1_2
  L0_2 = Config
  L0_2 = L0_2.IkeaDeliveryDelayMinutes
  return L0_2
end
L0_1.getDelayMinutes = L1_1
function L1_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = math
  L0_2 = L0_2.max
  L1_2 = 5000
  L2_2 = tonumber
  L3_2 = Config
  L3_2 = L3_2.IkeaDeliveryStatusCheckMs
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = 15000
  end
  return L0_2(L1_2, L2_2)
end
L0_1.getStatusCheckMs = L1_1
L1_1 = {}
L2_1 = {}
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = type
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if "table" ~= L1_2 then
    L1_2 = nil
    return L1_2
  end
  L1_2 = tonumber
  L2_2 = A0_2.x
  L1_2 = L1_2(L2_2)
  L2_2 = tonumber
  L3_2 = A0_2.y
  L2_2 = L2_2(L3_2)
  L3_2 = tonumber
  L4_2 = A0_2.z
  L3_2 = L3_2(L4_2)
  if not (L1_2 and L2_2) or not L3_2 then
    L4_2 = nil
    return L4_2
  end
  L4_2 = {}
  L4_2.x = L1_2
  L4_2.y = L2_2
  L4_2.z = L3_2
  L5_2 = tonumber
  L6_2 = A0_2.w
  L5_2 = L5_2(L6_2)
  if not L5_2 then
    L5_2 = 0.0
  end
  L4_2.w = L5_2
  return L4_2
end
function L4_1(A0_2)
  local L1_2, L2_2
  L1_2 = type
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if "string" ~= L1_2 or "" == A0_2 then
    L1_2 = nil
    return L1_2
  end
  return A0_2
end
L5_1 = {}
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = GetIdentifier
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = CheckHasKey
  L4_2 = L2_2
  L5_2 = L2_2
  L6_2 = A1_2
  L7_2 = A0_2
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L3_2 = true == L3_2
  return L3_2
end
L5_1.canAccessHouse = L6_1
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = GetIdentifier
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = MySQL
  L3_2 = L3_2.single
  L3_2 = L3_2.await
  L4_2 = "SELECT owner, citizenid FROM player_houses WHERE house = ? LIMIT 1"
  L5_2 = {}
  L6_2 = A1_2
  L5_2[1] = L6_2
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L4_2 = false
    return L4_2
  end
  L4_2 = L3_2.owner
  L4_2 = L4_2 == L2_2
  return L4_2
end
L5_1.isHouseOwner = L6_1
L6_1 = {}
function L7_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = math
  L1_2 = L1_2.max
  L2_2 = 0
  L3_2 = tonumber
  L4_2 = db
  L4_2 = L4_2.getReadyFurnitureOrderCount
  L5_2 = A0_2
  L4_2, L5_2 = L4_2(L5_2)
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L3_2 = 0
  end
  return L1_2(L2_2, L3_2)
end
L6_1.getReadyCount = L7_1
function L7_1(A0_2)
  local L1_2, L2_2
  L1_2 = db
  L1_2 = L1_2.getReadyFurnitureOrderCounts
  L2_2 = A0_2
  return L1_2(L2_2)
end
L6_1.getReadyCounts = L7_1
function L7_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L3_2 = tostring
  L4_2 = A2_2.modelName
  if not L4_2 then
    L4_2 = ""
  end
  L3_2 = L3_2(L4_2)
  L4_2 = tonumber
  L5_2 = A2_2.price
  L4_2 = L4_2(L5_2)
  if not L4_2 then
    L4_2 = 0
  end
  L5_2 = tostring
  L6_2 = GetIdentifier
  L7_2 = A0_2
  L6_2 = L6_2(L7_2)
  if not L6_2 then
    L6_2 = ""
  end
  L5_2 = L5_2(L6_2)
  if "" == L5_2 or "" == L3_2 or L4_2 <= 0 then
    L6_2 = false
    return L6_2
  end
  L6_2 = GetAccountMoney
  L7_2 = A0_2
  L8_2 = Config
  L8_2 = L8_2.MoneyType
  L6_2 = L6_2(L7_2, L8_2)
  if L4_2 > L6_2 then
    L7_2 = false
    return L7_2
  end
  L7_2 = RemoveAccountMoney
  L8_2 = A0_2
  L9_2 = Config
  L9_2 = L9_2.MoneyType
  L10_2 = L4_2
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = L0_1.getDelayMinutes
  L7_2 = L7_2()
  L7_2 = L7_2 * 60
  L8_2 = tostring
  L9_2 = os
  L9_2 = L9_2.date
  L10_2 = "%Y-%m-%d %H:%M:%S"
  L11_2 = os
  L11_2 = L11_2.time
  L11_2 = L11_2()
  L11_2 = L11_2 + L7_2
  L9_2, L10_2, L11_2, L12_2, L13_2 = L9_2(L10_2, L11_2)
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
  L9_2 = db
  L9_2 = L9_2.createFurnitureOrder
  L10_2 = {}
  L10_2.house = A1_2
  L10_2.buyerIdentifier = L5_2
  L10_2.modelName = L3_2
  L10_2.price = L4_2
  L11_2 = {}
  L11_2.inStash = true
  L11_2.inHouse = false
  L10_2.payload = L11_2
  L10_2.deliverAt = L8_2
  L9_2 = L9_2(L10_2)
  if not L9_2 then
    L10_2 = AddAccountMoney
    L11_2 = A0_2
    L12_2 = Config
    L12_2 = L12_2.MoneyType
    L13_2 = L4_2
    L10_2(L11_2, L12_2, L13_2)
    L10_2 = false
    return L10_2
  end
  L10_2 = true
  return L10_2
end
L6_1.createOrder = L7_1
function L7_1(A0_2)
  local L1_2, L2_2
  L1_2 = db
  L1_2 = L1_2.claimReadyFurnitureOrders
  L2_2 = A0_2
  return L1_2(L2_2)
end
L6_1.claimReadyOrders = L7_1
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = db
  L2_2 = L2_2.revertFurnitureOrdersToReady
  L3_2 = A0_2
  L4_2 = A1_2
  return L2_2(L3_2, L4_2)
end
L6_1.revertOrders = L7_1
function L7_1()
  local L0_2, L1_2
  L0_2 = db
  L0_2 = L0_2.updateFurnitureOrdersToReady
  return L0_2()
end
L6_1.promotePendingOrders = L7_1
L7_1 = {}
function L8_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = L1_1
  L1_2 = L1_2[A0_2]
  if L1_2 then
    return L1_2
  end
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A0_2]
  L3_2 = nil
  if L2_2 then
    L4_2 = type
    L5_2 = L2_2.coords
    L4_2 = L4_2(L5_2)
    if "table" == L4_2 then
      L4_2 = L2_2.coords
      L3_2 = L4_2.delivery
    end
  end
  L4_2 = {}
  L5_2 = L3_1
  L6_2 = L3_2
  L5_2 = L5_2(L6_2)
  L4_2.point = L5_2
  L4_2.readyCount = nil
  L5_2 = os
  L5_2 = L5_2.time
  L5_2 = L5_2()
  L4_2.lastUpdate = L5_2
  L1_2 = L4_2
  L4_2 = L1_1
  L4_2[A0_2] = L1_2
  return L1_2
end
L7_1.ensure = L8_1
function L8_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = L7_1.ensure
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = L1_2.readyCount
  if nil == L2_2 then
    L2_2 = L6_1.getReadyCount
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L1_2.readyCount = L2_2
    L2_2 = os
    L2_2 = L2_2.time
    L2_2 = L2_2()
    L1_2.lastUpdate = L2_2
  end
  return L1_2
end
L7_1.getHydrated = L8_1
function L8_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = L7_1.ensure
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = math
  L3_2 = L3_2.max
  L4_2 = 0
  L5_2 = tonumber
  L6_2 = A1_2
  L5_2 = L5_2(L6_2)
  if not L5_2 then
    L5_2 = 0
  end
  L3_2 = L3_2(L4_2, L5_2)
  L2_2.readyCount = L3_2
  L3_2 = os
  L3_2 = L3_2.time
  L3_2 = L3_2()
  L2_2.lastUpdate = L3_2
end
L7_1.setReadyCount = L8_1
function L8_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L7_1.ensure
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = L3_1
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  L2_2.point = L3_2
  L3_2 = os
  L3_2 = L3_2.time
  L3_2 = L3_2()
  L2_2.lastUpdate = L3_2
end
L7_1.setPoint = L8_1
L8_1 = {}
function L9_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = Debug
  L3_2 = "IkeaDeliveryNotifier.publishState"
  L4_2 = A0_2
  L5_2 = A1_2
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = A1_2.point
  if L2_2 then
    L2_2 = A1_2.readyCount
    if not L2_2 then
      L2_2 = 0
    end
    if L2_2 > 0 then
      L2_2 = Debug
      L3_2 = "IkeaDeliveryNotifier.publishState.ready"
      L4_2 = A0_2
      L5_2 = A1_2.readyCount
      L6_2 = A1_2.point
      L2_2(L3_2, L4_2, L5_2, L6_2)
      L2_2 = BroadcastToPlayersInHouseZone
      L3_2 = A0_2
      L4_2 = "housing:ikeaDeliveryReady"
      L5_2 = A0_2
      L6_2 = A1_2.readyCount
      L7_2 = A1_2.point
      L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
      return
    end
  end
  L2_2 = Debug
  L3_2 = "IkeaDeliveryNotifier.publishState.collected"
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
  L2_2 = BroadcastToPlayersInHouseZone
  L3_2 = A0_2
  L4_2 = "housing:ikeaDeliveryCollected"
  L5_2 = A0_2
  L2_2(L3_2, L4_2, L5_2)
end
L8_1.publishState = L9_1
L9_1 = {}
L10_1 = _G
L10_1.HousingIkeaDeliveryService = L9_1
function L10_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = L0_1.isEnabled
  L3_2 = L3_2()
  if not L3_2 then
    L3_2 = false
    return L3_2
  end
  if A2_2 then
    L3_2 = type
    L4_2 = A2_2
    L3_2 = L3_2(L4_2)
    if "table" == L3_2 then
      goto lbl_16
    end
  end
  L3_2 = false
  do return L3_2 end
  ::lbl_16::
  L3_2 = L4_1
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L4_2 = false
    return L4_2
  end
  L4_2 = L5_1.isHouseOwner
  L5_2 = A0_2
  L6_2 = L3_2
  L4_2 = L4_2(L5_2, L6_2)
  if not L4_2 then
    L4_2 = false
    return L4_2
  end
  L4_2 = L6_1.createOrder
  L5_2 = A0_2
  L6_2 = L3_2
  L7_2 = A2_2
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  if not L4_2 then
    L5_2 = false
    return L5_2
  end
  L5_2 = GetResourceState
  L6_2 = "qs-inventory"
  L5_2 = L5_2(L6_2)
  L6_2 = L5_2
  L5_2 = L5_2.find
  L7_2 = "started"
  L5_2 = L5_2(L6_2, L7_2)
  if L5_2 then
    L5_2 = Config
    L5_2 = L5_2.EnableQuests
    if L5_2 then
      L5_2 = exports
      L5_2 = L5_2["qs-inventory"]
      L6_2 = L5_2
      L5_2 = L5_2.UpdateQuestProgress
      L7_2 = A0_2
      L8_2 = "buy_furniture"
      L9_2 = 10
      L5_2(L6_2, L7_2, L8_2, L9_2)
    end
  end
  L5_2 = true
  return L5_2
end
L9_1.createOrder = L10_1
function L10_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = L0_1.isEnabled
  L2_2 = L2_2()
  if not L2_2 then
    L2_2 = {}
    L2_2.enabled = false
    L2_2.readyCount = 0
    return L2_2
  end
  L2_2 = L4_1
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L3_2 = {}
    L3_2.enabled = false
    L3_2.readyCount = 0
    return L3_2
  end
  L3_2 = L5_1.canAccessHouse
  L4_2 = A0_2
  L5_2 = L2_2
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L3_2 = {}
    L3_2.enabled = true
    L3_2.readyCount = 0
    return L3_2
  end
  L3_2 = L7_1.getHydrated
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = L3_2.point
  if not L4_2 then
    L4_2 = {}
    L4_2.enabled = true
    L4_2.hasPoint = false
    L5_2 = L3_2.readyCount
    if not L5_2 then
      L5_2 = 0
    end
    L4_2.readyCount = L5_2
    return L4_2
  end
  L4_2 = {}
  L4_2.enabled = true
  L4_2.hasPoint = true
  L5_2 = L3_2.readyCount
  if not L5_2 then
    L5_2 = 0
  end
  L4_2.readyCount = L5_2
  L5_2 = L3_2.point
  L4_2.point = L5_2
  return L4_2
end
L9_1.getState = L10_1
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = A0_2.payload_json
  if L1_2 then
    L1_2 = json
    L1_2 = L1_2.decode
    L2_2 = A0_2.payload_json
    L1_2 = L1_2(L2_2)
    if L1_2 then
      goto lbl_12
    end
  end
  L1_2 = {}
  ::lbl_12::
  L2_2 = {}
  L3_2 = A0_2.model_name
  L2_2.modelName = L3_2
  L3_2 = A0_2.price
  L2_2.price = L3_2
  L3_2 = L1_2.inStash
  L3_2 = false ~= L3_2
  L2_2.inStash = L3_2
  L3_2 = L1_2.inHouse
  L3_2 = true == L3_2
  L2_2.inHouse = L3_2
  L3_2 = vec3
  L4_2 = 0.0
  L5_2 = 0.0
  L6_2 = 0.0
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L2_2.coords = L3_2
  L3_2 = vec3
  L4_2 = 0.0
  L5_2 = 0.0
  L6_2 = 0.0
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L2_2.rotation = L3_2
  return L2_2
end
function L11_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L2_2 = L0_1.isEnabled
  L2_2 = L2_2()
  if not L2_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = L4_1
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = L5_1.canAccessHouse
  L4_2 = A0_2
  L5_2 = L2_2
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = L7_1.getHydrated
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = L3_2.point
  if not L4_2 then
    L4_2 = false
    return L4_2
  end
  L4_2 = L2_1
  L4_2 = L4_2[L2_2]
  if L4_2 then
    L4_2 = false
    return L4_2
  end
  L4_2 = L2_1
  L4_2[L2_2] = true
  L4_2 = L6_1.claimReadyOrders
  L5_2 = L2_2
  L4_2, L5_2, L6_2 = L4_2(L5_2)
  if not L4_2 then
    L7_2 = L2_1
    L7_2[L2_2] = nil
    L7_2 = false
    return L7_2
  end
  L7_2 = {}
  L8_2 = 1
  L9_2 = #L5_2
  L10_2 = 1
  for L11_2 = L8_2, L9_2, L10_2 do
    L12_2 = #L7_2
    L12_2 = L12_2 + 1
    L13_2 = L10_1
    L14_2 = L5_2[L11_2]
    L13_2 = L13_2(L14_2)
    L7_2[L12_2] = L13_2
  end
  L8_2 = addDecorationBatchToHouse
  L9_2 = A0_2
  L10_2 = L2_2
  L11_2 = L7_2
  L8_2 = L8_2(L9_2, L10_2, L11_2)
  if not L8_2 then
    L9_2 = L6_1.revertOrders
    L10_2 = L6_2
    L11_2 = L2_2
    L9_2(L10_2, L11_2)
    L9_2 = L2_1
    L9_2[L2_2] = nil
    L9_2 = false
    return L9_2
  end
  L9_2 = L6_1.getReadyCount
  L10_2 = L2_2
  L9_2 = L9_2(L10_2)
  L10_2 = L7_1.setReadyCount
  L11_2 = L2_2
  L12_2 = L9_2
  L10_2(L11_2, L12_2)
  L10_2 = L8_1.publishState
  L11_2 = L2_2
  L12_2 = L7_1.ensure
  L13_2 = L2_2
  L12_2, L13_2, L14_2 = L12_2(L13_2)
  L10_2(L11_2, L12_2, L13_2, L14_2)
  L10_2 = L2_1
  L10_2[L2_2] = nil
  L10_2 = true
  return L10_2
end
L9_1.collectReadyOrders = L11_1
function L11_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = L4_1
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    return
  end
  L3_2 = L7_1.setPoint
  L4_2 = L2_2
  L5_2 = A1_2
  L3_2(L4_2, L5_2)
  L3_2 = L7_1.getHydrated
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = L8_1.publishState
  L5_2 = L2_2
  L6_2 = L3_2
  L4_2(L5_2, L6_2)
end
L9_1.syncDeliveryPoint = L11_1
function L11_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = L0_1.isEnabled
  L0_2 = L0_2()
  if not L0_2 then
    return
  end
  L0_2 = L6_1.promotePendingOrders
  L0_2 = L0_2()
  L1_2 = #L0_2
  if 0 == L1_2 then
    return
  end
  L1_2 = L6_1.getReadyCounts
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  L2_2 = 1
  L3_2 = #L0_2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = L0_2[L5_2]
    L7_2 = L7_1.setReadyCount
    L8_2 = L6_2
    L9_2 = L1_2[L6_2]
    if not L9_2 then
      L9_2 = 0
    end
    L7_2(L8_2, L9_2)
    L7_2 = BroadcastToPlayersInHouseZone
    L8_2 = L6_2
    L9_2 = "housing:playDoorbell"
    L10_2 = L6_2
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = L8_1.publishState
    L8_2 = L6_2
    L9_2 = L7_1.ensure
    L10_2 = L6_2
    L9_2, L10_2 = L9_2(L10_2)
    L7_2(L8_2, L9_2, L10_2)
  end
end
L9_1.processDueOrders = L11_1
L11_1 = lib
L11_1 = L11_1.callback
L11_1 = L11_1.register
L12_1 = "housing:createFurnitureOrder"
function L13_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = L9_1.createOrder
  L4_2 = A0_2
  L5_2 = A1_2
  L6_2 = A2_2
  return L3_2(L4_2, L5_2, L6_2)
end
L11_1(L12_1, L13_1)
L11_1 = lib
L11_1 = L11_1.callback
L11_1 = L11_1.register
L12_1 = "housing:getIkeaDeliveryState"
function L13_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L9_1.getState
  L3_2 = A0_2
  L4_2 = A1_2
  return L2_2(L3_2, L4_2)
end
L11_1(L12_1, L13_1)
L11_1 = lib
L11_1 = L11_1.callback
L11_1 = L11_1.register
L12_1 = "housing:collectIkeaFurnitureOrders"
function L13_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L9_1.collectReadyOrders
  L3_2 = A0_2
  L4_2 = A1_2
  return L2_2(L3_2, L4_2)
end
L11_1(L12_1, L13_1)
L11_1 = AddEventHandler
L12_1 = "qb-houses:server:setLocation"
function L13_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  if 8 ~= A2_2 then
    return
  end
  L3_2 = L9_1.syncDeliveryPoint
  L4_2 = A1_2
  L5_2 = A0_2
  L3_2(L4_2, L5_2)
end
L11_1(L12_1, L13_1)
L11_1 = AddEventHandler
L12_1 = "housing:syncIkeaDeliveryPoint"
function L13_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L9_1.syncDeliveryPoint
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
end
L11_1(L12_1, L13_1)
L11_1 = CreateThread
function L12_1()
  local L0_2, L1_2
  while true do
    L0_2 = Wait
    L1_2 = L0_1.getStatusCheckMs
    L1_2 = L1_2()
    L0_2(L1_2)
    L0_2 = L9_1.processDueOrders
    L0_2()
  end
end
L11_1(L12_1)






