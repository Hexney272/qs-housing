





local L0_1, L1_1, L2_1, L3_1
L0_1 = {}
L0_1.INSERT_OBJECT = [[
        INSERT INTO house_decorations (creator, house, modelName, coords, rotation, inStash, inHouse, created, uniq, lightData, wallartData, price)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ]]
L0_1.DELETE_OBJECT = [[
        DELETE FROM house_decorations WHERE id = ?
    ]]
L0_1.SELECT_OBJECTS = [[
        SELECT * FROM house_decorations WHERE house = ?
    ]]
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = math
  L0_2 = L0_2.random
  L1_2 = 100000
  L2_2 = 999999
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = "decor_%s_%s_%s"
  L2_2 = L1_2
  L1_2 = L1_2.format
  L3_2 = os
  L3_2 = L3_2.time
  L3_2 = L3_2()
  L4_2 = GetGameTimer
  L4_2 = L4_2()
  L5_2 = L0_2
  return L1_2(L2_2, L3_2, L4_2, L5_2)
end
L2_1 = db
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L2_2 = A1_2.uniq
  if not L2_2 then
    L2_2 = L1_1
    L2_2 = L2_2()
  end
  A1_2.uniq = L2_2
  L3_2 = A1_2.lightData
  if L3_2 then
    L3_2 = json
    L3_2 = L3_2.encode
    L4_2 = A1_2.lightData
    L3_2 = L3_2(L4_2)
    if L3_2 then
      goto lbl_21
    end
  end
  L3_2 = json
  L3_2 = L3_2.encode
  L4_2 = {}
  L3_2 = L3_2(L4_2)
  ::lbl_21::
  L4_2 = A1_2.wallartData
  if L4_2 then
    L4_2 = json
    L4_2 = L4_2.encode
    L5_2 = A1_2.wallartData
    L4_2 = L4_2(L5_2)
    if L4_2 then
      goto lbl_35
    end
  end
  L4_2 = json
  L4_2 = L4_2.encode
  L5_2 = {}
  L4_2 = L4_2(L5_2)
  ::lbl_35::
  L5_2 = MySQL
  L5_2 = L5_2.insert
  L5_2 = L5_2.await
  L6_2 = L0_1.INSERT_OBJECT
  L7_2 = {}
  L8_2 = A0_2
  L9_2 = A1_2.house
  L10_2 = A1_2.modelName
  L11_2 = json
  L11_2 = L11_2.encode
  L12_2 = A1_2.coords
  L11_2 = L11_2(L12_2)
  L12_2 = json
  L12_2 = L12_2.encode
  L13_2 = A1_2.rotation
  L12_2 = L12_2(L13_2)
  L13_2 = A1_2.inStash
  if L13_2 then
    L13_2 = 1
    if L13_2 then
      goto lbl_59
    end
  end
  L13_2 = 0
  ::lbl_59::
  L14_2 = A1_2.inHouse
  if L14_2 then
    L14_2 = 1
    if L14_2 then
      goto lbl_66
    end
  end
  L14_2 = 0
  ::lbl_66::
  L15_2 = os
  L15_2 = L15_2.date
  L16_2 = "%Y-%m-%d %H:%M:%S"
  L15_2 = L15_2(L16_2)
  L16_2 = L2_2
  L17_2 = L3_2
  L18_2 = L4_2
  L19_2 = A1_2.price
  if not L19_2 then
    L19_2 = 0
  end
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
  L7_2 = "db.saveObject"
  L8_2 = "Saved"
  L9_2 = A1_2.insideId
  L10_2 = "Id"
  L11_2 = L5_2
  L12_2 = "Data"
  L13_2 = A1_2
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  return L5_2
end
L2_1.saveObject = L3_1
L2_1 = db
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  L2_2 = #A1_2
  if 0 == L2_2 then
    L3_2 = {}
    return L3_2
  end
  L3_2 = os
  L3_2 = L3_2.date
  L4_2 = "%Y-%m-%d %H:%M:%S"
  L3_2 = L3_2(L4_2)
  L4_2 = {}
  L5_2 = {}
  L6_2 = 1
  L7_2 = L2_2
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = A1_2[L9_2]
    L11_2 = L10_2.uniq
    if not L11_2 then
      L11_2 = L1_1
      L11_2 = L11_2()
    end
    L10_2.uniq = L11_2
    L12_2 = L10_2.lightData
    if L12_2 then
      L12_2 = json
      L12_2 = L12_2.encode
      L13_2 = L10_2.lightData
      L12_2 = L12_2(L13_2)
      if L12_2 then
        goto lbl_40
      end
    end
    L12_2 = json
    L12_2 = L12_2.encode
    L13_2 = {}
    L12_2 = L12_2(L13_2)
    ::lbl_40::
    L13_2 = L10_2.wallartData
    if L13_2 then
      L13_2 = json
      L13_2 = L13_2.encode
      L14_2 = L10_2.wallartData
      L13_2 = L13_2(L14_2)
      if L13_2 then
        goto lbl_54
      end
    end
    L13_2 = json
    L13_2 = L13_2.encode
    L14_2 = {}
    L13_2 = L13_2(L14_2)
    ::lbl_54::
    L14_2 = {}
    L15_2 = A0_2
    L16_2 = L10_2.house
    L17_2 = L10_2.modelName
    L18_2 = json
    L18_2 = L18_2.encode
    L19_2 = L10_2.coords
    L18_2 = L18_2(L19_2)
    L19_2 = json
    L19_2 = L19_2.encode
    L20_2 = L10_2.rotation
    L19_2 = L19_2(L20_2)
    L20_2 = L10_2.inStash
    if L20_2 then
      L20_2 = 1
      if L20_2 then
        goto lbl_74
      end
    end
    L20_2 = 0
    ::lbl_74::
    L21_2 = L10_2.inHouse
    if L21_2 then
      L21_2 = 1
      if L21_2 then
        goto lbl_81
      end
    end
    L21_2 = 0
    ::lbl_81::
    L22_2 = L3_2
    L23_2 = L11_2
    L24_2 = L12_2
    L25_2 = L13_2
    L26_2 = L10_2.price
    if not L26_2 then
      L26_2 = 0
    end
    L14_2[1] = L15_2
    L14_2[2] = L16_2
    L14_2[3] = L17_2
    L14_2[4] = L18_2
    L14_2[5] = L19_2
    L14_2[6] = L20_2
    L14_2[7] = L21_2
    L14_2[8] = L22_2
    L14_2[9] = L23_2
    L14_2[10] = L24_2
    L14_2[11] = L25_2
    L14_2[12] = L26_2
    L15_2 = 1
    L16_2 = #L14_2
    L17_2 = 1
    for L18_2 = L15_2, L16_2, L17_2 do
      L19_2 = #L4_2
      L19_2 = L19_2 + 1
      L20_2 = L14_2[L18_2]
      L4_2[L19_2] = L20_2
    end
    L5_2[L9_2] = "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
  end
  L6_2 = [[
        INSERT INTO house_decorations (creator, house, modelName, coords, rotation, inStash, inHouse, created, uniq, lightData, wallartData, price)
        VALUES %s
    ]]
  L8_2 = L6_2
  L7_2 = L6_2.format
  L9_2 = table
  L9_2 = L9_2.concat
  L10_2 = L5_2
  L11_2 = ", "
  L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L9_2(L10_2, L11_2)
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
  L6_2 = L7_2
  L7_2 = MySQL
  L7_2 = L7_2.insert
  L7_2 = L7_2.await
  L8_2 = L6_2
  L9_2 = L4_2
  L7_2 = L7_2(L8_2, L9_2)
  if not L7_2 then
    L8_2 = {}
    return L8_2
  end
  return A1_2
end
L2_1.saveObjectsBatch = L3_1
L2_1 = db
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = MySQL
  L1_2 = L1_2.query
  L1_2 = L1_2.await
  L2_2 = L0_1.SELECT_OBJECTS
  L3_2 = {}
  L4_2 = A0_2
  L3_2[1] = L4_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = 1
  L3_2 = #L1_2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = L1_2[L5_2]
    L7_2 = json
    L7_2 = L7_2.decode
    L8_2 = L1_2[L5_2]
    L8_2 = L8_2.coords
    L7_2 = L7_2(L8_2)
    L6_2.coords = L7_2
    L6_2 = L1_2[L5_2]
    L7_2 = json
    L7_2 = L7_2.decode
    L8_2 = L1_2[L5_2]
    L8_2 = L8_2.rotation
    L7_2 = L7_2(L8_2)
    L6_2.rotation = L7_2
    L6_2 = L1_2[L5_2]
    L7_2 = os
    L7_2 = L7_2.time
    L8_2 = os
    L8_2 = L8_2.date
    L9_2 = "*t"
    L10_2 = math
    L10_2 = L10_2.floor
    L11_2 = L1_2[L5_2]
    L11_2 = L11_2.created
    L11_2 = L11_2 / 1000
    L10_2, L11_2 = L10_2(L11_2)
    L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2, L10_2, L11_2)
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
    L6_2.created = L7_2
    L6_2 = L1_2[L5_2]
    L7_2 = L1_2[L5_2]
    L7_2 = L7_2.uniq
    if not L7_2 then
      L7_2 = tostring
      L8_2 = "house_"
      L9_2 = L1_2[L5_2]
      L9_2 = L9_2.id
      L8_2 = L8_2 .. L9_2
      L7_2 = L7_2(L8_2)
    end
    L6_2.uniq = L7_2
    L6_2 = L1_2[L5_2]
    L7_2 = L1_2[L5_2]
    L7_2 = L7_2.lightData
    if L7_2 then
      L7_2 = json
      L7_2 = L7_2.decode
      L8_2 = L1_2[L5_2]
      L8_2 = L8_2.lightData
      L7_2 = L7_2(L8_2)
    end
    L6_2.lightData = L7_2
    L6_2 = L1_2[L5_2]
    L7_2 = L1_2[L5_2]
    L7_2 = L7_2.wallartData
    if L7_2 then
      L7_2 = json
      L7_2 = L7_2.decode
      L8_2 = L1_2[L5_2]
      L8_2 = L8_2.wallartData
      L7_2 = L7_2(L8_2)
      if L7_2 then
        goto lbl_80
      end
    end
    L7_2 = nil
    ::lbl_80::
    L6_2.wallartData = L7_2
  end
  return L1_2
end
L2_1.getObjects = L3_1
L2_1 = db
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  if not A1_2 then
    L2_2 = Debug
    L3_2 = "db.updateObject"
    L4_2 = "No data to update"
    L2_2(L3_2, L4_2)
    L2_2 = false
    return L2_2
  end
  L2_2 = Debug
  L3_2 = "db.updateObject"
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
  L2_2 = "UPDATE house_decorations SET"
  L3_2 = {}
  L4_2 = pairs
  L5_2 = A1_2
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = L2_2
    L11_2 = " `%s` = :%s,"
    L12_2 = L11_2
    L11_2 = L11_2.format
    L13_2 = L8_2
    L14_2 = L8_2
    L11_2 = L11_2(L12_2, L13_2, L14_2)
    L10_2 = L10_2 .. L11_2
    L2_2 = L10_2
    if false == L9_2 and "inStash" ~= L8_2 and "inHouse" ~= L8_2 then
      L9_2 = nil
      L10_2 = Debug
      L11_2 = "db.updateObject"
      L12_2 = "Set"
      L13_2 = L8_2
      L14_2 = "to nil because of false"
      L10_2(L11_2, L12_2, L13_2, L14_2)
    end
    if "wallartData" == L8_2 then
      L10_2 = type
      L11_2 = L9_2
      L10_2 = L10_2(L11_2)
      if "table" == L10_2 then
        L10_2 = json
        L10_2 = L10_2.encode
        L11_2 = L9_2
        L10_2 = L10_2(L11_2)
        L9_2 = L10_2
      end
    end
    L3_2[L8_2] = L9_2
  end
  L5_2 = L2_2
  L4_2 = L2_2.sub
  L6_2 = 1
  L7_2 = -2
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L2_2 = L4_2
  L4_2 = L2_2
  L5_2 = " WHERE id = :id"
  L4_2 = L4_2 .. L5_2
  L2_2 = L4_2
  L3_2.id = A0_2
  L4_2 = Debug
  L5_2 = "params"
  L6_2 = L3_2
  L4_2(L5_2, L6_2)
  L4_2 = MySQL
  L4_2 = L4_2.update
  L4_2 = L4_2.await
  L5_2 = L2_2
  L6_2 = L3_2
  return L4_2(L5_2, L6_2)
end
L2_1.updateObject = L3_1
L2_1 = db
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = MySQL
  L1_2 = L1_2.prepare
  L2_2 = L0_1.DELETE_OBJECT
  L3_2 = {}
  L4_2 = A0_2
  L3_2[1] = L4_2
  L1_2(L2_2, L3_2)
  L1_2 = true
  return L1_2
end
L2_1.deleteObject = L3_1
L2_1 = db
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = Debug
  L2_2 = "db.deleteAllObjects"
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
  L1_2 = ClearHouseDecoration
  L2_2 = A0_2
  L1_2(L2_2)
  L1_2 = MySQL
  L1_2 = L1_2.prepare
  L1_2 = L1_2.await
  L2_2 = "DELETE FROM house_decorations WHERE house = ?"
  L3_2 = {}
  L4_2 = A0_2
  L3_2[1] = L4_2
  L1_2(L2_2, L3_2)
  L1_2 = true
  return L1_2
end
L2_1.deleteAllObjects = L3_1
L2_1 = db
function L3_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2
  L0_2 = {}
  L1_2 = MySQL
  L1_2 = L1_2.query
  L1_2 = L1_2.await
  L2_2 = "SELECT decorations, house, owner FROM player_houses"
  L1_2 = L1_2(L2_2)
  L2_2 = Debug
  L3_2 = "houseDecorations"
  L4_2 = L1_2
  L2_2(L3_2, L4_2)
  L2_2 = pairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = L7_2.decorations
    if not L8_2 then
      L8_2 = Warning
      L9_2 = "db.revertDecorations"
      L10_2 = "No decorations found for house we are going to skip it"
      L11_2 = L7_2.house
      L8_2(L9_2, L10_2, L11_2)
    else
      L8_2 = json
      L8_2 = L8_2.decode
      L9_2 = L7_2.decorations
      L8_2 = L8_2(L9_2)
      if not L8_2 then
        L9_2 = Debug
        L10_2 = "db.revertDecorations"
        L11_2 = "No decorations found for house we are going to skip it"
        L12_2 = L7_2.house
        L9_2(L10_2, L11_2, L12_2)
      else
        L9_2 = pairs
        L10_2 = L8_2
        L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
        for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
          L15_2 = table
          L15_2 = L15_2.insert
          L16_2 = L0_2
          L17_2 = {}
          L18_2 = L0_1.INSERT_OBJECT
          L17_2.query = L18_2
          L18_2 = {}
          L19_2 = L7_2.owner
          L20_2 = L7_2.house
          L21_2 = L14_2.hashname
          L22_2 = json
          L22_2 = L22_2.encode
          L23_2 = {}
          L24_2 = L14_2.x
          L23_2.x = L24_2
          L24_2 = L14_2.y
          L23_2.y = L24_2
          L24_2 = L14_2.z
          L23_2.z = L24_2
          L22_2 = L22_2(L23_2)
          L23_2 = json
          L23_2 = L23_2.encode
          L24_2 = {}
          L25_2 = L14_2.rotx
          L24_2.x = L25_2
          L25_2 = L14_2.roty
          L24_2.y = L25_2
          L25_2 = L14_2.rotz
          L24_2.z = L25_2
          L23_2 = L23_2(L24_2)
          L24_2 = L14_2.inStash
          if L24_2 then
            L24_2 = 1
            if L24_2 then
              goto lbl_82
            end
          end
          L24_2 = 0
          ::lbl_82::
          L25_2 = L14_2.inHouse
          if L25_2 then
            L25_2 = 1
            if L25_2 then
              goto lbl_89
            end
          end
          L25_2 = 0
          ::lbl_89::
          L26_2 = os
          L26_2 = L26_2.date
          L27_2 = "%Y-%m-%d %H:%M:%S"
          L26_2 = L26_2(L27_2)
          L27_2 = L14_2.uniq
          L28_2 = json
          L28_2 = L28_2.encode
          L29_2 = L14_2.lightData
          if not L29_2 then
            L29_2 = {}
          end
          L28_2 = L28_2(L29_2)
          L29_2 = json
          L29_2 = L29_2.encode
          L30_2 = {}
          L29_2 = L29_2(L30_2)
          L30_2 = 0
          L18_2[1] = L19_2
          L18_2[2] = L20_2
          L18_2[3] = L21_2
          L18_2[4] = L22_2
          L18_2[5] = L23_2
          L18_2[6] = L24_2
          L18_2[7] = L25_2
          L18_2[8] = L26_2
          L18_2[9] = L27_2
          L18_2[10] = L28_2
          L18_2[11] = L29_2
          L18_2[12] = L30_2
          L17_2.values = L18_2
          L15_2(L16_2, L17_2)
        end
      end
    end
  end
  L2_2 = MySQL
  L2_2 = L2_2.Sync
  L2_2 = L2_2.transaction
  L3_2 = L0_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L3_2 = Debug
    L4_2 = "db.revertDecorations"
    L5_2 = "Success"
    L3_2(L4_2, L5_2)
  else
    L3_2 = Debug
    L4_2 = "db.revertDecorations"
    L5_2 = "Failed"
    L3_2(L4_2, L5_2)
  end
  L3_2 = MySQL
  L3_2 = L3_2.query
  L4_2 = "ALTER TABLE player_houses DROP COLUMN decorations"
  L3_2(L4_2)
  L3_2 = LoopError
  L4_2 = "We drop the decorations column on your sql. Restart the script! Decorations have been reverted!"
  L3_2(L4_2)
end
L2_1.revertDecorations = L3_1
L2_1 = CreateThread
function L3_1()
  local L0_2, L1_2, L2_2
  L0_2 = MySQL
  L0_2 = L0_2.scalar
  L0_2 = L0_2.await
  L1_2 = [[
        SELECT COUNT(*)
        FROM information_schema.COLUMNS
        WHERE TABLE_SCHEMA = DATABASE()
          AND TABLE_NAME = 'house_decorations'
          AND COLUMN_NAME = 'wallartData'
    ]]
  L0_2 = L0_2(L1_2)
  if L0_2 and L0_2 > 0 then
    return
  end
  L1_2 = MySQL
  L1_2 = L1_2.query
  L1_2 = L1_2.await
  L2_2 = "ALTER TABLE house_decorations ADD COLUMN wallartData LONGTEXT NULL"
  L1_2(L2_2)
end
L2_1(L3_1)






