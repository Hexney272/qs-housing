





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1
L0_1 = Config
L1_1 = db
L1_1 = L1_1.getMergedFurnitureData
L1_1 = L1_1()
L0_1.Furniture = L1_1
function L0_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = db
  L0_2 = L0_2.getFurnitureShops
  L0_2 = L0_2()
  L1_2 = Config
  L2_2 = db
  L2_2 = L2_2.expandFurnitureShopCategories
  L3_2 = L0_2
  L2_2 = L2_2(L3_2)
  L1_2.FurnitureShops = L2_2
  L1_2 = Debug
  L2_2 = "InitFurnitureShops"
  L3_2 = "Loaded"
  L4_2 = Config
  L4_2 = L4_2.FurnitureShops
  L4_2 = #L4_2
  L5_2 = "furniture shops"
  L1_2(L2_2, L3_2, L4_2, L5_2)
end
InitFurnitureShops = L0_1
L0_1 = InitFurnitureShops
L0_1()
L0_1 = false
L1_1 = {}
HouseGarages = L1_1
L1_1 = {}
L2_1 = {}
PlayerInHouseZones = L2_1
L2_1 = {}
HouseOwnerIdentifierList = L2_1
L2_1 = {}
OfficialHouseOwnerList = L2_1
L2_1 = {}
HouseOwnerCitizenidList = L2_1
L2_1 = {}
HouseKeyholdersList = L2_1
L2_1 = {}
L3_1 = {}
L4_1 = {}
function L5_1(A0_2, A1_2)
  local L2_2, L3_2
  if nil == A0_2 then
    return A1_2
  end
  L2_2 = type
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if "boolean" == L2_2 then
    return A0_2
  end
  L2_2 = type
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if "number" == L2_2 then
    L2_2 = 1 == A0_2
    return L2_2
  end
  L2_2 = type
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if "string" == L2_2 then
    L3_2 = A0_2
    L2_2 = A0_2.lower
    L2_2 = L2_2(L3_2)
    if "1" == L2_2 or "true" == L2_2 then
      L3_2 = true
      return L3_2
    end
    if "0" == L2_2 or "false" == L2_2 then
      L3_2 = false
      return L3_2
    end
  end
  return A1_2
end
function L6_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = MySQL
  L0_2 = L0_2.query
  L0_2 = L0_2.await
  L1_2 = "SHOW COLUMNS FROM houselocations LIKE ?"
  L2_2 = {}
  L3_2 = "assistantZoneMessagesEnabled"
  L2_2[1] = L3_2
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L1_2 = L0_2[1]
    if L1_2 then
      return
    end
  end
  L1_2 = MySQL
  L1_2 = L1_2.query
  L1_2 = L1_2.await
  L2_2 = "ALTER TABLE houselocations ADD COLUMN assistantZoneMessagesEnabled TINYINT(1) NOT NULL DEFAULT 1"
  L1_2(L2_2)
  L1_2 = Debug
  L2_2 = "ensureAssistantZoneMessagesColumn"
  L3_2 = "assistantZoneMessagesEnabled column created"
  L1_2(L2_2, L3_2)
end
function L7_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = MySQL
  L0_2 = L0_2.query
  L0_2 = L0_2.await
  L1_2 = "SHOW COLUMNS FROM player_houses LIKE ?"
  L2_2 = {}
  L3_2 = "rentNextChargeAt"
  L2_2[1] = L3_2
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L1_2 = L0_2[1]
    if L1_2 then
      return
    end
  end
  L1_2 = MySQL
  L1_2 = L1_2.query
  L1_2 = L1_2.await
  L2_2 = "ALTER TABLE player_houses ADD COLUMN rentNextChargeAt DATETIME NULL DEFAULT NULL"
  L1_2(L2_2)
  L1_2 = Debug
  L2_2 = "ensureRentNextChargeAtColumn"
  L3_2 = "rentNextChargeAt column created"
  L1_2(L2_2, L3_2)
end
L8_1 = {}
L8_1.money = true
L8_1.bank = true
L8_1.cash = true
L8_1.black_money = true
function L9_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = Config
  L1_2 = L1_2.Houses
  L1_2 = L1_2[A0_2]
  if L1_2 then
    L2_2 = L1_2.paymentMethod
    if L2_2 then
      goto lbl_14
    end
  end
  L2_2 = Config
  L2_2 = L2_2.MoneyType
  if not L2_2 then
    L2_2 = "bank"
  end
  ::lbl_14::
  L3_2 = type
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  if "string" ~= L3_2 or "" == L2_2 then
    L3_2 = Config
    L3_2 = L3_2.MoneyType
    L2_2 = L3_2 or L2_2
    if not L3_2 then
      L2_2 = "bank"
    end
  end
  L3_2 = L8_1
  L3_2 = L3_2[L2_2]
  if not L3_2 then
    L3_2 = Error
    L4_2 = "getHousePaymentMethod"
    L5_2 = "Invalid payment method, using fallback"
    L6_2 = A0_2
    L7_2 = L2_2
    L3_2(L4_2, L5_2, L6_2, L7_2)
    L3_2 = Config
    L3_2 = L3_2.MoneyType
    L2_2 = L3_2 or L2_2
    if not L3_2 then
      L2_2 = "bank"
    end
  end
  return L2_2
end
getHousePaymentMethod = L9_1
function L9_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = GetAccountMoney
  L3_2 = A0_2
  L4_2 = getHousePaymentMethod
  L5_2 = A1_2
  L4_2, L5_2 = L4_2(L5_2)
  return L2_2(L3_2, L4_2, L5_2)
end
getHouseMoney = L9_1
function L9_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = RemoveAccountMoney
  L4_2 = A0_2
  L5_2 = getHousePaymentMethod
  L6_2 = A1_2
  L5_2 = L5_2(L6_2)
  L6_2 = A2_2
  L3_2(L4_2, L5_2, L6_2)
end
removeHouseMoney = L9_1
function L9_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L4_2 = RemoveMoneyFromAccount
  L5_2 = A0_2
  L6_2 = A2_2
  L7_2 = A3_2
  L8_2 = getHousePaymentMethod
  L9_2 = A1_2
  L8_2, L9_2 = L8_2(L9_2)
  return L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
end
removeHouseMoneyFromIdentifier = L9_1
function L9_1()
  local L0_2, L1_2
  L0_2 = Config
  L0_2 = L0_2.RentScheduler
  if L0_2 then
    L1_2 = L0_2.Enabled
    if false ~= L1_2 then
      goto lbl_10
    end
  end
  L1_2 = false
  do return L1_2 end
  ::lbl_10::
  L1_2 = L0_2.Mode
  L1_2 = "monthly_utc_anniversary" == L1_2
  return L1_2
end
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = L9_1
  L0_2 = L0_2()
  if not L0_2 then
    return
  end
  L0_2 = MySQL
  L0_2 = L0_2.update
  L0_2 = L0_2.await
  L1_2 = [[
		UPDATE player_houses ph
		LEFT JOIN (
			SELECT house, MAX(`date`) AS last_rent_date
			FROM house_rents
			GROUP BY house
		) hr ON ph.house = hr.house
		SET ph.rentNextChargeAt = DATE_ADD(COALESCE(hr.last_rent_date, UTC_TIMESTAMP()), INTERVAL 1 MONTH)
		WHERE ph.rented = 1 AND ph.rentNextChargeAt IS NULL
	]]
  L0_2(L1_2)
  L0_2 = Debug
  L1_2 = "backfillRentNextChargeAt"
  L2_2 = "Backfilled missing rent due dates"
  L0_2(L1_2, L2_2)
end
function L11_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = TriggerClientEvent
  L4_2 = "housing:notification"
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = A2_2
  L3_2(L4_2, L5_2, L6_2, L7_2)
end
Notification = L11_1
L11_1 = RegisterNetEvent
L12_1 = "housing:enterHouseZone"
function L13_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = source
  L2_2 = PlayerInHouseZones
  L3_2 = PlayerInHouseZones
  L3_2 = L3_2[A0_2]
  if not L3_2 then
    L3_2 = {}
  end
  L2_2[A0_2] = L3_2
  L2_2 = PlayerInHouseZones
  L2_2 = L2_2[A0_2]
  L2_2[L1_2] = true
  L2_2 = Debug
  L3_2 = "housing:enterHouseZone"
  L4_2 = "Player entered house zone"
  L5_2 = L1_2
  L6_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2)
end
L11_1(L12_1, L13_1)
L11_1 = RegisterNetEvent
L12_1 = "housing:exitHouseZone"
function L13_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = source
  L2_2 = PlayerInHouseZones
  L2_2 = L2_2[A0_2]
  if L2_2 then
    L2_2 = PlayerInHouseZones
    L2_2 = L2_2[A0_2]
    L2_2[L1_2] = nil
    L2_2 = next
    L3_2 = PlayerInHouseZones
    L3_2 = L3_2[A0_2]
    L2_2 = L2_2(L3_2)
    if not L2_2 then
      L2_2 = PlayerInHouseZones
      L2_2[A0_2] = nil
    end
  end
  L2_2 = Debug
  L3_2 = "housing:exitHouseZone"
  L4_2 = "Player exited house zone"
  L5_2 = L1_2
  L6_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2)
end
L11_1(L12_1, L13_1)
L11_1 = RegisterNetEvent
L12_1 = "housing:server:houseAlarmSound"
function L13_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L1_2 = type
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if "string" ~= L1_2 then
    return
  end
  L1_2 = Config
  L1_2 = L1_2.Houses
  L1_2 = L1_2[A0_2]
  if L1_2 then
    L2_2 = L1_2.coords
    if L2_2 then
      L2_2 = L1_2.coords
      L2_2 = L2_2.enter
      if L2_2 then
        goto lbl_20
      end
    end
  end
  do return end
  ::lbl_20::
  L2_2 = table
  L2_2 = L2_2.includes
  L3_2 = L1_2.upgrades
  if not L3_2 then
    L3_2 = {}
  end
  L4_2 = "alarm"
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    return
  end
  L2_2 = L1_2.coords
  L2_2 = L2_2.enter
  L3_2 = vector3
  L4_2 = L2_2.x
  L5_2 = L2_2.y
  L6_2 = L2_2.z
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = Config
  L4_2 = L4_2.HouseAlarmDurationMs
  if not L4_2 then
    L4_2 = 35000
  end
  L5_2 = Config
  L5_2 = L5_2.HouseAlarmHearRange
  if not L5_2 then
    L5_2 = 80.0
  end
  L6_2 = ipairs
  L7_2 = GetPlayers
  L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L7_2()
  L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
    L12_2 = tonumber
    L13_2 = L11_2
    L12_2 = L12_2(L13_2)
    if L12_2 then
      L13_2 = GetPlayerPed
      L14_2 = L12_2
      L13_2 = L13_2(L14_2)
      if L13_2 and 0 ~= L13_2 then
        L14_2 = GetEntityCoords
        L15_2 = L13_2
        L14_2 = L14_2(L15_2)
        L15_2 = L14_2 - L3_2
        L15_2 = #L15_2
        if L5_2 >= L15_2 then
          L15_2 = TriggerClientEvent
          L16_2 = "housing:client:houseAlarmSound"
          L17_2 = L12_2
          L18_2 = L3_2
          L19_2 = L4_2
          L20_2 = L5_2
          L15_2(L16_2, L17_2, L18_2, L19_2, L20_2)
        end
      end
    end
  end
end
L11_1(L12_1, L13_1)
function L11_1(A0_2, A1_2, ...)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = PlayerInHouseZones
  L2_2 = L2_2[A0_2]
  if not L2_2 then
    return
  end
  L3_2 = pairs
  L4_2 = L2_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2 in L3_2, L4_2, L5_2, L6_2 do
    L8_2 = TriggerClientEvent
    L9_2 = A1_2
    L10_2 = L7_2
    L11_2 = ...
    L8_2(L9_2, L10_2, L11_2)
  end
end
BroadcastToPlayersInHouseZone = L11_1
function L11_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = A0_2.coords
  L1_2 = L1_2.PolyZone
  L1_2 = L1_2.thickness
  if not L1_2 then
    L1_2 = A0_2.coords
    L1_2 = L1_2.PolyZone
    L1_2.thickness = 600.0
  end
  L1_2 = A0_2.coords
  L1_2 = L1_2.PolyZone
  L1_2 = L1_2.points
  if L1_2 then
    L1_2 = pairs
    L2_2 = A0_2.coords
    L2_2 = L2_2.PolyZone
    L2_2 = L2_2.points
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = A0_2.coords
      L7_2 = L7_2.PolyZone
      L7_2 = L7_2.points
      L8_2 = vec3
      L9_2 = L6_2.x
      L10_2 = L6_2.y
      L11_2 = L6_2.z
      if not L11_2 then
        L11_2 = 0.0
      end
      L8_2 = L8_2(L9_2, L10_2, L11_2)
      L7_2[L5_2] = L8_2
    end
  end
  L1_2 = {}
  L2_2 = A0_2.mlo
  if L2_2 then
    L2_2 = pairs
    L3_2 = A0_2.mlo
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = L7_2.coords
      if not L8_2 then
        L8_2 = pairs
        L9_2 = L7_2
        L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
        for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
          L14_2 = table
          L14_2 = L14_2.insert
          L15_2 = L1_2
          L16_2 = L13_2
          L14_2(L15_2, L16_2)
        end
      else
        L1_2 = A0_2.mlo
      end
    end
    A0_2.mlo = L1_2
  end
  L2_2 = A0_2.coords
  L2_2 = L2_2.shellCoords
  if not L2_2 then
    L2_2 = A0_2.coords
    L2_2 = L2_2.interiorCoords
    if L2_2 then
      L2_2 = A0_2.coords
      L3_2 = vec4
      L4_2 = A0_2.coords
      L4_2 = L4_2.interiorCoords
      L4_2 = L4_2.x
      L5_2 = A0_2.coords
      L5_2 = L5_2.interiorCoords
      L5_2 = L5_2.y
      L6_2 = A0_2.coords
      L6_2 = L6_2.interiorCoords
      L6_2 = L6_2.z
      L7_2 = A0_2.coords
      L7_2 = L7_2.interiorCoords
      L7_2 = L7_2.w
      if not L7_2 then
        L7_2 = A0_2.coords
        L7_2 = L7_2.interiorCoords
        L7_2 = L7_2.h
      end
      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
      L2_2.shellCoords = L3_2
    end
  end
  return A0_2
end
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = A1_2.mlo
  if L2_2 then
    L2_2 = json
    L2_2 = L2_2.decode
    L3_2 = A1_2.mlo
    L2_2 = L2_2(L3_2)
    if L2_2 then
      goto lbl_11
    end
  end
  L2_2 = false
  ::lbl_11::
  L3_2 = A1_2.ipl
  if L3_2 then
    L3_2 = json
    L3_2 = L3_2.decode
    L4_2 = A1_2.ipl
    L3_2 = L3_2(L4_2)
    if L3_2 then
      goto lbl_21
    end
  end
  L3_2 = false
  ::lbl_21::
  L4_2 = A1_2.garage
  if nil ~= L4_2 then
    L4_2 = json
    L4_2 = L4_2.decode
    L5_2 = A1_2.garage
    L4_2 = L4_2(L5_2)
    if L4_2 then
      goto lbl_32
    end
  end
  L4_2 = {}
  ::lbl_32::
  L5_2 = A1_2.garageShell
  if L5_2 then
    L5_2 = json
    L5_2 = L5_2.decode
    L6_2 = A1_2.garageShell
    L5_2 = L5_2(L6_2)
    if L5_2 then
      goto lbl_43
    end
  end
  L5_2 = {}
  ::lbl_43::
  L6_2 = A1_2.has_owner
  L6_2 = 1 == L6_2
  L7_2 = A1_2.id
  if not L7_2 then
    L7_2 = Error
    L8_2 = "House id is not set, for this house"
    L9_2 = A1_2.name
    L10_2 = "We set randomly id"
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = math
    L7_2 = L7_2.random
    L8_2 = 1
    L9_2 = 1000000
    L7_2 = L7_2(L8_2, L9_2)
    A1_2.id = L7_2
  end
  L7_2 = {}
  L8_2 = A1_2.id
  L7_2.id = L8_2
  L8_2 = json
  L8_2 = L8_2.decode
  L9_2 = A1_2.coords
  L8_2 = L8_2(L9_2)
  L7_2.coords = L8_2
  L7_2.owned = L6_2
  L8_2 = A1_2.price
  L7_2.price = L8_2
  L8_2 = A1_2.defaultPrice
  L7_2.defaultPrice = L8_2
  L7_2.locked = true
  L8_2 = A1_2.label
  L7_2.address = L8_2
  L8_2 = A1_2.tier
  L7_2.tier = L8_2
  L7_2.garage = L4_2
  L7_2.mlo = L2_2
  L7_2.ipl = L3_2
  L8_2 = A1_2.creator
  L7_2.creator = L8_2
  L8_2 = A1_2.board
  if L8_2 then
    L8_2 = json
    L8_2 = L8_2.decode
    L9_2 = A1_2.board
    L8_2 = L8_2(L9_2)
    if L8_2 then
      goto lbl_96
    end
  end
  L8_2 = nil
  ::lbl_96::
  L7_2.board = L8_2
  L8_2 = A1_2.creatorJob
  L7_2.creatorJob = L8_2
  L8_2 = A1_2.blip
  if L8_2 then
    L8_2 = json
    L8_2 = L8_2.decode
    L9_2 = A1_2.blip
    L8_2 = L8_2(L9_2)
    if L8_2 then
      goto lbl_109
    end
  end
  L8_2 = nil
  ::lbl_109::
  L7_2.blip = L8_2
  L8_2 = A1_2.permissions
  if L8_2 then
    L8_2 = json
    L8_2 = L8_2.decode
    L9_2 = A1_2.permissions
    L8_2 = L8_2(L9_2)
    if L8_2 then
      goto lbl_120
    end
  end
  L8_2 = nil
  ::lbl_120::
  L7_2.permissions = L8_2
  L8_2 = A1_2.upgrades
  if L8_2 then
    L8_2 = json
    L8_2 = L8_2.decode
    L9_2 = A1_2.upgrades
    L8_2 = L8_2(L9_2)
    if L8_2 then
      goto lbl_131
    end
  end
  L8_2 = nil
  ::lbl_131::
  L7_2.upgrades = L8_2
  L8_2 = A1_2.name
  L9_2 = L8_2
  L8_2 = L8_2.match
  L10_2 = "apt%-%d+"
  L8_2 = L8_2(L9_2, L10_2)
  L7_2.apartmentNumber = L8_2
  L8_2 = A1_2.name
  L9_2 = L8_2
  L8_2 = L8_2.gsub
  L10_2 = "-apt%-%d+"
  L11_2 = ""
  L8_2 = L8_2(L9_2, L10_2, L11_2)
  L7_2.apartmentName = L8_2
  L8_2 = A1_2.apartmentCount
  if 0 ~= L8_2 then
    L8_2 = A1_2.apartmentCount
    if L8_2 then
      goto lbl_150
    end
  end
  L8_2 = nil
  ::lbl_150::
  L7_2.apartmentCount = L8_2
  L8_2 = A1_2.paymentMethod
  if not L8_2 then
    L8_2 = "cash"
  end
  L7_2.paymentMethod = L8_2
  L8_2 = A1_2.doorbellSound
  if L8_2 then
    L8_2 = A1_2.doorbellSound
    if "" ~= L8_2 then
      L8_2 = A1_2.doorbellSound
      if L8_2 then
        goto lbl_166
      end
    end
  end
  L8_2 = nil
  ::lbl_166::
  L7_2.doorbellSound = L8_2
  L8_2 = L5_1
  L9_2 = A1_2.assistantZoneMessagesEnabled
  L10_2 = true
  L8_2 = L8_2(L9_2, L10_2)
  L7_2.assistantZoneMessagesEnabled = L8_2
  L8_2 = L5_1
  L9_2 = A1_2.allowPlantInside
  L10_2 = true
  L8_2 = L8_2(L9_2, L10_2)
  L7_2.allowPlantInside = L8_2
  L8_2 = L5_1
  L9_2 = A1_2.allowPlantOutside
  L10_2 = true
  L8_2 = L8_2(L9_2, L10_2)
  L7_2.allowPlantOutside = L8_2
  L8_2 = A1_2.photos
  if L8_2 then
    L8_2 = json
    L8_2 = L8_2.decode
    L9_2 = A1_2.photos
    L8_2 = L8_2(L9_2)
    if L8_2 then
      goto lbl_193
    end
  end
  L8_2 = {}
  ::lbl_193::
  L7_2.photos = L8_2
  L8_2 = A1_2.description
  if not L8_2 then
    L8_2 = ""
  end
  L7_2.description = L8_2
  L8_2 = A1_2.hideFromBrowser
  L7_2.hideFromBrowser = L8_2
  L8_2 = L11_1
  L9_2 = L7_2
  L8_2 = L8_2(L9_2)
  L7_2 = L8_2
  L8_2 = HouseGarages
  L9_2 = A1_2.name
  L10_2 = {}
  L11_2 = A1_2.label
  L10_2.label = L11_2
  L10_2.takeVehicle = L4_2
  L10_2.shell = L5_2
  L8_2[L9_2] = L10_2
  return L7_2
end
function L13_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = {}
  L1_2 = type
  L2_2 = Config
  L2_2 = L2_2.Houses
  L1_2 = L1_2(L2_2)
  if "table" ~= L1_2 then
    L1_2 = LoopError
    L2_2 = "Config.Houses is not a table, please check your config."
    L3_2 = Config
    L3_2 = L3_2.Houses
    L1_2(L2_2, L3_2)
    return
  end
  L1_2 = pairs
  L2_2 = Config
  L2_2 = L2_2.Houses
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = L6_2.coords
    if L7_2 then
      L7_2 = L7_2.PolyZone
    end
    if not L7_2 then
      L7_2 = Error
      L8_2 = "Please add PolyZone to this house, otherwise you cant use this house."
      L9_2 = L5_2
      L7_2(L8_2, L9_2)
    else
      L7_2 = L6_2.coords
      if L7_2 then
        L7_2 = L7_2.exit
      end
      if not L7_2 then
        L7_2 = Error
        L8_2 = "Please add exit coords to this house, otherwise you cant use this house."
        L9_2 = L5_2
        L7_2(L8_2, L9_2)
      else
        L7_2 = L6_2.coords
        if L7_2 then
          L7_2 = L7_2.shellCoords
        end
        if not L7_2 then
          L7_2 = Error
          L8_2 = "Please add shellCoords to this house, otherwise you cant use this house."
          L9_2 = L5_2
          L7_2(L8_2, L9_2)
        else
          L7_2 = L6_2.coords
          if L7_2 then
            L7_2 = L7_2.interiorCoords
          end
          if not L7_2 then
            L7_2 = Error
            L8_2 = "Please add interiorCoords to this house, otherwise you cant use this house."
            L9_2 = L5_2
            L7_2(L8_2, L9_2)
          else
            L7_2 = HouseGarages
            L8_2 = {}
            L8_2.label = L5_2
            L9_2 = L6_2.garage
            L8_2.takeVehicle = L9_2
            L9_2 = L6_2.garageShell
            L8_2.shell = L9_2
            L7_2[L5_2] = L8_2
            if L6_2 then
              L7_2 = L6_2.assistantZoneMessagesEnabled
              L7_2 = false ~= L7_2
              L6_2.assistantZoneMessagesEnabled = L7_2
              L7_2 = L6_2.allowPlantInside
              L7_2 = false ~= L7_2
              L6_2.allowPlantInside = L7_2
              L7_2 = L6_2.allowPlantOutside
              L7_2 = false ~= L7_2
              L6_2.allowPlantOutside = L7_2
              L0_2[L5_2] = L6_2
            end
          end
        end
      end
    end
  end
  L1_2 = [[
		SELECT houselocations.*,
		       CASE WHEN player_houses.house IS NOT NULL THEN 1 ELSE 0 END as has_owner
		FROM houselocations
		LEFT JOIN player_houses ON houselocations.name = player_houses.house
	]]
  L2_2 = MySQL
  L2_2 = L2_2.Sync
  L2_2 = L2_2.fetchAll
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = L2_2[1]
  if L3_2 then
    L3_2 = Debug
    L4_2 = "InitHouses"
    L5_2 = "Found houses in database, initializing.."
    L3_2(L4_2, L5_2)
    L3_2 = pairs
    L4_2 = L2_2
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = L8_2.name
      L10_2 = L12_1
      L11_2 = L7_2
      L12_2 = L8_2
      L10_2 = L10_2(L11_2, L12_2)
      L0_2[L9_2] = L10_2
    end
  end
  L3_2 = Config
  L3_2.Houses = L0_2
  L3_2 = TriggerHouseUpdateGarage
  L4_2 = HouseGarages
  L3_2(L4_2)
  L3_2 = Debug
  L4_2 = "Initialized houses"
  L5_2 = #L2_2
  L3_2(L4_2, L5_2)
end
InitHouses = L13_1
L13_1 = RegisterNetEvent
L14_1 = "housing:playerConnected"
function L15_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = source
  while true do
    L1_2 = L0_1
    if L1_2 then
      break
    end
    L1_2 = Error
    L2_2 = "Waiting for houses to be initialized"
    L1_2(L2_2)
    L1_2 = Wait
    L2_2 = 100
    L1_2(L2_2)
  end
  L1_2 = HandleLoadPlayer
  L2_2 = L0_2
  L1_2(L2_2)
  L1_2 = TriggerClientEvent
  L2_2 = "housing:syncFurnitureData"
  L3_2 = L0_2
  L4_2 = Config
  L4_2 = L4_2.Furniture
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = TriggerClientEvent
  L2_2 = "housing:syncFurnitureShops"
  L3_2 = L0_2
  L4_2 = Config
  L4_2 = L4_2.FurnitureShops
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = GetIdentifier
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
  end
  L2_2 = Debug
  L3_2 = "housing:playerConnected"
  L4_2 = L0_2
  L2_2(L3_2, L4_2)
end
L13_1(L14_1, L15_1)
L13_1 = CreateThread
function L14_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = L6_1
  L0_2()
  L0_2 = L7_1
  L0_2()
  L0_2 = L10_1
  L0_2()
  L0_2 = MySQL
  L0_2 = L0_2.Sync
  L0_2 = L0_2.fetchAll
  L1_2 = "SELECT * FROM house_objects"
  L0_2 = L0_2(L1_2)
  L1_2 = pairs
  L2_2 = L0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = json
    L7_2 = L7_2.decode
    L8_2 = L6_2.coords
    L7_2 = L7_2(L8_2)
    L6_2.coords = L7_2
    L7_2 = L6_2.created
    if L7_2 then
      L7_2 = os
      L7_2 = L7_2.time
      L8_2 = os
      L8_2 = L8_2.date
      L9_2 = "*t"
      L10_2 = math
      L10_2 = L10_2.floor
      L11_2 = L6_2.created
      L11_2 = L11_2 / 1000
      L10_2, L11_2 = L10_2(L11_2)
      L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2, L10_2, L11_2)
      L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
      L6_2.created = L7_2
    end
    L7_2 = L6_2.construction
    if L7_2 then
      L7_2 = Config
      L7_2 = L7_2.Constructions
      L8_2 = L6_2.construction
      L7_2 = L7_2[L8_2]
    end
    L6_2.construction = L7_2
  end
  L1_1 = L0_2
  L1_2 = Debug
  L2_2 = "Initialized house objects"
  L3_2 = L1_1
  L1_2(L2_2, L3_2)
  L1_2 = InitHouses
  L1_2()
  L1_2 = true
  L0_1 = L1_2
end
L13_1(L14_1)
function L13_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = [[
		SELECT houselocations.*,
		       CASE WHEN player_houses.house IS NOT NULL THEN 1 ELSE 0 END as has_owner
		FROM houselocations
		LEFT JOIN player_houses ON houselocations.name = player_houses.house
		WHERE houselocations.name = ?
	]]
  L2_2 = MySQL
  L2_2 = L2_2.Sync
  L2_2 = L2_2.fetchAll
  L3_2 = L1_2
  L4_2 = {}
  L5_2 = A0_2
  L4_2[1] = L5_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = L2_2[1]
  if not L3_2 then
    L3_2 = Error
    L4_2 = "InitHouse"
    L5_2 = "House not found"
    L6_2 = A0_2
    return L3_2(L4_2, L5_2, L6_2)
  end
  L3_2 = Config
  L3_2 = L3_2.Houses
  L4_2 = L12_1
  L5_2 = 1
  L6_2 = L2_2[1]
  L4_2 = L4_2(L5_2, L6_2)
  L3_2[A0_2] = L4_2
  L3_2 = Debug
  L4_2 = "config.garage"
  L5_2 = Config
  L5_2 = L5_2.Garage
  L3_2(L4_2, L5_2)
  L3_2 = TriggerClientEvent
  L4_2 = "housing:setHouse"
  L5_2 = -1
  L6_2 = A0_2
  L7_2 = Config
  L7_2 = L7_2.Houses
  L7_2 = L7_2[A0_2]
  L3_2(L4_2, L5_2, L6_2, L7_2)
  L3_2 = TriggerAddHouseGarage
  L4_2 = A0_2
  L5_2 = HouseGarages
  L5_2 = L5_2[A0_2]
  L3_2(L4_2, L5_2)
  L3_2 = Debug
  L4_2 = "InitHouse"
  L5_2 = "Initialized house"
  L6_2 = A0_2
  L7_2 = Config
  L7_2 = L7_2.Houses
  L7_2 = L7_2[A0_2]
  L3_2(L4_2, L5_2, L6_2, L7_2)
end
InitHouse = L13_1
function L13_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = TriggerHouseUpdateGarage
  L2_2 = HouseGarages
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
  L1_2 = TriggerLatentClientEvent
  L2_2 = "housing:initHouses"
  L3_2 = A0_2
  L4_2 = 10485760
  L5_2 = Config
  L5_2 = L5_2.Houses
  L1_2(L2_2, L3_2, L4_2, L5_2)
  L1_2 = TriggerClientEvent
  L2_2 = "qb-houses:SetIplData"
  L3_2 = A0_2
  L4_2 = iplHouses
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = Debug
  L2_2 = "PlayerLoaded"
  L3_2 = "Player Loaded: "
  L4_2 = A0_2
  L1_2(L2_2, L3_2, L4_2)
end
HandleLoadPlayer = L13_1
L13_1 = RegisterCommand
L14_1 = "houseload"
function L15_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = A0_2
  L4_2 = HandleLoadPlayer
  L5_2 = L3_2
  L4_2(L5_2)
end
L13_1(L14_1, L15_1)
L13_1 = {}
PlayerDefaultRoutings = L13_1
L13_1 = {}
HouseRoutings = L13_1
L13_1 = RegisterNetEvent
L14_1 = "housing:routePlayerToDefault"
function L15_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = source
  L2_2 = RouteDefault
  L3_2 = L1_2
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
end
L13_1(L14_1, L15_1)
L13_1 = RegisterNetEvent
L14_1 = "housing:toggleInSecurityCam"
function L15_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = source
  L2_2 = Debug
  L3_2 = "housing:toggleInSecurityCam"
  L4_2 = "Toggling security cam"
  L5_2 = A0_2
  L2_2(L3_2, L4_2, L5_2)
  if not A0_2 then
    L2_2 = L4_1
    L2_2[L1_2] = nil
    L2_2 = TriggerClientEvent
    L3_2 = "housing:toggleInSecurityCam"
    L4_2 = -1
    L5_2 = L1_2
    L6_2 = "deleted"
    L2_2(L3_2, L4_2, L5_2, L6_2)
    return
  end
  L2_2 = TriggerClientEvent
  L3_2 = "housing:toggleInSecurityCam"
  L4_2 = -1
  L5_2 = L1_2
  L6_2 = true
  L2_2(L3_2, L4_2, L5_2, L6_2)
end
L13_1(L14_1, L15_1)
L13_1 = RegisterServerCallback
L14_1 = "qb-houses:server:GetHouseObjects"
function L15_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = A0_2
  L3_2 = A1_2
  L4_2 = L1_1
  L3_2(L4_2)
end
L13_1(L14_1, L15_1)
function L13_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = GetIdentifier
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = {}
  L3_2.creator = L2_2
  L4_2 = A1_2.coords
  L3_2.coords = L4_2
  L4_2 = A1_2.model
  L3_2.model = L4_2
  L4_2 = A1_2.house
  L3_2.house = L4_2
  L4_2 = os
  L4_2 = L4_2.time
  L4_2 = L4_2()
  L3_2.created = L4_2
  L4_2 = Config
  L4_2 = L4_2.Construction
  if L4_2 then
    L4_2 = Config
    L4_2 = L4_2.Constructions
    L5_2 = A1_2.model
    L4_2 = L4_2[L5_2]
    L3_2.construction = L4_2
  end
  L4_2 = MySQL
  L4_2 = L4_2.Sync
  L4_2 = L4_2.fetchAll
  L5_2 = "INSERT INTO house_objects (creator, coords, model, house, construction) VALUES (?, ?, ?, ?, ?)"
  L6_2 = {}
  L7_2 = L2_2
  L8_2 = json
  L8_2 = L8_2.encode
  L9_2 = A1_2.coords
  L8_2 = L8_2(L9_2)
  L9_2 = A1_2.model
  L10_2 = A1_2.house
  if not L10_2 then
    L10_2 = ""
  end
  L11_2 = L3_2.construction
  if L11_2 then
    L11_2 = A1_2.model
    if L11_2 then
      goto lbl_49
    end
  end
  L11_2 = nil
  ::lbl_49::
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L6_2[3] = L9_2
  L6_2[4] = L10_2
  L6_2[5] = L11_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = L4_2.insertId
  L3_2.id = L5_2
  L5_2 = table
  L5_2 = L5_2.insert
  L6_2 = L1_1
  L7_2 = L3_2
  L5_2(L6_2, L7_2)
  L5_2 = TriggerClientEvent
  L6_2 = "qb-houses:client:createHouseObject"
  L7_2 = -1
  L8_2 = L3_2
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = Debug
  L6_2 = "qb-houses:server:createHouseObject"
  L7_2 = "Created house object"
  L8_2 = L3_2
  L5_2(L6_2, L7_2, L8_2)
end
CreateHouseObject = L13_1
function L13_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = MySQL
  L1_2 = L1_2.query
  L1_2 = L1_2.await
  L2_2 = "DELETE FROM house_objects WHERE house = ?"
  L3_2 = {}
  L4_2 = A0_2
  L3_2[1] = L4_2
  L1_2(L2_2, L3_2)
  L1_2 = table
  L1_2 = L1_2.filter
  L2_2 = L1_1
  function L3_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.house
    L2_3 = A0_2
    L1_3 = L1_3 ~= L2_3
    return L1_3
  end
  L1_2 = L1_2(L2_2, L3_2)
  L1_1 = L1_2
  L1_2 = TriggerClientEvent
  L2_2 = "housing:deleteHouseObject"
  L3_2 = -1
  L4_2 = A0_2
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = Debug
  L2_2 = "housing:deleteHouseObject"
  L3_2 = "Deleted house object"
  L4_2 = A0_2
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = true
  return L1_2
end
DeleteHouseObject = L13_1
L13_1 = {}
L14_1 = RegisterNetEvent
L15_1 = "qb-houses:UpdateDecoMode"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = source
  L3_2 = L13_1
  L4_2 = {}
  L4_2.src = L2_2
  L4_2.upval = A1_2
  L3_2[A0_2] = L4_2
end
L14_1(L15_1, L16_1)
L14_1 = RegisterServerCallback
L15_1 = "qb-houses:GetDecoMode"
function L16_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2
  L3_2 = L13_1
  if L3_2 then
    L3_2 = L3_2[A2_2]
    if L3_2 then
      L3_2 = L3_2.upval
    end
  end
  if L3_2 then
    L3_2 = A1_2
    L4_2 = false
    return L3_2(L4_2)
  end
  L3_2 = A1_2
  L4_2 = true
  L3_2(L4_2)
end
L14_1(L15_1, L16_1)
L14_1 = AddEventHandler
L15_1 = "playerDropped"
function L16_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L1_2 = source
  L2_2 = L4_1
  L2_2 = L2_2[L1_2]
  if L2_2 then
    L2_2 = L4_1
    L2_2[L1_2] = nil
    L2_2 = TriggerClientEvent
    L3_2 = "housing:toggleInSecurityCam"
    L4_2 = -1
    L5_2 = L1_2
    L6_2 = "deleted"
    L2_2(L3_2, L4_2, L5_2, L6_2)
  end
  L2_2 = pairs
  L3_2 = L13_1
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = L7_2.src
    if L8_2 == L1_2 then
      L8_2 = L13_1
      L8_2[L6_2] = nil
    end
  end
  L2_2 = pairs
  L3_2 = HouseRoutings
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = L7_2.players
    L9_2 = pairs
    L10_2 = L8_2
    L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
    for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
      if L14_2 == L1_2 then
        L15_2 = table
        L15_2 = L15_2.remove
        L16_2 = L8_2
        L17_2 = L13_2
        L15_2(L16_2, L17_2)
      end
    end
    L9_2 = #L8_2
    if 0 == L9_2 then
      L9_2 = HouseRoutings
      L9_2[L6_2] = nil
    end
  end
  L2_2 = PlayerDefaultRoutings
  L2_2[L1_2] = nil
  L2_2 = pairs
  L3_2 = PlayerInHouseZones
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = L7_2[L1_2]
    if L8_2 then
      L8_2 = PlayerInHouseZones
      L9_2 = table
      L9_2 = L9_2.filter
      L10_2 = L7_2
      function L11_2(A0_3, A1_3)
        local L2_3
        L2_3 = L1_2
        L2_3 = A1_3 ~= L2_3
        return L2_3
      end
      L9_2 = L9_2(L10_2, L11_2)
      L8_2[L6_2] = L9_2
    end
  end
end
L14_1(L15_1, L16_1)
L14_1 = RegisterNetEvent
L15_1 = "qb-houses:SyncDoor"
function L16_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L3_2 = source
  L4_2 = type
  L5_2 = A1_2
  L4_2 = L4_2(L5_2)
  if "table" ~= L4_2 then
    L4_2 = {}
    L5_2 = A1_2
    L4_2[1] = L5_2
    A1_2 = L4_2
  end
  L4_2 = Debug
  L5_2 = "sync doors"
  L6_2 = A2_2
  L7_2 = "mlo"
  L8_2 = Config
  L8_2 = L8_2.Houses
  L8_2 = L8_2[A0_2]
  L8_2 = L8_2.mlo
  L9_2 = "doors"
  L10_2 = A1_2
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = pairs
  L5_2 = A1_2
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = table
    L10_2 = L10_2.find
    L11_2 = Config
    L11_2 = L11_2.Houses
    L11_2 = L11_2[A0_2]
    L11_2 = L11_2.mlo
    function L12_2(A0_3)
      local L1_3, L2_3
      L1_3 = A0_3.tempHandle
      L2_3 = L9_2.tempHandle
      L1_3 = L1_3 == L2_3
      return L1_3
    end
    L10_2, L11_2 = L10_2(L11_2, L12_2)
    L12_2 = Debug
    L13_2 = "door"
    L14_2 = L10_2
    L15_2 = L11_2
    L12_2(L13_2, L14_2, L15_2)
    if L10_2 then
      L12_2 = Config
      L12_2 = L12_2.Houses
      L12_2 = L12_2[A0_2]
      L12_2 = L12_2.mlo
      L12_2 = L12_2[L11_2]
      L12_2.locked = A2_2
    end
  end
  L4_2 = MySQL
  L4_2 = L4_2.Sync
  L4_2 = L4_2.execute
  L5_2 = "UPDATE houselocations SET mlo = ? WHERE name = ?"
  L6_2 = {}
  L7_2 = json
  L7_2 = L7_2.encode
  L8_2 = Config
  L8_2 = L8_2.Houses
  L8_2 = L8_2[A0_2]
  L8_2 = L8_2.mlo
  L7_2 = L7_2(L8_2)
  L8_2 = A0_2
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L4_2(L5_2, L6_2)
  L4_2 = TriggerClientEvent
  L5_2 = "housing:updateHouseData"
  L6_2 = -1
  L7_2 = A0_2
  L8_2 = "mlo"
  L9_2 = Config
  L9_2 = L9_2.Houses
  L9_2 = L9_2[A0_2]
  L9_2 = L9_2.mlo
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
end
L14_1(L15_1, L16_1)
L14_1 = RegisterNetEvent
L15_1 = "qb-houses:mloToggleAllDoors"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = source
  L3_2 = pairs
  L4_2 = Config
  L4_2 = L4_2.Houses
  L4_2 = L4_2[A0_2]
  L4_2 = L4_2.mlo
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = Config
    L9_2 = L9_2.Houses
    L9_2 = L9_2[A0_2]
    L9_2 = L9_2.mlo
    L9_2 = L9_2[L7_2]
    L9_2.locked = A1_2
  end
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.execute
  L4_2 = "UPDATE houselocations SET mlo = ? WHERE name = ?"
  L5_2 = {}
  L6_2 = json
  L6_2 = L6_2.encode
  L7_2 = Config
  L7_2 = L7_2.Houses
  L7_2 = L7_2[A0_2]
  L7_2 = L7_2.mlo
  L6_2 = L6_2(L7_2)
  L7_2 = A0_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2(L4_2, L5_2)
  L3_2 = TriggerClientEvent
  L4_2 = "housing:updateHouseData"
  L5_2 = -1
  L6_2 = A0_2
  L7_2 = "mlo"
  L8_2 = Config
  L8_2 = L8_2.Houses
  L8_2 = L8_2[A0_2]
  L8_2 = L8_2.mlo
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
end
L14_1(L15_1, L16_1)
L14_1 = RegisterServerCallback
L15_1 = "qb-phone:server:GetPlayerHouses"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2
  L2_2 = A0_2
  L3_2 = GetIdentifier
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = GetCharacterName
  L5_2 = L2_2
  L4_2, L5_2 = L4_2(L5_2)
  L6_2 = {}
  L6_2.firstname = L4_2
  L6_2.lastname = L5_2
  if not L6_2 then
    L7_2 = print
    L8_2 = "name not exists"
    L7_2(L8_2)
    L7_2 = A1_2
    L8_2 = {}
    return L7_2(L8_2)
  end
  L7_2 = {}
  L8_2 = MySQL
  L8_2 = L8_2.Sync
  L8_2 = L8_2.fetchAll
  L9_2 = "SELECT * FROM player_houses WHERE citizenid = ?"
  L10_2 = {}
  L11_2 = L3_2
  L10_2[1] = L11_2
  L8_2 = L8_2(L9_2, L10_2)
  if L8_2 then
    L9_2 = L8_2[1]
    if L9_2 then
      L9_2 = pairs
      L10_2 = L8_2
      L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
      for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
        L15_2 = Config
        L15_2 = L15_2.Houses
        L16_2 = L14_2.house
        L15_2 = L15_2[L16_2]
        L15_2 = L15_2.garage
        L16_2 = Config
        L16_2 = L16_2.Houses
        L17_2 = L14_2.house
        L16_2 = L16_2[L17_2]
        L16_2 = L16_2.tier
        L17_2 = #L7_2
        L17_2 = L17_2 + 1
        L18_2 = {}
        L19_2 = L14_2.house
        L18_2.name = L19_2
        L19_2 = {}
        L18_2.keyholders = L19_2
        L18_2.owner = L3_2
        L19_2 = Config
        L19_2 = L19_2.Houses
        L20_2 = L14_2.house
        L19_2 = L19_2[L20_2]
        L19_2 = L19_2.price
        L18_2.price = L19_2
        L19_2 = Config
        L19_2 = L19_2.Houses
        L20_2 = L14_2.house
        L19_2 = L19_2[L20_2]
        L19_2 = L19_2.address
        L18_2.label = L19_2
        L19_2 = L16_2 or L19_2
        if not L16_2 then
          L19_2 = ""
        end
        L18_2.tier = L19_2
        L19_2 = L15_2.x
        L19_2 = L15_2 or L19_2
        if not L19_2 or not L15_2 then
          L19_2 = nil
        end
        L18_2.garage = L19_2
        L7_2[L17_2] = L18_2
        L17_2 = L14_2.keyholders
        if "null" ~= L17_2 then
          L17_2 = json
          L17_2 = L17_2.decode
          L18_2 = L14_2.keyholders
          L17_2 = L17_2(L18_2)
          L14_2.keyholders = L17_2
          L17_2 = L14_2.keyholders
          if L17_2 then
            L17_2 = pairs
            L18_2 = L14_2.keyholders
            L17_2, L18_2, L19_2, L20_2 = L17_2(L18_2)
            for L21_2, L22_2 in L17_2, L18_2, L19_2, L20_2 do
              L23_2 = GetCharacterFromIdentifier
              L24_2 = L22_2
              L23_2, L24_2 = L23_2(L24_2)
              L25_2 = {}
              L26_2 = {}
              L26_2.firstname = L23_2
              L26_2.lastname = L24_2
              L25_2.charinfo = L26_2
              L25_2.citizenid = L22_2
              L26_2 = L23_2
              L27_2 = " "
              L28_2 = L24_2
              L26_2 = L26_2 .. L27_2 .. L28_2
              L25_2.name = L26_2
              L26_2 = L7_2[L13_2]
              L26_2 = L26_2.keyholders
              L27_2 = L7_2[L13_2]
              L27_2 = L27_2.keyholders
              L27_2 = #L27_2
              L27_2 = L27_2 + 1
              L26_2[L27_2] = L25_2
            end
          else
            L17_2 = L7_2[L13_2]
            L17_2 = L17_2.keyholders
            L18_2 = {}
            L19_2 = {}
            L20_2 = L6_2.firstname
            L19_2.firstname = L20_2
            L20_2 = L6_2.lastname
            L19_2.lastname = L20_2
            L18_2.charinfo = L19_2
            L18_2.citizenid = L3_2
            L19_2 = GetPlayerName
            L20_2 = L2_2
            L19_2 = L19_2(L20_2)
            L18_2.name = L19_2
            L17_2[1] = L18_2
          end
        else
          L17_2 = L7_2[L13_2]
          L17_2 = L17_2.keyholders
          L18_2 = {}
          L19_2 = {}
          L20_2 = L6_2.firstname
          L19_2.firstname = L20_2
          L20_2 = L6_2.lastname
          L19_2.lastname = L20_2
          L18_2.charinfo = L19_2
          L18_2.citizenid = L3_2
          L19_2 = GetPlayerName
          L20_2 = L2_2
          L19_2 = L19_2(L20_2)
          L18_2.name = L19_2
          L17_2[1] = L18_2
        end
      end
      L9_2 = SetTimeout
      L10_2 = 100
      function L11_2()
        local L0_3, L1_3
        L0_3 = A1_2
        L1_3 = L7_2
        L0_3(L1_3)
      end
      L9_2(L10_2, L11_2)
  end
  else
    L9_2 = A1_2
    L10_2 = {}
    L9_2(L10_2)
  end
end
L14_1(L15_1, L16_1)
L14_1 = RegisterServerCallback
L15_1 = "qb-phone:GetPlayerSqlName"
function L16_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = GetCharacterName
  L4_2 = A2_2
  L3_2, L4_2 = L3_2(L4_2)
  L5_2 = {}
  L5_2.firstname = L3_2
  L5_2.lastname = L4_2
  L6_2 = A1_2
  L7_2 = L5_2
  return L6_2(L7_2)
end
L14_1(L15_1, L16_1)
L14_1 = RegisterServerCallback
L15_1 = "qb-phone:server:GetHouseKeys"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L2_2 = A0_2
  L3_2 = GetIdentifier
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = {}
  L5_2 = MySQL
  L5_2 = L5_2.Sync
  L5_2 = L5_2.fetchAll
  L6_2 = "SELECT * FROM player_houses"
  L7_2 = {}
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = pairs
  L7_2 = L5_2
  L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
  for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
    L12_2 = L11_2.keyholders
    if "null" ~= L12_2 then
      L12_2 = json
      L12_2 = L12_2.decode
      L13_2 = L11_2.keyholders
      L12_2 = L12_2(L13_2)
      L11_2.keyholders = L12_2
      L12_2 = pairs
      L13_2 = L11_2.keyholders
      L12_2, L13_2, L14_2, L15_2 = L12_2(L13_2)
      for L16_2, L17_2 in L12_2, L13_2, L14_2, L15_2 do
        if L17_2 == L3_2 then
          L18_2 = L11_2.citizenid
          if L18_2 ~= L3_2 then
            L18_2 = #L4_2
            L18_2 = L18_2 + 1
            L19_2 = {}
            L20_2 = Config
            L20_2 = L20_2.Houses
            L21_2 = L11_2.house
            L20_2 = L20_2[L21_2]
            L19_2.HouseData = L20_2
            L4_2[L18_2] = L19_2
          end
        end
      end
    end
    L12_2 = L11_2.citizenid
    if L12_2 == L3_2 then
      L12_2 = #L4_2
      L12_2 = L12_2 + 1
      L13_2 = {}
      L14_2 = Config
      L14_2 = L14_2.Houses
      L15_2 = L11_2.house
      L14_2 = L14_2[L15_2]
      L13_2.HouseData = L14_2
      L4_2[L12_2] = L13_2
    end
  end
  L6_2 = A1_2
  L7_2 = L4_2
  L6_2(L7_2)
end
L14_1(L15_1, L16_1)
L14_1 = RegisterServerCallback
L15_1 = "qb-houses:buyDecorationObject"
function L16_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L3_2 = GetAccountMoney
  L4_2 = A0_2
  L5_2 = Config
  L5_2 = L5_2.MoneyType
  L3_2 = L3_2(L4_2, L5_2)
  if A2_2 <= L3_2 then
    L4_2 = RemoveAccountMoney
    L5_2 = A0_2
    L6_2 = Config
    L6_2 = L6_2.MoneyType
    L7_2 = A2_2
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = SendLog
    L5_2 = DiscordWebhook
    L6_2 = {}
    L6_2.title = "Housing"
    L6_2.description = "Player bought a decoration object"
    L7_2 = {}
    L8_2 = {}
    L8_2.name = "Player"
    L9_2 = GetPlayerName
    L10_2 = A0_2
    L9_2 = L9_2(L10_2)
    L8_2.value = L9_2
    L8_2.inline = true
    L9_2 = {}
    L9_2.name = "Price"
    L9_2.value = A2_2
    L9_2.inline = true
    L7_2[1] = L8_2
    L7_2[2] = L9_2
    L6_2.fields = L7_2
    L7_2 = WebhookColor
    L6_2.color = L7_2
    L4_2(L5_2, L6_2)
    L4_2 = A1_2
    L5_2 = true
    L4_2(L5_2)
  else
    L4_2 = A1_2
    L5_2 = false
    L4_2(L5_2)
  end
end
L14_1(L15_1, L16_1)
L14_1 = RegisterServerEvent
L15_1 = "qb-houses:server:viewHouse"
L14_1(L15_1)
L14_1 = AddEventHandler
L15_1 = "qb-houses:server:viewHouse"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L2_2 = source
  L3_2 = GetCharacterName
  L4_2 = L2_2
  L3_2, L4_2 = L3_2(L4_2)
  L5_2 = Config
  L5_2 = L5_2.Houses
  L5_2 = L5_2[A0_2]
  L5_2 = L5_2.price
  if A1_2 then
    L6_2 = MySQL
    L6_2 = L6_2.Sync
    L6_2 = L6_2.fetchAll
    L7_2 = "SELECT rentPrice FROM `player_houses` WHERE `house` = ?"
    L8_2 = {}
    L9_2 = A0_2
    L8_2[1] = L9_2
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = L6_2[1]
    if L7_2 then
      L7_2 = L6_2[1]
      L7_2 = L7_2.rentPrice
      if L7_2 then
        L7_2 = L6_2[1]
        L5_2 = L7_2.rentPrice
    end
    else
      L7_2 = print
      L8_2 = "no rent price"
      L7_2(L8_2)
      return
    end
  end
  L6_2 = tonumber
  L7_2 = L5_2
  L6_2 = L6_2(L7_2)
  L5_2 = L6_2
  L6_2 = Config
  L6_2 = L6_2.BrokerFee
  L7_2 = L5_2
  L6_2 = L6_2(L7_2)
  L7_2 = Config
  L7_2 = L7_2.BankFee
  L8_2 = L5_2
  L7_2 = L7_2(L8_2)
  L8_2 = Config
  L8_2 = L8_2.Taxes
  L9_2 = L5_2
  L8_2 = L8_2(L9_2)
  L9_2 = Config
  L9_2 = L9_2.UseMathCeilOnFees
  if L9_2 then
    L9_2 = math
    L9_2 = L9_2.ceil
    L10_2 = L6_2
    L9_2 = L9_2(L10_2)
    L6_2 = L9_2
    L9_2 = math
    L9_2 = L9_2.ceil
    L10_2 = L7_2
    L9_2 = L9_2(L10_2)
    L7_2 = L9_2
    L9_2 = math
    L9_2 = L9_2.ceil
    L10_2 = L8_2
    L9_2 = L9_2(L10_2)
    L8_2 = L9_2
    L9_2 = math
    L9_2 = L9_2.ceil
    L10_2 = L5_2
    L9_2 = L9_2(L10_2)
    L5_2 = L9_2
  end
  L9_2 = TriggerClientEvent
  L10_2 = "qb-houses:client:viewHouse"
  L11_2 = L2_2
  L12_2 = L5_2
  L13_2 = L6_2
  L14_2 = L7_2
  L15_2 = L8_2
  L16_2 = L3_2
  L17_2 = L4_2
  L18_2 = A1_2
  L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
end
L14_1(L15_1, L16_1)
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = MySQL
  L1_2 = L1_2.Sync
  L1_2 = L1_2.fetchAll
  L2_2 = "SELECT COUNT(*) as count FROM player_houses WHERE owner = ?"
  L3_2 = {}
  L4_2 = A0_2
  L3_2[1] = L4_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = L1_2[1]
  L2_2 = L2_2.count
  return L2_2
end
function L15_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  L3_2 = GetIdentifier
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L5_2 = A1_2
  L4_2 = A1_2.gsub
  L6_2 = "-apt%-%d+"
  L7_2 = ""
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = {}
  L6_2 = Config
  L6_2 = L6_2.CreatedRentableHousesManageable
  if not L6_2 then
    L3_2 = "realestate"
    L6_2 = Debug
    L7_2 = "BuyWholeApartment ::: We did set the identifier to realestate because you set CreatedRentableHousesManageable to false"
    L6_2(L7_2)
  end
  L6_2 = pairs
  L7_2 = Config
  L7_2 = L7_2.Houses
  L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
  for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
    L12_2 = L11_2.apartmentName
    if L12_2 == L4_2 then
      L12_2 = L11_2.apartmentNumber
      if "apt-0" ~= L12_2 then
        L12_2 = HouseKeyholdersList
        L13_2 = {}
        L14_2 = L3_2
        L13_2[1] = L14_2
        L12_2[L10_2] = L13_2
        L12_2 = table
        L12_2 = L12_2.insert
        L13_2 = L5_2
        L14_2 = {}
        L14_2.query = "INSERT INTO `player_houses` (`house`, `citizenid`, `owner`, `keyholders`, `credit`, `creditPrice`, `rentable`, `rentPrice`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
        L15_2 = {}
        L16_2 = L10_2
        L17_2 = L3_2
        L18_2 = L3_2
        L19_2 = json
        L19_2 = L19_2.encode
        L20_2 = HouseKeyholdersList
        L20_2 = L20_2[L10_2]
        L19_2 = L19_2(L20_2)
        L20_2 = 0
        L21_2 = 0
        L22_2 = 1
        L23_2 = A2_2
        L15_2[1] = L16_2
        L15_2[2] = L17_2
        L15_2[3] = L18_2
        L15_2[4] = L19_2
        L15_2[5] = L20_2
        L15_2[6] = L21_2
        L15_2[7] = L22_2
        L15_2[8] = L23_2
        L14_2.parameters = L15_2
        L12_2(L13_2, L14_2)
        L12_2 = HouseOwnerIdentifierList
        L12_2[L10_2] = L3_2
        L12_2 = HouseOwnerCitizenidList
        L12_2[L10_2] = L3_2
        L12_2 = OfficialHouseOwnerList
        L12_2[L10_2] = L3_2
        L12_2 = L2_1
        L12_2[L10_2] = true
        L12_2 = Config
        L12_2 = L12_2.Houses
        L12_2 = L12_2[L10_2]
        L12_2.owned = true
        L12_2 = Debug
        L13_2 = "Bought apartment"
        L14_2 = L10_2
        L15_2 = "house name"
        L16_2 = A1_2
        L12_2(L13_2, L14_2, L15_2, L16_2)
      end
    end
  end
  L6_2 = MySQL
  L6_2 = L6_2.Sync
  L6_2 = L6_2.transaction
  L7_2 = L5_2
  L6_2 = L6_2(L7_2)
  if not L6_2 then
    L7_2 = Error
    L8_2 = "BuyWholeApartment"
    L9_2 = "Failed to buy apartment"
    L10_2 = A1_2
    L7_2(L8_2, L9_2, L10_2)
    return
  end
  L7_2 = Debug
  L8_2 = "Bought whole apartment"
  L9_2 = L4_2
  L10_2 = "house name"
  L11_2 = A1_2
  L7_2(L8_2, L9_2, L10_2, L11_2)
  L7_2 = TriggerClientEvent
  L8_2 = "housing:refreshHouse"
  L9_2 = A0_2
  L10_2 = L4_2
  L11_2 = "-apt-0"
  L10_2 = L10_2 .. L11_2
  L7_2(L8_2, L9_2, L10_2)
end
BuyWholeApartment = L15_1
function L15_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2
  L5_2 = A1_2
  L4_2 = A1_2.gsub
  L6_2 = "'"
  L7_2 = ""
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = L4_2
  L4_2 = L4_2.gsub
  L6_2 = "`"
  L7_2 = ""
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = L4_2
  L4_2 = L4_2.gsub
  L6_2 = "\""
  L7_2 = ""
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  A1_2 = L4_2
  L4_2 = GetIdentifier
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L5_2 = Config
  L5_2 = L5_2.Houses
  L5_2 = L5_2[A1_2]
  L6_2 = L5_2.price
  L7_2 = Config
  L7_2 = L7_2.BrokerFee
  L8_2 = L6_2
  L7_2 = L7_2(L8_2)
  L8_2 = Config
  L8_2 = L8_2.BankFee
  L9_2 = L6_2
  L8_2 = L8_2(L9_2)
  L9_2 = Config
  L9_2 = L9_2.Taxes
  L10_2 = L6_2
  L9_2 = L9_2(L10_2)
  L10_2 = math
  L10_2 = L10_2.ceil
  L11_2 = L6_2 + L7_2
  L11_2 = L11_2 + L8_2
  L11_2 = L11_2 + L9_2
  L10_2 = L10_2(L11_2)
  L11_2 = Config
  L11_2 = L11_2.CreditEq
  L11_2 = L10_2 * L11_2
  L12_2 = getHousePaymentMethod
  L13_2 = A1_2
  L12_2 = L12_2(L13_2)
  L13_2 = GetAccountMoney
  L14_2 = A0_2
  L15_2 = L12_2
  L13_2 = L13_2(L14_2, L15_2)
  L14_2 = L14_1
  L15_2 = L4_2
  L14_2 = L14_2(L15_2)
  if not A3_2 then
    L15_2 = Config
    L15_2 = L15_2.MaxOwnedHouses
    if L14_2 >= L15_2 then
      L15_2 = Notification
      L16_2 = A0_2
      L17_2 = i18n
      L17_2 = L17_2.t
      L18_2 = "max_houses_reached"
      L19_2 = {}
      L20_2 = Config
      L20_2 = L20_2.MaxOwnedHouses
      L19_2.limit = L20_2
      L17_2 = L17_2(L18_2, L19_2)
      L18_2 = "error"
      L15_2(L16_2, L17_2, L18_2)
      L15_2 = Error
      L16_2 = "BuyHouse"
      L17_2 = "Max houses reached"
      L18_2 = L14_2
      return L15_2(L16_2, L17_2, L18_2)
    end
    if not A2_2 and L10_2 > L13_2 then
      L15_2 = Notification
      L16_2 = A0_2
      L17_2 = i18n
      L17_2 = L17_2.t
      L18_2 = "no_money"
      L19_2 = {}
      L19_2.price = L10_2
      L17_2 = L17_2(L18_2, L19_2)
      L18_2 = "error"
      L15_2(L16_2, L17_2, L18_2)
      L15_2 = Error
      L16_2 = "BuyHouse"
      L17_2 = "No money"
      L18_2 = L13_2
      return L15_2(L16_2, L17_2, L18_2)
    end
    if A2_2 and L11_2 > L13_2 then
      L15_2 = Notification
      L16_2 = A0_2
      L17_2 = i18n
      L17_2 = L17_2.t
      L18_2 = "no_money"
      L19_2 = {}
      L19_2.price = L11_2
      L17_2 = L17_2(L18_2, L19_2)
      L18_2 = "error"
      L15_2(L16_2, L17_2, L18_2)
      L15_2 = Error
      L16_2 = "BuyHouse"
      L17_2 = "No credit"
      L18_2 = L13_2
      return L15_2(L16_2, L17_2, L18_2)
    end
  end
  L15_2 = MySQL
  L15_2 = L15_2.Sync
  L15_2 = L15_2.fetchAll
  L16_2 = "SELECT * FROM houselocations WHERE name = ?"
  L17_2 = {}
  L18_2 = A1_2
  L17_2[1] = L18_2
  L15_2 = L15_2(L16_2, L17_2)
  L16_2 = L15_2[1]
  if not L16_2 then
    L16_2 = Error
    L17_2 = "BuyHouse"
    L18_2 = "House not found"
    L19_2 = A1_2
    L16_2(L17_2, L18_2, L19_2)
    return
  end
  L16_2 = MySQL
  L16_2 = L16_2.Sync
  L16_2 = L16_2.fetchAll
  L17_2 = "SELECT owner, purchasable, sale_furnished FROM `player_houses` WHERE `house` = ?"
  L18_2 = {}
  L19_2 = A1_2
  L18_2[1] = L19_2
  L16_2 = L16_2(L17_2, L18_2)
  L16_2 = L16_2[1]
  L17_2 = L16_2 or L17_2
  if L16_2 then
    L17_2 = L16_2.purchasable
  end
  if L16_2 and not L17_2 then
    L18_2 = Notification
    L19_2 = A0_2
    L20_2 = i18n
    L20_2 = L20_2.t
    L21_2 = "house_already_owned"
    L20_2 = L20_2(L21_2)
    if not L20_2 then
      L20_2 = "This house is already owned!"
    end
    L21_2 = "error"
    L18_2(L19_2, L20_2, L21_2)
    L18_2 = Error
    L19_2 = "BuyHouse"
    L20_2 = "House already owned and not for sale"
    L21_2 = A1_2
    return L18_2(L19_2, L20_2, L21_2)
  end
  if L17_2 then
    L18_2 = HouseTransactionVeto
    L18_2 = L18_2.Run
    L19_2 = {}
    L19_2.action = "buy_from_player"
    L19_2.buyerSource = A0_2
    L20_2 = L16_2.owner
    L19_2.sellerIdentifier = L20_2
    L19_2.house = A1_2
    L19_2.price = L6_2
    L20_2 = A2_2 or L20_2
    if not A2_2 then
      L20_2 = false
    end
    L19_2.isCredit = L20_2
    L20_2 = L16_2.sale_furnished
    L20_2 = 1 == L20_2
    L19_2.saleFurnished = L20_2
    L18_2 = L18_2(L19_2)
    L19_2 = L18_2.allowed
    if not L19_2 then
      L19_2 = Notification
      L20_2 = A0_2
      L21_2 = L18_2.reason
      if not L21_2 then
        L21_2 = i18n
        L21_2 = L21_2.t
        L22_2 = "house_already_owned"
        L21_2 = L21_2(L22_2)
      end
      L22_2 = "error"
      L19_2(L20_2, L21_2, L22_2)
      return
    end
    L19_2 = AddMoneyToAccount
    L20_2 = L16_2.owner
    L21_2 = L6_2
    L22_2 = true
    L19_2(L20_2, L21_2, L22_2)
    L19_2 = GetPlayerFromIdentifier
    L20_2 = L16_2.owner
    L19_2 = L19_2(L20_2)
    if L19_2 then
      L20_2 = Notification
      L21_2 = A0_2
      L22_2 = i18n
      L22_2 = L22_2.t
      L23_2 = "sold_house"
      L24_2 = {}
      L24_2.price = L6_2
      L22_2 = L22_2(L23_2, L24_2)
      L23_2 = "success"
      L20_2(L21_2, L22_2, L23_2)
    end
    L20_2 = L16_2.sale_furnished
    if not L20_2 then
      L21_2 = MySQL
      L21_2 = L21_2.Sync
      L21_2 = L21_2.execute
      L22_2 = "DELETE FROM house_decorations WHERE house = ?"
      L23_2 = {}
      L24_2 = A1_2
      L23_2[1] = L24_2
      L21_2(L22_2, L23_2)
      L21_2 = ClearHouseDecoration
      L22_2 = A1_2
      L21_2(L22_2)
      L21_2 = Debug
      L22_2 = "BuyHouse"
      L23_2 = "Deleted decorations for unfurnished sale"
      L24_2 = A1_2
      L21_2(L22_2, L23_2, L24_2)
    else
      L21_2 = Debug
      L22_2 = "BuyHouse"
      L23_2 = "Keeping decorations for furnished sale"
      L24_2 = A1_2
      L21_2(L22_2, L23_2, L24_2)
    end
    L21_2 = MySQL
    L21_2 = L21_2.Sync
    L21_2 = L21_2.execute
    L22_2 = "DELETE FROM `player_houses` WHERE `house` = ?"
    L23_2 = {}
    L24_2 = A1_2
    L23_2[1] = L24_2
    L21_2(L22_2, L23_2)
    L21_2 = TriggerClientEvent
    L22_2 = "qb-houses:requiredLeaveHouse"
    L23_2 = -1
    L24_2 = A1_2
    L21_2(L22_2, L23_2, L24_2)
    L21_2 = L3_1
    L21_2[A1_2] = nil
    L21_2 = Config
    L21_2 = L21_2.Houses
    L21_2 = L21_2[A1_2]
    if L21_2 then
      L21_2 = Config
      L21_2 = L21_2.Houses
      L21_2 = L21_2[A1_2]
      L21_2.saleFurnished = nil
    end
  end
  L18_2 = Debug
  L19_2 = "BuyHouse creator got money"
  L20_2 = L15_2[1]
  L20_2 = L20_2.creatorGotMoney
  L18_2(L19_2, L20_2)
  if not L16_2 and not A3_2 then
    L18_2 = L15_2[1]
    L18_2 = L18_2.creatorGotMoney
    if not L18_2 then
      L18_2 = Config
      L18_2 = L18_2.Society
      if "none" == L18_2 then
        L18_2 = L5_2.creator
        if L18_2 then
          L18_2 = AddMoneyToAccount
          L19_2 = L5_2.creator
          L20_2 = L10_2
          L21_2 = true
          L18_2(L19_2, L20_2, L21_2)
        end
      end
      L18_2 = Config
      L18_2 = L18_2.Houses
      L18_2 = L18_2[A1_2]
      L18_2 = L18_2.creatorJob
      if L18_2 then
        L19_2 = AddMoneyToSociety
        L20_2 = A0_2
        L21_2 = L18_2
        L22_2 = Config
        L22_2 = L22_2.SocietyCommision
        L22_2 = L10_2 * L22_2
        L19_2(L20_2, L21_2, L22_2)
        L19_2 = Debug
        L20_2 = "qb-houses:server:buyHouse"
        L21_2 = "Added money to society"
        L22_2 = L18_2
        L23_2 = L10_2
        L19_2(L20_2, L21_2, L22_2, L23_2)
      else
        L19_2 = Debug
        L20_2 = "qb-houses:server:buyHouse"
        L21_2 = "No creator job"
        L22_2 = L18_2
        L19_2(L20_2, L21_2, L22_2)
      end
    end
  end
  L18_2 = nil
  if A3_2 then
    L19_2 = Config
    L19_2 = L19_2.CreatedRentableHousesManageable
    if not L19_2 then
      L18_2 = true
      L4_2 = "realestate"
      L19_2 = Debug
      L20_2 = "We did set the identifier to realestate because you set CreatedRentableHousesManageable to false"
      L19_2(L20_2)
    end
  end
  L19_2 = HouseKeyholdersList
  L20_2 = {}
  L19_2[A1_2] = L20_2
  L19_2 = HouseKeyholdersList
  L19_2 = L19_2[A1_2]
  L19_2[1] = L4_2
  if A2_2 then
    L19_2 = L10_2 - L11_2
    if L19_2 then
      goto lbl_365
    end
  end
  L19_2 = 0
  ::lbl_365::
  L20_2 = MySQL
  L20_2 = L20_2.Sync
  L20_2 = L20_2.execute
  L21_2 = "INSERT INTO `player_houses` (`house`, `citizenid`, `owner`, `keyholders`, `credit`, `creditPrice`, `rentable`, `rentPrice`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
  L22_2 = {}
  L23_2 = A1_2
  L24_2 = L4_2
  L25_2 = L4_2
  L26_2 = json
  L26_2 = L26_2.encode
  L27_2 = HouseKeyholdersList
  L27_2 = L27_2[A1_2]
  L26_2 = L26_2(L27_2)
  L27_2 = L19_2
  L28_2 = L11_2
  L29_2 = L18_2
  L30_2 = L10_2
  L22_2[1] = L23_2
  L22_2[2] = L24_2
  L22_2[3] = L25_2
  L22_2[4] = L26_2
  L22_2[5] = L27_2
  L22_2[6] = L28_2
  L22_2[7] = L29_2
  L22_2[8] = L30_2
  L20_2(L21_2, L22_2)
  L20_2 = MySQL
  L20_2 = L20_2.Sync
  L20_2 = L20_2.execute
  L21_2 = "UPDATE `houselocations` SET `creatorGotMoney` = 1 WHERE `name` = '"
  L22_2 = A1_2
  L23_2 = "'"
  L21_2 = L21_2 .. L22_2 .. L23_2
  L20_2(L21_2)
  L20_2 = HouseOwnerIdentifierList
  L20_2[A1_2] = L4_2
  L20_2 = HouseOwnerCitizenidList
  L20_2[A1_2] = L4_2
  L20_2 = OfficialHouseOwnerList
  L20_2[A1_2] = L4_2
  if L18_2 then
    L20_2 = L2_1
    L20_2[A1_2] = true
  end
  L20_2 = TriggerEvent
  L21_2 = "bb-garages:server:buyHouseGarage"
  L22_2 = A1_2
  L23_2 = L4_2
  L24_2 = A0_2
  L20_2(L21_2, L22_2, L23_2, L24_2)
  L20_2 = Debug
  L21_2 = "Bought a house for $"
  L22_2 = L10_2
  L23_2 = " House: "
  L21_2 = L21_2 .. L22_2 .. L23_2
  L22_2 = A1_2
  L23_2 = "Creator"
  L24_2 = L5_2.creator
  L20_2(L21_2, L22_2, L23_2, L24_2)
  if not A3_2 then
    L20_2 = RemoveAccountMoney
    L21_2 = A0_2
    L22_2 = L12_2
    L23_2 = L11_2 or L23_2
    if not A2_2 or not L11_2 then
      L23_2 = L10_2
    end
    L20_2(L21_2, L22_2, L23_2)
    L20_2 = TriggerEvent
    L21_2 = "housing:handleBuyHouse"
    L22_2 = A0_2
    L23_2 = A1_2
    L24_2 = L10_2
    L25_2 = A2_2
    L20_2(L21_2, L22_2, L23_2, L24_2, L25_2)
  end
  L20_2 = InitHouse
  L21_2 = A1_2
  L20_2(L21_2)
  L20_2 = GetResourceState
  L21_2 = "qs-inventory"
  L20_2 = L20_2(L21_2)
  L21_2 = L20_2
  L20_2 = L20_2.find
  L22_2 = "started"
  L20_2 = L20_2(L21_2, L22_2)
  if L20_2 then
    L20_2 = Config
    L20_2 = L20_2.EnableQuests
    if L20_2 then
      L20_2 = exports
      L20_2 = L20_2["qs-inventory"]
      L21_2 = L20_2
      L20_2 = L20_2.UpdateQuestProgress
      L22_2 = A0_2
      L23_2 = "buy_house"
      L24_2 = 100
      L20_2 = L20_2(L21_2, L22_2, L23_2, L24_2)
      if L20_2 then
        L21_2 = Debug
        L22_2 = "Quest \"buy_house\" progress updated"
        L21_2(L22_2)
      else
        L21_2 = Debug
        L22_2 = "Failed to update quest \"buy_house\""
        L21_2(L22_2)
      end
    end
  end
  L20_2 = SendLog
  L21_2 = DiscordWebhook
  L22_2 = {}
  L22_2.title = "Housing"
  L22_2.description = "Player bought a house"
  L23_2 = {}
  L24_2 = {}
  L24_2.name = "Player"
  L25_2 = GetPlayerName
  L26_2 = A0_2
  L25_2 = L25_2(L26_2)
  L24_2.value = L25_2
  L24_2.inline = true
  L25_2 = {}
  L25_2.name = "House"
  L25_2.value = A1_2
  L25_2.inline = true
  L26_2 = {}
  L26_2.name = "Price"
  L26_2.value = L10_2
  L26_2.inline = true
  L23_2[1] = L24_2
  L23_2[2] = L25_2
  L23_2[3] = L26_2
  L22_2.fields = L23_2
  L23_2 = WebhookColor
  L22_2.color = L23_2
  L20_2(L21_2, L22_2)
  L20_2 = Config
  L20_2 = L20_2.MInsurance
  if L20_2 then
    L20_2 = exports
    L20_2 = L20_2["m-Insurance"]
    L21_2 = L20_2
    L20_2 = L20_2.GiveHomeInsurance
    L22_2 = A0_2
    L23_2 = L4_2
    L24_2 = 1
    L25_2 = A1_2
    L20_2(L21_2, L22_2, L23_2, L24_2, L25_2)
  end
end
BuyHouse = L15_1
L15_1 = RegisterServerEvent
L16_1 = "qb-houses:server:buyHouse"
L15_1(L16_1)
L15_1 = AddEventHandler
L16_1 = "qb-houses:server:buyHouse"
function L17_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = source
  L3_2 = BuyHouse
  L4_2 = L2_2
  L5_2 = A0_2
  L6_2 = A1_2
  L3_2(L4_2, L5_2, L6_2)
end
L15_1(L16_1, L17_1)
function L15_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L2_2 = Config
  L2_2 = L2_2.EnableRentable
  if not L2_2 then
    L2_2 = Notification
    L3_2 = A0_2
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "rent.disabled"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = Debug
    L3_2 = "qb-houses:rentHouse"
    L4_2 = "Rentable houses are disabled"
    L2_2(L3_2, L4_2)
    L2_2 = false
    return L2_2
  end
  L2_2 = GetIdentifier
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.fetchAll
  L4_2 = "SELECT * FROM player_houses WHERE house = ? AND rentable = 1"
  L5_2 = {}
  L6_2 = A1_2
  L5_2[1] = L6_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = L3_2[1]
  if not L4_2 then
    L4_2 = Notification
    L5_2 = A0_2
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "rent.cant_rent"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = Debug
    L5_2 = "qb-houses:rentHouse"
    L6_2 = "Cant rent house"
    L7_2 = A1_2
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = false
    return L4_2
  end
  L4_2 = L3_2[1]
  L4_2 = L4_2.rentPrice
  L5_2 = getHouseMoney
  L6_2 = A0_2
  L7_2 = A1_2
  L5_2 = L5_2(L6_2, L7_2)
  if L4_2 <= L5_2 then
    L6_2 = "UPDATE player_houses SET citizenid = ?, rentable = NULL, rented = 1, keyholders = ?"
    L7_2 = {}
    L8_2 = L2_2
    L9_2 = json
    L9_2 = L9_2.encode
    L10_2 = {}
    L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L9_2(L10_2)
    L7_2[1] = L8_2
    L7_2[2] = L9_2
    L7_2[3] = L10_2
    L7_2[4] = L11_2
    L7_2[5] = L12_2
    L7_2[6] = L13_2
    L7_2[7] = L14_2
    L7_2[8] = L15_2
    L8_2 = L9_1
    L8_2 = L8_2()
    if L8_2 then
      L8_2 = L6_2
      L9_2 = ", rentNextChargeAt = DATE_ADD(UTC_TIMESTAMP(), INTERVAL 1 MONTH)"
      L8_2 = L8_2 .. L9_2
      L6_2 = L8_2
    end
    L8_2 = L6_2
    L9_2 = " WHERE id = ?"
    L8_2 = L8_2 .. L9_2
    L6_2 = L8_2
    L8_2 = #L7_2
    L8_2 = L8_2 + 1
    L9_2 = L3_2[1]
    L9_2 = L9_2.id
    L7_2[L8_2] = L9_2
    L8_2 = MySQL
    L8_2 = L8_2.Sync
    L8_2 = L8_2.execute
    L9_2 = L6_2
    L10_2 = L7_2
    L8_2(L9_2, L10_2)
    L8_2 = L2_1
    L8_2[A1_2] = nil
    L8_2 = HouseOwnerIdentifierList
    L8_2[A1_2] = L2_2
    L8_2 = HouseOwnerCitizenidList
    L8_2[A1_2] = L2_2
    L8_2 = Notification
    L9_2 = A0_2
    L10_2 = i18n
    L10_2 = L10_2.t
    L11_2 = "rent.you_rented_house"
    L10_2 = L10_2(L11_2)
    L11_2 = "success"
    L8_2(L9_2, L10_2, L11_2)
    L8_2 = TriggerClientEvent
    L9_2 = "housing:refreshHouse"
    L10_2 = -1
    L11_2 = A1_2
    L8_2(L9_2, L10_2, L11_2)
    L8_2 = Debug
    L9_2 = "qb-houses:rentHouse"
    L10_2 = "Rented house"
    L11_2 = A1_2
    L8_2(L9_2, L10_2, L11_2)
    L8_2 = SendLog
    L9_2 = DiscordWebhook
    L10_2 = {}
    L10_2.title = "Housing"
    L10_2.description = "Player rented a house"
    L11_2 = {}
    L12_2 = {}
    L12_2.name = "Player"
    L13_2 = GetPlayerName
    L14_2 = A0_2
    L13_2 = L13_2(L14_2)
    L12_2.value = L13_2
    L12_2.inline = true
    L13_2 = {}
    L13_2.name = "House"
    L13_2.value = A1_2
    L13_2.inline = true
    L14_2 = {}
    L14_2.name = "Price"
    L15_2 = L3_2[1]
    L15_2 = L15_2.rentPrice
    L14_2.value = L15_2
    L14_2.inline = true
    L11_2[1] = L12_2
    L11_2[2] = L13_2
    L11_2[3] = L14_2
    L10_2.fields = L11_2
    L11_2 = WebhookColor
    L10_2.color = L11_2
    L8_2(L9_2, L10_2)
    L8_2 = true
    return L8_2
  end
  L6_2 = Notification
  L7_2 = A0_2
  L8_2 = i18n
  L8_2 = L8_2.t
  L9_2 = "no_money"
  L10_2 = {}
  L11_2 = L3_2[1]
  L11_2 = L11_2.rentPrice
  L10_2.price = L11_2
  L8_2 = L8_2(L9_2, L10_2)
  L9_2 = "error"
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = false
  return L6_2
end
HousingRentHouse = L15_1
L15_1 = RegisterNetEvent
L16_1 = "qb-houses:rentHouse"
function L17_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = HousingRentHouse
  L2_2 = source
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L15_1(L16_1, L17_1)
function L15_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L2_2 = GetIdentifier
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.fetchAll
  L4_2 = "SELECT * FROM player_houses WHERE house = ? AND owner = ?"
  L5_2 = {}
  L6_2 = A1_2
  L7_2 = L2_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = L3_2[1]
  if not L4_2 then
    L4_2 = Notification
    L5_2 = A0_2
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "cant_sell_house"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = false
    return L4_2
  end
  L4_2 = L3_2[1]
  L4_2 = L4_2.rented
  if 1 == L4_2 then
    L4_2 = Notification
    L5_2 = A0_2
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "cant_sell_rented"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = false
    return L4_2
  end
  L4_2 = L3_2[1]
  L4_2 = L4_2.credit
  if L4_2 then
    L4_2 = tonumber
    L5_2 = L3_2[1]
    L5_2 = L5_2.credit
    L4_2 = L4_2(L5_2)
    if L4_2 > 0 then
      L4_2 = Notification
      L5_2 = A0_2
      L6_2 = i18n
      L6_2 = L6_2.t
      L7_2 = "house_has_credit"
      L6_2 = L6_2(L7_2)
      L7_2 = "error"
      L4_2(L5_2, L6_2, L7_2)
      L4_2 = false
      return L4_2
    end
  end
  L4_2 = HouseTransactionVeto
  L4_2 = L4_2.Run
  L5_2 = {}
  L5_2.action = "sell_bank"
  L5_2.source = A0_2
  L5_2.house = A1_2
  L4_2 = L4_2(L5_2)
  L5_2 = L4_2.allowed
  if not L5_2 then
    L5_2 = Notification
    L6_2 = A0_2
    L7_2 = L4_2.reason
    if not L7_2 then
      L7_2 = i18n
      L7_2 = L7_2.t
      L8_2 = "cant_sell_house"
      L7_2 = L7_2(L8_2)
    end
    L8_2 = "error"
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = false
    return L5_2
  end
  L5_2 = MySQL
  L5_2 = L5_2.Sync
  L5_2 = L5_2.execute
  L6_2 = "DELETE FROM player_houses WHERE id = ?"
  L7_2 = {}
  L8_2 = L3_2[1]
  L8_2 = L8_2.id
  L7_2[1] = L8_2
  L5_2(L6_2, L7_2)
  L5_2 = MySQL
  L5_2 = L5_2.Sync
  L5_2 = L5_2.execute
  L6_2 = "UPDATE `houselocations` SET `price` = houselocations.defaultPrice WHERE `name` = ?"
  L7_2 = {}
  L8_2 = A1_2
  L7_2[1] = L8_2
  L5_2(L6_2, L7_2)
  L5_2 = Notification
  L6_2 = A0_2
  L7_2 = i18n
  L7_2 = L7_2.t
  L8_2 = "house_sold"
  L7_2 = L7_2(L8_2)
  L8_2 = "success"
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = Config
  L5_2 = L5_2.Houses
  L5_2 = L5_2[A1_2]
  L5_2 = L5_2.defaultPrice
  L6_2 = AddAccountMoney
  L7_2 = A0_2
  L8_2 = "bank"
  L9_2 = L5_2 / 2
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = HouseOwnerCitizenidList
  L6_2[A1_2] = nil
  L6_2 = HouseOwnerIdentifierList
  L6_2[A1_2] = nil
  L6_2 = OfficialHouseOwnerList
  L6_2[A1_2] = nil
  L6_2 = HouseKeyholdersList
  L6_2[A1_2] = nil
  L6_2 = L2_1
  L6_2[A1_2] = nil
  L6_2 = L3_1
  L6_2[A1_2] = nil
  L6_2 = Config
  L6_2 = L6_2.Houses
  L6_2 = L6_2[A1_2]
  L7_2 = Config
  L7_2 = L7_2.Houses
  L7_2 = L7_2[A1_2]
  L7_2 = L7_2.defaultPrice
  L6_2.price = L7_2
  L6_2 = Config
  L6_2 = L6_2.Houses
  L6_2 = L6_2[A1_2]
  L6_2.owned = false
  L6_2 = InitHouse
  L7_2 = A1_2
  L6_2(L7_2)
  L6_2 = TriggerClientEvent
  L7_2 = "qb-houses:requiredLeaveHouse"
  L8_2 = -1
  L9_2 = A1_2
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = SendLog
  L7_2 = DiscordWebhook
  L8_2 = {}
  L8_2.title = "Housing"
  L8_2.description = "Player sold a house"
  L9_2 = {}
  L10_2 = {}
  L10_2.name = "Player"
  L11_2 = GetPlayerName
  L12_2 = A0_2
  L11_2 = L11_2(L12_2)
  L10_2.value = L11_2
  L10_2.inline = true
  L11_2 = {}
  L11_2.name = "House"
  L11_2.value = A1_2
  L11_2.inline = true
  L12_2 = {}
  L12_2.name = "Price"
  L12_2.value = L5_2
  L12_2.inline = true
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  L8_2.fields = L9_2
  L9_2 = WebhookColor
  L8_2.color = L9_2
  L6_2(L7_2, L8_2)
  L6_2 = Debug
  L7_2 = "qb-houses:sellHouse"
  L8_2 = "Sold house"
  L9_2 = A1_2
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = true
  return L6_2
end
HousingSellHouse = L15_1
L15_1 = RegisterNetEvent
L16_1 = "qb-houses:sellHouse"
function L17_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = HousingSellHouse
  L2_2 = source
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L15_1(L16_1, L17_1)
function L15_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L3_2 = GetPlayerPed
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if not L3_2 or 0 == L3_2 then
    L4_2 = false
    return L4_2
  end
  L4_2 = Config
  L4_2 = L4_2.Houses
  L4_2 = L4_2[A1_2]
  if L4_2 then
    L5_2 = L4_2.coords
    if L5_2 then
      L5_2 = L4_2.coords
      L5_2 = L5_2.enter
      if L5_2 then
        goto lbl_24
      end
    end
  end
  L5_2 = false
  do return L5_2 end
  ::lbl_24::
  L5_2 = L4_2.coords
  L5_2 = L5_2.enter
  L6_2 = L5_2.x
  if not L6_2 then
    L6_2 = L5_2[1]
  end
  L7_2 = L5_2.y
  if not L7_2 then
    L7_2 = L5_2[2]
  end
  L8_2 = L5_2.z
  if not L8_2 then
    L8_2 = L5_2[3]
    if not L8_2 then
      L8_2 = 0.0
    end
  end
  L9_2 = type
  L10_2 = L6_2
  L9_2 = L9_2(L10_2)
  if "number" == L9_2 then
    L9_2 = type
    L10_2 = L7_2
    L9_2 = L9_2(L10_2)
    if "number" == L9_2 then
      goto lbl_53
    end
  end
  L9_2 = false
  do return L9_2 end
  ::lbl_53::
  L9_2 = GetEntityCoords
  L10_2 = L3_2
  L9_2 = L9_2(L10_2)
  L10_2 = A2_2 or L10_2
  if not A2_2 then
    L10_2 = 48.0
  end
  L11_2 = vector3
  L12_2 = L6_2 + 0.0
  L13_2 = L7_2 + 0.0
  L14_2 = L8_2 + 0.0
  L11_2 = L11_2(L12_2, L13_2, L14_2)
  L11_2 = L9_2 - L11_2
  L11_2 = #L11_2
  L11_2 = L10_2 >= L11_2
  return L11_2
end
HousingPlayerNearHouseEntrance = L15_1
L15_1 = RegisterNetEvent
L16_1 = "qb-houses:sellHouseToPlayer"
function L17_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L3_2 = source
  L4_2 = GetIdentifier
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = MySQL
  L5_2 = L5_2.Sync
  L5_2 = L5_2.fetchAll
  L6_2 = "SELECT * FROM player_houses WHERE house = ? AND owner = ?"
  L7_2 = {}
  L8_2 = A0_2
  L9_2 = L4_2
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = L5_2[1]
  if not L6_2 then
    L6_2 = Notification
    L7_2 = L3_2
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "cant_sell_house"
    L8_2 = L8_2(L9_2)
    L9_2 = "error"
    return L6_2(L7_2, L8_2, L9_2)
  end
  L6_2 = L5_2[1]
  L6_2 = L6_2.rented
  if 1 == L6_2 then
    L6_2 = Notification
    L7_2 = L3_2
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "cant_sell_rented"
    L8_2 = L8_2(L9_2)
    L9_2 = "error"
    return L6_2(L7_2, L8_2, L9_2)
  end
  L6_2 = L5_2[1]
  L6_2 = L6_2.credit
  if L6_2 then
    L6_2 = tonumber
    L7_2 = L5_2[1]
    L7_2 = L7_2.credit
    L6_2 = L6_2(L7_2)
    if L6_2 > 0 then
      L6_2 = Notification
      L7_2 = L3_2
      L8_2 = i18n
      L8_2 = L8_2.t
      L9_2 = "house_has_credit"
      L8_2 = L8_2(L9_2)
      L9_2 = "error"
      return L6_2(L7_2, L8_2, L9_2)
    end
  end
  L6_2 = L2_1
  L6_2 = L6_2[A0_2]
  if L6_2 then
    L6_2 = Notification
    L7_2 = L3_2
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "cant_sell_rentable"
    L8_2 = L8_2(L9_2)
    L9_2 = "error"
    return L6_2(L7_2, L8_2, L9_2)
  end
  L6_2 = HouseTransactionVeto
  L6_2 = L6_2.Run
  L7_2 = {}
  L7_2.action = "list_player_sale"
  L7_2.source = L3_2
  L7_2.house = A0_2
  L7_2.price = A1_2
  L8_2 = A2_2 or L8_2
  if not A2_2 then
    L8_2 = {}
  end
  L7_2.saleOptions = L8_2
  L6_2 = L6_2(L7_2)
  L7_2 = L6_2.allowed
  if not L7_2 then
    L7_2 = Notification
    L8_2 = L3_2
    L9_2 = L6_2.reason
    if not L9_2 then
      L9_2 = i18n
      L9_2 = L9_2.t
      L10_2 = "cant_sell_house"
      L9_2 = L9_2(L10_2)
    end
    L10_2 = "error"
    return L7_2(L8_2, L9_2, L10_2)
  end
  if not A2_2 then
    L7_2 = {}
    A2_2 = L7_2
  end
  L7_2 = json
  L7_2 = L7_2.encode
  L8_2 = A2_2.photos
  if not L8_2 then
    L8_2 = {}
  end
  L7_2 = L7_2(L8_2)
  L8_2 = A2_2.description
  if not L8_2 then
    L8_2 = ""
  end
  L9_2 = A2_2.furnished
  if false ~= L9_2 then
    L9_2 = 1
    if L9_2 then
      goto lbl_125
    end
  end
  L9_2 = 0
  ::lbl_125::
  L10_2 = A2_2.hideFromBrowser
  if L10_2 then
    L10_2 = 1
    if L10_2 then
      goto lbl_132
    end
  end
  L10_2 = 0
  ::lbl_132::
  L11_2 = MySQL
  L11_2 = L11_2.Sync
  L11_2 = L11_2.execute
  L12_2 = "UPDATE player_houses SET purchasable = 1, sale_furnished = ? WHERE house = ?"
  L13_2 = {}
  L14_2 = L9_2
  L15_2 = A0_2
  L13_2[1] = L14_2
  L13_2[2] = L15_2
  L11_2(L12_2, L13_2)
  L11_2 = MySQL
  L11_2 = L11_2.Sync
  L11_2 = L11_2.execute
  L12_2 = [[
		UPDATE houselocations SET
			price = ?,
			photos = ?,
			description = ?,
			hideFromBrowser = ?
		WHERE name = ?
	]]
  L13_2 = {}
  L14_2 = A1_2
  L15_2 = L7_2
  L16_2 = L8_2
  L17_2 = L10_2
  L18_2 = A0_2
  L13_2[1] = L14_2
  L13_2[2] = L15_2
  L13_2[3] = L16_2
  L13_2[4] = L17_2
  L13_2[5] = L18_2
  L11_2(L12_2, L13_2)
  L11_2 = Notification
  L12_2 = L3_2
  L13_2 = i18n
  L13_2 = L13_2.t
  L14_2 = "house_is_sale_now"
  L13_2 = L13_2(L14_2)
  L14_2 = "info"
  L11_2(L12_2, L13_2, L14_2)
  L11_2 = L3_1
  L11_2[A0_2] = true
  L11_2 = Config
  L11_2 = L11_2.Houses
  L11_2 = L11_2[A0_2]
  L11_2.price = A1_2
  L11_2 = Config
  L11_2 = L11_2.Houses
  L11_2 = L11_2[A0_2]
  L12_2 = A2_2.photos
  if not L12_2 then
    L12_2 = {}
  end
  L11_2.photos = L12_2
  L11_2 = Config
  L11_2 = L11_2.Houses
  L11_2 = L11_2[A0_2]
  L11_2.description = L8_2
  L11_2 = Config
  L11_2 = L11_2.Houses
  L11_2 = L11_2[A0_2]
  L12_2 = 1 == L10_2
  L11_2.hideFromBrowser = L12_2
  L11_2 = Config
  L11_2 = L11_2.Houses
  L11_2 = L11_2[A0_2]
  L12_2 = 1 == L9_2
  L11_2.saleFurnished = L12_2
  L11_2 = TriggerClientEvent
  L12_2 = "housing:updateHouseData"
  L13_2 = -1
  L14_2 = A0_2
  L15_2 = "price"
  L16_2 = A1_2
  L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
  L11_2 = TriggerClientEvent
  L12_2 = "housing:updateHouseData"
  L13_2 = -1
  L14_2 = A0_2
  L15_2 = "photos"
  L16_2 = Config
  L16_2 = L16_2.Houses
  L16_2 = L16_2[A0_2]
  L16_2 = L16_2.photos
  L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
  L11_2 = TriggerClientEvent
  L12_2 = "housing:updateHouseData"
  L13_2 = -1
  L14_2 = A0_2
  L15_2 = "description"
  L16_2 = Config
  L16_2 = L16_2.Houses
  L16_2 = L16_2[A0_2]
  L16_2 = L16_2.description
  L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
  L11_2 = TriggerClientEvent
  L12_2 = "housing:updateHouseData"
  L13_2 = -1
  L14_2 = A0_2
  L15_2 = "hideFromBrowser"
  L16_2 = Config
  L16_2 = L16_2.Houses
  L16_2 = L16_2[A0_2]
  L16_2 = L16_2.hideFromBrowser
  L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
  L11_2 = TriggerClientEvent
  L12_2 = "housing:updateHouseData"
  L13_2 = -1
  L14_2 = A0_2
  L15_2 = "saleFurnished"
  L16_2 = Config
  L16_2 = L16_2.Houses
  L16_2 = L16_2[A0_2]
  L16_2 = L16_2.saleFurnished
  L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
  L11_2 = TriggerClientEvent
  L12_2 = "housing:refreshHouse"
  L13_2 = -1
  L14_2 = A0_2
  L11_2(L12_2, L13_2, L14_2)
  L11_2 = SendLog
  L12_2 = DiscordWebhook
  L13_2 = {}
  L13_2.title = "Housing"
  L13_2.description = "Player put a house for sale"
  L14_2 = {}
  L15_2 = {}
  L15_2.name = "Player"
  L16_2 = GetPlayerName
  L17_2 = L3_2
  L16_2 = L16_2(L17_2)
  L15_2.value = L16_2
  L15_2.inline = true
  L16_2 = {}
  L16_2.name = "House"
  L16_2.value = A0_2
  L16_2.inline = true
  L17_2 = {}
  L17_2.name = "Price"
  L17_2.value = A1_2
  L17_2.inline = true
  L18_2 = {}
  L18_2.name = "Furnished"
  L19_2 = tostring
  L20_2 = 1 == L9_2
  L19_2 = L19_2(L20_2)
  L18_2.value = L19_2
  L18_2.inline = true
  L19_2 = {}
  L19_2.name = "Hidden"
  L20_2 = tostring
  L21_2 = 1 == L10_2
  L20_2 = L20_2(L21_2)
  L19_2.value = L20_2
  L19_2.inline = true
  L14_2[1] = L15_2
  L14_2[2] = L16_2
  L14_2[3] = L17_2
  L14_2[4] = L18_2
  L14_2[5] = L19_2
  L13_2.fields = L14_2
  L14_2 = WebhookColor
  L13_2.color = L14_2
  L11_2(L12_2, L13_2)
end
L15_1(L16_1, L17_1)
L15_1 = RegisterNetEvent
L16_1 = "qb-houses:cancelSellHouse"
function L17_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = source
  L2_2 = GetIdentifier
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = Debug
  L4_2 = "qb-houses:cancelSellHouse"
  L5_2 = "Canceling sale"
  L6_2 = A0_2
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.fetchAll
  L4_2 = "SELECT * FROM player_houses WHERE house = ? AND owner = ?"
  L5_2 = {}
  L6_2 = A0_2
  L7_2 = L2_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = L3_2[1]
  if not L4_2 then
    L4_2 = Notification
    L5_2 = L1_2
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "you_are_not_owner"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    return L4_2(L5_2, L6_2, L7_2)
  end
  L4_2 = L3_2[1]
  L4_2 = L4_2.purchasable
  if 1 ~= L4_2 then
    L4_2 = Notification
    L5_2 = L1_2
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "house_is_not_for_sale"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    return L4_2(L5_2, L6_2, L7_2)
  end
  L4_2 = MySQL
  L4_2 = L4_2.Sync
  L4_2 = L4_2.execute
  L5_2 = "UPDATE player_houses SET purchasable = NULL, sale_furnished = NULL WHERE house = ?"
  L6_2 = {}
  L7_2 = A0_2
  L6_2[1] = L7_2
  L4_2(L5_2, L6_2)
  L4_2 = MySQL
  L4_2 = L4_2.Sync
  L4_2 = L4_2.execute
  L5_2 = "UPDATE houselocations SET price = defaultPrice WHERE name = ?"
  L6_2 = {}
  L7_2 = A0_2
  L6_2[1] = L7_2
  L4_2(L5_2, L6_2)
  L4_2 = Notification
  L5_2 = L1_2
  L6_2 = i18n
  L6_2 = L6_2.t
  L7_2 = "house_no_longer_for_sale"
  L6_2 = L6_2(L7_2)
  L7_2 = "info"
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = L3_1
  L4_2[A0_2] = nil
  L4_2 = Config
  L4_2 = L4_2.Houses
  L4_2 = L4_2[A0_2]
  L5_2 = Config
  L5_2 = L5_2.Houses
  L5_2 = L5_2[A0_2]
  L5_2 = L5_2.defaultPrice
  L4_2.price = L5_2
  L4_2 = Config
  L4_2 = L4_2.Houses
  L4_2 = L4_2[A0_2]
  L5_2 = {}
  L4_2.photos = L5_2
  L4_2 = Config
  L4_2 = L4_2.Houses
  L4_2 = L4_2[A0_2]
  L4_2.description = ""
  L4_2 = Config
  L4_2 = L4_2.Houses
  L4_2 = L4_2[A0_2]
  L4_2.hideFromBrowser = false
  L4_2 = Config
  L4_2 = L4_2.Houses
  L4_2 = L4_2[A0_2]
  L4_2.saleFurnished = nil
  L4_2 = TriggerClientEvent
  L5_2 = "housing:updateHouseData"
  L6_2 = -1
  L7_2 = A0_2
  L8_2 = "price"
  L9_2 = Config
  L9_2 = L9_2.Houses
  L9_2 = L9_2[A0_2]
  L9_2 = L9_2.defaultPrice
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = TriggerClientEvent
  L5_2 = "qb-houses:requiredLeaveHouse"
  L6_2 = -1
  L7_2 = A0_2
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = TriggerClientEvent
  L5_2 = "housing:refreshHouse"
  L6_2 = -1
  L7_2 = A0_2
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = SendLog
  L5_2 = DiscordWebhook
  L6_2 = {}
  L6_2.title = "Housing"
  L6_2.description = "Player canceled a house sale"
  L7_2 = {}
  L8_2 = {}
  L8_2.name = "Player"
  L9_2 = GetPlayerName
  L10_2 = L1_2
  L9_2 = L9_2(L10_2)
  L8_2.value = L9_2
  L8_2.inline = true
  L9_2 = {}
  L9_2.name = "House"
  L9_2.value = A0_2
  L9_2.inline = true
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L6_2.fields = L7_2
  L7_2 = WebhookColor
  L6_2.color = L7_2
  L4_2(L5_2, L6_2)
end
L15_1(L16_1, L17_1)
L15_1 = RegisterNetEvent
L16_1 = "housing:transferHouse"
function L17_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L2_2 = source
  L3_2 = GetIdentifier
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = GetIdentifier
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  if not L4_2 then
    L5_2 = Notification
    L6_2 = L2_2
    L7_2 = i18n
    L7_2 = L7_2.t
    L8_2 = "player_not_found"
    L7_2 = L7_2(L8_2)
    L8_2 = "error"
    return L5_2(L6_2, L7_2, L8_2)
  end
  L5_2 = MySQL
  L5_2 = L5_2.Sync
  L5_2 = L5_2.fetchAll
  L6_2 = "SELECT * FROM player_houses WHERE house = ? AND owner = ?"
  L7_2 = {}
  L8_2 = A1_2
  L9_2 = L3_2
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = L5_2[1]
  if not L6_2 then
    L6_2 = Notification
    L7_2 = L2_2
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "you_are_not_owner"
    L8_2 = L8_2(L9_2)
    L9_2 = "error"
    return L6_2(L7_2, L8_2, L9_2)
  end
  L6_2 = L5_2[1]
  L6_2 = L6_2.rented
  if 1 == L6_2 then
    L6_2 = Notification
    L7_2 = L2_2
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "cant_transfer_rented"
    L8_2 = L8_2(L9_2)
    L9_2 = "error"
    return L6_2(L7_2, L8_2, L9_2)
  end
  L6_2 = L5_2[1]
  L6_2 = L6_2.credit
  if L6_2 then
    L6_2 = tonumber
    L7_2 = L5_2[1]
    L7_2 = L7_2.credit
    L6_2 = L6_2(L7_2)
    if L6_2 > 0 then
      L6_2 = Notification
      L7_2 = L2_2
      L8_2 = i18n
      L8_2 = L8_2.t
      L9_2 = "house_has_credit"
      L8_2 = L8_2(L9_2)
      L9_2 = "error"
      return L6_2(L7_2, L8_2, L9_2)
    end
  end
  L6_2 = L5_2[1]
  L6_2 = L6_2.purchasable
  if 1 == L6_2 then
    L6_2 = Notification
    L7_2 = L2_2
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "cant_transfer_for_sale"
    L8_2 = L8_2(L9_2)
    L9_2 = "error"
    return L6_2(L7_2, L8_2, L9_2)
  end
  L6_2 = L5_2[1]
  L6_2 = L6_2.rentable
  if 1 == L6_2 then
    L6_2 = Notification
    L7_2 = L2_2
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "cant_transfer_for_rent"
    L8_2 = L8_2(L9_2)
    L9_2 = "error"
    return L6_2(L7_2, L8_2, L9_2)
  end
  L6_2 = HouseTransactionVeto
  L6_2 = L6_2.Run
  L7_2 = {}
  L7_2.action = "transfer"
  L7_2.fromSource = L2_2
  L7_2.toSource = A0_2
  L7_2.toIdentifier = L4_2
  L7_2.house = A1_2
  L6_2 = L6_2(L7_2)
  L7_2 = L6_2.allowed
  if not L7_2 then
    L7_2 = Notification
    L8_2 = L2_2
    L9_2 = L6_2.reason
    if not L9_2 then
      L9_2 = i18n
      L9_2 = L9_2.t
      L10_2 = "cant_transfer_rented"
      L9_2 = L9_2(L10_2)
    end
    L10_2 = "error"
    return L7_2(L8_2, L9_2, L10_2)
  end
  L7_2 = MySQL
  L7_2 = L7_2.Sync
  L7_2 = L7_2.execute
  L8_2 = "UPDATE player_houses SET owner = ?, citizenid = ? WHERE house = ?"
  L9_2 = {}
  L10_2 = L4_2
  L11_2 = L4_2
  L12_2 = A1_2
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  L7_2(L8_2, L9_2)
  L7_2 = HouseOwnerIdentifierList
  L7_2[A1_2] = L4_2
  L7_2 = HouseOwnerCitizenidList
  L7_2[A1_2] = L4_2
  L7_2 = OfficialHouseOwnerList
  L7_2[A1_2] = L4_2
  L7_2 = HouseKeyholdersList
  L7_2[A1_2] = nil
  L7_2 = GetCharacterName
  L8_2 = A0_2
  L7_2, L8_2 = L7_2(L8_2)
  if L7_2 and L8_2 then
    L9_2 = L7_2
    L10_2 = " "
    L11_2 = L8_2
    L9_2 = L9_2 .. L10_2 .. L11_2
    if L9_2 then
      goto lbl_159
    end
  end
  L9_2 = GetPlayerName
  L10_2 = A0_2
  L9_2 = L9_2(L10_2)
  ::lbl_159::
  L10_2 = Notification
  L11_2 = L2_2
  L12_2 = i18n
  L12_2 = L12_2.t
  L13_2 = "house_transferred"
  L14_2 = {}
  L14_2.player = L9_2
  L12_2 = L12_2(L13_2, L14_2)
  L13_2 = "success"
  L10_2(L11_2, L12_2, L13_2)
  L10_2 = Notification
  L11_2 = A0_2
  L12_2 = i18n
  L12_2 = L12_2.t
  L13_2 = "house_received"
  L14_2 = {}
  L15_2 = Config
  L15_2 = L15_2.Houses
  L15_2 = L15_2[A1_2]
  L15_2 = L15_2.address
  if not L15_2 then
    L15_2 = A1_2
  end
  L14_2.house = L15_2
  L12_2 = L12_2(L13_2, L14_2)
  L13_2 = "success"
  L10_2(L11_2, L12_2, L13_2)
  L10_2 = TriggerClientEvent
  L11_2 = "qb-houses:requiredLeaveHouse"
  L12_2 = L2_2
  L13_2 = A1_2
  L10_2(L11_2, L12_2, L13_2)
  L10_2 = TriggerClientEvent
  L11_2 = "housing:refreshHouse"
  L12_2 = -1
  L13_2 = A1_2
  L10_2(L11_2, L12_2, L13_2)
  L10_2 = SendLog
  L11_2 = DiscordWebhook
  L12_2 = {}
  L12_2.title = "Housing"
  L12_2.description = "Player transferred a house to another player"
  L13_2 = {}
  L14_2 = {}
  L14_2.name = "From"
  L15_2 = GetPlayerName
  L16_2 = L2_2
  L15_2 = L15_2(L16_2)
  L14_2.value = L15_2
  L14_2.inline = true
  L15_2 = {}
  L15_2.name = "To"
  L15_2.value = L9_2
  L15_2.inline = true
  L16_2 = {}
  L16_2.name = "House"
  L16_2.value = A1_2
  L16_2.inline = true
  L13_2[1] = L14_2
  L13_2[2] = L15_2
  L13_2[3] = L16_2
  L12_2.fields = L13_2
  L13_2 = WebhookColor
  L12_2.color = L13_2
  L10_2(L11_2, L12_2)
end
L15_1(L16_1, L17_1)
function L15_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L2_2 = A0_2
  L1_2 = A0_2.gsub
  L3_2 = "-apt%-%d+"
  L4_2 = ""
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  L2_2 = {}
  L3_2 = {}
  L4_2 = pairs
  L5_2 = Config
  L5_2 = L5_2.Houses
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = L9_2.apartmentName
    if L10_2 == L1_2 then
      L10_2 = table
      L10_2 = L10_2.insert
      L11_2 = L2_2
      L12_2 = {}
      L12_2.query = "DELETE FROM player_houses WHERE house = ?"
      L13_2 = {}
      L14_2 = L8_2
      L13_2[1] = L14_2
      L12_2.parameters = L13_2
      L10_2(L11_2, L12_2)
      L10_2 = table
      L10_2 = L10_2.insert
      L11_2 = L2_2
      L12_2 = {}
      L12_2.query = "DELETE FROM `houselocations` WHERE `name` = ?"
      L13_2 = {}
      L14_2 = L8_2
      L13_2[1] = L14_2
      L12_2.parameters = L13_2
      L10_2(L11_2, L12_2)
      L10_2 = table
      L10_2 = L10_2.insert
      L11_2 = L2_2
      L12_2 = {}
      L12_2.query = "DELETE FROM house_decorations WHERE house = ?"
      L13_2 = {}
      L14_2 = L8_2
      L13_2[1] = L14_2
      L12_2.parameters = L13_2
      L10_2(L11_2, L12_2)
      L10_2 = ClearHouseDecoration
      L11_2 = L8_2
      L10_2(L11_2)
      L10_2 = table
      L10_2 = L10_2.insert
      L11_2 = L3_2
      L12_2 = L8_2
      L10_2(L11_2, L12_2)
      L10_2 = HouseOwnerCitizenidList
      L10_2[L8_2] = nil
      L10_2 = HouseOwnerIdentifierList
      L10_2[L8_2] = nil
      L10_2 = OfficialHouseOwnerList
      L10_2[L8_2] = nil
      L10_2 = HouseKeyholdersList
      L10_2[L8_2] = nil
      L10_2 = L2_1
      L10_2[L8_2] = nil
      L10_2 = L3_1
      L10_2[L8_2] = nil
      L10_2 = Config
      L10_2 = L10_2.Houses
      L10_2[L8_2] = nil
      L10_2 = Debug
      L11_2 = "Delete Apartment House"
      L12_2 = "Deleted house"
      L13_2 = L8_2
      L10_2(L11_2, L12_2, L13_2)
    end
  end
  L4_2 = MySQL
  L4_2 = L4_2.Sync
  L4_2 = L4_2.transaction
  L5_2 = L2_2
  L4_2 = L4_2(L5_2)
  if not L4_2 then
    L5_2 = Debug
    L6_2 = "DeleteHouse"
    L7_2 = "Failed to delete apartment houses"
    L8_2 = A0_2
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = false
    return L5_2
  end
  L5_2 = 1
  L6_2 = #L3_2
  L7_2 = 1
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = HousingBatteryBridge_Unregister
    L10_2 = L3_2[L8_2]
    L9_2(L10_2)
  end
  L5_2 = TriggerClientEvent
  L6_2 = "housing:setHouse"
  L7_2 = -1
  L8_2 = L3_2
  L9_2 = nil
  L5_2(L6_2, L7_2, L8_2, L9_2)
  L5_2 = TriggerClientEvent
  L6_2 = "qb-houses:requiredLeaveHouse"
  L7_2 = -1
  L8_2 = L3_2
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = true
  return L5_2
end
function L16_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = Config
  L1_2 = L1_2.Houses
  L1_2 = L1_2[A0_2]
  if not L1_2 then
    L2_2 = Error
    L3_2 = "DeleteHouse"
    L4_2 = "House not found"
    L5_2 = A0_2
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = false
    return L2_2
  end
  L2_2 = L1_2.apartmentNumber
  if L2_2 then
    L2_2 = L15_1
    L3_2 = A0_2
    return L2_2(L3_2)
  end
  L2_2 = DeleteHouseObject
  L3_2 = A0_2
  L2_2(L3_2)
  L2_2 = MySQL
  L2_2 = L2_2.Sync
  L2_2 = L2_2.fetchAll
  L3_2 = "SELECT * FROM houselocations WHERE name = ?"
  L4_2 = {}
  L5_2 = A0_2
  L4_2[1] = L5_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = L2_2[1]
  if not L3_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.execute
  L4_2 = "DELETE FROM player_houses WHERE house = ?"
  L5_2 = {}
  L6_2 = A0_2
  L5_2[1] = L6_2
  L3_2(L4_2, L5_2)
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.execute
  L4_2 = "DELETE FROM `houselocations` WHERE `name` = ?"
  L5_2 = {}
  L6_2 = A0_2
  L5_2[1] = L6_2
  L3_2(L4_2, L5_2)
  L3_2 = db
  L3_2 = L3_2.deleteAllObjects
  L4_2 = A0_2
  L3_2(L4_2)
  L3_2 = TriggerClientEvent
  L4_2 = "qb-houses:requiredLeaveHouse"
  L5_2 = -1
  L6_2 = A0_2
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = HouseOwnerCitizenidList
  L3_2[A0_2] = nil
  L3_2 = HouseOwnerIdentifierList
  L3_2[A0_2] = nil
  L3_2 = OfficialHouseOwnerList
  L3_2[A0_2] = nil
  L3_2 = HouseKeyholdersList
  L3_2[A0_2] = nil
  L3_2 = L2_1
  L3_2[A0_2] = nil
  L3_2 = L3_1
  L3_2[A0_2] = nil
  L3_2 = HousingBatteryBridge_Unregister
  L4_2 = A0_2
  L3_2(L4_2)
  L3_2 = Config
  L3_2 = L3_2.Houses
  L3_2[A0_2] = nil
  L3_2 = TriggerHouseRemoveGarage
  L4_2 = A0_2
  L3_2(L4_2)
  L3_2 = TriggerClientEvent
  L4_2 = "housing:setHouse"
  L5_2 = -1
  L6_2 = A0_2
  L7_2 = nil
  L3_2(L4_2, L5_2, L6_2, L7_2)
  L3_2 = Debug
  L4_2 = "DeleteHouse"
  L5_2 = "Deleted house"
  L6_2 = A0_2
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = true
  return L3_2
end
DeleteHouse = L16_1
L16_1 = RegisterNetEvent
L17_1 = "qb-houses:deleteHouse"
function L18_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = source
  L2_2 = HasPermission
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = print
    L3_2 = L1_2
    L4_2 = "Tried to exploit qb-houses:deleteHouse"
    L2_2(L3_2, L4_2)
    return
  end
  L2_2 = DeleteHouse
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L3_2 = Notification
    L4_2 = source
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "house_not_found"
    L5_2 = L5_2(L6_2)
    L6_2 = "error"
    return L3_2(L4_2, L5_2, L6_2)
  end
  L3_2 = Notification
  L4_2 = source
  L5_2 = i18n
  L5_2 = L5_2.t
  L6_2 = "house_deleted"
  L5_2 = L5_2(L6_2)
  L6_2 = "success"
  L3_2(L4_2, L5_2, L6_2)
end
L16_1(L17_1, L18_1)
L16_1 = exports
L17_1 = "deleteHouse"
L18_1 = DeleteHouse
L16_1(L17_1, L18_1)
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = Debug
  L3_2 = "removeRenter"
  L4_2 = "Removing renter"
  L5_2 = A0_2
  L6_2 = A1_2
  L2_2(L3_2, L4_2, L5_2, L6_2)
  L2_2 = MySQL
  L2_2 = L2_2.Sync
  L2_2 = L2_2.execute
  L3_2 = "UPDATE player_houses SET citizenid = player_houses.owner, rented = NULL, rentable = ?, rent_furnished = NULL, stash = NULL, outfit = NULL, logout = NULL, decorateStash = NULL, charge = NULL, tablet = NULL, rentNextChargeAt = NULL WHERE house = ?"
  L4_2 = {}
  if A1_2 then
    L5_2 = 1
    if L5_2 then
      goto lbl_19
    end
  end
  L5_2 = nil
  ::lbl_19::
  L6_2 = A0_2
  L4_2[1] = L5_2
  L4_2[2] = L6_2
  L2_2(L3_2, L4_2)
  L2_2 = HousingBatteryBridge_Unregister
  L3_2 = A0_2
  L2_2(L3_2)
  L2_2 = MySQL
  L2_2 = L2_2.Sync
  L2_2 = L2_2.execute
  L3_2 = "DELETE FROM house_rents WHERE house = ?"
  L4_2 = {}
  L5_2 = A0_2
  L4_2[1] = L5_2
  L2_2(L3_2, L4_2)
  if not A1_2 then
    L2_2 = MySQL
    L2_2 = L2_2.Sync
    L2_2 = L2_2.execute
    L3_2 = [[
			UPDATE houselocations SET
				photos = '[]',
				description = '',
				hideFromBrowser = 0
			WHERE name = ?
		]]
    L4_2 = {}
    L5_2 = A0_2
    L4_2[1] = L5_2
    L2_2(L3_2, L4_2)
    L2_2 = Config
    L2_2 = L2_2.Houses
    L2_2 = L2_2[A0_2]
    L3_2 = {}
    L2_2.photos = L3_2
    L2_2 = Config
    L2_2 = L2_2.Houses
    L2_2 = L2_2[A0_2]
    L2_2.description = ""
    L2_2 = Config
    L2_2 = L2_2.Houses
    L2_2 = L2_2[A0_2]
    L2_2.hideFromBrowser = false
    L2_2 = Config
    L2_2 = L2_2.Houses
    L2_2 = L2_2[A0_2]
    L2_2.rentFurnished = nil
    L2_2 = TriggerClientEvent
    L3_2 = "housing:updateHouseData"
    L4_2 = -1
    L5_2 = A0_2
    L6_2 = "photos"
    L7_2 = {}
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
    L2_2 = TriggerClientEvent
    L3_2 = "housing:updateHouseData"
    L4_2 = -1
    L5_2 = A0_2
    L6_2 = "description"
    L7_2 = ""
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
    L2_2 = TriggerClientEvent
    L3_2 = "housing:updateHouseData"
    L4_2 = -1
    L5_2 = A0_2
    L6_2 = "hideFromBrowser"
    L7_2 = false
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
    L2_2 = TriggerClientEvent
    L3_2 = "housing:updateHouseData"
    L4_2 = -1
    L5_2 = A0_2
    L6_2 = "rentFurnished"
    L7_2 = nil
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  end
  L2_2 = MySQL
  L2_2 = L2_2.Sync
  L2_2 = L2_2.fetchAll
  L3_2 = "SELECT * FROM player_houses WHERE house = ?"
  L4_2 = {}
  L5_2 = A0_2
  L4_2[1] = L5_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = HouseOwnerIdentifierList
  L4_2 = L2_2[1]
  L4_2 = L4_2.owner
  L3_2[A0_2] = L4_2
  L3_2 = HouseOwnerCitizenidList
  L4_2 = L2_2[1]
  L4_2 = L4_2.owner
  L3_2[A0_2] = L4_2
  L3_2 = OfficialHouseOwnerList
  L4_2 = L2_2[1]
  L4_2 = L4_2.owner
  L3_2[A0_2] = L4_2
  L3_2 = L2_1
  L3_2[A0_2] = A1_2
  L3_2 = SendLog
  L4_2 = DiscordWebhook
  L5_2 = {}
  L5_2.title = "Housing"
  L5_2.description = "Player removed a renter from a house"
  L6_2 = {}
  L7_2 = {}
  L7_2.name = "House"
  L7_2.value = A0_2
  L7_2.inline = true
  L8_2 = {}
  L8_2.name = "Owner"
  L9_2 = L2_2[1]
  L9_2 = L9_2.owner
  L8_2.value = L9_2
  L8_2.inline = true
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L5_2.fields = L6_2
  L6_2 = WebhookColor
  L5_2.color = L6_2
  L3_2(L4_2, L5_2)
  L3_2 = TriggerClientEvent
  L4_2 = "housing:refreshHouse"
  L5_2 = -1
  L6_2 = A0_2
  L3_2(L4_2, L5_2, L6_2)
end
L17_1 = lib
L17_1 = L17_1.callback
L17_1 = L17_1.register
L18_1 = "housing:isAdmin"
function L19_1(A0_2)
  local L1_2, L2_2
  L1_2 = PlayerIsAdmin
  L2_2 = A0_2
  return L1_2(L2_2)
end
L17_1(L18_1, L19_1)
L17_1 = RegisterNetEvent
L18_1 = "housing:hireRenter"
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = source
  L2_2 = PlayerIsAdmin
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = Notification
    L3_2 = L1_2
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "no_permission"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    return L2_2(L3_2, L4_2, L5_2)
  end
  L2_2 = MySQL
  L2_2 = L2_2.Sync
  L2_2 = L2_2.fetchAll
  L3_2 = "SELECT * FROM player_houses WHERE house = ?"
  L4_2 = {}
  L5_2 = A0_2
  L4_2[1] = L5_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = L2_2[1]
  if not L3_2 then
    L3_2 = Notification
    L4_2 = L1_2
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "house_not_found"
    L5_2 = L5_2(L6_2)
    L6_2 = "error"
    return L3_2(L4_2, L5_2, L6_2)
  end
  L3_2 = L2_2[1]
  L3_2 = L3_2.rentable
  if L3_2 then
    L3_2 = L2_2[1]
    L3_2 = L3_2.rented
    if not L3_2 then
      L3_2 = L16_1
      L4_2 = A0_2
      L5_2 = false
      L3_2(L4_2, L5_2)
      L3_2 = Notification
      L4_2 = L1_2
      L5_2 = i18n
      L5_2 = L5_2.t
      L6_2 = "rent.house_is_no_longer_rented"
      L5_2 = L5_2(L6_2)
      L6_2 = "success"
      L3_2(L4_2, L5_2, L6_2)
      return
    end
  end
  L3_2 = L2_2[1]
  L3_2 = L3_2.rented
  if not L3_2 then
    L3_2 = Notification
    L4_2 = L1_2
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "rent.house_is_not_rented"
    L5_2 = L5_2(L6_2)
    L6_2 = "error"
    return L3_2(L4_2, L5_2, L6_2)
  end
  L3_2 = GetPlayerSourceFromIdentifier
  L4_2 = L2_2[1]
  L4_2 = L4_2.citizenid
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L4_2 = Notification
    L5_2 = L3_2
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "rent.hired_by_admin"
    L6_2 = L6_2(L7_2)
    L7_2 = "info"
    L4_2(L5_2, L6_2, L7_2)
  end
  L4_2 = L16_1
  L5_2 = A0_2
  L6_2 = true
  L4_2(L5_2, L6_2)
  L4_2 = Notification
  L5_2 = L1_2
  L6_2 = i18n
  L6_2 = L6_2.t
  L7_2 = "rent.hired_success"
  L6_2 = L6_2(L7_2)
  L7_2 = "info"
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = SendLog
  L5_2 = DiscordWebhook
  L6_2 = {}
  L6_2.title = "Housing"
  L6_2.description = "Admin evicted a renter from a house"
  L7_2 = {}
  L8_2 = {}
  L8_2.name = "House"
  L8_2.value = A0_2
  L8_2.inline = true
  L9_2 = {}
  L9_2.name = "Owner"
  L10_2 = L2_2[1]
  L10_2 = L10_2.owner
  L9_2.value = L10_2
  L9_2.inline = true
  L10_2 = {}
  L10_2.name = "Tenant"
  L11_2 = L2_2[1]
  L11_2 = L11_2.citizenid
  L10_2.value = L11_2
  L10_2.inline = true
  L11_2 = {}
  L11_2.name = "Admin"
  L12_2 = GetPlayerName
  L13_2 = L1_2
  L12_2 = L12_2(L13_2)
  L11_2.value = L12_2
  L11_2.inline = true
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L7_2[3] = L10_2
  L7_2[4] = L11_2
  L6_2.fields = L7_2
  L7_2 = WebhookColor
  L6_2.color = L7_2
  L4_2(L5_2, L6_2)
end
L17_1(L18_1, L19_1)
L17_1 = RegisterNetEvent
L18_1 = "qb-houses:disspossesHouse"
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = source
  L2_2 = GetIdentifier
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.fetchAll
  L4_2 = "SELECT * FROM player_houses WHERE house = ? AND owner = ?"
  L5_2 = {}
  L6_2 = A0_2
  L7_2 = L2_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = L3_2[1]
  if not L4_2 then
    L4_2 = Notification
    L5_2 = L1_2
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "you_are_not_owner"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    return L4_2(L5_2, L6_2, L7_2)
  end
  L4_2 = L3_2[1]
  L4_2 = L4_2.rentable
  if L4_2 then
    L4_2 = L3_2[1]
    L4_2 = L4_2.rented
    if not L4_2 then
      L4_2 = L16_1
      L5_2 = A0_2
      L6_2 = false
      L4_2(L5_2, L6_2)
      L4_2 = Notification
      L5_2 = L1_2
      L6_2 = i18n
      L6_2 = L6_2.t
      L7_2 = "rent.house_is_no_longer_rented"
      L6_2 = L6_2(L7_2)
      L7_2 = "success"
      L4_2(L5_2, L6_2, L7_2)
      return
    end
  end
  L4_2 = L3_2[1]
  L4_2 = L4_2.rented
  if not L4_2 then
    L4_2 = Notification
    L5_2 = L1_2
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "rent.house_is_not_rented"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    return L4_2(L5_2, L6_2, L7_2)
  end
  L4_2 = MySQL
  L4_2 = L4_2.Sync
  L4_2 = L4_2.fetchAll
  L5_2 = "SELECT * FROM house_rents WHERE house = ? AND payed = 0"
  L6_2 = {}
  L7_2 = A0_2
  L6_2[1] = L7_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = L4_2[1]
  if not L5_2 then
    L5_2 = Notification
    L6_2 = L1_2
    L7_2 = i18n
    L7_2 = L7_2.t
    L8_2 = "rent.cant_evict_renter"
    L7_2 = L7_2(L8_2)
    L8_2 = "info"
    return L5_2(L6_2, L7_2, L8_2)
  end
  L5_2 = GetPlayerSourceFromIdentifier
  L6_2 = L3_2[1]
  L6_2 = L6_2.citizenid
  L5_2 = L5_2(L6_2)
  if L5_2 then
    L6_2 = Notification
    L7_2 = L5_2
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "rent.evict_success"
    L8_2 = L8_2(L9_2)
    L9_2 = "info"
    L6_2(L7_2, L8_2, L9_2)
  end
  L6_2 = L16_1
  L7_2 = A0_2
  L8_2 = true
  L6_2(L7_2, L8_2)
  L6_2 = Notification
  L7_2 = L1_2
  L8_2 = i18n
  L8_2 = L8_2.t
  L9_2 = "left_house"
  L8_2 = L8_2(L9_2)
  L9_2 = "info"
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = SendLog
  L7_2 = DiscordWebhook
  L8_2 = {}
  L8_2.title = "Housing"
  L8_2.description = "Player evicted a renter from a house"
  L9_2 = {}
  L10_2 = {}
  L10_2.name = "House"
  L10_2.value = A0_2
  L10_2.inline = true
  L11_2 = {}
  L11_2.name = "Owner"
  L12_2 = L3_2[1]
  L12_2 = L12_2.owner
  L11_2.value = L12_2
  L11_2.inline = true
  L12_2 = {}
  L12_2.name = "Tenant"
  L13_2 = L3_2[1]
  L13_2 = L13_2.citizenid
  L12_2.value = L13_2
  L12_2.inline = true
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  L8_2.fields = L9_2
  L9_2 = WebhookColor
  L8_2.color = L9_2
  L6_2(L7_2, L8_2)
end
L17_1(L18_1, L19_1)
function L17_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L3_2 = getHouseMoney
  L4_2 = A0_2
  L5_2 = A2_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = MySQL
  L4_2 = L4_2.Sync
  L4_2 = L4_2.fetchAll
  L5_2 = "SELECT * FROM house_rents WHERE id = ? AND house = ?"
  L6_2 = {}
  L7_2 = A1_2
  L8_2 = A2_2
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = L4_2[1]
  if not L5_2 then
    L5_2 = Notification
    L6_2 = A0_2
    L7_2 = i18n
    L7_2 = L7_2.t
    L8_2 = "rent.not_found"
    L7_2 = L7_2(L8_2)
    L8_2 = "error"
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = false
    return L5_2
  end
  L5_2 = L4_2[1]
  L5_2 = L5_2.payed
  if 1 == L5_2 then
    L5_2 = Notification
    L6_2 = A0_2
    L7_2 = i18n
    L7_2 = L7_2.t
    L8_2 = "rent.already_paid"
    L7_2 = L7_2(L8_2)
    L8_2 = "error"
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = false
    return L5_2
  end
  L5_2 = MySQL
  L5_2 = L5_2.Sync
  L5_2 = L5_2.fetchAll
  L6_2 = "SELECT * FROM player_houses WHERE house = ? AND citizenid = ? AND rented = 1"
  L7_2 = {}
  L8_2 = A2_2
  L9_2 = GetIdentifier
  L10_2 = A0_2
  L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L9_2(L10_2)
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L7_2[3] = L10_2
  L7_2[4] = L11_2
  L7_2[5] = L12_2
  L7_2[6] = L13_2
  L7_2[7] = L14_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = L5_2[1]
  if not L6_2 then
    L6_2 = Notification
    L7_2 = A0_2
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "rent.you_are_not_tenant"
    L8_2 = L8_2(L9_2)
    L9_2 = "error"
    L6_2(L7_2, L8_2, L9_2)
    L6_2 = false
    return L6_2
  end
  L6_2 = L5_2[1]
  L6_2 = L6_2.rentPrice
  if L3_2 < L6_2 then
    L6_2 = Notification
    L7_2 = A0_2
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "no_money"
    L10_2 = {}
    L11_2 = L5_2[1]
    L11_2 = L11_2.rentPrice
    L10_2.price = L11_2
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = "error"
    L6_2(L7_2, L8_2, L9_2)
    L6_2 = false
    return L6_2
  end
  L6_2 = removeHouseMoney
  L7_2 = A0_2
  L8_2 = A2_2
  L9_2 = L5_2[1]
  L9_2 = L9_2.rentPrice
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = MySQL
  L6_2 = L6_2.Sync
  L6_2 = L6_2.execute
  L7_2 = "UPDATE house_rents SET payed = 1 WHERE id = ?"
  L8_2 = {}
  L9_2 = A1_2
  L8_2[1] = L9_2
  L6_2(L7_2, L8_2)
  L6_2 = Notification
  L7_2 = A0_2
  L8_2 = i18n
  L8_2 = L8_2.t
  L9_2 = "rent.payment_success"
  L10_2 = {}
  L11_2 = L5_2[1]
  L11_2 = L11_2.rentPrice
  L10_2.price = L11_2
  L8_2 = L8_2(L9_2, L10_2)
  L9_2 = "success"
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = SendLog
  L7_2 = DiscordWebhook
  L8_2 = {}
  L8_2.title = "Housing"
  L8_2.description = "Player paid the rent"
  L9_2 = {}
  L10_2 = {}
  L10_2.name = "House"
  L10_2.value = A2_2
  L10_2.inline = true
  L11_2 = {}
  L11_2.name = "Owner"
  L12_2 = L5_2[1]
  L12_2 = L12_2.owner
  L11_2.value = L12_2
  L11_2.inline = true
  L12_2 = {}
  L12_2.name = "Tenant"
  L13_2 = GetPlayerName
  L14_2 = A0_2
  L13_2 = L13_2(L14_2)
  L12_2.value = L13_2
  L12_2.inline = true
  L13_2 = {}
  L13_2.name = "Price"
  L14_2 = L5_2[1]
  L14_2 = L14_2.rentPrice
  L13_2.value = L14_2
  L13_2.inline = true
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  L9_2[4] = L13_2
  L8_2.fields = L9_2
  L9_2 = WebhookColor
  L8_2.color = L9_2
  L6_2(L7_2, L8_2)
  L6_2 = Debug
  L7_2 = "housing:payRent"
  L8_2 = "Paid rent"
  L9_2 = A2_2
  L10_2 = "rent id"
  L11_2 = A1_2
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  L6_2 = true
  return L6_2
end
HousingPayRent = L17_1
L17_1 = lib
L17_1 = L17_1.callback
L17_1 = L17_1.register
L18_1 = "housing:payRent"
L19_1 = HousingPayRent
L17_1(L18_1, L19_1)
function L17_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L3_2 = GetAccountMoney
  L4_2 = A0_2
  L5_2 = Config
  L5_2 = L5_2.MoneyType
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = db
  L4_2 = L4_2.getBill
  L5_2 = A1_2
  L4_2 = L4_2(L5_2)
  if not L4_2 then
    L5_2 = Notification
    L6_2 = A0_2
    L7_2 = "Bill not found"
    L8_2 = "error"
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = false
    return L5_2
  end
  L5_2 = L4_2.payed
  if L5_2 then
    L5_2 = Notification
    L6_2 = A0_2
    L7_2 = "Bill already paid"
    L8_2 = "error"
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = false
    return L5_2
  end
  L5_2 = tonumber
  L6_2 = L4_2.total
  L5_2 = L5_2(L6_2)
  if not L5_2 then
    L5_2 = 0
  end
  if L3_2 < L5_2 then
    L6_2 = Notification
    L7_2 = A0_2
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "no_money"
    L10_2 = {}
    L10_2.price = L5_2
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = "error"
    L6_2(L7_2, L8_2, L9_2)
    L6_2 = false
    return L6_2
  end
  L6_2 = RemoveAccountMoney
  L7_2 = A0_2
  L8_2 = Config
  L8_2 = L8_2.MoneyType
  L9_2 = L5_2
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = db
  L7_2 = L6_2
  L6_2 = L6_2.payBill
  L8_2 = A1_2
  L9_2 = A2_2
  L10_2 = GetIdentifier
  L11_2 = A0_2
  L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L6_2 = Notification
  L7_2 = A0_2
  L8_2 = i18n
  L8_2 = L8_2.t
  L9_2 = "management.bills.you_paid_bills"
  L10_2 = {}
  L10_2.price = L5_2
  L8_2 = L8_2(L9_2, L10_2)
  L9_2 = "success"
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = SendLog
  L7_2 = DiscordWebhook
  L8_2 = {}
  L8_2.title = "Housing"
  L8_2.description = "Player paid the house bills"
  L9_2 = {}
  L10_2 = {}
  L10_2.name = "House"
  L10_2.value = A2_2
  L10_2.inline = true
  L11_2 = {}
  L11_2.name = "Tenant"
  L12_2 = GetPlayerName
  L13_2 = A0_2
  L12_2 = L12_2(L13_2)
  L11_2.value = L12_2
  L11_2.inline = true
  L12_2 = {}
  L12_2.name = "Total"
  L12_2.value = L5_2
  L12_2.inline = true
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  L8_2.fields = L9_2
  L9_2 = WebhookColor
  L8_2.color = L9_2
  L6_2(L7_2, L8_2)
  L6_2 = Debug
  L7_2 = "housing:payBill"
  L8_2 = "Paid bill"
  L9_2 = A2_2
  L10_2 = "bill id"
  L11_2 = A1_2
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  L6_2 = true
  return L6_2
end
HousingPayBill = L17_1
L17_1 = lib
L17_1 = L17_1.callback
L17_1 = L17_1.register
L18_1 = "housing:payBill"
L19_1 = HousingPayBill
L17_1(L18_1, L19_1)
function L17_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L2_2 = GetAccountMoney
  L3_2 = A0_2
  L4_2 = Config
  L4_2 = L4_2.MoneyType
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = db
  L4_2 = L3_2
  L3_2 = L3_2.getBills
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = {}
  L5_2 = ipairs
  L6_2 = L3_2
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = L10_2.payed
    if not L11_2 then
      L11_2 = table
      L11_2 = L11_2.insert
      L12_2 = L4_2
      L13_2 = L10_2
      L11_2(L12_2, L13_2)
    end
  end
  L5_2 = #L4_2
  if 0 == L5_2 then
    L5_2 = Notification
    L6_2 = A0_2
    L7_2 = i18n
    L7_2 = L7_2.t
    L8_2 = "management.bills.no_unpaid_bills"
    L7_2 = L7_2(L8_2)
    L8_2 = "info"
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = false
    return L5_2
  end
  L5_2 = 0
  L6_2 = ipairs
  L7_2 = L4_2
  L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
  for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
    L12_2 = tonumber
    L13_2 = L11_2.total
    L12_2 = L12_2(L13_2)
    if not L12_2 then
      L12_2 = 0
    end
    L5_2 = L5_2 + L12_2
  end
  if L2_2 < L5_2 then
    L6_2 = Notification
    L7_2 = A0_2
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "no_money"
    L10_2 = {}
    L10_2.price = L5_2
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = "error"
    L6_2(L7_2, L8_2, L9_2)
    L6_2 = false
    return L6_2
  end
  L6_2 = GetIdentifier
  L7_2 = A0_2
  L6_2 = L6_2(L7_2)
  L7_2 = db
  L8_2 = L7_2
  L7_2 = L7_2.payAllBills
  L9_2 = A1_2
  L10_2 = L6_2
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = RemoveAccountMoney
  L8_2 = A0_2
  L9_2 = Config
  L9_2 = L9_2.MoneyType
  L10_2 = L5_2
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = Notification
  L8_2 = A0_2
  L9_2 = i18n
  L9_2 = L9_2.t
  L10_2 = "management.bills.you_paid_all_bills"
  L11_2 = {}
  L11_2.price = L5_2
  L12_2 = #L4_2
  L11_2.count = L12_2
  L9_2 = L9_2(L10_2, L11_2)
  L10_2 = "success"
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = SendLog
  L8_2 = DiscordWebhook
  L9_2 = {}
  L9_2.title = "Housing"
  L9_2.description = "Player paid all house bills"
  L10_2 = {}
  L11_2 = {}
  L11_2.name = "House"
  L11_2.value = A1_2
  L11_2.inline = true
  L12_2 = {}
  L12_2.name = "Player"
  L13_2 = GetPlayerName
  L14_2 = A0_2
  L13_2 = L13_2(L14_2)
  L12_2.value = L13_2
  L12_2.inline = true
  L13_2 = {}
  L13_2.name = "Total"
  L13_2.value = L5_2
  L13_2.inline = true
  L14_2 = {}
  L14_2.name = "Count"
  L15_2 = #L4_2
  L14_2.value = L15_2
  L14_2.inline = true
  L10_2[1] = L11_2
  L10_2[2] = L12_2
  L10_2[3] = L13_2
  L10_2[4] = L14_2
  L9_2.fields = L10_2
  L10_2 = WebhookColor
  L9_2.color = L10_2
  L7_2(L8_2, L9_2)
  L7_2 = Debug
  L8_2 = "housing:payAllBills"
  L9_2 = "Paid all bills"
  L10_2 = A1_2
  L11_2 = "total"
  L12_2 = L5_2
  L13_2 = "count"
  L14_2 = #L4_2
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L7_2 = true
  return L7_2
end
HousingPayAllBills = L17_1
L17_1 = lib
L17_1 = L17_1.callback
L17_1 = L17_1.register
L18_1 = "housing:payAllBills"
L19_1 = HousingPayAllBills
L17_1(L18_1, L19_1)
function L17_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = type
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  if "string" ~= L2_2 or "" == A1_2 then
    L2_2 = nil
    return L2_2
  end
  L2_2 = GetIdentifier
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L3_2 = nil
    return L3_2
  end
  L3_2 = MySQL
  L3_2 = L3_2.single
  L3_2 = L3_2.await
  L4_2 = "SELECT citizenid, rented, owner FROM player_houses WHERE house = ? LIMIT 1"
  L5_2 = {}
  L6_2 = A1_2
  L5_2[1] = L6_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = OfficialHouseOwnerList
  L4_2 = L4_2[A1_2]
  L4_2 = L4_2 == L2_2
  L5_2 = L3_2 or L5_2
  if L3_2 then
    L5_2 = tonumber
    L6_2 = L3_2.rented
    L5_2 = L5_2(L6_2)
    L5_2 = 1 == L5_2
  end
  L6_2 = CheckHasKey
  L7_2 = L2_2
  L8_2 = L2_2
  L9_2 = A1_2
  L10_2 = A0_2
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  if not L4_2 and not L5_2 and not L6_2 then
    L7_2 = Notification
    L8_2 = A0_2
    L9_2 = i18n
    L9_2 = L9_2.t
    L10_2 = "not_have_keys"
    L9_2 = L9_2(L10_2)
    L10_2 = "error"
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = nil
    return L7_2
  end
  L7_2 = db
  L8_2 = L7_2
  L7_2 = L7_2.getBills
  L9_2 = A1_2
  L7_2 = L7_2(L8_2, L9_2)
  L8_2 = GetRents
  L9_2 = A1_2
  L8_2 = L8_2(L9_2)
  if L5_2 and not L4_2 then
    L9_2 = {}
    L9_2.bills = L7_2
    L9_2.rents = L8_2
    L10_2 = {}
    L9_2.keyholders = L10_2
    L10_2 = {}
    L9_2.metaKeys = L10_2
    return L9_2
  end
  if L4_2 then
    L9_2 = {}
    L10_2 = Config
    L10_2 = L10_2.EnableMetaKey
    if L10_2 then
      L10_2 = GetHouseMetaKeys
      L11_2 = A1_2
      L10_2 = L10_2(L11_2)
      L9_2 = L10_2 or L9_2
      if not L10_2 then
        L10_2 = {}
        L9_2 = L10_2
      end
    end
    L10_2 = {}
    L10_2.bills = L7_2
    L10_2.rents = L8_2
    L11_2 = GetKeyHolders
    L12_2 = A0_2
    L13_2 = A1_2
    L11_2 = L11_2(L12_2, L13_2)
    L10_2.keyholders = L11_2
    L10_2.metaKeys = L9_2
    return L10_2
  end
  L9_2 = {}
  L10_2 = {}
  L9_2.bills = L10_2
  L10_2 = {}
  L9_2.rents = L10_2
  L10_2 = {}
  L9_2.keyholders = L10_2
  L10_2 = {}
  L9_2.metaKeys = L10_2
  return L9_2
end
GetHousingManagementData = L17_1
L17_1 = lib
L17_1 = L17_1.callback
L17_1 = L17_1.register
L18_1 = "housing:getManagementData"
L19_1 = GetHousingManagementData
L17_1(L18_1, L19_1)
L17_1 = lib
L17_1 = L17_1.callback
L17_1 = L17_1.register
L18_1 = "housing:getLightsStatus"
function L19_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  if not A1_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = MySQL
  L2_2 = L2_2.query
  L2_2 = L2_2.await
  L3_2 = "SELECT lights_on FROM player_houses WHERE house = ?"
  L4_2 = {}
  L5_2 = A1_2
  L4_2[1] = L5_2
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L3_2 = L2_2[1]
    if L3_2 then
      L3_2 = L2_2[1]
      L3_2 = L3_2.lights_on
      return L3_2
    end
  end
  L3_2 = false
  return L3_2
end
L17_1(L18_1, L19_1)
function L17_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  if not A1_2 then
    L2_2 = nil
    return L2_2
  end
  L2_2 = GetIdentifier
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L3_2 = nil
    return L3_2
  end
  L3_2 = HouseKeyholdersList
  L3_2 = L3_2[A1_2]
  if not L3_2 then
    L3_2 = {}
  end
  L4_2 = table
  L4_2 = L4_2.includes
  L5_2 = L3_2
  L6_2 = L2_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = HouseOwnerIdentifierList
  L5_2 = L5_2[A1_2]
  L5_2 = L5_2 == L2_2
  if not L4_2 and not L5_2 then
    L6_2 = Notification
    L7_2 = A0_2
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "not_have_keys"
    L8_2 = L8_2(L9_2)
    L9_2 = "error"
    L6_2(L7_2, L8_2, L9_2)
    L6_2 = nil
    return L6_2
  end
  L6_2 = MySQL
  L6_2 = L6_2.query
  L6_2 = L6_2.await
  L7_2 = "SELECT lights_on, lights_on_since FROM player_houses WHERE house = ?"
  L8_2 = {}
  L9_2 = A1_2
  L8_2[1] = L9_2
  L6_2 = L6_2(L7_2, L8_2)
  if L6_2 then
    L7_2 = L6_2[1]
    if L7_2 then
      goto lbl_59
    end
  end
  L7_2 = nil
  do return L7_2 end
  ::lbl_59::
  L7_2 = L6_2[1]
  L7_2 = L7_2.lights_on
  L8_2 = not L7_2
  if L8_2 then
    L9_2 = MySQL
    L9_2 = L9_2.update
    L9_2 = L9_2.await
    L10_2 = "UPDATE player_houses SET lights_on = 1, lights_on_since = ? WHERE house = ?"
    L11_2 = {}
    L12_2 = os
    L12_2 = L12_2.time
    L12_2 = L12_2()
    L13_2 = A1_2
    L11_2[1] = L12_2
    L11_2[2] = L13_2
    L9_2(L10_2, L11_2)
  else
    L9_2 = MySQL
    L9_2 = L9_2.update
    L9_2 = L9_2.await
    L10_2 = "UPDATE player_houses SET lights_on = 0, lights_on_since = NULL WHERE house = ?"
    L11_2 = {}
    L12_2 = A1_2
    L11_2[1] = L12_2
    L9_2(L10_2, L11_2)
  end
  L9_2 = TriggerClientEvent
  L10_2 = "housing:syncLightsStatus"
  L11_2 = -1
  L12_2 = A1_2
  L13_2 = L8_2
  L9_2(L10_2, L11_2, L12_2, L13_2)
  L9_2 = Debug
  L10_2 = "housing:toggleLights"
  L11_2 = "Toggled lights"
  L12_2 = A1_2
  L13_2 = "newStatus"
  L14_2 = L8_2
  L9_2(L10_2, L11_2, L12_2, L13_2, L14_2)
  return L8_2
end
HousingToggleLights = L17_1
L17_1 = lib
L17_1 = L17_1.callback
L17_1 = L17_1.register
L18_1 = "housing:toggleLights"
L19_1 = HousingToggleLights
L17_1(L18_1, L19_1)
function L17_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = HouseOwnerIdentifierList
  L2_2 = L2_2[A0_2]
  if not L2_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = HouseOwnerIdentifierList
  L2_2 = L2_2[A0_2]
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.execute
  L4_2 = "DELETE FROM player_houses WHERE house = ?"
  L5_2 = {}
  L6_2 = A0_2
  L5_2[1] = L6_2
  L3_2(L4_2, L5_2)
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.execute
  L4_2 = "DELETE FROM house_bills WHERE house = ? AND payed = 0"
  L5_2 = {}
  L6_2 = A0_2
  L5_2[1] = L6_2
  L3_2(L4_2, L5_2)
  L3_2 = HouseOwnerCitizenidList
  L3_2[A0_2] = nil
  L3_2 = HouseOwnerIdentifierList
  L3_2[A0_2] = nil
  L3_2 = OfficialHouseOwnerList
  L3_2[A0_2] = nil
  L3_2 = HouseKeyholdersList
  L3_2[A0_2] = nil
  L3_2 = L2_1
  L3_2[A0_2] = nil
  L3_2 = L3_1
  L3_2[A0_2] = nil
  L3_2 = TriggerClientEvent
  L4_2 = "qb-houses:requiredLeaveHouse"
  L5_2 = -1
  L6_2 = A0_2
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = InitHouse
  L4_2 = A0_2
  L3_2(L4_2)
  L3_2 = Config
  L3_2 = L3_2.Bills
  L3_2 = L3_2.AutoEviction
  L3_2 = L3_2.NotifyOnEviction
  if L3_2 then
    L3_2 = GetPlayerSourceFromIdentifier
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      L4_2 = Notification
      L5_2 = L3_2
      L6_2 = i18n
      L6_2 = L6_2.t
      L7_2 = "management.bills.auto_eviction_notice"
      L8_2 = {}
      L8_2.house = A0_2
      L8_2.count = A1_2
      L6_2 = L6_2(L7_2, L8_2)
      L7_2 = "error"
      L4_2(L5_2, L6_2, L7_2)
    end
  end
  L3_2 = SendLog
  L4_2 = DiscordWebhook
  L5_2 = {}
  L5_2.title = "Housing - Auto Eviction"
  L5_2.description = "House owner was automatically evicted due to unpaid bills"
  L6_2 = {}
  L7_2 = {}
  L7_2.name = "House"
  L7_2.value = A0_2
  L7_2.inline = true
  L8_2 = {}
  L8_2.name = "Owner"
  L8_2.value = L2_2
  L8_2.inline = true
  L9_2 = {}
  L9_2.name = "Unpaid Bills"
  L10_2 = tostring
  L11_2 = A1_2
  L10_2 = L10_2(L11_2)
  L9_2.value = L10_2
  L9_2.inline = true
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L6_2[3] = L9_2
  L5_2.fields = L6_2
  L5_2.color = 15158332
  L3_2(L4_2, L5_2)
  L3_2 = Debug
  L4_2 = "AutoEviction"
  L5_2 = "Evicted owner from house"
  L6_2 = A0_2
  L7_2 = "unpaid bills:"
  L8_2 = A1_2
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = true
  return L3_2
end
function L18_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L3_2 = HouseOwnerIdentifierList
  L3_2 = L3_2[A0_2]
  if not L3_2 then
    return
  end
  L4_2 = GetPlayerSourceFromIdentifier
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L5_2 = A2_2 - A1_2
    L6_2 = Notification
    L7_2 = L4_2
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "management.bills.eviction_warning"
    L10_2 = {}
    L10_2.house = A0_2
    L10_2.unpaid = A1_2
    L10_2.remaining = L5_2
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = "info"
    L6_2(L7_2, L8_2, L9_2)
  end
end
L19_1 = Config
L19_1 = L19_1.Bills
if L19_1 then
  L19_1 = Config
  L19_1 = L19_1.Bills
  L19_1 = L19_1.Enabled
  if L19_1 then
    L19_1 = CreateThread
    function L20_1()
      local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
      L0_2 = Config
      L0_2 = L0_2.Bills
      L0_2 = L0_2.IntervalHours
      if not L0_2 then
        L0_2 = 72
      end
      L0_2 = L0_2 * 60
      L0_2 = L0_2 * 60
      L0_2 = L0_2 * 1000
      while true do
        L1_2 = Wait
        L2_2 = L0_2
        L1_2(L2_2)
        L1_2 = {}
        L2_2 = {}
        L3_2 = MySQL
        L3_2 = L3_2.query
        L3_2 = L3_2.await
        L4_2 = "SELECT house, lights_on, lights_on_since FROM player_houses"
        L3_2 = L3_2(L4_2)
        L4_2 = os
        L4_2 = L4_2.time
        L4_2 = L4_2()
        L5_2 = Config
        L5_2 = L5_2.Bills
        L5_2 = L5_2.AutoEviction
        if L5_2 then
          L5_2 = Config
          L5_2 = L5_2.Bills
          L5_2 = L5_2.AutoEviction
          L5_2 = L5_2.Enabled
        end
        L6_2 = Config
        L6_2 = L6_2.Bills
        L6_2 = L6_2.AutoEviction
        if L6_2 then
          L6_2 = Config
          L6_2 = L6_2.Bills
          L6_2 = L6_2.AutoEviction
          L6_2 = L6_2.MaxUnpaidBills
          if L6_2 then
            goto lbl_49
          end
        end
        L6_2 = 60
        ::lbl_49::
        L7_2 = Config
        L7_2 = L7_2.Bills
        L7_2 = L7_2.AutoEviction
        if L7_2 then
          L7_2 = Config
          L7_2 = L7_2.Bills
          L7_2 = L7_2.AutoEviction
          L7_2 = L7_2.NotifyOwnerAtBills
          if L7_2 then
            goto lbl_62
          end
        end
        L7_2 = {}
        ::lbl_62::
        L8_2 = {}
        if L5_2 then
          L9_2 = MySQL
          L9_2 = L9_2.query
          L9_2 = L9_2.await
          L10_2 = "SELECT house, COUNT(*) as count FROM house_bills WHERE payed = 0 GROUP BY house"
          L9_2 = L9_2(L10_2)
          L10_2 = ipairs
          L11_2 = L9_2 or L11_2
          if not L9_2 then
            L11_2 = {}
          end
          L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
          for L14_2, L15_2 in L10_2, L11_2, L12_2, L13_2 do
            L16_2 = L15_2.house
            L17_2 = L15_2.count
            L8_2[L16_2] = L17_2
          end
        end
        L9_2 = 1
        L10_2 = #L3_2
        L11_2 = 1
        for L12_2 = L9_2, L10_2, L11_2 do
          L13_2 = L3_2[L12_2]
          L14_2 = L13_2.house
          if L14_2 then
            if L5_2 then
              L15_2 = L8_2[L14_2]
              if not L15_2 then
                L15_2 = 0
              end
              L15_2 = L15_2 + 1
              if L6_2 <= L15_2 then
                L16_2 = Debug
                L17_2 = "AutoEviction"
                L18_2 = "Checking eviction for"
                L19_2 = L14_2
                L20_2 = "unpaid:"
                L21_2 = L15_2
                L22_2 = "max:"
                L23_2 = L6_2
                L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
                L16_2 = L17_1
                L17_2 = L14_2
                L18_2 = L15_2
                L16_2 = L16_2(L17_2, L18_2)
                if L16_2 then
              end
              else
                L16_2 = ipairs
                L17_2 = L7_2
                L16_2, L17_2, L18_2, L19_2 = L16_2(L17_2)
                for L20_2, L21_2 in L16_2, L17_2, L18_2, L19_2 do
                  if L15_2 == L21_2 then
                    L22_2 = L18_1
                    L23_2 = L14_2
                    L24_2 = L15_2
                    L25_2 = L6_2
                    L22_2(L23_2, L24_2, L25_2)
                    break
                  end
                end
                L15_2 = 0
                L16_2 = L13_2.lights_on
                if L16_2 then
                  L16_2 = L13_2.lights_on_since
                  if L16_2 then
                    L16_2 = L13_2.lights_on_since
                    L16_2 = L4_2 - L16_2
                    L16_2 = L16_2 / 3600
                    L17_2 = Config
                    L17_2 = L17_2.Bills
                    L17_2 = L17_2.Electricity
                    if L17_2 then
                      L17_2 = Config
                      L17_2 = L17_2.Bills
                      L17_2 = L17_2.Electricity
                      L17_2 = L17_2.kilowattPerHour
                      if L17_2 then
                        goto lbl_157
                      end
                    end
                    L17_2 = 1.5
                    ::lbl_157::
                    L18_2 = Config
                    L18_2 = L18_2.Bills
                    L18_2 = L18_2.Electricity
                    if L18_2 then
                      L18_2 = Config
                      L18_2 = L18_2.Bills
                      L18_2 = L18_2.Electricity
                      L18_2 = L18_2.pricePerKilowatt
                      if L18_2 then
                        goto lbl_169
                      end
                    end
                    L18_2 = 50
                    ::lbl_169::
                    L19_2 = math
                    L19_2 = L19_2.floor
                    L20_2 = L16_2 * L17_2
                    L20_2 = L20_2 * L18_2
                    L19_2 = L19_2(L20_2)
                    L15_2 = L19_2
                    L19_2 = #L2_2
                    L19_2 = L19_2 + 1
                    L20_2 = {}
                    L20_2.query = "UPDATE player_houses SET lights_on_since = ? WHERE house = ?"
                    L21_2 = {}
                    L22_2 = L4_2
                    L23_2 = L14_2
                    L21_2[1] = L22_2
                    L21_2[2] = L23_2
                    L20_2.parameters = L21_2
                    L2_2[L19_2] = L20_2
                  end
                end
                L16_2 = math
                L16_2 = L16_2.random
                L17_2 = Config
                L17_2 = L17_2.Bills
                L17_2 = L17_2.RandomRanges
                L17_2 = L17_2.water
                L17_2 = L17_2.min
                L18_2 = Config
                L18_2 = L18_2.Bills
                L18_2 = L18_2.RandomRanges
                L18_2 = L18_2.water
                L18_2 = L18_2.max
                L16_2 = L16_2(L17_2, L18_2)
                L17_2 = math
                L17_2 = L17_2.random
                L18_2 = Config
                L18_2 = L18_2.Bills
                L18_2 = L18_2.RandomRanges
                L18_2 = L18_2.internet
                L18_2 = L18_2.min
                L19_2 = Config
                L19_2 = L19_2.Bills
                L19_2 = L19_2.RandomRanges
                L19_2 = L19_2.internet
                L19_2 = L19_2.max
                L17_2 = L17_2(L18_2, L19_2)
                L18_2 = L15_2 + L16_2
                L18_2 = L18_2 + L17_2
                L19_2 = json
                L19_2 = L19_2.encode
                L20_2 = {}
                L20_2.electricity = L15_2
                L20_2.water = L16_2
                L20_2.internet = L17_2
                L19_2 = L19_2(L20_2)
                L20_2 = #L1_2
                L20_2 = L20_2 + 1
                L21_2 = {}
                L21_2.query = "INSERT INTO house_bills (house, total, breakdown, payed) VALUES (?, ?, ?, 0)"
                L22_2 = {}
                L23_2 = L14_2
                L24_2 = L18_2
                L25_2 = L19_2
                L22_2[1] = L23_2
                L22_2[2] = L24_2
                L22_2[3] = L25_2
                L21_2.parameters = L22_2
                L1_2[L20_2] = L21_2
                L20_2 = Debug
                L21_2 = "bills"
                L22_2 = "created"
                L23_2 = L14_2
                L24_2 = L18_2
                L25_2 = "electricity"
                L26_2 = L15_2
                L20_2(L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
              end
            end
          end
        end
        L9_2 = #L1_2
        if L9_2 > 0 then
          L9_2 = MySQL
          L9_2 = L9_2.transaction
          L9_2 = L9_2.await
          L10_2 = L1_2
          L9_2(L10_2)
        end
        L9_2 = #L2_2
        if L9_2 > 0 then
          L9_2 = MySQL
          L9_2 = L9_2.transaction
          L9_2 = L9_2.await
          L10_2 = L2_2
          L9_2(L10_2)
        end
        L9_2 = db
        L10_2 = L9_2
        L9_2 = L9_2.clearCache
        L11_2 = "bills"
        L9_2(L10_2, L11_2)
      end
    end
    L19_1(L20_1)
  end
end
L19_1 = RegisterNetEvent
L20_1 = "qb-houses:leftHouse"
function L21_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = source
  L2_2 = GetIdentifier
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.fetchAll
  L4_2 = "SELECT * FROM player_houses WHERE house = ? AND citizenid = ? AND rented = 1"
  L5_2 = {}
  L6_2 = A0_2
  L7_2 = L2_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = L3_2[1]
  if not L4_2 then
    L4_2 = Notification
    L5_2 = L1_2
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "rent.you_are_not_tenant"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    return L4_2(L5_2, L6_2, L7_2)
  end
  L4_2 = Notification
  L5_2 = L1_2
  L6_2 = i18n
  L6_2 = L6_2.t
  L7_2 = "left_house"
  L6_2 = L6_2(L7_2)
  L7_2 = "info"
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = GetPlayerSourceFromIdentifier
  L5_2 = L3_2[1]
  L5_2 = L5_2.owner
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L5_2 = Notification
    L6_2 = L4_2
    L7_2 = i18n
    L7_2 = L7_2.t
    L8_2 = "rent.tenant_left"
    L9_2 = {}
    L9_2.house = A0_2
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = "error"
    L5_2(L6_2, L7_2, L8_2)
  end
  L5_2 = SendLog
  L6_2 = DiscordWebhook
  L7_2 = {}
  L7_2.title = "Housing"
  L7_2.description = "Player left a rented house"
  L8_2 = {}
  L9_2 = {}
  L9_2.name = "House"
  L9_2.value = A0_2
  L9_2.inline = true
  L10_2 = {}
  L10_2.name = "Owner"
  L11_2 = L3_2[1]
  L11_2 = L11_2.owner
  L10_2.value = L11_2
  L10_2.inline = true
  L11_2 = {}
  L11_2.name = "Tenant"
  L12_2 = GetPlayerName
  L13_2 = L1_2
  L12_2 = L12_2(L13_2)
  L11_2.value = L12_2
  L11_2.inline = true
  L8_2[1] = L9_2
  L8_2[2] = L10_2
  L8_2[3] = L11_2
  L7_2.fields = L8_2
  L8_2 = WebhookColor
  L7_2.color = L8_2
  L5_2(L6_2, L7_2)
  L5_2 = L16_1
  L6_2 = A0_2
  L7_2 = true
  L5_2(L6_2, L7_2)
end
L19_1(L20_1, L21_1)
L19_1 = RegisterNetEvent
L20_1 = "housing:lease"
function L21_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  L3_2 = source
  L4_2 = Config
  L4_2 = L4_2.EnableRentable
  if not L4_2 then
    L4_2 = Notification
    L5_2 = L3_2
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "rent.disabled"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = Debug
    L5_2 = "housing:lease"
    L6_2 = "Rentable houses are disabled"
    L4_2(L5_2, L6_2)
    return
  end
  L4_2 = GetIdentifier
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = HasPermission
  L6_2 = L3_2
  L5_2 = L5_2(L6_2)
  L6_2 = [[
		SELECT * FROM player_houses WHERE house = ? AND owner = ? AND rented IS NULL
	]]
  L7_2 = {}
  L8_2 = A0_2
  L9_2 = L4_2
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L8_2 = Config
  L8_2 = L8_2.CreatedRentableHousesManageable
  if not L8_2 and L5_2 then
    L6_2 = [[
			SELECT * FROM player_houses WHERE house = ? AND rented IS NULL
		]]
    L8_2 = {}
    L9_2 = A0_2
    L8_2[1] = L9_2
    L7_2 = L8_2
    L8_2 = Debug
    L9_2 = "housing:lease"
    L10_2 = "Realestate is leasing"
    L8_2(L9_2, L10_2)
  end
  L8_2 = MySQL
  L8_2 = L8_2.Sync
  L8_2 = L8_2.fetchAll
  L9_2 = L6_2
  L10_2 = L7_2
  L8_2 = L8_2(L9_2, L10_2)
  L9_2 = L8_2[1]
  if not L9_2 then
    L9_2 = Notification
    L10_2 = L3_2
    L11_2 = i18n
    L11_2 = L11_2.t
    L12_2 = "rent.no_owner_or_renter"
    L11_2 = L11_2(L12_2)
    L12_2 = "error"
    return L9_2(L10_2, L11_2, L12_2)
  end
  L9_2 = L3_1
  L9_2 = L9_2[A0_2]
  if L9_2 then
    L9_2 = Notification
    L10_2 = L3_2
    L11_2 = i18n
    L11_2 = L11_2.t
    L12_2 = "rent.in_sell"
    L11_2 = L11_2(L12_2)
    L12_2 = "error"
    return L9_2(L10_2, L11_2, L12_2)
  end
  if not A2_2 then
    L9_2 = {}
    A2_2 = L9_2
  end
  L9_2 = json
  L9_2 = L9_2.encode
  L10_2 = A2_2.photos
  if not L10_2 then
    L10_2 = {}
  end
  L9_2 = L9_2(L10_2)
  L10_2 = A2_2.description
  if not L10_2 then
    L10_2 = ""
  end
  L11_2 = A2_2.furnished
  if false ~= L11_2 then
    L11_2 = 1
    if L11_2 then
      goto lbl_102
    end
  end
  L11_2 = 0
  ::lbl_102::
  L12_2 = A2_2.hideFromBrowser
  if L12_2 then
    L12_2 = 1
    if L12_2 then
      goto lbl_109
    end
  end
  L12_2 = 0
  ::lbl_109::
  L13_2 = MySQL
  L13_2 = L13_2.Sync
  L13_2 = L13_2.execute
  L14_2 = "UPDATE player_houses SET citizenid = player_houses.owner, rentable = 1, rentPrice = ?, rent_furnished = ? WHERE id = ?"
  L15_2 = {}
  L16_2 = A1_2
  L17_2 = L11_2
  L18_2 = L8_2[1]
  L18_2 = L18_2.id
  L15_2[1] = L16_2
  L15_2[2] = L17_2
  L15_2[3] = L18_2
  L13_2(L14_2, L15_2)
  L13_2 = MySQL
  L13_2 = L13_2.Sync
  L13_2 = L13_2.execute
  L14_2 = [[
		UPDATE houselocations SET
			photos = ?,
			description = ?,
			hideFromBrowser = ?
		WHERE name = ?
	]]
  L15_2 = {}
  L16_2 = L9_2
  L17_2 = L10_2
  L18_2 = L12_2
  L19_2 = A0_2
  L15_2[1] = L16_2
  L15_2[2] = L17_2
  L15_2[3] = L18_2
  L15_2[4] = L19_2
  L13_2(L14_2, L15_2)
  L13_2 = L2_1
  L13_2[A0_2] = true
  L13_2 = Config
  L13_2 = L13_2.Houses
  L13_2 = L13_2[A0_2]
  L14_2 = A2_2.photos
  if not L14_2 then
    L14_2 = {}
  end
  L13_2.photos = L14_2
  L13_2 = Config
  L13_2 = L13_2.Houses
  L13_2 = L13_2[A0_2]
  L13_2.description = L10_2
  L13_2 = Config
  L13_2 = L13_2.Houses
  L13_2 = L13_2[A0_2]
  L14_2 = 1 == L12_2
  L13_2.hideFromBrowser = L14_2
  L13_2 = Config
  L13_2 = L13_2.Houses
  L13_2 = L13_2[A0_2]
  L14_2 = 1 == L11_2
  L13_2.rentFurnished = L14_2
  L13_2 = TriggerClientEvent
  L14_2 = "housing:updateHouseData"
  L15_2 = -1
  L16_2 = A0_2
  L17_2 = "photos"
  L18_2 = Config
  L18_2 = L18_2.Houses
  L18_2 = L18_2[A0_2]
  L18_2 = L18_2.photos
  L13_2(L14_2, L15_2, L16_2, L17_2, L18_2)
  L13_2 = TriggerClientEvent
  L14_2 = "housing:updateHouseData"
  L15_2 = -1
  L16_2 = A0_2
  L17_2 = "description"
  L18_2 = Config
  L18_2 = L18_2.Houses
  L18_2 = L18_2[A0_2]
  L18_2 = L18_2.description
  L13_2(L14_2, L15_2, L16_2, L17_2, L18_2)
  L13_2 = TriggerClientEvent
  L14_2 = "housing:updateHouseData"
  L15_2 = -1
  L16_2 = A0_2
  L17_2 = "hideFromBrowser"
  L18_2 = Config
  L18_2 = L18_2.Houses
  L18_2 = L18_2[A0_2]
  L18_2 = L18_2.hideFromBrowser
  L13_2(L14_2, L15_2, L16_2, L17_2, L18_2)
  L13_2 = TriggerClientEvent
  L14_2 = "housing:updateHouseData"
  L15_2 = -1
  L16_2 = A0_2
  L17_2 = "rentFurnished"
  L18_2 = Config
  L18_2 = L18_2.Houses
  L18_2 = L18_2[A0_2]
  L18_2 = L18_2.rentFurnished
  L13_2(L14_2, L15_2, L16_2, L17_2, L18_2)
  L13_2 = Notification
  L14_2 = L3_2
  L15_2 = i18n
  L15_2 = L15_2.t
  L16_2 = "rent.rented"
  L15_2 = L15_2(L16_2)
  L16_2 = "success"
  L13_2(L14_2, L15_2, L16_2)
  L13_2 = TriggerClientEvent
  L14_2 = "housing:refreshHouse"
  L15_2 = -1
  L16_2 = A0_2
  L13_2(L14_2, L15_2, L16_2)
  L13_2 = SendLog
  L14_2 = DiscordWebhook
  L15_2 = {}
  L15_2.title = "Housing"
  L15_2.description = "Player rented a house"
  L16_2 = {}
  L17_2 = {}
  L17_2.name = "House"
  L17_2.value = A0_2
  L17_2.inline = true
  L18_2 = {}
  L18_2.name = "Owner"
  L19_2 = L8_2[1]
  L19_2 = L19_2.owner
  L18_2.value = L19_2
  L18_2.inline = true
  L19_2 = {}
  L19_2.name = "Tenant"
  L20_2 = GetPlayerName
  L21_2 = L3_2
  L20_2 = L20_2(L21_2)
  L19_2.value = L20_2
  L19_2.inline = true
  L20_2 = {}
  L20_2.name = "Price"
  L20_2.value = A1_2
  L20_2.inline = true
  L21_2 = {}
  L21_2.name = "Furnished"
  L22_2 = tostring
  L23_2 = 1 == L11_2
  L22_2 = L22_2(L23_2)
  L21_2.value = L22_2
  L21_2.inline = true
  L22_2 = {}
  L22_2.name = "Hidden"
  L23_2 = tostring
  L24_2 = 1 == L12_2
  L23_2 = L23_2(L24_2)
  L22_2.value = L23_2
  L22_2.inline = true
  L16_2[1] = L17_2
  L16_2[2] = L18_2
  L16_2[3] = L19_2
  L16_2[4] = L20_2
  L16_2[5] = L21_2
  L16_2[6] = L22_2
  L15_2.fields = L16_2
  L16_2 = WebhookColor
  L15_2.color = L16_2
  L13_2(L14_2, L15_2)
end
L19_1(L20_1, L21_1)
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L1_2 = {}
  L2_2 = MySQL
  L2_2 = L2_2.Sync
  L2_2 = L2_2.fetchAll
  L3_2 = "SELECT * FROM player_houses WHERE house = ?"
  L4_2 = {}
  L5_2 = A0_2
  L4_2[1] = L5_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = L2_2[1]
  if not L3_2 then
    L3_2 = Debug
    L4_2 = "housing:getRents"
    L5_2 = "No house found"
    L6_2 = A0_2
    L3_2(L4_2, L5_2, L6_2)
    return L1_2
  end
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.fetchAll
  L4_2 = "SELECT * FROM house_rents WHERE house = ? ORDER BY payed ASC, date DESC LIMIT 50"
  L5_2 = {}
  L6_2 = A0_2
  L5_2[1] = L6_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = L3_2[1]
  if not L4_2 then
    return L1_2
  end
  L4_2 = GetCharacterFromIdentifier
  L5_2 = L3_2[1]
  L5_2 = L5_2.identifier
  L4_2, L5_2 = L4_2(L5_2)
  L6_2 = pairs
  L7_2 = L3_2
  L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
  for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
    L12_2 = table
    L12_2 = L12_2.insert
    L13_2 = L1_2
    L14_2 = {}
    L15_2 = L11_2.id
    L14_2.id = L15_2
    L15_2 = L4_2
    L16_2 = " "
    L17_2 = L5_2
    L15_2 = L15_2 .. L16_2 .. L17_2
    L14_2.name = L15_2
    L15_2 = L11_2.identifier
    L14_2.identifier = L15_2
    L15_2 = L11_2.payed
    L15_2 = 1 == L15_2
    L14_2.payed = L15_2
    L15_2 = L11_2.date
    L14_2.date = L15_2
    L15_2 = L2_2[1]
    L15_2 = L15_2.rentPrice
    L14_2.price = L15_2
    L12_2(L13_2, L14_2)
  end
  return L1_2
end
GetRents = L19_1
function L19_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  if A2_2 then
    L3_2 = 1
    if L3_2 then
      goto lbl_7
      A2_2 = L3_2 or A2_2
    end
  end
  A2_2 = 0
  ::lbl_7::
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.execute
  L4_2 = "INSERT INTO house_rents (house, identifier, payed) VALUES (?, ?, ?)"
  L5_2 = {}
  L6_2 = A0_2
  L7_2 = A1_2
  L8_2 = A2_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L5_2[3] = L8_2
  L3_2(L4_2, L5_2)
  L3_2 = TriggerEvent
  L4_2 = "housing:handleRentPayment"
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = A2_2
  L3_2(L4_2, L5_2, L6_2, L7_2)
end
CreateHouseRent = L19_1
function L19_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L2_2 = A0_2.rentPrice
  L3_2 = A0_2.house
  L4_2 = Config
  L4_2 = L4_2.Houses
  L4_2 = L4_2[L3_2]
  if not L4_2 or not L2_2 then
    return
  end
  L5_2 = L4_2.creator
  L6_2 = A0_2.owner
  L5_2 = L5_2 == L6_2
  L6_2 = getHousePaymentMethod
  L7_2 = L3_2
  L6_2 = L6_2(L7_2)
  L7_2 = GetPlayerSourceFromIdentifier
  L8_2 = A0_2.citizenid
  L7_2 = L7_2(L8_2)
  L8_2 = false
  if L7_2 then
    L9_2 = GetAccountMoney
    L10_2 = L7_2
    L11_2 = L6_2
    L9_2 = L9_2(L10_2, L11_2)
    if L2_2 <= L9_2 then
      L9_2 = RemoveAccountMoney
      L10_2 = L7_2
      L11_2 = L6_2
      L12_2 = L2_2
      L9_2(L10_2, L11_2, L12_2)
      L9_2 = Notification
      L10_2 = L7_2
      L11_2 = i18n
      L11_2 = L11_2.t
      L12_2 = "rent.payment_success"
      L13_2 = {}
      L13_2.price = L2_2
      L11_2 = L11_2(L12_2, L13_2)
      L12_2 = "success"
      L9_2(L10_2, L11_2, L12_2)
      L8_2 = true
    else
      L9_2 = CreateHouseRent
      L10_2 = L3_2
      L11_2 = A0_2.citizenid
      L12_2 = false
      L9_2(L10_2, L11_2, L12_2)
      L9_2 = Notification
      L10_2 = L7_2
      L11_2 = i18n
      L11_2 = L11_2.t
      L12_2 = "rent.payment_failed"
      L13_2 = {}
      L13_2.price = L2_2
      L11_2 = L11_2(L12_2, L13_2)
      L12_2 = "error"
      L9_2(L10_2, L11_2, L12_2)
    end
  else
    L9_2 = removeHouseMoneyFromIdentifier
    L10_2 = A0_2.citizenid
    L11_2 = L3_2
    L12_2 = L2_2
    L9_2 = L9_2(L10_2, L11_2, L12_2)
    L8_2 = true == L9_2
    if not L8_2 then
      L9_2 = CreateHouseRent
      L10_2 = L3_2
      L11_2 = A0_2.citizenid
      L12_2 = false
      L9_2(L10_2, L11_2, L12_2)
    end
  end
  if L8_2 then
    if L5_2 then
      L9_2 = Config
      L9_2 = L9_2.Society
      if "none" == L9_2 then
        L9_2 = L4_2.creator
        if L9_2 then
          L9_2 = Debug
          L10_2 = "Please specify a society in the config otherwise realestate jobs will not get the money"
          L9_2(L10_2)
        end
      end
      L9_2 = L4_2.creatorJob
      if L9_2 then
        L10_2 = AddMoneyToSociety
        L11_2 = L7_2 or L11_2
        if not L7_2 then
          L11_2 = A0_2.citizenid
        end
        L12_2 = L9_2
        L13_2 = L2_2
        L10_2(L11_2, L12_2, L13_2)
        L10_2 = Debug
        L11_2 = "processRentCharge"
        L12_2 = "Added money to society"
        L13_2 = L9_2
        L14_2 = L2_2
        L10_2(L11_2, L12_2, L13_2, L14_2)
      else
        L10_2 = Debug
        L11_2 = "processRentCharge"
        L12_2 = "No creator job"
        L13_2 = L9_2
        L10_2(L11_2, L12_2, L13_2)
      end
    else
      L9_2 = AddMoneyToAccount
      L10_2 = A0_2.owner
      L11_2 = L2_2
      L9_2(L10_2, L11_2)
    end
    L9_2 = CreateHouseRent
    L10_2 = L3_2
    L11_2 = A0_2.citizenid
    L12_2 = true
    L9_2(L10_2, L11_2, L12_2)
  end
  if A1_2 then
    L9_2 = A0_2.id
    if L9_2 then
      L9_2 = MySQL
      L9_2 = L9_2.update
      L9_2 = L9_2.await
      L10_2 = "UPDATE player_houses SET rentNextChargeAt = DATE_ADD(COALESCE(rentNextChargeAt, UTC_TIMESTAMP()), INTERVAL 1 MONTH) WHERE id = ?"
      L11_2 = {}
      L12_2 = A0_2.id
      L11_2[1] = L12_2
      L9_2(L10_2, L11_2)
    end
  end
end
function L20_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = MySQL
  L0_2 = L0_2.Sync
  L0_2 = L0_2.fetchAll
  L1_2 = "SELECT id, house, rentPrice, citizenid, owner FROM player_houses WHERE rented = 1"
  L0_2 = L0_2(L1_2)
  L1_2 = pairs
  L2_2 = L0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = L19_1
    L8_2 = L6_2
    L9_2 = false
    L7_2(L8_2, L9_2)
  end
end
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = MySQL
  L0_2 = L0_2.Sync
  L0_2 = L0_2.fetchAll
  L1_2 = [[
		SELECT id, house, rentPrice, citizenid, owner
		FROM player_houses
		WHERE rented = 1 AND rentNextChargeAt IS NOT NULL AND rentNextChargeAt <= UTC_TIMESTAMP()
	]]
  L0_2 = L0_2(L1_2)
  L1_2 = pairs
  L2_2 = L0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = L19_1
    L8_2 = L6_2
    L9_2 = true
    L7_2(L8_2, L9_2)
  end
end
function L22_1()
  local L0_2, L1_2
  L0_2 = L9_1
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = L21_1
    L0_2()
  else
    L0_2 = L20_1
    L0_2()
  end
end
function L23_1()
  local L0_2, L1_2
  L0_2 = MySQL
  L0_2 = L0_2.Sync
  L0_2 = L0_2.execute
  L1_2 = "DELETE FROM house_rents WHERE date < DATE_SUB(UTC_TIMESTAMP(), INTERVAL 10 DAY) AND payed = 0"
  L0_2(L1_2)
end
L24_1 = Config
L24_1 = L24_1.EnableRentable
if L24_1 then
  L24_1 = CreateThread
  function L25_1()
    local L0_2, L1_2, L2_2
    L0_2 = Wait
    L1_2 = 5000
    L0_2(L1_2)
    L0_2 = L9_1
    L0_2 = L0_2()
    if L0_2 then
      L0_2 = Config
      L0_2 = L0_2.RentScheduler
      if L0_2 then
        L0_2 = Config
        L0_2 = L0_2.RentScheduler
        L0_2 = L0_2.PollMinutes
        if L0_2 then
          goto lbl_18
        end
      end
      L0_2 = 5
      ::lbl_18::
      if L0_2 < 1 then
        L0_2 = 1
      end
      while true do
        L1_2 = Wait
        L2_2 = L0_2 * 60000
        L1_2(L2_2)
        L1_2 = L22_1
        L1_2()
        L1_2 = L23_1
        L1_2()
      end
    else
      while true do
        L0_2 = Wait
        L1_2 = Config
        L1_2 = L1_2.RentTime
        L1_2 = L1_2 * 60000
        L0_2(L1_2)
        L0_2 = L22_1
        L0_2()
        L0_2 = L23_1
        L0_2()
      end
    end
  end
  L24_1(L25_1)
end
L24_1 = CreateThread
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  while true do
    L0_2 = Wait
    L1_2 = Config
    L1_2 = L1_2.CreditTime
    L1_2 = L1_2 * 60000
    L0_2(L1_2)
    L0_2 = MySQL
    L0_2 = L0_2.Sync
    L0_2 = L0_2.fetchAll
    L1_2 = "SELECT credit, creditPrice, citizenid, house FROM player_houses"
    L0_2 = L0_2(L1_2)
    L1_2 = 1
    L2_2 = #L0_2
    L3_2 = 1
    for L4_2 = L1_2, L2_2, L3_2 do
      L5_2 = L0_2[L4_2]
      L5_2 = L5_2.credit
      if L5_2 then
        L5_2 = L0_2[L4_2]
        L5_2 = L5_2.credit
        if "" ~= L5_2 then
          L5_2 = tonumber
          L6_2 = L0_2[L4_2]
          L6_2 = L6_2.credit
          L5_2 = L5_2(L6_2)
          L6_2 = tonumber
          L7_2 = L0_2[L4_2]
          L7_2 = L7_2.creditPrice
          L6_2 = L6_2(L7_2)
          if L5_2 > 0 and L6_2 then
            L7_2 = GetPlayerSourceFromIdentifier
            L8_2 = L0_2[L4_2]
            L8_2 = L8_2.citizenid
            L7_2 = L7_2(L8_2)
            if L7_2 then
              L8_2 = RemoveAccountMoney
              L9_2 = L7_2
              L10_2 = "bank"
              L11_2 = L6_2
              L8_2(L9_2, L10_2, L11_2)
              L8_2 = Notification
              L9_2 = L7_2
              L10_2 = i18n
              L10_2 = L10_2.t
              L11_2 = "rent.pay_mortgage"
              L12_2 = {}
              L12_2.price = L6_2
              L13_2 = L5_2 - L6_2
              L12_2.remaining = L13_2
              L10_2 = L10_2(L11_2, L12_2)
              L11_2 = "success"
              L8_2(L9_2, L10_2, L11_2)
              L8_2 = L5_2 - L6_2
              if L8_2 < 0 then
                L8_2 = AddAccountMoney
                L9_2 = L7_2
                L10_2 = "bank"
                L11_2 = L6_2 - L5_2
                L8_2(L9_2, L10_2, L11_2)
                L8_2 = Notification
                L9_2 = L7_2
                L10_2 = i18n
                L10_2 = L10_2.t
                L11_2 = "rent.transfer_account"
                L12_2 = {}
                L13_2 = L6_2 - L5_2
                L12_2.price = L13_2
                L10_2 = L10_2(L11_2, L12_2)
                L11_2 = "info"
                L8_2(L9_2, L10_2, L11_2)
              end
            else
              L8_2 = L5_2 - L6_2
              if L8_2 < 0 then
                L8_2 = L6_2 - L5_2
                if L8_2 then
                  goto lbl_94
                end
              end
              L8_2 = 0
              ::lbl_94::
              L9_2 = RemoveMoneyFromAccount
              L10_2 = L0_2[L4_2]
              L10_2 = L10_2.citizenid
              L11_2 = L6_2
              L12_2 = true
              L9_2(L10_2, L11_2, L12_2)
              L9_2 = AddMoneyToAccount
              L10_2 = L0_2[L4_2]
              L10_2 = L10_2.citizenid
              L11_2 = L8_2
              L9_2(L10_2, L11_2)
            end
            L8_2 = MySQL
            L8_2 = L8_2.Sync
            L8_2 = L8_2.execute
            L9_2 = "UPDATE player_houses SET credit = ? WHERE house = ?"
            L10_2 = {}
            L11_2 = L5_2 - L6_2
            if L11_2 <= 0 then
              L11_2 = 0
              if L11_2 then
                goto lbl_120
              end
            end
            L11_2 = L5_2 - L6_2
            ::lbl_120::
            L12_2 = L0_2[L4_2]
            L12_2 = L12_2.house
            L10_2[1] = L11_2
            L10_2[2] = L12_2
            L8_2(L9_2, L10_2)
          end
        end
      end
    end
  end
end
L24_1(L25_1)
L24_1 = RegisterServerCallback
L25_1 = "qb-phone:server:TransferCid"
function L26_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L4_2 = GetIdentifier
  L5_2 = A2_2
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L5_2 = GetPlayerSQLDataFromIdentifier
    L6_2 = L4_2
    L5_2 = L5_2(L6_2)
    if L5_2 then
      L6_2 = A3_2.name
      L7_2 = MySQL
      L7_2 = L7_2.Sync
      L7_2 = L7_2.execute
      L8_2 = "UPDATE player_houses SET citizenid = @iden, keyholders = @keyholders WHERE house = @house"
      L9_2 = {}
      L9_2["@iden"] = L4_2
      L9_2["@keyholders"] = "null"
      L9_2["@house"] = L6_2
      L7_2(L8_2, L9_2)
      L7_2 = TriggerClientEvent
      L8_2 = "qb-phone:client:sendMessageee"
      L9_2 = A2_2
      L7_2(L8_2, L9_2)
      L7_2 = HouseKeyholdersList
      L8_2 = {}
      L7_2[L6_2] = L8_2
      L7_2 = HouseKeyholdersList
      L7_2 = L7_2[L6_2]
      L7_2[1] = L4_2
      L7_2 = HouseOwnerCitizenidList
      L7_2[L6_2] = L4_2
      L7_2 = HouseOwnerIdentifierList
      L7_2[L6_2] = L4_2
      L7_2 = OfficialHouseOwnerList
      L7_2[L6_2] = L4_2
      L7_2 = TriggerClientEvent
      L8_2 = "housing:refreshHouse"
      L9_2 = -1
      L10_2 = L6_2
      L7_2(L8_2, L9_2, L10_2)
      L7_2 = A1_2
      L8_2 = true
      L7_2(L8_2)
    else
      L6_2 = A1_2
      L7_2 = false
      L6_2(L7_2)
    end
  else
    L5_2 = A1_2
    L6_2 = false
    L5_2(L6_2)
  end
end
L24_1(L25_1, L26_1)
L24_1 = RegisterServerEvent
L25_1 = "qb-houses:server:lockHouse"
L24_1(L25_1)
L24_1 = AddEventHandler
L25_1 = "qb-houses:server:lockHouse"
function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = TriggerClientEvent
  L3_2 = "qb-houses:client:lockHouse"
  L4_2 = -1
  L5_2 = A0_2
  L6_2 = A1_2
  L2_2(L3_2, L4_2, L5_2, L6_2)
end
L24_1(L25_1, L26_1)
L24_1 = RegisterServerEvent
L25_1 = "qb-houses:server:SetRamState"
L24_1(L25_1)
L24_1 = AddEventHandler
L25_1 = "qb-houses:server:SetRamState"
function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A1_2]
  L2_2.IsRaming = A0_2
  L2_2 = TriggerClientEvent
  L3_2 = "qb-houses:server:SetRamState"
  L4_2 = -1
  L5_2 = A0_2
  L6_2 = A1_2
  L2_2(L3_2, L4_2, L5_2, L6_2)
end
L24_1(L25_1, L26_1)
function L24_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = CheckHasKey
  L4_2 = A1_2
  L5_2 = A1_2
  L6_2 = A2_2
  L7_2 = A0_2
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  if L3_2 then
    L3_2 = true
    return L3_2
  end
  L3_2 = false
  return L3_2
end
L25_1 = RegisterServerCallback
L26_1 = "houses:getHouseData"
function L27_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L3_2 = GetIdentifier
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = L24_1
  L5_2 = A0_2
  L6_2 = L3_2
  L7_2 = A2_2
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = HouseOwnerIdentifierList
  L5_2 = L5_2[A2_2]
  L5_2 = nil ~= L5_2
  L6_2 = L2_1
  L6_2 = L6_2[A2_2]
  L7_2 = L3_1
  L7_2 = L7_2[A2_2]
  L8_2 = OfficialHouseOwnerList
  L8_2 = L8_2[A2_2]
  L8_2 = nil ~= L8_2
  L9_2 = HouseOwnerIdentifierList
  L9_2 = L9_2[A2_2]
  L9_2 = L9_2 == L3_2
  L10_2 = table
  L10_2 = L10_2.filter
  L11_2 = db
  L12_2 = L11_2
  L11_2 = L11_2.getBills
  L13_2 = A2_2
  L11_2 = L11_2(L12_2, L13_2)
  function L12_2(A0_3)
    local L1_3
    L1_3 = A0_3.payed
    L1_3 = not L1_3
    return L1_3
  end
  L10_2 = L10_2(L11_2, L12_2)
  L10_2 = #L10_2
  L10_2 = L10_2 > 1
  L11_2 = false
  L12_2 = MySQL
  L12_2 = L12_2.query
  L12_2 = L12_2.await
  L13_2 = "SELECT lights_on FROM player_houses WHERE house = ?"
  L14_2 = {}
  L15_2 = A2_2
  L14_2[1] = L15_2
  L12_2 = L12_2(L13_2, L14_2)
  if L12_2 then
    L13_2 = L12_2[1]
    if L13_2 then
      L13_2 = L12_2[1]
      L11_2 = L13_2.lights_on
    end
  end
  L13_2 = A1_2
  L14_2 = {}
  L14_2.haskey = L4_2
  L14_2.isOwned = L5_2
  L14_2.rentable = L6_2
  L14_2.purchasable = L7_2
  L14_2.isOfficialOwner = L8_2
  L14_2.isOwnedByMe = L9_2
  L14_2.billsCutOff = L10_2
  L14_2.lightsOn = L11_2
  L13_2(L14_2)
end
L25_1(L26_1, L27_1)
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L0_2 = {}
  L1_2 = {}
  L2_2 = MySQL
  L2_2 = L2_2.Sync
  L2_2 = L2_2.fetchAll
  L3_2 = [[
		SELECT house, sale_furnished
		FROM player_houses
		WHERE purchasable = 1
	]]
  L2_2 = L2_2(L3_2)
  L3_2 = ipairs
  L4_2 = L2_2 or L4_2
  if not L2_2 then
    L4_2 = {}
  end
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = L8_2.house
    L10_2 = L8_2.sale_furnished
    L1_2[L9_2] = L10_2
  end
  L3_2 = pairs
  L4_2 = Config
  L4_2 = L4_2.Houses
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = L8_2.apartmentNumber
    if L9_2 then
      L9_2 = L8_2.apartmentNumber
      if "apt-0" ~= L9_2 then
    end
    else
      L9_2 = HouseOwnerIdentifierList
      L9_2 = L9_2[L7_2]
      L9_2 = nil ~= L9_2
      L10_2 = L2_1
      L10_2 = L10_2[L7_2]
      if not L10_2 then
        L10_2 = false
      end
      L11_2 = L3_1
      L11_2 = L11_2[L7_2]
      if not L11_2 then
        L11_2 = false
      end
      L12_2 = L8_2.apartmentCount
      if L12_2 then
        L12_2 = L8_2.apartmentCount
        if L12_2 > 0 then
          L12_2 = L8_2.apartmentName
          if not L12_2 then
            L13_2 = L7_2
            L12_2 = L7_2.gsub
            L14_2 = "-apt%-0$"
            L15_2 = ""
            L12_2 = L12_2(L13_2, L14_2, L15_2)
          end
          L13_2 = false
          L14_2 = false
          L15_2 = 0
          L16_2 = 1
          L17_2 = L8_2.apartmentCount
          L18_2 = 1
          for L19_2 = L16_2, L17_2, L18_2 do
            L20_2 = L12_2
            L21_2 = "-apt-"
            L22_2 = L19_2
            L20_2 = L20_2 .. L21_2 .. L22_2
            L21_2 = L2_1
            L21_2 = L21_2[L20_2]
            if L21_2 then
              L13_2 = true
            end
            L21_2 = L3_1
            L21_2 = L21_2[L20_2]
            if L21_2 then
              L14_2 = true
            end
            L21_2 = HouseOwnerIdentifierList
            L21_2 = L21_2[L20_2]
            if nil ~= L21_2 then
              L21_2 = HouseOwnerCitizenidList
              L21_2 = L21_2[L20_2]
              if nil ~= L21_2 then
                L15_2 = L15_2 + 1
              end
            end
          end
          L16_2 = L8_2.apartmentCount
          L16_2 = L15_2 >= L16_2
          L17_2 = L8_2.apartmentCount
          L17_2 = L15_2 < L17_2
          L10_2 = L13_2
          L11_2 = L14_2 or L11_2
          if not L14_2 then
            L11_2 = L17_2
          end
          L9_2 = L16_2
        end
      end
      if L11_2 then
        L12_2 = L8_2.hideFromBrowser
        if L12_2 then
      end
      else
        L12_2 = nil
        if L9_2 then
          L13_2 = HouseOwnerIdentifierList
          L13_2 = L13_2[L7_2]
          if L13_2 then
            L13_2 = HouseOwnerIdentifierList
            L13_2 = L13_2[L7_2]
            L14_2 = GetCharacterFromIdentifier
            L15_2 = L13_2
            L14_2, L15_2 = L14_2(L15_2)
            if L14_2 and L15_2 then
              L16_2 = L14_2
              L17_2 = " "
              L18_2 = L15_2
              L16_2 = L16_2 .. L17_2 .. L18_2
              L12_2 = L16_2
            else
              L16_2 = GetPlayerFromIdentifier
              L17_2 = L13_2
              L16_2 = L16_2(L17_2)
              if L16_2 then
                L17_2 = GetCharacterName
                L18_2 = L16_2.source
                L17_2, L18_2 = L17_2(L18_2)
                L15_2 = L18_2
                L14_2 = L17_2
                if L14_2 and L15_2 then
                  L17_2 = L14_2
                  L18_2 = " "
                  L19_2 = L15_2
                  L17_2 = L17_2 .. L18_2 .. L19_2
                  L12_2 = L17_2
                else
                  L12_2 = "Unknown Owner"
                end
              else
                L12_2 = "Unknown Owner"
              end
            end
          end
        end
        L13_2 = nil
        if L10_2 then
          L14_2 = L8_2.price
          if L14_2 then
            L13_2 = L8_2.price
          end
        end
        L14_2 = {}
        L14_2.owned = L9_2
        L14_2.rentable = L10_2
        L14_2.purchasable = L11_2
        L14_2.rentPrice = L13_2
        L14_2.ownerName = L12_2
        L14_2.ownerPhone = nil
        L15_2 = L1_2[L7_2]
        L14_2.saleFurnished = L15_2
        L0_2[L7_2] = L14_2
      end
    end
  end
  return L0_2
end
HousingBuildBrowserDataMap = L25_1
L25_1 = lib
L25_1 = L25_1.callback
L25_1 = L25_1.register
L26_1 = "housing:getHouseBrowserData"
function L27_1(A0_2)
  local L1_2
  L1_2 = HousingBuildBrowserDataMap
  return L1_2()
end
L25_1(L26_1, L27_1)
L25_1 = RegisterServerCallback
L26_1 = "housing:getApartmentsData"
function L27_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  L4_2 = {}
  L5_2 = GetIdentifier
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  L7_2 = A2_2
  L6_2 = A2_2.gsub
  L8_2 = "-apt%-%d+"
  L9_2 = ""
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L7_2 = pairs
  L8_2 = Config
  L8_2 = L8_2.Houses
  L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
  for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
    L13_2 = L12_2.apartmentName
    if L13_2 == L6_2 then
      L13_2 = L12_2.apartmentNumber
      if "apt-0" ~= L13_2 then
        L13_2 = L24_1
        L14_2 = A0_2
        L15_2 = L5_2
        L16_2 = L11_2
        L13_2 = L13_2(L14_2, L15_2, L16_2)
        L14_2 = HouseOwnerIdentifierList
        L14_2 = L14_2[L11_2]
        L14_2 = nil ~= L14_2
        L15_2 = L2_1
        L15_2 = L15_2[L11_2]
        L16_2 = L3_1
        L16_2 = L16_2[L11_2]
        L17_2 = HouseOwnerIdentifierList
        L17_2 = L17_2[L11_2]
        L17_2 = L17_2 == L5_2
        L18_2 = OfficialHouseOwnerList
        L18_2 = L18_2[L11_2]
        L18_2 = nil ~= L18_2
        L19_2 = false
        L20_2 = nil
        if A3_2 then
          L21_2 = MySQL
          L21_2 = L21_2.Sync
          L21_2 = L21_2.fetchAll
          L22_2 = "SELECT * FROM player_houses WHERE house = ?"
          L23_2 = {}
          L24_2 = L11_2
          L23_2[1] = L24_2
          L21_2 = L21_2(L22_2, L23_2)
          L22_2 = L21_2[1]
          if L22_2 then
            L22_2 = L21_2[1]
            L22_2 = L22_2.rented
            L19_2 = 1 == L22_2
          end
        end
        if L14_2 then
          L21_2 = GetCharacterFromIdentifier
          L22_2 = HouseOwnerCitizenidList
          L22_2 = L22_2[L11_2]
          L21_2 = L21_2(L22_2)
          L20_2 = L21_2
        end
        L21_2 = table
        L21_2 = L21_2.insert
        L22_2 = L4_2
        L23_2 = {}
        L24_2 = L12_2.id
        L23_2.id = L24_2
        L23_2.house = L11_2
        L23_2.haskey = L13_2
        L23_2.isOwned = L14_2
        L23_2.rentable = L15_2
        L23_2.purchasable = L16_2
        L23_2.isOfficialOwner = L18_2
        L23_2.isOwnedByMe = L17_2
        L23_2.rented = L19_2
        L24_2 = L20_2 or L24_2
        if not L20_2 then
          L24_2 = "Unknown Owner"
        end
        L23_2.ownerName = L24_2
        L21_2(L22_2, L23_2)
      end
    end
  end
  L7_2 = table
  L7_2 = L7_2.sort
  L8_2 = L4_2
  function L9_2(A0_3, A1_3)
    local L2_3, L3_3
    L2_3 = A0_3.isOwnedByMe
    if L2_3 then
      L2_3 = A1_3.isOwnedByMe
      if not L2_3 then
        L2_3 = true
        return L2_3
    end
    else
      L2_3 = A0_3.isOwnedByMe
      if not L2_3 then
        L2_3 = A1_3.isOwnedByMe
        if L2_3 then
          L2_3 = false
          return L2_3
        end
      end
    end
    L2_3 = A0_3.house
    L3_3 = A1_3.house
    L2_3 = L2_3 < L3_3
    return L2_3
  end
  L7_2(L8_2, L9_2)
  L7_2 = A1_2
  L8_2 = L4_2
  L7_2(L8_2)
end
L25_1(L26_1, L27_1)
L25_1 = RegisterServerCallback
L26_1 = "qb-houses:server:getHouseOwner"
function L27_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2
  L3_2 = A1_2
  L4_2 = HouseOwnerCitizenidList
  L4_2 = L4_2[A2_2]
  L3_2(L4_2)
end
L25_1(L26_1, L27_1)
function L25_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L2_2 = {}
  L3_2 = GetIdentifier
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = HouseKeyholdersList
  L4_2 = L4_2[A1_2]
  if nil ~= L4_2 then
    L4_2 = 1
    L5_2 = HouseKeyholdersList
    L5_2 = L5_2[A1_2]
    L5_2 = #L5_2
    L6_2 = 1
    for L7_2 = L4_2, L5_2, L6_2 do
      L8_2 = HouseOwnerIdentifierList
      L8_2 = L8_2[A1_2]
      L9_2 = HouseKeyholdersList
      L9_2 = L9_2[A1_2]
      L9_2 = L9_2[L7_2]
      L8_2 = L8_2 == L9_2
      L9_2 = HouseKeyholdersList
      L9_2 = L9_2[A1_2]
      L9_2 = L9_2[L7_2]
      if L3_2 ~= L9_2 and not L8_2 then
        L9_2 = GetCharacterFromIdentifier
        L10_2 = HouseKeyholdersList
        L10_2 = L10_2[A1_2]
        L10_2 = L10_2[L7_2]
        L9_2, L10_2 = L9_2(L10_2)
        L11_2 = table
        L11_2 = L11_2.insert
        L12_2 = L2_2
        L13_2 = {}
        L13_2.firstname = L9_2
        L13_2.lastname = L10_2
        L14_2 = HouseKeyholdersList
        L14_2 = L14_2[A1_2]
        L14_2 = L14_2[L7_2]
        L13_2.citizenid = L14_2
        L11_2(L12_2, L13_2)
      end
    end
  end
  return L2_2
end
GetKeyHolders = L25_1
function L25_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L4_2 = Debug
  L5_2 = "CheckHasKey info:"
  L6_2 = json
  L6_2 = L6_2.encode
  L7_2 = A0_2
  L6_2 = L6_2(L7_2)
  L7_2 = json
  L7_2 = L7_2.encode
  L8_2 = A1_2
  L7_2 = L7_2(L8_2)
  L8_2 = json
  L8_2 = L8_2.encode
  L9_2 = A2_2
  L8_2, L9_2 = L8_2(L9_2)
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = HouseOwnerIdentifierList
  L4_2 = L4_2[A2_2]
  if nil ~= L4_2 then
    L4_2 = HouseOwnerCitizenidList
    L4_2 = L4_2[A2_2]
    if nil ~= L4_2 then
      L4_2 = HouseOwnerIdentifierList
      L4_2 = L4_2[A2_2]
      if L4_2 == A0_2 then
        L4_2 = HouseOwnerCitizenidList
        L4_2 = L4_2[A2_2]
        if L4_2 == A1_2 then
          L4_2 = true
          return L4_2
      end
      else
        L4_2 = HouseKeyholdersList
        L4_2 = L4_2[A2_2]
        if nil ~= L4_2 then
          L4_2 = 1
          L5_2 = HouseKeyholdersList
          L5_2 = L5_2[A2_2]
          L5_2 = #L5_2
          L6_2 = 1
          for L7_2 = L4_2, L5_2, L6_2 do
            L8_2 = HouseKeyholdersList
            L8_2 = L8_2[A2_2]
            L8_2 = L8_2[L7_2]
            if L8_2 == A1_2 then
              L8_2 = true
              return L8_2
            end
          end
        end
      end
    end
  end
  L4_2 = Config
  L4_2 = L4_2.EnableMetaKey
  if L4_2 then
    L4_2 = Config
    L4_2 = L4_2.MetaKeyCheckOnEntry
    if L4_2 and A3_2 then
      L4_2 = CheckHasMetaKey
      if L4_2 then
        L4_2 = CheckHasMetaKey
        L5_2 = A3_2
        L6_2 = A2_2
        L4_2 = L4_2(L5_2, L6_2)
        if L4_2 then
          L4_2 = Debug
          L5_2 = "CheckHasKey: Player has meta key for house:"
          L6_2 = A2_2
          L4_2(L5_2, L6_2)
          L4_2 = true
          return L4_2
        end
      end
    end
  end
  L4_2 = false
  return L4_2
end
CheckHasKey = L25_1
L25_1 = exports
L26_1 = "CheckHasKey"
L27_1 = CheckHasKey
L25_1(L26_1, L27_1)
L25_1 = CreateThread
function L26_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = MySQL
  L0_2 = L0_2.Async
  L0_2 = L0_2.fetchAll
  L1_2 = "SELECT * FROM player_houses"
  L2_2 = {}
  function L3_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    if nil ~= A0_3 then
      L1_3 = pairs
      L2_3 = A0_3
      L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3)
      for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
        L7_3 = HouseOwnerIdentifierList
        L8_3 = L6_3.house
        L9_3 = L6_3.citizenid
        L7_3[L8_3] = L9_3
        L7_3 = HouseOwnerCitizenidList
        L8_3 = L6_3.house
        L9_3 = L6_3.citizenid
        L7_3[L8_3] = L9_3
        L7_3 = OfficialHouseOwnerList
        L8_3 = L6_3.house
        L9_3 = L6_3.owner
        L7_3[L8_3] = L9_3
        L8_3 = L6_3.house
        L7_3 = L2_1
        L9_3 = L6_3.rentable
        L7_3[L8_3] = L9_3
        L8_3 = L6_3.house
        L7_3 = L3_1
        L9_3 = L6_3.purchasable
        L7_3[L8_3] = L9_3
        L7_3 = HouseKeyholdersList
        L8_3 = L6_3.house
        L9_3 = json
        L9_3 = L9_3.decode
        L10_3 = L6_3.keyholders
        L9_3 = L9_3(L10_3)
        L7_3[L8_3] = L9_3
      end
    end
  end
  L0_2(L1_2, L2_2, L3_2)
end
L25_1(L26_1)
L25_1 = RegisterServerEvent
L26_1 = "qb-houses:server:OpenDoor"
L25_1(L26_1)
L25_1 = AddEventHandler
L26_1 = "qb-houses:server:OpenDoor"
function L27_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = source
  L3_2 = GetPlayerSourceFromSource
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L4_2 = vec3
    L5_2 = Config
    L5_2 = L5_2.Houses
    L5_2 = L5_2[A1_2]
    L5_2 = L5_2.coords
    L5_2 = L5_2.enter
    L5_2 = L5_2.x
    L6_2 = Config
    L6_2 = L6_2.Houses
    L6_2 = L6_2[A1_2]
    L6_2 = L6_2.coords
    L6_2 = L6_2.enter
    L6_2 = L6_2.y
    L7_2 = Config
    L7_2 = L7_2.Houses
    L7_2 = L7_2[A1_2]
    L7_2 = L7_2.coords
    L7_2 = L7_2.enter
    L7_2 = L7_2.z
    L4_2 = L4_2(L5_2, L6_2, L7_2)
    L5_2 = GetEntityCoords
    L6_2 = GetPlayerPed
    L7_2 = L3_2
    L6_2, L7_2, L8_2 = L6_2(L7_2)
    L5_2 = L5_2(L6_2, L7_2, L8_2)
    L5_2 = L5_2 - L4_2
    L5_2 = #L5_2
    if L5_2 < 2.0 then
      L5_2 = TriggerClientEvent
      L6_2 = "qb-houses:client:SpawnInApartment"
      L7_2 = L3_2
      L8_2 = A1_2
      L5_2(L6_2, L7_2, L8_2)
    else
      L5_2 = Notification
      L6_2 = L2_2
      L7_2 = i18n
      L7_2 = L7_2.t
      L8_2 = "invite_play_far_other"
      L7_2 = L7_2(L8_2)
      L8_2 = "error"
      L5_2(L6_2, L7_2, L8_2)
      L5_2 = Notification
      L6_2 = L3_2
      L7_2 = i18n
      L7_2 = L7_2.t
      L8_2 = "invite_play_far"
      L7_2 = L7_2(L8_2)
      L8_2 = "error"
      L5_2(L6_2, L7_2, L8_2)
    end
  end
end
L25_1(L26_1, L27_1)
L25_1 = {}
L26_1 = {}
DoorbellPlayers = L26_1
L26_1 = RegisterServerEvent
L27_1 = "qb-houses:server:RingDoor"
L26_1(L27_1)
L26_1 = AddEventHandler
L27_1 = "qb-houses:server:RingDoor"
function L28_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L1_2 = source
  L2_2 = GetIdentifier
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    return
  end
  L3_2 = A0_2
  L4_2 = ":"
  L5_2 = L2_2
  L3_2 = L3_2 .. L4_2 .. L5_2
  L4_2 = L25_1
  L4_2 = L4_2[L3_2]
  L5_2 = os
  L5_2 = L5_2.time
  L5_2 = L5_2()
  if L4_2 then
    L6_2 = L5_2 - L4_2
    if L6_2 < 10 then
      return
    end
  end
  L6_2 = L25_1
  L6_2[L3_2] = L5_2
  L6_2 = SetTimeout
  L7_2 = 10000
  function L8_2()
    local L0_3, L1_3
    L1_3 = L3_2
    L0_3 = L25_1
    L0_3[L1_3] = nil
  end
  L6_2(L7_2, L8_2)
  L6_2 = GetCharacterName
  L7_2 = L1_2
  L6_2, L7_2 = L6_2(L7_2)
  L8_2 = GetPlayerName
  L9_2 = L1_2
  L8_2 = L8_2(L9_2)
  L9_2 = DoorbellPlayers
  L9_2 = L9_2[A0_2]
  if not L9_2 then
    L9_2 = DoorbellPlayers
    L10_2 = {}
    L9_2[A0_2] = L10_2
  end
  L9_2 = {}
  L9_2.id = L1_2
  L10_2 = L6_2 or L10_2
  if not L6_2 then
    L10_2 = ""
  end
  L9_2.firstname = L10_2
  L10_2 = L7_2 or L10_2
  if not L7_2 then
    L10_2 = ""
  end
  L9_2.lastname = L10_2
  L10_2 = L8_2 or L10_2
  if not L8_2 then
    L10_2 = ""
  end
  L9_2.name = L10_2
  L10_2 = L5_2 * 1000
  L9_2.timestamp = L10_2
  L10_2 = false
  L11_2 = ipairs
  L12_2 = DoorbellPlayers
  L12_2 = L12_2[A0_2]
  L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2)
  for L15_2, L16_2 in L11_2, L12_2, L13_2, L14_2 do
    L17_2 = L16_2.id
    if L17_2 == L1_2 then
      L17_2 = DoorbellPlayers
      L17_2 = L17_2[A0_2]
      L17_2[L15_2] = L9_2
      L10_2 = true
      break
    end
  end
  if not L10_2 then
    L11_2 = table
    L11_2 = L11_2.insert
    L12_2 = DoorbellPlayers
    L12_2 = L12_2[A0_2]
    L13_2 = L9_2
    L11_2(L12_2, L13_2)
  end
  L11_2 = SetTimeout
  L12_2 = 10000
  function L13_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3
    L0_3 = DoorbellPlayers
    L1_3 = A0_2
    L0_3 = L0_3[L1_3]
    if L0_3 then
      L0_3 = ipairs
      L1_3 = DoorbellPlayers
      L2_3 = A0_2
      L1_3 = L1_3[L2_3]
      L0_3, L1_3, L2_3, L3_3 = L0_3(L1_3)
      for L4_3, L5_3 in L0_3, L1_3, L2_3, L3_3 do
        L6_3 = L5_3.id
        L7_3 = L1_2
        if L6_3 == L7_3 then
          L6_3 = table
          L6_3 = L6_3.remove
          L7_3 = DoorbellPlayers
          L8_3 = A0_2
          L7_3 = L7_3[L8_3]
          L8_3 = L4_3
          L6_3(L7_3, L8_3)
          break
        end
      end
      L0_3 = DoorbellPlayers
      L1_3 = A0_2
      L0_3 = L0_3[L1_3]
      L0_3 = #L0_3
      if 0 == L0_3 then
        L0_3 = DoorbellPlayers
        L1_3 = A0_2
        L0_3[L1_3] = nil
      end
    end
  end
  L11_2(L12_2, L13_2)
  L11_2 = TriggerClientEvent
  L12_2 = "qb-houses:client:RingDoor"
  L13_2 = -1
  L14_2 = L1_2
  L15_2 = A0_2
  L11_2(L12_2, L13_2, L14_2, L15_2)
end
L26_1(L27_1, L28_1)
L26_1 = lib
L26_1 = L26_1.callback
L26_1 = L26_1.register
L27_1 = "housing:getDoorbellPlayers"
function L28_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  if A1_2 then
    L2_2 = DoorbellPlayers
    L2_2 = L2_2[A1_2]
    if L2_2 then
      goto lbl_10
    end
  end
  L2_2 = {}
  do return L2_2 end
  ::lbl_10::
  L2_2 = os
  L2_2 = L2_2.time
  L2_2 = L2_2()
  L2_2 = L2_2 * 1000
  L3_2 = {}
  L4_2 = ipairs
  L5_2 = DoorbellPlayers
  L5_2 = L5_2[A1_2]
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = L9_2.timestamp
    L10_2 = L2_2 - L10_2
    L11_2 = 10000
    if L10_2 < L11_2 then
      L10_2 = table
      L10_2 = L10_2.insert
      L11_2 = L3_2
      L12_2 = L9_2
      L10_2(L11_2, L12_2)
    end
  end
  return L3_2
end
L26_1(L27_1, L28_1)
L26_1 = RegisterNetEvent
L27_1 = "qb-houses:saveStash"
function L28_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = MySQL
  L2_2 = L2_2.Sync
  L2_2 = L2_2.fetchAll
  L3_2 = "select * from player_houses where house = @hosue"
  L4_2 = {}
  L4_2["@house"] = A0_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = L2_2[1]
  if not L3_2 then
    return
  end
  L3_2 = json
  L3_2 = L3_2.decode
  L4_2 = L2_2[1]
  L4_2 = L4_2.decorateStash
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L4_2 = L3_2[1]
    if L4_2 then
      goto lbl_26
    end
  end
  L4_2 = {}
  L3_2 = L4_2
  ::lbl_26::
  L4_2 = table
  L4_2 = L4_2.insert
  L5_2 = L3_2
  L6_2 = A1_2
  L4_2(L5_2, L6_2)
  L4_2 = MySQL
  L4_2 = L4_2.Sync
  L4_2 = L4_2.execute
  L5_2 = "update player_houses SET decorateStash = @newStash where house = @house"
  L6_2 = {}
  L6_2["@house"] = A0_2
  L6_2["@newStash"] = L3_2
  L4_2(L5_2, L6_2)
end
L26_1(L27_1, L28_1)
L26_1 = RegisterServerCallback
L27_1 = "qb-houses:server:getHouseDecorateStashes"
function L28_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.fetchAll
  L4_2 = "SELECT * FROM `player_houses` WHERE `house` = '"
  L5_2 = A2_2
  L6_2 = "'"
  L4_2 = L4_2 .. L5_2 .. L6_2
  L3_2 = L3_2(L4_2)
  L4_2 = L3_2[1]
  if nil ~= L4_2 then
    L4_2 = L3_2[1]
    L4_2 = L4_2.decorateStash
    if nil ~= L4_2 then
      L4_2 = A1_2
      L5_2 = json
      L5_2 = L5_2.decode
      L6_2 = L3_2[1]
      L6_2 = L6_2.decorateStash
      L5_2, L6_2 = L5_2(L6_2)
      L4_2(L5_2, L6_2)
    else
      L4_2 = A1_2
      L5_2 = false
      L4_2(L5_2)
    end
  else
    L4_2 = A1_2
    L5_2 = false
    L4_2(L5_2)
  end
end
L26_1(L27_1, L28_1)
L26_1 = lib
L26_1 = L26_1.callback
L26_1 = L26_1.register
L27_1 = "housing:getLocations"
function L28_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = Debug
  L3_2 = "house"
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
  L2_2 = MySQL
  L2_2 = L2_2.query
  L2_2 = L2_2.await
  L3_2 = "SELECT stash, outfit, logout, charge, tablet FROM `player_houses` WHERE `house` = ?"
  L4_2 = {}
  L5_2 = A1_2
  L4_2[1] = L5_2
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L3_2 = L2_2[1]
    if L3_2 then
      goto lbl_20
    end
  end
  L3_2 = nil
  ::lbl_20::
  if not L3_2 then
    L4_2 = Debug
    L5_2 = "getlocations"
    L6_2 = L2_2
    L4_2(L5_2, L6_2)
    L4_2 = nil
    return L4_2
  end
  L4_2 = MySQL
  L4_2 = L4_2.single
  L4_2 = L4_2.await
  L5_2 = "SELECT coords FROM `houselocations` WHERE `name` = ? LIMIT 1"
  L6_2 = {}
  L7_2 = A1_2
  L6_2[1] = L7_2
  L4_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L5_2 = L4_2.coords
    if L5_2 then
      L5_2 = json
      L5_2 = L5_2.decode
      L6_2 = L4_2.coords
      L5_2 = L5_2(L6_2)
      if not L5_2 then
        L5_2 = {}
      end
      L6_2 = L5_2.delivery
      if L6_2 then
        L6_2 = json
        L6_2 = L6_2.encode
        L7_2 = L5_2.delivery
        L6_2 = L6_2(L7_2)
        L3_2.delivery = L6_2
      end
    end
  end
  L5_2 = Debug
  L6_2 = "getlocations"
  L7_2 = L3_2
  L5_2(L6_2, L7_2)
  return L3_2
end
L26_1(L27_1, L28_1)
L26_1 = RegisterServerCallback
L27_1 = "qb-houses:server:getPlayerHouses"
function L28_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L3_2 = A0_2
  L4_2 = "SELECT house, owner, citizenid, rented, rentable, purchasable FROM player_houses"
  if A2_2 then
    L5_2 = L4_2
    L6_2 = " WHERE house = ?"
    L5_2 = L5_2 .. L6_2
    L4_2 = L5_2
  end
  L5_2 = MySQL
  L5_2 = L5_2.Sync
  L5_2 = L5_2.fetchAll
  L6_2 = L4_2
  if A2_2 then
    L7_2 = {}
    L8_2 = A2_2
    L7_2[1] = L8_2
    if L7_2 then
      goto lbl_23
    end
  end
  L7_2 = {}
  ::lbl_23::
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = A1_2
  L7_2 = L5_2
  L6_2(L7_2)
end
L26_1(L27_1, L28_1)
L26_1 = RegisterServerEvent
L27_1 = "qb-houses:server:setLocation"
L26_1(L27_1)
L26_1 = AddEventHandler
L27_1 = "qb-houses:server:setLocation"
function L28_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L3_2 = source
  L4_2 = json
  L4_2 = L4_2.encode
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L5_2 = L4_2
  if 1 == A2_2 then
    L6_2 = MySQL
    L6_2 = L6_2.update
    L6_2 = L6_2.await
    L7_2 = "UPDATE `player_houses` SET `stash` = ? WHERE `house` = ?"
    L8_2 = {}
    L9_2 = L4_2
    L10_2 = A1_2
    L8_2[1] = L9_2
    L8_2[2] = L10_2
    L6_2(L7_2, L8_2)
    L6_2 = GetResourceState
    L7_2 = "qs-inventory"
    L6_2 = L6_2(L7_2)
    L7_2 = L6_2
    L6_2 = L6_2.find
    L8_2 = "started"
    L6_2 = L6_2(L7_2, L8_2)
    if L6_2 then
      L6_2 = Config
      L6_2 = L6_2.EnableQuests
      if L6_2 then
        L6_2 = exports
        L6_2 = L6_2["qs-inventory"]
        L7_2 = L6_2
        L6_2 = L6_2.UpdateQuestProgress
        L8_2 = L3_2
        L9_2 = "place_home_stash"
        L10_2 = 100
        L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
        if L6_2 then
          L7_2 = Debug
          L8_2 = "Quest \"place_home_stash\" progress updated"
          L7_2(L8_2)
        else
          L7_2 = Debug
          L8_2 = "Failed to update quest \"place_home_stash\""
          L7_2(L8_2)
        end
      end
    end
  elseif 2 == A2_2 then
    L6_2 = MySQL
    L6_2 = L6_2.update
    L6_2 = L6_2.await
    L7_2 = "UPDATE `player_houses` SET `outfit` = ? WHERE `house` = ?"
    L8_2 = {}
    L9_2 = L4_2
    L10_2 = A1_2
    L8_2[1] = L9_2
    L8_2[2] = L10_2
    L6_2(L7_2, L8_2)
    L6_2 = GetResourceState
    L7_2 = "qs-inventory"
    L6_2 = L6_2(L7_2)
    L7_2 = L6_2
    L6_2 = L6_2.find
    L8_2 = "started"
    L6_2 = L6_2(L7_2, L8_2)
    if L6_2 then
      L6_2 = Config
      L6_2 = L6_2.EnableQuests
      if L6_2 then
        L6_2 = exports
        L6_2 = L6_2["qs-inventory"]
        L7_2 = L6_2
        L6_2 = L6_2.UpdateQuestProgress
        L8_2 = L3_2
        L9_2 = "place_home_wardrobe"
        L10_2 = 100
        L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
        if L6_2 then
          L7_2 = Debug
          L8_2 = "Quest \"place_home_wardrobe\" progress updated"
          L7_2(L8_2)
        else
          L7_2 = Debug
          L8_2 = "Failed to update quest \"place_home_wardrobe\""
          L7_2(L8_2)
        end
      end
    end
  elseif 3 == A2_2 then
    L6_2 = MySQL
    L6_2 = L6_2.update
    L6_2 = L6_2.await
    L7_2 = "UPDATE `player_houses` SET `logout` = ? WHERE `house` = ?"
    L8_2 = {}
    L9_2 = L4_2
    L10_2 = A1_2
    L8_2[1] = L9_2
    L8_2[2] = L10_2
    L6_2(L7_2, L8_2)
  elseif 4 == A2_2 then
    L6_2 = MySQL
    L6_2 = L6_2.update
    L6_2 = L6_2.await
    L7_2 = "UPDATE `player_houses` SET `charge` = ? WHERE `house` = ?"
    L8_2 = {}
    L9_2 = L4_2
    L10_2 = A1_2
    L8_2[1] = L9_2
    L8_2[2] = L10_2
    L6_2(L7_2, L8_2)
    L6_2 = GetResourceState
    L7_2 = "qs-inventory"
    L6_2 = L6_2(L7_2)
    L7_2 = L6_2
    L6_2 = L6_2.find
    L8_2 = "started"
    L6_2 = L6_2(L7_2, L8_2)
    if L6_2 then
      L6_2 = Config
      L6_2 = L6_2.EnableQuests
      if L6_2 then
        L6_2 = exports
        L6_2 = L6_2["qs-inventory"]
        L7_2 = L6_2
        L6_2 = L6_2.UpdateQuestProgress
        L8_2 = L3_2
        L9_2 = "place_phone_charger"
        L10_2 = 100
        L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
        if L6_2 then
          L7_2 = Debug
          L8_2 = "Quest \"place_phone_charger\" progress updated"
          L7_2(L8_2)
        else
          L7_2 = Debug
          L8_2 = "Failed to update quest \"place_phone_charger\""
          L7_2(L8_2)
        end
      end
    end
    L6_2 = HousingBatteryBridge_Register
    L7_2 = A1_2
    L8_2 = A0_2
    L6_2(L7_2, L8_2)
  elseif 8 == A2_2 then
    L6_2 = MySQL
    L6_2 = L6_2.single
    L6_2 = L6_2.await
    L7_2 = "SELECT coords FROM `houselocations` WHERE `name` = ? LIMIT 1"
    L8_2 = {}
    L9_2 = A1_2
    L8_2[1] = L9_2
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = {}
    if L6_2 then
      L8_2 = L6_2.coords
      if L8_2 then
        L8_2 = json
        L8_2 = L8_2.decode
        L9_2 = L6_2.coords
        L8_2 = L8_2(L9_2)
        L7_2 = L8_2 or L7_2
        if not L8_2 then
          L8_2 = {}
          L7_2 = L8_2
        end
      end
    end
    L8_2 = {}
    L9_2 = tonumber
    L10_2 = A0_2.x
    L9_2 = L9_2(L10_2)
    if not L9_2 then
      L9_2 = A0_2.x
    end
    L8_2.x = L9_2
    L9_2 = tonumber
    L10_2 = A0_2.y
    L9_2 = L9_2(L10_2)
    if not L9_2 then
      L9_2 = A0_2.y
    end
    L8_2.y = L9_2
    L9_2 = tonumber
    L10_2 = A0_2.z
    L9_2 = L9_2(L10_2)
    if not L9_2 then
      L9_2 = A0_2.z
    end
    L8_2.z = L9_2
    L9_2 = tonumber
    L10_2 = A0_2.w
    L9_2 = L9_2(L10_2)
    if not L9_2 then
      L9_2 = 0.0
    end
    L8_2.w = L9_2
    L7_2.delivery = L8_2
    L8_2 = MySQL
    L8_2 = L8_2.update
    L8_2 = L8_2.await
    L9_2 = "UPDATE `houselocations` SET `coords` = ? WHERE `name` = ?"
    L10_2 = {}
    L11_2 = json
    L11_2 = L11_2.encode
    L12_2 = L7_2
    L11_2 = L11_2(L12_2)
    L12_2 = A1_2
    L10_2[1] = L11_2
    L10_2[2] = L12_2
    L8_2(L9_2, L10_2)
    L8_2 = json
    L8_2 = L8_2.encode
    L9_2 = L7_2.delivery
    L8_2 = L8_2(L9_2)
    L5_2 = L8_2
  elseif 9 == A2_2 then
    L6_2 = MySQL
    L6_2 = L6_2.update
    L6_2 = L6_2.await
    L7_2 = "UPDATE `player_houses` SET `tablet` = ? WHERE `house` = ?"
    L8_2 = {}
    L9_2 = L4_2
    L10_2 = A1_2
    L8_2[1] = L9_2
    L8_2[2] = L10_2
    L6_2(L7_2, L8_2)
  elseif 6 == A2_2 then
    L6_2 = MySQL
    L6_2 = L6_2.Sync
    L6_2 = L6_2.fetchAll
    L7_2 = "SELECT console FROM `player_houses` WHERE `house` = ?"
    L8_2 = {}
    L9_2 = A1_2
    L8_2[1] = L9_2
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = json
    L7_2 = L7_2.decode
    L8_2 = L6_2[1]
    L8_2 = L8_2.console
    L7_2 = L7_2(L8_2)
    if not L7_2 then
      L7_2 = {}
    end
    L7_2.tv = A0_2
    L8_2 = MySQL
    L8_2 = L8_2.Sync
    L8_2 = L8_2.execute
    L9_2 = "UPDATE `player_houses` SET `console` = '"
    L10_2 = json
    L10_2 = L10_2.encode
    L11_2 = L7_2
    L10_2 = L10_2(L11_2)
    L11_2 = "' WHERE `house` = '"
    L12_2 = A1_2
    L13_2 = "'"
    L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2 .. L13_2
    L8_2(L9_2)
  elseif 7 == A2_2 then
    L6_2 = MySQL
    L6_2 = L6_2.Sync
    L6_2 = L6_2.fetchAll
    L7_2 = "SELECT console FROM `player_houses` WHERE `house` = ?"
    L8_2 = {}
    L9_2 = A1_2
    L8_2[1] = L9_2
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = json
    L7_2 = L7_2.decode
    L8_2 = L6_2[1]
    L8_2 = L8_2.console
    L7_2 = L7_2(L8_2)
    if not L7_2 then
      L7_2 = {}
    end
    L7_2.sit = A0_2
    L8_2 = MySQL
    L8_2 = L8_2.Sync
    L8_2 = L8_2.execute
    L9_2 = "UPDATE `player_houses` SET `console` = '"
    L10_2 = json
    L10_2 = L10_2.encode
    L11_2 = L7_2
    L10_2 = L10_2(L11_2)
    L11_2 = "' WHERE `house` = '"
    L12_2 = A1_2
    L13_2 = "'"
    L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2 .. L13_2
    L8_2(L9_2)
  end
  L6_2 = Debug
  L7_2 = "refresh locations, type: "
  L8_2 = A2_2
  L9_2 = " house: "
  L10_2 = A1_2
  L11_2 = " coords: "
  L12_2 = tostring
  L13_2 = L5_2
  L12_2 = L12_2(L13_2)
  L13_2 = ""
  L7_2 = L7_2 .. L8_2 .. L9_2 .. L10_2 .. L11_2 .. L12_2 .. L13_2
  L6_2(L7_2)
  if 8 == A2_2 then
    L6_2 = {}
    L7_2 = {}
    if L3_2 and L3_2 > 0 then
      L7_2[L3_2] = true
      L8_2 = #L6_2
      L8_2 = L8_2 + 1
      L6_2[L8_2] = L3_2
    end
    L8_2 = HouseRoutings
    if L8_2 then
      L8_2 = HouseRoutings
      L8_2 = L8_2[A1_2]
    end
    if L8_2 then
      L9_2 = A2_2
      L10_2 = L8_2.players
      L9_2 = L9_2(L10_2)
      if "table" == L9_2 then
        L9_2 = 1
        L10_2 = L8_2.players
        L10_2 = #L10_2
        L11_2 = 1
        for L12_2 = L9_2, L10_2, L11_2 do
          L13_2 = tonumber
          L14_2 = L8_2.players
          L14_2 = L14_2[L12_2]
          L13_2 = L13_2(L14_2)
          if L13_2 then
            L14_2 = L7_2[L13_2]
            if not L14_2 then
              L14_2 = DoesPlayerExist
              L15_2 = tostring
              L16_2 = L13_2
              L15_2, L16_2, L17_2, L18_2 = L15_2(L16_2)
              L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2)
              if L14_2 > 0 then
                L7_2[L13_2] = true
                L14_2 = #L6_2
                L14_2 = L14_2 + 1
                L6_2[L14_2] = L13_2
              end
            end
          end
        end
      end
    end
    L9_2 = 1
    L10_2 = #L6_2
    L11_2 = 1
    for L12_2 = L9_2, L10_2, L11_2 do
      L13_2 = TriggerClientEvent
      L14_2 = "qb-houses:client:refreshLocations"
      L15_2 = L6_2[L12_2]
      L16_2 = A1_2
      L17_2 = L5_2
      L18_2 = A2_2
      L13_2(L14_2, L15_2, L16_2, L17_2, L18_2)
    end
  else
    L6_2 = TriggerClientEvent
    L7_2 = "qb-houses:client:refreshLocations"
    L8_2 = -1
    L9_2 = A1_2
    L10_2 = L5_2
    L11_2 = A2_2
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  end
end
L26_1(L27_1, L28_1)
L26_1 = RegisterServerCallback
L27_1 = "qb-houses:GetCreditState"
function L28_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.fetchAll
  L4_2 = "SELECT * FROM player_houses WHERE house = ?"
  L5_2 = {}
  L6_2 = A2_2
  L5_2[1] = L6_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = L3_2[1]
  if L4_2 then
    L4_2 = L4_2.credit
  end
  if L4_2 then
    L5_2 = tonumber
    L6_2 = L4_2
    L5_2 = L5_2(L6_2)
    if L5_2 > 0 then
      L5_2 = A1_2
      L6_2 = true
      L5_2(L6_2)
  end
  else
    L5_2 = A1_2
    L6_2 = false
    L5_2(L6_2)
  end
end
L26_1(L27_1, L28_1)
L26_1 = RegisterServerEvent
L27_1 = "housing:setInside"
L26_1(L27_1)
L26_1 = AddEventHandler
L27_1 = "housing:setInside"
function L28_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = source
  L3_2 = UpdateInside
  L4_2 = L2_2
  L5_2 = A0_2
  L6_2 = A1_2
  L3_2(L4_2, L5_2, L6_2)
end
L26_1(L27_1, L28_1)
L26_1 = RegisterServerCallback
L27_1 = "qb-houses:getConsoleData"
function L28_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.fetchAll
  L4_2 = "SELECT console FROM player_houses WHERE house = ?"
  L5_2 = {}
  L6_2 = A2_2
  L5_2[1] = L6_2
  L3_2 = L3_2(L4_2, L5_2)
  L3_2 = L3_2[1]
  if not L3_2 then
    L4_2 = A1_2
    L5_2 = {}
    return L4_2(L5_2)
  end
  L4_2 = A1_2
  L5_2 = json
  L5_2 = L5_2.decode
  L6_2 = L3_2.console
  L5_2 = L5_2(L6_2)
  if not L5_2 then
    L5_2 = {}
  end
  L4_2(L5_2)
end
L26_1(L27_1, L28_1)
L26_1 = RegisterServerCallback
L27_1 = "phone_new:server:GetPlayerHouses"
function L28_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = A0_2
  L3_2 = {}
  L4_2 = {}
  L5_2 = GetIdentifier
  L6_2 = L2_2
  L5_2 = L5_2(L6_2)
  L6_2 = MySQL
  L6_2 = L6_2.Async
  L6_2 = L6_2.fetchAll
  L7_2 = "SELECT * FROM `player_houses` WHERE `citizenid` = '"
  L8_2 = L5_2
  L9_2 = "'"
  L7_2 = L7_2 .. L8_2 .. L9_2
  L8_2 = {}
  function L9_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3
    L1_3 = A0_3[1]
    if nil ~= L1_3 then
      L1_3 = pairs
      L2_3 = A0_3
      L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3)
      for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
        L7_3 = json
        L7_3 = L7_3.decode
        L8_3 = L6_3.keyholders
        L7_3 = L7_3(L8_3)
        L6_3.keyholders = L7_3
        L7_3 = L6_3.keyholders
        if nil ~= L7_3 then
          L7_3 = next
          L8_3 = L6_3.keyholders
          L7_3 = L7_3(L8_3)
          if L7_3 then
            L7_3 = pairs
            L8_3 = L6_3.keyholders
            L7_3, L8_3, L9_3, L10_3 = L7_3(L8_3)
            for L11_3, L12_3 in L7_3, L8_3, L9_3, L10_3 do
              L13_3 = GetPlayerSQLDataFromIdentifier
              L14_3 = L12_3
              L13_3 = L13_3(L14_3)
              if L13_3 then
                L14_3 = L4_2
                L14_3[L11_3] = L13_3
              end
            end
        end
        else
          L7_3 = L4_2
          L8_3 = L5_2
          L7_3[1] = L8_3
        end
        L7_3 = table
        L7_3 = L7_3.insert
        L8_3 = L3_2
        L9_3 = {}
        L10_3 = L6_3.house
        L9_3.name = L10_3
        L10_3 = L4_2
        L9_3.keyholders = L10_3
        L10_3 = L6_3.citizenid
        L9_3.owner = L10_3
        L10_3 = Config
        L10_3 = L10_3.Houses
        L11_3 = L6_3.house
        L10_3 = L10_3[L11_3]
        L10_3 = L10_3.price
        L9_3.price = L10_3
        L10_3 = Config
        L10_3 = L10_3.Houses
        L11_3 = L6_3.house
        L10_3 = L10_3[L11_3]
        L10_3 = L10_3.address
        L9_3.label = L10_3
        L10_3 = Config
        L10_3 = L10_3.Houses
        L11_3 = L6_3.house
        L10_3 = L10_3[L11_3]
        L10_3 = L10_3.tier
        L9_3.tier = L10_3
        L10_3 = Config
        L10_3 = L10_3.Houses
        L11_3 = L6_3.house
        L10_3 = L10_3[L11_3]
        L10_3 = L10_3.garage
        L9_3.garage = L10_3
        L7_3(L8_3, L9_3)
      end
      L1_3 = A1_2
      L2_3 = L3_2
      L1_3(L2_3)
    end
  end
  L6_2(L7_2, L8_2, L9_2)
end
L26_1(L27_1, L28_1)
function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = {}
  L2_2 = A0_2.gmatch
  L3_2 = A0_2
  L4_2 = "%S+"
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2, L4_2)
  for L6_2 in L2_2, L3_2, L4_2, L5_2 do
    L7_2 = #L1_2
    L7_2 = L7_2 + 1
    L1_2[L7_2] = L6_2
  end
  return L1_2
end
SplitStringToArray = L26_1
function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = {}
  L1_2["\""] = "\\\""
  L1_2["'"] = "\\'"
  L3_2 = A0_2
  L2_2 = A0_2.gsub
  L4_2 = "['\"]"
  L5_2 = L1_2
  return L2_2(L3_2, L4_2, L5_2)
end
escape_sqli = L26_1
L26_1 = Config
L26_1 = L26_1.EnableRaid
if L26_1 then
  L26_1 = RegisterUsableItem
  L27_1 = Config
  L27_1 = L27_1.StomRamItem
  function L28_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2
    L2_2 = GetJobName
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L3_2 = table
    L3_2 = L3_2.contains
    L4_2 = Config
    L4_2 = L4_2.PoliceJobs
    L5_2 = L2_2
    L3_2 = L3_2(L4_2, L5_2)
    if L3_2 then
      L3_2 = TriggerClientEvent
      L4_2 = "qb-houses:client:HomeInvasion"
      L5_2 = A0_2
      L3_2(L4_2, L5_2)
    else
      L3_2 = Notification
      L4_2 = A0_2
      L5_2 = i18n
      L5_2 = L5_2.t
      L6_2 = "stormram"
      L5_2 = L5_2(L6_2)
      L6_2 = "error"
      L3_2(L4_2, L5_2, L6_2)
    end
  end
  L26_1(L27_1, L28_1)
end
function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = GetPlayers
  L1_2 = L1_2()
  L2_2 = 0
  L3_2 = ipairs
  L4_2 = L1_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = GetJobName
    L10_2 = L8_2
    L9_2 = L9_2(L10_2)
    L10_2 = table
    L10_2 = L10_2.contains
    L11_2 = A0_2
    L12_2 = L9_2
    L10_2 = L10_2(L11_2, L12_2)
    if L10_2 then
      L2_2 = L2_2 + 1
    end
  end
  return L2_2
end
L27_1 = RegisterServerCallback
L28_1 = "housing:checkTotalJobCount"
function L29_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = A1_2
  L3_2 = L26_1
  L4_2 = Config
  L4_2 = L4_2.PoliceJobs
  L3_2, L4_2 = L3_2(L4_2)
  L2_2(L3_2, L4_2)
end
L27_1(L28_1, L29_1)
L27_1 = RegisterNetEvent
L28_1 = "housing:removeItem"
function L29_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = source
  L3_2 = RemoveItem
  L4_2 = L2_2
  L5_2 = A0_2
  L6_2 = A1_2
  L3_2(L4_2, L5_2, L6_2)
end
L27_1(L28_1, L29_1)
L27_1 = Config
L27_1 = L27_1.EnableRobbery
if L27_1 then
  L27_1 = RegisterUsableItem
  L28_1 = Config
  L28_1 = L28_1.RobberyItem
  function L29_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2
    L2_2 = L26_1
    L3_2 = Config
    L3_2 = L3_2.PoliceJobs
    L2_2 = L2_2(L3_2)
    L3_2 = Config
    L3_2 = L3_2.RequiredCop
    if L2_2 < L3_2 then
      L3_2 = Notification
      L4_2 = A0_2
      L5_2 = i18n
      L5_2 = L5_2.t
      L6_2 = "not_enough_police"
      L5_2 = L5_2(L6_2)
      L6_2 = "error"
      L3_2(L4_2, L5_2, L6_2)
    end
    L3_2 = TriggerClientEvent
    L4_2 = "qb-houses:client:lockpick"
    L5_2 = A0_2
    L3_2(L4_2, L5_2)
  end
  L27_1(L28_1, L29_1)
end
L27_1 = RegisterServerEvent
L28_1 = "qb-houses:server:SetHouseRammed"
L27_1(L28_1)
L27_1 = AddEventHandler
L28_1 = "qb-houses:server:SetHouseRammed"
function L29_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A1_2]
  L2_2.IsRammed = A0_2
  L2_2 = TriggerClientEvent
  L3_2 = "qb-houses:client:SetHouseRammed"
  L4_2 = -1
  L5_2 = A0_2
  L6_2 = A1_2
  L2_2(L3_2, L4_2, L5_2, L6_2)
end
L27_1(L28_1, L29_1)
L27_1 = RegisterNetEvent
L28_1 = "qb-houses:server:RegisterStash"
L27_1(L28_1)
L27_1 = AddEventHandler
L28_1 = "qb-houses:server:RegisterStash"
function L29_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = exports
  L3_2 = L3_2.ox_inventory
  L4_2 = L3_2
  L3_2 = L3_2.RegisterStash
  L5_2 = A0_2
  L6_2 = "stash"
  L7_2 = A0_2
  L6_2 = L6_2 .. L7_2
  L7_2 = A1_2
  L8_2 = A2_2
  L9_2 = false
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
end
L27_1(L28_1, L29_1)
L27_1 = RegisterServerCallback
L28_1 = "qb-houses:server:getPlayerDressing"
function L29_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = GetPlayerFromId
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L3_2 = TriggerEvent
    L4_2 = "esx_datastore:getDataStore"
    L5_2 = "property"
    L6_2 = L2_2.identifier
    function L7_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
      L1_3 = A0_3.count
      L2_3 = "dressing"
      L1_3 = L1_3(L2_3)
      L2_3 = {}
      L3_3 = 1
      L4_3 = L1_3
      L5_3 = 1
      for L6_3 = L3_3, L4_3, L5_3 do
        L7_3 = A0_3.get
        L8_3 = "dressing"
        L9_3 = L6_3
        L7_3 = L7_3(L8_3, L9_3)
        L8_3 = table
        L8_3 = L8_3.insert
        L9_3 = L2_3
        L10_3 = L7_3.label
        L8_3(L9_3, L10_3)
      end
      L3_3 = A1_2
      L4_3 = L2_3
      L3_3(L4_3)
    end
    L3_2(L4_2, L5_2, L6_2, L7_2)
  end
end
L27_1(L28_1, L29_1)
L27_1 = RegisterServerCallback
L28_1 = "qb-houses:server:getPlayerOutfit"
function L29_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L3_2 = GetPlayerFromId
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L4_2 = TriggerEvent
    L5_2 = "esx_datastore:getDataStore"
    L6_2 = "property"
    L7_2 = L3_2.identifier
    function L8_2(A0_3)
      local L1_3, L2_3, L3_3
      L1_3 = A0_3.get
      L2_3 = "dressing"
      L3_3 = A2_2
      L1_3 = L1_3(L2_3, L3_3)
      L2_3 = A1_2
      L3_3 = L1_3.skin
      L2_3(L3_3)
    end
    L4_2(L5_2, L6_2, L7_2, L8_2)
  end
end
L27_1(L28_1, L29_1)
L27_1 = RegisterServerEvent
L28_1 = "qb-houses:server:removeOutfit"
L27_1(L28_1)
L27_1 = AddEventHandler
L28_1 = "qb-houses:server:removeOutfit"
function L29_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = GetPlayerFromId
  L2_2 = source
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L2_2 = TriggerEvent
    L3_2 = "esx_datastore:getDataStore"
    L4_2 = "property"
    L5_2 = L1_2.identifier
    function L6_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3
      L1_3 = A0_3.get
      L2_3 = "dressing"
      L1_3 = L1_3(L2_3)
      if nil == L1_3 then
        L2_3 = {}
        L1_3 = L2_3
      end
      L2_3 = A0_2
      A0_2 = L2_3
      L2_3 = table
      L2_3 = L2_3.remove
      L3_3 = L1_3
      L4_3 = A0_2
      L2_3(L3_3, L4_3)
      L2_3 = A0_3.set
      L3_3 = "dressing"
      L4_3 = L1_3
      L2_3(L3_3, L4_3)
    end
    L2_2(L3_2, L4_2, L5_2, L6_2)
  end
end
L27_1(L28_1, L29_1)
L27_1 = RegisterServerEvent
L28_1 = "qb-houses:server:withdrawItem"
L27_1(L28_1)
L27_1 = AddEventHandler
L28_1 = "qb-houses:server:withdrawItem"
function L29_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L4_2 = source
  L5_2 = GetPlayerFromId
  L6_2 = L4_2
  L5_2 = L5_2(L6_2)
  L6_2 = L5_2.identifier
  if "item" == A0_2 then
    L7_2 = TriggerEvent
    L8_2 = "esx_addoninventory:getInventory"
    L9_2 = "property"
    L10_2 = L6_2
    function L11_2(A0_3)
      local L1_3, L2_3, L3_3
      L1_3 = L5_2.canCarryItem
      L2_3 = A1_2
      L3_3 = A2_2
      L1_3 = L1_3(L2_3, L3_3)
      if L1_3 then
        L1_3 = A0_3.getItem
        L2_3 = A1_2
        L1_3 = L1_3(L2_3)
        L1_3 = L1_3.count
        L2_3 = A2_2
        if L1_3 >= L2_3 then
          L1_3 = L5_2.addInventoryItem
          L2_3 = A1_2
          L3_3 = A2_2
          L1_3(L2_3, L3_3)
          L1_3 = A0_3.removeItem
          L2_3 = A1_2
          L3_3 = A2_2
          L1_3(L2_3, L3_3)
        end
      end
    end
    L7_2(L8_2, L9_2, L10_2, L11_2)
  elseif "weapon" == A0_2 then
    L7_2 = TriggerEvent
    L8_2 = "esx_datastore:getDataStore"
    L9_2 = "property"
    L10_2 = L6_2
    function L11_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3
      L1_3 = A0_3.get
      L2_3 = "weapons"
      L1_3 = L1_3(L2_3)
      if not L1_3 then
        L1_3 = {}
      end
      L2_3 = 1
      L3_3 = #L1_3
      L4_3 = 1
      for L5_3 = L2_3, L3_3, L4_3 do
        L6_3 = L1_3[L5_3]
        L6_3 = L6_3.name
        L7_3 = A1_2
        if L6_3 == L7_3 then
          L6_3 = table
          L6_3 = L6_3.remove
          L7_3 = L1_3
          L8_3 = L5_3
          L6_3(L7_3, L8_3)
          L6_3 = A0_3.set
          L7_3 = "weapons"
          L8_3 = L1_3
          L6_3(L7_3, L8_3)
          L6_3 = L5_2.addWeapon
          L7_3 = A1_2
          L8_3 = A2_2
          L6_3(L7_3, L8_3)
          break
        end
      end
    end
    L7_2(L8_2, L9_2, L10_2, L11_2)
  end
end
L27_1(L28_1, L29_1)
L27_1 = RegisterServerEvent
L28_1 = "qb-houses:server:storeItem"
L27_1(L28_1)
L27_1 = AddEventHandler
L28_1 = "qb-houses:server:storeItem"
function L29_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L4_2 = source
  L5_2 = GetPlayerFromId
  L6_2 = L4_2
  L5_2 = L5_2(L6_2)
  L6_2 = L5_2.identifier
  if "item" == A0_2 then
    L7_2 = L5_2.getInventoryItem
    L8_2 = A1_2
    L7_2 = L7_2(L8_2)
    L7_2 = L7_2.count
    if A2_2 <= L7_2 then
      L7_2 = TriggerEvent
      L8_2 = "esx_addoninventory:getInventory"
      L9_2 = "property"
      L10_2 = L6_2
      function L11_2(A0_3)
        local L1_3, L2_3, L3_3
        L1_3 = L5_2.removeInventoryItem
        L2_3 = A1_2
        L3_3 = A2_2
        L1_3(L2_3, L3_3)
        L1_3 = A0_3.addItem
        L2_3 = A1_2
        L3_3 = A2_2
        L1_3(L2_3, L3_3)
      end
      L7_2(L8_2, L9_2, L10_2, L11_2)
    end
  elseif "weapon" == A0_2 then
    L7_2 = L5_2.getLoadout
    L7_2 = L7_2()
    L8_2 = false
    L9_2 = pairs
    L10_2 = L7_2
    L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
    for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
      L15_2 = L14_2.name
      if L15_2 == A1_2 then
        L8_2 = true
        break
      end
    end
    if L8_2 then
      L9_2 = TriggerEvent
      L10_2 = "esx_datastore:getDataStore"
      L11_2 = "property"
      L12_2 = L6_2
      function L13_2(A0_3)
        local L1_3, L2_3, L3_3, L4_3, L5_3
        L1_3 = A0_3.get
        L2_3 = "weapons"
        L1_3 = L1_3(L2_3)
        if not L1_3 then
          L1_3 = {}
        end
        L2_3 = table
        L2_3 = L2_3.insert
        L3_3 = L1_3
        L4_3 = {}
        L5_3 = A1_2
        L4_3.name = L5_3
        L5_3 = A2_2
        L4_3.ammo = L5_3
        L2_3(L3_3, L4_3)
        L2_3 = A0_3.set
        L3_3 = "weapons"
        L4_3 = L1_3
        L2_3(L3_3, L4_3)
        L2_3 = L5_2.removeWeapon
        L3_3 = A1_2
        L2_3(L3_3)
      end
      L9_2(L10_2, L11_2, L12_2, L13_2)
    end
  end
end
L27_1(L28_1, L29_1)
L27_1 = RegisterServerCallback
L28_1 = "qb-houses:server:getInventory"
function L29_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = GetPlayerFromId
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L3_2 = A1_2
    L4_2 = {}
    L5_2 = L2_2.inventory
    L4_2.items = L5_2
    L5_2 = L2_2.getLoadout
    L5_2 = L5_2()
    L4_2.weapons = L5_2
    L3_2(L4_2)
  end
end
L27_1(L28_1, L29_1)
L27_1 = RegisterServerCallback
L28_1 = "qb-houses:server:getBlackMoney"
function L29_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = GetPlayerFromId
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L3_2 = TriggerEvent
    L4_2 = "esx_addonaccount:getAccount"
    L5_2 = "property"
    L6_2 = L2_2.identifier
    function L7_2(A0_3)
      local L1_3, L2_3, L3_3
      L1_3 = A0_3.money
      L2_3 = A1_2
      L3_3 = L1_3
      L2_3(L3_3)
    end
    L3_2(L4_2, L5_2, L6_2, L7_2)
  end
end
L27_1(L28_1, L29_1)
L27_1 = RegisterServerCallback
L28_1 = "qb-houses:server:depositBlackMoney"
function L29_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L3_2 = GetPlayerFromId
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = A2_2
  if L3_2 then
    L5_2 = L3_2.getAccount
    L6_2 = "black_money"
    L5_2 = L5_2(L6_2)
    L5_2 = L5_2.money
    if L4_2 and L4_2 > 0 and L4_2 <= L5_2 then
      L6_2 = L3_2.removeAccountMoney
      L7_2 = "black_money"
      L8_2 = L4_2
      L6_2(L7_2, L8_2)
      L6_2 = TriggerEvent
      L7_2 = "esx_addonaccount:getAccount"
      L8_2 = "property"
      L9_2 = L3_2.identifier
      function L10_2(A0_3)
        local L1_3, L2_3
        L1_3 = A0_3.addMoney
        L2_3 = L4_2
        L1_3(L2_3)
        L1_3 = A1_2
        L2_3 = true
        L1_3(L2_3)
      end
      L6_2(L7_2, L8_2, L9_2, L10_2)
    else
      L6_2 = A1_2
      L7_2 = false
      L6_2(L7_2)
    end
  end
end
L27_1(L28_1, L29_1)
L27_1 = RegisterServerCallback
L28_1 = "qb-houses:server:withdrawBlackMoney"
function L29_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = GetPlayerFromId
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = A2_2
  if L3_2 and L4_2 and L4_2 > 0 then
    L5_2 = TriggerEvent
    L6_2 = "esx_addonaccount:getAccount"
    L7_2 = "property"
    L8_2 = L3_2.identifier
    function L9_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3
      L1_3 = A0_3.money
      L2_3 = L4_2
      if L1_3 >= L2_3 then
        L2_3 = A0_3.removeMoney
        L3_3 = L4_2
        L2_3(L3_3)
        L2_3 = L3_2.addAccountMoney
        L3_3 = "black_money"
        L4_3 = L4_2
        L2_3(L3_3, L4_3)
        L2_3 = A1_2
        L3_3 = true
        L2_3(L3_3)
      else
        L2_3 = A1_2
        L3_3 = false
        L2_3(L3_3)
      end
    end
    L5_2(L6_2, L7_2, L8_2, L9_2)
  end
end
L27_1(L28_1, L29_1)
L27_1 = RegisterServerCallback
L28_1 = "qb-houses:server:getHouseInventory"
function L29_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L3_2 = GetPlayerFromId
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L4_2 = {}
    L5_2 = {}
    L6_2 = TriggerEvent
    L7_2 = "esx_addoninventory:getInventory"
    L8_2 = "property"
    L9_2 = L3_2.identifier
    function L10_2(A0_3)
      local L1_3
      L1_3 = A0_3.items
      L4_2 = L1_3
    end
    L6_2(L7_2, L8_2, L9_2, L10_2)
    L6_2 = TriggerEvent
    L7_2 = "esx_datastore:getDataStore"
    L8_2 = "property"
    L9_2 = L3_2.identifier
    function L10_2(A0_3)
      local L1_3, L2_3
      L1_3 = A0_3.get
      L2_3 = "weapons"
      L1_3 = L1_3(L2_3)
      if not L1_3 then
        L1_3 = {}
      end
      L5_2 = L1_3
    end
    L6_2(L7_2, L8_2, L9_2, L10_2)
    L6_2 = A1_2
    L7_2 = {}
    L7_2.items = L4_2
    L7_2.weapons = L5_2
    L6_2(L7_2)
  end
end
L27_1(L28_1, L29_1)
L27_1 = RegisterNetEvent
L28_1 = "housing:openStash"
function L29_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = source
  L3_2 = exports
  L3_2 = L3_2["qb-inventory"]
  L4_2 = L3_2
  L3_2 = L3_2.OpenInventory
  L5_2 = L2_2
  L6_2 = A0_2
  L7_2 = A1_2
  L3_2(L4_2, L5_2, L6_2, L7_2)
end
L27_1(L28_1, L29_1)
L27_1 = RegisterNetEvent
L28_1 = "housing:updateExitCoords"
function L29_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = source
  L3_2 = Debug
  L4_2 = "housing:updateExitCoords"
  L5_2 = "Updating exit coords"
  L6_2 = A0_2
  L7_2 = A1_2
  L3_2(L4_2, L5_2, L6_2, L7_2)
  L3_2 = Config
  L3_2 = L3_2.Houses
  L3_2 = L3_2[A0_2]
  L3_2 = L3_2.coords
  L3_2.exit = A1_2
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.execute
  L4_2 = "UPDATE houselocations SET coords = ? WHERE name = ?"
  L5_2 = {}
  L6_2 = json
  L6_2 = L6_2.encode
  L7_2 = Config
  L7_2 = L7_2.Houses
  L7_2 = L7_2[A0_2]
  L7_2 = L7_2.coords
  L6_2 = L6_2(L7_2)
  L7_2 = A0_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2(L4_2, L5_2)
  L3_2 = TriggerClientEvent
  L4_2 = "housing:updateHouseData"
  L5_2 = -1
  L6_2 = A0_2
  L7_2 = "coords"
  L8_2 = Config
  L8_2 = L8_2.Houses
  L8_2 = L8_2[A0_2]
  L8_2 = L8_2.coords
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
end
L27_1(L28_1, L29_1)
function L27_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = {}
  L2_2.name = "HOUSE LOG"
  L2_2.icon_url = "https://img.gta5-mods.com/q75/images/motel-arrangement/3a516a-1.png"
  A1_2.author = L2_2
  L2_2 = {}
  L2_2.text = "HOUSING"
  A1_2.footer = L2_2
  L2_2 = os
  L2_2 = L2_2.date
  L3_2 = "%Y-%m-%dT%H:%M:%S"
  L2_2 = L2_2(L3_2)
  A1_2.timestamp = L2_2
  L2_2 = {}
  L3_2 = table
  L3_2 = L3_2.insert
  L4_2 = L2_2
  L5_2 = A1_2
  L3_2(L4_2, L5_2)
  L3_2 = PerformHttpRequest
  L4_2 = A0_2
  function L5_2(A0_3, A1_3, A2_3)
  end
  L6_2 = "POST"
  L7_2 = json
  L7_2 = L7_2.encode
  L8_2 = {}
  L8_2.username = "QS"
  L8_2.embeds = L2_2
  L8_2.avatar_url = "https://img.gta5-mods.com/q75/images/motel-arrangement/3a516a-1.png"
  L7_2 = L7_2(L8_2)
  L8_2 = {}
  L8_2["Content-Type"] = "application/json"
  L9_2 = {}
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
end
SendLog = L27_1
function L27_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = MySQL
  L1_2 = L1_2.Sync
  L1_2 = L1_2.fetchAll
  L2_2 = "SELECT vaultCodes FROM player_houses WHERE house = ?"
  L3_2 = {}
  L4_2 = A0_2
  L3_2[1] = L4_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = L1_2[1]
  if L2_2 then
    L2_2 = json
    L2_2 = L2_2.decode
    L3_2 = L1_2[1]
    L3_2 = L3_2.vaultCodes
    L2_2 = L2_2(L3_2)
    if not L2_2 then
      L2_2 = {}
    end
    return L2_2
  end
  L2_2 = {}
  return L2_2
end
HousingGetVaultCodes = L27_1
L27_1 = RegisterServerCallback
L28_1 = "housing:getVaultCodes"
function L29_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = A0_2
  L4_2 = A1_2
  L5_2 = HousingGetVaultCodes
  L6_2 = A2_2
  L5_2, L6_2 = L5_2(L6_2)
  L4_2(L5_2, L6_2)
end
L27_1(L28_1, L29_1)
L27_1 = RegisterNetEvent
L28_1 = "housing:setVaultCode"
function L29_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = source
  L2_2 = HousingGetVaultCodes
  L3_2 = A0_2.house
  L2_2 = L2_2(L3_2)
  L3_2 = #L2_2
  L4_2 = Config
  L4_2 = L4_2.MaxVaultCodes
  if L3_2 >= L4_2 then
    L3_2 = Notification
    L4_2 = L1_2
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "vault_code.codes_full"
    L5_2 = L5_2(L6_2)
    L6_2 = "error"
    L3_2(L4_2, L5_2, L6_2)
    return
  end
  L3_2 = table
  L3_2 = L3_2.insert
  L4_2 = L2_2
  L5_2 = {}
  L6_2 = A0_2.code
  L5_2.code = L6_2
  L6_2 = A0_2.id
  L5_2.id = L6_2
  L3_2(L4_2, L5_2)
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.execute
  L4_2 = "UPDATE player_houses SET vaultCodes = ? WHERE house = ?"
  L5_2 = {}
  L6_2 = json
  L6_2 = L6_2.encode
  L7_2 = L2_2
  L6_2 = L6_2(L7_2)
  L7_2 = A0_2.house
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2(L4_2, L5_2)
  L3_2 = Notification
  L4_2 = L1_2
  L5_2 = i18n
  L5_2 = L5_2.t
  L6_2 = "vault_code.added"
  L5_2 = L5_2(L6_2)
  L6_2 = "success"
  L3_2(L4_2, L5_2, L6_2)
end
L27_1(L28_1, L29_1)
L27_1 = RegisterNetEvent
L28_1 = "housing:removeVaultCode"
function L29_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = source
  L2_2 = HousingGetVaultCodes
  L3_2 = A0_2.house
  L2_2 = L2_2(L3_2)
  L3_2 = 1
  L4_2 = #L2_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = tostring
    L8_2 = L2_2[L6_2]
    L8_2 = L8_2.id
    L7_2 = L7_2(L8_2)
    L8_2 = tostring
    L9_2 = A0_2.id
    L8_2 = L8_2(L9_2)
    if L7_2 == L8_2 then
      L7_2 = table
      L7_2 = L7_2.remove
      L8_2 = L2_2
      L9_2 = L6_2
      L7_2(L8_2, L9_2)
      L7_2 = MySQL
      L7_2 = L7_2.Sync
      L7_2 = L7_2.execute
      L8_2 = "UPDATE player_houses SET vaultCodes = ? WHERE house = ?"
      L9_2 = {}
      L10_2 = json
      L10_2 = L10_2.encode
      L11_2 = L2_2
      L10_2 = L10_2(L11_2)
      L11_2 = A0_2.house
      L9_2[1] = L10_2
      L9_2[2] = L11_2
      L7_2(L8_2, L9_2)
      L7_2 = Notification
      L8_2 = L1_2
      L9_2 = i18n
      L9_2 = L9_2.t
      L10_2 = "vault_code.removed"
      L9_2 = L9_2(L10_2)
      L10_2 = "success"
      L7_2(L8_2, L9_2, L10_2)
      return
    end
  end
  L3_2 = Notification
  L4_2 = L1_2
  L5_2 = i18n
  L5_2 = L5_2.t
  L6_2 = "vault_code.not_found"
  L5_2 = L5_2(L6_2)
  L6_2 = "error"
  L3_2(L4_2, L5_2, L6_2)
end
L27_1(L28_1, L29_1)
L27_1 = Config
L27_1 = L27_1.Construction
if L27_1 then
  L27_1 = CreateThread
  function L28_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
    while true do
      L0_2 = pairs
      L1_2 = L1_1
      L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
      for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
        L6_2 = L5_2.construction
        if not L6_2 then
        else
          L6_2 = os
          L6_2 = L6_2.difftime
          L7_2 = os
          L7_2 = L7_2.time
          L7_2 = L7_2()
          L8_2 = L5_2.created
          L6_2 = L6_2(L7_2, L8_2)
          L7_2 = L5_2.construction
          L7_2 = L7_2.duration
          if L6_2 >= L7_2 then
            L5_2.construction = nil
            L7_2 = MySQL
            L7_2 = L7_2.Sync
            L7_2 = L7_2.execute
            L8_2 = "UPDATE house_objects SET construction = NULL WHERE id = ?"
            L9_2 = {}
            L10_2 = L5_2.id
            L9_2[1] = L10_2
            L7_2(L8_2, L9_2)
            L7_2 = TriggerClientEvent
            L8_2 = "housing:updateHouseObject"
            L9_2 = -1
            L10_2 = L5_2.id
            L11_2 = L5_2
            L7_2(L8_2, L9_2, L10_2, L11_2)
            L7_2 = Debug
            L8_2 = "housing:construction"
            L9_2 = "Construction finished"
            L10_2 = L5_2.id
            L7_2(L8_2, L9_2, L10_2)
          end
        end
      end
      L0_2 = Wait
      L1_2 = 2000
      L0_2(L1_2)
    end
  end
  L27_1(L28_1)
end
L27_1 = RegisterNetEvent
L28_1 = "housing:showConstructionRemaining"
function L29_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = source
  L2_2 = table
  L2_2 = L2_2.find
  L3_2 = L1_1
  function L4_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.house
    L2_3 = A0_2
    L1_3 = L1_3 == L2_3
    return L1_3
  end
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L3_2 = Notification
    L4_2 = L1_2
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "construction.not_found"
    L5_2 = L5_2(L6_2)
    L6_2 = "error"
    L3_2(L4_2, L5_2, L6_2)
    return
  end
  L3_2 = L2_2.construction
  if not L3_2 then
    L3_2 = Notification
    L4_2 = L1_2
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "construction.finished"
    L5_2 = L5_2(L6_2)
    L6_2 = "info"
    L3_2(L4_2, L5_2, L6_2)
    return
  end
  L3_2 = os
  L3_2 = L3_2.difftime
  L4_2 = os
  L4_2 = L4_2.time
  L4_2 = L4_2()
  L5_2 = L2_2.created
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = L2_2.construction
  L4_2 = L4_2.duration
  L4_2 = L4_2 - L3_2
  L5_2 = Notification
  L6_2 = L1_2
  L7_2 = i18n
  L7_2 = L7_2.t
  L8_2 = "construction.remaining"
  L9_2 = {}
  L9_2.remaining = L4_2
  L7_2 = L7_2(L8_2, L9_2)
  L8_2 = "info"
  L5_2(L6_2, L7_2, L8_2)
end
L27_1(L28_1, L29_1)
L27_1 = AddEventHandler
L28_1 = "housing:handleBuyHouse"
function L29_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L4_2 = Debug
  L5_2 = "housing:handleBuyHouse"
  L6_2 = "Buying house"
  L7_2 = "Source"
  L8_2 = A0_2
  L9_2 = A1_2
  L10_2 = A2_2
  L11_2 = A3_2
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
end
L27_1(L28_1, L29_1)
function L27_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = GetJobName
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = GetJobGrade
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = PlayerIsAdmin
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L4_2 = Config
    L4_2 = L4_2.AllowAdminsToCreateHouses
    if L4_2 then
      L4_2 = true
      return L4_2
    end
  end
  L4_2 = pairs
  L5_2 = Config
  L5_2 = L5_2.CreatorJobs
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = L9_2.job
    if L10_2 == L1_2 then
      L10_2 = L9_2.grade
      if L10_2 then
        L10_2 = table
        L10_2 = L10_2.contains
        L11_2 = L9_2.grade
        L12_2 = L2_2
        L10_2 = L10_2(L11_2, L12_2)
        if not L10_2 then
          goto lbl_38
        end
      end
      L10_2 = true
      return L10_2
    end
    ::lbl_38::
  end
  L4_2 = false
  return L4_2
end
HasPermission = L27_1
L27_1 = lib
L27_1 = L27_1.callback
L27_1 = L27_1.register
L28_1 = "housing:hasPermission"
function L29_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = PlayerIsAdmin
  L3_2 = A0_2
  L4_2 = A1_2
  return L2_2(L3_2, L4_2)
end
L27_1(L28_1, L29_1)
L27_1 = Citizen
L27_1 = L27_1.CreateThread
function L28_1()
  local L0_2, L1_2, L2_2
  L0_2 = GetCurrentResourceName
  L0_2 = L0_2()
  if "qs-housing" == L0_2 then
    verify = true
  end
  L1_2 = verify
  if true ~= L1_2 then
    repeat
      L1_2 = Citizen
      L1_2 = L1_2.Wait
      L2_2 = 3000
      L1_2(L2_2)
      L1_2 = print
      L2_2 = "^1[ERROR]^0: You have renamed the script! ^4qs-housing^0 must not be renamed."
      L1_2(L2_2)
      L1_2 = print
      L2_2 = "^3[WARNING]^0: If you rename the script, your console will freeze and you won\226\128\153t be able to access the game."
      L1_2(L2_2)
      L1_2 = Citizen
      L1_2 = L1_2.Wait
      L2_2 = 5000
      L1_2(L2_2)
      while true do
      end
      L1_2 = verify
    until true == L1_2
  end
end
L27_1(L28_1)
function L27_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = pairs
  L2_2 = A0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = GetCharacterName
    L8_2 = L6_2.id
    L7_2, L8_2 = L7_2(L8_2)
    if not L7_2 or not L8_2 then
      L9_2 = ""
      L8_2 = ""
      L7_2 = L9_2
    end
    L9_2 = A0_2[L5_2]
    L10_2 = L7_2
    L11_2 = " "
    L12_2 = L8_2
    L10_2 = L10_2 .. L11_2 .. L12_2
    L9_2.name = L10_2
  end
  return A0_2
end
InitPlayersName = L27_1
L27_1 = lib
L27_1 = L27_1.callback
L27_1 = L27_1.register
L28_1 = "housing:getNearbyPlayers"
function L29_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L1_2 = GetPlayerPed
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = GetEntityCoords
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = {}
  L4_2 = pairs
  L5_2 = GetPlayers
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L5_2()
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = GetPlayerPed
    L11_2 = L9_2
    L10_2 = L10_2(L11_2)
    L11_2 = GetEntityCoords
    L12_2 = L10_2
    L11_2 = L11_2(L12_2)
    L12_2 = L2_2 - L11_2
    L12_2 = #L12_2
    L13_2 = tonumber
    L14_2 = L9_2
    L13_2 = L13_2(L14_2)
    L9_2 = L13_2
    if L12_2 < 10.0 and L9_2 ~= A0_2 then
      L13_2 = table
      L13_2 = L13_2.insert
      L14_2 = L3_2
      L15_2 = {}
      L15_2.id = L9_2
      L15_2.distance = L12_2
      L13_2(L14_2, L15_2)
    end
  end
  L4_2 = table
  L4_2 = L4_2.sort
  L5_2 = L3_2
  function L6_2(A0_3, A1_3)
    local L2_3, L3_3
    L2_3 = A0_3.distance
    L3_3 = A1_3.distance
    L2_3 = L2_3 < L3_3
    return L2_3
  end
  L4_2(L5_2, L6_2)
  L4_2 = InitPlayersName
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L3_2 = L4_2
  return L3_2
end
L27_1(L28_1, L29_1)
function L27_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = GetIdentifier
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = {}
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.fetchAll
  L4_2 = "SELECT * FROM player_houses WHERE citizenid = ?"
  L5_2 = {}
  L6_2 = L1_2
  L5_2[1] = L6_2
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L4_2 = L3_2[1]
    if L4_2 then
      L4_2 = pairs
      L5_2 = L3_2
      L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
      for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
        L10_2 = #L2_2
        L10_2 = L10_2 + 1
        L11_2 = L9_2.house
        L2_2[L10_2] = L11_2
      end
    end
  end
  return L2_2
end
GetPlayerHouses = L27_1
L27_1 = exports
L28_1 = "GetPlayerHouses"
L29_1 = GetPlayerHouses
L27_1(L28_1, L29_1)
function L27_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  if not A0_2 then
    L1_2 = {}
    return L1_2
  end
  L1_2 = {}
  L2_2 = MySQL
  L2_2 = L2_2.Sync
  L2_2 = L2_2.fetchAll
  L3_2 = "SELECT house FROM player_houses WHERE citizenid = ?"
  L4_2 = {}
  L5_2 = A0_2
  L4_2[1] = L5_2
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L3_2 = L2_2[1]
    if L3_2 then
      goto lbl_23
    end
  end
  do return L1_2 end
  ::lbl_23::
  L3_2 = pairs
  L4_2 = L2_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = L8_2.house
    L10_2 = L9_2 or L10_2
    if L9_2 then
      L10_2 = Config
      L10_2 = L10_2.Houses
      L10_2 = L10_2[L9_2]
    end
    L11_2 = L10_2 or L11_2
    if L10_2 then
      L11_2 = L10_2.coords
      if L11_2 then
        L11_2 = L10_2.coords
        L11_2 = L11_2.enter
      end
    end
    if L11_2 then
      L12_2 = #L1_2
      L12_2 = L12_2 + 1
      L13_2 = {}
      L13_2.house = L9_2
      L14_2 = L10_2.address
      if not L14_2 then
        L14_2 = L9_2
      end
      L13_2.label = L14_2
      L14_2 = L10_2.address
      if not L14_2 then
        L14_2 = L9_2
      end
      L13_2.address = L14_2
      L14_2 = {}
      L15_2 = L11_2.x
      L14_2.x = L15_2
      L15_2 = L11_2.y
      L14_2.y = L15_2
      L15_2 = L11_2.z
      L14_2.z = L15_2
      L15_2 = L11_2.h
      if not L15_2 then
        L15_2 = L11_2.w
        if not L15_2 then
          L15_2 = 0.0
        end
      end
      L14_2.h = L15_2
      L13_2.coords = L14_2
      L14_2 = L10_2.image
      L13_2.image = L14_2
      L14_2 = L10_2.description
      L13_2.description = L14_2
      L1_2[L12_2] = L13_2
    end
  end
  return L1_2
end
GetPlayerPropertiesByIdentifier = L27_1
L27_1 = exports
L28_1 = "GetPlayerPropertiesByIdentifier"
L29_1 = GetPlayerPropertiesByIdentifier
L27_1(L28_1, L29_1)
function L27_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  if not A0_2 then
    L1_2 = false
    return L1_2
  end
  L1_2 = Config
  L1_2 = L1_2.Framework
  if "esx" == L1_2 then
    L1_2 = MySQL
    L1_2 = L1_2.Sync
    L1_2 = L1_2.execute
    L2_2 = "UPDATE users SET inside = NULL WHERE identifier = ?"
    L3_2 = {}
    L4_2 = A0_2
    L3_2[1] = L4_2
    L1_2(L2_2, L3_2)
    L1_2 = true
    return L1_2
  end
  L1_2 = MySQL
  L1_2 = L1_2.single
  L1_2 = L1_2.await
  L2_2 = "SELECT metadata FROM players WHERE citizenid = ? LIMIT 1"
  L3_2 = {}
  L4_2 = A0_2
  L3_2[1] = L4_2
  L1_2 = L1_2(L2_2, L3_2)
  if not L1_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = L1_2.metadata
  if L2_2 then
    L2_2 = json
    L2_2 = L2_2.decode
    L3_2 = L1_2.metadata
    L2_2 = L2_2(L3_2)
    if L2_2 then
      goto lbl_44
    end
  end
  L2_2 = {}
  ::lbl_44::
  L3_2 = type
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  if "table" ~= L3_2 then
    L3_2 = {}
    L2_2 = L3_2
  end
  L2_2.currentHouseId = nil
  L3_2 = MySQL
  L3_2 = L3_2.Sync
  L3_2 = L3_2.execute
  L4_2 = "UPDATE players SET metadata = ? WHERE citizenid = ?"
  L5_2 = {}
  L6_2 = json
  L6_2 = L6_2.encode
  L7_2 = L2_2
  L6_2 = L6_2(L7_2)
  L7_2 = A0_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2(L4_2, L5_2)
  L3_2 = true
  return L3_2
end
ClearPlayerInsideByIdentifier = L27_1
L27_1 = exports
L28_1 = "ClearPlayerInsideByIdentifier"
L29_1 = ClearPlayerInsideByIdentifier
L27_1(L28_1, L29_1)
function L27_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = PlayerIsAdmin
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = {}
    return L2_2
  end
  L2_2 = db
  L2_2 = L2_2.getApartmentUnits
  L3_2 = A1_2
  return L2_2(L3_2)
end
HousingGetApartmentUnits = L27_1
L27_1 = lib
L27_1 = L27_1.callback
L27_1 = L27_1.register
L28_1 = "housing:getApartmentUnits"
L29_1 = HousingGetApartmentUnits
L27_1(L28_1, L29_1)
function L27_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = PlayerIsAdmin
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = db
  L3_2 = L3_2.updateApartmentShell
  L4_2 = A1_2
  L5_2 = A2_2
  return L3_2(L4_2, L5_2)
end
HousingUpdateApartmentShell = L27_1
L27_1 = lib
L27_1 = L27_1.callback
L27_1 = L27_1.register
L28_1 = "housing:updateApartmentShell"
L29_1 = HousingUpdateApartmentShell
L27_1(L28_1, L29_1)
function L27_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = PlayerIsAdmin
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = db
  L3_2 = L3_2.updateApartmentIpl
  L4_2 = A1_2
  L5_2 = A2_2
  return L3_2(L4_2, L5_2)
end
HousingUpdateApartmentIpl = L27_1
L27_1 = lib
L27_1 = L27_1.callback
L27_1 = L27_1.register
L28_1 = "housing:updateApartmentIpl"
L29_1 = HousingUpdateApartmentIpl
L27_1(L28_1, L29_1)
L27_1 = exports
L28_1 = "GetPlayerInsideHouse"
function L29_1(A0_2)
  local L1_2, L2_2
  L1_2 = GetPlayerInsideHouse
  L2_2 = A0_2
  return L1_2(L2_2)
end
L27_1(L28_1, L29_1)






