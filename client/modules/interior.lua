





local L0_1, L1_1
function L0_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2
  L4_2 = CreateThread
  function L5_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3
    L0_3 = SetEntityCoords
    L1_3 = cache
    L1_3 = L1_3.ped
    L2_3 = A0_2
    L3_3 = A1_2
    L4_3 = A2_2
    L5_3 = 0
    L6_3 = 0
    L7_3 = 0
    L8_3 = false
    L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3)
    L0_3 = SetEntityHeading
    L1_3 = cache
    L1_3 = L1_3.ped
    L2_3 = A3_2
    L0_3(L1_3, L2_3)
    L0_3 = Wait
    L1_3 = 100
    L0_3(L1_3)
    L0_3 = DoScreenFadeIn
    L1_3 = 1000
    L0_3(L1_3)
  end
  L4_2(L5_2)
end
TeleportToInterior = L0_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L3_2 = {}
  L4_2 = {}
  L4_2.exit = A1_2
  L5_2 = DoScreenFadeOut
  L6_2 = 500
  L5_2(L6_2)
  while true do
    L5_2 = IsScreenFadedOut
    L5_2 = L5_2()
    if L5_2 then
      break
    end
    L5_2 = Wait
    L6_2 = 10
    L5_2(L6_2)
  end
  L5_2 = lib
  L5_2 = L5_2.requestModel
  L6_2 = A2_2
  L7_2 = Config
  L7_2 = L7_2.DefaultRequestModelTimeout
  L5_2(L6_2, L7_2)
  L5_2 = CreateObject
  L6_2 = A2_2
  L7_2 = A0_2.x
  L8_2 = A0_2.y
  L9_2 = A0_2.z
  L10_2 = false
  L11_2 = false
  L12_2 = false
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = A0_2.h
  if L6_2 then
    L6_2 = SetEntityHeading
    L7_2 = L5_2
    L8_2 = A0_2.h
    L6_2(L7_2, L8_2)
  end
  L6_2 = SetModelAsNoLongerNeeded
  L7_2 = A2_2
  L6_2(L7_2)
  L6_2 = FreezeEntityPosition
  L7_2 = L5_2
  L8_2 = true
  L6_2(L7_2, L8_2)
  L6_2 = #L3_2
  L6_2 = L6_2 + 1
  L3_2[L6_2] = L5_2
  L6_2 = Debug
  L7_2 = "CreateShell.exitCoords"
  L8_2 = A1_2
  L9_2 = "spawn coords"
  L10_2 = A0_2
  L6_2(L7_2, L8_2, L9_2, L10_2)
  L6_2 = TeleportToInterior
  L7_2 = A1_2.x
  L8_2 = A1_2.y
  L9_2 = A1_2.z
  L10_2 = A1_2.h
  L6_2(L7_2, L8_2, L9_2, L10_2)
  L6_2 = {}
  L7_2 = L3_2
  L8_2 = L4_2
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  return L6_2
end
CreateShell = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = CreateThread
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    L0_3 = pairs
    L1_3 = A0_2
    L0_3, L1_3, L2_3, L3_3 = L0_3(L1_3)
    for L4_3, L5_3 in L0_3, L1_3, L2_3, L3_3 do
      if L5_3 then
        L6_3 = DoesEntityExist
        L7_3 = L5_3
        L6_3 = L6_3(L7_3)
        if L6_3 then
          L6_3 = DeleteEntity
          L7_3 = L5_3
          L6_3(L7_3)
        end
      end
    end
    L0_3 = A1_2
    L0_3()
  end
  L2_2(L3_2)
end
DespawnInterior = L0_1






