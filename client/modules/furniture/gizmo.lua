





local L0_1, L1_1, L2_1
L0_1 = _G
L1_1 = {}
L2_1 = {}
L1_1.utils = L2_1
L0_1.gizmo = L1_1
L0_1 = gizmo
function L1_1(A0_2)
  local L1_2, L2_2
  L1_2 = CreateThread
  function L2_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    while true do
      L0_3 = decorate
      L0_3 = L0_3.active
      if not L0_3 then
        break
      end
      L0_3 = decorate
      L0_3 = L0_3.mode
      if "gizmo" ~= L0_3 then
        break
      end
      L0_3 = SendNUIMessage
      L1_3 = {}
      L1_3.action = "set_camera_position"
      L2_3 = {}
      L3_3 = GetFinalRenderedCamCoord
      L3_3 = L3_3()
      L2_3.position = L3_3
      L3_3 = GetFinalRenderedCamRot
      L4_3 = 2
      L3_3 = L3_3(L4_3)
      L2_3.rotation = L3_3
      L1_3.data = L2_3
      L0_3(L1_3)
      L0_3 = Wait
      L1_3 = 0
      L0_3(L1_3)
    end
  end
  L1_2(L2_2)
end
L0_1.handleCameraUpdate = L1_1
L0_1 = gizmo
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = GetEntityCoords
  L2_2 = A0_2.entity
  L1_2 = L1_2(L2_2)
  L2_2 = GetEntityRotation
  L3_2 = A0_2.entity
  L2_2 = L2_2(L3_2)
  L3_2 = SendReactMessage
  L4_2 = "set_gizmo_entity"
  L5_2 = {}
  L6_2 = A0_2.entity
  L5_2.handle = L6_2
  L5_2.position = L1_2
  L5_2.rotation = L2_2
  L3_2(L4_2, L5_2)
  L3_2 = L1_2.z
  L3_2 = L3_2 + 10.0
  A0_2.maxZ = L3_2
  L3_2 = CreateThread
  function L4_2()
    local L0_3, L1_3, L2_3
    while true do
      L0_3 = A0_2.entity
      if not L0_3 then
        break
      end
      L0_3 = DoesEntityExist
      L1_3 = A0_2.entity
      L0_3 = L0_3(L1_3)
      if not L0_3 then
        break
      end
      L0_3 = Wait
      L1_3 = 0
      L0_3(L1_3)
    end
    L0_3 = SendReactMessage
    L1_3 = "set_gizmo_entity"
    L2_3 = nil
    L0_3(L1_3, L2_3)
  end
  L3_2(L4_2)
end
L0_1.selectEntity = L1_1
L0_1 = gizmo
function L1_1(A0_2)
  local L1_2
  A0_2.entity = nil
end
L0_1.deselectEntity = L1_1
L0_1 = RegisterNUICallback
L1_1 = "select_decorate_entity"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = A1_2
  L3_2 = 1
  L2_2(L3_2)
  L2_2 = decorate
  L2_2 = L2_2.mode
  if "gizmo" ~= L2_2 then
    L2_2 = Debug
    L3_2 = "gizmo:selectEntity gizmo mode is not enabled, so we do not select entity"
    return L2_2(L3_2)
  end
  L2_2 = decorate
  L3_2 = L2_2
  L2_2 = L2_2.selectEntity
  L2_2(L3_2)
end
L0_1(L1_1, L2_1)
L0_1 = gizmo
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = SendReactMessage
  L3_2 = "set_gizmo_editor_mode"
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
end
L0_1.setEditorMode = L1_1
L0_1 = RegisterNUICallback
L1_1 = "set_gizmo_editor_mode"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = A1_2
  L3_2 = 1
  L2_2(L3_2)
  L2_2 = gizmo
  L3_2 = L2_2
  L2_2 = L2_2.setEditorMode
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
end
L0_1(L1_1, L2_1)
L0_1 = gizmo
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = A0_2.entity
  if L1_2 then
    L1_2 = DoesEntityExist
    L2_2 = A0_2.entity
    L1_2 = L1_2(L2_2)
    if L1_2 then
      goto lbl_15
    end
  end
  L1_2 = Error
  L2_2 = "updateGizmoEntity"
  L3_2 = "Entity does not exist"
  L4_2 = A0_2.entity
  do return L1_2(L2_2, L3_2, L4_2) end
  ::lbl_15::
  L1_2 = GetEntityCoords
  L2_2 = A0_2.entity
  L1_2 = L1_2(L2_2)
  L2_2 = GetEntityRotation
  L3_2 = A0_2.entity
  L2_2 = L2_2(L3_2)
  L3_2 = SendReactMessage
  L4_2 = "set_gizmo_entity"
  L5_2 = {}
  L6_2 = A0_2.entity
  L5_2.handle = L6_2
  L5_2.position = L1_2
  L5_2.rotation = L2_2
  L3_2(L4_2, L5_2)
end
L0_1.updateGizmoEntity = L1_1
L0_1 = RegisterNUICallback
L1_1 = "move_entity"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = A1_2
  L3_2 = 1
  L2_2(L3_2)
  L2_2 = A0_2.handle
  if L2_2 then
    L2_2 = DoesEntityExist
    L3_2 = A0_2.handle
    L2_2 = L2_2(L3_2)
    if L2_2 then
      goto lbl_18
    end
  end
  L2_2 = Error
  L3_2 = "move_entity"
  L4_2 = "Entity does not exist"
  L5_2 = A0_2.handle
  do return L2_2(L3_2, L4_2, L5_2) end
  ::lbl_18::
  L2_2 = A0_2.position
  if L2_2 then
    L2_2 = A0_2.position
    L3_2 = math
    L3_2 = L3_2.min
    L4_2 = A0_2.position
    L4_2 = L4_2.z
    L5_2 = gizmo
    L5_2 = L5_2.maxZ
    L3_2 = L3_2(L4_2, L5_2)
    L2_2.z = L3_2
    L2_2 = SetEntityCoordsNoOffset
    L3_2 = A0_2.handle
    L4_2 = A0_2.position
    L4_2 = L4_2.x
    L5_2 = A0_2.position
    L5_2 = L5_2.y
    L6_2 = A0_2.position
    L6_2 = L6_2.z
    L7_2 = false
    L8_2 = false
    L9_2 = false
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  end
  L2_2 = A0_2.rotation
  if L2_2 then
    L2_2 = SetEntityRotation
    L3_2 = A0_2.handle
    L4_2 = A0_2.rotation
    L4_2 = L4_2.x
    L5_2 = A0_2.rotation
    L5_2 = L5_2.y
    L6_2 = A0_2.rotation
    L6_2 = L6_2.z
    L7_2 = 0
    L8_2 = false
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  end
  L2_2 = SendReactMessage
  L3_2 = "set_gizmo_entity"
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
end
L0_1(L1_1, L2_1)






