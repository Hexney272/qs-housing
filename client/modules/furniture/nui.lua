





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1
L0_1 = RegisterNUICallback
L1_1 = "toggle_hide_decorate"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = decorate
  L3_2 = L2_2
  L2_2 = L2_2.toggleHideDecorate
  L2_2(L3_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "spawn_object"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  L2_2 = decorate
  L2_2 = L2_2.active
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = "ok"
    return L2_2(L3_2)
  end
  L2_2 = decorate
  L3_2 = L2_2
  L2_2 = L2_2.removeCurrentObject
  L2_2(L3_2)
  L2_2 = IsOnlyInsideModel
  L3_2 = A0_2.modelName
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = EnteredHouse
    if not L2_2 then
      L2_2 = Notification
      L3_2 = i18n
      L3_2 = L3_2.t
      L4_2 = "decorate.only_inside_purchase"
      L3_2 = L3_2(L4_2)
      L4_2 = "error"
      L2_2(L3_2, L4_2)
      L2_2 = A1_2
      L3_2 = "ok"
      return L2_2(L3_2)
    end
  end
  L2_2 = table
  L2_2 = L2_2.find
  L3_2 = LIGHT_ITEMS
  function L4_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.object
    L2_3 = A0_2.modelName
    L1_3 = L1_3 == L2_3
    return L1_3
  end
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = decorate
  L4_2 = L3_2
  L3_2 = L3_2.getCamCoords
  L3_2 = L3_2(L4_2)
  L4_2 = decorate
  L5_2 = L4_2
  L4_2 = L4_2.getCamRot
  L4_2 = L4_2(L5_2)
  L5_2 = Utils
  L5_2 = L5_2.GetForwardVector
  L6_2 = L4_2
  L5_2 = L5_2(L6_2)
  L6_2 = L5_2 * 5.0
  L6_2 = L3_2 + L6_2
  L7_2 = L6_2
  L8_2 = SpawnObject
  L9_2 = A0_2.modelName
  L10_2 = L7_2
  L11_2 = vec3
  L12_2 = 0.0
  L13_2 = 0.0
  L14_2 = 0.0
  L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L11_2(L12_2, L13_2, L14_2)
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
  L9_2 = A1_2
  L10_2 = L8_2
  L9_2(L10_2)
  if not L8_2 then
    L9_2 = Notification
    L10_2 = "Object is not spawned"
    L11_2 = "error"
    return L9_2(L10_2, L11_2)
  end
  L9_2 = decorate
  L10_2 = {}
  L11_2 = A0_2.modelName
  L10_2.modelName = L11_2
  L10_2.handle = L8_2
  L11_2 = A0_2.price
  L10_2.price = L11_2
  L9_2.currentObject = L10_2
  L9_2 = Debug
  L10_2 = "Spawned object"
  L11_2 = "decorate.currentObject"
  L12_2 = decorate
  L12_2 = L12_2.currentObject
  L9_2(L10_2, L11_2, L12_2)
  if not L2_2 then
    return
  end
  while true do
    L9_2 = decorate
    L9_2 = L9_2.currentObject
    if L9_2 then
      L9_2 = L9_2.handle
    end
    if not L9_2 then
      break
    end
    L9_2 = Wait
    L10_2 = 0
    L9_2(L10_2)
    L9_2 = GetEntityRotation
    L10_2 = decorate
    L10_2 = L10_2.currentObject
    L10_2 = L10_2.handle
    L9_2 = L9_2(L10_2)
    L10_2 = GetEntityCoords
    L11_2 = decorate
    L11_2 = L11_2.currentObject
    L11_2 = L11_2.handle
    L10_2 = L10_2(L11_2)
    L11_2 = RotationToDirection
    L12_2 = L9_2
    L11_2 = L11_2(L12_2)
    L12_2 = DrawSpotLight
    L13_2 = L10_2.x
    L14_2 = L10_2.y
    L15_2 = L10_2.z
    L16_2 = L11_2.x
    L17_2 = L11_2.y
    L18_2 = L11_2.z
    L19_2 = 255
    L20_2 = 255
    L21_2 = 255
    L22_2 = 100.0
    L23_2 = 20.0
    L24_2 = 1.0
    L25_2 = Config
    L25_2 = L25_2.DefaultLightIntensity
    L26_2 = 0.0
    L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
  end
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "place_object_on_ground"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = decorate
  L2_2 = L2_2.currentObject
  if L2_2 then
    L2_2 = L2_2.handle
  end
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = "ok"
    return L2_2(L3_2)
  end
  L2_2 = decorate
  L3_2 = L2_2
  L2_2 = L2_2.placeObjectOnGround
  L2_2(L3_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "set_current_page"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = decorate
  L2_2.currentPage = A0_2
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "toggle_cursor"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = decorate
  L3_2 = L2_2
  L2_2 = L2_2.setFocus
  L2_2(L3_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "save_locations"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = decorate
  L3_2 = L2_2
  L2_2 = L2_2.saveObjects
  L2_2(L3_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "sell_current_object"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = decorate
  L2_2 = L2_2.currentObject
  if L2_2 then
    L2_2 = L2_2.stashId
  end
  if not L2_2 then
    L2_2 = Error
    L3_2 = "sell_current_object"
    L4_2 = "Selected object id is nil"
    L5_2 = decorate
    L5_2 = L5_2.currentObject
    if L5_2 then
      L5_2 = L5_2.stashId
    end
    L2_2(L3_2, L4_2, L5_2)
    return
  end
  L2_2 = table
  L2_2 = L2_2.find
  L3_2 = decorate
  L3_2 = L3_2.objects
  function L4_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.id
    L2_3 = decorate
    L2_3 = L2_3.currentObject
    L2_3 = L2_3.stashId
    L1_3 = L1_3 == L2_3
    return L1_3
  end
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L3_2 = Error
    L4_2 = "sell_current_object"
    L5_2 = "Object not found"
    L6_2 = decorate
    L6_2 = L6_2.currentObject
    L6_2 = L6_2.stashId
    L3_2(L4_2, L5_2, L6_2)
    return
  end
  L3_2 = TriggerServerEvent
  L4_2 = "housing:decorate:sellFurniture"
  L5_2 = CurrentHouse
  L6_2 = decorate
  L6_2 = L6_2.currentObject
  L6_2 = L6_2.stashId
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = decorate
  L4_2 = L3_2
  L3_2 = L3_2.removeCurrentObject
  L3_2(L4_2)
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "update_stash"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = A0_2.id
  if not L2_2 then
    L2_2 = decorate
    L2_2 = L2_2.currentObject
    if L2_2 then
      L2_2 = L2_2.stashId
    end
  end
  if not L2_2 then
    L3_2 = Error
    L4_2 = "update_stash"
    L5_2 = "Selected object id is nil"
    L6_2 = decorate
    L6_2 = L6_2.currentObject
    if L6_2 then
      L6_2 = L6_2.stashId
    end
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = A1_2
    L4_2 = "ok"
    return L3_2(L4_2)
  end
  A0_2.id = nil
  L3_2 = A0_2.wallartData
  if L3_2 then
    L3_2 = type
    L4_2 = A0_2.wallartData
    L4_2 = L4_2.url
    L3_2 = L3_2(L4_2)
    if "string" == L3_2 then
      L3_2 = A0_2.wallartData
      L4_2 = A0_2.wallartData
      L4_2 = L4_2.url
      L5_2 = L4_2
      L4_2 = L4_2.match
      L6_2 = "^%s*(.-)%s*$"
      L4_2 = L4_2(L5_2, L6_2)
      L3_2.url = L4_2
    end
  end
  L3_2 = table
  L3_2 = L3_2.find
  L4_2 = decorate
  L4_2 = L4_2.objects
  function L5_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.id
    L2_3 = L2_2
    L1_3 = L1_3 == L2_3
    return L1_3
  end
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L4_2 = pairs
    L5_2 = A0_2
    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
    for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
      L3_2[L8_2] = L9_2
    end
    L4_2 = A0_2.wallartData
    if L4_2 then
      L4_2 = L3_2.spawned
      if L4_2 then
        L4_2 = decorate
        L5_2 = L4_2
        L4_2 = L4_2.applyWallartTexture
        L6_2 = L3_2
        L4_2(L5_2, L6_2)
      end
    end
  end
  L4_2 = decorate
  L4_2 = L4_2.currentObject
  if L4_2 then
    L4_2 = decorate
    L4_2 = L4_2.currentObject
    L4_2 = L4_2.stashId
    if L4_2 == L2_2 then
      L4_2 = pairs
      L5_2 = A0_2
      L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
      for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
        L10_2 = decorate
        L10_2 = L10_2.currentObject
        L10_2[L8_2] = L9_2
      end
    end
  end
  L4_2 = TriggerServerEvent
  L5_2 = "housing:updateObject"
  L6_2 = CurrentHouse
  L7_2 = L2_2
  L8_2 = A0_2
  L4_2(L5_2, L6_2, L7_2, L8_2)
  L4_2 = A1_2
  L5_2 = "ok"
  L4_2(L5_2)
end
L0_1(L1_1, L2_1)
function L0_1(A0_2)
  local L1_2, L2_2
  L1_2 = Config
  L1_2 = L1_2.DynamicFurnitures
  L1_2 = L1_2[A0_2]
  L2_2 = L1_2 or L2_2
  if L1_2 then
    L2_2 = L1_2.type
    L2_2 = "wallart" == L2_2
  end
  return L2_2
end
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = 0
  L1_2 = 1
  L2_2 = decorate
  L2_2 = L2_2.objects
  L2_2 = #L2_2
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = L0_1
    L6_2 = decorate
    L6_2 = L6_2.objects
    L6_2 = L6_2[L4_2]
    L6_2 = L6_2.modelName
    L5_2 = L5_2(L6_2)
    if L5_2 then
      L0_2 = L0_2 + 1
    end
  end
  return L0_2
end
L2_1 = RegisterNUICallback
L3_1 = "buy_object"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = decorate
  L2_2 = L2_2.currentObject
  if not L2_2 then
    L2_2 = Error
    L3_2 = "buy_object"
    L4_2 = "Current object is nil"
    L5_2 = decorate
    L5_2 = L5_2.currentObject
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = A1_2
    L3_2 = "ok"
    return L2_2(L3_2)
  end
  L2_2 = IsOnlyInsideModel
  L3_2 = decorate
  L3_2 = L3_2.currentObject
  L3_2 = L3_2.modelName
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = EnteredHouse
    if not L2_2 then
      L2_2 = Notification
      L3_2 = i18n
      L3_2 = L3_2.t
      L4_2 = "decorate.only_inside_purchase"
      L3_2 = L3_2(L4_2)
      L4_2 = "error"
      L2_2(L3_2, L4_2)
      L2_2 = A1_2
      L3_2 = "ok"
      return L2_2(L3_2)
    end
  end
  L2_2 = Config
  L2_2 = L2_2.Houses
  L3_2 = CurrentHouse
  L2_2 = L2_2[L3_2]
  if not L2_2 then
    L3_2 = Debug
    L4_2 = "buy_object"
    L5_2 = "House data not found"
    L6_2 = CurrentHouse
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = A1_2
    L4_2 = "ok"
    return L3_2(L4_2)
  end
  L3_2 = decorate
  L3_2 = L3_2.currentObject
  L3_2 = L3_2.modelName
  L4_2 = Config
  L4_2 = L4_2.DynamicFurnitures
  L4_2 = L4_2[L3_2]
  L5_2 = L4_2 or L5_2
  if L4_2 then
    L5_2 = L4_2.type
    L5_2 = "wallart" == L5_2
  end
  if L5_2 then
    L6_2 = table
    L6_2 = L6_2.includes
    L7_2 = L2_2.upgrades
    if not L7_2 then
      L7_2 = {}
    end
    L8_2 = "wallart"
    L6_2 = L6_2(L7_2, L8_2)
    if not L6_2 then
      L6_2 = A1_2
      L7_2 = "ok"
      L6_2(L7_2)
      L6_2 = Notification
      L7_2 = i18n
      L7_2 = L7_2.t
      L8_2 = "decorate.wallart_upgrade_required"
      L7_2 = L7_2(L8_2)
      L8_2 = "error"
      return L6_2(L7_2, L8_2)
    end
  end
  L6_2 = table
  L6_2 = L6_2.includes
  L7_2 = L2_2.upgrades
  if not L7_2 then
    L7_2 = {}
  end
  L8_2 = "furniture"
  L6_2 = L6_2(L7_2, L8_2)
  if L6_2 then
    L7_2 = decorate
    L7_2 = L7_2.objects
    L7_2 = #L7_2
    L8_2 = Config
    L8_2 = L8_2.FurnitureLimits
    L8_2 = L8_2.upgrade
    if L7_2 >= L8_2 then
      L7_2 = A1_2
      L8_2 = "ok"
      L7_2(L8_2)
      L7_2 = Notification
      L8_2 = "You have reached the maximum number of furniture items"
      L9_2 = "error"
      return L7_2(L8_2, L9_2)
  end
  elseif not L6_2 then
    L7_2 = decorate
    L7_2 = L7_2.objects
    L7_2 = #L7_2
    L8_2 = Config
    L8_2 = L8_2.FurnitureLimits
    L8_2 = L8_2.normal
    if L7_2 >= L8_2 then
      L7_2 = A1_2
      L8_2 = "ok"
      L7_2(L8_2)
      L7_2 = Notification
      L8_2 = "You have reached the maximum number of furniture items. You can upgrade your property to increase the limit."
      L9_2 = "error"
      return L7_2(L8_2, L9_2)
    end
  end
  if L5_2 then
    L7_2 = L1_1
    L7_2 = L7_2()
    if L7_2 >= 6 then
      L7_2 = A1_2
      L8_2 = "ok"
      L7_2(L8_2)
      L7_2 = Notification
      L8_2 = i18n
      L8_2 = L8_2.t
      L9_2 = "decorate.wallart_limit_reached"
      L10_2 = {}
      L10_2.limit = 6
      L8_2 = L8_2(L9_2, L10_2)
      L9_2 = "error"
      return L7_2(L8_2, L9_2)
    end
  end
  if L5_2 then
    L7_2 = L4_2.wallart
    if L7_2 then
      L7_2 = decorate
      L7_2 = L7_2.currentObject
      L8_2 = {}
      L9_2 = L4_2.wallart
      L9_2 = L9_2.defaultUrl
      if not L9_2 then
        L9_2 = ""
      end
      L8_2.url = L9_2
      L9_2 = L4_2.wallart
      L9_2 = L9_2.textureName
      L8_2.textureName = L9_2
      L9_2 = L4_2.wallart
      L9_2 = L9_2.textureDict
      L8_2.textureDict = L9_2
      L7_2.wallartData = L8_2
    end
  end
  L7_2 = Debug
  L8_2 = "buy_object"
  L9_2 = "Current object"
  L10_2 = decorate
  L10_2 = L10_2.currentObject
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = lib
  L7_2 = L7_2.callback
  L7_2 = L7_2.await
  L8_2 = "housing:buyDecorationObject"
  L9_2 = false
  L10_2 = decorate
  L10_2 = L10_2.currentObject
  L10_2 = L10_2.price
  L7_2 = L7_2(L8_2, L9_2, L10_2)
  if not L7_2 then
    L8_2 = decorate
    L9_2 = L8_2
    L8_2 = L8_2.removeCurrentObject
    L8_2(L9_2)
    L8_2 = A1_2
    L9_2 = "ok"
    L8_2(L9_2)
    return
  end
  L8_2 = decorate
  L9_2 = L8_2
  L8_2 = L8_2.saveCurrentObject
  L8_2(L9_2)
  L8_2 = A1_2
  L9_2 = "ok"
  L8_2(L9_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNUICallback
L3_1 = "get_owned_objects"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = A1_2
  L3_2 = decorate
  L3_2 = L3_2.objects
  L2_2(L3_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNUICallback
L3_1 = "select_owned_object"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = table
  L2_2 = L2_2.find
  L3_2 = decorate
  L3_2 = L3_2.objects
  function L4_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.id
    L2_3 = A0_2
    L1_3 = L1_3 == L2_3
    return L1_3
  end
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L3_2 = Error
    L4_2 = "select_owned_object"
    L5_2 = "Object not found"
    L6_2 = A0_2
    L3_2(L4_2, L5_2, L6_2)
    return
  end
  L3_2 = decorate
  L4_2 = {}
  L5_2 = L2_2.handle
  L4_2.handle = L5_2
  L5_2 = L2_2.modelName
  L4_2.modelName = L5_2
  L5_2 = L2_2.id
  L4_2.stashId = L5_2
  L5_2 = L2_2.wallartData
  L4_2.wallartData = L5_2
  L3_2.currentObject = L4_2
  L3_2 = Debug
  L4_2 = "Selected object"
  L5_2 = "data"
  L6_2 = L2_2
  L7_2 = "objectData"
  L8_2 = L2_2
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = A1_2
  L4_2 = true
  L3_2(L4_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNUICallback
L3_1 = "deselect_owned_object"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = decorate
  L3_2 = L2_2
  L2_2 = L2_2.removeCurrentObject
  L2_2(L3_2)
  L2_2 = decorate
  L3_2 = L2_2
  L2_2 = L2_2.refreshObjects
  L2_2(L3_2)
  L2_2 = A1_2
  L3_2 = true
  L2_2(L3_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNUICallback
L3_1 = "remove_current_object"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = decorate
  L3_2 = L2_2
  L2_2 = L2_2.removeCurrentObject
  L2_2(L3_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L2_1(L3_1, L4_1)
L2_1 = {}
L2_1.x = "lookSpeedX"
L2_1.y = "lookSpeedY"
L2_1.speed = "moveSpeed"
L3_1 = RegisterNUICallback
L4_1 = "updateCameraSpeed"
function L5_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = A0_2.value
  L4_2 = A0_2.type
  L3_2 = L2_1
  L3_2 = L3_2[L4_2]
  L4_2 = CameraOptions
  L4_2[L3_2] = L2_2
end
L3_1(L4_1, L5_1)
L3_1 = RegisterNUICallback
L4_1 = "toggle_gizmo_mode"
function L5_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = decorate
  L3_2 = L2_2
  L2_2 = L2_2.toggleGizmoMode
  L2_2(L3_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L3_1(L4_1, L5_1)
L3_1 = RegisterNUICallback
L4_1 = "toggle_free_camera"
function L5_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = decorate
  L3_2 = L2_2
  L2_2 = L2_2.toggleFreeCamera
  L2_2(L3_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L3_1(L4_1, L5_1)
L3_1 = RegisterNUICallback
L4_1 = "open_buy_object_modal"
function L5_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = decorate
  L3_2 = L2_2
  L2_2 = L2_2.openBuyObjectModal
  L2_2(L3_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L3_1(L4_1, L5_1)






