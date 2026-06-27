





local L0_1, L1_1, L2_1
L0_1 = _G
L1_1 = {}
L0_1.keypad = L1_1
L0_1 = keypad
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = A1_2 or nil
  if not A1_2 then
    L3_2 = "Enter PIN Code"
  end
  A0_2.title = L3_2
  L3_2 = A2_2 or L3_2
  if not A2_2 then
    L3_2 = 4
  end
  A0_2.maxLength = L3_2
  A0_2.response = nil
  L3_2 = SendReactMessage
  L4_2 = "toggle_keypad"
  L5_2 = {}
  L5_2.visible = true
  L6_2 = A0_2.title
  L5_2.title = L6_2
  L6_2 = A0_2.maxLength
  L5_2.maxLength = L6_2
  L3_2(L4_2, L5_2)
  L3_2 = SetNuiFocus
  L4_2 = true
  L5_2 = true
  L3_2(L4_2, L5_2)
  while true do
    L3_2 = A0_2.response
    if nil ~= L3_2 then
      break
    end
    L3_2 = Wait
    L4_2 = 50
    L3_2(L4_2)
  end
  L3_2 = A0_2.response
  return L3_2
end
L0_1.open = L1_1
L0_1 = keypad
function L1_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SendReactMessage
  L2_2 = "toggle_keypad"
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
L1_1 = "keypad:submit"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = A0_2.pin
  if L2_2 then
    L3_2 = #L2_2
    L4_2 = keypad
    L4_2 = L4_2.maxLength
    if not (L3_2 < L4_2) then
      goto lbl_13
    end
  end
  L3_2 = A1_2
  L4_2 = "error"
  L3_2(L4_2)
  do return end
  ::lbl_13::
  L3_2 = keypad
  L4_2 = L3_2
  L3_2 = L3_2.close
  L3_2(L4_2)
  L3_2 = keypad
  L3_2.response = L2_2
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L0_1(L1_1, L2_1)






