





local L0_1, L1_1, L2_1
L0_1 = RegisterNUICallback
L1_1 = "house_browser:set_waypoint"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  if A0_2 then
    L2_2 = A0_2.houseName
    if L2_2 then
      goto lbl_10
    end
  end
  L2_2 = A1_2
  L3_2 = false
  do return L2_2(L3_2) end
  ::lbl_10::
  L2_2 = housebrowser
  L3_2 = L2_2
  L2_2 = L2_2.setWaypoint
  L4_2 = A0_2.houseName
  L2_2(L3_2, L4_2)
  L2_2 = A1_2
  L3_2 = true
  L2_2(L3_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "house_browser:get_house_details"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  if A0_2 then
    L2_2 = A0_2.houseName
    if L2_2 then
      goto lbl_10
    end
  end
  L2_2 = A1_2
  L3_2 = nil
  do return L2_2(L3_2) end
  ::lbl_10::
  L2_2 = Config
  L2_2 = L2_2.Houses
  L3_2 = A0_2.houseName
  L2_2 = L2_2[L3_2]
  if not L2_2 then
    L3_2 = A1_2
    L4_2 = nil
    return L3_2(L4_2)
  end
  L3_2 = {}
  L4_2 = A0_2.houseName
  L3_2.name = L4_2
  L4_2 = L2_2.owned
  if L4_2 then
    L4_2 = "Owner Info"
    if L4_2 then
      goto lbl_31
    end
  end
  L4_2 = nil
  ::lbl_31::
  L3_2.owner = L4_2
  L4_2 = A1_2
  L5_2 = L3_2
  L4_2(L5_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "house_browser:refresh"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = housebrowser
  L3_2 = housebrowser
  L4_2 = L3_2
  L3_2 = L3_2.collectHouses
  L3_2 = L3_2(L4_2)
  L2_2.houses = L3_2
  L2_2 = A1_2
  L3_2 = housebrowser
  L3_2 = L3_2.houses
  L2_2(L3_2)
end
L0_1(L1_1, L2_1)






