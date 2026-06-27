





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1
L0_1 = {}
L1_1 = {}
HouseTransactionVeto = L1_1
L1_1 = HouseTransactionVeto
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = pairs
  L2_2 = L0_1
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = pcall
    L8_2 = L6_2
    L9_2 = A0_2
    L7_2, L8_2, L9_2 = L7_2(L8_2, L9_2)
    if not L7_2 then
      L10_2 = Debug
      L11_2 = "HouseTransactionVeto"
      L12_2 = "Handler error"
      L13_2 = L5_2
      L14_2 = L8_2
      L10_2(L11_2, L12_2, L13_2, L14_2)
    elseif false == L8_2 then
      L10_2 = Debug
      L11_2 = "HouseTransactionVeto"
      L12_2 = "Transaction vetoed"
      L13_2 = L5_2
      L14_2 = A0_2.action
      L15_2 = A0_2.house
      L16_2 = L9_2
      L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
      L10_2 = {}
      L10_2.allowed = false
      L11_2 = L9_2 or L11_2
      if not L9_2 then
        L11_2 = "Transaction blocked by "
        L12_2 = L5_2
        L11_2 = L11_2 .. L12_2
      end
      L10_2.reason = L11_2
      return L10_2
    end
  end
  L1_2 = {}
  L1_2.allowed = true
  L1_2.reason = nil
  return L1_2
end
L1_1.Run = L2_1
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = type
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if "string" ~= L2_2 or "" == A0_2 then
    L2_2 = Error
    L3_2 = "RegisterHouseTransactionVeto"
    L4_2 = "Invalid handler id"
    L5_2 = A0_2
    return L2_2(L3_2, L4_2, L5_2)
  end
  L2_2 = L0_1
  L2_2[A0_2] = A1_2
  L2_2 = Debug
  L3_2 = "HouseTransactionVeto"
  L4_2 = "Registered handler"
  L5_2 = A0_2
  L2_2(L3_2, L4_2, L5_2)
end
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = L0_1
  L1_2 = L1_2[A0_2]
  if L1_2 then
    L1_2 = L0_1
    L1_2[A0_2] = nil
    L1_2 = Debug
    L2_2 = "HouseTransactionVeto"
    L3_2 = "Unregistered handler"
    L4_2 = A0_2
    L1_2(L2_2, L3_2, L4_2)
  end
end
L3_1 = exports
L4_1 = "RegisterHouseTransactionVeto"
L5_1 = L1_1
L3_1(L4_1, L5_1)
L3_1 = exports
L4_1 = "UnregisterHouseTransactionVeto"
L5_1 = L2_1
L3_1(L4_1, L5_1)






