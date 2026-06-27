





local L0_1, L1_1
L0_1 = db
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L0_2 = MySQL
  L0_2 = L0_2.query
  L0_2 = L0_2.await
  L1_2 = "SELECT * FROM qs_housing_furniture_shops ORDER BY id"
  L0_2 = L0_2(L1_2)
  if not L0_2 then
    L1_2 = {}
    return L1_2
  end
  L1_2 = {}
  L2_2 = ipairs
  L3_2 = L0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = json
    L8_2 = L8_2.decode
    L9_2 = L7_2.enter
    L8_2 = L8_2(L9_2)
    L9_2 = L7_2.blip
    if L9_2 then
      L9_2 = json
      L9_2 = L9_2.decode
      L10_2 = L7_2.blip
      L9_2 = L9_2(L10_2)
      if L9_2 then
        goto lbl_31
      end
    end
    L9_2 = nil
    ::lbl_31::
    L10_2 = L7_2.categories
    if L10_2 then
      L10_2 = json
      L10_2 = L10_2.decode
      L11_2 = L7_2.categories
      L10_2 = L10_2(L11_2)
      if L10_2 then
        goto lbl_41
      end
    end
    L10_2 = "all"
    ::lbl_41::
    L11_2 = #L1_2
    L11_2 = L11_2 + 1
    L12_2 = {}
    L13_2 = L7_2.id
    L12_2.id = L13_2
    L13_2 = L7_2.name
    L12_2.name = L13_2
    L13_2 = vec3
    L14_2 = L8_2.x
    L15_2 = L8_2.y
    L16_2 = L8_2.z
    L13_2 = L13_2(L14_2, L15_2, L16_2)
    L12_2.enter = L13_2
    L12_2.blip = L9_2
    L12_2.categories = L10_2
    L13_2 = L7_2.creator
    L12_2.creator = L13_2
    L1_2[L11_2] = L12_2
  end
  L2_2 = Debug
  L3_2 = "db.getFurnitureShops"
  L4_2 = "Loaded"
  L5_2 = #L1_2
  L6_2 = "shops"
  L2_2(L3_2, L4_2, L5_2, L6_2)
  return L1_2
end
L0_1.getFurnitureShops = L1_1
L0_1 = db
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = pairs
  L2_2 = A0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = L6_2.categories
    if "all" == L7_2 then
      L7_2 = A0_2[L5_2]
      L8_2 = {}
      L7_2.categories = L8_2
      L7_2 = pairs
      L8_2 = Config
      L8_2 = L8_2.Furniture
      L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
      for L11_2 in L7_2, L8_2, L9_2, L10_2 do
        if "navigation" ~= L11_2 then
          L12_2 = A0_2[L5_2]
          L12_2 = L12_2.categories
          L13_2 = A0_2[L5_2]
          L13_2 = L13_2.categories
          L13_2 = #L13_2
          L13_2 = L13_2 + 1
          L12_2[L13_2] = L11_2
        end
      end
    end
  end
  return A0_2
end
L0_1.expandFurnitureShopCategories = L1_1
L0_1 = db
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L2_2 = assert
  L3_2 = A1_2
  L4_2 = "db.createFurnitureShop data must be provided"
  L2_2(L3_2, L4_2)
  L2_2 = assert
  L3_2 = A1_2.name
  L4_2 = "db.createFurnitureShop name is required"
  L2_2(L3_2, L4_2)
  L2_2 = assert
  L3_2 = A1_2.enter
  L4_2 = "db.createFurnitureShop enter is required"
  L2_2(L3_2, L4_2)
  L2_2 = GetIdentifier
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = assert
  L4_2 = L2_2
  L5_2 = "db.createFurnitureShop identifier is nil"
  L3_2(L4_2, L5_2)
  L3_2 = [[
        INSERT INTO qs_housing_furniture_shops
        (`name`, `enter`, `blip`, `categories`, `creator`)
        VALUES (?, ?, ?, ?, ?)
    ]]
  L4_2 = A1_2.categories
  L5_2 = type
  L6_2 = L4_2
  L5_2 = L5_2(L6_2)
  if "table" == L5_2 then
    L5_2 = json
    L5_2 = L5_2.encode
    L6_2 = L4_2
    L5_2 = L5_2(L6_2)
    L4_2 = L5_2
  elseif "all" == L4_2 then
    L5_2 = json
    L5_2 = L5_2.encode
    L6_2 = "all"
    L5_2 = L5_2(L6_2)
    L4_2 = L5_2
  else
    L5_2 = json
    L5_2 = L5_2.encode
    L6_2 = "all"
    L5_2 = L5_2(L6_2)
    L4_2 = L5_2
  end
  L5_2 = MySQL
  L5_2 = L5_2.insert
  L5_2 = L5_2.await
  L6_2 = L3_2
  L7_2 = {}
  L8_2 = A1_2.name
  L9_2 = json
  L9_2 = L9_2.encode
  L10_2 = A1_2.enter
  L9_2 = L9_2(L10_2)
  L10_2 = A1_2.blip
  if L10_2 then
    L10_2 = json
    L10_2 = L10_2.encode
    L11_2 = A1_2.blip
    L10_2 = L10_2(L11_2)
    if L10_2 then
      goto lbl_67
    end
  end
  L10_2 = nil
  ::lbl_67::
  L11_2 = L4_2
  L12_2 = L2_2
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L7_2[3] = L10_2
  L7_2[4] = L11_2
  L7_2[5] = L12_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = Debug
  L7_2 = "db.createFurnitureShop"
  L8_2 = "Inserted"
  L9_2 = L5_2
  L10_2 = "Name"
  L11_2 = A1_2.name
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  return L5_2
end
L0_1.createFurnitureShop = L1_1
L0_1 = db
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L2_2 = assert
  L3_2 = A1_2
  L4_2 = "db.updateFurnitureShop data must be provided"
  L2_2(L3_2, L4_2)
  L2_2 = assert
  L3_2 = A1_2.id
  L4_2 = "db.updateFurnitureShop id is required"
  L2_2(L3_2, L4_2)
  L2_2 = GetIdentifier
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = assert
  L4_2 = L2_2
  L5_2 = "db.updateFurnitureShop identifier is nil"
  L3_2(L4_2, L5_2)
  L3_2 = A1_2.categories
  L4_2 = type
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  if "table" == L4_2 then
    L4_2 = json
    L4_2 = L4_2.encode
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    L3_2 = L4_2
  elseif "all" == L3_2 then
    L4_2 = json
    L4_2 = L4_2.encode
    L5_2 = "all"
    L4_2 = L4_2(L5_2)
    L3_2 = L4_2
  else
    L4_2 = json
    L4_2 = L4_2.encode
    L5_2 = "all"
    L4_2 = L4_2(L5_2)
    L3_2 = L4_2
  end
  L4_2 = [[
        UPDATE qs_housing_furniture_shops
        SET `name` = ?, `enter` = ?, `blip` = ?, `categories` = ?
        WHERE `id` = ?
    ]]
  L5_2 = MySQL
  L5_2 = L5_2.update
  L5_2 = L5_2.await
  L6_2 = L4_2
  L7_2 = {}
  L8_2 = A1_2.name
  L9_2 = json
  L9_2 = L9_2.encode
  L10_2 = A1_2.enter
  L9_2 = L9_2(L10_2)
  L10_2 = A1_2.blip
  if L10_2 then
    L10_2 = json
    L10_2 = L10_2.encode
    L11_2 = A1_2.blip
    L10_2 = L10_2(L11_2)
    if L10_2 then
      goto lbl_63
    end
  end
  L10_2 = nil
  ::lbl_63::
  L11_2 = L3_2
  L12_2 = A1_2.id
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L7_2[3] = L10_2
  L7_2[4] = L11_2
  L7_2[5] = L12_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = Debug
  L7_2 = "db.updateFurnitureShop"
  L8_2 = "Updated"
  L9_2 = L5_2
  L10_2 = "ID"
  L11_2 = A1_2.id
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  L6_2 = L5_2 > 0
  return L6_2
end
L0_1.updateFurnitureShop = L1_1
L0_1 = db
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = assert
  L3_2 = A0_2
  L4_2 = "db.removeFurnitureShop id is nil"
  L2_2(L3_2, L4_2)
  L2_2 = GetIdentifier
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  L3_2 = assert
  L4_2 = L2_2
  L5_2 = "db.removeFurnitureShop identifier is nil"
  L3_2(L4_2, L5_2)
  L3_2 = MySQL
  L3_2 = L3_2.update
  L3_2 = L3_2.await
  L4_2 = "DELETE FROM qs_housing_furniture_shops WHERE id = ?"
  L5_2 = {}
  L6_2 = A0_2
  L5_2[1] = L6_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = Debug
  L5_2 = "db.removeFurnitureShop"
  L6_2 = "Deleted"
  L7_2 = L3_2
  L8_2 = "ID"
  L9_2 = A0_2
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = L3_2 > 0
  return L4_2
end
L0_1.removeFurnitureShop = L1_1






