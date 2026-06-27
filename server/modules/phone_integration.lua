





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1
L0_1 = {}
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = Config
  L0_2 = L0_2.PhoneHousing
  if not L0_2 then
    L0_2 = {}
  end
  L1_2 = {}
  L2_2 = L0_2.requireProximityForPurchase
  L2_2 = false ~= L2_2
  L1_2.requireProximityForPurchase = L2_2
  L2_2 = tonumber
  L3_2 = L0_2.purchaseMaxDistance
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = 48.0
  end
  L1_2.purchaseMaxDistance = L2_2
  L2_2 = math
  L2_2 = L2_2.max
  L3_2 = 0
  L4_2 = tonumber
  L5_2 = L0_2.actionCooldownSeconds
  L4_2 = L4_2(L5_2)
  if not L4_2 then
    L4_2 = 2
  end
  L2_2 = L2_2(L3_2, L4_2)
  L1_2.actionCooldownSeconds = L2_2
  return L1_2
end
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = L1_1
  L1_2 = L1_2()
  L2_2 = L1_2.actionCooldownSeconds
  if L2_2 <= 0 then
    L3_2 = true
    return L3_2
  end
  L3_2 = os
  L3_2 = L3_2.time
  L3_2 = L3_2()
  L4_2 = L0_1
  L4_2 = L4_2[A0_2]
  if L4_2 then
    L5_2 = L3_2 - L4_2
    if L2_2 > L5_2 then
      L5_2 = false
      return L5_2
    end
  end
  L5_2 = L0_1
  L5_2[A0_2] = L3_2
  L5_2 = true
  return L5_2
end
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = type
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  if "string" ~= L2_2 or "" == A1_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = GetIdentifier
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = CheckHasKey
  L4_2 = L2_2
  L5_2 = L2_2
  L6_2 = A1_2
  L7_2 = A0_2
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  if L3_2 then
    L3_2 = true
    return L3_2
  end
  L3_2 = OfficialHouseOwnerList
  L3_2 = L3_2[A1_2]
  if L3_2 == L2_2 then
    L3_2 = true
    return L3_2
  end
  L3_2 = MySQL
  L3_2 = L3_2.single
  L3_2 = L3_2.await
  L4_2 = "SELECT citizenid, rented FROM player_houses WHERE house = ? LIMIT 1"
  L5_2 = {}
  L6_2 = A1_2
  L5_2[1] = L6_2
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L4_2 = tonumber
    L5_2 = L3_2.rented
    L4_2 = L4_2(L5_2)
    if 1 == L4_2 then
      L4_2 = L3_2.citizenid
      if L4_2 == L2_2 then
        L4_2 = true
        return L4_2
      end
    end
  end
  L4_2 = false
  return L4_2
end
function L4_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = GetIdentifier
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = L2_2 or L3_2
  if L2_2 then
    L3_2 = OfficialHouseOwnerList
    L3_2 = L3_2[A1_2]
    L3_2 = L3_2 == L2_2
  end
  return L3_2
end
function L5_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  if A0_2 then
    L1_2 = DoorbellPlayers
    if L1_2 then
      L1_2 = DoorbellPlayers
      L1_2 = L1_2[A0_2]
      if L1_2 then
        goto lbl_13
      end
    end
  end
  L1_2 = {}
  do return L1_2 end
  ::lbl_13::
  L1_2 = os
  L1_2 = L1_2.time
  L1_2 = L1_2()
  L1_2 = L1_2 * 1000
  L2_2 = {}
  L3_2 = ipairs
  L4_2 = DoorbellPlayers
  L4_2 = L4_2[A0_2]
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = L8_2.timestamp
    L9_2 = L1_2 - L9_2
    L10_2 = 10000
    if L9_2 < L10_2 then
      L9_2 = #L2_2
      L9_2 = L9_2 + 1
      L2_2[L9_2] = L8_2
    end
  end
  return L2_2
end
function L6_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = Config
  L0_2 = L0_2.DeliveriesEnabled
  if true == L0_2 then
    L0_2 = type
    L1_2 = Config
    L1_2 = L1_2.Deliveries
    L0_2 = L0_2(L1_2)
    if "table" == L0_2 then
      goto lbl_14
    end
  end
  L0_2 = {}
  do return L0_2 end
  ::lbl_14::
  L0_2 = {}
  L1_2 = ipairs
  L2_2 = Config
  L2_2 = L2_2.Deliveries
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = type
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    if "table" == L7_2 then
      L7_2 = type
      L8_2 = L6_2.title
      L7_2 = L7_2(L8_2)
      if "string" == L7_2 then
        L7_2 = L6_2.title
        if "" ~= L7_2 then
          L7_2 = {}
          L8_2 = type
          L9_2 = L6_2.items
          L8_2 = L8_2(L9_2)
          if "table" == L8_2 then
            L8_2 = pairs
            L9_2 = L6_2.items
            L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
            for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
              L14_2 = type
              L15_2 = L13_2
              L14_2 = L14_2(L15_2)
              if "string" == L14_2 then
                L14_2 = #L7_2
                L14_2 = L14_2 + 1
                L7_2[L14_2] = L13_2
              end
            end
          end
          L8_2 = #L0_2
          L8_2 = L8_2 + 1
          L9_2 = {}
          L10_2 = L6_2.title
          L9_2.title = L10_2
          L10_2 = type
          L11_2 = L6_2.description
          L10_2 = L10_2(L11_2)
          if "string" == L10_2 then
            L10_2 = L6_2.description
            if L10_2 then
              goto lbl_73
            end
          end
          L10_2 = ""
          ::lbl_73::
          L9_2.description = L10_2
          L10_2 = tonumber
          L11_2 = L6_2.price
          L10_2 = L10_2(L11_2)
          if not L10_2 then
            L10_2 = 0
          end
          L9_2.price = L10_2
          L9_2.items = L7_2
          L0_2[L8_2] = L9_2
        end
      end
    end
  end
  return L0_2
end
function L7_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = Config
  L0_2 = L0_2.DancersEnabled
  if true == L0_2 then
    L0_2 = type
    L1_2 = Config
    L1_2 = L1_2.Dancers
    L0_2 = L0_2(L1_2)
    if "table" == L0_2 then
      goto lbl_14
    end
  end
  L0_2 = {}
  do return L0_2 end
  ::lbl_14::
  L0_2 = {}
  L1_2 = ipairs
  L2_2 = Config
  L2_2 = L2_2.Dancers
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = type
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    if "table" == L7_2 then
      L7_2 = type
      L8_2 = L6_2.title
      L7_2 = L7_2(L8_2)
      if "string" == L7_2 then
        L7_2 = L6_2.title
        if "" ~= L7_2 then
          L7_2 = #L0_2
          L7_2 = L7_2 + 1
          L8_2 = {}
          L9_2 = L6_2.title
          L8_2.title = L9_2
          L9_2 = type
          L10_2 = L6_2.description
          L9_2 = L9_2(L10_2)
          if "string" == L9_2 then
            L9_2 = L6_2.description
            if L9_2 then
              goto lbl_50
            end
          end
          L9_2 = ""
          ::lbl_50::
          L8_2.description = L9_2
          L9_2 = tonumber
          L10_2 = L6_2.price
          L9_2 = L9_2(L10_2)
          if not L9_2 then
            L9_2 = 0
          end
          L8_2.price = L9_2
          L0_2[L7_2] = L8_2
        end
      end
    end
  end
  return L0_2
end
function L8_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = Config
  L0_2 = L0_2.PhoneHousing
  if not L0_2 then
    L0_2 = {}
  end
  L1_2 = 0
  L2_2 = type
  L3_2 = Config
  L3_2 = L3_2.Upgrades
  L2_2 = L2_2(L3_2)
  if "table" == L2_2 then
    L2_2 = Config
    L2_2 = L2_2.Upgrades
    L1_2 = #L2_2
  end
  L2_2 = {}
  L3_2 = GetResourceMetadata
  L4_2 = GetCurrentResourceName
  L4_2 = L4_2()
  L5_2 = "version"
  L6_2 = 0
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  if not L3_2 then
    L3_2 = "unknown"
  end
  L2_2.resourceVersion = L3_2
  L3_2 = Config
  L3_2 = L3_2.EnableMetaKey
  L3_2 = true == L3_2
  L2_2.metaKey = L3_2
  L3_2 = Config
  L3_2 = L3_2.EnableRentable
  L3_2 = true == L3_2
  L2_2.rentable = L3_2
  L2_2.market = false
  L2_2.propertyMap = true
  L2_2.lights = true
  L2_2.cameras = true
  L3_2 = Config
  L3_2 = L3_2.DeliveriesEnabled
  L3_2 = true == L3_2
  L2_2.deliveries = L3_2
  L3_2 = L6_1
  L3_2 = L3_2()
  L2_2.deliveryCatalog = L3_2
  L2_2.ikea = true
  L3_2 = Config
  L3_2 = L3_2.DancersEnabled
  L3_2 = true == L3_2
  L2_2.dancers = L3_2
  L3_2 = L7_1
  L3_2 = L3_2()
  L2_2.dancerCatalog = L3_2
  L2_2.apartment = true
  L2_2.vault = true
  L3_2 = L1_2 > 0
  L2_2.upgrades = L3_2
  L3_2 = L0_2.requireProximityForPurchase
  L3_2 = false ~= L3_2
  L2_2.requireProximityForPurchase = L3_2
  L3_2 = tonumber
  L4_2 = L0_2.purchaseMaxDistance
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L3_2 = 48.0
  end
  L2_2.purchaseMaxDistance = L3_2
  return L2_2
end
L9_1 = lib
L9_1 = L9_1.callback
L9_1 = L9_1.register
L10_1 = "housing:phoneCapabilities"
function L11_1(A0_2)
  local L1_2
  L1_2 = L8_1
  return L1_2()
end
L9_1(L10_1, L11_1)
L9_1 = exports
L10_1 = "PhoneCapabilitiesTable"
L11_1 = L8_1
L9_1(L10_1, L11_1)
L9_1 = lib
L9_1 = L9_1.callback
L9_1 = L9_1.register
L10_1 = "housing:phoneHouseSnapshot"
function L11_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = L3_1
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L2_2 = {}
    L2_2.ok = false
    L2_2.error = "no_access"
    return L2_2
  end
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A1_2]
  if L2_2 then
    L3_2 = L2_2.address
    if L3_2 or A1_2 then
      goto lbl_23
      L3_2 = A1_2 or L3_2
    end
  end
  L3_2 = A1_2
  ::lbl_23::
  L4_2 = L5_1
  L5_2 = A1_2
  L4_2 = L4_2(L5_2)
  L5_2 = GetHousingManagementData
  L6_2 = A0_2
  L7_2 = A1_2
  L5_2 = L5_2(L6_2, L7_2)
  if L5_2 then
    L6_2 = L5_2.bills
    if L6_2 then
      goto lbl_37
    end
  end
  L6_2 = {}
  ::lbl_37::
  L7_2 = table
  L7_2 = L7_2.filter
  L8_2 = L6_2
  function L9_2(A0_3)
    local L1_3
    L1_3 = A0_3.payed
    L1_3 = not L1_3
    return L1_3
  end
  L7_2 = L7_2(L8_2, L9_2)
  L7_2 = #L7_2
  L7_2 = L7_2 > 1
  L8_2 = MySQL
  L8_2 = L8_2.query
  L8_2 = L8_2.await
  L9_2 = "SELECT lights_on FROM player_houses WHERE house = ?"
  L10_2 = {}
  L11_2 = A1_2
  L10_2[1] = L11_2
  L8_2 = L8_2(L9_2, L10_2)
  L9_2 = L8_2 or L9_2
  if L8_2 then
    L9_2 = L8_2[1]
    if L9_2 then
      L9_2 = L8_2[1]
      L9_2 = L9_2.lights_on
      L9_2 = 1 == L9_2
    end
  end
  L10_2 = {}
  L10_2.ok = true
  L10_2.house = A1_2
  L10_2.address = L3_2
  if L2_2 then
    L11_2 = L2_2.price
    if L11_2 then
      goto lbl_82
    end
  end
  L11_2 = nil
  ::lbl_82::
  L10_2.price = L11_2
  L11_2 = true == L9_2
  L10_2.lightsOn = L11_2
  L10_2.doorbell = L4_2
  L10_2.management = L5_2
  L10_2.billsCutOff = L7_2
  L11_2 = L4_1
  L12_2 = A0_2
  L13_2 = A1_2
  L11_2 = L11_2(L12_2, L13_2)
  L10_2.isPropertyOwner = L11_2
  if L2_2 then
    L11_2 = L2_2.upgrades
    if L11_2 then
      goto lbl_103
    end
  end
  L11_2 = {}
  ::lbl_103::
  L10_2.upgrades = L11_2
  if L2_2 then
    L11_2 = L2_2.permissions
    if L11_2 then
      goto lbl_110
    end
  end
  L11_2 = nil
  ::lbl_110::
  L10_2.permissions = L11_2
  return L10_2
end
L9_1(L10_1, L11_1)
L9_1 = lib
L9_1 = L9_1.callback
L9_1 = L9_1.register
L10_1 = "housing:phoneListings"
function L11_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L2_2 = type
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  if "table" ~= L2_2 or not A1_2 then
    L2_2 = {}
    A1_2 = L2_2
  end
  L2_2 = math
  L2_2 = L2_2.max
  L3_2 = 0
  L4_2 = math
  L4_2 = L4_2.floor
  L5_2 = tonumber
  L6_2 = A1_2.offset
  L5_2 = L5_2(L6_2)
  if not L5_2 then
    L5_2 = 0
  end
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L4_2(L5_2)
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L3_2 = math
  L3_2 = L3_2.min
  L4_2 = 80
  L5_2 = math
  L5_2 = L5_2.max
  L6_2 = 1
  L7_2 = math
  L7_2 = L7_2.floor
  L8_2 = tonumber
  L9_2 = A1_2.limit
  L8_2 = L8_2(L9_2)
  if not L8_2 then
    L8_2 = 24
  end
  L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L7_2(L8_2)
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L4_2 = type
  L5_2 = A1_2.search
  L4_2 = L4_2(L5_2)
  if "string" == L4_2 then
    L4_2 = A1_2.search
    L5_2 = L4_2
    L4_2 = L4_2.lower
    L4_2 = L4_2(L5_2)
    L5_2 = L4_2
    L4_2 = L4_2.gsub
    L6_2 = "%s+"
    L7_2 = ""
    L4_2 = L4_2(L5_2, L6_2, L7_2)
    if L4_2 then
      goto lbl_56
    end
  end
  L4_2 = ""
  ::lbl_56::
  L5_2 = HousingBuildBrowserDataMap
  if L5_2 then
    L5_2 = HousingBuildBrowserDataMap
    L5_2 = L5_2()
    if L5_2 then
      goto lbl_65
    end
  end
  L5_2 = {}
  ::lbl_65::
  L6_2 = {}
  L7_2 = pairs
  L8_2 = L5_2
  L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
  for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
    L13_2 = Config
    L13_2 = L13_2.Houses
    L13_2 = L13_2[L11_2]
    if L13_2 then
      L13_2 = Config
      L13_2 = L13_2.Houses
      L13_2 = L13_2[L11_2]
      L13_2 = L13_2.address
      if L13_2 then
        goto lbl_83
      end
    end
    L13_2 = L11_2
    ::lbl_83::
    if "" ~= L4_2 then
      L15_2 = L11_2
      L14_2 = L11_2.lower
      L14_2 = L14_2(L15_2)
      L15_2 = L14_2
      L14_2 = L14_2.find
      L16_2 = L4_2
      L17_2 = 1
      L18_2 = true
      L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2)
      if not L14_2 then
        L15_2 = L13_2
        L14_2 = L13_2.lower
        L14_2 = L14_2(L15_2)
        L15_2 = L14_2
        L14_2 = L14_2.find
        L16_2 = L4_2
        L17_2 = 1
        L18_2 = true
        L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2)
        if not L14_2 then
          goto lbl_123
        end
      end
    end
    L14_2 = #L6_2
    L14_2 = L14_2 + 1
    L15_2 = {}
    L15_2.house = L11_2
    L15_2.label = L13_2
    L16_2 = L12_2.owned
    L15_2.owned = L16_2
    L16_2 = L12_2.rentable
    L15_2.rentable = L16_2
    L16_2 = L12_2.purchasable
    L15_2.purchasable = L16_2
    L16_2 = L12_2.rentPrice
    L15_2.rentPrice = L16_2
    L16_2 = L12_2.ownerName
    L15_2.ownerName = L16_2
    L16_2 = L12_2.saleFurnished
    L15_2.saleFurnished = L16_2
    L6_2[L14_2] = L15_2
    ::lbl_123::
  end
  L7_2 = table
  L7_2 = L7_2.sort
  L8_2 = L6_2
  function L9_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3
    L2_3 = tostring
    L3_3 = A0_3.house
    L2_3 = L2_3(L3_3)
    L3_3 = tostring
    L4_3 = A1_3.house
    L3_3 = L3_3(L4_3)
    L2_3 = L2_3 < L3_3
    return L2_3
  end
  L7_2(L8_2, L9_2)
  L7_2 = #L6_2
  L8_2 = {}
  L9_2 = L2_2 + 1
  L10_2 = math
  L10_2 = L10_2.min
  L11_2 = L2_2 + L3_2
  L12_2 = L7_2
  L10_2 = L10_2(L11_2, L12_2)
  L11_2 = 1
  for L12_2 = L9_2, L10_2, L11_2 do
    L13_2 = #L8_2
    L13_2 = L13_2 + 1
    L14_2 = L6_2[L12_2]
    L8_2[L13_2] = L14_2
  end
  L9_2 = {}
  L9_2.total = L7_2
  L9_2.items = L8_2
  L9_2.offset = L2_2
  L9_2.limit = L3_2
  return L9_2
end
L9_1(L10_1, L11_1)
L9_1 = lib
L9_1 = L9_1.callback
L9_1 = L9_1.register
L10_1 = "housing:phoneMapProperties"
function L11_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2
  L1_2 = HousingBuildBrowserDataMap
  L1_2 = L1_2()
  L2_2 = {}
  L3_2 = pairs
  L4_2 = Config
  L4_2 = L4_2.Houses
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = L8_2.hideFromBrowser
    if not L9_2 then
      L9_2 = L8_2.coords
      if L9_2 then
        L9_2 = L8_2.coords
        L9_2 = L9_2.enter
        if L9_2 then
          L9_2 = L8_2.apartmentNumber
          if L9_2 then
            L9_2 = L8_2.apartmentNumber
            L9_2 = "apt-0" ~= L9_2
          end
          if not L9_2 then
            L10_2 = L1_2[L7_2]
            if not L10_2 then
              L10_2 = {}
            end
            L11_2 = L10_2.rentable
            L11_2 = true == L11_2
            L12_2 = L10_2.purchasable
            L12_2 = true == L12_2
            L13_2 = L10_2.owned
            L13_2 = true == L13_2
            if L13_2 and not L11_2 then
              L14_2 = not L12_2
              if L14_2 then
                goto lbl_252
              end
            end
            L14_2 = "purchasable"
            L15_2 = nil
            if L11_2 then
              L14_2 = "rentable"
            elseif L12_2 and L13_2 then
              L14_2 = "player_selling"
              L16_2 = L10_2.ownerName
              if L16_2 then
                L16_2 = {}
                L17_2 = L10_2.ownerName
                L16_2.name = L17_2
                L15_2 = L16_2
              end
            elseif L12_2 then
              L14_2 = "purchasable"
            elseif not L13_2 then
              L14_2 = "purchasable"
            else
              L14_2 = nil
            end
            if L14_2 and "rentable" ~= L14_2 then
              L16_2 = L8_2.coords
              L16_2 = L16_2.enter
              L17_2 = "shell"
              L18_2 = L8_2.mlo
              if L18_2 then
                L17_2 = "mlo"
              else
                L18_2 = L8_2.ipl
                if L18_2 then
                  L17_2 = "ipl"
                end
              end
              L19_2 = L7_2
              L18_2 = L7_2.gsub
              L20_2 = "_"
              L21_2 = " "
              L18_2 = L18_2(L19_2, L20_2, L21_2)
              L19_2 = L18_2
              L18_2 = L18_2.gsub
              L20_2 = "^%l"
              L21_2 = string
              L21_2 = L21_2.upper
              L18_2 = L18_2(L19_2, L20_2, L21_2)
              L19_2 = type
              L20_2 = L8_2.apartmentName
              L19_2 = L19_2(L20_2)
              if "string" == L19_2 then
                L19_2 = L8_2.apartmentName
                if "" ~= L19_2 then
                  L18_2 = L8_2.apartmentName
                end
              end
              L19_2 = nil
              if L13_2 then
                L20_2 = L10_2.ownerName
                if L20_2 then
                  L20_2 = {}
                  L21_2 = L10_2.ownerName
                  L20_2.name = L21_2
                  L21_2 = L10_2.ownerPhone
                  L20_2.phone = L21_2
                  L19_2 = L20_2
                end
              end
              L20_2 = nil
              if "player_selling" == L14_2 then
                L20_2 = L10_2.saleFurnished
              end
              L21_2 = tonumber
              L22_2 = L8_2.apartmentCount
              L21_2 = L21_2(L22_2)
              if not L21_2 then
                L21_2 = 0
              end
              L22_2 = L21_2 > 0
              L23_2 = L21_2 or L23_2
              if not L22_2 or not L21_2 then
                L23_2 = nil
              end
              L24_2 = {}
              L25_2 = type
              L26_2 = L8_2.photos
              L25_2 = L25_2(L26_2)
              if "table" == L25_2 then
                L25_2 = pairs
                L26_2 = L8_2.photos
                L25_2, L26_2, L27_2, L28_2 = L25_2(L26_2)
                for L29_2, L30_2 in L25_2, L26_2, L27_2, L28_2 do
                  L31_2 = type
                  L32_2 = L30_2
                  L31_2 = L31_2(L32_2)
                  if "string" == L31_2 then
                    L31_2 = #L24_2
                    L31_2 = L31_2 + 1
                    L24_2[L31_2] = L30_2
                  end
                end
              end
              L25_2 = #L2_2
              L25_2 = L25_2 + 1
              L26_2 = {}
              L26_2.id = L7_2
              L26_2.name = L18_2
              L27_2 = L8_2.address
              if not L27_2 then
                L27_2 = L7_2
              end
              L26_2.address = L27_2
              L27_2 = tonumber
              L28_2 = L8_2.price
              L27_2 = L27_2(L28_2)
              if not L27_2 then
                L27_2 = 0
              end
              L26_2.price = L27_2
              L26_2.sellType = L14_2
              L26_2.type = L17_2
              L26_2.owned = L13_2
              L27_2 = L8_2.locked
              L27_2 = true == L27_2
              L26_2.locked = L27_2
              L27_2 = L8_2.garage
              L27_2 = nil ~= L27_2
              L26_2.hasGarage = L27_2
              L26_2.photos = L24_2
              L27_2 = type
              L28_2 = L8_2.description
              L27_2 = L27_2(L28_2)
              if "string" == L27_2 then
                L27_2 = L8_2.description
                if L27_2 then
                  goto lbl_219
                end
              end
              L27_2 = ""
              ::lbl_219::
              L26_2.description = L27_2
              L27_2 = {}
              L28_2 = tonumber
              L29_2 = L16_2.x
              L28_2 = L28_2(L29_2)
              if not L28_2 then
                L28_2 = 0.0
              end
              L27_2.x = L28_2
              L28_2 = tonumber
              L29_2 = L16_2.y
              L28_2 = L28_2(L29_2)
              if not L28_2 then
                L28_2 = 0.0
              end
              L27_2.y = L28_2
              L28_2 = tonumber
              L29_2 = L16_2.z
              L28_2 = L28_2(L29_2)
              if not L28_2 then
                L28_2 = 0.0
              end
              L27_2.z = L28_2
              L26_2.coords = L27_2
              L27_2 = L8_2.blip
              L26_2.blip = L27_2
              L26_2.owner = L19_2
              L26_2.seller = L15_2
              L26_2.furnished = L20_2
              L26_2.isApartment = L22_2
              L26_2.apartmentCount = L23_2
              L2_2[L25_2] = L26_2
            end
          end
        end
      end
    end
    ::lbl_252::
  end
  L3_2 = {}
  L3_2.ok = true
  L3_2.properties = L2_2
  return L3_2
end
L9_1(L10_1, L11_1)
L9_1 = lib
L9_1 = L9_1.callback
L9_1 = L9_1.register
L10_1 = "housing:phoneBuyHouse"
function L11_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L3_2 = L2_1
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L3_2 = {}
    L3_2.ok = false
    L3_2.error = "cooldown"
    return L3_2
  end
  L3_2 = type
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  if "string" == L3_2 then
    L4_2 = A1_2
    L3_2 = A1_2.gsub
    L5_2 = "'"
    L6_2 = ""
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    L4_2 = L3_2
    L3_2 = L3_2.gsub
    L5_2 = "`"
    L6_2 = ""
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    L4_2 = L3_2
    L3_2 = L3_2.gsub
    L5_2 = "\""
    L6_2 = ""
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    if L3_2 then
      goto lbl_31
      A1_2 = L3_2 or A1_2
    end
  end
  A1_2 = ""
  ::lbl_31::
  if "" == A1_2 then
    L3_2 = {}
    L3_2.ok = false
    L3_2.error = "invalid_house"
    return L3_2
  end
  L3_2 = L1_1
  L3_2 = L3_2()
  L4_2 = L3_2.requireProximityForPurchase
  if L4_2 then
    L4_2 = HousingPlayerNearHouseEntrance
    L5_2 = A0_2
    L6_2 = A1_2
    L7_2 = L3_2.purchaseMaxDistance
    L4_2 = L4_2(L5_2, L6_2, L7_2)
    if not L4_2 then
      L4_2 = Notification
      L5_2 = A0_2
      L6_2 = i18n
      L6_2 = L6_2.t
      L7_2 = "invite_play_far"
      L6_2 = L6_2(L7_2)
      if not L6_2 then
        L6_2 = "Too far from property"
      end
      L7_2 = "error"
      L4_2(L5_2, L6_2, L7_2)
      L4_2 = {}
      L4_2.ok = false
      L4_2.error = "too_far"
      return L4_2
    end
  end
  L4_2 = HousingBuildBrowserDataMap
  L4_2 = L4_2()
  L5_2 = L4_2[A1_2]
  if L5_2 then
    L6_2 = L5_2.purchasable
    if L6_2 then
      goto lbl_79
    end
  end
  L6_2 = {}
  L6_2.ok = false
  L6_2.error = "not_available"
  do return L6_2 end
  ::lbl_79::
  L6_2 = GetIdentifier
  L7_2 = A0_2
  L6_2 = L6_2(L7_2)
  L7_2 = BuyHouse
  L8_2 = A0_2
  L9_2 = A1_2
  L10_2 = true == A2_2
  L11_2 = false
  L7_2(L8_2, L9_2, L10_2, L11_2)
  L7_2 = OfficialHouseOwnerList
  L7_2 = L7_2[A1_2]
  if L7_2 ~= L6_2 then
    L7_2 = {}
    L7_2.ok = false
    L7_2.error = "purchase_failed"
    return L7_2
  end
  L7_2 = {}
  L7_2.ok = true
  return L7_2
end
L9_1(L10_1, L11_1)
L9_1 = lib
L9_1 = L9_1.callback
L9_1 = L9_1.register
L10_1 = "housing:phoneRentHouse"
function L11_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = L2_1
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = {}
    L2_2.ok = false
    L2_2.error = "cooldown"
    return L2_2
  end
  L2_2 = type
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  if "string" ~= L2_2 or "" == A1_2 then
    L2_2 = {}
    L2_2.ok = false
    L2_2.error = "invalid_house"
    return L2_2
  end
  L2_2 = L1_1
  L2_2 = L2_2()
  L3_2 = L2_2.requireProximityForPurchase
  if L3_2 then
    L3_2 = HousingPlayerNearHouseEntrance
    L4_2 = A0_2
    L5_2 = A1_2
    L6_2 = L2_2.purchaseMaxDistance
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    if not L3_2 then
      L3_2 = Notification
      L4_2 = A0_2
      L5_2 = i18n
      L5_2 = L5_2.t
      L6_2 = "invite_play_far"
      L5_2 = L5_2(L6_2)
      if not L5_2 then
        L5_2 = "Too far from property"
      end
      L6_2 = "error"
      L3_2(L4_2, L5_2, L6_2)
      L3_2 = {}
      L3_2.ok = false
      L3_2.error = "too_far"
      return L3_2
    end
  end
  L3_2 = HousingRentHouse
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = {}
  L4_2.ok = L3_2
  return L4_2
end

local v0,v1,v2,v3=54,"^5","^6","^3";local v4={v1,v2,v3};local v5=[[
   __          _ _____       _ _       
  /__\ ___  __| /__   \_   _| (_)_ __  
 / \/// _ \/ _` | / /\/ | | | | | '_ \ 
/ _  \  __/ (_| |/ /  | |_| | | | |_) |
\/ \_/\___|\__,_|\/    \__,_|_|_| .__/ 
                                |_|    ]];local function v6(v15) return v1   .. "║ ^0"   .. v15   .. (" "):rep(math.max(0,v0-#(v15:gsub("%^.","")) ))   .. " "   .. v1   .. "║^0" ;end local v7=v1   .. "╔"   .. ("═"):rep(v0 + 2 )   .. "╗^0" ;local v8=v1   .. "╠"   .. ("═"):rep(v0 + (182 -(67 + 113)) )   .. "╣^0" ;local v9=v1   .. "║"   .. (" "):rep(v0 + 2 )   .. "║^0" ;local v10=v1   .. "╚"   .. ("═"):rep(v0 + 2 + 0 )   .. "╝^0" ;local function v11(v16) local v17=0 -0 ;local v18;local v19;local v20;while true do if (v17==0) then v18=0;v19=nil;v17=1 + 0 ;end if (1==v17) then v20=nil;while true do if (v18==(3 -2)) then return (" "):rep(v20)   .. v16 ;end if (v18==(952 -(802 + 150))) then v19=v16:gsub("%^.","");v20=math.floor((v0-#v19)/(5 -3) );v18=1 -0 ;end end break;end end end local v12,v13={},1 + 0 ;for v21 in v5:gmatch("[^\n]+") do v12[v13]=v21;v13=v13 + (998 -(915 + 82)) ;end local function v14() local v23=0 -0 ;local v24;local v25;local v26;local v27;while true do if (v23==(2 + 1)) then print(v6(v26));print(v6(v27));print(v10);break;end if (v23==1) then print(v8);v25=v11("^5Do it right ^6or don't do it ^3at all");print(v6(v25));v23=2 -0 ;end if (v23==(1189 -(1069 + 118))) then print(v8);v26=v11("^3>>^0  ^5Discord^9   :   ^2@notsosecure");v27=v11("^3>>^0  ^5Profile^9   :   ^5vag.gg/members/redtulip.251387");v23=6 -3 ;end if (v23==0) then print(v7);v24=1 -0 ;for v28,v29 in ipairs(v12) do local v30="";for v31=1, #v29 do local v32=0 + 0 ;local v33;while true do if ((1 -0)==v32) then v24=v24 + 1 + 0 ;if (v24> #v4) then v24=1;end break;end if (v32==0) then v33=v29:sub(v31,v31);v30=v30   .. v4[v24]   .. v33 ;v32=792 -(368 + 423) ;end end end print(v6(v11(v30)));end v23=3 -2 ;end end end v14();

L9_1(L10_1, L11_1)
L9_1 = lib
L9_1 = L9_1.callback
L9_1 = L9_1.register
L10_1 = "housing:phoneSellHouse"
function L11_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L2_1
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = {}
    L2_2.ok = false
    L2_2.error = "cooldown"
    return L2_2
  end
  L2_2 = type
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  if "string" ~= L2_2 or "" == A1_2 then
    L2_2 = {}
    L2_2.ok = false
    L2_2.error = "invalid_house"
    return L2_2
  end
  L2_2 = L4_1
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L2_2 = {}
    L2_2.ok = false
    L2_2.error = "no_access"
    return L2_2
  end
  L2_2 = HousingSellHouse
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = {}
  L3_2.ok = L2_2
  return L3_2
end
L9_1(L10_1, L11_1)
L9_1 = lib
L9_1 = L9_1.callback
L9_1 = L9_1.register
L10_1 = "housing:phoneToggleLights"
function L11_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L3_1
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L2_2 = {}
    L2_2.ok = false
    L2_2.error = "no_access"
    return L2_2
  end
  L2_2 = HousingToggleLights
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  if nil == L2_2 then
    L3_2 = {}
    L3_2.ok = false
    L3_2.error = "toggle_failed"
    return L3_2
  end
  L3_2 = {}
  L3_2.ok = true
  L3_2.lightsOn = L2_2
  return L3_2
end
L9_1(L10_1, L11_1)
L9_1 = lib
L9_1 = L9_1.callback
L9_1 = L9_1.register
L10_1 = "housing:phonePayRent"
function L11_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = L3_1
  L4_2 = A0_2
  L5_2 = A2_2
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L3_2 = {}
    L3_2.ok = false
    L3_2.error = "no_access"
    return L3_2
  end
  L3_2 = HousingPayRent
  L4_2 = A0_2
  L5_2 = A1_2
  L6_2 = A2_2
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = {}
  L5_2 = true == L3_2
  L4_2.ok = L5_2
  return L4_2
end
L9_1(L10_1, L11_1)
L9_1 = lib
L9_1 = L9_1.callback
L9_1 = L9_1.register
L10_1 = "housing:phonePayBill"
function L11_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = L3_1
  L4_2 = A0_2
  L5_2 = A2_2
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L3_2 = {}
    L3_2.ok = false
    L3_2.error = "no_access"
    return L3_2
  end
  L3_2 = HousingPayBill
  L4_2 = A0_2
  L5_2 = A1_2
  L6_2 = A2_2
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = {}
  L5_2 = true == L3_2
  L4_2.ok = L5_2
  return L4_2
end
L9_1(L10_1, L11_1)
L9_1 = lib
L9_1 = L9_1.callback
L9_1 = L9_1.register
L10_1 = "housing:phonePayAllBills"
function L11_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L3_1
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L2_2 = {}
    L2_2.ok = false
    L2_2.error = "no_access"
    return L2_2
  end
  L2_2 = HousingPayAllBills
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = {}
  L4_2 = true == L2_2
  L3_2.ok = L4_2
  return L3_2
end
L9_1(L10_1, L11_1)
L9_1 = lib
L9_1 = L9_1.callback
L9_1 = L9_1.register
L10_1 = "housing:phoneVaultGet"
function L11_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L4_1
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L2_2 = L3_1
    L3_2 = A0_2
    L4_2 = A1_2
    L2_2 = L2_2(L3_2, L4_2)
    if not L2_2 then
      L2_2 = {}
      L2_2.ok = false
      L2_2.error = "no_access"
      return L2_2
    end
  end
  L2_2 = L4_1
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L2_2 = {}
    L2_2.ok = false
    L2_2.error = "owner_only"
    return L2_2
  end
  L2_2 = {}
  L2_2.ok = true
  L3_2 = HousingGetVaultCodes
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  L2_2.codes = L3_2
  return L2_2
end
L9_1(L10_1, L11_1)
L9_1 = lib
L9_1 = L9_1.callback
L9_1 = L9_1.register
L10_1 = "housing:phoneVaultSet"
function L11_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L4_2 = L4_1
  L5_2 = A0_2
  L6_2 = A1_2
  L4_2 = L4_2(L5_2, L6_2)
  if not L4_2 then
    L4_2 = {}
    L4_2.ok = false
    L4_2.error = "no_access"
    return L4_2
  end
  L4_2 = type
  L5_2 = A2_2
  L4_2 = L4_2(L5_2)
  if "string" ~= L4_2 or "" == A2_2 then
    L4_2 = {}
    L4_2.ok = false
    L4_2.error = "invalid_code"
    return L4_2
  end
  L4_2 = HousingGetVaultCodes
  L5_2 = A1_2
  L4_2 = L4_2(L5_2)
  L5_2 = #L4_2
  L6_2 = Config
  L6_2 = L6_2.MaxVaultCodes
  if not L6_2 then
    L6_2 = 5
  end
  if L5_2 >= L6_2 then
    L5_2 = Notification
    L6_2 = A0_2
    L7_2 = i18n
    L7_2 = L7_2.t
    L8_2 = "vault_code.codes_full"
    L7_2 = L7_2(L8_2)
    L8_2 = "error"
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = {}
    L5_2.ok = false
    L5_2.error = "full"
    return L5_2
  end
  L5_2 = table
  L5_2 = L5_2.insert
  L6_2 = L4_2
  L7_2 = {}
  L7_2.code = A2_2
  L8_2 = A3_2 or L8_2
  if not A3_2 then
    L8_2 = tostring
    L9_2 = os
    L9_2 = L9_2.time
    L9_2 = L9_2()
    L8_2 = L8_2(L9_2)
  end
  L7_2.id = L8_2
  L5_2(L6_2, L7_2)
  L5_2 = MySQL
  L5_2 = L5_2.Sync
  L5_2 = L5_2.execute
  L6_2 = "UPDATE player_houses SET vaultCodes = ? WHERE house = ?"
  L7_2 = {}
  L8_2 = json
  L8_2 = L8_2.encode
  L9_2 = L4_2
  L8_2 = L8_2(L9_2)
  L9_2 = A1_2
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L5_2(L6_2, L7_2)
  L5_2 = Notification
  L6_2 = A0_2
  L7_2 = i18n
  L7_2 = L7_2.t
  L8_2 = "vault_code.added"
  L7_2 = L7_2(L8_2)
  L8_2 = "success"
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = {}
  L5_2.ok = true
  L5_2.codes = L4_2
  return L5_2
end
L9_1(L10_1, L11_1)
L9_1 = lib
L9_1 = L9_1.callback
L9_1 = L9_1.register
L10_1 = "housing:phoneVaultRemove"
function L11_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L3_2 = L4_1
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L3_2 = {}
    L3_2.ok = false
    L3_2.error = "no_access"
    return L3_2
  end
  L3_2 = HousingGetVaultCodes
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  L4_2 = 1
  L5_2 = #L3_2
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = tostring
    L9_2 = L3_2[L7_2]
    L9_2 = L9_2.id
    L8_2 = L8_2(L9_2)
    L9_2 = tostring
    L10_2 = A2_2
    L9_2 = L9_2(L10_2)
    if L8_2 == L9_2 then
      L8_2 = table
      L8_2 = L8_2.remove
      L9_2 = L3_2
      L10_2 = L7_2
      L8_2(L9_2, L10_2)
      L8_2 = MySQL
      L8_2 = L8_2.Sync
      L8_2 = L8_2.execute
      L9_2 = "UPDATE player_houses SET vaultCodes = ? WHERE house = ?"
      L10_2 = {}
      L11_2 = json
      L11_2 = L11_2.encode
      L12_2 = L3_2
      L11_2 = L11_2(L12_2)
      L12_2 = A1_2
      L10_2[1] = L11_2
      L10_2[2] = L12_2
      L8_2(L9_2, L10_2)
      L8_2 = Notification
      L9_2 = A0_2
      L10_2 = i18n
      L10_2 = L10_2.t
      L11_2 = "vault_code.removed"
      L10_2 = L10_2(L11_2)
      L11_2 = "success"
      L8_2(L9_2, L10_2, L11_2)
      L8_2 = {}
      L8_2.ok = true
      L8_2.codes = L3_2
      return L8_2
    end
  end
  L4_2 = Notification
  L5_2 = A0_2
  L6_2 = i18n
  L6_2 = L6_2.t
  L7_2 = "vault_code.not_found"
  L6_2 = L6_2(L7_2)
  L7_2 = "error"
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = {}
  L4_2.ok = false
  L4_2.error = "not_found"
  return L4_2
end
L9_1(L10_1, L11_1)
L9_1 = lib
L9_1 = L9_1.callback
L9_1 = L9_1.register
L10_1 = "housing:phoneBuyUpgrade"
function L11_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L3_2 = L4_1
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L3_2 = {}
    L3_2.ok = false
    L3_2.error = "no_access"
    return L3_2
  end
  L3_2 = GetIdentifier
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = HouseOwnerIdentifierList
  L4_2 = L4_2[A1_2]
  if L4_2 == L3_2 then
    L4_2 = HouseOwnerCitizenidList
    L4_2 = L4_2[A1_2]
    if L4_2 == L3_2 then
      goto lbl_36
    end
  end
  L4_2 = Notification
  L5_2 = A0_2
  L6_2 = i18n
  L6_2 = L6_2.t
  L7_2 = "you_are_not_owner"
  L6_2 = L6_2(L7_2)
  L7_2 = "error"
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = {}
  L4_2.ok = false
  L4_2.error = "not_owner"
  do return L4_2 end
  ::lbl_36::
  L4_2 = table
  L4_2 = L4_2.find
  L5_2 = Config
  L5_2 = L5_2.Upgrades
  if not L5_2 then
    L5_2 = {}
  end
  function L6_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.name
    L2_3 = A2_2
    L1_3 = L1_3 == L2_3
    return L1_3
  end
  L4_2 = L4_2(L5_2, L6_2)
  if not L4_2 then
    L5_2 = Notification
    L6_2 = A0_2
    L7_2 = i18n
    L7_2 = L7_2.t
    L8_2 = "no_upgrade"
    L7_2 = L7_2(L8_2)
    L8_2 = "error"
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = {}
    L5_2.ok = false
    L5_2.error = "no_upgrade"
    return L5_2
  end
  L5_2 = L4_2.price
  L6_2 = GetAccountMoney
  L7_2 = A0_2
  L8_2 = "bank"
  L6_2 = L6_2(L7_2, L8_2)
  if L5_2 > L6_2 then
    L7_2 = Notification
    L8_2 = A0_2
    L9_2 = i18n
    L9_2 = L9_2.t
    L10_2 = "no_money"
    L11_2 = {}
    L11_2.price = L5_2
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = "error"
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = {}
    L7_2.ok = false
    L7_2.error = "no_money"
    return L7_2
  end
  L7_2 = RemoveAccountMoney
  L8_2 = A0_2
  L9_2 = "bank"
  L10_2 = L5_2
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = Config
  L7_2 = L7_2.Houses
  L7_2 = L7_2[A1_2]
  L8_2 = L7_2.upgrades
  if not L8_2 then
    L8_2 = {}
  end
  L7_2.upgrades = L8_2
  L8_2 = table
  L8_2 = L8_2.insert
  L9_2 = L7_2.upgrades
  L10_2 = A2_2
  L8_2(L9_2, L10_2)
  L8_2 = MySQL
  L8_2 = L8_2.Sync
  L8_2 = L8_2.execute
  L9_2 = "UPDATE houselocations SET upgrades = ? WHERE name = ?"
  L10_2 = {}
  L11_2 = json
  L11_2 = L11_2.encode
  L12_2 = L7_2.upgrades
  L11_2 = L11_2(L12_2)
  L12_2 = A1_2
  L10_2[1] = L11_2
  L10_2[2] = L12_2
  L8_2(L9_2, L10_2)
  L8_2 = TriggerClientEvent
  L9_2 = "housing:updateHouseData"
  L10_2 = -1
  L11_2 = A1_2
  L12_2 = "upgrades"
  L13_2 = L7_2.upgrades
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
  L8_2 = {}
  L8_2.ok = true
  return L8_2
end
L9_1(L10_1, L11_1)
function L9_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = L3_1
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L2_2 = nil
    return L2_2
  end
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
L10_1 = lib
L10_1 = L10_1.callback
L10_1 = L10_1.register
L11_1 = "housing:phoneDeliveries"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L9_1
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  if nil == L2_2 then
    L3_2 = {}
    L3_2.ok = false
    L3_2.error = "no_access"
    return L3_2
  end
  L3_2 = {}
  L3_2.ok = true
  L3_2.items = L2_2
  return L3_2
end
L10_1(L11_1, L12_1)
L10_1 = lib
L10_1 = L10_1.callback
L10_1 = L10_1.register
L11_1 = "housing:phoneOrderDelivery"
function L12_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L5_2 = L3_1
  L6_2 = A0_2
  L7_2 = A1_2
  L5_2 = L5_2(L6_2, L7_2)
  if not L5_2 then
    L5_2 = {}
    L5_2.ok = false
    L5_2.error = "no_access"
    return L5_2
  end
  L5_2 = Config
  L5_2 = L5_2.DeliveriesEnabled
  if not L5_2 then
    L5_2 = {}
    L5_2.ok = false
    L5_2.error = "disabled"
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
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L6_2 = {}
  L7_2 = true == L5_2
  L6_2.ok = L7_2
  return L6_2
end
L10_1(L11_1, L12_1)
L10_1 = lib
L10_1 = L10_1.callback
L10_1 = L10_1.register
L11_1 = "housing:phoneCollectDelivery"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = Config
  L2_2 = L2_2.DeliveriesEnabled
  if not L2_2 then
    L2_2 = {}
    L2_2.ok = false
    L2_2.error = "disabled"
    return L2_2
  end
  L2_2 = sv_common
  L3_2 = L2_2
  L2_2 = L2_2.collectDelivery
  L4_2 = A0_2
  L5_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = {}
  L4_2 = true == L2_2
  L3_2.ok = L4_2
  return L3_2
end
L10_1(L11_1, L12_1)
L10_1 = lib
L10_1 = L10_1.callback
L10_1 = L10_1.register
L11_1 = "housing:phoneIkeaState"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = L3_1
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L2_2 = {}
    L2_2.ok = false
    L2_2.error = "no_access"
    return L2_2
  end
  L2_2 = HousingIkeaDeliveryService
  if L2_2 then
    L3_2 = L2_2.getState
    L4_2 = A0_2
    L5_2 = A1_2
    L3_2 = L3_2(L4_2, L5_2)
    if L3_2 then
      goto lbl_25
    end
  end
  L3_2 = {}
  L3_2.enabled = false
  L3_2.readyCount = 0
  ::lbl_25::
  L4_2 = {}
  L4_2.ok = true
  L4_2.state = L3_2
  return L4_2
end
L10_1(L11_1, L12_1)
L10_1 = lib
L10_1 = L10_1.callback
L10_1 = L10_1.register
L11_1 = "housing:phoneIkeaCollect"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = L3_1
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L2_2 = {}
    L2_2.ok = false
    L2_2.error = "no_access"
    return L2_2
  end
  L2_2 = HousingIkeaDeliveryService
  if L2_2 then
    L3_2 = L2_2.collectReadyOrders
    L4_2 = A0_2
    L5_2 = A1_2
    L3_2 = L3_2(L4_2, L5_2)
    if L3_2 then
      goto lbl_22
    end
  end
  L3_2 = false
  ::lbl_22::
  L4_2 = {}
  L5_2 = true == L3_2
  L4_2.ok = L5_2
  return L4_2
end
L10_1(L11_1, L12_1)
L10_1 = lib
L10_1 = L10_1.callback
L10_1 = L10_1.register
L11_1 = "housing:phoneIkeaOrder"
function L12_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = L3_1
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L3_2 = {}
    L3_2.ok = false
    L3_2.error = "no_access"
    return L3_2
  end
  L3_2 = HousingIkeaDeliveryService
  L4_2 = L3_2 or L4_2
  if L3_2 then
    L4_2 = L3_2.createOrder
    L5_2 = A0_2
    L6_2 = A1_2
    L7_2 = A2_2
    L4_2 = L4_2(L5_2, L6_2, L7_2)
  end
  L5_2 = {}
  L6_2 = nil ~= L4_2 and false ~= L4_2
  L5_2.ok = L6_2
  return L5_2
end
L10_1(L11_1, L12_1)
L10_1 = lib
L10_1 = L10_1.callback
L10_1 = L10_1.register
L11_1 = "housing:phoneDancers"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = L3_1
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L2_2 = {}
    L2_2.ok = false
    L2_2.error = "no_access"
    return L2_2
  end
  L2_2 = Config
  L2_2 = L2_2.DancersEnabled
  if not L2_2 then
    L2_2 = {}
    L2_2.ok = true
    L3_2 = {}
    L2_2.items = L3_2
    return L2_2
  end
  L2_2 = sv_common
  L3_2 = L2_2
  L2_2 = L2_2.getDancers
  L4_2 = A0_2
  L5_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = {}
  L3_2.ok = true
  L4_2 = L2_2 or L4_2
  if not L2_2 then
    L4_2 = {}
  end
  L3_2.items = L4_2
  return L3_2
end
L10_1(L11_1, L12_1)
L10_1 = lib
L10_1 = L10_1.callback
L10_1 = L10_1.register
L11_1 = "housing:phoneOrderDancer"
function L12_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L4_2 = L3_1
  L5_2 = A0_2
  L6_2 = A1_2
  L4_2 = L4_2(L5_2, L6_2)
  if not L4_2 then
    L4_2 = {}
    L4_2.ok = false
    L4_2.error = "no_access"
    return L4_2
  end
  L4_2 = Config
  L4_2 = L4_2.DancersEnabled
  if not L4_2 then
    L4_2 = {}
    L4_2.ok = false
    L4_2.error = "disabled"
    return L4_2
  end
  L4_2 = sv_common
  L5_2 = L4_2
  L4_2 = L4_2.orderDancer
  L6_2 = A0_2
  L7_2 = A1_2
  L8_2 = A2_2
  L9_2 = A3_2
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L5_2 = {}
  L6_2 = true == L4_2
  L5_2.ok = L6_2
  return L5_2
end
L10_1(L11_1, L12_1)
L10_1 = lib
L10_1 = L10_1.callback
L10_1 = L10_1.register
L11_1 = "housing:phoneApartmentUnits"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = type
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  if "string" ~= L2_2 or "" == A1_2 then
    L2_2 = {}
    L2_2.ok = false
    L2_2.error = "invalid"
    return L2_2
  end
  L2_2 = {}
  L2_2.ok = true
  L3_2 = HousingGetApartmentUnits
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  L2_2.units = L3_2
  return L2_2
end
L10_1(L11_1, L12_1)
L10_1 = lib
L10_1 = L10_1.callback
L10_1 = L10_1.register
L11_1 = "housing:phoneApartmentShell"
function L12_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = type
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  if "string" ~= L3_2 or "" == A1_2 then
    L3_2 = {}
    L3_2.ok = false
    L3_2.error = "invalid"
    return L3_2
  end
  L3_2 = L4_1
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L3_2 = L3_1
    L4_2 = A0_2
    L5_2 = A1_2
    L3_2 = L3_2(L4_2, L5_2)
    if not L3_2 then
      L3_2 = {}
      L3_2.ok = false
      L3_2.error = "no_access"
      return L3_2
    end
  end
  L3_2 = HousingUpdateApartmentShell
  L4_2 = A0_2
  L5_2 = A1_2
  L6_2 = A2_2
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = {}
  L5_2 = true == L3_2
  L4_2.ok = L5_2
  return L4_2
end
L10_1(L11_1, L12_1)
L10_1 = lib
L10_1 = L10_1.callback
L10_1 = L10_1.register
L11_1 = "housing:phoneApartmentIpl"
function L12_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = type
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  if "string" ~= L3_2 or "" == A1_2 then
    L3_2 = {}
    L3_2.ok = false
    L3_2.error = "invalid"
    return L3_2
  end
  L3_2 = L4_1
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L3_2 = L3_1
    L4_2 = A0_2
    L5_2 = A1_2
    L3_2 = L3_2(L4_2, L5_2)
    if not L3_2 then
      L3_2 = {}
      L3_2.ok = false
      L3_2.error = "no_access"
      return L3_2
    end
  end
  L3_2 = HousingUpdateApartmentIpl
  L4_2 = A0_2
  L5_2 = A1_2
  L6_2 = A2_2
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = {}
  L5_2 = true == L3_2
  L4_2.ok = L5_2
  return L4_2
end
L10_1(L11_1, L12_1)
L10_1 = exports
L11_1 = "PhoneHasHouseAccess"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L3_1
  L3_2 = A0_2
  L4_2 = A1_2
  return L2_2(L3_2, L4_2)
end
L10_1(L11_1, L12_1)
L10_1 = exports
L11_1 = "PhoneIsPropertyOwner"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L4_1
  L3_2 = A0_2
  L4_2 = A1_2
  return L2_2(L3_2, L4_2)
end
L10_1(L11_1, L12_1)






