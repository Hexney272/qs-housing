





local L0_1, L1_1, L2_1
L0_1 = lib
L0_1 = L0_1.callback
L0_1 = L0_1.register
L1_1 = "housing:getCreatorData"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = HasPermission
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = Error
    L2_2 = "housing:getCreatorData"
    L3_2 = "Player does not have permission to get creator data"
    L1_2(L2_2, L3_2)
    L1_2 = nil
    return L1_2
  end
  L1_2 = {}
  L2_2 = pairs
  L3_2 = Config
  L3_2 = L3_2.Furniture
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    if "navigation" ~= L6_2 then
      L8_2 = #L1_2
      L8_2 = L8_2 + 1
      L9_2 = {}
      L9_2.key = L6_2
      L10_2 = L7_2.label
      L9_2.label = L10_2
      L1_2[L8_2] = L9_2
    end
  end
  L2_2 = {}
  L3_2 = GetJobsData
  L3_2 = L3_2()
  L2_2.jobs = L3_2
  L3_2 = Config
  L3_2 = L3_2.FurnitureShops
  L2_2.furnitureShops = L3_2
  L2_2.furnitureCategories = L1_2
  return L2_2
end
L0_1(L1_1, L2_1)
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = MySQL
  L1_2 = L1_2.Sync
  L1_2 = L1_2.fetchAll
  L2_2 = "SELECT COUNT(*) as count FROM player_garages WHERE name LIKE ?"
  L3_2 = {}
  L4_2 = "%"
  L5_2 = A0_2
  L6_2 = "%"
  L4_2 = L4_2 .. L5_2 .. L6_2
  L3_2[1] = L4_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = L1_2[1]
  L2_2 = L2_2.count
  L2_2 = L2_2 + 1
  return L2_2
end
GetGarageStreetId = L0_1
L0_1 = lib
L0_1 = L0_1.callback
L0_1 = L0_1.register
L1_1 = "housing:createHouse"
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L3_2 = HasPermission
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L3_2 = Error
    L4_2 = "housing:createHouse"
    L5_2 = "Player does not have permission to create house"
    L3_2(L4_2, L5_2)
    L3_2 = false
    return L3_2
  end
  L3_2 = Config
  L3_2 = L3_2.Houses
  L4_2 = A2_2.name
  L3_2 = L3_2[L4_2]
  if L3_2 then
    L3_2 = Notification
    L4_2 = A0_2
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "creator.house_already_exists"
    L5_2 = L5_2(L6_2)
    L6_2 = "error"
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = false
    return L3_2
  end
  L3_2 = A2_2.apartmentCount
  if L3_2 then
    L3_2 = tonumber
    L4_2 = A2_2.apartmentCount
    L3_2 = L3_2(L4_2)
    if L3_2 then
      goto lbl_37
    end
  end
  L3_2 = nil
  ::lbl_37::
  A2_2.apartmentCount = L3_2
  L3_2 = A2_2.apartmentCount
  if L3_2 then
    L3_2 = A2_2.apartmentCount
    L4_2 = Config
    L4_2 = L4_2.MaxApartmentCount
    if L3_2 > L4_2 then
      L3_2 = Error
      L4_2 = "This player tried to create more than the max apartment count"
      L5_2 = A0_2
      L6_2 = "We are decreasing the apartment count to the max"
      L3_2(L4_2, L5_2, L6_2)
      L3_2 = Config
      L3_2 = L3_2.MaxApartmentCount
      A2_2.apartmentCount = L3_2
    end
  end
  L3_2 = A2_2.apartmentCount
  if L3_2 then
    A2_2.garage = nil
    A2_2.garageShell = nil
  end
  L3_2 = GetCharacterName
  L4_2 = A0_2
  L3_2, L4_2 = L3_2(L4_2)
  L5_2 = L3_2
  L6_2 = " "
  L7_2 = L4_2
  L5_2 = L5_2 .. L6_2 .. L7_2
  L6_2 = GetPlayerPhone
  L7_2 = A0_2
  L6_2 = L6_2(L7_2)
  L7_2 = GetJobName
  L8_2 = A0_2
  L7_2 = L7_2(L8_2)
  L8_2 = {}
  L9_2 = Config
  L9_2 = L9_2.BoardObject
  L8_2.object = L9_2
  L9_2 = A2_2.board
  L8_2.coords = L9_2
  L9_2 = L5_2 or L9_2
  if not L5_2 then
    L9_2 = "Unknown"
  end
  L8_2.name = L9_2
  L9_2 = L6_2 or L9_2
  if not L6_2 then
    L9_2 = "Unknown"
  end
  L8_2.phone = L9_2
  A2_2.board = L8_2
  L9_2 = A1_2
  L8_2 = A1_2.gsub
  L10_2 = "%'"
  L11_2 = ""
  L8_2 = L8_2(L9_2, L10_2, L11_2)
  A1_2 = L8_2
  L8_2 = A2_2.price
  if L8_2 then
    L8_2 = tonumber
    L9_2 = A2_2.price
    L8_2 = L8_2(L9_2)
    if L8_2 then
      goto lbl_102
    end
  end
  L8_2 = 0
  ::lbl_102::
  A2_2.price = L8_2
  L8_2 = A2_2.tier
  if L8_2 then
    L8_2 = tonumber
    L9_2 = A2_2.tier
    L8_2 = L8_2(L9_2)
    if L8_2 then
      goto lbl_112
    end
  end
  L8_2 = 0
  ::lbl_112::
  A2_2.tier = L8_2
  A2_2.address = A1_2
  L8_2 = db
  L8_2 = L8_2.createHouse
  L9_2 = A0_2
  L10_2 = L7_2
  L11_2 = A2_2
  L8_2(L9_2, L10_2, L11_2)
  L8_2 = A2_2.island
  if L8_2 then
    L8_2 = L8_2.enable
  end
  if L8_2 then
    L8_2 = CreateHouseObject
    L9_2 = A0_2
    L10_2 = {}
    L11_2 = A2_2.name
    L10_2.house = L11_2
    L11_2 = A2_2.island
    L11_2 = L11_2.data
    L11_2 = L11_2.coords
    L10_2.coords = L11_2
    L11_2 = A2_2.island
    L11_2 = L11_2.data
    L11_2 = L11_2.model
    L10_2.model = L11_2
    L8_2(L9_2, L10_2)
  end
  L8_2 = A2_2.showOnMap
  if L8_2 then
    L8_2 = L8_2.enable
  end
  if L8_2 then
    L8_2 = CreateHouseObject
    L9_2 = A0_2
    L10_2 = {}
    L11_2 = A2_2.name
    L10_2.house = L11_2
    L11_2 = A2_2.showOnMap
    L11_2 = L11_2.data
    L11_2 = L11_2.coords
    L10_2.coords = L11_2
    L11_2 = A2_2.showOnMap
    L11_2 = L11_2.data
    L11_2 = L11_2.model
    L10_2.model = L11_2
    L8_2(L9_2, L10_2)
  end
  L8_2 = true
  return L8_2
end
L0_1(L1_1, L2_1)
L0_1 = lib
L0_1 = L0_1.callback
L0_1 = L0_1.register
L1_1 = "housing:updateHouse"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = HasPermission
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = Error
    L3_2 = "housing:updateHouse"
    L4_2 = "Player does not have permission to update house"
    L2_2(L3_2, L4_2)
    L2_2 = false
    return L2_2
  end
  L2_2 = assert
  L3_2 = A1_2.name
  L4_2 = "housing:updateHouse data.name is nil"
  L2_2(L3_2, L4_2)
  L2_2 = A1_2.apartmentCount
  if L2_2 then
    A1_2.garage = nil
    A1_2.garageShell = nil
  end
  L2_2 = GetCharacterName
  L3_2 = A0_2
  L2_2, L3_2 = L2_2(L3_2)
  L4_2 = L2_2
  L5_2 = " "
  L6_2 = L3_2
  L4_2 = L4_2 .. L5_2 .. L6_2
  L5_2 = GetPlayerPhone
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  L6_2 = {}
  L7_2 = Config
  L7_2 = L7_2.BoardObject
  L6_2.object = L7_2
  L7_2 = A1_2.board
  if L7_2 then
    L7_2 = L7_2.coords
    if L7_2 then
      L7_2 = L7_2.x
    end
  end
  if L7_2 then
    L7_2 = vec4
    L8_2 = A1_2.board
    L8_2 = L8_2.coords
    L8_2 = L8_2.x
    L9_2 = A1_2.board
    L9_2 = L9_2.coords
    L9_2 = L9_2.y
    L10_2 = A1_2.board
    L10_2 = L10_2.coords
    L10_2 = L10_2.z
    L11_2 = A1_2.board
    L11_2 = L11_2.coords
    L11_2 = L11_2.w
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
    if L7_2 then
      goto lbl_62
    end
  end
  L7_2 = A1_2.board
  ::lbl_62::
  L6_2.coords = L7_2
  L7_2 = L4_2 or L7_2
  if not L4_2 then
    L7_2 = "Unknown"
  end
  L6_2.name = L7_2
  L7_2 = L5_2 or L7_2
  if not L5_2 then
    L7_2 = "Unknown"
  end
  L6_2.phone = L7_2
  A1_2.board = L6_2
  L6_2 = A1_2.price
  if L6_2 then
    L6_2 = tonumber
    L7_2 = A1_2.price
    L6_2 = L6_2(L7_2)
    if L6_2 then
      goto lbl_81
    end
  end
  L6_2 = 0
  ::lbl_81::
  A1_2.price = L6_2
  L6_2 = A1_2.tier
  if L6_2 then
    L6_2 = tonumber
    L7_2 = A1_2.tier
    L6_2 = L6_2(L7_2)
    if L6_2 then
      goto lbl_91
    end
  end
  L6_2 = 0
  ::lbl_91::
  A1_2.tier = L6_2
  L6_2 = DeleteHouseObject
  L7_2 = A1_2.name
  L6_2(L7_2)
  L6_2 = A1_2.island
  if L6_2 then
    L6_2 = L6_2.enable
  end
  if L6_2 then
    L6_2 = CreateHouseObject
    L7_2 = A0_2
    L8_2 = {}
    L9_2 = A1_2.name
    L8_2.house = L9_2
    L9_2 = A1_2.island
    L9_2 = L9_2.data
    L9_2 = L9_2.coords
    L8_2.coords = L9_2
    L9_2 = A1_2.island
    L9_2 = L9_2.data
    L9_2 = L9_2.model
    L8_2.model = L9_2
    L6_2(L7_2, L8_2)
  end
  L6_2 = A1_2.showOnMap
  if L6_2 then
    L6_2 = L6_2.enable
  end
  if L6_2 then
    L6_2 = CreateHouseObject
    L7_2 = A0_2
    L8_2 = {}
    L9_2 = A1_2.name
    L8_2.house = L9_2
    L9_2 = A1_2.showOnMap
    L9_2 = L9_2.data
    L9_2 = L9_2.coords
    L8_2.coords = L9_2
    L9_2 = A1_2.showOnMap
    L9_2 = L9_2.data
    L9_2 = L9_2.model
    L8_2.model = L9_2
    L6_2(L7_2, L8_2)
  end
  L6_2 = db
  L6_2 = L6_2.updateHouse
  L7_2 = A0_2
  L8_2 = A1_2
  L6_2(L7_2, L8_2)
  L6_2 = true
  return L6_2
end
L0_1(L1_1, L2_1)
L0_1 = lib
L0_1 = L0_1.callback
L0_1 = L0_1.register
L1_1 = "housing:removeHouse"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = HasPermission
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = Error
    L3_2 = "housing:removeHouse"
    L4_2 = "Player does not have permission to remove house"
    L2_2(L3_2, L4_2)
    L2_2 = false
    return L2_2
  end
  L2_2 = assert
  L3_2 = A1_2
  L4_2 = "housing:removeHouse house is nil"
  L2_2(L3_2, L4_2)
  L2_2 = DeleteHouse
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L3_2 = Error
    L4_2 = "housing:removeHouse"
    L5_2 = "Failed to remove house"
    L6_2 = A1_2
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = false
    return L3_2
  end
  L3_2 = Notification
  L4_2 = A0_2
  L5_2 = i18n
  L5_2 = L5_2.t
  L6_2 = "house_deleted"
  L5_2 = L5_2(L6_2)
  L6_2 = "success"
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = true
  return L3_2
end
L0_1(L1_1, L2_1)
L0_1 = lib
L0_1 = L0_1.callback
L0_1 = L0_1.register
L1_1 = "housing:createFurnitureShop"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = HasPermission
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = Error
    L3_2 = "housing:createFurnitureShop"
    L4_2 = "Player does not have permission"
    L2_2(L3_2, L4_2)
    L2_2 = false
    return L2_2
  end
  L2_2 = assert
  L3_2 = A1_2
  L4_2 = "housing:createFurnitureShop data is nil"
  L2_2(L3_2, L4_2)
  L2_2 = assert
  L3_2 = A1_2.name
  L4_2 = "housing:createFurnitureShop data.name is nil"
  L2_2(L3_2, L4_2)
  L2_2 = db
  L2_2 = L2_2.createFurnitureShop
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L3_2 = Error
    L4_2 = "housing:createFurnitureShop"
    L5_2 = "Failed to create furniture shop"
    L3_2(L4_2, L5_2)
    L3_2 = false
    return L3_2
  end
  L3_2 = InitFurnitureShops
  L3_2()
  L3_2 = TriggerClientEvent
  L4_2 = "housing:syncFurnitureShops"
  L5_2 = -1
  L6_2 = Config
  L6_2 = L6_2.FurnitureShops
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = Notification
  L4_2 = A0_2
  L5_2 = i18n
  L5_2 = L5_2.t
  L6_2 = "creator.furniture_shop_created"
  L5_2 = L5_2(L6_2)
  L6_2 = "success"
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = Debug
  L4_2 = "housing:createFurnitureShop"
  L5_2 = "Created"
  L6_2 = A1_2.name
  L7_2 = "ID"
  L8_2 = L2_2
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = true
  return L3_2
end
L0_1(L1_1, L2_1)
L0_1 = lib
L0_1 = L0_1.callback
L0_1 = L0_1.register
L1_1 = "housing:updateFurnitureShop"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = HasPermission
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = Error
    L3_2 = "housing:updateFurnitureShop"
    L4_2 = "Player does not have permission"
    L2_2(L3_2, L4_2)
    L2_2 = false
    return L2_2
  end
  L2_2 = assert
  L3_2 = A1_2
  L4_2 = "housing:updateFurnitureShop data is nil"
  L2_2(L3_2, L4_2)
  L2_2 = assert
  L3_2 = A1_2.id
  L4_2 = "housing:updateFurnitureShop data.id is nil"
  L2_2(L3_2, L4_2)
  L2_2 = db
  L2_2 = L2_2.updateFurnitureShop
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L3_2 = Error
    L4_2 = "housing:updateFurnitureShop"
    L5_2 = "Failed to update furniture shop"
    L3_2(L4_2, L5_2)
    L3_2 = false
    return L3_2
  end
  L3_2 = InitFurnitureShops
  L3_2()
  L3_2 = TriggerClientEvent
  L4_2 = "housing:syncFurnitureShops"
  L5_2 = -1
  L6_2 = Config
  L6_2 = L6_2.FurnitureShops
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = Notification
  L4_2 = A0_2
  L5_2 = i18n
  L5_2 = L5_2.t
  L6_2 = "creator.furniture_shop_updated"
  L5_2 = L5_2(L6_2)
  L6_2 = "success"
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = Debug
  L4_2 = "housing:updateFurnitureShop"
  L5_2 = "Updated"
  L6_2 = A1_2.id
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = true
  return L3_2
end
L0_1(L1_1, L2_1)
L0_1 = lib
L0_1 = L0_1.callback
L0_1 = L0_1.register
L1_1 = "housing:removeFurnitureShop"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = HasPermission
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = Error
    L3_2 = "housing:removeFurnitureShop"
    L4_2 = "Player does not have permission"
    L2_2(L3_2, L4_2)
    L2_2 = false
    return L2_2
  end
  L2_2 = assert
  L3_2 = A1_2
  L4_2 = "housing:removeFurnitureShop id is nil"
  L2_2(L3_2, L4_2)
  L2_2 = db
  L2_2 = L2_2.removeFurnitureShop
  L3_2 = A1_2
  L4_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L3_2 = Error
    L4_2 = "housing:removeFurnitureShop"
    L5_2 = "Failed to remove furniture shop"
    L3_2(L4_2, L5_2)
    L3_2 = false
    return L3_2
  end
  L3_2 = InitFurnitureShops
  L3_2()
  L3_2 = TriggerClientEvent
  L4_2 = "housing:syncFurnitureShops"
  L5_2 = -1
  L6_2 = Config
  L6_2 = L6_2.FurnitureShops
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = Notification
  L4_2 = A0_2
  L5_2 = i18n
  L5_2 = L5_2.t
  L6_2 = "creator.furniture_shop_deleted"
  L5_2 = L5_2(L6_2)
  L6_2 = "success"
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = Debug
  L4_2 = "housing:removeFurnitureShop"
  L5_2 = "Removed"
  L6_2 = A1_2
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = true
  return L3_2
end
L0_1(L1_1, L2_1)
L0_1 = lib
L0_1 = L0_1.callback
L0_1 = L0_1.register
L1_1 = "housing:removeHouseOwner"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = HasPermission
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = Error
    L3_2 = "housing:removeHouseOwner"
    L4_2 = "Player does not have permission to remove house owner"
    L2_2(L3_2, L4_2)
    L2_2 = false
    return L2_2
  end
  L2_2 = assert
  L3_2 = A1_2
  L4_2 = "housing:removeHouseOwner house is nil"
  L2_2(L3_2, L4_2)
  L2_2 = HouseOwnerIdentifierList
  L2_2 = L2_2[A1_2]
  if not L2_2 then
    L2_2 = Notification
    L3_2 = A0_2
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "creator.house_has_no_owner"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = false
    return L2_2
  end
  L2_2 = MySQL
  L2_2 = L2_2.Sync
  L2_2 = L2_2.execute
  L3_2 = "DELETE FROM player_houses WHERE house = ?"
  L4_2 = {}
  L5_2 = A1_2
  L4_2[1] = L5_2
  L2_2(L3_2, L4_2)
  L2_2 = HouseOwnerCitizenidList
  L2_2[A1_2] = nil
  L2_2 = HouseOwnerIdentifierList
  L2_2[A1_2] = nil
  L2_2 = OfficialHouseOwnerList
  L2_2[A1_2] = nil
  L2_2 = HouseKeyholdersList
  L2_2[A1_2] = nil
  L2_2 = TriggerClientEvent
  L3_2 = "qb-houses:requiredLeaveHouse"
  L4_2 = -1
  L5_2 = A1_2
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = InitHouse
  L3_2 = A1_2
  L2_2(L3_2)
  L2_2 = Notification
  L3_2 = A0_2
  L4_2 = i18n
  L4_2 = L4_2.t
  L5_2 = "creator.owner_removed"
  L4_2 = L4_2(L5_2)
  L5_2 = "success"
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = true
  return L2_2
end
L0_1(L1_1, L2_1)






