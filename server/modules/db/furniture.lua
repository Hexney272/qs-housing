





local L0_1, L1_1
L0_1 = db
function L1_1()
  local L0_2, L1_2
  L0_2 = MySQL
  L0_2 = L0_2.query
  L0_2 = L0_2.await
  L1_2 = "SELECT * FROM qs_housing_furnitures ORDER BY category_key, label"
  L0_2 = L0_2(L1_2)
  L1_2 = L0_2 or L1_2
  if not L0_2 then
    L1_2 = {}
  end
  return L1_2
end
L0_1.getFurnitureItems = L1_1
L0_1 = db
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = MySQL
  L1_2 = L1_2.query
  L1_2 = L1_2.await
  L2_2 = "SELECT * FROM qs_housing_furnitures WHERE category_key = ? ORDER BY label"
  L3_2 = {}
  L4_2 = A0_2
  L3_2[1] = L4_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = L1_2 or L2_2
  if not L1_2 then
    L2_2 = {}
  end
  return L2_2
end
L0_1.getFurnitureItemsByCategory = L1_1
L0_1 = db
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L2_2 = assert
  L3_2 = A1_2
  L4_2 = "db.createFurnitureItem data must be provided"
  L2_2(L3_2, L4_2)
  L2_2 = assert
  L3_2 = A1_2.category
  L4_2 = "db.createFurnitureItem category is required"
  L2_2(L3_2, L4_2)
  L2_2 = assert
  L3_2 = A1_2.item
  L4_2 = "db.createFurnitureItem item is required"
  L2_2(L3_2, L4_2)
  L2_2 = GetIdentifier
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = assert
  L4_2 = L2_2
  L5_2 = "db.createFurnitureItem identifier is nil"
  L3_2(L4_2, L5_2)
  L3_2 = A1_2.item
  L4_2 = [[
        INSERT INTO qs_housing_furnitures
        (`creator`, `category_key`, `object`, `label`, `description`, `price`, `img`, `colorlabel`, `type`, `stash`, `offset`, `colors`)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ]]
  L5_2 = L3_2.offset
  if not L5_2 then
    L5_2 = {}
    L5_2.x = 0.0
    L5_2.y = 0.0
    L5_2.z = 0.0
  end
  L3_2.offset = L5_2
  L5_2 = MySQL
  L5_2 = L5_2.insert
  L5_2 = L5_2.await
  L6_2 = L4_2
  L7_2 = {}
  L8_2 = L2_2
  L9_2 = A1_2.category
  L10_2 = L3_2.object
  L11_2 = L3_2.label
  L12_2 = L3_2.description
  if not L12_2 then
    L12_2 = ""
  end
  L13_2 = L3_2.price
  if not L13_2 then
    L13_2 = 0
  end
  L14_2 = L3_2.img
  if not L14_2 then
    L14_2 = ""
  end
  L15_2 = L3_2.colorlabel
  if not L15_2 then
    L15_2 = ""
  end
  L16_2 = L3_2.type
  L17_2 = L3_2.stash
  if L17_2 then
    L17_2 = json
    L17_2 = L17_2.encode
    L18_2 = L3_2.stash
    L17_2 = L17_2(L18_2)
    if L17_2 then
      goto lbl_68
    end
  end
  L17_2 = nil
  ::lbl_68::
  L18_2 = json
  L18_2 = L18_2.encode
  L19_2 = L3_2.offset
  L18_2 = L18_2(L19_2)
  L19_2 = L3_2.colors
  if L19_2 then
    L19_2 = json
    L19_2 = L19_2.encode
    L20_2 = L3_2.colors
    L19_2 = L19_2(L20_2)
    if L19_2 then
      goto lbl_82
    end
  end
  L19_2 = "[]"
  ::lbl_82::
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L7_2[3] = L10_2
  L7_2[4] = L11_2
  L7_2[5] = L12_2
  L7_2[6] = L13_2
  L7_2[7] = L14_2
  L7_2[8] = L15_2
  L7_2[9] = L16_2
  L7_2[10] = L17_2
  L7_2[11] = L18_2
  L7_2[12] = L19_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = Debug
  L7_2 = "db.createFurnitureItem"
  L8_2 = "Inserted"
  L9_2 = L5_2
  L10_2 = "Category"
  L11_2 = A1_2.category
  L12_2 = "Object"
  L13_2 = L3_2.object
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  return L5_2
end
L0_1.createFurnitureItem = L1_1
L0_1 = db
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L2_2 = assert
  L3_2 = A1_2
  L4_2 = "db.updateFurnitureItem data must be provided"
  L2_2(L3_2, L4_2)
  L2_2 = assert
  L3_2 = A1_2.item
  L4_2 = "db.updateFurnitureItem item is required"
  L2_2(L3_2, L4_2)
  L2_2 = assert
  L3_2 = A1_2.item
  L3_2 = L3_2.id
  L4_2 = "db.updateFurnitureItem item.id is required"
  L2_2(L3_2, L4_2)
  L2_2 = GetIdentifier
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = assert
  L4_2 = L2_2
  L5_2 = "db.updateFurnitureItem identifier is nil"
  L3_2(L4_2, L5_2)
  L3_2 = A1_2.item
  L4_2 = [[
        UPDATE qs_housing_furnitures
        SET `category_key` = ?, `object` = ?, `label` = ?, `description` = ?, `price` = ?,
            `img` = ?, `colorlabel` = ?, `type` = ?, `stash` = ?, `offset` = ?, `colors` = ?
        WHERE id = ?
    ]]
  L5_2 = L3_2.offset
  if not L5_2 then
    L5_2 = {}
    L5_2.x = 0.0
    L5_2.y = 0.0
    L5_2.z = 0.0
  end
  L3_2.offset = L5_2
  L5_2 = MySQL
  L5_2 = L5_2.update
  L5_2 = L5_2.await
  L6_2 = L4_2
  L7_2 = {}
  L8_2 = A1_2.category
  L9_2 = L3_2.object
  L10_2 = L3_2.label
  L11_2 = L3_2.description
  if not L11_2 then
    L11_2 = ""
  end
  L12_2 = L3_2.price
  if not L12_2 then
    L12_2 = 0
  end
  L13_2 = L3_2.img
  if not L13_2 then
    L13_2 = ""
  end
  L14_2 = L3_2.colorlabel
  if not L14_2 then
    L14_2 = ""
  end
  L15_2 = L3_2.type
  L16_2 = L3_2.stash
  if L16_2 then
    L16_2 = json
    L16_2 = L16_2.encode
    L17_2 = L3_2.stash
    L16_2 = L16_2(L17_2)
    if L16_2 then
      goto lbl_68
    end
  end
  L16_2 = nil
  ::lbl_68::
  L17_2 = json
  L17_2 = L17_2.encode
  L18_2 = L3_2.offset
  L17_2 = L17_2(L18_2)
  L18_2 = L3_2.colors
  if L18_2 then
    L18_2 = json
    L18_2 = L18_2.encode
    L19_2 = L3_2.colors
    L18_2 = L18_2(L19_2)
    if L18_2 then
      goto lbl_82
    end
  end
  L18_2 = "[]"
  ::lbl_82::
  L19_2 = L3_2.id
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L7_2[3] = L10_2
  L7_2[4] = L11_2
  L7_2[5] = L12_2
  L7_2[6] = L13_2
  L7_2[7] = L14_2
  L7_2[8] = L15_2
  L7_2[9] = L16_2
  L7_2[10] = L17_2
  L7_2[11] = L18_2
  L7_2[12] = L19_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = Debug
  L7_2 = "db.updateFurnitureItem"
  L8_2 = "Updated"
  L9_2 = L5_2
  L10_2 = "ID"
  L11_2 = L3_2.id
  L12_2 = "Object"
  L13_2 = L3_2.object
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L6_2 = L5_2 > 0
  return L6_2
end
L0_1.updateFurnitureItem = L1_1
L0_1 = db
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = assert
  L3_2 = A0_2
  L4_2 = "db.removeFurnitureItem id is nil"
  L2_2(L3_2, L4_2)
  L2_2 = GetIdentifier
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  L3_2 = assert
  L4_2 = L2_2
  L5_2 = "db.removeFurnitureItem identifier is nil"
  L3_2(L4_2, L5_2)
  L3_2 = MySQL
  L3_2 = L3_2.update
  L3_2 = L3_2.await
  L4_2 = "DELETE FROM qs_housing_furnitures WHERE id = ? AND creator = ?"
  L5_2 = {}
  L6_2 = A0_2
  L7_2 = L2_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = Debug
  L5_2 = "db.removeFurnitureItem"
  L6_2 = "Deleted"
  L7_2 = L3_2
  L8_2 = "ID"
  L9_2 = A0_2
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = L3_2 > 0
  return L4_2
end
L0_1.removeFurnitureItem = L1_1
L0_1 = db
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L0_2 = db
  L0_2 = L0_2.getFurnitureItems
  L0_2 = L0_2()
  L1_2 = table
  L1_2 = L1_2.clone
  L2_2 = Config
  L2_2 = L2_2.Furniture
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = {}
  end
  L2_2 = ipairs
  L3_2 = L0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = L7_2.category_key
    L9_2 = L1_2[L8_2]
    if not L9_2 then
      L9_2 = Error
      L10_2 = "db.getMergedFurnitureData"
      L11_2 = "Category not found"
      L12_2 = L8_2
      L9_2(L10_2, L11_2, L12_2)
    else
      L9_2 = L7_2.stash
      if L9_2 then
        L9_2 = json
        L9_2 = L9_2.decode
        L10_2 = L7_2.stash
        L9_2 = L9_2(L10_2)
        if L9_2 then
          goto lbl_37
        end
      end
      L9_2 = nil
      ::lbl_37::
      L7_2.stash = L9_2
      L9_2 = L7_2.offset
      if L9_2 then
        L9_2 = json
        L9_2 = L9_2.decode
        L10_2 = L7_2.offset
        L9_2 = L9_2(L10_2)
        if L9_2 then
          goto lbl_48
        end
      end
      L9_2 = nil
      ::lbl_48::
      L7_2.offset = L9_2
      L9_2 = L7_2.colors
      if L9_2 then
        L9_2 = json
        L9_2 = L9_2.decode
        L10_2 = L7_2.colors
        L9_2 = L9_2(L10_2)
        if L9_2 then
          goto lbl_59
        end
      end
      L9_2 = nil
      ::lbl_59::
      L7_2.colors = L9_2
      L9_2 = {}
      L10_2 = L7_2.id
      L9_2.id = L10_2
      L10_2 = L7_2.object
      L9_2.object = L10_2
      L10_2 = L7_2.label
      L9_2.label = L10_2
      L10_2 = L7_2.description
      L9_2.description = L10_2
      L10_2 = L7_2.price
      L9_2.price = L10_2
      L10_2 = L7_2.img
      L9_2.img = L10_2
      L10_2 = L7_2.colorlabel
      L9_2.colorlabel = L10_2
      L10_2 = L7_2.type
      L9_2.type = L10_2
      L9_2.key = L8_2
      L9_2.creator = true
      L10_2 = L7_2.stash
      L9_2.stash = L10_2
      L10_2 = L7_2.offset
      L9_2.offset = L10_2
      L10_2 = L7_2.colors
      L9_2.colors = L10_2
      L10_2 = nil
      L11_2 = ipairs
      L12_2 = L1_2[L8_2]
      L12_2 = L12_2.items
      L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2)
      for L15_2, L16_2 in L11_2, L12_2, L13_2, L14_2 do
        L17_2 = L16_2.object
        L18_2 = L9_2.object
        if L17_2 == L18_2 then
          L10_2 = L15_2
          break
        end
      end
      if L10_2 then
        L11_2 = L1_2[L8_2]
        L11_2 = L11_2.items
        L11_2[L10_2] = L9_2
      else
        L11_2 = table
        L11_2 = L11_2.insert
        L12_2 = L1_2[L8_2]
        L12_2 = L12_2.items
        L13_2 = L9_2
        L11_2(L12_2, L13_2)
      end
    end
  end
  return L1_2
end
L0_1.getMergedFurnitureData = L1_1






