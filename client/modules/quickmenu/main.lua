





local L0_1, L1_1, L2_1
L0_1 = _G
L1_1 = {}
L0_1.quickMenu = L1_1
L0_1 = quickMenu
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L1_2 = CurrentHouse
  if not L1_2 then
    return
  end
  L1_2 = Config
  L1_2 = L1_2.Houses
  L2_2 = CurrentHouse
  L1_2 = L1_2[L2_2]
  if not L1_2 then
    return
  end
  L2_2 = CurrentHouseData
  L2_2 = L2_2.haskey
  if not L2_2 then
    L2_2 = false
  end
  L3_2 = GetCameras
  L3_2 = L3_2()
  L4_2 = #L3_2
  L4_2 = L4_2 > 0
  L5_2 = {}
  L6_2 = 0
  L7_2 = false
  L8_2 = Config
  L8_2 = L8_2.DeliveriesEnabled
  if L8_2 then
    L8_2 = common
    L9_2 = L8_2
    L8_2 = L8_2.getDeliveries
    L8_2 = L8_2(L9_2)
    L9_2 = ipairs
    L10_2 = L8_2.pending
    L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
    for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
      L15_2 = L14_2.status
      if "delivered" == L15_2 then
        L6_2 = L6_2 + 1
        L15_2 = table
        L15_2 = L15_2.insert
        L16_2 = L5_2
        L17_2 = L14_2
        L15_2(L16_2, L17_2)
      end
    end
    L7_2 = L6_2 > 0
  end
  L8_2 = {}
  L9_2 = 0
  L10_2 = false
  L11_2 = Config
  L11_2 = L11_2.DancersEnabled
  if L11_2 then
    L11_2 = common
    L12_2 = L11_2
    L11_2 = L11_2.getDancers
    L11_2 = L11_2(L12_2)
    L12_2 = ipairs
    L13_2 = L11_2.pending
    L12_2, L13_2, L14_2, L15_2 = L12_2(L13_2)
    for L16_2, L17_2 in L12_2, L13_2, L14_2, L15_2 do
      L18_2 = L17_2.status
      if "delivered" == L18_2 then
        L9_2 = L9_2 + 1
        L18_2 = table
        L18_2 = L18_2.insert
        L19_2 = L8_2
        L20_2 = L17_2
        L18_2(L19_2, L20_2)
      end
    end
    L10_2 = L9_2 > 0
  end
  L11_2 = lib
  L11_2 = L11_2.callback
  L11_2 = L11_2.await
  L12_2 = "housing:getDoorbellPlayers"
  L13_2 = false
  L14_2 = CurrentHouse
  L11_2 = L11_2(L12_2, L13_2, L14_2)
  L12_2 = lib
  L12_2 = L12_2.callback
  L12_2 = L12_2.await
  L13_2 = "housing:getLightsStatus"
  L14_2 = false
  L15_2 = CurrentHouse
  L12_2 = L12_2(L13_2, L14_2, L15_2)
  L13_2 = L1_2.mlo
  L14_2 = SendReactMessage
  L15_2 = "toggle_quick_menu"
  L16_2 = {}
  L16_2.visible = true
  L17_2 = CurrentHouse
  L16_2.name = L17_2
  L17_2 = L1_2.address
  L16_2.address = L17_2
  L17_2 = L1_2.locked
  if not L17_2 then
    L17_2 = false
  end
  L16_2.locked = L17_2
  L16_2.hasCamera = L4_2
  L17_2 = Config
  L17_2 = L17_2.DeliveriesEnabled
  L16_2.deliveriesEnabled = L17_2
  L17_2 = Config
  L17_2 = L17_2.DancersEnabled
  L16_2.dancersEnabled = L17_2
  L16_2.hasDeliveries = L7_2
  L16_2.deliveryCount = L6_2
  L16_2.deliveredDeliveries = L5_2
  L16_2.hasDancers = L10_2
  L16_2.dancerCount = L9_2
  L16_2.deliveredDancers = L8_2
  L17_2 = L11_2 or L17_2
  if not L11_2 then
    L17_2 = {}
  end
  L16_2.doorbellPlayers = L17_2
  L16_2.hasKey = L2_2
  L16_2.isMlo = L13_2
  L17_2 = L12_2 or L17_2
  if not L12_2 then
    L17_2 = false
  end
  L16_2.lightsOn = L17_2
  L14_2(L15_2, L16_2)
  L14_2 = SetNuiFocus
  L15_2 = true
  L16_2 = true
  L14_2(L15_2, L16_2)
end
L0_1.open = L1_1
L0_1 = quickMenu
function L1_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SendReactMessage
  L2_2 = "toggle_quick_menu"
  L3_2 = {}
  L3_2.visible = false
  L1_2(L2_2, L3_2)
  L1_2 = SetNuiFocus
  L2_2 = false
  L3_2 = false
  L1_2(L2_2, L3_2)
end
L0_1.close = L1_1
L0_1 = RegisterNUICallback
L1_1 = "quick_menu:toggle_lock"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = TriggerEvent
  L3_2 = "qb-houses:client:toggleDoorlock"
  L2_2(L3_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "quick_menu:toggle_lights"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = CurrentHouse
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = nil
    return L2_2(L3_2)
  end
  L2_2 = lib
  L2_2 = L2_2.callback
  L3_2 = "housing:toggleLights"
  L4_2 = false
  function L5_2(A0_3)
    local L1_3, L2_3
    if nil ~= A0_3 then
      L1_3 = CurrentHouseData
      L1_3.lightsOn = A0_3
      L1_3 = quickMenu
      L2_3 = L1_3
      L1_3 = L1_3.open
      L1_3(L2_3)
    end
    L1_3 = A1_2
    L2_3 = A0_3
    L1_3(L2_3)
  end
  L6_2 = CurrentHouse
  L2_2(L3_2, L4_2, L5_2, L6_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "front_door_camera"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L3_2 = EnteredHouse
  L2_2 = L2_2[L3_2]
  if not L2_2 then
    L3_2 = A1_2
    L4_2 = "error"
    return L3_2(L4_2)
  end
  L3_2 = FrontDoorCam
  L4_2 = vec3
  L5_2 = L2_2.coords
  L5_2 = L5_2.enter
  L5_2 = L5_2.x
  L6_2 = L2_2.coords
  L6_2 = L6_2.enter
  L6_2 = L6_2.y
  L7_2 = L2_2.coords
  L7_2 = L7_2.enter
  L7_2 = L7_2.z
  L7_2 = L7_2 + 1.0
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2, L6_2, L7_2)
  L3_2(L4_2, L5_2, L6_2, L7_2)
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "quick_menu:deliveries"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L2_2 = Config
  L2_2 = L2_2.DeliveriesEnabled
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = "ok"
    return L2_2(L3_2)
  end
  L2_2 = common
  L3_2 = L2_2
  L2_2 = L2_2.getDeliveries
  L2_2 = L2_2(L3_2)
  L3_2 = {}
  L4_2 = ipairs
  L5_2 = L2_2.pending
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = L9_2.status
    if "delivered" == L10_2 then
      L10_2 = table
      L10_2 = L10_2.insert
      L11_2 = L3_2
      L12_2 = L9_2
      L10_2(L11_2, L12_2)
    end
  end
  L4_2 = #L3_2
  if 0 == L4_2 then
    L4_2 = Notification
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "delivery.no_delivered_orders"
    L5_2 = L5_2(L6_2)
    L6_2 = "info"
    L4_2(L5_2, L6_2)
    L4_2 = A1_2
    L5_2 = "ok"
    return L4_2(L5_2)
  end
  L4_2 = CurrentHouseData
  L4_2 = L4_2.haskey
  if not L4_2 then
    L4_2 = false
  end
  L5_2 = lib
  L5_2 = L5_2.callback
  L5_2 = L5_2.await
  L6_2 = "housing:getDoorbellPlayers"
  L7_2 = false
  L8_2 = CurrentHouse
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L6_2 = Config
  L6_2 = L6_2.Houses
  L7_2 = CurrentHouse
  L6_2 = L6_2[L7_2]
  L7_2 = common
  L8_2 = L7_2
  L7_2 = L7_2.getDancers
  L7_2 = L7_2(L8_2)
  L8_2 = {}
  L9_2 = ipairs
  L10_2 = L7_2.pending
  L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
  for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
    L15_2 = L14_2.status
    if "delivered" == L15_2 then
      L15_2 = table
      L15_2 = L15_2.insert
      L16_2 = L8_2
      L17_2 = L14_2
      L15_2(L16_2, L17_2)
    end
  end
  L9_2 = lib
  L9_2 = L9_2.callback
  L9_2 = L9_2.await
  L10_2 = "housing:getLightsStatus"
  L11_2 = false
  L12_2 = CurrentHouse
  L9_2 = L9_2(L10_2, L11_2, L12_2)
  L10_2 = SendReactMessage
  L11_2 = "toggle_quick_menu"
  L12_2 = {}
  L12_2.visible = true
  L13_2 = CurrentHouse
  L12_2.name = L13_2
  L13_2 = L6_2.address
  L12_2.address = L13_2
  L13_2 = L6_2.locked
  if not L13_2 then
    L13_2 = false
  end
  L12_2.locked = L13_2
  L13_2 = GetCameras
  L13_2 = L13_2()
  L13_2 = #L13_2
  L13_2 = L13_2 > 0
  L12_2.hasCamera = L13_2
  L13_2 = Config
  L13_2 = L13_2.DeliveriesEnabled
  L12_2.deliveriesEnabled = L13_2
  L13_2 = Config
  L13_2 = L13_2.DancersEnabled
  L12_2.dancersEnabled = L13_2
  L12_2.hasDeliveries = true
  L13_2 = #L3_2
  L12_2.deliveryCount = L13_2
  L12_2.deliveredDeliveries = L3_2
  L13_2 = #L8_2
  L13_2 = L13_2 > 0
  L12_2.hasDancers = L13_2
  L13_2 = #L8_2
  L12_2.dancerCount = L13_2
  L12_2.deliveredDancers = L8_2
  L13_2 = L5_2 or L13_2
  if not L5_2 then
    L13_2 = {}
  end
  L12_2.doorbellPlayers = L13_2
  L12_2.hasKey = L4_2
  L13_2 = L6_2.mlo
  L12_2.isMlo = L13_2
  L13_2 = L9_2 or L13_2
  if not L9_2 then
    L13_2 = false
  end
  L12_2.lightsOn = L13_2
  L10_2(L11_2, L12_2)
  L10_2 = A1_2
  L11_2 = "ok"
  L10_2(L11_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "quick_menu:collect_delivery"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = Config
  L2_2 = L2_2.DeliveriesEnabled
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = false
    return L2_2(L3_2)
  end
  L2_2 = lib
  L2_2 = L2_2.callback
  L3_2 = "housing:collectDelivery"
  L4_2 = false
  function L5_2(A0_3)
    local L1_3, L2_3, L3_3
    if A0_3 then
      L1_3 = Notification
      L2_3 = i18n
      L2_3 = L2_3.t
      L3_3 = "delivery.collected"
      L2_3 = L2_3(L3_3)
      L3_3 = "success"
      L1_3(L2_3, L3_3)
      L1_3 = quickMenu
      L2_3 = L1_3
      L1_3 = L1_3.open
      L1_3(L2_3)
    else
      L1_3 = Notification
      L2_3 = i18n
      L2_3 = L2_3.t
      L3_3 = "no_permission"
      L2_3 = L2_3(L3_3)
      L3_3 = "error"
      L1_3(L2_3, L3_3)
    end
    L1_3 = A1_2
    L2_3 = A0_3
    L1_3(L2_3)
  end
  L6_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "quick_menu:leave"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L3_2 = EnteredHouse
  L2_2 = L2_2[L3_2]
  L3_2 = quickMenu
  L4_2 = L3_2
  L3_2 = L3_2.close
  L3_2(L4_2)
  if L2_2 then
    L3_2 = L2_2.ipl
    if L3_2 then
      L3_2 = LeaveIplHouse
      L4_2 = EnteredHouse
      L5_2 = inOwned
      L3_2(L4_2, L5_2)
  end
  else
    L3_2 = LeaveHouse
    L3_2()
  end
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "quick_menu:invite_player"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = EnteredHouse
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = "error"
    return L2_2(L3_2)
  end
  L2_2 = TriggerServerEvent
  L3_2 = "qb-houses:server:OpenDoor"
  L4_2 = A0_2
  L5_2 = EnteredHouse
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "quick_menu:dancers"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L2_2 = Config
  L2_2 = L2_2.DancersEnabled
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = "ok"
    return L2_2(L3_2)
  end
  L2_2 = common
  L3_2 = L2_2
  L2_2 = L2_2.getDancers
  L2_2 = L2_2(L3_2)
  L3_2 = {}
  L4_2 = ipairs
  L5_2 = L2_2.pending
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = L9_2.status
    if "delivered" == L10_2 then
      L10_2 = table
      L10_2 = L10_2.insert
      L11_2 = L3_2
      L12_2 = L9_2
      L10_2(L11_2, L12_2)
    end
  end
  L4_2 = #L3_2
  if 0 == L4_2 then
    L4_2 = Notification
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "dancers.no_delivered_orders"
    L5_2 = L5_2(L6_2)
    L6_2 = "info"
    L4_2(L5_2, L6_2)
    L4_2 = A1_2
    L5_2 = "ok"
    return L4_2(L5_2)
  end
  L4_2 = CurrentHouseData
  L4_2 = L4_2.haskey
  if not L4_2 then
    L4_2 = false
  end
  L5_2 = lib
  L5_2 = L5_2.callback
  L5_2 = L5_2.await
  L6_2 = "housing:getDoorbellPlayers"
  L7_2 = false
  L8_2 = CurrentHouse
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L6_2 = Config
  L6_2 = L6_2.Houses
  L7_2 = CurrentHouse
  L6_2 = L6_2[L7_2]
  L7_2 = common
  L8_2 = L7_2
  L7_2 = L7_2.getDeliveries
  L7_2 = L7_2(L8_2)
  L8_2 = {}
  L9_2 = ipairs
  L10_2 = L7_2.pending
  L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
  for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
    L15_2 = L14_2.status
    if "delivered" == L15_2 then
      L15_2 = table
      L15_2 = L15_2.insert
      L16_2 = L8_2
      L17_2 = L14_2
      L15_2(L16_2, L17_2)
    end
  end
  L9_2 = lib
  L9_2 = L9_2.callback
  L9_2 = L9_2.await
  L10_2 = "housing:getLightsStatus"
  L11_2 = false
  L12_2 = CurrentHouse
  L9_2 = L9_2(L10_2, L11_2, L12_2)
  L10_2 = SendReactMessage
  L11_2 = "toggle_quick_menu"
  L12_2 = {}
  L12_2.visible = true
  L13_2 = CurrentHouse
  L12_2.name = L13_2
  L13_2 = L6_2.address
  L12_2.address = L13_2
  L13_2 = L6_2.locked
  if not L13_2 then
    L13_2 = false
  end
  L12_2.locked = L13_2
  L13_2 = GetCameras
  L13_2 = L13_2()
  L13_2 = #L13_2
  L13_2 = L13_2 > 0
  L12_2.hasCamera = L13_2
  L13_2 = Config
  L13_2 = L13_2.DeliveriesEnabled
  L12_2.deliveriesEnabled = L13_2
  L13_2 = Config
  L13_2 = L13_2.DancersEnabled
  L12_2.dancersEnabled = L13_2
  L13_2 = #L8_2
  L13_2 = L13_2 > 0
  L12_2.hasDeliveries = L13_2
  L13_2 = #L8_2
  L12_2.deliveryCount = L13_2
  L12_2.deliveredDeliveries = L8_2
  L12_2.hasDancers = true
  L13_2 = #L3_2
  L12_2.dancerCount = L13_2
  L12_2.deliveredDancers = L3_2
  L13_2 = L5_2 or L13_2
  if not L5_2 then
    L13_2 = {}
  end
  L12_2.doorbellPlayers = L13_2
  L12_2.hasKey = L4_2
  L13_2 = L6_2.mlo
  L12_2.isMlo = L13_2
  L13_2 = L9_2 or L13_2
  if not L9_2 then
    L13_2 = false
  end
  L12_2.lightsOn = L13_2
  L10_2(L11_2, L12_2)
  L10_2 = A1_2
  L11_2 = "ok"
  L10_2(L11_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "quick_menu:place_dancer"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = Config
  L2_2 = L2_2.DancersEnabled
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = "error"
    return L2_2(L3_2)
  end
  L2_2 = A0_2.dancerId
  L3_2 = CurrentHouse
  if not L3_2 then
    L3_2 = A1_2
    L4_2 = "error"
    return L3_2(L4_2)
  end
  L3_2 = common
  L4_2 = L3_2
  L3_2 = L3_2.getDancers
  L3_2 = L3_2(L4_2)
  L4_2 = nil
  L5_2 = ipairs
  L6_2 = L3_2.pending
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = L10_2.id
    if L11_2 == L2_2 then
      L11_2 = L10_2.status
      if "delivered" == L11_2 then
        L4_2 = L10_2
        break
      end
    end
  end
  if not L4_2 then
    L5_2 = Notification
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "dancers.not_found"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    L5_2(L6_2, L7_2)
    L5_2 = A1_2
    L6_2 = "error"
    return L5_2(L6_2)
  end
  L5_2 = creator
  L6_2 = L5_2
  L5_2 = L5_2.spawnTempEntities
  L5_2(L6_2)
  L5_2 = creator
  L6_2 = L5_2
  L5_2 = L5_2.selectPoint
  L7_2 = "ped"
  L8_2 = 1
  L9_2 = {}
  L10_2 = L4_2.pedModel
  L9_2.model = L10_2
  L10_2 = {}
  L11_2 = L4_2.pedModel
  L10_2.model = L11_2
  L11_2 = L4_2.anim
  L10_2.anim = L11_2
  L9_2.ped = L10_2
  L9_2.externalUsage = true
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L6_2 = creator
  L7_2 = L6_2
  L6_2 = L6_2.destroyTempEntities
  L6_2(L7_2)
  if L5_2 then
    L6_2 = L5_2[1]
    if L6_2 then
      goto lbl_88
    end
  end
  L6_2 = Notification
  L7_2 = i18n
  L7_2 = L7_2.t
  L8_2 = "dancers.placement_cancelled"
  L7_2 = L7_2(L8_2)
  L8_2 = "info"
  L6_2(L7_2, L8_2)
  L6_2 = A1_2
  L7_2 = "cancelled"
  do return L6_2(L7_2) end
  ::lbl_88::
  L6_2 = L5_2[1]
  L7_2 = {}
  L8_2 = L6_2.x
  L7_2.x = L8_2
  L8_2 = L6_2.y
  L7_2.y = L8_2
  L8_2 = L6_2.z
  L7_2.z = L8_2
  L8_2 = L6_2.w
  if not L8_2 then
    L8_2 = 0.0
  end
  L7_2.w = L8_2
  L8_2 = lib
  L8_2 = L8_2.callback
  L9_2 = "housing:placeDancer"
  L10_2 = false
  function L11_2(A0_3)
    local L1_3, L2_3, L3_3
    if A0_3 then
      L1_3 = Notification
      L2_3 = i18n
      L2_3 = L2_3.t
      L3_3 = "dancers.placed"
      L2_3 = L2_3(L3_3)
      L3_3 = "success"
      L1_3(L2_3, L3_3)
    else
      L1_3 = Notification
      L2_3 = i18n
      L2_3 = L2_3.t
      L3_3 = "dancers.place_failed"
      L2_3 = L2_3(L3_3)
      L3_3 = "error"
      L1_3(L2_3, L3_3)
    end
    L1_3 = A1_2
    L2_3 = A0_3
    L1_3(L2_3)
  end
  L12_2 = L2_2
  L13_2 = L7_2
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
end
L0_1(L1_1, L2_1)






