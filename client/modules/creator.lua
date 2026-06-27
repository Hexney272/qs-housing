





local L0_1, L1_1, L2_1, L3_1, L4_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = GetEntityModel
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = GetModelDimensions
  L4_2 = L2_2
  L3_2, L4_2 = L3_2(L4_2)
  L5_2 = GetEntityCoords
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  L6_2 = L4_2.x
  L7_2 = L3_2.x
  L6_2 = L6_2 - L7_2
  L7_2 = L4_2.y
  L8_2 = L3_2.y
  L7_2 = L7_2 - L8_2
  L8_2 = L4_2.z
  L9_2 = L3_2.z
  L8_2 = L8_2 - L9_2
  L9_2 = vec3
  L10_2 = L5_2.x
  L10_2 = L10_2 - L6_2
  L11_2 = L5_2.y
  L11_2 = L11_2 - L7_2
  L12_2 = L5_2.z
  L12_2 = L12_2 - L8_2
  L9_2 = L9_2(L10_2, L11_2, L12_2)
  L10_2 = vec3
  L11_2 = L5_2.x
  L11_2 = L11_2 + L6_2
  L12_2 = L5_2.y
  L12_2 = L12_2 + L7_2
  L13_2 = L5_2.z
  L13_2 = L13_2 + L8_2
  L10_2 = L10_2(L11_2, L12_2, L13_2)
  L11_2 = A1_2.x
  L12_2 = L9_2.x
  L11_2 = L11_2 >= L12_2
  return L11_2
end
L1_1 = {}
L2_1 = i18n
L2_1 = L2_1.t
L3_1 = "drawtext.entry_point"
L2_1 = L2_1(L3_1)
L1_1.entry = L2_1
L2_1 = i18n
L2_1 = L2_1.t
L3_1 = "drawtext.board_point"
L2_1 = L2_1(L3_1)
L1_1.board = L2_1
L2_1 = i18n
L2_1 = L2_1.t
L3_1 = "drawtext.shell_point"
L2_1 = L2_1(L3_1)
L1_1.shell = L2_1
L2_1 = i18n
L2_1 = L2_1.t
L3_1 = "drawtext.exit_point"
L2_1 = L2_1(L3_1)
L1_1.exit = L2_1
L2_1 = i18n
L2_1 = L2_1.t
L3_1 = "drawtext.house_point"
L2_1 = L2_1(L3_1)
L1_1.customHouse = L2_1
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L3_2 = Config
  L3_2 = L3_2.Shells
  L3_2 = L3_2[A1_2]
  if not L3_2 then
    L3_2 = Config
    L3_2 = L3_2.Shells
    L3_2 = L3_2[1]
  end
  L4_2 = joaat
  L5_2 = L3_2.model
  L4_2 = L4_2(L5_2)
  L5_2 = lib
  L5_2 = L5_2.requestModel
  L6_2 = L4_2
  L7_2 = Config
  L7_2 = L7_2.DefaultRequestModelTimeout
  L5_2(L6_2, L7_2)
  L5_2 = CreateObject
  L6_2 = L4_2
  L7_2 = A0_2.x
  L8_2 = A0_2.y
  L9_2 = A0_2.z
  L10_2 = false
  L11_2 = true
  L12_2 = true
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = SetEntityCollision
  L7_2 = L5_2
  L8_2 = false
  L9_2 = false
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = SetEntityCompletelyDisableCollision
  L7_2 = L5_2
  L8_2 = true
  L9_2 = false
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = FreezeEntityPosition
  L7_2 = L5_2
  L8_2 = true
  L6_2(L7_2, L8_2)
  L6_2 = SetEntityInvincible
  L7_2 = L5_2
  L8_2 = true
  L6_2(L7_2, L8_2)
  L6_2 = SetEntityDrawOutline
  L7_2 = L5_2
  L8_2 = true
  L6_2(L7_2, L8_2)
  L6_2 = SetModelAsNoLongerNeeded
  L7_2 = L4_2
  L6_2(L7_2)
  L6_2 = SetEntityDrawOutlineColor
  L7_2 = 0
  L8_2 = 255
  L9_2 = 0
  L10_2 = 255
  L6_2(L7_2, L8_2, L9_2, L10_2)
  if A2_2 then
    L6_2 = SetEntityHeading
    L7_2 = L5_2
    L8_2 = A2_2
    L6_2(L7_2, L8_2)
  end
  return L5_2
end
function L3_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  if A3_2 then
    L4_2 = Config
    L4_2 = L4_2.Islands
    if L4_2 then
      goto lbl_9
    end
  end
  L4_2 = Config
  L4_2 = L4_2.HouseObjects
  ::lbl_9::
  L5_2 = L4_2[A1_2]
  if not L5_2 then
    L5_2 = L4_2[1]
  end
  L6_2 = joaat
  L7_2 = L5_2.model
  L6_2 = L6_2(L7_2)
  L7_2 = lib
  L7_2 = L7_2.requestModel
  L8_2 = L6_2
  L9_2 = Config
  L9_2 = L9_2.DefaultRequestModelTimeout
  L7_2(L8_2, L9_2)
  L7_2 = CreateObject
  L8_2 = L6_2
  L9_2 = A0_2.x
  L10_2 = A0_2.y
  L11_2 = A0_2.z
  L12_2 = false
  L13_2 = true
  L14_2 = true
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L8_2 = SetEntityCollision
  L9_2 = L7_2
  L10_2 = false
  L11_2 = false
  L8_2(L9_2, L10_2, L11_2)
  L8_2 = SetEntityCompletelyDisableCollision
  L9_2 = L7_2
  L10_2 = true
  L11_2 = false
  L8_2(L9_2, L10_2, L11_2)
  L8_2 = FreezeEntityPosition
  L9_2 = L7_2
  L10_2 = true
  L8_2(L9_2, L10_2)
  L8_2 = SetEntityInvincible
  L9_2 = L7_2
  L10_2 = true
  L8_2(L9_2, L10_2)
  L8_2 = SetEntityDrawOutline
  L9_2 = L7_2
  L10_2 = true
  L8_2(L9_2, L10_2)
  L8_2 = SetModelAsNoLongerNeeded
  L9_2 = L6_2
  L8_2(L9_2)
  L8_2 = SetEntityDrawOutlineColor
  L9_2 = 0
  L10_2 = 255
  L11_2 = 0
  L12_2 = 255
  L8_2(L9_2, L10_2, L11_2, L12_2)
  if A2_2 then
    L8_2 = SetEntityHeading
    L9_2 = L7_2
    L10_2 = A2_2
    L8_2(L9_2, L10_2)
  end
  return L7_2
end
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2
  L2_2 = cache
  L2_2 = L2_2.ped
  L3_2 = GetEntityMatrix
  L4_2 = L2_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  L7_2 = GetEntityHeading
  L8_2 = L2_2
  L7_2 = L7_2(L8_2)
  L8_2 = L5_2 * 2
  L8_2 = L6_2 + L8_2
  L9_2 = A1_2 or L9_2
  if A1_2 then
    L9_2 = A1_2.camOffset
  end
  if L9_2 then
    L9_2 = A1_2 or L9_2
    if A1_2 then
      L9_2 = A1_2.camOffset
    end
    L8_2 = L6_2 + L9_2
  end
  if "shell" == A0_2 then
    L9_2 = Config
    L9_2 = L9_2.MinZOffset
    L8_2 = L6_2 - L9_2
  elseif "exit" == A0_2 then
    L9_2 = vec3
    L10_2 = A1_2.coords
    L10_2 = L10_2.x
    L11_2 = A1_2.coords
    L11_2 = L11_2.y
    L12_2 = A1_2.coords
    L12_2 = L12_2.z
    L9_2 = L9_2(L10_2, L11_2, L12_2)
    L10_2 = L5_2 * 2
    L8_2 = L9_2 + L10_2
  end
  L9_2 = vector3
  L10_2 = -35.0
  L11_2 = 0.0
  L12_2 = 0.0
  L9_2 = L9_2(L10_2, L11_2, L12_2)
  L10_2 = Utils
  L10_2 = L10_2.CreateCamera
  L11_2 = "DEFAULT_SCRIPTED_CAMERA"
  L12_2 = L8_2
  L13_2 = L9_2
  L14_2 = true
  L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
  L11_2 = {}
  L12_2 = "done"
  L13_2 = "cancel"
  L14_2 = "up"
  L15_2 = "right"
  L16_2 = "forward"
  L17_2 = "rotate_z"
  L11_2[1] = L12_2
  L11_2[2] = L13_2
  L11_2[3] = L14_2
  L11_2[4] = L15_2
  L11_2[5] = L16_2
  L11_2[6] = L17_2
  if "shell" == A0_2 then
    L12_2 = #L11_2
    L12_2 = L12_2 + 1
    L11_2[L12_2] = "increase_z"
    L12_2 = #L11_2
    L12_2 = L12_2 + 1
    L11_2[L12_2] = "change_shell"
    L12_2 = #L11_2
    L12_2 = L12_2 + 1
    L11_2[L12_2] = "decrease_z"
  elseif "customHouse" == A0_2 then
    L12_2 = ActionControls
    L12_2 = L12_2.rotate_z_scroll
    L13_2 = i18n
    L13_2 = L13_2.t
    L14_2 = "creator.raycast.scroll_position_z"
    L13_2 = L13_2(L14_2)
    L12_2.label = L13_2
    L12_2 = #L11_2
    L12_2 = L12_2 + 1
    L11_2[L12_2] = "rotate_z_scroll"
  end
  L12_2 = Utils
  L12_2 = L12_2.GetControls
  L13_2 = L11_2
  L12_2 = L12_2(L13_2)
  L13_2 = Utils
  L13_2 = L13_2.CreateInstructional
  L14_2 = L12_2
  L13_2 = L13_2(L14_2)
  EnabledMouseMovement = true
  L14_2 = nil
  L15_2 = L1_1
  L15_2 = L15_2[A0_2]
  L16_2 = nil
  L17_2 = nil
  L18_2 = nil
  L19_2 = nil
  L20_2 = 1
  function L21_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    L0_3 = lib
    L0_3 = L0_3.hideMenu
    L0_3()
    L0_3 = A0_2
    L1_3 = L0_3
    L0_3 = L0_3.includes
    L2_3 = {}
    L3_3 = "entry"
    L4_3 = "board"
    L5_3 = "shell"
    L6_3 = "customHouse"
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L0_3 = L0_3(L1_3, L2_3)
    if L0_3 then
      L0_3 = GetEntityCoords
      L1_3 = L16_2
      L0_3 = L0_3(L1_3)
      L1_3 = vec4
      L2_3 = L0_3.x
      L3_3 = L0_3.y
      L4_3 = L0_3.z
      L5_3 = GetEntityHeading
      L6_3 = L16_2
      L5_3, L6_3 = L5_3(L6_3)
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3)
      L14_2 = L1_3
      L1_3 = DeleteEntity
      L2_3 = L16_2
      L1_3(L2_3)
    else
      L0_3 = A0_2
      if "exit" == L0_3 then
        L0_3 = GetEntityCoords
        L1_3 = L16_2
        L0_3 = L0_3(L1_3)
        L1_3 = vec4
        L2_3 = L0_3.x
        L3_3 = L0_3.y
        L4_3 = L0_3.z
        L5_3 = GetEntityHeading
        L6_3 = L16_2
        L5_3, L6_3 = L5_3(L6_3)
        L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3)
        L14_2 = L1_3
        L1_3 = DeleteEntity
        L2_3 = L19_2
        L1_3(L2_3)
        L1_3 = DeleteEntity
        L2_3 = L16_2
        L1_3(L2_3)
      end
    end
  end
  function L22_2()
    local L0_3, L1_3
    L0_3 = L21_2
    L0_3()
    L0_3 = EnableAllControlActions
    L1_3 = 0
    L0_3(L1_3)
    L0_3 = Utils
    L0_3 = L0_3.DestroyFlyCam
    L1_3 = L10_2
    L0_3(L1_3)
    L0_3 = RefreshPolyZones
    L0_3()
    L0_3 = A0_2
    if "shell" ~= L0_3 then
      L0_3 = A0_2
      if "customHouse" ~= L0_3 then
        goto lbl_21
      end
    end
    L0_3 = L20_2
    L1_3 = L14_2
    do return L0_3, L1_3 end
    ::lbl_21::
    L0_3 = L14_2
    return L0_3
  end
  if "entry" == A0_2 then
    L23_2 = vec4
    L24_2 = L6_2.x
    L25_2 = L6_2.y
    L26_2 = L6_2.z
    L27_2 = L7_2
    L23_2 = L23_2(L24_2, L25_2, L26_2, L27_2)
    L14_2 = L23_2
    L23_2 = ClonePed
    L24_2 = cache
    L24_2 = L24_2.ped
    L25_2 = false
    L26_2 = false
    L27_2 = true
    L23_2 = L23_2(L24_2, L25_2, L26_2, L27_2)
    L16_2 = L23_2
    L23_2 = SetEntityAlpha
    L24_2 = L16_2
    L25_2 = Config
    L25_2 = L25_2.CreatorAlpha
    L26_2 = false
    L23_2(L24_2, L25_2, L26_2)
    L17_2 = L7_2
  elseif "board" == A0_2 then
    L23_2 = joaat
    L24_2 = Config
    L24_2 = L24_2.BoardObject
    L23_2 = L23_2(L24_2)
    L24_2 = lib
    L24_2 = L24_2.requestModel
    L25_2 = L23_2
    L26_2 = Config
    L26_2 = L26_2.DefaultRequestModelTimeout
    L24_2(L25_2, L26_2)
    L24_2 = CreateObject
    L25_2 = joaat
    L26_2 = Config
    L26_2 = L26_2.BoardObject
    L25_2 = L25_2(L26_2)
    L26_2 = L6_2.x
    L27_2 = L6_2.y
    L28_2 = L6_2.z
    L29_2 = false
    L30_2 = true
    L31_2 = true
    L24_2 = L24_2(L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2)
    L16_2 = L24_2
    L24_2 = SetEntityAlpha
    L25_2 = L16_2
    L26_2 = Config
    L26_2 = L26_2.CreatorAlpha
    L27_2 = false
    L24_2(L25_2, L26_2, L27_2)
    L24_2 = SetModelAsNoLongerNeeded
    L25_2 = L23_2
    L24_2(L25_2)
    L17_2 = L7_2
  elseif "shell" == A0_2 then
    L23_2 = L2_1
    L24_2 = L6_2
    L25_2 = L20_2
    L26_2 = L7_2
    L23_2 = L23_2(L24_2, L25_2, L26_2)
    L16_2 = L23_2
    L17_2 = L7_2
  elseif "exit" == A0_2 then
    L23_2 = ClonePed
    L24_2 = cache
    L24_2 = L24_2.ped
    L25_2 = false
    L26_2 = false
    L27_2 = true
    L23_2 = L23_2(L24_2, L25_2, L26_2, L27_2)
    L16_2 = L23_2
    L23_2 = SetEntityAlpha
    L24_2 = L16_2
    L25_2 = Config
    L25_2 = L25_2.CreatorAlpha
    L26_2 = false
    L23_2(L24_2, L25_2, L26_2)
    L23_2 = L2_1
    L24_2 = A1_2.coords
    L25_2 = A1_2.tier
    L26_2 = A1_2.coords
    L26_2 = L26_2.w
    L23_2 = L23_2(L24_2, L25_2, L26_2)
    L19_2 = L23_2
    L23_2 = A1_2.coords
    L17_2 = L23_2.w
  elseif "customHouse" == A0_2 then
    L23_2 = L3_1
    L24_2 = L6_2
    L25_2 = L20_2
    L26_2 = L7_2
    L27_2 = A1_2 or L27_2
    if A1_2 then
      L27_2 = A1_2.isIsland
    end
    L23_2 = L23_2(L24_2, L25_2, L26_2, L27_2)
    L16_2 = L23_2
    L17_2 = L7_2
  end
  if "customHouse" == A0_2 then
    L23_2 = A1_2 or L23_2
    if A1_2 then
      L23_2 = A1_2.isIsland
    end
    if L23_2 then
      L23_2 = Config
      L23_2 = L23_2.Islands
      if L23_2 then
        goto lbl_231
      end
    end
  end
  L23_2 = Config
  L23_2 = L23_2.HouseObjects
  ::lbl_231::
  while true do
    L24_2 = Wait
    L25_2 = 0
    L24_2(L25_2)
    L24_2 = DisableAllControlActions
    L25_2 = 0
    L24_2(L25_2)
    L24_2 = Utils
    L24_2 = L24_2.HandleFlyCam
    L25_2 = L10_2
    L24_2, L25_2 = L24_2(L25_2)
    L9_2 = L25_2
    L8_2 = L24_2
    L24_2 = GetFrameTime
    L24_2 = L24_2()
    L25_2 = GetCamMatrix
    L26_2 = L10_2
    L25_2, L26_2, L27_2, L28_2 = L25_2(L26_2)
    L29_2 = nil
    L30_2 = nil
    L31_2 = nil
    L32_2 = nil
    L33_2 = nil
    if "shell" == A0_2 then
      L34_2 = L26_2 * 25.0
      L31_2 = L28_2 + L34_2
    else
      L34_2 = _ENV
      L35_2 = "StartExpensiveSynchronousShapeTestLosProbe"
      L34_2 = L34_2[L35_2]
      L35_2 = L28_2.x
      L36_2 = L28_2.y
      L37_2 = L28_2.z
      L38_2 = L28_2.x
      L39_2 = L26_2.x
      L39_2 = L39_2 * 100.0
      L38_2 = L38_2 + L39_2
      L39_2 = L28_2.y
      L40_2 = L26_2.y
      L40_2 = L40_2 * 100.0
      L39_2 = L39_2 + L40_2
      L40_2 = L28_2.z
      L41_2 = L26_2.z
      L41_2 = L41_2 * 100.0
      L40_2 = L40_2 + L41_2
      L41_2 = 4294967295
      L42_2 = L16_2
      L43_2 = 7
      L34_2 = L34_2(L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2)
      L35_2 = GetShapeTestResult
      L36_2 = L34_2
      L35_2, L36_2, L37_2, L38_2, L39_2 = L35_2(L36_2)
      L33_2 = L39_2
      L32_2 = L38_2
      L31_2 = L37_2
      L30_2 = L36_2
      L29_2 = L35_2
    end
    L34_2 = IsDisabledControlJustPressed
    L35_2 = 0
    L36_2 = ActionControls
    L36_2 = L36_2.done
    L36_2 = L36_2.codes
    L36_2 = L36_2[1]
    L34_2 = L34_2(L35_2, L36_2)
    if L34_2 then
      if "exit" == A0_2 then
        L34_2 = L0_1
        L35_2 = L19_2
        L36_2 = L31_2
        L34_2 = L34_2(L35_2, L36_2)
        if L34_2 then
          L34_2 = L22_2
          return L34_2()
        else
          L34_2 = Notification
          L35_2 = i18n
          L35_2 = L35_2.t
          L36_2 = "coords_not_in_shell"
          L35_2 = L35_2(L36_2)
          L36_2 = "error"
          L34_2(L35_2, L36_2)
        end
      else
        L34_2 = Config
        L34_2 = L34_2.NeedToBeInsidePoints
        L34_2 = L34_2[A0_2]
        if not L34_2 then
          L34_2 = L22_2
          return L34_2()
        else
          L34_2 = creator
          L35_2 = L34_2
          L34_2 = L34_2.isInPoints
          L36_2 = L31_2
          L34_2 = L34_2(L35_2, L36_2)
          if L34_2 then
            L34_2 = L22_2
            return L34_2()
          else
            L34_2 = Notification
            L35_2 = i18n
            L35_2 = L35_2.t
            L36_2 = "polyzone_nearby"
            L35_2 = L35_2(L36_2)
            L36_2 = "error"
            L34_2(L35_2, L36_2)
          end
        end
      end
    end
    L34_2 = IsDisabledControlJustPressed
    L35_2 = 0
    L36_2 = ActionControls
    L36_2 = L36_2.cancel
    L36_2 = L36_2.codes
    L36_2 = L36_2[1]
    L34_2 = L34_2(L35_2, L36_2)
    if not L34_2 then
      L34_2 = IsDisabledControlJustPressed
      L35_2 = 0
      L36_2 = 322
      L34_2 = L34_2(L35_2, L36_2)
      if not L34_2 then
        goto lbl_375
      end
    end
    L34_2 = L21_2
    L34_2()
    L34_2 = EnableAllControlActions
    L35_2 = 0
    L34_2(L35_2)
    L34_2 = Utils
    L34_2 = L34_2.DestroyFlyCam
    L35_2 = L10_2
    L34_2(L35_2)
    L34_2 = RefreshPolyZones
    L34_2()
    L34_2 = false
    do return L34_2 end
    ::lbl_375::
    L35_2 = A0_2
    L34_2 = A0_2.includes
    L36_2 = {}
    L37_2 = "shell"
    L38_2 = "customHouse"
    L36_2[1] = L37_2
    L36_2[2] = L38_2
    L34_2 = L34_2(L35_2, L36_2)
    if L34_2 then
      L34_2 = IsDisabledControlPressed
      L35_2 = 0
      L36_2 = ActionControls
      L36_2 = L36_2.increase_z
      L36_2 = L36_2.codes
      L36_2 = L36_2[1]
      L34_2 = L34_2(L35_2, L36_2)
      if L34_2 then
        L34_2 = L18_2 or L34_2
        if not L18_2 then
          L34_2 = L31_2.z
        end
        L18_2 = L34_2 - 0.1
      end
      L34_2 = IsDisabledControlPressed
      L35_2 = 0
      L36_2 = ActionControls
      L36_2 = L36_2.increase_z
      L36_2 = L36_2.codes
      L36_2 = L36_2[2]
      L34_2 = L34_2(L35_2, L36_2)
      if L34_2 then
        L34_2 = L18_2 or L34_2
        if not L18_2 then
          L34_2 = L31_2.z
        end
        L18_2 = L34_2 + 0.1
      end
      L34_2 = IsDisabledControlJustPressed
      L35_2 = 0
      L36_2 = ActionControls
      L36_2 = L36_2.change_shell
      L36_2 = L36_2.codes
      L36_2 = L36_2[1]
      L34_2 = L34_2(L35_2, L36_2)
      if L34_2 then
        if "shell" == A0_2 then
          L34_2 = Config
          L34_2 = L34_2.Shells
          L34_2 = #L34_2
          if L34_2 then
            goto lbl_429
          end
        end
        L34_2 = #L23_2
        ::lbl_429::
        L35_2 = L20_2 + 1
        if L34_2 >= L35_2 then
          L35_2 = L20_2 + 1
          if L35_2 then
            goto lbl_438
            L20_2 = L35_2 or L20_2
          end
        end
        L20_2 = 1
        ::lbl_438::
        L35_2 = GetEntityCoords
        L36_2 = L16_2
        L35_2 = L35_2(L36_2)
        L36_2 = DeleteEntity
        L37_2 = L16_2
        L36_2(L37_2)
        if "shell" == A0_2 then
          L36_2 = L2_1
          L37_2 = L35_2
          L38_2 = L20_2
          L39_2 = L17_2
          L36_2 = L36_2(L37_2, L38_2, L39_2)
          L16_2 = L36_2
        else
          L36_2 = L3_1
          L37_2 = L35_2
          L38_2 = L20_2
          L39_2 = L17_2
          L40_2 = A1_2 or L40_2
          if A1_2 then
            L40_2 = A1_2.isIsland
          end
          L36_2 = L36_2(L37_2, L38_2, L39_2, L40_2)
          L16_2 = L36_2
        end
      end
      L34_2 = IsDisabledControlJustPressed
      L35_2 = 0
      L36_2 = ActionControls
      L36_2 = L36_2.change_shell
      L36_2 = L36_2.codes
      L36_2 = L36_2[2]
      L34_2 = L34_2(L35_2, L36_2)
      if L34_2 then
        if "shell" == A0_2 then
          L34_2 = Config
          L34_2 = L34_2.Shells
          L34_2 = #L34_2
          if L34_2 then
            goto lbl_479
          end
        end
        L34_2 = #L23_2
        ::lbl_479::
        L35_2 = L20_2 - 1
        if L35_2 > 0 then
          L35_2 = L20_2 - 1
          if L35_2 then
            goto lbl_488
            L20_2 = L35_2 or L20_2
          end
        end
        L20_2 = L34_2
        ::lbl_488::
        L35_2 = GetEntityCoords
        L36_2 = L16_2
        L35_2 = L35_2(L36_2)
        L36_2 = DeleteEntity
        L37_2 = L16_2
        L36_2(L37_2)
        if "shell" == A0_2 then
          L36_2 = L2_1
          L37_2 = L35_2
          L38_2 = L20_2
          L39_2 = L17_2
          L36_2 = L36_2(L37_2, L38_2, L39_2)
          L16_2 = L36_2
        else
          L36_2 = L3_1
          L37_2 = L35_2
          L38_2 = L20_2
          L39_2 = L17_2
          L40_2 = A1_2 or L40_2
          if A1_2 then
            L40_2 = A1_2.isIsland
          end
          L36_2 = L36_2(L37_2, L38_2, L39_2, L40_2)
          L16_2 = L36_2
        end
      end
    end
    L34_2 = IsDisabledControlPressed
    L35_2 = 0
    L36_2 = ActionControls
    L36_2 = L36_2.rotate_z
    L36_2 = L36_2.codes
    L36_2 = L36_2[1]
    L34_2 = L34_2(L35_2, L36_2)
    if L34_2 then
      L35_2 = A0_2
      L34_2 = A0_2.includes
      L36_2 = {}
      L37_2 = "entry"
      L38_2 = "board"
      L39_2 = "shell"
      L40_2 = "exit"
      L41_2 = "customHouse"
      L36_2[1] = L37_2
      L36_2[2] = L38_2
      L36_2[3] = L39_2
      L36_2[4] = L40_2
      L36_2[5] = L41_2
      L34_2 = L34_2(L35_2, L36_2)
      if L34_2 then
        L17_2 = L17_2 + 1.0
      end
    end
    L34_2 = IsDisabledControlPressed
    L35_2 = 0
    L36_2 = ActionControls
    L36_2 = L36_2.rotate_z
    L36_2 = L36_2.codes
    L36_2 = L36_2[2]
    L34_2 = L34_2(L35_2, L36_2)
    if L34_2 then
      L35_2 = A0_2
      L34_2 = A0_2.includes
      L36_2 = {}
      L37_2 = "entry"
      L38_2 = "board"
      L39_2 = "shell"
      L40_2 = "exit"
      L41_2 = "customHouse"
      L36_2[1] = L37_2
      L36_2[2] = L38_2
      L36_2[3] = L39_2
      L36_2[4] = L40_2
      L36_2[5] = L41_2
      L34_2 = L34_2(L35_2, L36_2)
      if L34_2 then
        L17_2 = L17_2 - 1.0
      end
    end
    L34_2 = SetEntityCoords
    L35_2 = L16_2
    L36_2 = L31_2.x
    L37_2 = L31_2.y
    L38_2 = L18_2 or L38_2
    if not L18_2 then
      L38_2 = L31_2.z
    end
    L39_2 = false
    L40_2 = false
    L41_2 = false
    L42_2 = false
    L34_2(L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2)
    L34_2 = SetEntityHeading
    L35_2 = L16_2
    L36_2 = L17_2
    L34_2(L35_2, L36_2)
    if "shell" ~= A0_2 then
      L34_2 = DrawLine
      L35_2 = L31_2.x
      L36_2 = L31_2.y
      L37_2 = L31_2.z
      L38_2 = L31_2.x
      L39_2 = L31_2.y
      L40_2 = L31_2.z
      L40_2 = L40_2 + 10.0
      L41_2 = 255
      L42_2 = 0
      L43_2 = 0
      L44_2 = 255
      L34_2(L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
      L34_2 = DrawText3Ds
      L35_2 = L31_2.x
      L36_2 = L31_2.y
      L37_2 = L31_2.z
      L37_2 = L37_2 + 1.0
      L38_2 = L15_2
      L34_2(L35_2, L36_2, L37_2, L38_2)
    end
    L34_2 = Utils
    L34_2 = L34_2.DrawScaleform
    L35_2 = L13_2
    L34_2(L35_2)
  end
end
RayCastSelector = L4_1
function L4_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2
  L0_2 = {}
  L1_2 = cache
  L1_2 = L1_2.ped
  L2_2 = GetEntityMatrix
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  L6_2 = L4_2 * 2
  L6_2 = L5_2 + L6_2
  L7_2 = vector3
  L8_2 = -35.0
  L9_2 = 0.0
  L10_2 = 0.0
  L7_2 = L7_2(L8_2, L9_2, L10_2)
  L8_2 = false
  L9_2 = Utils
  L9_2 = L9_2.CreateCamera
  L10_2 = "DEFAULT_SCRIPTED_CAMERA"
  L11_2 = L6_2
  L12_2 = L7_2
  L13_2 = true
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
  L10_2 = Utils
  L10_2 = L10_2.GetControls
  L11_2 = {}
  L12_2 = "done"
  L13_2 = "cancel"
  L14_2 = "add_point"
  L15_2 = "undo_point"
  L11_2[1] = L12_2
  L11_2[2] = L13_2
  L11_2[3] = L14_2
  L11_2[4] = L15_2
  L10_2 = L10_2(L11_2)
  L11_2 = Utils
  L11_2 = L11_2.CreateInstructional
  L12_2 = L10_2
  L11_2 = L11_2(L12_2)
  EnabledMouseMovement = true
  L12_2 = {}
  L12_2.r = 116
  L12_2.g = 189
  L12_2.b = 252
  L12_2.a = 100
  while true do
    L13_2 = Wait
    L14_2 = 0
    L13_2(L14_2)
    L13_2 = IsDisabledControlJustPressed
    L14_2 = 0
    L15_2 = ActionControls
    L15_2 = L15_2.done
    L15_2 = L15_2.codes
    L15_2 = L15_2[1]
    L13_2 = L13_2(L14_2, L15_2)
    if L13_2 then
      L13_2 = #L0_2
      if L13_2 > 0 then
        L13_2 = EnableAllControlActions
        L14_2 = 0
        L13_2(L14_2)
        L13_2 = Utils
        L13_2 = L13_2.DestroyFlyCam
        L14_2 = L9_2
        L13_2(L14_2)
        L13_2 = pairs
        L14_2 = L0_2
        L13_2, L14_2, L15_2, L16_2 = L13_2(L14_2)
        for L17_2, L18_2 in L13_2, L14_2, L15_2, L16_2 do
          L19_2 = SetEntityDrawOutline
          L20_2 = L18_2.tempHandle
          L21_2 = false
          L19_2(L20_2, L21_2)
        end
        return L0_2
      else
        L13_2 = Notification
        L14_2 = i18n
        L14_2 = L14_2.t
        L15_2 = "choose_door"
        L14_2 = L14_2(L15_2)
        L15_2 = "error"
        L13_2(L14_2, L15_2)
      end
    end
    L13_2 = IsDisabledControlJustPressed
    L14_2 = 0
    L15_2 = ActionControls
    L15_2 = L15_2.cancel
    L15_2 = L15_2.codes
    L15_2 = L15_2[1]
    L13_2 = L13_2(L14_2, L15_2)
    if not L13_2 then
      L13_2 = IsDisabledControlJustPressed
      L14_2 = 0
      L15_2 = 322
      L13_2 = L13_2(L14_2, L15_2)
      if not L13_2 then
        goto lbl_123
      end
    end
    L13_2 = EnableAllControlActions
    L14_2 = 0
    L13_2(L14_2)
    L13_2 = Utils
    L13_2 = L13_2.DestroyFlyCam
    L14_2 = L9_2
    L13_2(L14_2)
    L13_2 = pairs
    L14_2 = L0_2
    L13_2, L14_2, L15_2, L16_2 = L13_2(L14_2)
    for L17_2, L18_2 in L13_2, L14_2, L15_2, L16_2 do
      L19_2 = SetEntityDrawOutline
      L20_2 = L18_2.tempHandle
      L21_2 = false
      L19_2(L20_2, L21_2)
    end
    L13_2 = false
    do return L13_2 end
    ::lbl_123::
    L13_2 = DisableAllControlActions
    L14_2 = 0
    L13_2(L14_2)
    L13_2 = Utils
    L13_2 = L13_2.HandleFlyCam
    L14_2 = L9_2
    L13_2, L14_2 = L13_2(L14_2)
    L7_2 = L14_2
    L6_2 = L13_2
    L13_2 = GetFrameTime
    L13_2 = L13_2()
    L14_2 = GetCamMatrix
    L15_2 = L9_2
    L14_2, L15_2, L16_2, L17_2 = L14_2(L15_2)
    L18_2 = StartShapeTestRay
    L19_2 = L17_2.x
    L20_2 = L17_2.y
    L21_2 = L17_2.z
    L22_2 = L17_2.x
    L23_2 = L15_2.x
    L23_2 = L23_2 * 100.0
    L22_2 = L22_2 + L23_2
    L23_2 = L17_2.y
    L24_2 = L15_2.y
    L24_2 = L24_2 * 100.0
    L23_2 = L23_2 + L24_2
    L24_2 = L17_2.z
    L25_2 = L15_2.z
    L25_2 = L25_2 * 100.0
    L24_2 = L24_2 + L25_2
    L25_2 = -1
    L26_2 = L1_2
    L27_2 = 0
    L18_2 = L18_2(L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
    L19_2 = GetShapeTestResult
    L20_2 = L18_2
    L19_2, L20_2, L21_2, L22_2, L23_2 = L19_2(L20_2)
    L24_2 = IsDisabledControlJustPressed
    L25_2 = 0
    L26_2 = ActionControls
    L26_2 = L26_2.add_point
    L26_2 = L26_2.codes
    L26_2 = L26_2[1]
    L24_2 = L24_2(L25_2, L26_2)
    if L24_2 then
      if L23_2 then
        L24_2 = IsEntityAnObject
        L25_2 = L23_2
        L24_2 = L24_2(L25_2)
        if L24_2 then
          L24_2 = GetEntityCoords
          L25_2 = L23_2
          L24_2 = L24_2(L25_2)
          if L8_2 and L24_2 == L8_2 then
            L25_2 = Notification
            L26_2 = i18n
            L26_2 = L26_2.t
            L27_2 = "door_already_added"
            L26_2 = L26_2(L27_2)
            L27_2 = "info"
            L25_2(L26_2, L27_2)
          else
            L25_2 = table
            L25_2 = L25_2.insert
            L26_2 = L0_2
            L27_2 = {}
            L28_2 = GetEntityModel
            L29_2 = L23_2
            L28_2 = L28_2(L29_2)
            L27_2.hash = L28_2
            L27_2.coords = L24_2
            L28_2 = GetEntityHeading
            L29_2 = L23_2
            L28_2 = L28_2(L29_2)
            L27_2.h = L28_2
            L27_2.locked = true
            L27_2.obj = nil
            L27_2.tempHandle = L23_2
            L25_2(L26_2, L27_2)
            L8_2 = L24_2
            L25_2 = Notification
            L26_2 = i18n
            L26_2 = L26_2.t
            L27_2 = "creator.new_door"
            L26_2 = L26_2(L27_2)
            L27_2 = "success"
            L25_2(L26_2, L27_2)
            L25_2 = SetEntityDrawOutline
            L26_2 = L23_2
            L27_2 = true
            L25_2(L26_2, L27_2)
            L25_2 = SetEntityDrawOutlineColor
            L26_2 = 0
            L27_2 = 255
            L28_2 = 0
            L29_2 = 255
            L25_2(L26_2, L27_2, L28_2, L29_2)
          end
      end
      else
        L24_2 = Notification
        L25_2 = i18n
        L25_2 = L25_2.t
        L26_2 = "choose_door"
        L25_2 = L25_2(L26_2)
        L26_2 = "error"
        L24_2(L25_2, L26_2)
      end
    end
    L24_2 = IsDisabledControlJustPressed
    L25_2 = 0
    L26_2 = ActionControls
    L26_2 = L26_2.undo_point
    L26_2 = L26_2.codes
    L26_2 = L26_2[1]
    L24_2 = L24_2(L25_2, L26_2)
    if L24_2 then
      L24_2 = #L0_2
      if L24_2 > 0 then
        L24_2 = #L0_2
        L24_2 = L0_2[L24_2]
        L25_2 = SetEntityDrawOutline
        L26_2 = L24_2.tempHandle
        L27_2 = false
        L25_2(L26_2, L27_2)
        L25_2 = table
        L25_2 = L25_2.remove
        L26_2 = L0_2
        L27_2 = #L0_2
        L25_2(L26_2, L27_2)
        L8_2 = false
        L25_2 = Notification
        L26_2 = i18n
        L26_2 = L26_2.t
        L27_2 = "door_removed"
        L26_2 = L26_2(L27_2)
        L27_2 = "success"
        L25_2(L26_2, L27_2)
      else
        L24_2 = Notification
        L25_2 = i18n
        L25_2 = L25_2.t
        L26_2 = "no_doors"
        L25_2 = L25_2(L26_2)
        L26_2 = "error"
        L24_2(L25_2, L26_2)
      end
    end
    if L23_2 then
      L24_2 = IsEntityAnObject
      L25_2 = L23_2
      L24_2 = L24_2(L25_2)
      if L24_2 then
        L24_2 = GetEntityCoords
        L25_2 = L23_2
        L24_2 = L24_2(L25_2)
        L25_2 = DrawMarker
        L26_2 = 21
        L27_2 = L24_2.x
        L28_2 = L24_2.y
        L29_2 = L24_2.z
        L29_2 = L29_2 + 1
        L30_2 = 0.0
        L31_2 = 0.0
        L32_2 = 0.0
        L33_2 = 0.0
        L34_2 = 180.0
        L35_2 = 0.0
        L36_2 = 1.0
        L37_2 = 1.0
        L38_2 = 1.0
        L39_2 = 255
        L40_2 = 0
        L41_2 = 0
        L42_2 = 255
        L43_2 = false
        L44_2 = true
        L45_2 = 2
        L46_2 = nil
        L47_2 = nil
        L48_2 = false
        L25_2(L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2)
      end
    end
    L24_2 = DrawLine
    L25_2 = L21_2.x
    L26_2 = L21_2.y
    L27_2 = L21_2.z
    L28_2 = L21_2.x
    L29_2 = L21_2.y
    L30_2 = L21_2.z
    L30_2 = L30_2 + 1.0
    L31_2 = 255
    L32_2 = 0
    L33_2 = 0
    L34_2 = 255
    L24_2(L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2)
    L24_2 = Utils
    L24_2 = L24_2.DrawScaleform
    L25_2 = L11_2
    L24_2(L25_2)
  end
end
RayCastGetMLO = L4_1






