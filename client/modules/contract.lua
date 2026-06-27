





local L0_1, L1_1, L2_1
L0_1 = _G
L1_1 = {}
L0_1.contract = L1_1
L0_1 = contract
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = A0_2.visible
  if L2_2 then
    L2_2 = Debug
    L3_2 = "contract:open ::: contract is already visible"
    return L2_2(L3_2)
  end
  A1_2.visible = true
  A0_2.data = A1_2
  A0_2.visible = true
  L2_2 = SendReactMessage
  L3_2 = "toggle_contract"
  L4_2 = A0_2.data
  L2_2(L3_2, L4_2)
  L2_2 = SetNuiFocus
  L3_2 = true
  L4_2 = true
  L2_2(L3_2, L4_2)
end
L0_1.open = L1_1
L0_1 = contract
function L1_1(A0_2)
  local L1_2, L2_2, L3_2
  A0_2.visible = false
  A0_2.data = nil
  L1_2 = SendReactMessage
  L2_2 = "toggle_contract"
  L3_2 = {}
  L3_2.visible = false
  L1_2(L2_2, L3_2)
end
L0_1.close = L1_1
L0_1 = RegisterNUICallback
L1_1 = "accept_contract"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = CurrentApartment
  if L2_2 then
    L2_2 = L2_2.house
  end
  if not L2_2 then
    L2_2 = CurrentHouse
  end
  L3_2 = A0_2.type
  if "buy" == L3_2 then
    L3_2 = TriggerServerEvent
    L4_2 = "qb-houses:server:buyHouse"
    L5_2 = L2_2
    L3_2(L4_2, L5_2)
  else
    L3_2 = A0_2.type
    if "rent" == L3_2 then
      L3_2 = TriggerServerEvent
      L4_2 = "qb-houses:rentHouse"
      L5_2 = L2_2
      L3_2(L4_2, L5_2)
    else
      L3_2 = A0_2.type
      if "credit" == L3_2 then
        L3_2 = TriggerServerEvent
        L4_2 = "qb-houses:server:buyHouse"
        L5_2 = L2_2
        L6_2 = true
        L3_2(L4_2, L5_2, L6_2)
      else
        L3_2 = Error
        L4_2 = "buy ::: Invalid data"
        L5_2 = "data"
        L6_2 = A0_2
        L3_2(L4_2, L5_2, L6_2)
      end
    end
  end
  CurrentApartment = nil
  L3_2 = A1_2
  L4_2 = true
  L3_2(L4_2)
end
L0_1(L1_1, L2_1)






