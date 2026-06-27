





local L0_1, L1_1, L2_1, L3_1, L4_1
L0_1 = {}
iplHouses = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = iplHouses
  L2_2 = L2_2[A0_2]
  if not L2_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = pairs
  L3_2 = iplHouses
  L3_2 = L3_2[A0_2]
  L3_2 = L3_2.players
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    if L7_2 == A1_2 then
      return L6_2
    end
  end
  L2_2 = false
  return L2_2
end
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = source
  L2_2 = L0_1
  L3_2 = A0_2
  L4_2 = L1_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    return
  end
  L3_2 = table
  L3_2 = L3_2.remove
  L4_2 = iplHouses
  L4_2 = L4_2[A0_2]
  L4_2 = L4_2.players
  L5_2 = L2_2
  L3_2(L4_2, L5_2)
  L3_2 = TriggerClientEvent
  L4_2 = "qb-houses:SetIplData"
  L5_2 = -1
  L6_2 = iplHouses
  L3_2(L4_2, L5_2, L6_2)
end
L2_1 = RegisterNetEvent
L3_1 = "qb-houses:enterIplHouse"
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = source
  L2_2 = MySQL
  L2_2 = L2_2.Sync
  L2_2 = L2_2.fetchAll
  L3_2 = "select * from player_houses where house = ? limit 1"
  L4_2 = {}
  L5_2 = A0_2
  L4_2[1] = L5_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = L2_2[1]
  if not L3_2 then
    return
  end
  L3_2 = L2_2[1]
  L2_2 = L3_2.citizenid
  L3_2 = iplHouses
  L3_2 = L3_2[A0_2]
  if not L3_2 then
    L3_2 = iplHouses
    L4_2 = {}
    L4_2.houseOwner = L2_2
    L5_2 = {}
    L4_2.players = L5_2
    L3_2[A0_2] = L4_2
  end
  L3_2 = table
  L3_2 = L3_2.insert
  L4_2 = iplHouses
  L4_2 = L4_2[A0_2]
  L4_2 = L4_2.players
  L5_2 = L1_2
  L3_2(L4_2, L5_2)
  L3_2 = TriggerClientEvent
  L4_2 = "qb-houses:SetIplData"
  L5_2 = -1
  L6_2 = iplHouses
  L3_2(L4_2, L5_2, L6_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "qb-houses:UpdateIplTheme"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A1_2]
  L2_2 = L2_2.ipl
  L2_2.theme = A0_2
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.execute
  L4_2 = "UPDATE houselocations SET ipl = ? WHERE name = ?"
  L5_2 = {}
  L6_2 = json
  L6_2 = L6_2.encode
  L7_2 = L2_2
  L6_2 = L6_2(L7_2)
  L7_2 = A1_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2(L4_2, L5_2)
  L3_2 = TriggerClientEvent
  L4_2 = "housing:updateHouseData"
  L5_2 = -1
  L6_2 = A1_2
  L7_2 = "ipl"
  L8_2 = L2_2
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = iplHouses
  L3_2 = L3_2[A1_2]
  if not L3_2 then
    return
  end
  L3_2 = pairs
  L4_2 = iplHouses
  L4_2 = L4_2[A1_2]
  L4_2 = L4_2.players
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = TriggerClientEvent
    L10_2 = "qb-houses:UpdateTheme"
    L11_2 = L8_2
    L12_2 = A0_2
    L13_2 = A1_2
    L9_2(L10_2, L11_2, L12_2, L13_2)
  end
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "qb-houses:leaveIplHouse"
L4_1 = L1_1
L2_1(L3_1, L4_1)
L2_1 = AddEventHandler
L3_1 = "playerDropped"
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = source
  L2_2 = next
  L3_2 = iplHouses
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    return
  end
  L2_2 = pairs
  L3_2 = iplHouses
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = pairs
    L9_2 = L7_2.players
    L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
    for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
      if L13_2 == L1_2 then
        L14_2 = table
        L14_2 = L14_2.remove
        L15_2 = L7_2.players
        L16_2 = L12_2
        L14_2(L15_2, L16_2)
      end
    end
  end
  L2_2 = TriggerClientEvent
  L3_2 = "qb-houses:SetIplData"
  L4_2 = -1
  L5_2 = iplHouses
  L2_2(L3_2, L4_2, L5_2)
end
L2_1(L3_1, L4_1)






