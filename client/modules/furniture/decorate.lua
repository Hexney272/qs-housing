





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1
L0_1 = DisablePlayerFiring
L1_1 = IsControlJustPressed
L2_1 = IsDisabledControlJustPressed
L3_1 = IsControlJustReleased
L4_1 = IsDisabledControlJustReleased
L5_1 = Utils
L5_1 = L5_1.getCursorHitCoords
L6_1 = {}
L6_1.active = false
L6_1.currentObject = nil
L6_1.hide = false
L6_1.focus = false
L6_1.keepInput = false
L7_1 = {}
L6_1.objects = L7_1
L6_1.currentPage = "dynamic"
L6_1.mode = "mgizmo"
L6_1.freeCamera = false
L6_1.cameraFocus = false
L7_1 = _G
L8_1 = setmetatable
L9_1 = {}
L10_1 = {}
function L11_1(A0_2, A1_2)
  local L2_2
  L2_2 = L6_1
  L2_2 = L2_2[A1_2]
  return L2_2
end
L10_1.__index = L11_1
function L11_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = L6_1
  L3_2[A1_2] = A2_2
  if "currentObject" == A1_2 then
    if A2_2 then
      L3_2 = L6_1.currentPage
      if "stash" == L3_2 then
        L3_2 = SendReactMessage
        L4_2 = "select_stash_item"
        L5_2 = A2_2.stashId
        L3_2(L4_2, L5_2)
      end
      L3_2 = DoesEntityExist
      L4_2 = A2_2.handle
      L3_2 = L3_2(L4_2)
      if L3_2 then
        L3_2 = decorate
        L4_2 = L3_2
        L3_2 = L3_2.selectEntity
        L5_2 = A2_2.handle
        L3_2(L4_2, L5_2)
      else
        L3_2 = decorate
        L4_2 = L3_2
        L3_2 = L3_2.deselectEntity
        L3_2(L4_2)
      end
    else
      L3_2 = decorate
      L4_2 = L3_2
      L3_2 = L3_2.deselectEntity
      L3_2(L4_2)
    end
  end
end
L10_1.__newindex = L11_1
L8_1 = L8_1(L9_1, L10_1)
L7_1.decorate = L8_1
L7_1 = decorate
function L8_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = A0_2.active
  if not L2_2 then
    return
  end
  L2_2 = DrawingInstructional
  if L2_2 then
    DrawingInstructional = false
  end
  L2_2 = {}
  L3_2 = {}
  L3_2.key = "place_object_on_ground"
  L4_2 = ActionControls
  L4_2 = L4_2.place_object_on_ground
  L4_2 = L4_2.label
  L3_2.label = L4_2
  L4_2 = {}
  L4_2.key = "toggle_cursor"
  L5_2 = ActionControls
  L5_2 = L5_2.toggle_cursor
  L5_2 = L5_2.label
  L4_2.label = L5_2
  L5_2 = {}
  L5_2.key = "toggle_free_mode"
  L6_2 = ActionControls
  L6_2 = L6_2.toggle_free_mode
  L6_2 = L6_2.label
  L5_2.label = L6_2
  L6_2 = {}
  L6_2.key = "toggle_editor_mode"
  L7_2 = ActionControls
  L7_2 = L7_2.toggle_editor_mode
  L7_2 = L7_2.label
  L6_2.label = L7_2
  L7_2 = {}
  L7_2.key = "toggle_gizmo_mode"
  L8_2 = ActionControls
  L8_2 = L8_2.toggle_gizmo_mode
  L8_2 = L8_2.label
  L7_2.label = L8_2
  L8_2 = {}
  L8_2.key = "toggle_free_camera"
  L9_2 = ActionControls
  L9_2 = L9_2.toggle_free_camera
  L9_2 = L9_2.label
  L8_2.label = L9_2
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L2_2[4] = L6_2
  L2_2[5] = L7_2
  L2_2[6] = L8_2
  L3_2 = A0_2.currentObject
  if L3_2 then
    L3_2 = L3_2.stashId
  end
  if not L3_2 then
    L3_2 = #L2_2
    L3_2 = L3_2 + 1
    L4_2 = {}
    L4_2.key = "done"
    L5_2 = ActionControls
    L5_2 = L5_2.done
    L5_2 = L5_2.label
    L4_2.label = L5_2
    L2_2[L3_2] = L4_2
  end
  if A1_2 then
    L3_2 = pairs
    L4_2 = A1_2
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = #L2_2
      L9_2 = L9_2 + 1
      L2_2[L9_2] = L8_2
    end
  end
  L3_2 = Utils
  L3_2 = L3_2.DrawInstructional
  L4_2 = L2_2
  L3_2(L4_2)
end
L7_1.instructional = L8_1
L7_1 = decorate
function L8_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = A0_2.active
  if L1_2 then
    L1_2 = Debug
    L2_2 = "decorate:open ::: decorate is already active"
    return L1_2(L2_2)
  end
  L1_2 = CurrentHouse
  if not L1_2 then
    L1_2 = Notification
    L2_2 = i18n
    L2_2 = L2_2.t
    L3_2 = "decorate.not_in_garage"
    L2_2 = L2_2(L3_2)
    L3_2 = "error"
    return L1_2(L2_2, L3_2)
  end
  L1_2 = cleanerRobot
  if L1_2 then
    L1_2 = cleanerRobot
    L1_2 = L1_2.hasActiveCleaningRobot
    if L1_2 then
      L1_2 = cleanerRobot
      L2_2 = L1_2
      L1_2 = L1_2.hasActiveCleaningRobot
      L1_2 = L1_2(L2_2)
      if L1_2 then
        L2_2 = Notification
        L3_2 = i18n
        L3_2 = L3_2.t
        L4_2 = "decorate.robot_not_docked"
        L3_2 = L3_2(L4_2)
        L4_2 = "error"
        return L2_2(L3_2, L4_2)
      end
    end
  end
  L1_2 = lib
  L1_2 = L1_2.callback
  L1_2 = L1_2.await
  L2_2 = "housing:decorate:getDecorationAvailable"
  L3_2 = false
  L4_2 = CurrentHouse
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  if not L1_2 then
    L2_2 = Notification
    L3_2 = i18n
    L3_2 = L3_2.t
    L4_2 = "decorate.decoration_not_available"
    L3_2 = L3_2(L4_2)
    L4_2 = "error"
    return L2_2(L3_2, L4_2)
  end
  L2_2 = TriggerServerEvent
  L3_2 = "housing:decorate:updateDecorationUsedBy"
  L4_2 = CurrentHouse
  L5_2 = true
  L2_2(L3_2, L4_2, L5_2)
  A0_2.active = true
  L3_2 = A0_2
  L2_2 = A0_2.toggleFreeCamera
  L4_2 = true
  L2_2(L3_2, L4_2)
  L3_2 = A0_2
  L2_2 = A0_2.setFocus
  L4_2 = true
  L2_2(L3_2, L4_2)
  L2_2 = DisableIdleCamera
  L3_2 = true
  L2_2(L3_2)
  L3_2 = A0_2
  L2_2 = A0_2.getObjects
  L4_2 = CurrentHouse
  L2_2(L3_2, L4_2)
  L2_2 = SendReactMessage
  L3_2 = "toggle_decorate_menu"
  L4_2 = {}
  L4_2.visible = true
  L5_2 = Config
  L5_2 = L5_2.FurnitureNavigation
  L4_2.navigation = L5_2
  L5_2 = Config
  L5_2 = L5_2.Furniture
  L4_2.furniture = L5_2
  L5_2 = Config
  L5_2 = L5_2.EnableF3Shop
  L4_2.enableShop = L5_2
  L2_2(L3_2, L4_2)
  L2_2 = ToggleHud
  L3_2 = false
  L2_2(L3_2)
  L2_2 = TriggerServerEvent
  L3_2 = "housing:fiveguard:freecam"
  L4_2 = true
  L2_2(L3_2, L4_2)
  L3_2 = A0_2
  L2_2 = A0_2.instructional
  L2_2(L3_2)
  L2_2 = gizmo
  L3_2 = L2_2
  L2_2 = L2_2.handleCameraUpdate
  L2_2(L3_2)
  L2_2 = mgizmo
  L3_2 = L2_2
  L2_2 = L2_2.loop
  L2_2(L3_2)
  L3_2 = A0_2
  L2_2 = A0_2.handleControls
  L2_2(L3_2)
  L3_2 = A0_2
  L2_2 = A0_2.checkDistance
  L2_2(L3_2)
end
L7_1.open = L8_1
L7_1 = decorate
function L8_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = A0_2.active
  if not L1_2 then
    return
  end
  A0_2.active = false
  L1_2 = ToggleHud
  L2_2 = true
  L1_2(L2_2)
  L1_2 = DisableIdleCamera
  L2_2 = false
  L1_2(L2_2)
  L2_2 = A0_2
  L1_2 = A0_2.removeCurrentObject
  L1_2(L2_2)
  L1_2 = Utils
  L1_2 = L1_2.RemoveInstructional
  L1_2()
  L1_2 = SetNuiFocus
  L2_2 = false
  L3_2 = false
  L1_2(L2_2, L3_2)
  L1_2 = SetNuiFocusKeepInput
  L2_2 = false
  L1_2(L2_2)
  L1_2 = SendReactMessage
  L2_2 = "toggle_decorate_menu"
  L3_2 = {}
  L3_2.visible = false
  L1_2(L2_2, L3_2)
  A0_2.focus = false
  A0_2.keepInput = false
  DrawingInstructional = false
  L1_2 = TriggerServerEvent
  L2_2 = "housing:fiveguard:freecam"
  L3_2 = false
  L1_2(L2_2, L3_2)
  L1_2 = TriggerServerEvent
  L2_2 = "housing:decorate:updateDecorationUsedBy"
  L3_2 = CurrentHouse
  L4_2 = false
  L1_2(L2_2, L3_2, L4_2)
end
L7_1.close = L8_1
L7_1 = decorate
function L8_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = Config
  L1_2 = L1_2.MaximumDistanceForDecorate
  if not L1_2 then
    return
  end
  L1_2 = GetEntityCoords
  L2_2 = cache
  L2_2 = L2_2.ped
  L1_2 = L1_2(L2_2)
  L2_2 = CreateThread
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    while true do
      L0_3 = A0_2.active
      if not L0_3 then
        break
      end
      L0_3 = CurrentHouse
      if not L0_3 then
        break
      end
      L0_3 = GetFinalRenderedCamCoord
      L0_3 = L0_3()
      L1_3 = L1_2
      L1_3 = L0_3 - L1_3
      L1_3 = #L1_3
      L2_3 = Config
      L2_3 = L2_3.MaximumDistanceForDecorate
      L1_3 = L1_3 > L2_3
      if L1_3 then
        L2_3 = Notification
        L3_3 = i18n
        L3_3 = L3_3.t
        L4_3 = "decorate.too_far"
        L3_3 = L3_3(L4_3)
        L4_3 = "error"
        L2_3(L3_3, L4_3)
        L2_3 = A0_2
        L3_3 = L2_3
        L2_3 = L2_3.close
        L2_3(L3_3)
      end
      L2_3 = Wait
      L3_3 = 500
      L2_3(L3_3)
    end
  end
  L2_2(L3_2)
end
L7_1.checkDistance = L8_1
L7_1 = decorate
function L8_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = A0_2.mode
  if "gizmo" == L2_2 then
    L2_2 = gizmo
    if L2_2 then
      goto lbl_8
    end
  end
  L2_2 = mgizmo
  ::lbl_8::
  if A1_2 then
    L3_2 = DoesEntityExist
    L4_2 = A1_2
    L3_2 = L3_2(L4_2)
    if not L3_2 then
      L2_2.entity = nil
      L2_2.decorateData = nil
      return
    end
  end
  L3_2 = nil
  if A1_2 then
    L3_2 = A1_2
  else
    L4_2 = L5_1
    L4_2, L5_2 = L4_2()
    if L4_2 and L5_2 and 0 ~= L5_2 then
      L3_2 = L5_2
    end
  end
  if not L3_2 then
    return
  end
  L4_2 = decorate
  L4_2 = L4_2.currentPage
  if "stash" ~= L4_2 and not A1_2 then
    L4_2 = decorate
    L4_2 = L4_2.currentObject
    if L4_2 then
      L4_2 = L4_2.handle
    end
    if L4_2 ~= L3_2 then
      L4_2 = Notification
      L5_2 = i18n
      L5_2 = L5_2.t
      L6_2 = "decorate.you_cant_select_entity"
      L5_2 = L5_2(L6_2)
      L6_2 = "error"
      return L4_2(L5_2, L6_2)
    end
  end
  L4_2 = decorate
  L5_2 = L4_2
  L4_2 = L4_2.getObjectData
  L6_2 = L3_2
  L4_2 = L4_2(L5_2, L6_2)
  if not A1_2 and not L4_2 then
    return
  end
  L2_2.entity = L3_2
  L2_2.decorateData = L4_2
  L5_2 = decorate
  L5_2 = L5_2.currentObject
  if L5_2 then
    L5_2 = L5_2.handle
  end
  if L5_2 ~= L3_2 then
    L5_2 = decorate
    L6_2 = {}
    L6_2.handle = L3_2
    L7_2 = L4_2.modelName
    L6_2.modelName = L7_2
    L7_2 = L4_2.id
    L6_2.stashId = L7_2
    L5_2.currentObject = L6_2
  end
  L6_2 = L2_2
  L5_2 = L2_2.selectEntity
  L5_2(L6_2)
  L6_2 = A0_2
  L5_2 = A0_2.instructional
  L5_2(L6_2)
end
L7_1.selectEntity = L8_1
L7_1 = decorate
function L8_1(A0_2)
  local L1_2, L2_2
  L1_2 = gizmo
  L2_2 = L1_2
  L1_2 = L1_2.deselectEntity
  L1_2(L2_2)
  L2_2 = A0_2
  L1_2 = A0_2.instructional
  L1_2(L2_2)
end
L7_1.deselectEntity = L8_1
L7_1 = decorate
function L8_1(A0_2)
  local L1_2
  L1_2 = GetFinalRenderedCamCoord
  return L1_2()
end
L7_1.getCamCoords = L8_1
L7_1 = decorate
function L8_1(A0_2)
  local L1_2, L2_2
  L1_2 = GetFinalRenderedCamRot
  L2_2 = 2
  return L1_2(L2_2)
end
L7_1.getCamRot = L8_1
L7_1 = decorate
function L8_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = A0_2.hide
  L1_2 = not L1_2
  A0_2.hide = L1_2
  L1_2 = SendReactMessage
  L2_2 = "toggle_hide_decorate"
  L3_2 = A0_2.hide
  L1_2(L2_2, L3_2)
  L1_2 = A0_2.hide
  if L1_2 then
    L2_2 = A0_2
    L1_2 = A0_2.setFocus
    L3_2 = true
    L4_2 = true
    L1_2(L2_2, L3_2, L4_2)
  else
    L2_2 = A0_2
    L1_2 = A0_2.setFocus
    L3_2 = true
    L4_2 = false
    L1_2(L2_2, L3_2, L4_2)
  end
end
L7_1.toggleHideDecorate = L8_1
L7_1 = decorate
function L8_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = A1_2 or L3_2
  if not A1_2 or not A1_2 then
    L3_2 = A0_2.focus
    L3_2 = not L3_2
  end
  A0_2.focus = L3_2
  L3_2 = SetNuiFocus
  L4_2 = A0_2.focus
  L5_2 = A0_2.focus
  L3_2(L4_2, L5_2)
  if nil ~= A2_2 then
    A0_2.keepInput = A2_2
  else
    L3_2 = A0_2.focus
    L3_2 = not L3_2
    A0_2.keepInput = L3_2
  end
  A0_2.keepInput = A2_2
  L3_2 = SetNuiFocusKeepInput
  L4_2 = A0_2.keepInput
  L3_2(L4_2)
  L3_2 = A0_2.keepInput
  if not L3_2 then
    L3_2 = A0_2.mode
    if "mgizmo" == L3_2 then
      L4_2 = A0_2
      L3_2 = A0_2.toggleGizmoMode
      L5_2 = "gizmo"
      L3_2(L4_2, L5_2)
      L3_2 = Debug
      L4_2 = "setFocus ::: toggleGizmoMode to gizmo because keepInput is false"
      L3_2(L4_2)
    end
  end
end
L7_1.setFocus = L8_1
L7_1 = decorate
function L8_1(A0_2)
  local L1_2, L2_2
  L1_2 = decorate
  L1_2 = L1_2.currentObject
  if L1_2 then
    L1_2 = L1_2.handle
  end
  if not L1_2 then
    return
  end
  L1_2 = PlaceObjectOnGroundProperly
  L2_2 = decorate
  L2_2 = L2_2.currentObject
  L2_2 = L2_2.handle
  L1_2(L2_2)
  L1_2 = gizmo
  L2_2 = L1_2
  L1_2 = L1_2.updateGizmoEntity
  L1_2(L2_2)
end
L7_1.placeObjectOnGround = L8_1
L7_1 = decorate
function L8_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = A0_2.mode
  if "gizmo" == L2_2 then
    L2_2 = A0_2.keepInput
    if not L2_2 then
      L2_2 = Debug
      L3_2 = "toggleGizmoMode ::: mgizmo mode is enabled and keepInput is true, so we do not toggle mode"
      return L2_2(L3_2)
    end
  end
  if A1_2 then
    L2_2 = A0_2.mode
    if A1_2 == L2_2 then
      L2_2 = Debug
      L3_2 = "toggleGizmoMode ::: mode is already same"
      L4_2 = "mode"
      L5_2 = A1_2
      return L2_2(L3_2, L4_2, L5_2)
    end
    A0_2.mode = A1_2
  else
    L2_2 = A0_2.mode
    if "gizmo" == L2_2 then
      L2_2 = "mgizmo"
      if L2_2 then
        goto lbl_31
      end
    end
    L2_2 = "gizmo"
    ::lbl_31::
    A0_2.mode = L2_2
  end
  L2_2 = SendReactMessage
  L3_2 = "toggle_gizmo_mode"
  L4_2 = A0_2.mode
  L2_2(L3_2, L4_2)
  L2_2 = Notification
  L3_2 = i18n
  L3_2 = L3_2.t
  L4_2 = "decorate.gizmo_mode_toggled"
  L5_2 = {}
  L6_2 = A0_2.mode
  L5_2.mode = L6_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = "info"
  L2_2(L3_2, L4_2)
  L2_2 = gizmo
  L3_2 = L2_2
  L2_2 = L2_2.deselectEntity
  L2_2(L3_2)
  L2_2 = mgizmo
  L3_2 = L2_2
  L2_2 = L2_2.deselectEntity
  L2_2(L3_2)
  L2_2 = A0_2.mode
  if "gizmo" == L2_2 then
    L2_2 = gizmo
    L3_2 = L2_2
    L2_2 = L2_2.handleCameraUpdate
    L2_2(L3_2)
  else
    L2_2 = mgizmo
    L3_2 = L2_2
    L2_2 = L2_2.loop
    L2_2(L3_2)
  end
end
L7_1.toggleGizmoMode = L8_1
L7_1 = Config
L7_1 = L7_1.Furniture
L7_1 = L7_1.light
L7_1 = L7_1.items
LIGHT_ITEMS = L7_1
L7_1 = table
L7_1 = L7_1.deepclone
L8_1 = Config
L8_1 = L8_1.DynamicFurnitures
L7_1 = L7_1(L8_1)
L8_1 = {}
function L9_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L0_2 = Config
  L1_2 = table
  L1_2 = L1_2.deepclone
  L2_2 = L7_1
  L1_2 = L1_2(L2_2)
  L0_2.DynamicFurnitures = L1_2
  L0_2 = Config
  L1_2 = {}
  L0_2.DoorModels = L1_2
  L0_2 = {}
  L8_1 = L0_2
  L0_2 = pairs
  L1_2 = Config
  L1_2 = L1_2.Furniture
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    if "navigation" ~= L4_2 then
      L6_2 = pairs
      L7_2 = L5_2.items
      L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
      for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
        L12_2 = L11_2.type
        if L12_2 then
          L12_2 = Config
          L12_2 = L12_2.DynamicFurnitures
          L13_2 = L11_2.object
          L12_2[L13_2] = L11_2
        end
        L12_2 = L11_2.isDoor
        if L12_2 then
          L12_2 = Config
          L12_2 = L12_2.DoorModels
          L13_2 = L11_2.object
          L12_2[L13_2] = L11_2
        end
        L12_2 = L11_2.onlyInside
        if L12_2 then
          L13_2 = L11_2.object
          L12_2 = L8_1
          L12_2[L13_2] = true
        end
        L12_2 = L11_2.colors
        if L12_2 then
          L12_2 = pairs
          L13_2 = L11_2.colors
          L12_2, L13_2, L14_2, L15_2 = L12_2(L13_2)
          for L16_2, L17_2 in L12_2, L13_2, L14_2, L15_2 do
            L18_2 = L17_2.type
            if L18_2 then
              L18_2 = Config
              L18_2 = L18_2.DynamicFurnitures
              L19_2 = L17_2.object
              L18_2[L19_2] = L17_2
            end
            L18_2 = L11_2.isDoor
            if L18_2 then
              L18_2 = Config
              L18_2 = L18_2.DoorModels
              L19_2 = L17_2.object
              L18_2[L19_2] = L17_2
            end
            L18_2 = L11_2.onlyInside
            if L18_2 then
              L19_2 = L17_2.object
              L18_2 = L8_1
              L18_2[L19_2] = true
            end
          end
        end
      end
    end
  end
end
InitializeFurnitures = L9_1
function L9_1(A0_2)
  local L1_2
  L1_2 = L8_1
  L1_2 = L1_2[A0_2]
  L1_2 = true == L1_2
  return L1_2
end
IsOnlyInsideModel = L9_1
L9_1 = CreateThread
L10_1 = InitializeFurnitures
L9_1(L10_1)
L9_1 = {}
L10_1 = {}
function L11_1(A0_2)
  local L1_2, L2_2
  L1_2 = tostring
  L2_2 = A0_2.id
  if not L2_2 then
    L2_2 = A0_2.uniq
    if not L2_2 then
      L2_2 = A0_2.modelName
    end
  end
  return L1_2(L2_2)
end
function L12_1(A0_2)
  local L1_2, L2_2
  L1_2 = Config
  L1_2 = L1_2.DynamicFurnitures
  L1_2 = L1_2[A0_2]
  if L1_2 then
    L2_2 = L1_2.type
    if "wallart" == L2_2 then
      goto lbl_11
    end
  end
  L2_2 = nil
  do return L2_2 end
  ::lbl_11::
  L2_2 = L1_2.wallart
  return L2_2
end
function L13_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = "%s:%s"
  L3_2 = L2_2
  L2_2 = L2_2.format
  L4_2 = A0_2
  L5_2 = A1_2
  return L2_2(L3_2, L4_2, L5_2)
end
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = "wallart_%s"
  L2_2 = L1_2
  L1_2 = L1_2.format
  L4_2 = A0_2
  L3_2 = A0_2.gsub
  L5_2 = "[^%w_]"
  L6_2 = "_"
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2, L5_2, L6_2)
  return L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
end
function L15_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = L11_1
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = L10_1
  L2_2 = L2_2[L1_2]
  if not L2_2 then
    return
  end
  L3_2 = L10_1
  L3_2[L1_2] = nil
  L3_2 = table
  L3_2 = L3_2.find
  L4_2 = L10_1
  function L5_2(A0_3)
    local L1_3
    L1_3 = L2_2
    L1_3 = A0_3 == L1_3
    return L1_3
  end
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    return
  end
  L4_2 = L9_1
  L4_2 = L4_2[L2_2]
  if not L4_2 then
    return
  end
  L5_2 = L4_2.duiObj
  if L5_2 then
    L5_2 = DestroyDui
    L6_2 = L4_2.duiObj
    L5_2(L6_2)
  end
  L5_2 = L9_1
  L5_2[L2_2] = nil
end
function L16_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L1_2 = Debug
  L2_2 = "ApplyWallartTexture ::: Applying wallart texture"
  L3_2 = "objectData"
  L4_2 = A0_2
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = L12_1
  L2_2 = A0_2.modelName
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = A0_2.wallartData
  if not L2_2 then
    L2_2 = {}
  end
  L3_2 = L2_2.textureDict
  if not L3_2 then
    L3_2 = L1_2.textureDict
  end
  L4_2 = L2_2.textureName
  if not L4_2 then
    L4_2 = L1_2.textureName
  end
  if not L3_2 or not L4_2 then
    L5_2 = false
    return L5_2
  end
  L5_2 = L2_2.url
  if not L5_2 then
    L5_2 = L1_2.defaultUrl
  end
  L6_2 = type
  L7_2 = L5_2
  L6_2 = L6_2(L7_2)
  if "string" ~= L6_2 then
    L6_2 = false
    return L6_2
  end
  L7_2 = L5_2
  L6_2 = L5_2.match
  L8_2 = "^%s*(.-)%s*$"
  L6_2 = L6_2(L7_2, L8_2)
  L5_2 = L6_2
  if "" == L5_2 then
    L6_2 = false
    return L6_2
  end
  L6_2 = A0_2.wallartData
  if not L6_2 then
    L6_2 = {}
  end
  A0_2.wallartData = L6_2
  L6_2 = A0_2.wallartData
  L6_2.url = L5_2
  L6_2 = A0_2.wallartData
  L6_2.textureName = L4_2
  L6_2 = A0_2.wallartData
  L6_2.textureDict = L3_2
  L6_2 = L13_1
  L7_2 = L3_2
  L8_2 = L4_2
  L6_2 = L6_2(L7_2, L8_2)
  L7_2 = L11_1
  L8_2 = A0_2
  L7_2 = L7_2(L8_2)
  L8_2 = L9_1
  L8_2 = L8_2[L6_2]
  if L8_2 then
    L9_2 = L8_2.url
    if L9_2 == L5_2 then
      L9_2 = L10_1
      L9_2[L7_2] = L6_2
      L9_2 = true
      return L9_2
    end
  end
  if L8_2 then
    L9_2 = L8_2.duiObj
    if L9_2 then
      L9_2 = DestroyDui
      L10_2 = L8_2.duiObj
      L9_2(L10_2)
    end
  end
  L9_2 = L14_1
  L10_2 = L6_2
  L9_2 = L9_2(L10_2)
  L10_2 = CreateRuntimeTxd
  L11_2 = L9_2
  L10_2 = L10_2(L11_2)
  L11_2 = CreateDui
  L12_2 = L5_2
  L13_2 = 512
  L14_2 = 512
  L11_2 = L11_2(L12_2, L13_2, L14_2)
  L12_2 = GetGameTimer
  L12_2 = L12_2()
  L12_2 = L12_2 + 12500
  while true do
    L13_2 = IsDuiAvailable
    L14_2 = L11_2
    L13_2 = L13_2(L14_2)
    if L13_2 then
      break
    end
    L13_2 = GetGameTimer
    L13_2 = L13_2()
    if not (L12_2 > L13_2) then
      break
    end
    L13_2 = Wait
    L14_2 = 50
    L13_2(L14_2)
  end
  L13_2 = IsDuiAvailable
  L14_2 = L11_2
  L13_2 = L13_2(L14_2)
  if not L13_2 then
    L13_2 = Debug
    L14_2 = "ApplyWallartTexture ::: Dui is not available"
    L15_2 = "url"
    L16_2 = L5_2
    L13_2(L14_2, L15_2, L16_2)
    L13_2 = DestroyDui
    L14_2 = L11_2
    L13_2(L14_2)
    L13_2 = false
    return L13_2
  end
  L13_2 = GetDuiHandle
  L14_2 = L11_2
  L13_2 = L13_2(L14_2)
  L14_2 = CreateRuntimeTextureFromDuiHandle
  L15_2 = L10_2
  L16_2 = "skin"
  L17_2 = L13_2
  L14_2(L15_2, L16_2, L17_2)
  L14_2 = AddReplaceTexture
  L15_2 = L3_2
  L16_2 = L4_2
  L17_2 = L9_2
  L18_2 = "skin"
  L14_2(L15_2, L16_2, L17_2, L18_2)
  L14_2 = Debug
  L15_2 = "ApplyWallartTexture ::: Added replace texture"
  L16_2 = "textureDict"
  L17_2 = L3_2
  L18_2 = "textureName"
  L19_2 = L4_2
  L20_2 = "txdName"
  L21_2 = L9_2
  L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
  L14_2 = L9_1
  L15_2 = {}
  L15_2.txdName = L9_2
  L15_2.duiObj = L11_2
  L15_2.url = L5_2
  L14_2[L6_2] = L15_2
  L14_2 = L10_1
  L14_2[L7_2] = L6_2
  L14_2 = true
  return L14_2
end
L17_1 = decorate
function L18_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = L16_1
  L3_2 = A1_2
  return L2_2(L3_2)
end
L17_1.applyWallartTexture = L18_1
function L17_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = pairs
  L1_2 = L9_1
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = L5_2.duiObj
    if L6_2 then
      L6_2 = DestroyDui
      L7_2 = L5_2.duiObj
      L6_2(L7_2)
    end
  end
  L0_2 = {}
  L9_1 = L0_2
  L0_2 = {}
  L10_1 = L0_2
end
L18_1 = decorate
function L19_1(A0_2)
  local L1_2, L2_2
  L1_2 = CreateThread
  function L2_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    L0_3 = 0
    while true do
      L1_3 = A0_2.active
      if not L1_3 then
        break
      end
      L1_3 = L0_1
      L2_3 = cache
      L2_3 = L2_3.playerId
      L3_3 = true
      L1_3(L2_3, L3_3)
      L1_3 = A0_2.currentObject
      if L1_3 then
        L1_3 = L1_3.handle
      end
      L1_3 = L0_3 ~= L1_3
      if L1_3 then
        L2_3 = SetEntityDrawOutline
        L3_3 = L0_3
        L4_3 = false
        L2_3(L3_3, L4_3)
        L2_3 = SetEntityDrawOutline
        L3_3 = A0_2.currentObject
        if L3_3 then
          L3_3 = L3_3.handle
        end
        L4_3 = true
        L2_3(L3_3, L4_3)
        L2_3 = SetEntityDrawOutlineColor
        L3_3 = 0
        L4_3 = 180
        L5_3 = 255
        L6_3 = 255
        L2_3(L3_3, L4_3, L5_3, L6_3)
      end
      L2_3 = A0_2.currentObject
      if L2_3 then
        L2_3 = L2_3.handle
      end
      L0_3 = L2_3
      L2_3 = L1_1
      L3_3 = 0
      L4_3 = ActionControls
      L4_3 = L4_3.toggle_cursor
      L4_3 = L4_3.codes
      L4_3 = L4_3[1]
      L2_3 = L2_3(L3_3, L4_3)
      if not L2_3 then
        L2_3 = L2_1
        L3_3 = 0
        L4_3 = ActionControls
        L4_3 = L4_3.toggle_cursor
        L4_3 = L4_3.codes
        L4_3 = L4_3[1]
        L2_3 = L2_3(L3_3, L4_3)
        if not L2_3 then
          goto lbl_64
        end
      end
      L2_3 = A0_2
      L3_3 = L2_3
      L2_3 = L2_3.setFocus
      L4_3 = true
      L2_3(L3_3, L4_3)
      ::lbl_64::
      L2_3 = L1_1
      L3_3 = 0
      L4_3 = ActionControls
      L4_3 = L4_3.toggle_free_camera
      L4_3 = L4_3.codes
      L4_3 = L4_3[1]
      L2_3 = L2_3(L3_3, L4_3)
      if not L2_3 then
        L2_3 = L2_1
        L3_3 = 0
        L4_3 = ActionControls
        L4_3 = L4_3.toggle_free_camera
        L4_3 = L4_3.codes
        L4_3 = L4_3[1]
        L2_3 = L2_3(L3_3, L4_3)
        if not L2_3 then
          goto lbl_85
        end
      end
      L2_3 = A0_2
      L3_3 = L2_3
      L2_3 = L2_3.toggleFreeCamera
      L2_3(L3_3)
      ::lbl_85::
      L2_3 = L1_1
      L3_3 = 0
      L4_3 = ActionControls
      L4_3 = L4_3.done
      L4_3 = L4_3.codes
      L4_3 = L4_3[1]
      L2_3 = L2_3(L3_3, L4_3)
      if not L2_3 then
        L2_3 = L2_1
        L3_3 = 0
        L4_3 = ActionControls
        L4_3 = L4_3.done
        L4_3 = L4_3.codes
        L4_3 = L4_3[1]
        L2_3 = L2_3(L3_3, L4_3)
        if not L2_3 then
          goto lbl_112
        end
      end
      L2_3 = A0_2.currentObject
      if L2_3 then
        L2_3 = L2_3.stashId
      end
      if not L2_3 then
        L2_3 = A0_2
        L3_3 = L2_3
        L2_3 = L2_3.openBuyObjectModal
        L2_3(L3_3)
      end
      ::lbl_112::
      if L0_3 then
        L2_3 = L3_1
        L3_3 = 0
        L4_3 = ActionControls
        L4_3 = L4_3.place_object_on_ground
        L4_3 = L4_3.codes
        L4_3 = L4_3[1]
        L2_3 = L2_3(L3_3, L4_3)
        if not L2_3 then
          L2_3 = L4_1
          L3_3 = 0
          L4_3 = ActionControls
          L4_3 = L4_3.place_object_on_ground
          L4_3 = L4_3.codes
          L4_3 = L4_3[1]
          L2_3 = L2_3(L3_3, L4_3)
          if not L2_3 then
            goto lbl_135
          end
        end
        L2_3 = A0_2
        L3_3 = L2_3
        L2_3 = L2_3.placeObjectOnGround
        L2_3(L3_3)
      end
      ::lbl_135::
      L2_3 = Wait
      L3_3 = 0
      L2_3(L3_3)
    end
  end
  L1_2(L2_2)
end
L18_1.handleControls = L19_1
L18_1 = RegisterNetEvent
L19_1 = "housing:decorate:open"
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = CurrentHouse
  if not L0_2 then
    L0_2 = Notification
    L1_2 = i18n
    L1_2 = L1_2.t
    L2_2 = "decorate.not_in_house"
    L1_2 = L1_2(L2_2)
    L2_2 = "error"
    return L0_2(L1_2, L2_2)
  end
  L0_2 = Config
  L0_2 = L0_2.Houses
  L1_2 = CurrentHouse
  L0_2 = L0_2[L1_2]
  if not L0_2 then
    L1_2 = Notification
    L2_2 = i18n
    L2_2 = L2_2.t
    L3_2 = "decorate.invalid_data"
    L2_2 = L2_2(L3_2)
    L3_2 = "error"
    return L1_2(L2_2, L3_2)
  end
  L1_2 = Config
  L1_2 = L1_2.DecorateOnlyAccessForOwner
  if L1_2 then
    L1_2 = CurrentHouseData
    L1_2 = L1_2.isOwnedByMe
    if not L1_2 then
      L1_2 = Notification
      L2_2 = i18n
      L2_2 = L2_2.t
      L3_2 = "you_are_not_owner"
      L2_2 = L2_2(L3_2)
      L3_2 = "error"
      return L1_2(L2_2, L3_2)
    end
  end
  L1_2 = CurrentHouseData
  L1_2 = L1_2.billsCutOff
  if L1_2 then
    L1_2 = Notification
    L2_2 = i18n
    L2_2 = L2_2.t
    L3_2 = "decorate.bills_cut_off"
    L2_2 = L2_2(L3_2)
    L3_2 = "error"
    return L1_2(L2_2, L3_2)
  end
  L1_2 = CurrentHouseData
  L1_2 = L1_2.haskey
  if not L1_2 then
    L1_2 = Notification
    L2_2 = i18n
    L2_2 = L2_2.t
    L3_2 = "decorate.not_key_holder"
    L2_2 = L2_2(L3_2)
    L3_2 = "error"
    return L1_2(L2_2, L3_2)
  end
  L1_2 = decorate
  L2_2 = L1_2
  L1_2 = L1_2.open
  L1_2(L2_2)
end
L18_1(L19_1, L20_1)
L18_1 = 0.01
L19_1 = decorate
function L20_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  if nil ~= A1_2 then
    A0_2.freeCamera = A1_2
  else
    L2_2 = A0_2.freeCamera
    L2_2 = not L2_2
    A0_2.freeCamera = L2_2
  end
  L2_2 = A0_2.freeCamera
  if not L2_2 then
    return
  end
  L2_2 = SetPlayerControl
  L3_2 = cache
  L3_2 = L3_2.playerId
  L4_2 = false
  L5_2 = 0
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = GetEntityMatrix
  L3_2 = cache
  L3_2 = L3_2.ped
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  L6_2 = L5_2 + L4_2
  L7_2 = GetEntityRotation
  L8_2 = cache
  L8_2 = L8_2.ped
  L7_2 = L7_2(L8_2)
  L8_2 = Utils
  L8_2 = L8_2.CreateCamera
  L9_2 = "DEFAULT_SCRIPTED_CAMERA"
  L10_2 = L6_2
  L11_2 = L7_2
  L12_2 = true
  L13_2 = nil
  L14_2 = 1000
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L10_2 = A0_2
  L9_2 = A0_2.instructional
  L11_2 = {}
  L12_2 = {}
  L12_2.key = "focus_free_camera"
  L12_2.label = "Focus Object"
  L11_2[1] = L12_2
  L9_2(L10_2, L11_2)
  A0_2.cameraFocus = false
  L9_2 = CreateThread
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3
    while true do
      L0_3 = A0_2.active
      if not L0_3 then
        break
      end
      L0_3 = A0_2.freeCamera
      if not L0_3 then
        break
      end
      L0_3 = Utils
      L0_3 = L0_3.HandleFlyCam
      L1_3 = L8_2
      L2_3 = {}
      L3_3 = A0_2.cameraFocus
      L3_3 = not L3_3
      L2_3.mouse = L3_3
      L0_3, L1_3 = L0_3(L1_3, L2_3)
      L7_2 = L1_3
      L6_2 = L0_3
      L0_3 = DisableAllControlActions
      L1_3 = 0
      L0_3(L1_3)
      L0_3 = L2_1
      L1_3 = 0
      L2_3 = Keys
      L2_3 = L2_3.F
      L0_3 = L0_3(L1_3, L2_3)
      if L0_3 then
        L0_3 = A0_2.mode
        if "gizmo" == L0_3 then
          L0_3 = A0_2.cameraFocus
          L0_3 = not L0_3
          A0_2.cameraFocus = L0_3
        else
          L0_3 = Notification
          L1_3 = i18n
          L1_3 = L1_3.t
          L2_3 = "decorate.focus_object_not_supported"
          L1_3 = L1_3(L2_3)
          L2_3 = "error"
          L0_3(L1_3, L2_3)
        end
      end
      L0_3 = A0_2.cameraFocus
      if L0_3 then
        L0_3 = A0_2.mode
        if "mgizmo" == L0_3 then
          A0_2.cameraFocus = false
        end
      end
      L0_3 = A0_2.cameraFocus
      if L0_3 then
        L0_3 = A0_2.currentObject
        if L0_3 then
          L0_3 = L0_3.handle
        end
        if L0_3 then
          L0_3 = A0_2.currentObject
          L0_3 = L0_3.handle
          if L0_3 then
            L1_3 = DoesEntityExist
            L2_3 = L0_3
            L1_3 = L1_3(L2_3)
            if L1_3 then
              L1_3 = GetEntityCoords
              L2_3 = L0_3
              L1_3 = L1_3(L2_3)
              L2_3 = GetEntityModel
              L3_3 = L0_3
              L2_3 = L2_3(L3_3)
              L3_3 = GetModelDimensions
              L4_3 = L2_3
              L3_3, L4_3 = L3_3(L4_3)
              L5_3 = L4_3 - L3_3
              L5_3 = #L5_3
              L6_3 = math
              L6_3 = L6_3.max
              L7_3 = L5_3 * 2.0
              L8_3 = 3.0
              L6_3 = L6_3(L7_3, L8_3)
              L7_3 = L4_3.z
              L8_3 = L3_3.z
              L7_3 = L7_3 - L8_3
              L8_3 = L6_2
              L9_3 = L8_3 - L1_3
              L9_3 = #L9_3
              L10_3 = L1_3 - L8_3
              L11_3 = vec3
              L12_3 = math
              L12_3 = L12_3.deg
              L13_3 = math
              L13_3 = L13_3.asin
              L14_3 = L10_3.z
              L15_3 = #L10_3
              L14_3 = L14_3 / L15_3
              L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3 = L13_3(L14_3)
              L12_3 = L12_3(L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3)
              L13_3 = 0.0
              L14_3 = math
              L14_3 = L14_3.deg
              L15_3 = math
              L15_3 = L15_3.atan
              L16_3 = L10_3.x
              L16_3 = -L16_3
              L17_3 = L10_3.y
              L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3 = L15_3(L16_3, L17_3)
              L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3 = L14_3(L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3)
              L11_3 = L11_3(L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3)
              L12_3 = vec3
              L13_3 = L7_2.x
              L14_3 = L11_3.x
              L15_3 = L7_2.x
              L14_3 = L14_3 - L15_3
              L15_3 = L18_1
              L14_3 = L14_3 * L15_3
              L13_3 = L13_3 + L14_3
              L14_3 = L7_2.y
              L15_3 = L11_3.y
              L16_3 = L7_2.y
              L15_3 = L15_3 - L16_3
              L16_3 = L18_1
              L15_3 = L15_3 * L16_3
              L14_3 = L14_3 + L15_3
              L15_3 = L7_2.z
              L16_3 = L11_3.z
              L17_3 = L7_2.z
              L16_3 = L16_3 - L17_3
              L17_3 = L18_1
              L16_3 = L16_3 * L17_3
              L15_3 = L15_3 + L16_3
              L12_3 = L12_3(L13_3, L14_3, L15_3)
              L13_3 = SetCamRot
              L14_3 = L8_2
              L15_3 = L12_3.x
              L16_3 = L12_3.y
              L17_3 = L12_3.z
              L18_3 = 2
              L13_3(L14_3, L15_3, L16_3, L17_3, L18_3)
              L13_3 = L6_3 * 1.5
              if not (L9_3 > L13_3) then
                L13_3 = L6_3 * 0.5
                if not (L9_3 < L13_3) then
                  goto lbl_215
                end
              end
              L13_3 = L10_3 / L9_3
              L14_3 = L13_3 * L6_3
              L14_3 = L1_3 - L14_3
              L15_3 = vec3
              L16_3 = L6_2.x
              L17_3 = L14_3.x
              L18_3 = L6_2.x
              L17_3 = L17_3 - L18_3
              L18_3 = L18_1
              L17_3 = L17_3 * L18_3
              L17_3 = L17_3 * 0.5
              L16_3 = L16_3 + L17_3
              L17_3 = L6_2.y
              L18_3 = L14_3.y
              L19_3 = L6_2.y
              L18_3 = L18_3 - L19_3
              L19_3 = L18_1
              L18_3 = L18_3 * L19_3
              L18_3 = L18_3 * 0.5
              L17_3 = L17_3 + L18_3
              L18_3 = L6_2.z
              L19_3 = L14_3.z
              L20_3 = L6_2.z
              L19_3 = L19_3 - L20_3
              L20_3 = L18_1
              L19_3 = L19_3 * L20_3
              L19_3 = L19_3 * 0.5
              L18_3 = L18_3 + L19_3
              L15_3 = L15_3(L16_3, L17_3, L18_3)
              L16_3 = SetCamCoord
              L17_3 = L8_2
              L18_3 = L15_3.x
              L19_3 = L15_3.y
              L20_3 = L15_3.z
              L16_3(L17_3, L18_3, L19_3, L20_3)
              L6_2 = L15_3
              ::lbl_215::
              L13_3 = L6_3 * 0.7
              if L9_3 < L13_3 then
                L13_3 = 0.3
                L14_3 = GetGameTimer
                L14_3 = L14_3()
                L14_3 = L14_3 / 1000.0
                L14_3 = L14_3 * L13_3
                L15_3 = L6_3 * 0.8
                L16_3 = vec3
                L17_3 = L1_3.x
                L18_3 = math
                L18_3 = L18_3.cos
                L19_3 = L14_3
                L18_3 = L18_3(L19_3)
                L18_3 = L18_3 * L15_3
                L17_3 = L17_3 + L18_3
                L18_3 = L1_3.y
                L19_3 = math
                L19_3 = L19_3.sin
                L20_3 = L14_3
                L19_3 = L19_3(L20_3)
                L19_3 = L19_3 * L15_3
                L18_3 = L18_3 + L19_3
                L19_3 = L1_3.z
                L19_3 = L19_3 + L7_3
                L16_3 = L16_3(L17_3, L18_3, L19_3)
                L17_3 = vec3
                L18_3 = L6_2.x
                L19_3 = L16_3.x
                L20_3 = L6_2.x
                L19_3 = L19_3 - L20_3
                L19_3 = L19_3 * 0.05
                L18_3 = L18_3 + L19_3
                L19_3 = L6_2.y
                L20_3 = L16_3.y
                L21_3 = L6_2.y
                L20_3 = L20_3 - L21_3
                L20_3 = L20_3 * 0.05
                L19_3 = L19_3 + L20_3
                L20_3 = L6_2.z
                L21_3 = L16_3.z
                L22_3 = L6_2.z
                L21_3 = L21_3 - L22_3
                L21_3 = L21_3 * 0.05
                L20_3 = L20_3 + L21_3
                L17_3 = L17_3(L18_3, L19_3, L20_3)
                L18_3 = SetCamCoord
                L19_3 = L8_2
                L20_3 = L17_3.x
                L21_3 = L17_3.y
                L22_3 = L17_3.z
                L18_3(L19_3, L20_3, L21_3, L22_3)
              end
            end
          end
        end
      end
      L0_3 = Wait
      L1_3 = 0
      L0_3(L1_3)
    end
    L0_3 = Utils
    L0_3 = L0_3.DestroyFlyCam
    L1_3 = L8_2
    L2_3 = 1000
    L0_3(L1_3, L2_3)
    L0_3 = SetPlayerControl
    L1_3 = cache
    L1_3 = L1_3.playerId
    L2_3 = true
    L3_3 = 0
    L0_3(L1_3, L2_3, L3_3)
    L0_3 = A0_2
    L1_3 = L0_3
    L0_3 = L0_3.instructional
    L0_3(L1_3)
  end
  L9_2(L10_2)
end
L19_1.toggleFreeCamera = L20_1
L19_1 = decorate
function L20_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = decorate
  L1_2 = L1_2.currentObject
  if not L1_2 then
    return
  end
  L1_2 = decorate
  L1_2 = L1_2.currentObject
  if L1_2 then
    L1_2 = L1_2.handle
  end
  if L1_2 then
    L1_2 = decorate
    L1_2 = L1_2.currentObject
    L1_2 = L1_2.stashId
    if not L1_2 then
      L1_2 = DeleteObject
      L2_2 = decorate
      L2_2 = L2_2.currentObject
      L2_2 = L2_2.handle
      L1_2(L2_2)
    end
  end
  L1_2 = gizmo
  L2_2 = L1_2
  L1_2 = L1_2.deselectEntity
  L1_2(L2_2)
  L1_2 = decorate
  L1_2.currentObject = nil
  L1_2 = SendReactMessage
  L2_2 = "remove_current_object"
  L1_2(L2_2)
  L1_2 = Debug
  L2_2 = "Removed current object"
  L3_2 = decorate
  L3_2 = L3_2.currentObject
  L1_2(L2_2, L3_2)
end
L19_1.removeCurrentObject = L20_1
L19_1 = exports
L20_1 = "inDecorate"
function L21_1()
  local L0_2, L1_2
  L0_2 = decorate
  L0_2 = L0_2.active
  return L0_2
end
L19_1(L20_1, L21_1)
L19_1 = decorate
function L20_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = A0_2.currentObject
  if L2_2 then
    L2_2 = L2_2.handle
  end
  if A1_2 == L2_2 then
    L2_2 = A0_2.currentObject
    return L2_2
  end
  L2_2 = pairs
  L3_2 = decorate
  L3_2 = L3_2.objects
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = L7_2.handle
    if L8_2 then
      L8_2 = DoesEntityExist
      L9_2 = L7_2.handle
      L8_2 = L8_2(L9_2)
      if L8_2 then
        L8_2 = L7_2.handle
        if L8_2 == A1_2 then
          return L7_2
        end
      end
    end
  end
  L2_2 = false
  return L2_2
end
L19_1.getObjectData = L20_1
L19_1 = decorate
function L20_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = Debug
  L2_2 = "saveCurrentObject"
  L3_2 = "Current object"
  L4_2 = decorate
  L4_2 = L4_2.currentObject
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = A0_2.currentObject
  if not L1_2 then
    return
  end
  L1_2 = {}
  L2_2 = A0_2.currentObject
  L2_2 = L2_2.modelName
  L1_2.modelName = L2_2
  L2_2 = GetEntityCoords
  L3_2 = A0_2.currentObject
  L3_2 = L3_2.handle
  L2_2 = L2_2(L3_2)
  L1_2.coords = L2_2
  L2_2 = GetEntityRotation
  L3_2 = A0_2.currentObject
  L3_2 = L3_2.handle
  L2_2 = L2_2(L3_2)
  L1_2.rotation = L2_2
  L2_2 = A0_2.currentObject
  L2_2 = L2_2.handle
  L1_2.handle = L2_2
  L1_2.inStash = false
  L2_2 = EnteredHouse
  L2_2 = nil ~= L2_2
  L1_2.inHouse = L2_2
  L2_2 = CurrentHouse
  L1_2.house = L2_2
  L2_2 = A0_2.currentObject
  L2_2 = L2_2.price
  L1_2.price = L2_2
  L2_2 = A0_2.currentObject
  L2_2 = L2_2.wallartData
  L1_2.wallartData = L2_2
  L3_2 = A0_2
  L2_2 = A0_2.removeCurrentObject
  L2_2(L3_2)
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:saveObject"
  L4_2 = false
  L5_2 = CurrentHouse
  L6_2 = L1_2
  return L2_2(L3_2, L4_2, L5_2, L6_2)
end
L19_1.saveCurrentObject = L20_1
L19_1 = decorate
function L20_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = table
  L1_2 = L1_2.deepclone
  L2_2 = decorate
  L2_2 = L2_2.objects
  L1_2 = L1_2(L2_2)
  L2_2 = decorate
  L3_2 = {}
  L2_2.objects = L3_2
  L2_2 = pairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = RemoveSpawnedObject
    L9_2 = L7_2
    L8_2(L9_2)
  end
  L2_2 = cleanerRobot
  if L2_2 then
    L2_2 = cleanerRobot
    L3_2 = L2_2
    L2_2 = L2_2.stopInteractionLoop
    L2_2(L3_2)
    L2_2 = cleanerRobot
    L3_2 = L2_2
    L2_2 = L2_2.cleanAll
    L2_2(L3_2)
  end
end
L19_1.destroyObjects = L20_1
L19_1 = decorate
function L20_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = pairs
  L2_2 = decorate
  L2_2 = L2_2.objects
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = RemoveSpawnedObject
    L8_2 = L6_2
    L7_2(L8_2)
  end
end
L19_1.refreshObjects = L20_1
L19_1 = decorate
function L20_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L1_2 = pairs
  L2_2 = decorate
  L2_2 = L2_2.objects
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = L6_2.spawned
    if L7_2 then
      L7_2 = DoesEntityExist
      L8_2 = L6_2.handle
      L7_2 = L7_2(L8_2)
      if L7_2 then
        L7_2 = GetEntityCoords
        L8_2 = L6_2.handle
        L7_2 = L7_2(L8_2)
        L8_2 = GetEntityRotation
        L9_2 = L6_2.handle
        L8_2 = L8_2(L9_2)
        L9_2 = vec3
        L10_2 = L7_2.x
        L11_2 = L7_2.y
        L12_2 = L7_2.z
        L9_2 = L9_2(L10_2, L11_2, L12_2)
        L10_2 = vec3
        L11_2 = L8_2.x
        L12_2 = L8_2.y
        L13_2 = L8_2.z
        L10_2 = L10_2(L11_2, L12_2, L13_2)
        L11_2 = L9_2.x
        L12_2 = L6_2.coords
        L12_2 = L12_2.x
        L11_2 = L11_2 == L12_2
        L12_2 = L10_2.x
        L13_2 = L6_2.rotation
        L13_2 = L13_2.x
        L12_2 = L12_2 == L13_2
        if not L11_2 or not L12_2 then
          L6_2.coords = L7_2
          L6_2.rotation = L8_2
          L13_2 = TriggerServerEvent
          L14_2 = "housing:updateObject"
          L15_2 = CurrentHouse
          L16_2 = L6_2.id
          L17_2 = {}
          L18_2 = json
          L18_2 = L18_2.encode
          L19_2 = L7_2
          L18_2 = L18_2(L19_2)
          L17_2.coords = L18_2
          L18_2 = json
          L18_2 = L18_2.encode
          L19_2 = L8_2
          L18_2 = L18_2(L19_2)
          L17_2.rotation = L18_2
          L13_2(L14_2, L15_2, L16_2, L17_2)
        end
      end
    end
  end
end
L19_1.saveObjects = L20_1
L19_1 = decorate
function L20_1(A0_2)
  local L1_2, L2_2
  L1_2 = A0_2.currentObject
  if not L1_2 then
    return
  end
  L1_2 = SendReactMessage
  L2_2 = "open_buy_object_modal"
  L1_2(L2_2)
end
L19_1.openBuyObjectModal = L20_1
L19_1 = RegisterNetEvent
L20_1 = "housing:updateObject"
function L21_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L3_2 = CurrentHouse
  if L3_2 ~= A0_2 then
    L3_2 = Debug
    L4_2 = "housing:updateObject ::: house is not same"
    L5_2 = "CurrentHouse"
    L6_2 = CurrentHouse
    L7_2 = "house"
    L8_2 = A0_2
    return L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  end
  L3_2 = table
  L3_2 = L3_2.find
  L4_2 = decorate
  L4_2 = L4_2.objects
  function L5_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.id
    L2_3 = A1_2
    L1_3 = L1_3 == L2_3
    return L1_3
  end
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L4_2 = Error
    L5_2 = "housing:updateObject :: Object not found"
    L6_2 = "id"
    L7_2 = A1_2
    L4_2(L5_2, L6_2, L7_2)
    return
  end
  L4_2 = pairs
  L5_2 = A2_2
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    if "coords" == L8_2 then
      L10_2 = L3_2.spawned
      if L10_2 then
        L10_2 = Debug
        L11_2 = "housing:updateObject ::: SetEntityCoords"
        L12_2 = "object"
        L13_2 = L3_2.handle
        L14_2 = "coords"
        L15_2 = L9_2
        L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
        L10_2 = SetEntityCoords
        L11_2 = L3_2.handle
        L12_2 = L9_2.x
        L13_2 = L9_2.y
        L14_2 = L9_2.z
        L15_2 = false
        L16_2 = false
        L17_2 = false
        L18_2 = false
        L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    end
    elseif "rotation" == L8_2 then
      L10_2 = L3_2.spawned
      if L10_2 then
        L10_2 = Debug
        L11_2 = "housing:updateObject ::: SetEntityRotation"
        L12_2 = "object"
        L13_2 = L3_2.handle
        L14_2 = "rotation"
        L15_2 = L9_2
        L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
        L10_2 = SetEntityRotation
        L11_2 = L3_2.handle
        L12_2 = L9_2.x
        L13_2 = L9_2.y
        L14_2 = L9_2.z
        L15_2 = 0
        L16_2 = false
        L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
      end
    end
    L3_2[L8_2] = L9_2
    if "wallartData" == L8_2 then
      L10_2 = L3_2.spawned
      if L10_2 then
        L10_2 = L16_1
        L11_2 = L3_2
        L10_2(L11_2)
      end
    end
    L10_2 = Debug
    L11_2 = "Updated object"
    L12_2 = "object"
    L13_2 = L3_2.id
    L14_2 = "key"
    L15_2 = L8_2
    L16_2 = "value"
    L17_2 = L9_2
    L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
end
L19_1(L20_1, L21_1)
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = A0_2.spawned
  if not L1_2 then
    L1_2 = false
    return L1_2
  end
  L1_2 = cleanerRobot
  if L1_2 then
    L1_2 = A0_2.id
    if L1_2 then
      L1_2 = cleanerRobot
      L2_2 = L1_2
      L1_2 = L1_2.isCleanerModel
      L3_2 = A0_2.modelName
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L2_2 = cleanerRobot
        L3_2 = L2_2
        L2_2 = L2_2.despawn
        L4_2 = A0_2.id
        L2_2(L3_2, L4_2)
      end
    end
  end
  L1_2 = L15_1
  L2_2 = A0_2
  L1_2(L2_2)
  L1_2 = DeleteObject
  L2_2 = A0_2.handle
  L1_2(L2_2)
  A0_2.spawned = false
end
RemoveSpawnedObject = L19_1
L19_1 = RegisterNetEvent
L20_1 = "housing:decorate:sellFurniture"
function L21_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = CurrentHouse
  if L2_2 ~= A0_2 then
    L2_2 = Debug
    L3_2 = "housing:decorate:sellFurniture ::: house is not same"
    L4_2 = "house"
    L5_2 = A0_2
    L6_2 = "CurrentHouse"
    L7_2 = CurrentHouse
    return L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  end
  L2_2 = table
  L2_2 = L2_2.find
  L3_2 = decorate
  L3_2 = L3_2.objects
  function L4_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.id
    L2_3 = A1_2
    L1_3 = L1_3 == L2_3
    return L1_3
  end
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L3_2 = Error
    L4_2 = "housing:decorate:sellFurniture ::: Object not found"
    L5_2 = "id"
    L6_2 = A1_2
    L3_2(L4_2, L5_2, L6_2)
    return
  end
  L3_2 = RemoveSpawnedObject
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = decorate
  L4_2 = table
  L4_2 = L4_2.filter
  L5_2 = decorate
  L5_2 = L5_2.objects
  function L6_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.id
    L2_3 = A1_2
    L1_3 = L1_3 ~= L2_3
    return L1_3
  end
  L4_2 = L4_2(L5_2, L6_2)
  L3_2.objects = L4_2
  L3_2 = Debug
  L4_2 = "housing:decorate:sellFurniture"
  L5_2 = "object is deleted from cache"
  L6_2 = L2_2.id
  L3_2(L4_2, L5_2, L6_2)
end
L19_1(L20_1, L21_1)
L19_1 = RegisterNetEvent
L20_1 = "housing:addObject"
function L21_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = CurrentHouse
  if L2_2 ~= A0_2 then
    L2_2 = Debug
    L3_2 = "housing:addObject ::: house is not same"
    L4_2 = "house"
    L5_2 = A0_2
    L6_2 = "CurrentHouse"
    L7_2 = CurrentHouse
    return L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  end
  L2_2 = decorate
  L2_2 = L2_2.objects
  L3_2 = decorate
  L3_2 = L3_2.objects
  L3_2 = #L3_2
  L3_2 = L3_2 + 1
  L2_2[L3_2] = A1_2
  L2_2 = Debug
  L3_2 = "Added object to data"
  L4_2 = "data"
  L5_2 = A1_2
  L2_2(L3_2, L4_2, L5_2)
end
L19_1(L20_1, L21_1)
L19_1 = RegisterNetEvent
L20_1 = "housing:removeFurniture"
function L21_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = CurrentHouse
  if L2_2 ~= A0_2 then
    return
  end
  L2_2 = decorate
  L2_2 = L2_2.objects
  if not L2_2 then
    return
  end
  L2_2 = pairs
  L3_2 = decorate
  L3_2 = L3_2.objects
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = L7_2.id
    if L8_2 == A1_2 then
      L8_2 = cleanerRobot
      if L8_2 then
        L8_2 = cleanerRobot
        L9_2 = L8_2
        L8_2 = L8_2.isCleanerModel
        L10_2 = L7_2.modelName
        L8_2 = L8_2(L9_2, L10_2)
        if L8_2 then
          L9_2 = cleanerRobot
          L10_2 = L9_2
          L9_2 = L9_2.despawn
          L11_2 = A1_2
          L9_2(L10_2, L11_2)
        end
      end
      L8_2 = L7_2.handle
      if L8_2 then
        L8_2 = DoesEntityExist
        L9_2 = L7_2.handle
        L8_2 = L8_2(L9_2)
        if L8_2 then
          L8_2 = DeleteObject
          L9_2 = L7_2.handle
          L8_2(L9_2)
        end
      end
      L8_2 = decorate
      L8_2 = L8_2.objects
      L8_2[L6_2] = nil
      L8_2 = Debug
      L9_2 = "Removed furniture:"
      L10_2 = A1_2
      L8_2(L9_2, L10_2)
      break
    end
  end
end
L19_1(L20_1, L21_1)
function L19_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L3_2 = joaat
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = lib
  L4_2 = L4_2.requestModel
  L5_2 = L3_2
  L6_2 = Config
  L6_2 = L6_2.DefaultRequestModelTimeout
  L4_2(L5_2, L6_2)
  L4_2 = CreateObject
  L5_2 = L3_2
  L6_2 = A1_2.x
  L7_2 = A1_2.y
  L8_2 = A1_2.z
  L9_2 = false
  L10_2 = false
  L11_2 = false
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = SetEntityAlpha
  L6_2 = L4_2
  L7_2 = 0
  L8_2 = false
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = CreateThread
  function L6_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    L0_3 = 0
    L1_3 = 255
    L2_3 = 51
    for L3_3 = L0_3, L1_3, L2_3 do
      L4_3 = Wait
      L5_3 = 50
      L4_3(L5_3)
      L4_3 = SetEntityAlpha
      L5_3 = L4_2
      L6_3 = L3_3
      L7_3 = false
      L4_3(L5_3, L6_3, L7_3)
    end
  end
  L5_2(L6_2)
  if A2_2 then
    L5_2 = SetEntityRotation
    L6_2 = L4_2
    L7_2 = A2_2.x
    L8_2 = A2_2.y
    L9_2 = A2_2.z
    L10_2 = 0
    L11_2 = false
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  end
  L5_2 = SetEntityAsMissionEntity
  L6_2 = L4_2
  L7_2 = true
  L8_2 = true
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = SetEntityInvincible
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = SetEntityCompletelyDisableCollision
  L6_2 = L4_2
  L7_2 = true
  L8_2 = false
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = Config
  L5_2 = L5_2.DynamicDoors
  if L5_2 then
    L5_2 = Config
    L5_2 = L5_2.DoorModels
    L5_2 = L5_2[A0_2]
    if L5_2 then
      goto lbl_64
    end
  end
  L5_2 = FreezeEntityPosition
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  ::lbl_64::
  L5_2 = SetModelAsNoLongerNeeded
  L6_2 = L3_2
  L5_2(L6_2)
  L5_2 = Wait
  L6_2 = 0
  L5_2(L6_2)
  L5_2 = SetEntityCoords
  L6_2 = L4_2
  L7_2 = A1_2.x
  L8_2 = A1_2.y
  L9_2 = A1_2.z
  L10_2 = false
  L11_2 = false
  L12_2 = false
  L13_2 = false
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  return L4_2
end
SpawnObject = L19_1
L19_1 = decorate
function L20_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L3_2 = A0_2
  L2_2 = A0_2.destroyObjects
  L2_2(L3_2)
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:getDecorations"
  L4_2 = 0
  L5_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  A0_2.objects = L2_2
  L2_2 = cleanerRobot
  if L2_2 then
    L2_2 = CurrentHouse
    if L2_2 then
      L2_2 = EnteredHouse
      if L2_2 then
        L2_2 = CreateThread
        function L3_2()
          local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
          L0_3 = Wait
          L1_3 = 500
          L0_3(L1_3)
          L0_3 = decorate
          L0_3 = L0_3.objects
          if L0_3 then
            L0_3 = pairs
            L1_3 = decorate
            L1_3 = L1_3.objects
            L0_3, L1_3, L2_3, L3_3 = L0_3(L1_3)
            for L4_3, L5_3 in L0_3, L1_3, L2_3, L3_3 do
              L6_3 = L5_3.spawned
              if L6_3 then
                L6_3 = L5_3.handle
                if L6_3 then
                  L6_3 = DoesEntityExist
                  L7_3 = L5_3.handle
                  L6_3 = L6_3(L7_3)
                  if L6_3 then
                    L6_3 = cleanerRobot
                    L7_3 = L6_3
                    L6_3 = L6_3.isCleanerModel
                    L8_3 = L5_3.modelName
                    L6_3 = L6_3(L7_3, L8_3)
                    if L6_3 then
                      L7_3 = cleanerRobot
                      L8_3 = L7_3
                      L7_3 = L7_3.spawnForDecoration
                      L9_3 = L5_3
                      L10_3 = CurrentHouse
                      L7_3(L8_3, L9_3, L10_3)
                    end
                  end
                end
              end
            end
            L0_3 = cleanerRobot
            L1_3 = L0_3
            L0_3 = L0_3.hasRobots
            L0_3 = L0_3(L1_3)
            if L0_3 then
              L0_3 = Config
              L0_3 = L0_3.UseTarget
              if not L0_3 then
                L0_3 = cleanerRobot
                L1_3 = L0_3
                L0_3 = L0_3.startInteractionLoop
                L0_3(L1_3)
              end
            end
          end
        end
        L2_2(L3_2)
      end
    end
  end
end
L19_1.getObjects = L20_1
L19_1 = exports
L20_1 = "refreshCurrentDecorations"
function L21_1()
  local L0_2, L1_2
  L0_2 = decorate
  L1_2 = L0_2
  L0_2 = L0_2.refreshObjects
  return L0_2(L1_2)
end
L19_1(L20_1, L21_1)
L19_1 = exports
L20_1 = "initCurrentDecorations"
function L21_1()
  local L0_2, L1_2, L2_2
  L0_2 = CurrentHouse
  if not L0_2 then
    L0_2 = Debug
    L1_2 = "initDecorations ::: No Current House"
    return L0_2(L1_2)
  end
  L0_2 = decorate
  L1_2 = L0_2
  L0_2 = L0_2.getObjects
  L2_2 = CurrentHouse
  return L0_2(L1_2, L2_2)
end
L19_1(L20_1, L21_1)
L19_1 = {}
L20_1 = {}
L21_1 = CreateThread
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = pairs
  L1_2 = LIGHT_ITEMS
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = table
    L6_2 = L6_2.insert
    L7_2 = L20_1
    L8_2 = L5_2.object
    L6_2(L7_2, L8_2)
  end
  while true do
    L0_2 = decorate
    L0_2 = L0_2.objects
    if not L0_2 then
      L0_2 = {}
      L19_1 = L0_2
    else
      L0_2 = table
      L0_2 = L0_2.deepclone
      L1_2 = table
      L1_2 = L1_2.filter
      L2_2 = decorate
      L2_2 = L2_2.objects
      function L3_2(A0_3)
        local L1_3, L2_3, L3_3
        L1_3 = table
        L1_3 = L1_3.includes
        L2_3 = L20_1
        L3_3 = A0_3.modelName
        return L1_3(L2_3, L3_3)
      end
      L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L1_2(L2_2, L3_2)
      L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
      L19_1 = L0_2
      L0_2 = pairs
      L1_2 = L19_1
      L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
      for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
        L6_2 = L5_2.handle
        if L6_2 then
          L6_2 = DoesEntityExist
          L7_2 = L5_2.handle
          L6_2 = L6_2(L7_2)
          if L6_2 then
            L6_2 = L5_2.inside
            if L6_2 then
              L6_2 = CurrentHouse
              if not L6_2 then
            end
            else
              L6_2 = GetEntityRotation
              L7_2 = L5_2.handle
              L6_2 = L6_2(L7_2)
              L7_2 = GetEntityCoords
              L8_2 = L5_2.handle
              L7_2 = L7_2(L8_2)
              L8_2 = RotationToDirection
              L9_2 = L6_2
              L8_2 = L8_2(L9_2)
              L9_2 = L19_1
              L9_2 = L9_2[L4_2]
              L9_2.position = L7_2
              L9_2 = L19_1
              L9_2 = L9_2[L4_2]
              L9_2.direction = L8_2
            end
          end
        end
      end
    end
    L0_2 = Wait
    L1_2 = 500
    L0_2(L1_2)
  end
end
L21_1(L22_1)
L21_1 = CreateThread
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2
  while true do
    L0_2 = 1250
    L1_2 = CurrentHouseData
    L1_2 = L1_2.billsCutOff
    if not L1_2 then
      L1_2 = CurrentHouseData
      L1_2 = L1_2.lightsOn
      if L1_2 then
        L1_2 = pairs
        L2_2 = L19_1
        L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
        for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
          L7_2 = L6_2.handle
          if L7_2 then
            L7_2 = DoesEntityExist
            L8_2 = L6_2.handle
            L7_2 = L7_2(L8_2)
            if L7_2 then
              L7_2 = L6_2.lightData
              if L7_2 then
                L7_2 = L6_2.lightData
                if L7_2 then
                  L7_2 = L7_2.active
                end
                if not L7_2 then
                  goto lbl_74
                end
              end
              L7_2 = L6_2.position
              if L7_2 then
                L0_2 = 0
                L7_2 = L6_2.position
                L8_2 = L6_2.direction
                L9_2 = L6_2.lightData
                if L9_2 then
                  L9_2 = L9_2.rgb
                end
                if not L9_2 then
                  L9_2 = {}
                  L9_2.r = 255
                  L9_2.g = 255
                  L9_2.b = 255
                end
                L10_2 = L6_2.lightData
                if L10_2 then
                  L10_2 = L10_2.intensity
                end
                if not L10_2 then
                  L10_2 = Config
                  L10_2 = L10_2.DefaultLightIntensity
                end
                L10_2 = L10_2 + 0.0
                L11_2 = DrawSpotLight
                L12_2 = L7_2.x
                L13_2 = L7_2.y
                L14_2 = L7_2.z
                L15_2 = L8_2.x
                L16_2 = L8_2.y
                L17_2 = L8_2.z
                L18_2 = L9_2.r
                L19_2 = L9_2.g
                L20_2 = L9_2.b
                L21_2 = 100.0
                L22_2 = 20.0
                L23_2 = 1.0
                L24_2 = L10_2
                L25_2 = 0.0
                L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
              end
            end
          end
          ::lbl_74::
        end
      end
    end
    L1_2 = Wait
    L2_2 = L0_2
    L1_2(L2_2)
  end
end
L21_1(L22_1)
L21_1 = CreateThread
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  while true do
    L0_2 = decorate
    L0_2 = L0_2.active
    if L0_2 then
      L0_2 = 300
      if L0_2 then
        goto lbl_9
      end
    end
    L0_2 = 1250
    ::lbl_9::
    L1_2 = GetEntityCoords
    L2_2 = cache
    L2_2 = L2_2.ped
    L1_2 = L1_2(L2_2)
    L2_2 = decorate
    L2_2 = L2_2.objects
    if not L2_2 then
      L2_2 = Wait
      L3_2 = L0_2
      L2_2(L3_2)
    else
      L2_2 = pairs
      L3_2 = decorate
      L3_2 = L3_2.objects
      L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
      for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
        L8_2 = L7_2.inStash
        if L8_2 then
          L8_2 = L7_2.spawned
          if L8_2 then
            L8_2 = DeleteObject
            L9_2 = L7_2.handle
            L8_2(L9_2)
            L7_2.spawned = false
            L8_2 = Debug
            L9_2 = "Deleted object because its setted to inStash"
            L10_2 = "object"
            L11_2 = L7_2.handle
            L8_2(L9_2, L10_2, L11_2)
          end
        else
          L8_2 = L7_2.coords
          if not L8_2 then
            L8_2 = Error
            L9_2 = "Object coords is nil we skipping it."
            L10_2 = "object"
            L11_2 = L7_2
            L8_2(L9_2, L10_2, L11_2)
          else
            L8_2 = IsOnlyInsideModel
            L9_2 = L7_2.modelName
            L8_2 = L8_2(L9_2)
            if L8_2 then
              L8_2 = EnteredHouse
              if not L8_2 then
                L8_2 = L7_2.spawned
                if L8_2 then
                  L8_2 = RemoveSpawnedObject
                  L9_2 = L7_2
                  L8_2(L9_2)
                  L8_2 = Debug
                  L9_2 = "Deleted onlyInside object because player left the house"
                  L10_2 = "object"
                  L11_2 = L7_2.handle
                  L8_2(L9_2, L10_2, L11_2)
                end
            end
            else
              L8_2 = vec3
              L9_2 = L7_2.coords
              L9_2 = L9_2.x
              L10_2 = L7_2.coords
              L10_2 = L10_2.y
              L11_2 = L7_2.coords
              L11_2 = L11_2.z
              L8_2 = L8_2(L9_2, L10_2, L11_2)
              L7_2.coords = L8_2
              L8_2 = L7_2.coords
              L8_2 = L8_2.x
              if 0.0 == L8_2 then
                L8_2 = L7_2.coords
                L8_2 = L8_2.y
                if 0.0 == L8_2 then
                  L8_2 = L7_2.coords
                  L8_2 = L8_2.z
                  if 0.0 == L8_2 then
                    L8_2 = decorate
                    L8_2 = L8_2.active
                    if L8_2 then
                      L8_2 = Utils
                      L8_2 = L8_2.GetCamera
                      L8_2 = L8_2()
                      L9_2 = L8_2.coords
                      L10_2 = L8_2.rotation
                      L11_2 = Utils
                      L11_2 = L11_2.GetForwardVector
                      L12_2 = L10_2
                      L11_2 = L11_2(L12_2)
                      L12_2 = L11_2 * 5.0
                      L12_2 = L9_2 + L12_2
                      L13_2 = L12_2
                      L14_2 = Debug
                      L15_2 = "Load Decorations : Object is from ikea. We setted it to camera center"
                      L16_2 = "v"
                      L17_2 = L7_2
                      L14_2(L15_2, L16_2, L17_2)
                      L14_2 = vec3
                      L15_2 = L13_2.x
                      L16_2 = L13_2.y
                      L17_2 = L13_2.z
                      L14_2 = L14_2(L15_2, L16_2, L17_2)
                      L7_2.coords = L14_2
                      L14_2 = decorate
                      L15_2 = L14_2
                      L14_2 = L14_2.saveObjects
                      L14_2(L15_2)
                    end
                  end
                end
              end
              L8_2 = L7_2.coords
              L8_2 = L1_2 - L8_2
              L8_2 = #L8_2
              L9_2 = Config
              L9_2 = L9_2.SpawnDistance
              if L8_2 <= L9_2 then
                L9_2 = L7_2.spawned
                if not L9_2 then
                  L9_2 = SpawnObject
                  L10_2 = L7_2.modelName
                  L11_2 = L7_2.coords
                  L12_2 = L7_2.rotation
                  L9_2 = L9_2(L10_2, L11_2, L12_2)
                  if L9_2 then
                    L7_2.handle = L9_2
                    L10_2 = L16_1
                    L11_2 = L7_2
                    L10_2(L11_2)
                    L10_2 = decorate
                    L10_2 = L10_2.currentObject
                    if L10_2 then
                      L10_2 = L10_2.stashId
                    end
                    L11_2 = L7_2.id
                    if L10_2 == L11_2 then
                      L10_2 = decorate
                      L10_2 = L10_2.currentObject
                      L10_2.handle = L9_2
                      L10_2 = decorate
                      L11_2 = L10_2
                      L10_2 = L10_2.selectEntity
                      L12_2 = L9_2
                      L10_2(L11_2, L12_2)
                    end
                    L10_2 = cleanerRobot
                    if L10_2 then
                      L10_2 = CurrentHouse
                      if L10_2 then
                        L10_2 = EnteredHouse
                        if L10_2 then
                          L10_2 = cleanerRobot
                          L11_2 = L10_2
                          L10_2 = L10_2.isCleanerModel
                          L12_2 = L7_2.modelName
                          L10_2 = L10_2(L11_2, L12_2)
                          if L10_2 then
                            L11_2 = cleanerRobot
                            L12_2 = L11_2
                            L11_2 = L11_2.spawnForDecoration
                            L13_2 = L7_2
                            L14_2 = CurrentHouse
                            L11_2(L12_2, L13_2, L14_2)
                            L11_2 = cleanerRobot
                            L12_2 = L11_2
                            L11_2 = L11_2.hasRobots
                            L11_2 = L11_2(L12_2)
                            if L11_2 then
                              L11_2 = Config
                              L11_2 = L11_2.UseTarget
                              if not L11_2 then
                                L11_2 = cleanerRobot
                                L12_2 = L11_2
                                L11_2 = L11_2.startInteractionLoop
                                L11_2(L12_2)
                              end
                            end
                          end
                        end
                      end
                    end
                  else
                    L7_2.handle = 0
                    L10_2 = Warning
                    L11_2 = "This model is not loaded. Please check if the model is valid. if its not delete it from the list"
                    L12_2 = L7_2.modelName
                    L10_2(L11_2, L12_2)
                  end
                  L7_2.spawned = true
              end
              else
                L9_2 = Config
                L9_2 = L9_2.SpawnDistance
                if L8_2 > L9_2 then
                  L9_2 = L7_2.spawned
                  if L9_2 then
                    L9_2 = RemoveSpawnedObject
                    L10_2 = L7_2
                    L9_2(L10_2)
                    L9_2 = Debug
                    L10_2 = "Deleted object"
                    L11_2 = "object"
                    L12_2 = L7_2.handle
                    L9_2(L10_2, L11_2, L12_2)
                  end
                end
              end
            end
          end
        end
      end
      L2_2 = Wait
      L3_2 = L0_2
      L2_2(L3_2)
    end
  end
end
L21_1(L22_1)
L21_1 = exports
L22_1 = "AddFurniture"
function L23_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = GetInvokingResource
  L2_2 = L2_2()
  L3_2 = Error
  L4_2 = "AddFurniture ::: This export is moved to server side. Please use exports['qs-housing']:AddFurniture(category, item) instead. on the server side. Resource"
  L5_2 = L2_2
  L3_2(L4_2, L5_2)
end
L21_1(L22_1, L23_1)
L21_1 = exports
L22_1 = "AddShell"
function L23_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = Config
  L1_2 = L1_2.Shells
  L2_2 = Config
  L2_2 = L2_2.Shells
  L2_2 = #L2_2
  L2_2 = L2_2 + 1
  L1_2[L2_2] = A0_2
  L1_2 = Debug
  L2_2 = "Added shell"
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L21_1(L22_1, L23_1)
L21_1 = AddEventHandler
L22_1 = "onResourceStop"
function L23_1(A0_2)
  local L1_2, L2_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if L1_2 ~= A0_2 then
    return
  end
  L1_2 = decorate
  L2_2 = L1_2
  L1_2 = L1_2.destroyObjects
  L1_2(L2_2)
  L1_2 = decorate
  L2_2 = L1_2
  L1_2 = L1_2.close
  L1_2(L2_2)
  L1_2 = L17_1
  L1_2()
end
L21_1(L22_1, L23_1)






