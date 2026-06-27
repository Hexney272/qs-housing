





local L0_1, L1_1, L2_1, L3_1
L0_1 = RegisterNUICallback
L1_1 = "creator_select_points"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = creator
  L3_2 = L2_2
  L2_2 = L2_2.spawnTempEntities
  L2_2(L3_2)
  L2_2 = creator
  L3_2 = L2_2
  L2_2 = L2_2.raycastRectangle
  L2_2 = L2_2(L3_2)
  L3_2 = creator
  L4_2 = L3_2
  L3_2 = L3_2.open
  L3_2(L4_2)
  L3_2 = creator
  L4_2 = L3_2
  L3_2 = L3_2.destroyTempEntities
  L3_2(L4_2)
  if not L2_2 then
    L3_2 = A1_2
    L4_2 = nil
    return L3_2(L4_2)
  end
  L3_2 = table
  L3_2 = L3_2.map
  L4_2 = L2_2.points
  function L5_2(A0_3)
    local L1_3, L2_3
    L1_3 = {}
    L2_3 = A0_3.x
    L1_3.x = L2_3
    L2_3 = A0_3.y
    L1_3.y = L2_3
    L2_3 = A0_3.z
    L1_3.z = L2_3
    return L1_3
  end
  L3_2 = L3_2(L4_2, L5_2)
  L2_2.points = L3_2
  L3_2 = A1_2
  L4_2 = L2_2
  L3_2(L4_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "select_house"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = creator
  L2_2 = L2_2.raycast
  L3_2 = A0_2.island
  L2_2.island = L3_2
  L2_2 = creator
  L2_2 = L2_2.raycast
  L3_2 = A0_2.houseObject
  L2_2.houseObject = L3_2
  L2_2 = A0_2 or L2_2
  if A0_2 then
    L2_2 = A0_2.zone
    if L2_2 then
      L2_2 = L2_2.points
    end
  end
  if L2_2 then
    L2_2 = creator
    L2_2 = L2_2.raycast
    L3_2 = table
    L3_2 = L3_2.map
    L4_2 = A0_2.zone
    L4_2 = L4_2.points
    function L5_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3
      L1_3 = vec3
      L2_3 = A0_3.x
      L3_3 = A0_3.y
      L4_3 = A0_3.z
      return L1_3(L2_3, L3_3, L4_3)
    end
    L3_2 = L3_2(L4_2, L5_2)
    L2_2.points = L3_2
    L2_2 = creator
    L2_2 = L2_2.raycast
    L3_2 = A0_2.zone
    L3_2 = L3_2.thickness
    L2_2.height = L3_2
  else
    L2_2 = creator
    L2_2 = L2_2.raycast
    L3_2 = {}
    L2_2.points = L3_2
  end
  L2_2 = A1_2
  L3_2 = true
  L2_2(L3_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "select_point"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = A0_2 or nil
  if A0_2 then
    L2_2 = A0_2.options
    if L2_2 then
      L2_2 = L2_2.model
    end
  end
  if L2_2 then
    L2_2 = IsModelInCdimage
    L3_2 = A0_2.options
    L3_2 = L3_2.model
    L2_2 = L2_2(L3_2)
    if not L2_2 then
      L2_2 = Notification
      L3_2 = i18n
      L3_2 = L3_2.t
      L4_2 = "creator.raycast.model_is_not_valid"
      L5_2 = {}
      L6_2 = A0_2.options
      L6_2 = L6_2.model
      L5_2.model = L6_2
      L3_2 = L3_2(L4_2, L5_2)
      L4_2 = "error"
      L2_2(L3_2, L4_2)
      L2_2 = A1_2
      L3_2 = nil
      return L2_2(L3_2)
    end
  end
  L2_2 = A0_2 or L2_2
  if A0_2 then
    L2_2 = A0_2.pointType
  end
  if not L2_2 then
    L2_2 = "empty"
  end
  L3_2 = A0_2 or L3_2
  if A0_2 then
    L3_2 = A0_2.count
  end
  if not L3_2 then
    L3_2 = 1
  end
  L4_2 = creator
  L5_2 = L4_2
  L4_2 = L4_2.spawnTempEntities
  L4_2(L5_2)
  L4_2 = creator
  L5_2 = L4_2
  L4_2 = L4_2.selectPoint
  L6_2 = L2_2
  L7_2 = L3_2
  L8_2 = A0_2 or L8_2
  if A0_2 then
    L8_2 = A0_2.options
  end
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = creator
  L6_2 = L5_2
  L5_2 = L5_2.open
  L5_2(L6_2)
  L5_2 = creator
  L6_2 = L5_2
  L5_2 = L5_2.destroyTempEntities
  L5_2(L6_2)
  if not L4_2 then
    L5_2 = A1_2
    L6_2 = nil
    return L5_2(L6_2)
  end
  L5_2 = table
  L5_2 = L5_2.map
  L6_2 = L4_2
  function L7_2(A0_3)
    local L1_3, L2_3
    L1_3 = {}
    L2_3 = A0_3.x
    L1_3.x = L2_3
    L2_3 = A0_3.y
    L1_3.y = L2_3
    L2_3 = A0_3.z
    L1_3.z = L2_3
    L2_3 = A0_3.w
    if L2_3 then
      L2_3 = A0_3.w
      L1_3.w = L2_3
    end
    return L1_3
  end
  L5_2 = L5_2(L6_2, L7_2)
  L4_2 = L5_2
  if 1 == L3_2 then
    L5_2 = A1_2
    L6_2 = L4_2[1]
    L5_2(L6_2)
    return
  end
  L5_2 = A1_2
  L6_2 = L4_2
  L5_2(L6_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "select_entity"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = A0_2 or nil
  if A0_2 then
    L2_2 = A0_2.entityType
  end
  if not L2_2 then
    L2_2 = "object"
  end
  L3_2 = A0_2 or L3_2
  if A0_2 then
    L3_2 = A0_2.count
  end
  if not L3_2 then
    L3_2 = 1
  end
  L4_2 = Debug
  L5_2 = "select_entity"
  L6_2 = A0_2
  L4_2(L5_2, L6_2)
  L4_2 = creator
  L5_2 = L4_2
  L4_2 = L4_2.spawnTempEntities
  L4_2(L5_2)
  L4_2 = creator
  L5_2 = L4_2
  L4_2 = L4_2.selectEntity
  L6_2 = L2_2
  L7_2 = L3_2
  L8_2 = A0_2 or L8_2
  if A0_2 then
    L8_2 = A0_2.options
  end
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = creator
  L6_2 = L5_2
  L5_2 = L5_2.open
  L5_2(L6_2)
  L5_2 = creator
  L6_2 = L5_2
  L5_2 = L5_2.destroyTempEntities
  L5_2(L6_2)
  if not L4_2 then
    L5_2 = A1_2
    L6_2 = nil
    return L5_2(L6_2)
  end
  L5_2 = table
  L5_2 = L5_2.map
  L6_2 = L4_2
  function L7_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = {}
    L2_3 = A0_3.entity
    L1_3.entity = L2_3
    L2_3 = {}
    L3_3 = A0_3.coords
    L3_3 = L3_3.x
    L2_3.x = L3_3
    L3_3 = A0_3.coords
    L3_3 = L3_3.y
    L2_3.y = L3_3
    L3_3 = A0_3.coords
    L3_3 = L3_3.z
    L2_3.z = L3_3
    L3_3 = A0_3.coords
    L3_3 = L3_3.w
    L2_3.w = L3_3
    L1_3.coords = L2_3
    return L1_3
  end
  L5_2 = L5_2(L6_2, L7_2)
  L4_2 = L5_2
  if 1 == L3_2 then
    L5_2 = A1_2
    L6_2 = L4_2[1]
    L5_2(L6_2)
    return
  end
  L5_2 = A1_2
  L6_2 = L4_2
  L5_2(L6_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "create_house"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = Debug
  L3_2 = "create_house"
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
  L2_2 = A0_2.name
  L3_2 = L2_2
  L2_2 = L2_2.lower
  L2_2 = L2_2(L3_2)
  L3_2 = L2_2
  L2_2 = L2_2.gsub
  L4_2 = "%s+"
  L5_2 = "_"
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = L2_2
  L2_2 = L2_2.gsub
  L4_2 = "-"
  L5_2 = "_"
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  A0_2.name = L2_2
  L2_2 = A0_2.apartmentCount
  if 0 ~= L2_2 then
    L2_2 = A0_2.apartmentCount
    if L2_2 then
      goto lbl_24
    end
  end
  L2_2 = nil
  ::lbl_24::
  A0_2.apartmentCount = L2_2
  L2_2 = A0_2.coords
  L3_2 = {}
  L4_2 = A0_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.x
  L3_2.x = L4_2
  L4_2 = A0_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.y
  L3_2.y = L4_2
  L4_2 = A0_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.z
  L3_2.z = L4_2
  L4_2 = A0_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.w
  L3_2.h = L4_2
  L3_2.yaw = -10.0
  L2_2.cam = L3_2
  L2_2 = A0_2.coords
  L3_2 = {}
  L4_2 = A0_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.x
  L3_2.x = L4_2
  L4_2 = A0_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.y
  L3_2.y = L4_2
  L4_2 = A0_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.z
  L3_2.z = L4_2
  L4_2 = A0_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.w
  L3_2.h = L4_2
  L2_2.enter = L3_2
  L2_2 = A0_2.coords
  L2_2 = L2_2.exit
  if L2_2 then
    L2_2 = A0_2.coords
    L3_2 = {}
    L4_2 = A0_2.coords
    L4_2 = L4_2.exit
    L4_2 = L4_2.x
    L3_2.x = L4_2
    L4_2 = A0_2.coords
    L4_2 = L4_2.exit
    L4_2 = L4_2.y
    L3_2.y = L4_2
    L4_2 = A0_2.coords
    L4_2 = L4_2.exit
    L4_2 = L4_2.z
    L3_2.z = L4_2
    L4_2 = A0_2.coords
    L4_2 = L4_2.exit
    L4_2 = L4_2.w
    L3_2.h = L4_2
    L2_2.exit = L3_2
  end
  L2_2 = A0_2.coords
  L2_2 = L2_2.shellCoords
  if L2_2 then
    L2_2 = A0_2.coords
    L3_2 = {}
    L4_2 = A0_2.coords
    L4_2 = L4_2.shellCoords
    L4_2 = L4_2.x
    L3_2.x = L4_2
    L4_2 = A0_2.coords
    L4_2 = L4_2.shellCoords
    L4_2 = L4_2.y
    L3_2.y = L4_2
    L4_2 = A0_2.coords
    L4_2 = L4_2.shellCoords
    L4_2 = L4_2.z
    L3_2.z = L4_2
    L4_2 = A0_2.coords
    L4_2 = L4_2.shellCoords
    L4_2 = L4_2.w
    if not L4_2 then
      L4_2 = A0_2.coords
      L4_2 = L4_2.shellCoords
      L4_2 = L4_2.h
    end
    L3_2.h = L4_2
    L2_2.shellCoords = L3_2
  end
  L2_2 = GetEntityCoords
  L3_2 = cache
  L3_2 = L3_2.ped
  L2_2 = L2_2(L3_2)
  L3_2 = GetStreetNameAtCoord
  L4_2 = L2_2.x
  L5_2 = L2_2.y
  L6_2 = L2_2.z
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = GetStreetNameFromHashKey
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = lib
  L5_2 = L5_2.callback
  L5_2 = L5_2.await
  L6_2 = "housing:createHouse"
  L7_2 = false
  L8_2 = L4_2
  L9_2 = A0_2
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L6_2 = A1_2
  L7_2 = L5_2
  L6_2(L7_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "update_house"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = A0_2.coords
  L3_2 = {}
  L4_2 = A0_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.x
  L3_2.x = L4_2
  L4_2 = A0_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.y
  L3_2.y = L4_2
  L4_2 = A0_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.z
  L3_2.z = L4_2
  L4_2 = A0_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.w
  L3_2.h = L4_2
  L3_2.yaw = -10.0
  L2_2.cam = L3_2
  L2_2 = A0_2.coords
  L3_2 = {}
  L4_2 = A0_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.x
  L3_2.x = L4_2
  L4_2 = A0_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.y
  L3_2.y = L4_2
  L4_2 = A0_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.z
  L3_2.z = L4_2
  L4_2 = A0_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.w
  L3_2.h = L4_2
  L2_2.enter = L3_2
  L2_2 = A0_2.coords
  L2_2 = L2_2.exit
  if L2_2 then
    L2_2 = A0_2.coords
    L3_2 = {}
    L4_2 = A0_2.coords
    L4_2 = L4_2.exit
    L4_2 = L4_2.x
    L3_2.x = L4_2
    L4_2 = A0_2.coords
    L4_2 = L4_2.exit
    L4_2 = L4_2.y
    L3_2.y = L4_2
    L4_2 = A0_2.coords
    L4_2 = L4_2.exit
    L4_2 = L4_2.z
    L3_2.z = L4_2
    L4_2 = A0_2.coords
    L4_2 = L4_2.exit
    L4_2 = L4_2.w
    L3_2.h = L4_2
    L2_2.exit = L3_2
  end
  L2_2 = A0_2.coords
  L2_2 = L2_2.shellCoords
  if L2_2 then
    L2_2 = A0_2.coords
    L3_2 = {}
    L4_2 = A0_2.coords
    L4_2 = L4_2.shellCoords
    L4_2 = L4_2.x
    L3_2.x = L4_2
    L4_2 = A0_2.coords
    L4_2 = L4_2.shellCoords
    L4_2 = L4_2.y
    L3_2.y = L4_2
    L4_2 = A0_2.coords
    L4_2 = L4_2.shellCoords
    L4_2 = L4_2.z
    L3_2.z = L4_2
    L4_2 = A0_2.coords
    L4_2 = L4_2.shellCoords
    L4_2 = L4_2.w
    if not L4_2 then
      L4_2 = A0_2.coords
      L4_2 = L4_2.shellCoords
      L4_2 = L4_2.h
    end
    L3_2.h = L4_2
    L2_2.shellCoords = L3_2
  end
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:updateHouse"
  L4_2 = false
  L5_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  if L2_2 then
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "creator.house_updated"
    L4_2 = L4_2(L5_2)
    L5_2 = "success"
    L3_2(L4_2, L5_2)
  else
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "creator.house_update_failed"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  end
  L3_2 = A1_2
  L4_2 = L2_2
  L3_2(L4_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "remove_house"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:removeHouse"
  L4_2 = false
  L5_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = A1_2
  L4_2 = L2_2
  L3_2(L4_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "creator:remove_owner"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:removeHouseOwner"
  L4_2 = false
  L5_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = A1_2
  L4_2 = L2_2
  L3_2(L4_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "teleport_to_house"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A0_2]
  if not L2_2 then
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "house_not_found"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
    L3_2 = A1_2
    L4_2 = false
    return L3_2(L4_2)
  end
  L3_2 = lib
  L3_2 = L3_2.callback
  L3_2 = L3_2.await
  L4_2 = "housing:hasPermission"
  L5_2 = false
  L6_2 = true
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  if not L3_2 then
    L4_2 = Notification
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "no_permission"
    L5_2 = L5_2(L6_2)
    L6_2 = "error"
    L4_2(L5_2, L6_2)
    L4_2 = A1_2
    L5_2 = false
    return L4_2(L5_2)
  end
  L4_2 = L2_2.coords
  L4_2 = L4_2.enter
  L5_2 = RequestCollisionAtCoord
  L6_2 = L4_2.x
  L7_2 = L4_2.y
  L8_2 = L4_2.z
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = SetEntityCoords
  L6_2 = cache
  L6_2 = L6_2.ped
  L7_2 = L4_2.x
  L8_2 = L4_2.y
  L9_2 = L4_2.z
  L10_2 = false
  L11_2 = false
  L12_2 = false
  L13_2 = false
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L5_2 = Notification
  L6_2 = i18n
  L6_2 = L6_2.t
  L7_2 = "creator.teleported_to_house"
  L8_2 = {}
  L8_2.house = A0_2
  L6_2 = L6_2(L7_2, L8_2)
  L7_2 = "success"
  L5_2(L6_2, L7_2)
  L5_2 = A1_2
  L6_2 = true
  L5_2(L6_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "creator_select_house_object"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = nil
  if A0_2 then
    L3_2 = {}
    L3_2.isIsland = true
    L3_2.camOffset = 20.0
    L2_2 = L3_2
  end
  L3_2 = creator
  L4_2 = L3_2
  L3_2 = L3_2.spawnTempEntities
  L3_2(L4_2)
  L3_2 = RayCastSelector
  L4_2 = "customHouse"
  L5_2 = L2_2
  L3_2, L4_2 = L3_2(L4_2, L5_2)
  L5_2 = creator
  L6_2 = L5_2
  L5_2 = L5_2.destroyTempEntities
  L5_2(L6_2)
  if A0_2 then
    L5_2 = "island"
    if L5_2 then
      goto lbl_25
    end
  end
  L5_2 = "houseObject"
  ::lbl_25::
  if not L3_2 or not L4_2 then
    L6_2 = creator
    L6_2 = L6_2.raycast
    L6_2[L5_2] = nil
    L6_2 = creator
    L7_2 = L6_2
    L6_2 = L6_2.open
    L6_2(L7_2)
    L6_2 = A1_2
    L7_2 = nil
    return L6_2(L7_2)
  end
  if A0_2 then
    L6_2 = Config
    L6_2 = L6_2.Islands
    L6_2 = L6_2[L3_2]
    L6_2 = L6_2.model
    if L6_2 then
      goto lbl_51
    end
  end
  L6_2 = Config
  L6_2 = L6_2.HouseObjects
  L6_2 = L6_2[L3_2]
  L6_2 = L6_2.model
  ::lbl_51::
  L7_2 = creator
  L7_2 = L7_2.raycast
  L8_2 = {}
  L8_2.model = L6_2
  L9_2 = {}
  L10_2 = L4_2.x
  L9_2.x = L10_2
  L10_2 = L4_2.y
  L9_2.y = L10_2
  L10_2 = L4_2.z
  L9_2.z = L10_2
  L10_2 = L4_2.w
  L9_2.w = L10_2
  L8_2.coords = L9_2
  L7_2[L5_2] = L8_2
  L7_2 = creator
  L8_2 = L7_2
  L7_2 = L7_2.open
  L7_2(L8_2)
  L7_2 = A1_2
  L8_2 = {}
  L8_2.model = L6_2
  L9_2 = {}
  L10_2 = L4_2.x
  L9_2.x = L10_2
  L10_2 = L4_2.y
  L9_2.y = L10_2
  L10_2 = L4_2.z
  L9_2.z = L10_2
  L10_2 = L4_2.w
  L9_2.w = L10_2
  L8_2.coords = L9_2
  L7_2(L8_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "creator_select_mlo_doors"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = creator
  L3_2 = L2_2
  L2_2 = L2_2.spawnTempEntities
  L2_2(L3_2)
  L2_2 = RayCastGetMLO
  L2_2 = L2_2()
  L3_2 = creator
  L4_2 = L3_2
  L3_2 = L3_2.destroyTempEntities
  L3_2(L4_2)
  if not L2_2 then
    L3_2 = creator
    L4_2 = L3_2
    L3_2 = L3_2.open
    L3_2(L4_2)
    L3_2 = A1_2
    L4_2 = nil
    return L3_2(L4_2)
  end
  L3_2 = creator
  L4_2 = L3_2
  L3_2 = L3_2.open
  L3_2(L4_2)
  L3_2 = table
  L3_2 = L3_2.map
  L4_2 = L2_2
  function L5_2(A0_3)
    local L1_3, L2_3
    L1_3 = {}
    L2_3 = A0_3.coords
    L2_3 = L2_3.x
    L1_3.x = L2_3
    L2_3 = A0_3.coords
    L2_3 = L2_3.y
    L1_3.y = L2_3
    L2_3 = A0_3.coords
    L2_3 = L2_3.z
    L1_3.z = L2_3
    L2_3 = A0_3.coords
    L2_3 = L2_3.w
    L1_3.w = L2_3
    A0_3.coords = L1_3
    return A0_3
  end
  L3_2 = L3_2(L4_2, L5_2)
  L2_2 = L3_2
  L3_2 = A1_2
  L4_2 = L2_2
  L3_2(L4_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "creator_select_ipl"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = creator
  L3_2 = L2_2
  L2_2 = L2_2.spawnTempEntities
  L2_2(L3_2)
  L2_2 = GetEntityCoords
  L3_2 = cache
  L3_2 = L3_2.ped
  L2_2 = L2_2(L3_2)
  CreatorStartedPosition = L2_2
  L2_2 = showCaseOfIplHouse
  L2_2 = L2_2()
  L3_2 = creator
  L4_2 = L3_2
  L3_2 = L3_2.destroyTempEntities
  L3_2(L4_2)
  if not L2_2 then
    L3_2 = creator
    L4_2 = L3_2
    L3_2 = L3_2.open
    L3_2(L4_2)
    L3_2 = A1_2
    L4_2 = nil
    return L3_2(L4_2)
  end
  L3_2 = Config
  L3_2 = L3_2.IplData
  L3_2 = L3_2[L2_2]
  L4_2 = L3_2 or L4_2
  if L3_2 then
    L4_2 = L3_2.export
  end
  if L4_2 then
    L5_2 = L4_2
    L5_2 = L5_2()
    L4_2 = L5_2
  end
  L5_2 = {}
  L5_2.houseName = L2_2
  L6_2 = {}
  L7_2 = L3_2.exitCoords
  L7_2 = L7_2.x
  L6_2.x = L7_2
  L7_2 = L3_2.exitCoords
  L7_2 = L7_2.y
  L6_2.y = L7_2
  L7_2 = L3_2.exitCoords
  L7_2 = L7_2.z
  L6_2.z = L7_2
  L5_2.exit = L6_2
  L6_2 = L4_2 or L6_2
  if L4_2 then
    L6_2 = L4_2.Style
    L6_2 = L6_2.Theme
    L7_2 = L3_2.defaultTheme
    L6_2 = L6_2[L7_2]
  end
  L5_2.theme = L6_2
  L6_2 = L3_2 or L6_2
  if L3_2 then
    L6_2 = L3_2.themes
  end
  L5_2.themes = L6_2
  L6_2 = L3_2 or L6_2
  if L3_2 then
    L6_2 = L3_2.stash
  end
  L5_2.stash = L6_2
  L6_2 = creator
  L7_2 = L6_2
  L6_2 = L6_2.open
  L6_2(L7_2)
  L6_2 = A1_2
  L7_2 = L5_2
  L6_2(L7_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "creator_select_shell"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = creator
  L3_2 = L2_2
  L2_2 = L2_2.spawnTempEntities
  L2_2(L3_2)
  L2_2 = RayCastSelector
  L3_2 = "shell"
  L2_2, L3_2 = L2_2(L3_2)
  L4_2 = creator
  L5_2 = L4_2
  L4_2 = L4_2.destroyTempEntities
  L4_2(L5_2)
  if not L2_2 or not L3_2 then
    L4_2 = creator
    L5_2 = L4_2
    L4_2 = L4_2.open
    L4_2(L5_2)
    L4_2 = A1_2
    L5_2 = nil
    return L4_2(L5_2)
  end
  L4_2 = creator
  L5_2 = L4_2
  L4_2 = L4_2.open
  L4_2(L5_2)
  L4_2 = A1_2
  L5_2 = {}
  L5_2.tier = L2_2
  L6_2 = {}
  L7_2 = L3_2.x
  L6_2.x = L7_2
  L7_2 = L3_2.y
  L6_2.y = L7_2
  L7_2 = L3_2.z
  L6_2.z = L7_2
  L7_2 = L3_2.w
  L6_2.w = L7_2
  L5_2.coords = L6_2
  L4_2(L5_2)
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNUICallback
L1_1 = "creator_select_exit_coords"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = creator
  L3_2 = L2_2
  L2_2 = L2_2.spawnTempEntities
  L2_2(L3_2)
  L2_2 = RayCastSelector
  L3_2 = "exit"
  L4_2 = {}
  L5_2 = A0_2.tier
  L4_2.tier = L5_2
  L5_2 = vec4
  L6_2 = A0_2.coords
  L6_2 = L6_2.x
  L7_2 = A0_2.coords
  L7_2 = L7_2.y
  L8_2 = A0_2.coords
  L8_2 = L8_2.z
  L9_2 = A0_2.coords
  L9_2 = L9_2.w
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L4_2.coords = L5_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = creator
  L4_2 = L3_2
  L3_2 = L3_2.destroyTempEntities
  L3_2(L4_2)
  if not L2_2 then
    L3_2 = creator
    L4_2 = L3_2
    L3_2 = L3_2.open
    L3_2(L4_2)
    L3_2 = A1_2
    L4_2 = nil
    return L3_2(L4_2)
  end
  L3_2 = creator
  L4_2 = L3_2
  L3_2 = L3_2.open
  L3_2(L4_2)
  L3_2 = A1_2
  L4_2 = {}
  L5_2 = L2_2.x
  L4_2.x = L5_2
  L5_2 = L2_2.y
  L4_2.y = L5_2
  L5_2 = L2_2.z
  L4_2.z = L5_2
  L5_2 = L2_2.w
  L4_2.w = L5_2
  L3_2(L4_2)
end
L0_1(L1_1, L2_1)
function L0_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Config
  L0_2 = L0_2.Garage
  if "qs-advancedgarages" ~= L0_2 then
    L0_2 = {}
    return L0_2
  end
  L0_2 = exports
  L0_2 = L0_2["qs-advancedgarages"]
  L1_2 = L0_2
  L0_2 = L0_2.ShowCaseOfGarageShell
  L2_2 = nil
  L3_2 = "vehicle"
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  L1_2 = {}
  L1_2.shell = L0_2
  return L1_2
end
L1_1 = exports
L2_1 = "getGarageShell"
L3_1 = L0_1
L1_1(L2_1, L3_1)
L1_1 = RegisterNUICallback
L2_1 = "creator_select_garage"
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = creator
  L3_2 = L2_2
  L2_2 = L2_2.spawnTempEntities
  L2_2(L3_2)
  L2_2 = {}
  L3_2 = A0_2.coords
  L3_2 = L3_2.x
  L2_2.x = L3_2
  L3_2 = A0_2.coords
  L3_2 = L3_2.y
  L2_2.y = L3_2
  L3_2 = A0_2.coords
  L3_2 = L3_2.z
  L2_2.z = L3_2
  L3_2 = A0_2.coords
  L3_2 = L3_2.w
  L2_2.h = L3_2
  L3_2 = L0_1
  L3_2 = L3_2()
  L4_2 = creator
  L5_2 = L4_2
  L4_2 = L4_2.destroyTempEntities
  L4_2(L5_2)
  L4_2 = creator
  L5_2 = L4_2
  L4_2 = L4_2.open
  L4_2(L5_2)
  L4_2 = A1_2
  L5_2 = {}
  L5_2.coords = L2_2
  L5_2.shellData = L3_2
  L4_2(L5_2)
end
L1_1(L2_1, L3_1)
L1_1 = RegisterNUICallback
L2_1 = "create_furniture_shop"
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = Debug
  L3_2 = "create_furniture_shop"
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:createFurnitureShop"
  L4_2 = false
  L5_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = A1_2
  L4_2 = L2_2
  L3_2(L4_2)
end
L1_1(L2_1, L3_1)
L1_1 = RegisterNUICallback
L2_1 = "update_furniture_shop"
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = Debug
  L3_2 = "update_furniture_shop"
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:updateFurnitureShop"
  L4_2 = false
  L5_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = A1_2
  L4_2 = L2_2
  L3_2(L4_2)
end
L1_1(L2_1, L3_1)
L1_1 = RegisterNUICallback
L2_1 = "remove_furniture_shop"
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = Debug
  L3_2 = "remove_furniture_shop"
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:removeFurnitureShop"
  L4_2 = false
  L5_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = A1_2
  L4_2 = L2_2
  L3_2(L4_2)
end
L1_1(L2_1, L3_1)
L1_1 = RegisterNUICallback
L2_1 = "teleport_to_furniture_shop"
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = nil
  L3_2 = pairs
  L4_2 = Config
  L4_2 = L4_2.FurnitureShops
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = L8_2.id
    if L9_2 == A0_2 then
      L2_2 = L8_2
      break
    end
  end
  if L2_2 then
    L3_2 = L2_2.enter
    if L3_2 then
      goto lbl_34
    end
  end
  L3_2 = Notification
  L4_2 = i18n
  L4_2 = L4_2.t
  L5_2 = "creator.furniture_shop_creator.shop_not_found"
  L4_2 = L4_2(L5_2)
  if not L4_2 then
    L4_2 = "Shop not found"
  end
  L5_2 = "error"
  L3_2(L4_2, L5_2)
  L3_2 = A1_2
  L4_2 = false
  do return L3_2(L4_2) end
  ::lbl_34::
  L3_2 = lib
  L3_2 = L3_2.callback
  L3_2 = L3_2.await
  L4_2 = "housing:hasPermission"
  L5_2 = false
  L6_2 = true
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  if not L3_2 then
    L4_2 = Notification
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "no_permission"
    L5_2 = L5_2(L6_2)
    L6_2 = "error"
    L4_2(L5_2, L6_2)
    L4_2 = A1_2
    L5_2 = false
    return L4_2(L5_2)
  end
  L4_2 = L2_2.enter
  L5_2 = RequestCollisionAtCoord
  L6_2 = L4_2.x
  L7_2 = L4_2.y
  L8_2 = L4_2.z
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = SetEntityCoords
  L6_2 = cache
  L6_2 = L6_2.ped
  L7_2 = L4_2.x
  L8_2 = L4_2.y
  L9_2 = L4_2.z
  L10_2 = false
  L11_2 = false
  L12_2 = false
  L13_2 = false
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L5_2 = Notification
  L6_2 = i18n
  L6_2 = L6_2.t
  L7_2 = "creator.furniture_shop_creator.teleported_to_shop"
  L8_2 = {}
  L9_2 = L2_2.name
  L8_2.name = L9_2
  L6_2 = L6_2(L7_2, L8_2)
  if not L6_2 then
    L6_2 = "Teleported to "
    L7_2 = L2_2.name
    L6_2 = L6_2 .. L7_2
  end
  L7_2 = "success"
  L5_2(L6_2, L7_2)
  L5_2 = A1_2
  L6_2 = true
  L5_2(L6_2)
end
L1_1(L2_1, L3_1)
L1_1 = RegisterNUICallback
L2_1 = "get_apartment_units"
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:getApartmentUnits"
  L4_2 = false
  L5_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = A1_2
  L4_2 = L2_2
  L3_2(L4_2)
end
L1_1(L2_1, L3_1)
L1_1 = RegisterNUICallback
L2_1 = "change_apartment_shell"
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = creator
  L3_2 = L2_2
  L2_2 = L2_2.close
  L2_2(L3_2)
  L2_2 = creator
  L3_2 = L2_2
  L2_2 = L2_2.spawnTempEntities
  L2_2(L3_2)
  L2_2 = RayCastSelector
  L3_2 = "shell"
  L2_2, L3_2 = L2_2(L3_2)
  L4_2 = creator
  L5_2 = L4_2
  L4_2 = L4_2.destroyTempEntities
  L4_2(L5_2)
  if not L2_2 or not L3_2 then
    L4_2 = creator
    L5_2 = L4_2
    L4_2 = L4_2.open
    L4_2(L5_2)
    L4_2 = A1_2
    L5_2 = nil
    return L4_2(L5_2)
  end
  L4_2 = Notification
  L5_2 = i18n
  L5_2 = L5_2.t
  L6_2 = "creator.raycast.select_exit"
  L5_2 = L5_2(L6_2)
  if not L5_2 then
    L5_2 = "Select exit position inside the shell"
  end
  L6_2 = "info"
  L4_2(L5_2, L6_2)
  L4_2 = RayCastSelector
  L5_2 = "exit"
  L6_2 = {}
  L6_2.tier = L2_2
  L6_2.coords = L3_2
  L4_2 = L4_2(L5_2, L6_2)
  if not L4_2 then
    L5_2 = creator
    L6_2 = L5_2
    L5_2 = L5_2.open
    L5_2(L6_2)
    L5_2 = A1_2
    L6_2 = nil
    return L5_2(L6_2)
  end
  L5_2 = {}
  L5_2.tier = L2_2
  L6_2 = {}
  L7_2 = L3_2.x
  L6_2.x = L7_2
  L7_2 = L3_2.y
  L6_2.y = L7_2
  L7_2 = L3_2.z
  L6_2.z = L7_2
  L7_2 = L3_2.w
  L6_2.h = L7_2
  L5_2.shellCoords = L6_2
  L6_2 = {}
  L7_2 = L4_2.x
  L6_2.x = L7_2
  L7_2 = L4_2.y
  L6_2.y = L7_2
  L7_2 = L4_2.z
  L6_2.z = L7_2
  L7_2 = L4_2.w
  L6_2.h = L7_2
  L5_2.exit = L6_2
  L6_2 = lib
  L6_2 = L6_2.callback
  L6_2 = L6_2.await
  L7_2 = "housing:updateApartmentShell"
  L8_2 = false
  L9_2 = A0_2.apartmentName
  L10_2 = L5_2
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L7_2 = creator
  L8_2 = L7_2
  L7_2 = L7_2.open
  L7_2(L8_2)
  L7_2 = A1_2
  if L6_2 then
    L8_2 = {}
    L8_2.tier = L2_2
    if L8_2 then
      goto lbl_95
    end
  end
  L8_2 = nil
  ::lbl_95::
  L7_2(L8_2)
end
L1_1(L2_1, L3_1)
L1_1 = RegisterNUICallback
L2_1 = "change_apartment_ipl"
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = creator
  L3_2 = L2_2
  L2_2 = L2_2.spawnTempEntities
  L2_2(L3_2)
  L2_2 = GetEntityCoords
  L3_2 = cache
  L3_2 = L3_2.ped
  L2_2 = L2_2(L3_2)
  CreatorStartedPosition = L2_2
  L2_2 = showCaseOfIplHouse
  L2_2 = L2_2()
  L3_2 = creator
  L4_2 = L3_2
  L3_2 = L3_2.destroyTempEntities
  L3_2(L4_2)
  if not L2_2 then
    L3_2 = creator
    L4_2 = L3_2
    L3_2 = L3_2.open
    L3_2(L4_2)
    L3_2 = A1_2
    L4_2 = nil
    return L3_2(L4_2)
  end
  L3_2 = Config
  L3_2 = L3_2.IplData
  L3_2 = L3_2[L2_2]
  L4_2 = L3_2 or L4_2
  if L3_2 then
    L4_2 = L3_2.export
  end
  if L4_2 then
    L5_2 = L4_2
    L5_2 = L5_2()
    L4_2 = L5_2
  end
  L5_2 = {}
  L5_2.houseName = L2_2
  L6_2 = {}
  L7_2 = L3_2.exitCoords
  L7_2 = L7_2.x
  L6_2.x = L7_2
  L7_2 = L3_2.exitCoords
  L7_2 = L7_2.y
  L6_2.y = L7_2
  L7_2 = L3_2.exitCoords
  L7_2 = L7_2.z
  L6_2.z = L7_2
  L5_2.exit = L6_2
  if L4_2 then
    L6_2 = L4_2.Style
    L6_2 = L6_2.Theme
    L7_2 = L3_2.defaultTheme
    L6_2 = L6_2[L7_2]
    if L6_2 then
      goto lbl_58
    end
  end
  L6_2 = nil
  ::lbl_58::
  L5_2.theme = L6_2
  L6_2 = L3_2.themes
  L5_2.themes = L6_2
  L6_2 = L3_2.stash
  L5_2.stash = L6_2
  L6_2 = lib
  L6_2 = L6_2.callback
  L6_2 = L6_2.await
  L7_2 = "housing:updateApartmentIpl"
  L8_2 = false
  L9_2 = A0_2.apartmentName
  L10_2 = L5_2
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L7_2 = creator
  L8_2 = L7_2
  L7_2 = L7_2.open
  L7_2(L8_2)
  L7_2 = A1_2
  if L6_2 then
    L8_2 = {}
    L8_2.houseName = L2_2
    if L8_2 then
      goto lbl_83
    end
  end
  L8_2 = nil
  ::lbl_83::
  L7_2(L8_2)
end
L1_1(L2_1, L3_1)






