





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1
L0_1 = {}
L1_1 = {}
L2_1 = 6
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L1_2 = pairs
  L2_2 = Config
  L2_2 = L2_2.Furniture
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = type
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    if "table" == L7_2 then
      L7_2 = L6_2.items
      if L7_2 then
        L7_2 = pairs
        L8_2 = L6_2.items
        L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
        for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
          L13_2 = L12_2.object
          if L13_2 == A0_2 then
            return L12_2
          end
          L13_2 = L12_2.colors
          if L13_2 then
            L13_2 = pairs
            L14_2 = L12_2.colors
            L13_2, L14_2, L15_2, L16_2 = L13_2(L14_2)
            for L17_2, L18_2 in L13_2, L14_2, L15_2, L16_2 do
              L19_2 = L18_2.object
              if L19_2 == A0_2 then
                return L18_2
              end
            end
          end
        end
      end
    end
  end
end
function L4_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = L3_1
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L2_2 = L1_2.type
    if "wallart" == L2_2 then
      goto lbl_12
    end
  end
  L2_2 = false
  L3_2 = nil
  do return L2_2, L3_2 end
  ::lbl_12::
  L2_2 = true
  L3_2 = L1_2.wallart
  return L2_2, L3_2
end
function L5_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = L0_1
  L1_2 = L1_2[A0_2]
  if not L1_2 then
    L1_2 = L0_1
    L2_2 = db
    L2_2 = L2_2.getObjects
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    if not L2_2 then
      L2_2 = {}
    end
    L1_2[A0_2] = L2_2
  end
  L1_2 = L0_1
  L1_2 = L1_2[A0_2]
  return L1_2
end
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = L5_1
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = 0
  L3_2 = 1
  L4_2 = #L1_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = L4_1
    L8_2 = L1_2[L6_2]
    L8_2 = L8_2.modelName
    L7_2 = L7_2(L8_2)
    if L7_2 then
      L2_2 = L2_2 + 1
    end
  end
  return L2_2
end
function L7_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L3_2 = Config
  L3_2 = L3_2.Houses
  L3_2 = L3_2[A1_2]
  if not L3_2 then
    if A0_2 > 0 then
      L4_2 = Notification
      L5_2 = A0_2
      L6_2 = i18n
      L6_2 = L6_2.t
      L7_2 = "decorate.invalid_data"
      L6_2 = L6_2(L7_2)
      L7_2 = "error"
      L4_2(L5_2, L6_2, L7_2)
    end
    L4_2 = false
    return L4_2
  end
  L4_2 = L4_1
  L5_2 = A2_2.modelName
  L4_2, L5_2 = L4_2(L5_2)
  if L4_2 then
    L6_2 = table
    L6_2 = L6_2.includes
    L7_2 = L3_2.upgrades
    if not L7_2 then
      L7_2 = {}
    end
    L8_2 = "wallart"
    L6_2 = L6_2(L7_2, L8_2)
    if not L6_2 then
      if A0_2 > 0 then
        L6_2 = Notification
        L7_2 = A0_2
        L8_2 = i18n
        L8_2 = L8_2.t
        L9_2 = "decorate.wallart_upgrade_required"
        L8_2 = L8_2(L9_2)
        L9_2 = "error"
        L6_2(L7_2, L8_2, L9_2)
      end
      L6_2 = false
      return L6_2
    end
    L6_2 = L6_1
    L7_2 = A1_2
    L6_2 = L6_2(L7_2)
    L7_2 = L2_1
    if L6_2 >= L7_2 then
      if A0_2 > 0 then
        L6_2 = Notification
        L7_2 = A0_2
        L8_2 = i18n
        L8_2 = L8_2.t
        L9_2 = "decorate.wallart_limit_reached"
        L10_2 = {}
        L11_2 = L2_1
        L10_2.limit = L11_2
        L8_2 = L8_2(L9_2, L10_2)
        L9_2 = "error"
        L6_2(L7_2, L8_2, L9_2)
      end
      L6_2 = false
      return L6_2
    end
    L6_2 = A2_2.wallartData
    if not L6_2 then
      L6_2 = {}
    end
    A2_2.wallartData = L6_2
    L6_2 = A2_2.wallartData
    L7_2 = type
    L8_2 = A2_2.wallartData
    L8_2 = L8_2.url
    L7_2 = L7_2(L8_2)
    if "string" == L7_2 then
      L7_2 = A2_2.wallartData
      L7_2 = L7_2.url
      L8_2 = L7_2
      L7_2 = L7_2.match
      L9_2 = "^%s*(.-)%s*$"
      L7_2 = L7_2(L8_2, L9_2)
      if L7_2 then
        goto lbl_94
      end
    end
    if L5_2 then
      L7_2 = L5_2.defaultUrl
      if L7_2 then
        goto lbl_94
      end
    end
    L7_2 = ""
    ::lbl_94::
    L6_2.url = L7_2
    L6_2 = A2_2.wallartData
    if L5_2 then
      L7_2 = L5_2.textureName
      if L7_2 then
        goto lbl_103
      end
    end
    L7_2 = A2_2.wallartData
    L7_2 = L7_2.textureName
    ::lbl_103::
    L6_2.textureName = L7_2
    L6_2 = A2_2.wallartData
    if L5_2 then
      L7_2 = L5_2.textureDict
      if L7_2 then
        goto lbl_112
      end
    end
    L7_2 = A2_2.wallartData
    L7_2 = L7_2.textureDict
    ::lbl_112::
    L6_2.textureDict = L7_2
  else
    A2_2.wallartData = nil
  end
  if 0 == A0_2 then
    L6_2 = "server"
    if L6_2 then
      goto lbl_128
    end
  end
  L6_2 = tostring
  L7_2 = GetIdentifier
  L8_2 = A0_2
  L7_2 = L7_2(L8_2)
  if not L7_2 then
    L7_2 = ""
  end
  L6_2 = L6_2(L7_2)
  ::lbl_128::
  L7_2 = os
  L7_2 = L7_2.time
  L7_2 = L7_2()
  A2_2.created = L7_2
  L8_2 = db
  L8_2 = L8_2.saveObject
  L9_2 = L6_2
  L10_2 = A2_2
  L8_2 = L8_2(L9_2, L10_2)
  A2_2.id = L8_2
  L9_2 = L0_1
  L10_2 = L0_1
  L10_2 = L10_2[A1_2]
  if not L10_2 then
    L10_2 = {}
  end
  L9_2[A1_2] = L10_2
  L9_2 = L0_1
  L9_2 = L9_2[A1_2]
  L10_2 = L0_1
  L10_2 = L10_2[A1_2]
  L10_2 = #L10_2
  L10_2 = L10_2 + 1
  L9_2[L10_2] = A2_2
  L9_2 = TriggerClientEvent
  L10_2 = "housing:addObject"
  L11_2 = -1
  L12_2 = A1_2
  L13_2 = A2_2
  L9_2(L10_2, L11_2, L12_2, L13_2)
  L9_2 = Debug
  L10_2 = "housing:saveObject"
  L11_2 = "Saved"
  L12_2 = A1_2
  L13_2 = "Id"
  L14_2 = L8_2
  L15_2 = "Data"
  L16_2 = A2_2
  L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  L9_2 = true
  return L9_2
end
function L8_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  if A2_2 then
    L3_2 = #A2_2
    if 0 ~= L3_2 then
      goto lbl_10
    end
  end
  L3_2 = false
  L4_2 = {}
  do return L3_2, L4_2 end
  ::lbl_10::
  if 0 == A0_2 then
    L3_2 = "server"
    if L3_2 then
      goto lbl_23
    end
  end
  L3_2 = tostring
  L4_2 = GetIdentifier
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  if not L4_2 then
    L4_2 = ""
  end
  L3_2 = L3_2(L4_2)
  ::lbl_23::
  L4_2 = os
  L4_2 = L4_2.time
  L4_2 = L4_2()
  L5_2 = os
  L5_2 = L5_2.date
  L6_2 = "%Y-%m-%d %H:%M:%S"
  L5_2 = L5_2(L6_2)
  L6_2 = {}
  L7_2 = 1
  L8_2 = #A2_2
  L9_2 = 1
  for L10_2 = L7_2, L8_2, L9_2 do
    L11_2 = A2_2[L10_2]
    L12_2 = #L6_2
    L12_2 = L12_2 + 1
    L13_2 = {}
    L14_2 = L11_2.modelName
    L13_2.modelName = L14_2
    L14_2 = L11_2.coords
    if not L14_2 then
      L14_2 = vec3
      L15_2 = 0.0
      L16_2 = 0.0
      L17_2 = 0.0
      L14_2 = L14_2(L15_2, L16_2, L17_2)
    end
    L13_2.coords = L14_2
    L14_2 = L11_2.rotation
    if not L14_2 then
      L14_2 = vec3
      L15_2 = 0.0
      L16_2 = 0.0
      L17_2 = 0.0
      L14_2 = L14_2(L15_2, L16_2, L17_2)
    end
    L13_2.rotation = L14_2
    L14_2 = L11_2.inStash
    L14_2 = false ~= L14_2
    L13_2.inStash = L14_2
    L14_2 = L11_2.inHouse
    L14_2 = true == L14_2
    L13_2.inHouse = L14_2
    L13_2.house = A1_2
    L14_2 = L11_2.lightData
    L13_2.lightData = L14_2
    L14_2 = L11_2.price
    L13_2.price = L14_2
    L13_2.created = L4_2
    L13_2.createdSql = L5_2
    L6_2[L12_2] = L13_2
  end
  L7_2 = db
  L7_2 = L7_2.saveObjectsBatch
  L8_2 = L3_2
  L9_2 = L6_2
  L7_2 = L7_2(L8_2, L9_2)
  if L7_2 then
    L8_2 = #L7_2
    if 0 ~= L8_2 then
      goto lbl_97
    end
  end
  L8_2 = false
  L9_2 = {}
  do return L8_2, L9_2 end
  ::lbl_97::
  L8_2 = L0_1
  L9_2 = L0_1
  L9_2 = L9_2[A1_2]
  if not L9_2 then
    L9_2 = {}
  end
  L8_2[A1_2] = L9_2
  L8_2 = L0_1
  L8_2 = L8_2[A1_2]
  L9_2 = db
  L9_2 = L9_2.getObjects
  L10_2 = A1_2
  L9_2 = L9_2(L10_2)
  if not L9_2 then
    L9_2 = {}
  end
  L10_2 = {}
  L11_2 = 1
  L12_2 = #L8_2
  L13_2 = 1
  for L14_2 = L11_2, L12_2, L13_2 do
    L15_2 = L8_2[L14_2]
    if L15_2 then
      L16_2 = L15_2.id
      if L16_2 then
        L16_2 = L15_2.id
        L10_2[L16_2] = true
      end
    end
  end
  L11_2 = {}
  L12_2 = 1
  L13_2 = #L9_2
  L14_2 = 1
  for L15_2 = L12_2, L13_2, L14_2 do
    L16_2 = L9_2[L15_2]
    if L16_2 then
      L17_2 = L16_2.id
      if L17_2 then
        L17_2 = L16_2.id
        L17_2 = L10_2[L17_2]
        if not L17_2 then
          L17_2 = #L8_2
          L17_2 = L17_2 + 1
          L8_2[L17_2] = L16_2
          L17_2 = TriggerClientEvent
          L18_2 = "housing:addObject"
          L19_2 = -1
          L20_2 = A1_2
          L21_2 = L16_2
          L17_2(L18_2, L19_2, L20_2, L21_2)
          L17_2 = L16_2.id
          L10_2[L17_2] = true
          L17_2 = #L11_2
          L17_2 = L17_2 + 1
          L11_2[L17_2] = L16_2
        end
      end
    end
  end
  L12_2 = Debug
  L13_2 = "housing:addDecorationBatchToHouse"
  L14_2 = "Saved"
  L15_2 = A1_2
  L16_2 = "Count"
  L17_2 = #L11_2
  L12_2(L13_2, L14_2, L15_2, L16_2, L17_2)
  L12_2 = true
  L13_2 = L11_2
  return L12_2, L13_2
end
addDecorationBatchToHouse = L8_1
L8_1 = lib
L8_1 = L8_1.callback
L8_1 = L8_1.register
L9_1 = "housing:saveObject"
function L10_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = L7_1
  L4_2 = A0_2
  L5_2 = A1_2
  L6_2 = A2_2
  return L3_2(L4_2, L5_2, L6_2)
end
L8_1(L9_1, L10_1)
L8_1 = exports
L9_1 = "addDecorationToHouse"
function L10_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = L7_1
  L3_2 = 0
  L4_2 = A0_2
  L5_2 = A1_2
  return L2_2(L3_2, L4_2, L5_2)
end
L8_1(L9_1, L10_1)
L8_1 = exports
L9_1 = "addDecorationBatchToHouse"
function L10_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = addDecorationBatchToHouse
  L3_2 = 0
  L4_2 = A0_2
  L5_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  return L2_2
end
L8_1(L9_1, L10_1)
L8_1 = {}
L8_1.coords = true
L8_1.rotation = true
L8_1.inStash = true
L8_1.lightData = true
L8_1.wallartData = true
L9_1 = RegisterNetEvent
L10_1 = "housing:updateObject"
function L11_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L3_2 = source
  if not A2_2 then
    L4_2 = Notification
    L5_2 = L3_2
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "decorate.invalid_data"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    return L4_2(L5_2, L6_2, L7_2)
  end
  L4_2 = table
  L4_2 = L4_2.find
  L5_2 = A2_2
  function L6_2(A0_3, A1_3)
    local L2_3
    L2_3 = L8_1
    L2_3 = L2_3[A1_3]
    L2_3 = not L2_3
    return L2_3
  end
  L4_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L5_2 = Notification
    L6_2 = L3_2
    L7_2 = i18n
    L7_2 = L7_2.t
    L8_2 = "decorate.invalid_data"
    L7_2 = L7_2(L8_2)
    L8_2 = "error"
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = Debug
    L6_2 = "unsecured"
    L7_2 = L4_2
    L5_2(L6_2, L7_2)
    L5_2 = Debug
    L6_2 = "housing:updateObject"
    L7_2 = "User trying to exploit update profile event"
    L8_2 = L3_2
    L9_2 = A2_2
    return L5_2(L6_2, L7_2, L8_2, L9_2)
  end
  L5_2 = table
  L5_2 = L5_2.find
  L6_2 = L0_1
  L6_2 = L6_2[A0_2]
  function L7_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.id
    L2_3 = A1_2
    L1_3 = L1_3 == L2_3
    return L1_3
  end
  L5_2 = L5_2(L6_2, L7_2)
  if not L5_2 then
    L6_2 = Notification
    L7_2 = L3_2
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "decorate.invalid_object"
    L8_2 = L8_2(L9_2)
    L9_2 = "error"
    return L6_2(L7_2, L8_2, L9_2)
  end
  L6_2 = db
  L6_2 = L6_2.updateObject
  L7_2 = A1_2
  L8_2 = A2_2
  L6_2 = L6_2(L7_2, L8_2)
  if not L6_2 then
    L7_2 = Notification
    L8_2 = L3_2
    L9_2 = i18n
    L9_2 = L9_2.t
    L10_2 = "decorate.failed_update"
    L9_2 = L9_2(L10_2)
    L10_2 = "error"
    L7_2(L8_2, L9_2, L10_2)
    return
  end
  L7_2 = pairs
  L8_2 = A2_2
  L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
  for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
    if L12_2 then
      L13_2 = type
      L14_2 = L12_2
      L13_2 = L13_2(L14_2)
      if "string" == L13_2 and ("coords" == L11_2 or "rotation" == L11_2 or "lightData" == L11_2 or "wallartData" == L11_2) then
        L13_2 = Debug
        L14_2 = "housing:updateObject"
        L15_2 = "Decoding"
        L16_2 = L11_2
        L17_2 = L12_2
        L13_2(L14_2, L15_2, L16_2, L17_2)
        L13_2 = json
        L13_2 = L13_2.decode
        L14_2 = L12_2
        L13_2 = L13_2(L14_2)
        A2_2[L11_2] = L13_2
      end
    end
    L13_2 = A2_2[L11_2]
    L5_2[L11_2] = L13_2
  end
  L7_2 = TriggerClientEvent
  L8_2 = "housing:updateObject"
  L9_2 = -1
  L10_2 = A0_2
  L11_2 = A1_2
  L12_2 = A2_2
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
  L7_2 = Debug
  L8_2 = "housing:updateObject"
  L9_2 = "Updated"
  L10_2 = A0_2
  L11_2 = "Id"
  L12_2 = A1_2
  L13_2 = "data"
  L14_2 = A2_2
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
end
L9_1(L10_1, L11_1)
function L9_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L1_2 = pairs
  L2_2 = Config
  L2_2 = L2_2.Furniture
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    if "navigation" ~= L5_2 then
      L7_2 = pairs
      L8_2 = L6_2.items
      L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
      for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
        L13_2 = L12_2.object
        if L13_2 == A0_2 then
          L13_2 = L12_2.price
          return L13_2
        end
        L13_2 = L12_2.colors
        if L13_2 then
          L13_2 = pairs
          L14_2 = L12_2.colors
          L13_2, L14_2, L15_2, L16_2 = L13_2(L14_2)
          for L17_2, L18_2 in L13_2, L14_2, L15_2, L16_2 do
            L19_2 = L18_2.object
            if L19_2 == A0_2 then
              L19_2 = L18_2.price
              return L19_2
            end
          end
        end
      end
    end
  end
end
L10_1 = RegisterNetEvent
L11_1 = "housing:decorate:sellFurniture"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L2_2 = source
  L3_2 = table
  L3_2 = L3_2.find
  L4_2 = L0_1
  L4_2 = L4_2[A0_2]
  function L5_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.id
    L2_3 = A1_2
    L1_3 = L1_3 == L2_3
    return L1_3
  end
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L4_2 = Notification
    L5_2 = L2_2
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "decorate.invalid_object"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    return L4_2(L5_2, L6_2, L7_2)
  end
  L4_2 = db
  L4_2 = L4_2.deleteObject
  L5_2 = A1_2
  L4_2 = L4_2(L5_2)
  if not L4_2 then
    L5_2 = Notification
    L6_2 = L2_2
    L7_2 = i18n
    L7_2 = L7_2.t
    L8_2 = "decorate.failed_sell"
    L7_2 = L7_2(L8_2)
    L8_2 = "error"
    L5_2(L6_2, L7_2, L8_2)
    return
  end
  L5_2 = L3_2.price
  if not L5_2 then
    L5_2 = L9_1
    L6_2 = L3_2.modelName
    L5_2 = L5_2(L6_2)
  end
  L6_2 = Config
  L6_2 = L6_2.SellObjectCommision
  L6_2 = L5_2 * L6_2
  L7_2 = AddAccountMoney
  L8_2 = L2_2
  L9_2 = Config
  L9_2 = L9_2.MoneyType
  L10_2 = L6_2
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = L0_1
  L8_2 = table
  L8_2 = L8_2.filter
  L9_2 = L0_1
  L9_2 = L9_2[A0_2]
  function L10_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.id
    L2_3 = A1_2
    L1_3 = L1_3 ~= L2_3
    return L1_3
  end
  L8_2 = L8_2(L9_2, L10_2)
  L7_2[A0_2] = L8_2
  L7_2 = TriggerClientEvent
  L8_2 = "housing:decorate:sellFurniture"
  L9_2 = -1
  L10_2 = A0_2
  L11_2 = A1_2
  L7_2(L8_2, L9_2, L10_2, L11_2)
  L7_2 = Notification
  L8_2 = L2_2
  L9_2 = i18n
  L9_2 = L9_2.t
  L10_2 = "decorate.sold_furniture"
  L11_2 = {}
  L11_2.price = L6_2
  L9_2 = L9_2(L10_2, L11_2)
  L10_2 = "success"
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = SendLog
  L8_2 = DiscordWebhook
  L9_2 = {}
  L9_2.title = "Housing"
  L9_2.description = "Player sold a furniture"
  L10_2 = {}
  L11_2 = {}
  L11_2.name = "Player"
  L12_2 = GetPlayerName
  L13_2 = L2_2
  L12_2 = L12_2(L13_2)
  L11_2.value = L12_2
  L11_2.inline = true
  L12_2 = {}
  L12_2.name = "House"
  L12_2.value = A0_2
  L12_2.inline = true
  L13_2 = {}
  L13_2.name = "Model"
  L14_2 = L3_2.modelName
  L13_2.value = L14_2
  L13_2.inline = true
  L14_2 = {}
  L14_2.name = "Price"
  L15_2 = tostring
  L16_2 = L6_2
  L15_2 = L15_2(L16_2)
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
end
L10_1(L11_1, L12_1)
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = L0_1
  L1_2 = L1_2[A0_2]
  if not L1_2 then
    L1_2 = db
    L1_2 = L1_2.getObjects
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    L2_2 = L0_1
    L3_2 = L1_2 or L3_2
    if not L1_2 then
      L3_2 = {}
    end
    L2_2[A0_2] = L3_2
  end
  L1_2 = pairs
  L2_2 = L0_1
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    if "coords" == L5_2 then
      L7_2 = type
      L8_2 = L6_2
      L7_2 = L7_2(L8_2)
      if "string" == L7_2 then
        L7_2 = L0_1
        L8_2 = json
        L8_2 = L8_2.decode
        L9_2 = L6_2
        L8_2 = L8_2(L9_2)
        L7_2[L5_2] = L8_2
        L7_2 = Error
        L8_2 = "If you see this error please report this ERROR TO THE QUASAR. It will not affect the server but it will help us to improve the script. Thank you!"
        L7_2(L8_2)
    end
    else
      if "rotation" == L5_2 then
        L7_2 = type
        L8_2 = L6_2
        L7_2 = L7_2(L8_2)
        if "string" == L7_2 then
          L7_2 = L0_1
          L8_2 = json
          L8_2 = L8_2.decode
          L9_2 = L6_2
          L8_2 = L8_2(L9_2)
          L7_2[L5_2] = L8_2
          L7_2 = Error
          L8_2 = "If you see this error please report this ERROR TO THE QUASAR. It will not affect the server but it will help us to improve the script. Thank you!"
          L7_2(L8_2)
      end
      else
        if "lightData" == L5_2 then
          L7_2 = type
          L8_2 = L6_2
          L7_2 = L7_2(L8_2)
          if "string" == L7_2 then
            L7_2 = L0_1
            L8_2 = json
            L8_2 = L8_2.decode
            L9_2 = L6_2
            L8_2 = L8_2(L9_2)
            L7_2[L5_2] = L8_2
            L7_2 = Error
            L8_2 = "If you see this error please report this ERROR TO THE QUASAR. It will not affect the server but it will help us to improve the script. Thank you!"
            L7_2(L8_2)
        end
        elseif "wallartData" == L5_2 then
          L7_2 = type
          L8_2 = L6_2
          L7_2 = L7_2(L8_2)
          if "string" == L7_2 then
            L7_2 = L0_1
            L8_2 = json
            L8_2 = L8_2.decode
            L9_2 = L6_2
            L8_2 = L8_2(L9_2)
            L7_2[L5_2] = L8_2
            L7_2 = Error
            L8_2 = "If you see this error please report this ERROR TO THE QUASAR. It will not affect the server but it will help us to improve the script. Thank you!"
            L7_2(L8_2)
          end
        end
      end
    end
  end
  L1_2 = L0_1
  L1_2 = L1_2[A0_2]
  if not L1_2 then
    L1_2 = {}
  end
  return L1_2
end
function L11_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = L0_1
  L1_2[A0_2] = nil
  L1_2 = Debug
  L2_2 = "ClearHouseDecoration"
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
ClearHouseDecoration = L11_1
L11_1 = lib
L11_1 = L11_1.callback
L11_1 = L11_1.register
L12_1 = "housing:getDecorations"
function L13_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = A0_2
  L3_2 = L10_1
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  L4_2 = L3_2 or L4_2
  if not L3_2 then
    L4_2 = {}
  end
  return L4_2
end
L11_1(L12_1, L13_1)
L11_1 = lib
L11_1 = L11_1.callback
L11_1 = L11_1.register
L12_1 = "housing:buyDecorationObject"
function L13_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = GetAccountMoney
  L3_2 = A0_2
  L4_2 = Config
  L4_2 = L4_2.MoneyType
  L2_2 = L2_2(L3_2, L4_2)
  if A1_2 <= L2_2 then
    L3_2 = RemoveAccountMoney
    L4_2 = A0_2
    L5_2 = Config
    L5_2 = L5_2.MoneyType
    L6_2 = A1_2
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = GetResourceState
    L4_2 = "qs-inventory"
    L3_2 = L3_2(L4_2)
    L4_2 = L3_2
    L3_2 = L3_2.find
    L5_2 = "started"
    L3_2 = L3_2(L4_2, L5_2)
    if L3_2 then
      L3_2 = Config
      L3_2 = L3_2.EnableQuests
      if L3_2 then
        L3_2 = exports
        L3_2 = L3_2["qs-inventory"]
        L4_2 = L3_2
        L3_2 = L3_2.UpdateQuestProgress
        L5_2 = A0_2
        L6_2 = "buy_furniture"
        L7_2 = 10
        L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
        if L3_2 then
          L4_2 = Debug
          L5_2 = "Quest \"buy_furniture\" progress updated"
          L4_2(L5_2)
        else
          L4_2 = Debug
          L5_2 = "Failed to update quest \"buy_furniture\""
          L4_2(L5_2)
        end
      end
    end
    L3_2 = true
    return L3_2
  end
  L3_2 = false
  return L3_2
end
L11_1(L12_1, L13_1)
L11_1 = RegisterCommand
L12_1 = "revert_decorations"
function L13_1(A0_2, A1_2)
  local L2_2, L3_2
  if 0 ~= A0_2 then
    L2_2 = Error
    L3_2 = "This command can only be executed from the server console."
    return L2_2(L3_2)
  end
  L2_2 = db
  L2_2 = L2_2.revertDecorations
  L2_2()
end
L11_1(L12_1, L13_1)
L11_1 = lib
L11_1 = L11_1.callback
L11_1 = L11_1.register
L12_1 = "housing:decorate:getDecorationAvailable"
function L13_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = L1_1
  L2_2 = L2_2[A1_2]
  L3_2 = Debug
  L4_2 = "housing:decorate:getDecorationAvailable"
  L5_2 = A1_2
  L6_2 = "UsedBy"
  L7_2 = L2_2
  L3_2(L4_2, L5_2, L6_2, L7_2)
  L3_2 = L2_2 or L3_2
  if not L2_2 then
    L3_2 = true
  end
  return L3_2
end
L11_1(L12_1, L13_1)
L11_1 = RegisterNetEvent
L12_1 = "housing:decorate:updateDecorationUsedBy"
function L13_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = source
  L3_2 = L1_1
  L4_2 = L2_2 or L4_2
  if not A1_2 or not L2_2 then
    L4_2 = nil
  end
  L3_2[A0_2] = L4_2
  L3_2 = Debug
  L4_2 = "housing:decorate:updateDecorationUsedBy"
  L5_2 = A0_2
  L6_2 = "UsedBy"
  L7_2 = A1_2
  L3_2(L4_2, L5_2, L6_2, L7_2)
end
L11_1(L12_1, L13_1)
L11_1 = AddEventHandler
L12_1 = "playerDropped"
function L13_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = source
  L2_2 = pairs
  L3_2 = L1_1
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    if L7_2 == L1_2 then
      L8_2 = L1_1
      L8_2[L6_2] = nil
    end
  end
end
L11_1(L12_1, L13_1)






