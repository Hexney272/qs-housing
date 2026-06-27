





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1
L0_1 = {}
function L1_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = L0_1
  L2_2 = L2_2[A0_2]
  if L2_2 then
    L2_2 = L0_1
    L2_2 = L2_2[A0_2]
    L2_2 = L2_2[A1_2]
    if L2_2 then
      L2_2 = true
      L3_2 = L0_1
      L3_2 = L3_2[A0_2]
      L3_2 = L3_2[A1_2]
      L3_2 = L3_2.ownerId
      return L2_2, L3_2
    end
  end
  L2_2 = false
  L3_2 = nil
  return L2_2, L3_2
end
function L2_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L4_2 = L1_1
  L5_2 = A1_2
  L6_2 = A2_2
  L4_2, L5_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L6_2 = false
    L7_2 = "already_active"
    return L6_2, L7_2
  end
  L6_2 = L0_1
  L6_2 = L6_2[A1_2]
  if not L6_2 then
    L6_2 = L0_1
    L7_2 = {}
    L6_2[A1_2] = L7_2
  end
  L6_2 = L0_1
  L6_2 = L6_2[A1_2]
  L7_2 = {}
  L7_2.decorationId = A2_2
  L7_2.house = A1_2
  L7_2.ownerId = A0_2
  L7_2.networkId = 0
  L7_2.modelName = A3_2
  L6_2[A2_2] = L7_2
  L6_2 = TriggerClientEvent
  L7_2 = "housing:cleaner:setDecorationAlpha"
  L8_2 = -1
  L9_2 = A1_2
  L10_2 = A2_2
  L11_2 = 0
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  L6_2 = Debug
  L7_2 = "Cleaner started"
  L8_2 = "house"
  L9_2 = A1_2
  L10_2 = "decorationId"
  L11_2 = A2_2
  L12_2 = "owner"
  L13_2 = A0_2
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L6_2 = true
  L7_2 = nil
  return L6_2, L7_2
end
function L3_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L4_2 = L0_1
  L4_2 = L4_2[A1_2]
  if L4_2 then
    L4_2 = L0_1
    L4_2 = L4_2[A1_2]
    L4_2 = L4_2[A2_2]
    if L4_2 then
      L4_2 = L0_1
      L4_2 = L4_2[A1_2]
      L4_2 = L4_2[A2_2]
      L4_2 = L4_2.ownerId
      if L4_2 == A0_2 then
        L4_2 = L0_1
        L4_2 = L4_2[A1_2]
        L4_2 = L4_2[A2_2]
        L4_2.networkId = A3_2
        L4_2 = Debug
        L5_2 = "Cleaner network ID updated"
        L6_2 = "house"
        L7_2 = A1_2
        L8_2 = "decorationId"
        L9_2 = A2_2
        L10_2 = "networkId"
        L11_2 = A3_2
        L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      end
    end
  end
end
function L4_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = L0_1
  L3_2 = L3_2[A1_2]
  if L3_2 then
    L3_2 = L0_1
    L3_2 = L3_2[A1_2]
    L3_2 = L3_2[A2_2]
    if L3_2 then
      goto lbl_12
    end
  end
  L3_2 = false
  do return L3_2 end
  ::lbl_12::
  L3_2 = L0_1
  L3_2 = L3_2[A1_2]
  L3_2 = L3_2[A2_2]
  if A0_2 > 0 then
    L4_2 = L3_2.ownerId
    if L4_2 ~= A0_2 then
      L4_2 = false
      return L4_2
    end
  end
  L4_2 = TriggerClientEvent
  L5_2 = "housing:cleaner:setDecorationAlpha"
  L6_2 = -1
  L7_2 = A1_2
  L8_2 = A2_2
  L9_2 = 255
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = L3_2.ownerId
  if L4_2 > 0 then
    L4_2 = TriggerClientEvent
    L5_2 = "housing:cleaner:deleteNetworkedRobot"
    L6_2 = L3_2.ownerId
    L7_2 = A1_2
    L8_2 = A2_2
    L4_2(L5_2, L6_2, L7_2, L8_2)
  end
  L4_2 = L0_1
  L4_2 = L4_2[A1_2]
  L4_2[A2_2] = nil
  L4_2 = next
  L5_2 = L0_1
  L5_2 = L5_2[A1_2]
  L4_2 = L4_2(L5_2)
  if nil == L4_2 then
    L4_2 = L0_1
    L4_2[A1_2] = nil
  end
  L4_2 = Debug
  L5_2 = "Cleaner stopped"
  L6_2 = "house"
  L7_2 = A1_2
  L8_2 = "decorationId"
  L9_2 = A2_2
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = true
  return L4_2
end
function L5_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = pairs
  L2_2 = L0_1
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = pairs
    L8_2 = L6_2
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      L13_2 = L12_2.ownerId
      if L13_2 == A0_2 then
        L13_2 = L4_1
        L14_2 = 0
        L15_2 = L5_2
        L16_2 = L11_2
        L13_2(L14_2, L15_2, L16_2)
      end
    end
  end
end
L6_1 = lib
L6_1 = L6_1.callback
L6_1 = L6_1.register
L7_1 = "housing:cleaner:start"
function L8_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2
  L4_2 = L2_1
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = A2_2
  L8_2 = A3_2
  L4_2, L5_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L6_2 = L4_2
  L7_2 = L5_2
  return L6_2, L7_2
end
L6_1(L7_1, L8_1)
L6_1 = lib
L6_1 = L6_1.callback
L6_1 = L6_1.register
L7_1 = "housing:cleaner:stop"
function L8_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = L4_1
  L4_2 = A0_2
  L5_2 = A1_2
  L6_2 = A2_2
  return L3_2(L4_2, L5_2, L6_2)
end
L6_1(L7_1, L8_1)
L6_1 = lib
L6_1 = L6_1.callback
L6_1 = L6_1.register
L7_1 = "housing:cleaner:isActive"
function L8_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = L1_1
  L4_2 = A1_2
  L5_2 = A2_2
  L3_2, L4_2 = L3_2(L4_2, L5_2)
  L5_2 = L3_2
  L6_2 = L4_2
  return L5_2, L6_2
end
L6_1(L7_1, L8_1)
L6_1 = RegisterNetEvent
L7_1 = "housing:cleaner:updateNetworkId"
function L8_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L3_2 = source
  L4_2 = L3_1
  L5_2 = L3_2
  L6_2 = A0_2
  L7_2 = A1_2
  L8_2 = A2_2
  L4_2(L5_2, L6_2, L7_2, L8_2)
end
L6_1(L7_1, L8_1)
L6_1 = RegisterNetEvent
L7_1 = "housing:cleaner:stopped"
function L8_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = source
  L3_2 = L4_1
  L4_2 = L2_2
  L5_2 = A0_2
  L6_2 = A1_2
  L3_2(L4_2, L5_2, L6_2)
end
L6_1(L7_1, L8_1)
L6_1 = AddEventHandler
L7_1 = "housing:setInside"
function L8_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = source
  if not A1_2 then
    L3_2 = L5_1
    L4_2 = L2_2
    L3_2(L4_2)
  end
end
L6_1(L7_1, L8_1)
L6_1 = AddEventHandler
L7_1 = "playerDropped"
function L8_1()
  local L0_2, L1_2, L2_2
  L0_2 = source
  L1_2 = L5_1
  L2_2 = L0_2
  L1_2(L2_2)
end
L6_1(L7_1, L8_1)






