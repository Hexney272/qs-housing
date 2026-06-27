





local L0_1, L1_1, L2_1, L3_1, L4_1
function L0_1()
  local L0_2, L1_2
  L0_2 = GetResourceState
  L1_2 = "qs-smartphone"
  L0_2 = L0_2(L1_2)
  L0_2 = "started" == L0_2
  return L0_2
end
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = type
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if "string" ~= L1_2 or "" == A0_2 or "null" == A0_2 then
    L1_2 = nil
    return L1_2
  end
  L1_2 = pcall
  L2_2 = json
  L2_2 = L2_2.decode
  L3_2 = A0_2
  L1_2, L2_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L3_2 = type
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    if "table" == L3_2 then
      goto lbl_26
    end
  end
  L3_2 = nil
  do return L3_2 end
  ::lbl_26::
  L3_2 = tonumber
  L4_2 = L2_2.x
  L3_2 = L3_2(L4_2)
  L4_2 = tonumber
  L5_2 = L2_2.y
  L4_2 = L4_2(L5_2)
  L5_2 = tonumber
  L6_2 = L2_2.z
  L5_2 = L5_2(L6_2)
  if L3_2 and L4_2 and L5_2 then
    L6_2 = vector3
    L7_2 = L3_2
    L8_2 = L4_2
    L9_2 = L5_2
    return L6_2(L7_2, L8_2, L9_2)
  end
  L6_2 = nil
  return L6_2
end
function L2_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = L0_1
  L0_2 = L0_2()
  if not L0_2 then
    return
  end
  L0_2 = MySQL
  L0_2 = L0_2.query
  L0_2 = L0_2.await
  L1_2 = "SELECT house, charge FROM player_houses WHERE charge IS NOT NULL AND charge <> ? AND charge <> ?"
  L2_2 = {}
  L3_2 = ""
  L4_2 = "null"
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L0_2 = L0_2(L1_2, L2_2)
  if not L0_2 then
    return
  end
  L1_2 = 1
  L2_2 = #L0_2
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = L0_2[L4_2]
    L6_2 = L5_2.house
    L7_2 = L1_1
    L8_2 = L5_2.charge
    L7_2 = L7_2(L8_2)
    L8_2 = type
    L9_2 = L6_2
    L8_2 = L8_2(L9_2)
    if "string" == L8_2 and "" ~= L6_2 and L7_2 then
      L8_2 = exports
      L8_2 = L8_2["qs-smartphone"]
      L9_2 = L8_2
      L8_2 = L8_2.BatteryRegisterHousingCharger
      L10_2 = L6_2
      L11_2 = L7_2
      L12_2 = nil
      L8_2(L9_2, L10_2, L11_2, L12_2)
    end
  end
end
HousingBatteryBridge_SyncFromDatabase = L2_1
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = L0_1
  L2_2 = L2_2()
  if L2_2 then
    L2_2 = type
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    if "string" == L2_2 and "" ~= A0_2 then
      goto lbl_13
    end
  end
  do return end
  ::lbl_13::
  L2_2 = exports
  L2_2 = L2_2["qs-smartphone"]
  L3_2 = L2_2
  L2_2 = L2_2.BatteryRegisterHousingCharger
  L4_2 = A0_2
  L5_2 = A1_2
  L6_2 = nil
  L2_2(L3_2, L4_2, L5_2, L6_2)
end
HousingBatteryBridge_Register = L2_1
function L2_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = L0_1
  L1_2 = L1_2()
  if L1_2 then
    L1_2 = type
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    if "string" == L1_2 and "" ~= A0_2 then
      goto lbl_13
    end
  end
  do return end
  ::lbl_13::
  L1_2 = exports
  L1_2 = L1_2["qs-smartphone"]
  L2_2 = L1_2
  L1_2 = L1_2.BatteryUnregisterHousingCharger
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
HousingBatteryBridge_Unregister = L2_1
L2_1 = AddEventHandler
L3_1 = "onResourceStart"
function L4_1(A0_2)
  local L1_2
  if "qs-smartphone" == A0_2 then
    L1_2 = HousingBatteryBridge_SyncFromDatabase
    L1_2()
  else
    L1_2 = GetCurrentResourceName
    L1_2 = L1_2()
    if A0_2 == L1_2 then
      L1_2 = L0_1
      L1_2 = L1_2()
      if L1_2 then
        L1_2 = HousingBatteryBridge_SyncFromDatabase
        L1_2()
      end
    end
  end
end
L2_1(L3_1, L4_1)






