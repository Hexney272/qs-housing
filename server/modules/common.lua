





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1
L0_1 = _G
L1_1 = {}
L0_1.sv_common = L1_1
L0_1 = {}
L1_1 = 0
function L2_1()
  local L0_2, L1_2
  L0_2 = L1_1
  L0_2 = L0_2 + 1
  L1_1 = L0_2
  L0_2 = L1_1
  return L0_2
end
L3_1 = sv_common
function L4_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  if not A2_2 then
    L3_2 = {}
    return L3_2
  end
  L3_2 = L0_1
  L3_2 = L3_2[A2_2]
  if not L3_2 then
    L3_2 = {}
  end
  L4_2 = {}
  L5_2 = ipairs
  L6_2 = L3_2
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = table
    L11_2 = L11_2.insert
    L12_2 = L4_2
    L13_2 = {}
    L14_2 = L10_2.id
    L13_2.id = L14_2
    L14_2 = L10_2.title
    L13_2.title = L14_2
    L14_2 = L10_2.pedModel
    L13_2.pedModel = L14_2
    L14_2 = L10_2.anim
    L13_2.anim = L14_2
    L14_2 = L10_2.orderedAt
    L13_2.orderedAt = L14_2
    L14_2 = L10_2.status
    L13_2.status = L14_2
    L14_2 = L10_2.deliveryTime
    L13_2.deliveryTime = L14_2
    L14_2 = L10_2.coords
    L13_2.coords = L14_2
    L11_2(L12_2, L13_2)
  end
  return L4_2
end
L3_1.getDancers = L4_1
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = ipairs
  L2_2 = Config
  L2_2 = L2_2.Dancers
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = L6_2.title
    if L7_2 == A0_2 then
      L7_2 = L6_2.deliveryTime
      if L7_2 then
        L7_2 = type
        L8_2 = L6_2.deliveryTime
        L7_2 = L7_2(L8_2)
        if "number" == L7_2 then
          L7_2 = L6_2.deliveryTime
          do return L7_2 end
          break
        end
        L7_2 = type
        L8_2 = L6_2.deliveryTime
        L7_2 = L7_2(L8_2)
        if "table" == L7_2 then
          L7_2 = L6_2.deliveryTime
          L7_2 = L7_2.min
          if L7_2 then
            L7_2 = L6_2.deliveryTime
            L7_2 = L7_2.max
            if L7_2 then
              L7_2 = math
              L7_2 = L7_2.random
              L8_2 = L6_2.deliveryTime
              L8_2 = L8_2.min
              L9_2 = L6_2.deliveryTime
              L9_2 = L9_2.max
              L7_2, L8_2, L9_2 = L7_2(L8_2, L9_2)
              return L7_2, L8_2, L9_2
            end
          end
        end
      end
      break
    end
  end
  L1_2 = math
  L1_2 = L1_2.random
  L2_2 = 5
  L3_2 = 10
  return L1_2(L2_2, L3_2)
end
L4_1 = sv_common
function L5_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  if not (A2_2 and A3_2) or not A4_2 then
    L5_2 = false
    return L5_2
  end
  L5_2 = GetAccountMoney
  L6_2 = A1_2
  L7_2 = "bank"
  L5_2 = L5_2(L6_2, L7_2)
  if A4_2 > L5_2 then
    L6_2 = false
    return L6_2
  end
  L6_2 = RemoveAccountMoney
  L7_2 = A1_2
  L8_2 = "bank"
  L9_2 = A4_2
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = L3_1
  L7_2 = A3_2
  L6_2 = L6_2(L7_2)
  L7_2 = os
  L7_2 = L7_2.time
  L7_2 = L7_2()
  L8_2 = L6_2 * 60
  L7_2 = L7_2 + L8_2
  L8_2 = os
  L8_2 = L8_2.date
  L9_2 = "%Y-%m-%d %H:%M:%S"
  L8_2 = L8_2(L9_2)
  L9_2 = L2_1
  L9_2 = L9_2()
  L10_2 = nil
  L11_2 = ipairs
  L12_2 = Config
  L12_2 = L12_2.Dancers
  L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2)
  for L15_2, L16_2 in L11_2, L12_2, L13_2, L14_2 do
    L17_2 = L16_2.title
    if L17_2 == A3_2 then
      L10_2 = L16_2
      break
    end
  end
  if not L10_2 then
    L11_2 = false
    return L11_2
  end
  L11_2 = L0_1
  L11_2 = L11_2[A2_2]
  if not L11_2 then
    L11_2 = L0_1
    L12_2 = {}
    L11_2[A2_2] = L12_2
  end
  L11_2 = {}
  L11_2.id = L9_2
  L11_2.title = A3_2
  L12_2 = L10_2.pedModel
  L11_2.pedModel = L12_2
  L12_2 = L10_2.anim
  L11_2.anim = L12_2
  L12_2 = L10_2.time
  L11_2.time = L12_2
  L11_2.orderedAt = L8_2
  L11_2.status = "pending"
  L11_2.deliveryTime = L7_2
  L11_2.house = A2_2
  L11_2.coords = nil
  L12_2 = table
  L12_2 = L12_2.insert
  L13_2 = L0_1
  L13_2 = L13_2[A2_2]
  L14_2 = L11_2
  L12_2(L13_2, L14_2)
  L12_2 = SetTimeout
  L13_2 = L6_2 * 60
  L13_2 = L13_2 * 1000
  function L14_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    L1_3 = A2_2
    L0_3 = L0_1
    L0_3 = L0_3[L1_3]
    if L0_3 then
      L0_3 = ipairs
      L2_3 = A2_2
      L1_3 = L0_1
      L1_3 = L1_3[L2_3]
      L0_3, L1_3, L2_3, L3_3 = L0_3(L1_3)
      for L4_3, L5_3 in L0_3, L1_3, L2_3, L3_3 do
        L6_3 = L5_3.id
        L7_3 = L9_2
        if L6_3 == L7_3 then
          L5_3.status = "delivered"
          break
        end
      end
    end
    L0_3 = TriggerClientEvent
    L1_3 = "housing:playDoorbell"
    L2_3 = -1
    L3_3 = A2_2
    L0_3(L1_3, L2_3, L3_3)
  end
  L12_2(L13_2, L14_2)
  L12_2 = true
  return L12_2
end
L4_1.orderDancer = L5_1
L4_1 = sv_common
function L5_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if not A2_2 or not A3_2 then
    L4_2 = false
    return L4_2
  end
  L4_2 = nil
  L5_2 = nil
  L6_2 = pairs
  L7_2 = L0_1
  L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
  for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
    L12_2 = pairs
    L13_2 = L11_2
    L12_2, L13_2, L14_2, L15_2 = L12_2(L13_2)
    for L16_2, L17_2 in L12_2, L13_2, L14_2, L15_2 do
      L18_2 = L17_2.id
      if L18_2 == A2_2 then
        L18_2 = L17_2.status
        if "delivered" == L18_2 then
          L4_2 = L17_2
          L5_2 = L10_2
          break
        end
      end
    end
    if L4_2 then
      break
    end
  end
  if not L4_2 then
    L6_2 = false
    return L6_2
  end
  L4_2.coords = A3_2
  L4_2.status = "placed"
  L6_2 = L4_2.time
  if L6_2 then
    L6_2 = SetTimeout
    L7_2 = L4_2.time
    function L8_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3
      L1_3 = L5_2
      L0_3 = L0_1
      L0_3 = L0_3[L1_3]
      if L0_3 then
        L0_3 = pairs
        L2_3 = L5_2
        L1_3 = L0_1
        L1_3 = L1_3[L2_3]
        L0_3, L1_3, L2_3, L3_3 = L0_3(L1_3)
        for L4_3, L5_3 in L0_3, L1_3, L2_3, L3_3 do
          L6_3 = L5_3.id
          L7_3 = A2_2
          if L6_3 == L7_3 then
            L6_3 = table
            L6_3 = L6_3.remove
            L8_3 = L5_2
            L7_3 = L0_1
            L7_3 = L7_3[L8_3]
            L8_3 = L4_3
            L6_3(L7_3, L8_3)
            break
          end
        end
        L1_3 = L5_2
        L0_3 = L0_1
        L0_3 = L0_3[L1_3]
        if L0_3 then
          L1_3 = L5_2
          L0_3 = L0_1
          L0_3 = L0_3[L1_3]
          L0_3 = #L0_3
          if 0 == L0_3 then
            L1_3 = L5_2
            L0_3 = L0_1
            L0_3[L1_3] = nil
          end
        end
        L0_3 = TriggerClientEvent
        L1_3 = "housing:removeDancer"
        L2_3 = A1_2
        L3_3 = L5_2
        L4_3 = A2_2
        L0_3(L1_3, L2_3, L3_3, L4_3)
      end
    end
    L6_2(L7_2, L8_2)
  end
  L6_2 = TriggerClientEvent
  L7_2 = "housing:spawnDancer"
  L8_2 = A1_2
  L9_2 = L4_2
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = true
  return L6_2
end
L4_1.placeDancer = L5_1
L4_1 = sv_common
function L5_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  if not A2_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = nil
  L4_2 = nil
  L5_2 = pairs
  L6_2 = L0_1
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = pairs
    L12_2 = L10_2
    L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2)
    for L15_2, L16_2 in L11_2, L12_2, L13_2, L14_2 do
      L17_2 = L16_2.id
      if L17_2 == A2_2 then
        L3_2 = L16_2
        L4_2 = L9_2
        break
      end
    end
    if L3_2 then
      break
    end
  end
  if not L3_2 then
    L5_2 = false
    return L5_2
  end
  if L4_2 then
    L5_2 = L0_1
    L5_2 = L5_2[L4_2]
    if L5_2 then
      L5_2 = pairs
      L6_2 = L0_1
      L6_2 = L6_2[L4_2]
      L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
      for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
        L11_2 = L10_2.id
        if L11_2 == A2_2 then
          L11_2 = table
          L11_2 = L11_2.remove
          L12_2 = L0_1
          L12_2 = L12_2[L4_2]
          L13_2 = L9_2
          L11_2(L12_2, L13_2)
          break
        end
      end
      L5_2 = L0_1
      L5_2 = L5_2[L4_2]
      L5_2 = #L5_2
      if 0 == L5_2 then
        L5_2 = L0_1
        L5_2[L4_2] = nil
      end
      L5_2 = TriggerClientEvent
      L6_2 = "housing:removeDancer"
      L7_2 = A1_2
      L8_2 = L4_2
      L9_2 = A2_2
      L5_2(L6_2, L7_2, L8_2, L9_2)
    end
  end
  L5_2 = true
  return L5_2
end
L4_1.removeDancer = L5_1
L4_1 = lib
L4_1 = L4_1.callback
L4_1 = L4_1.register
L5_1 = "housing:getDancers"
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = Config
  L2_2 = L2_2.DancersEnabled
  if not L2_2 then
    L2_2 = {}
    return L2_2
  end
  L2_2 = sv_common
  L3_2 = L2_2
  L2_2 = L2_2.getDancers
  L4_2 = A0_2
  L5_2 = A1_2
  return L2_2(L3_2, L4_2, L5_2)
end
L4_1(L5_1, L6_1)
L4_1 = lib
L4_1 = L4_1.callback
L4_1 = L4_1.register
L5_1 = "housing:orderDancer"
function L6_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L4_2 = Config
  L4_2 = L4_2.DancersEnabled
  if not L4_2 then
    L4_2 = false
    return L4_2
  end
  L4_2 = sv_common
  L5_2 = L4_2
  L4_2 = L4_2.orderDancer
  L6_2 = A0_2
  L7_2 = A1_2
  L8_2 = A2_2
  L9_2 = A3_2
  return L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
end
L4_1(L5_1, L6_1)
L4_1 = lib
L4_1 = L4_1.callback
L4_1 = L4_1.register
L5_1 = "housing:placeDancer"
function L6_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = Config
  L3_2 = L3_2.DancersEnabled
  if not L3_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = sv_common
  L4_2 = L3_2
  L3_2 = L3_2.placeDancer
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = A2_2
  return L3_2(L4_2, L5_2, L6_2, L7_2)
end
L4_1(L5_1, L6_1)
L4_1 = lib
L4_1 = L4_1.callback
L4_1 = L4_1.register
L5_1 = "housing:removeDancer"
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = Config
  L2_2 = L2_2.DancersEnabled
  if not L2_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = sv_common
  L3_2 = L2_2
  L2_2 = L2_2.removeDancer
  L4_2 = A0_2
  L5_2 = A1_2
  return L2_2(L3_2, L4_2, L5_2)
end
L4_1(L5_1, L6_1)
L4_1 = {}
L5_1 = 0
function L6_1()
  local L0_2, L1_2
  L0_2 = L5_1
  L0_2 = L0_2 + 1
  L5_1 = L0_2
  L0_2 = L5_1
  return L0_2
end
L7_1 = sv_common
function L8_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  if not A2_2 then
    L3_2 = {}
    return L3_2
  end
  L3_2 = L4_1
  L3_2 = L3_2[A2_2]
  if not L3_2 then
    L3_2 = {}
  end
  L4_2 = {}
  L5_2 = ipairs
  L6_2 = L3_2
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = table
    L11_2 = L11_2.insert
    L12_2 = L4_2
    L13_2 = {}
    L14_2 = L10_2.id
    L13_2.id = L14_2
    L14_2 = L10_2.title
    L13_2.title = L14_2
    L14_2 = L10_2.items
    L13_2.items = L14_2
    L14_2 = L10_2.orderedAt
    L13_2.orderedAt = L14_2
    L14_2 = L10_2.status
    L13_2.status = L14_2
    L14_2 = L10_2.deliveryTime
    L13_2.deliveryTime = L14_2
    L11_2(L12_2, L13_2)
  end
  return L4_2
end
L7_1.getDeliveries = L8_1
function L7_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = ipairs
  L2_2 = Config
  L2_2 = L2_2.Deliveries
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = L6_2.title
    if L7_2 == A0_2 then
      L7_2 = L6_2.deliveryTime
      if L7_2 then
        L7_2 = type
        L8_2 = L6_2.deliveryTime
        L7_2 = L7_2(L8_2)
        if "number" == L7_2 then
          L7_2 = L6_2.deliveryTime
          do return L7_2 end
          break
        end
        L7_2 = type
        L8_2 = L6_2.deliveryTime
        L7_2 = L7_2(L8_2)
        if "table" == L7_2 then
          L7_2 = L6_2.deliveryTime
          L7_2 = L7_2.min
          if L7_2 then
            L7_2 = L6_2.deliveryTime
            L7_2 = L7_2.max
            if L7_2 then
              L7_2 = math
              L7_2 = L7_2.random
              L8_2 = L6_2.deliveryTime
              L8_2 = L8_2.min
              L9_2 = L6_2.deliveryTime
              L9_2 = L9_2.max
              L7_2, L8_2, L9_2 = L7_2(L8_2, L9_2)
              return L7_2, L8_2, L9_2
            end
          end
        end
      end
      break
    end
  end
  L1_2 = math
  L1_2 = L1_2.random
  L2_2 = 5
  L3_2 = 10
  return L1_2(L2_2, L3_2)
end
L8_1 = sv_common
function L9_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2)
  local L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  if not (A2_2 and A3_2 and A4_2) or not A5_2 then
    L6_2 = false
    return L6_2
  end
  L6_2 = GetAccountMoney
  L7_2 = A1_2
  L8_2 = "bank"
  L6_2 = L6_2(L7_2, L8_2)
  if A4_2 > L6_2 then
    L7_2 = false
    return L7_2
  end
  L7_2 = RemoveAccountMoney
  L8_2 = A1_2
  L9_2 = "bank"
  L10_2 = A4_2
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = L7_1
  L8_2 = A3_2
  L7_2 = L7_2(L8_2)
  L8_2 = os
  L8_2 = L8_2.time
  L8_2 = L8_2()
  L9_2 = L7_2 * 60
  L8_2 = L8_2 + L9_2
  L9_2 = os
  L9_2 = L9_2.date
  L10_2 = "%Y-%m-%d %H:%M:%S"
  L9_2 = L9_2(L10_2)
  L10_2 = L6_1
  L10_2 = L10_2()
  L11_2 = L4_1
  L11_2 = L11_2[A2_2]
  if not L11_2 then
    L11_2 = L4_1
    L12_2 = {}
    L11_2[A2_2] = L12_2
  end
  L11_2 = {}
  L11_2.id = L10_2
  L11_2.title = A3_2
  L11_2.items = A5_2
  L11_2.orderedAt = L9_2
  L11_2.status = "pending"
  L11_2.deliveryTime = L8_2
  L11_2.house = A2_2
  L12_2 = table
  L12_2 = L12_2.insert
  L13_2 = L4_1
  L13_2 = L13_2[A2_2]
  L14_2 = L11_2
  L12_2(L13_2, L14_2)
  L12_2 = SetTimeout
  L13_2 = L7_2 * 60
  L13_2 = L13_2 * 1000
  function L14_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    L1_3 = A2_2
    L0_3 = L4_1
    L0_3 = L0_3[L1_3]
    if L0_3 then
      L0_3 = ipairs
      L2_3 = A2_2
      L1_3 = L4_1
      L1_3 = L1_3[L2_3]
      L0_3, L1_3, L2_3, L3_3 = L0_3(L1_3)
      for L4_3, L5_3 in L0_3, L1_3, L2_3, L3_3 do
        L6_3 = L5_3.id
        L7_3 = L10_2
        if L6_3 == L7_3 then
          L5_3.status = "delivered"
          break
        end
      end
    end
    L0_3 = TriggerClientEvent
    L1_3 = "housing:playDoorbell"
    L2_3 = -1
    L3_3 = A2_2
    L0_3(L1_3, L2_3, L3_3)
  end
  L12_2(L13_2, L14_2)
  L12_2 = true
  return L12_2
end
L8_1.orderDelivery = L9_1
L8_1 = sv_common
function L9_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  if not A2_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = nil
  L4_2 = nil
  L5_2 = pairs
  L6_2 = L4_1
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = pairs
    L12_2 = L10_2
    L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2)
    for L15_2, L16_2 in L11_2, L12_2, L13_2, L14_2 do
      L17_2 = L16_2.id
      if L17_2 == A2_2 then
        L17_2 = L16_2.status
        if "delivered" == L17_2 then
          L3_2 = L16_2
          L4_2 = L9_2
          break
        end
      end
    end
    if L3_2 then
      break
    end
  end
  if not L3_2 then
    L5_2 = false
    return L5_2
  end
  L5_2 = pairs
  L6_2 = L3_2.items
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = AddItem
    L12_2 = A1_2
    L13_2 = L10_2
    L14_2 = 1
    L11_2(L12_2, L13_2, L14_2)
  end
  if L4_2 then
    L5_2 = L4_1
    L5_2 = L5_2[L4_2]
    if L5_2 then
      L5_2 = pairs
      L6_2 = L4_1
      L6_2 = L6_2[L4_2]
      L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
      for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
        L11_2 = L10_2.id
        if L11_2 == A2_2 then
          L11_2 = table
          L11_2 = L11_2.remove
          L12_2 = L4_1
          L12_2 = L12_2[L4_2]
          L13_2 = L9_2
          L11_2(L12_2, L13_2)
          break
        end
      end
      L5_2 = L4_1
      L5_2 = L5_2[L4_2]
      L5_2 = #L5_2
      if 0 == L5_2 then
        L5_2 = L4_1
        L5_2[L4_2] = nil
      end
    end
  end
  L5_2 = true
  return L5_2
end
L8_1.collectDelivery = L9_1
L8_1 = lib
L8_1 = L8_1.callback
L8_1 = L8_1.register
L9_1 = "housing:getDeliveries"
function L10_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = Config
  L2_2 = L2_2.DeliveriesEnabled
  if not L2_2 then
    L2_2 = {}
    return L2_2
  end
  L2_2 = sv_common
  L3_2 = L2_2
  L2_2 = L2_2.getDeliveries
  L4_2 = A0_2
  L5_2 = A1_2
  return L2_2(L3_2, L4_2, L5_2)
end
L8_1(L9_1, L10_1)
L8_1 = lib
L8_1 = L8_1.callback
L8_1 = L8_1.register
L9_1 = "housing:orderDelivery"
function L10_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L5_2 = Config
  L5_2 = L5_2.DeliveriesEnabled
  if not L5_2 then
    L5_2 = false
    return L5_2
  end
  L5_2 = sv_common
  L6_2 = L5_2
  L5_2 = L5_2.orderDelivery
  L7_2 = A0_2
  L8_2 = A1_2
  L9_2 = A2_2
  L10_2 = A3_2
  L11_2 = A4_2
  return L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
end
L8_1(L9_1, L10_1)
L8_1 = lib
L8_1 = L8_1.callback
L8_1 = L8_1.register
L9_1 = "housing:collectDelivery"
function L10_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = Config
  L2_2 = L2_2.DeliveriesEnabled
  if not L2_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = sv_common
  L3_2 = L2_2
  L2_2 = L2_2.collectDelivery
  L4_2 = A0_2
  L5_2 = A1_2
  return L2_2(L3_2, L4_2, L5_2)
end
L8_1(L9_1, L10_1)
L8_1 = sv_common
function L9_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L3_2 = A1_2
  L4_2 = Config
  L4_2 = L4_2.CookingRecipes
  if not L4_2 then
    L4_2 = Notification
    L5_2 = L3_2
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "cooking.no_recipes"
    L6_2 = L6_2(L7_2)
    if not L6_2 then
      L6_2 = "No recipes available"
    end
    L7_2 = "error"
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = false
    return L4_2
  end
  L4_2 = table
  L4_2 = L4_2.find
  L5_2 = Config
  L5_2 = L5_2.CookingRecipes
  function L6_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.title
    L2_3 = A2_2
    L1_3 = L1_3 == L2_3
    return L1_3
  end
  L4_2 = L4_2(L5_2, L6_2)
  if not L4_2 then
    L5_2 = Notification
    L6_2 = L3_2
    L7_2 = i18n
    L7_2 = L7_2.t
    L8_2 = "cooking.recipe_not_found"
    L7_2 = L7_2(L8_2)
    if not L7_2 then
      L7_2 = "Recipe not found"
    end
    L8_2 = "error"
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = false
    return L5_2
  end
  L5_2 = GetPlayerFromId
  L6_2 = L3_2
  L5_2 = L5_2(L6_2)
  if not L5_2 then
    L6_2 = false
    return L6_2
  end
  L6_2 = GetItems
  L7_2 = L5_2
  L6_2 = L6_2(L7_2)
  if not L6_2 then
    L7_2 = false
    return L7_2
  end
  L7_2 = pairs
  L8_2 = L4_2.ingredients
  L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
  for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
    L13_2 = 0
    L14_2 = pairs
    L15_2 = L6_2
    L14_2, L15_2, L16_2, L17_2 = L14_2(L15_2)
    for L18_2, L19_2 in L14_2, L15_2, L16_2, L17_2 do
      L20_2 = L19_2.name
      if L20_2 == L11_2 then
        L20_2 = L19_2.count
        L13_2 = L20_2 or L13_2
        if not L20_2 then
          L20_2 = L19_2.amount
          L13_2 = L20_2 or L13_2
          if not L20_2 then
            L13_2 = 0
          end
        end
        break
      end
    end
    if L12_2 > L13_2 then
      L14_2 = Notification
      L15_2 = L3_2
      L16_2 = i18n
      L16_2 = L16_2.t
      L17_2 = "cooking.missing_ingredient"
      L18_2 = {}
      L18_2.item = L11_2
      L18_2.amount = L12_2
      L16_2 = L16_2(L17_2, L18_2)
      if not L16_2 then
        L16_2 = string
        L16_2 = L16_2.format
        L17_2 = "You need %d %s"
        L18_2 = L12_2
        L19_2 = L11_2
        L16_2 = L16_2(L17_2, L18_2, L19_2)
      end
      L17_2 = "error"
      L14_2(L15_2, L16_2, L17_2)
      L14_2 = false
      return L14_2
    end
  end
  L7_2 = pairs
  L8_2 = L4_2.ingredients
  L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
  for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
    L13_2 = RemoveItem
    L14_2 = L3_2
    L15_2 = L11_2
    L16_2 = L12_2
    L13_2(L14_2, L15_2, L16_2)
  end
  L7_2 = TriggerClientEvent
  L8_2 = "housing:startCooking"
  L9_2 = L3_2
  L10_2 = L4_2
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = true
  return L7_2
end
L8_1.cook = L9_1
L8_1 = sv_common
function L9_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L3_2 = A1_2
  L4_2 = Config
  L4_2 = L4_2.CookingRecipes
  if not L4_2 then
    return
  end
  L4_2 = table
  L4_2 = L4_2.find
  L5_2 = Config
  L5_2 = L5_2.CookingRecipes
  function L6_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.title
    L2_3 = A2_2
    L1_3 = L1_3 == L2_3
    return L1_3
  end
  L4_2 = L4_2(L5_2, L6_2)
  if not L4_2 then
    return
  end
  L5_2 = pairs
  L6_2 = L4_2.rewards
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = AddItem
    L12_2 = L3_2
    L13_2 = L9_2
    L14_2 = L10_2
    L11_2(L12_2, L13_2, L14_2)
  end
  L5_2 = Notification
  L6_2 = L3_2
  L7_2 = i18n
  L7_2 = L7_2.t
  L8_2 = "cooking.cooked"
  L9_2 = {}
  L9_2.item = A2_2
  L7_2 = L7_2(L8_2, L9_2)
  if not L7_2 then
    L7_2 = string
    L7_2 = L7_2.format
    L8_2 = "You cooked %s!"
    L9_2 = A2_2
    L7_2 = L7_2(L8_2, L9_2)
  end
  L8_2 = "success"
  L5_2(L6_2, L7_2, L8_2)
end
L8_1.finishCooking = L9_1
L8_1 = lib
L8_1 = L8_1.callback
L8_1 = L8_1.register
L9_1 = "housing:cook"
function L10_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = sv_common
  L3_2 = L2_2
  L2_2 = L2_2.cook
  L4_2 = A0_2
  L5_2 = A1_2
  return L2_2(L3_2, L4_2, L5_2)
end
L8_1(L9_1, L10_1)
L8_1 = RegisterNetEvent
L9_1 = "housing:finishCooking"
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = source
  L2_2 = sv_common
  L3_2 = L2_2
  L2_2 = L2_2.finishCooking
  L4_2 = L1_2
  L5_2 = A0_2
  L2_2(L3_2, L4_2, L5_2)
end
L8_1(L9_1, L10_1)
L8_1 = sv_common
function L9_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2
  L2_2 = A1_2
  L3_2 = GetIdentifier
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L4_2 = {}
    return L4_2
  end
  L4_2 = MySQL
  L4_2 = L4_2.query
  L4_2 = L4_2.await
  L5_2 = "SELECT * FROM house_stolen_furniture WHERE identifier = ?"
  L6_2 = {}
  L7_2 = L3_2
  L6_2[1] = L7_2
  L4_2 = L4_2(L5_2, L6_2)
  if not L4_2 then
    L5_2 = {}
    return L5_2
  end
  L5_2 = 1
  L6_2 = #L4_2
  L7_2 = 1
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = 0
    L10_2 = Config
    L10_2 = L10_2.Furniture
    if L10_2 then
      L10_2 = pairs
      L11_2 = Config
      L11_2 = L11_2.Furniture
      L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
      for L14_2, L15_2 in L10_2, L11_2, L12_2, L13_2 do
        if "navigation" ~= L14_2 then
          L16_2 = L15_2.items
          if L16_2 then
            L16_2 = pairs
            L17_2 = L15_2.items
            L16_2, L17_2, L18_2, L19_2 = L16_2(L17_2)
            for L20_2, L21_2 in L16_2, L17_2, L18_2, L19_2 do
              L22_2 = L21_2.object
              L23_2 = L4_2[L8_2]
              L23_2 = L23_2.model_name
              if L22_2 == L23_2 then
                L22_2 = L21_2.price
                L9_2 = L22_2 or L9_2
                if not L22_2 then
                  L9_2 = 0
                end
                break
              end
              L22_2 = L21_2.colors
              if L22_2 then
                L22_2 = pairs
                L23_2 = L21_2.colors
                L22_2, L23_2, L24_2, L25_2 = L22_2(L23_2)
                for L26_2, L27_2 in L22_2, L23_2, L24_2, L25_2 do
                  L28_2 = L27_2.object
                  L29_2 = L4_2[L8_2]
                  L29_2 = L29_2.model_name
                  if L28_2 == L29_2 then
                    L28_2 = L21_2.price
                    L9_2 = L28_2 or L9_2
                    if not L28_2 then
                      L9_2 = 0
                    end
                    break
                  end
                end
              end
            end
          end
        end
      end
    end
    L10_2 = L4_2[L8_2]
    L10_2.price = L9_2
    L10_2 = L4_2[L8_2]
    L11_2 = math
    L11_2 = L11_2.floor
    L12_2 = Config
    L12_2 = L12_2.Robbery
    L12_2 = L12_2.sell
    L12_2 = L12_2.price
    if not L12_2 then
      L12_2 = 0.1
    end
    L12_2 = L9_2 * L12_2
    L11_2 = L11_2(L12_2)
    L10_2.sellPrice = L11_2
  end
  return L4_2
end
L8_1.getStolenFurniture = L9_1
L8_1 = sv_common
function L9_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  L3_2 = A1_2
  L4_2 = GetIdentifier
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  if not A2_2 then
    L5_2 = false
    return L5_2
  end
  L5_2 = MySQL
  L5_2 = L5_2.single
  L5_2 = L5_2.await
  L6_2 = "SELECT * FROM house_stolen_furniture WHERE id = ? AND identifier = ?"
  L7_2 = {}
  L8_2 = A2_2
  L9_2 = L4_2
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L5_2 = L5_2(L6_2, L7_2)
  if not L5_2 then
    L6_2 = Notification
    L7_2 = L3_2
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "robbery.furniture_not_found"
    L8_2 = L8_2(L9_2)
    if not L8_2 then
      L8_2 = "Furniture not found"
    end
    L9_2 = "error"
    L6_2(L7_2, L8_2, L9_2)
    L6_2 = false
    return L6_2
  end
  L6_2 = 0
  L7_2 = Config
  L7_2 = L7_2.Furniture
  if L7_2 then
    L7_2 = pairs
    L8_2 = Config
    L8_2 = L8_2.Furniture
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      if "navigation" ~= L11_2 then
        L13_2 = L12_2.items
        if L13_2 then
          L13_2 = pairs
          L14_2 = L12_2.items
          L13_2, L14_2, L15_2, L16_2 = L13_2(L14_2)
          for L17_2, L18_2 in L13_2, L14_2, L15_2, L16_2 do
            L19_2 = L18_2.object
            L20_2 = L5_2.model_name
            if L19_2 == L20_2 then
              L19_2 = L18_2.price
              L6_2 = L19_2 or L6_2
              if not L19_2 then
                L6_2 = 0
              end
              break
            end
            L19_2 = L18_2.colors
            if L19_2 then
              L19_2 = pairs
              L20_2 = L18_2.colors
              L19_2, L20_2, L21_2, L22_2 = L19_2(L20_2)
              for L23_2, L24_2 in L19_2, L20_2, L21_2, L22_2 do
                L25_2 = L24_2.object
                L26_2 = L5_2.model_name
                if L25_2 == L26_2 then
                  L25_2 = L18_2.price
                  L6_2 = L25_2 or L6_2
                  if not L25_2 then
                    L6_2 = 0
                  end
                  break
                end
              end
            end
          end
        end
      end
    end
  end
  L7_2 = math
  L7_2 = L7_2.floor
  L8_2 = Config
  L8_2 = L8_2.Robbery
  L8_2 = L8_2.sell
  L8_2 = L8_2.price
  if not L8_2 then
    L8_2 = 0.1
  end
  L8_2 = L6_2 * L8_2
  L7_2 = L7_2(L8_2)
  L8_2 = AddAccountMoney
  L9_2 = L3_2
  L10_2 = "money"
  L11_2 = L7_2
  L8_2(L9_2, L10_2, L11_2)
  L8_2 = MySQL
  L8_2 = L8_2.update
  L8_2 = L8_2.await
  L9_2 = "DELETE FROM house_stolen_furniture WHERE id = ?"
  L10_2 = {}
  L11_2 = A2_2
  L10_2[1] = L11_2
  L8_2(L9_2, L10_2)
  L8_2 = Notification
  L9_2 = L3_2
  L10_2 = i18n
  L10_2 = L10_2.t
  L11_2 = "robbery.furniture_sold"
  L12_2 = {}
  L12_2.price = L7_2
  L10_2 = L10_2(L11_2, L12_2)
  if not L10_2 then
    L10_2 = string
    L10_2 = L10_2.format
    L11_2 = "Furniture sold for $%d"
    L12_2 = L7_2
    L10_2 = L10_2(L11_2, L12_2)
  end
  L11_2 = "success"
  L8_2(L9_2, L10_2, L11_2)
  L8_2 = true
  return L8_2
end
L8_1.sellFurniture = L9_1
L8_1 = sv_common
function L9_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L5_2 = A1_2
  L6_2 = GetIdentifier
  L7_2 = L5_2
  L6_2 = L6_2(L7_2)
  if not (A2_2 and A3_2) or not A4_2 then
    return
  end
  L7_2 = MySQL
  L7_2 = L7_2.update
  L7_2 = L7_2.await
  L8_2 = "DELETE FROM house_decorations WHERE id = ? AND house = ?"
  L9_2 = {}
  L10_2 = A3_2
  L11_2 = A2_2
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L7_2(L8_2, L9_2)
  L7_2 = ClearHouseDecoration
  L8_2 = A2_2
  L7_2(L8_2)
  L7_2 = MySQL
  L7_2 = L7_2.insert
  L7_2 = L7_2.await
  L8_2 = "INSERT INTO house_stolen_furniture (identifier, house, model_name, stolen_at) VALUES (?, ?, ?, ?)"
  L9_2 = {}
  L10_2 = L6_2
  L11_2 = A2_2
  L12_2 = A4_2.modelName
  L13_2 = os
  L13_2 = L13_2.date
  L14_2 = "%Y-%m-%d %H:%M:%S"
  L13_2, L14_2 = L13_2(L14_2)
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  L9_2[4] = L13_2
  L9_2[5] = L14_2
  L7_2(L8_2, L9_2)
  L7_2 = TriggerClientEvent
  L8_2 = "housing:removeFurniture"
  L9_2 = -1
  L10_2 = A2_2
  L11_2 = A3_2
  L7_2(L8_2, L9_2, L10_2, L11_2)
  L7_2 = Notification
  L8_2 = L5_2
  L9_2 = i18n
  L9_2 = L9_2.t
  L10_2 = "robbery.furniture_stolen"
  L9_2 = L9_2(L10_2)
  if not L9_2 then
    L9_2 = "Furniture stolen!"
  end
  L10_2 = "success"
  L7_2(L8_2, L9_2, L10_2)
end
L8_1.stealFurniture = L9_1
L8_1 = lib
L8_1 = L8_1.callback
L8_1 = L8_1.register
L9_1 = "housing:robbery:getStolenFurniture"
function L10_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = sv_common
  L2_2 = L1_2
  L1_2 = L1_2.getStolenFurniture
  L3_2 = A0_2
  return L1_2(L2_2, L3_2)
end
L8_1(L9_1, L10_1)
L8_1 = RegisterNetEvent
L9_1 = "housing:robbery:sellFurniture"
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = source
  L2_2 = sv_common
  L3_2 = L2_2
  L2_2 = L2_2.sellFurniture
  L4_2 = L1_2
  L5_2 = A0_2
  L2_2(L3_2, L4_2, L5_2)
end
L8_1(L9_1, L10_1)
L8_1 = RegisterNetEvent
L9_1 = "housing:robbery:stealFurniture"
function L10_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = source
  L4_2 = sv_common
  L5_2 = L4_2
  L4_2 = L4_2.stealFurniture
  L6_2 = L3_2
  L7_2 = A0_2
  L8_2 = A1_2
  L9_2 = A2_2
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
end
L8_1(L9_1, L10_1)






