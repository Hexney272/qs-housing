





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1
L0_1 = IsControlPressed
L1_1 = IsDisabledControlPressed
L2_1 = Utils
L2_1 = L2_1.getCursorHitCoords
L3_1 = SetEntityCoords
L4_1 = SetEntityHeading
L5_1 = _G
L6_1 = {}
L5_1.mgizmo = L6_1
L5_1 = mgizmo
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = decorate
  L2_2 = L1_2
  L1_2 = L1_2.instructional
  L3_2 = {}
  L4_2 = {}
  L4_2.key = "rotate_z"
  L4_2.label = "Rotate Z +/-"
  L3_2[1] = L4_2
  L1_2(L2_2, L3_2)
  L1_2 = GetEntityCoords
  L2_2 = A0_2.entity
  L1_2 = L1_2(L2_2)
  A0_2.lastCoords = L1_2
end
L5_1.selectEntity = L6_1
L5_1 = mgizmo
function L6_1(A0_2)
  local L1_2, L2_2
  L1_2 = A0_2.entity
  if not L1_2 then
    return
  end
  A0_2.entity = nil
  A0_2.decorateData = nil
  L1_2 = decorate
  L2_2 = L1_2
  L1_2 = L1_2.instructional
  L1_2(L2_2)
end
L5_1.deselectEntity = L6_1
L5_1 = ActionControls
L5_1 = L5_1.rotate_z
L5_1 = L5_1.codes
L6_1 = mgizmo
function L7_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = A0_2.entity
  if not L1_2 then
    return
  end
  L1_2 = 1
  L2_2 = L5_1
  L2_2 = #L2_2
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = L5_1
    L5_2 = L5_2[L4_2]
    L6_2 = DisableControlAction
    L7_2 = 0
    L8_2 = L5_2
    L9_2 = true
    L6_2(L7_2, L8_2, L9_2)
  end
  L1_2 = L1_1
  L2_2 = 0
  L3_2 = L5_1
  L3_2 = L3_2[1]
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = L4_1
    L2_2 = A0_2.entity
    L3_2 = GetEntityHeading
    L4_2 = A0_2.entity
    L3_2 = L3_2(L4_2)
    L3_2 = L3_2 + 0.3
    L1_2(L2_2, L3_2)
  else
    L1_2 = L1_1
    L2_2 = 0
    L3_2 = L5_1
    L3_2 = L3_2[2]
    L1_2 = L1_2(L2_2, L3_2)
    if L1_2 then
      L1_2 = L4_1
      L2_2 = A0_2.entity
      L3_2 = GetEntityHeading
      L4_2 = A0_2.entity
      L3_2 = L3_2(L4_2)
      L3_2 = L3_2 - 0.3
      L1_2(L2_2, L3_2)
    end
  end
  L1_2 = L2_1
  L2_2 = A0_2.entity
  L1_2, L2_2 = L1_2(L2_2)
  if not L1_2 or not L2_2 then
    L3_2 = Debug
    L4_2 = "mgizmo:updateEntity hitCoords or hitEntity is nil"
    return L3_2(L4_2)
  end
  L3_2 = A0_2.lastCoords
  if L3_2 ~= L1_2 then
    A0_2.lastCoords = L1_2
    L3_2 = L3_1
    L4_2 = A0_2.entity
    L5_2 = L1_2.x
    L6_2 = L1_2.y
    L7_2 = L1_2.z
    L3_2(L4_2, L5_2, L6_2, L7_2)
  end
end
L6_1.updateEntity = L7_1
L6_1 = mgizmo
function L7_1(A0_2)
  local L1_2, L2_2
  L1_2 = CreateThread
  function L2_2()
    local L0_3, L1_3, L2_3
    while true do
      L0_3 = decorate
      L0_3 = L0_3.active
      if not L0_3 then
        break
      end
      L0_3 = decorate
      L0_3 = L0_3.mode
      if "mgizmo" ~= L0_3 then
        break
      end
      L0_3 = Wait
      L1_3 = 0
      L0_3(L1_3)
      L0_3 = IsControlJustPressed
      L1_3 = 0
      L2_3 = 24
      L0_3 = L0_3(L1_3, L2_3)
      if not L0_3 then
        L0_3 = IsDisabledControlJustPressed
        L1_3 = 0
        L2_3 = 24
        L0_3 = L0_3(L1_3, L2_3)
        if not L0_3 then
          goto lbl_29
        end
      end
      L0_3 = decorate
      L1_3 = L0_3
      L0_3 = L0_3.selectEntity
      L2_3 = A0_2.entity
      L0_3(L1_3, L2_3)
      goto lbl_60
      ::lbl_29::
      L0_3 = L0_1
      L1_3 = 0
      L2_3 = 24
      L0_3 = L0_3(L1_3, L2_3)
      if not L0_3 then
        L0_3 = L1_1
        L1_3 = 0
        L2_3 = 24
        L0_3 = L0_3(L1_3, L2_3)
        if not L0_3 then
          goto lbl_45
        end
      end
      L0_3 = A0_2
      L1_3 = L0_3
      L0_3 = L0_3.updateEntity
      L0_3(L1_3)
      goto lbl_60
      ::lbl_45::
      L0_3 = IsControlJustReleased
      L1_3 = 0
      L2_3 = 24
      L0_3 = L0_3(L1_3, L2_3)
      if not L0_3 then
        L0_3 = IsDisabledControlJustReleased
        L1_3 = 0
        L2_3 = 24
        L0_3 = L0_3(L1_3, L2_3)
        if not L0_3 then
          goto lbl_60
        end
      end
      L0_3 = A0_2
      L1_3 = L0_3
      L0_3 = L0_3.deselectEntity
      L0_3(L1_3)
      ::lbl_60::
    end
  end
  L1_2(L2_2)
end
L6_1.loop = L7_1






