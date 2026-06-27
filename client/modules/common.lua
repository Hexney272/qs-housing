





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1
L0_1 = _G
L1_1 = {}
L0_1.common = L1_1
L0_1 = common
function L1_1(A0_2, A1_2)
  local L2_2
  if A1_2 then
    L2_2 = "ANIM@MP_YACHT@SHOWER@FEMALE@"
    if L2_2 then
      goto lbl_7
    end
  end
  L2_2 = "ANIM@MP_YACHT@SHOWER@MALE@"
  ::lbl_7::
  return L2_2
end
L0_1.GetShowerAnimDict = L1_1
L0_1 = common
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  if A1_2 then
    L3_2 = "shower_idle_"
    if L3_2 then
      goto lbl_7
    end
  end
  L3_2 = "male_shower_idle_"
  ::lbl_7::
  L4_2 = {}
  L5_2 = "a"
  L6_2 = "b"
  L7_2 = "c"
  L8_2 = "d"
  L4_2[1] = L5_2
  L4_2[2] = L6_2
  L4_2[3] = L7_2
  L4_2[4] = L8_2
  L5_2 = L3_2
  L6_2 = L4_2[A2_2]
  if not L6_2 then
    L6_2 = "a"
  end
  L5_2 = L5_2 .. L6_2
  return L5_2
end
L0_1.GetShowerIdleAnim = L1_1
L0_1 = common
L1_1 = {}
L1_1.isInBathtub = false
L0_1.bathtub = L1_1
L0_1 = {}
L0_1.waterFallPtfx = nil
L0_1.waterObject = nil
L0_1.objectHandle = nil
L0_1.fillThreadActive = false
L1_1 = common
L2_1 = {}
L2_1.isInShower = false
L1_1.shower = L2_1
L1_1 = {}
L1_1.ptfxHandle = nil
L1_1.animDict = nil
L1_1.animName = nil
L2_1 = common
function L3_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2
  if not A1_2 or not A3_2 then
    return
  end
  L4_2 = A0_2.shower
  L4_2 = L4_2.isInShower
  if L4_2 then
    L4_2 = L1_1.ptfxHandle
    if L4_2 then
      L4_2 = StopParticleFxLooped
      L5_2 = L1_1.ptfxHandle
      L6_2 = false
      L4_2(L5_2, L6_2)
      L1_1.ptfxHandle = nil
    end
    L4_2 = A0_2.shower
    L4_2.isInShower = false
    L1_1.animDict = nil
    L1_1.animName = nil
    return
  end
  L4_2 = A3_2.ptfxOffset
  if not L4_2 then
    L4_2 = vec3
    L5_2 = 0.0
    L6_2 = 0.0
    L7_2 = 0.0
    L4_2 = L4_2(L5_2, L6_2, L7_2)
  end
  L5_2 = A3_2.animationOffset
  if not L5_2 then
    L5_2 = vec4
    L6_2 = 0.0
    L7_2 = 0.0
    L8_2 = 0.0
    L9_2 = 0.0
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  end
  L6_2 = vec3
  L7_2 = A1_2.x
  L8_2 = A1_2.y
  L9_2 = A1_2.z
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L7_2 = A2_2 or L7_2
  if not A2_2 then
    L7_2 = 0.0
  end
  L8_2 = GetCoordsWithOffset
  L9_2 = vec4
  L10_2 = L6_2.x
  L11_2 = L6_2.y
  L12_2 = L6_2.z
  L13_2 = L7_2
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
  L10_2 = L4_2
  L8_2 = L8_2(L9_2, L10_2)
  L9_2 = GetCoordsWithOffset
  L10_2 = vec4
  L11_2 = L6_2.x
  L12_2 = L6_2.y
  L13_2 = L6_2.z
  L14_2 = L7_2
  L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
  L11_2 = vec3
  L12_2 = L5_2.x
  L13_2 = L5_2.y
  L14_2 = L5_2.z
  L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2 = L11_2(L12_2, L13_2, L14_2)
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2)
  L10_2 = RequestNamedPtfxAsset
  L11_2 = "scr_mp_house"
  L10_2(L11_2)
  while true do
    L10_2 = HasNamedPtfxAssetLoaded
    L11_2 = "scr_mp_house"
    L10_2 = L10_2(L11_2)
    if L10_2 then
      break
    end
    L10_2 = Wait
    L11_2 = 0
    L10_2(L11_2)
  end
  L10_2 = UseParticleFxAssetNextCall
  L11_2 = "scr_mp_house"
  L10_2(L11_2)
  L10_2 = GetEntityModel
  L11_2 = cache
  L11_2 = L11_2.ped
  L10_2 = L10_2(L11_2)
  L11_2 = joaat
  L12_2 = "mp_f_freemode_01"
  L11_2 = L11_2(L12_2)
  L12_2 = L10_2 == L11_2
  L14_2 = A0_2
  L13_2 = A0_2.GetShowerAnimDict
  L15_2 = L12_2
  L13_2 = L13_2(L14_2, L15_2)
  L15_2 = A0_2
  L14_2 = A0_2.GetShowerIdleAnim
  L16_2 = L12_2
  L17_2 = 1
  L14_2 = L14_2(L15_2, L16_2, L17_2)
  L15_2 = lib
  L15_2 = L15_2.requestAnimDict
  L16_2 = L13_2
  L15_2(L16_2)
  while true do
    L15_2 = HasAnimDictLoaded
    L16_2 = L13_2
    L15_2 = L15_2(L16_2)
    if L15_2 then
      break
    end
    L15_2 = Wait
    L16_2 = 0
    L15_2(L16_2)
  end
  L15_2 = SetEntityCoords
  L16_2 = cache
  L16_2 = L16_2.ped
  L17_2 = L9_2.x
  L18_2 = L9_2.y
  L19_2 = L9_2.z
  L20_2 = false
  L21_2 = false
  L22_2 = false
  L23_2 = false
  L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
  L15_2 = L5_2.w
  if not L15_2 then
    L15_2 = 0.0
  end
  L15_2 = L7_2 + L15_2
  L15_2 = L15_2 % 360.0
  L16_2 = SetEntityHeading
  L17_2 = cache
  L17_2 = L17_2.ped
  L18_2 = L15_2
  L16_2(L17_2, L18_2)
  L16_2 = lib
  L16_2 = L16_2.playAnim
  L17_2 = cache
  L17_2 = L17_2.ped
  L18_2 = L13_2
  L19_2 = L14_2
  L20_2 = 8.0
  L21_2 = -8.0
  L22_2 = -1
  L23_2 = 1
  L24_2 = 0
  L25_2 = false
  L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
  L16_2 = StartParticleFxLoopedAtCoord
  L17_2 = "ent_amb_shower"
  L18_2 = L8_2.x
  L19_2 = L8_2.y
  L20_2 = L8_2.z
  L21_2 = -45.0
  L22_2 = 0.0
  L23_2 = 0.0
  L24_2 = 1.0
  L25_2 = false
  L26_2 = false
  L27_2 = false
  L28_2 = false
  L16_2 = L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2)
  L17_2 = Utils
  L17_2 = L17_2.stripPlayer
  L17_2()
  L17_2 = A0_2.shower
  L17_2.isInShower = true
  L1_1.ptfxHandle = L16_2
  L1_1.animDict = L13_2
  L1_1.animName = L14_2
  L17_2 = CreateThread
  function L18_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    while true do
      L0_3 = A0_2.shower
      L0_3 = L0_3.isInShower
      if not L0_3 then
        break
      end
      L0_3 = Wait
      L1_3 = 100
      L0_3(L1_3)
      L0_3 = IsEntityPlayingAnim
      L1_3 = cache
      L1_3 = L1_3.ped
      L2_3 = L13_2
      L3_3 = L14_2
      L4_3 = 3
      L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3)
      if not L0_3 then
        L0_3 = lib
        L0_3 = L0_3.playAnim
        L1_3 = cache
        L1_3 = L1_3.ped
        L2_3 = L13_2
        L3_3 = L14_2
        L4_3 = 8.0
        L5_3 = -8.0
        L6_3 = -1
        L7_3 = 1
        L8_3 = 0
        L9_3 = false
        L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
      end
    end
    L0_3 = Utils
    L0_3 = L0_3.restorePlayerClothes
    L0_3()
    L0_3 = ClearPedTasksImmediately
    L1_3 = cache
    L1_3 = L1_3.ped
    L0_3(L1_3)
  end
  L17_2(L18_2)
end
L2_1.useShower = L3_1
L2_1 = common
function L3_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  if not A2_2 then
    return
  end
  L4_2 = A2_2.ptfxOffset
  if not L4_2 then
    L4_2 = vec3
    L5_2 = 0.0
    L6_2 = 0.0
    L7_2 = 0.0
    L4_2 = L4_2(L5_2, L6_2, L7_2)
  end
  L5_2 = nil
  L6_2 = type
  L7_2 = A1_2
  L6_2 = L6_2(L7_2)
  if "number" == L6_2 then
    L6_2 = DoesEntityExist
    L7_2 = A1_2
    L6_2 = L6_2(L7_2)
    if L6_2 then
      L6_2 = GetOffsetFromEntityInWorldCoords
      L7_2 = A1_2
      L8_2 = L4_2.x
      L9_2 = L4_2.y
      L10_2 = L4_2.z
      L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
      L5_2 = L6_2
  end
  else
    L6_2 = A1_2
    L7_2 = A3_2 or L7_2
    if not A3_2 then
      L7_2 = 0.0
    end
    L8_2 = vec3
    L9_2 = L6_2.x
    L10_2 = L6_2.y
    L11_2 = L6_2.z
    L8_2 = L8_2(L9_2, L10_2, L11_2)
    L9_2 = GetCoordsWithOffset
    L10_2 = vec4
    L11_2 = L8_2.x
    L12_2 = L8_2.y
    L13_2 = L8_2.z
    L14_2 = L7_2
    L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
    L11_2 = L4_2
    L9_2 = L9_2(L10_2, L11_2)
    L5_2 = L9_2
  end
  L6_2 = RequestNamedPtfxAsset
  L7_2 = "scr_mp_house"
  L6_2(L7_2)
  while true do
    L6_2 = HasNamedPtfxAssetLoaded
    L7_2 = "scr_mp_house"
    L6_2 = L6_2(L7_2)
    if L6_2 then
      break
    end
    L6_2 = Wait
    L7_2 = 0
    L6_2(L7_2)
  end
  L6_2 = UseParticleFxAssetNextCall
  L7_2 = "scr_mp_house"
  L6_2(L7_2)
  L6_2 = A2_2.animationOffset
  if not L6_2 then
    L6_2 = vec4
    L7_2 = 0.0
    L8_2 = 0.0
    L9_2 = 0.0
    L10_2 = 0.0
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  end
  L7_2 = nil
  L8_2 = type
  L9_2 = A1_2
  L8_2 = L8_2(L9_2)
  if "number" == L8_2 then
    L8_2 = DoesEntityExist
    L9_2 = A1_2
    L8_2 = L8_2(L9_2)
    if L8_2 then
      L8_2 = GetEntityCoords
      L9_2 = cache
      L9_2 = L9_2.ped
      L8_2 = L8_2(L9_2)
      L7_2 = L8_2
  end
  else
    L8_2 = A1_2
    L9_2 = A3_2 or L9_2
    if not A3_2 then
      L9_2 = 0.0
    end
    L10_2 = vec3
    L11_2 = L8_2.x
    L12_2 = L8_2.y
    L13_2 = L8_2.z
    L10_2 = L10_2(L11_2, L12_2, L13_2)
    L11_2 = GetCoordsWithOffset
    L12_2 = vec4
    L13_2 = L10_2.x
    L14_2 = L10_2.y
    L15_2 = L10_2.z
    L16_2 = L9_2
    L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2)
    L13_2 = vec3
    L14_2 = L6_2.x
    L15_2 = L6_2.y
    L16_2 = L6_2.z
    L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L13_2(L14_2, L15_2, L16_2)
    L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    L7_2 = L11_2
    L11_2 = SetEntityCoords
    L12_2 = cache
    L12_2 = L12_2.ped
    L13_2 = L7_2.x
    L14_2 = L7_2.y
    L15_2 = L7_2.z
    L15_2 = L15_2 - 0.7
    L16_2 = false
    L17_2 = false
    L18_2 = false
    L19_2 = false
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    L11_2 = L6_2.w
    if not L11_2 then
      L11_2 = 0.0
    end
    L11_2 = L9_2 + L11_2
    L11_2 = L11_2 % 360.0
    L12_2 = SetEntityHeading
    L13_2 = cache
    L13_2 = L13_2.ped
    L14_2 = L11_2
    L12_2(L13_2, L14_2)
  end
  L8_2 = lib
  L8_2 = L8_2.playAnim
  L9_2 = cache
  L9_2 = L9_2.ped
  L10_2 = "missheist_agency3aig_23"
  L11_2 = "urinal_sink_loop"
  L12_2 = 8.0
  L13_2 = -8.0
  L14_2 = -1
  L15_2 = 1
  L16_2 = 0
  L17_2 = false
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L8_2 = StartParticleFxLoopedAtCoord
  L9_2 = "ent_amb_shower"
  L10_2 = L5_2.x
  L11_2 = L5_2.y
  L12_2 = L5_2.z
  L13_2 = -45.0
  L14_2 = 0.0
  L15_2 = 0.0
  L16_2 = 0.2
  L17_2 = false
  L18_2 = false
  L19_2 = false
  L20_2 = false
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  L9_2 = Wait
  L10_2 = 5000
  L9_2(L10_2)
  L9_2 = StopParticleFxLooped
  L10_2 = L8_2
  L11_2 = false
  L9_2(L10_2, L11_2)
  L9_2 = ClearPedTasks
  L10_2 = cache
  L10_2 = L10_2.ped
  L9_2(L10_2)
end
L2_1.useSink = L3_1
L2_1 = common
function L3_1(A0_2, A1_2)
  local L2_2
  if A1_2 then
    L2_2 = "timetable@ron@ig_3_couch"
    if L2_2 then
      goto lbl_7
    end
  end
  L2_2 = "misscarsteal2peeing"
  ::lbl_7::
  return L2_2
end
L2_1.GetToiletAnimDict = L3_1
L2_1 = common
function L3_1(A0_2, A1_2)
  local L2_2
  if A1_2 then
    L2_2 = "base"
    if L2_2 then
      goto lbl_7
    end
  end
  L2_2 = "peeing_loop"
  ::lbl_7::
  return L2_2
end
L2_1.GetToiletAnimName = L3_1
L2_1 = vec4
L3_1 = -0.3
L4_1 = 0.0
L5_1 = 0.0
L6_1 = 0.0
L2_1 = L2_1(L3_1, L4_1, L5_1, L6_1)
L3_1 = common
function L4_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  if not A2_2 then
    return
  end
  L4_2 = GetEntityModel
  L5_2 = cache
  L5_2 = L5_2.ped
  L4_2 = L4_2(L5_2)
  L5_2 = joaat
  L6_2 = "mp_f_freemode_01"
  L5_2 = L5_2(L6_2)
  L6_2 = L4_2 == L5_2
  L7_2 = A2_2.animationOffset
  if not L7_2 then
    L7_2 = vec4
    L8_2 = 0.0
    L9_2 = 0.0
    L10_2 = 0.0
    L11_2 = 0.0
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
  end
  L8_2 = nil
  L9_2 = nil
  L10_2 = nil
  L11_2 = type
  L12_2 = A1_2
  L11_2 = L11_2(L12_2)
  if "number" == L11_2 then
    L11_2 = DoesEntityExist
    L12_2 = A1_2
    L11_2 = L11_2(L12_2)
    if L11_2 then
      L11_2 = A1_2
      L12_2 = GetEntityCoords
      L13_2 = L11_2
      L12_2 = L12_2(L13_2)
      L13_2 = GetEntityHeading
      L14_2 = L11_2
      L13_2 = L13_2(L14_2)
      L14_2 = vec4
      L15_2 = L12_2.x
      L16_2 = L12_2.y
      L17_2 = L12_2.z
      L18_2 = L13_2
      L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2)
      L8_2 = L14_2
      L14_2 = vec4
      L15_2 = 0.3
      L16_2 = 0.0
      L17_2 = 0.0
      L18_2 = 0.0
      L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2)
      L2_1 = L14_2
  end
  else
    L11_2 = A1_2
    L12_2 = A3_2 or L12_2
    if not A3_2 then
      L12_2 = 0.0
    end
    L13_2 = vec4
    L14_2 = L11_2.x
    L15_2 = L11_2.y
    L16_2 = L11_2.z
    L17_2 = L12_2
    L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2)
    L8_2 = L13_2
    L13_2 = vec4
    L14_2 = -0.3
    L15_2 = 0.0
    L16_2 = 0.0
    L17_2 = 0.0
    L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2)
    L2_1 = L13_2
  end
  L11_2 = L8_2.w
  L12_2 = L7_2.w
  if not L12_2 then
    L12_2 = 0.0
  end
  L10_2 = L11_2 + L12_2
  if L6_2 then
    L11_2 = L10_2 - 180.0
    L10_2 = L11_2 % 360.0
  end
  if L6_2 then
    L11_2 = vec4
    L12_2 = L7_2.x
    L13_2 = L2_1.x
    L12_2 = L12_2 + L13_2
    L13_2 = L7_2.y
    L14_2 = L2_1.y
    L13_2 = L13_2 + L14_2
    L14_2 = L7_2.z
    L15_2 = L2_1.z
    L14_2 = L14_2 + L15_2
    L15_2 = L7_2.w
    L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2)
    L7_2 = L11_2
  end
  L11_2 = GetCoordsWithOffset
  L12_2 = L8_2
  L13_2 = vec3
  L14_2 = L7_2.x
  L15_2 = L7_2.y
  L16_2 = L7_2.z
  L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L13_2(L14_2, L15_2, L16_2)
  L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
  L9_2 = L11_2
  L11_2 = SetEntityCoords
  L12_2 = cache
  L12_2 = L12_2.ped
  L13_2 = L9_2.x
  L14_2 = L9_2.y
  L15_2 = L9_2.z
  L15_2 = L15_2 - 0.7
  L16_2 = false
  L17_2 = false
  L18_2 = false
  L19_2 = false
  L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  L11_2 = SetEntityHeading
  L12_2 = cache
  L12_2 = L12_2.ped
  L13_2 = L10_2
  L11_2(L12_2, L13_2)
  L12_2 = A0_2
  L11_2 = A0_2.GetToiletAnimDict
  L13_2 = L6_2
  L11_2 = L11_2(L12_2, L13_2)
  L13_2 = A0_2
  L12_2 = A0_2.GetToiletAnimName
  L14_2 = L6_2
  L12_2 = L12_2(L13_2, L14_2)
  L13_2 = lib
  L13_2 = L13_2.requestAnimDict
  L14_2 = L11_2
  L13_2(L14_2)
  while true do
    L13_2 = HasAnimDictLoaded
    L14_2 = L11_2
    L13_2 = L13_2(L14_2)
    if L13_2 then
      break
    end
    L13_2 = Wait
    L14_2 = 0
    L13_2(L14_2)
  end
  L13_2 = lib
  L13_2 = L13_2.playAnim
  L14_2 = cache
  L14_2 = L14_2.ped
  L15_2 = L11_2
  L16_2 = L12_2
  L17_2 = 8.0
  L18_2 = -8.0
  L19_2 = -1
  L20_2 = 1
  L21_2 = 0
  L22_2 = false
  L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L13_2 = nil
  if not L6_2 then
    L14_2 = RequestNamedPtfxAsset
    L15_2 = "scr_amb_chop"
    L14_2(L15_2)
    while true do
      L14_2 = HasNamedPtfxAssetLoaded
      L15_2 = "scr_amb_chop"
      L14_2 = L14_2(L15_2)
      if L14_2 then
        break
      end
      L14_2 = Wait
      L15_2 = 0
      L14_2(L15_2)
    end
    L14_2 = UseParticleFxAssetNextCall
    L15_2 = "scr_amb_chop"
    L14_2(L15_2)
    L14_2 = StartParticleFxLoopedOnEntity
    L15_2 = "ent_anim_dog_peeing"
    L16_2 = cache
    L16_2 = L16_2.ped
    L17_2 = -0.05
    L18_2 = 0.3
    L19_2 = 0.0
    L20_2 = 0.0
    L21_2 = 90.0
    L22_2 = 90.0
    L23_2 = 1.0
    L24_2 = false
    L25_2 = false
    L26_2 = false
    L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
    L13_2 = L14_2
  end
  L14_2 = Wait
  L15_2 = 5000
  L14_2(L15_2)
  if L13_2 then
    L14_2 = StopParticleFxLooped
    L15_2 = L13_2
    L16_2 = false
    L14_2(L15_2, L16_2)
  end
  L14_2 = ClearPedTasks
  L15_2 = cache
  L15_2 = L15_2.ped
  L14_2(L15_2)
end
L3_1.useToilet = L4_1
L3_1 = common
function L4_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  if A1_2 then
    L3_2 = DoesEntityExist
    L4_2 = A1_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      goto lbl_9
    end
  end
  do return end
  ::lbl_9::
  if not A2_2 then
    return
  end
  L3_2 = A0_2.bathtub
  L3_2 = L3_2.isInBathtub
  if L3_2 then
    L3_2 = L0_1.waterFallPtfx
    if L3_2 then
      L3_2 = StopParticleFxLooped
      L4_2 = L0_1.waterFallPtfx
      L5_2 = false
      L3_2(L4_2, L5_2)
      L0_1.waterFallPtfx = nil
    end
    L3_2 = L0_1.waterObject
    if L3_2 then
      L3_2 = DoesEntityExist
      L4_2 = L0_1.waterObject
      L3_2 = L3_2(L4_2)
      if L3_2 then
        L3_2 = DeleteObject
        L4_2 = L0_1.waterObject
        L3_2(L4_2)
        L0_1.waterObject = nil
      end
    end
    L0_1.fillThreadActive = false
    L3_2 = ClearPedTasks
    L4_2 = cache
    L4_2 = L4_2.ped
    L3_2(L4_2)
    L3_2 = A0_2.bathtub
    L3_2.isInBathtub = false
    L0_1.objectHandle = nil
    return
  end
  L3_2 = A2_2.animationOffset
  L4_2 = A2_2.waterFallOffset
  L5_2 = A2_2.fillOffset
  L6_2 = GetEntityCoords
  L7_2 = A1_2
  L6_2 = L6_2(L7_2)
  L7_2 = GetEntityHeading
  L8_2 = A1_2
  L7_2 = L7_2(L8_2)
  L8_2 = GetOffsetFromEntityInWorldCoords
  L9_2 = A1_2
  L10_2 = L3_2.x
  L11_2 = L3_2.y
  L12_2 = L3_2.z
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
  L9_2 = RequestNamedPtfxAsset
  L10_2 = "scr_mp_house"
  L9_2(L10_2)
  while true do
    L9_2 = HasNamedPtfxAssetLoaded
    L10_2 = "scr_mp_house"
    L9_2 = L9_2(L10_2)
    if L9_2 then
      break
    end
    L9_2 = Wait
    L10_2 = 0
    L9_2(L10_2)
  end
  L9_2 = UseParticleFxAssetNextCall
  L10_2 = "scr_mp_house"
  L9_2(L10_2)
  L9_2 = SetEntityCoords
  L10_2 = cache
  L10_2 = L10_2.ped
  L11_2 = L8_2.x
  L12_2 = L8_2.y
  L13_2 = L8_2.z
  L14_2 = false
  L15_2 = false
  L16_2 = false
  L17_2 = false
  L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L9_2 = SetEntityHeading
  L10_2 = cache
  L10_2 = L10_2.ped
  L11_2 = L3_2.w
  L11_2 = L7_2 + L11_2
  L9_2(L10_2, L11_2)
  L9_2 = lib
  L9_2 = L9_2.playAnim
  L10_2 = cache
  L10_2 = L10_2.ped
  L11_2 = "timetable@jimmy@mics3_ig_15@"
  L12_2 = "mics3_15_base_jimmy"
  L13_2 = 8.0
  L14_2 = -8.0
  L15_2 = -1
  L16_2 = 1
  L17_2 = 0
  L18_2 = false
  L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L9_2 = GetOffsetFromEntityInWorldCoords
  L10_2 = A1_2
  L11_2 = L4_2.x
  L12_2 = L4_2.y
  L13_2 = L4_2.z
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
  L10_2 = StartParticleFxLoopedAtCoord
  L11_2 = "ent_amb_shower"
  L12_2 = L9_2.x
  L13_2 = L9_2.y
  L14_2 = L9_2.z
  L15_2 = -45.0
  L16_2 = 0.0
  L17_2 = 0.0
  L18_2 = 0.3
  L19_2 = false
  L20_2 = false
  L21_2 = false
  L22_2 = false
  L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L11_2 = GetOffsetFromEntityInWorldCoords
  L12_2 = A1_2
  L13_2 = L5_2.x
  L14_2 = L5_2.y
  L15_2 = L5_2.z
  L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2)
  L12_2 = joaat
  L13_2 = "custom_water_01"
  L12_2 = L12_2(L13_2)
  L13_2 = lib
  L13_2 = L13_2.requestModel
  L14_2 = L12_2
  L15_2 = Config
  L15_2 = L15_2.DefaultRequestModelTimeout
  L13_2(L14_2, L15_2)
  L13_2 = L11_2.z
  L14_2 = 0.3
  L15_2 = L13_2 + L14_2
  L16_2 = CreateObject
  L17_2 = L12_2
  L18_2 = L11_2.x
  L19_2 = L11_2.y
  L20_2 = L13_2
  L21_2 = false
  L22_2 = false
  L23_2 = false
  L16_2 = L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
  L17_2 = SetEntityCompletelyDisableCollision
  L18_2 = L16_2
  L19_2 = true
  L20_2 = false
  L17_2(L18_2, L19_2, L20_2)
  L17_2 = FreezeEntityPosition
  L18_2 = L16_2
  L19_2 = false
  L17_2(L18_2, L19_2)
  L17_2 = SetEntityInvincible
  L18_2 = L16_2
  L19_2 = true
  L17_2(L18_2, L19_2)
  L17_2 = SetEntityAsMissionEntity
  L18_2 = L16_2
  L19_2 = true
  L20_2 = true
  L17_2(L18_2, L19_2, L20_2)
  L17_2 = SetEntityHeading
  L18_2 = L16_2
  L19_2 = L7_2
  L17_2(L18_2, L19_2)
  L0_1.waterObject = L16_2
  L0_1.fillThreadActive = true
  L17_2 = CreateThread
  function L18_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3
    L0_3 = 15000
    L1_3 = GetGameTimer
    L1_3 = L1_3()
    while true do
      L2_3 = L0_1.fillThreadActive
      if not L2_3 then
        break
      end
      L2_3 = A0_2.bathtub
      L2_3 = L2_3.isInBathtub
      if not L2_3 then
        break
      end
      L2_3 = DoesEntityExist
      L3_3 = A1_2
      L2_3 = L2_3(L3_3)
      if not L2_3 then
        break
      end
      L2_3 = DoesEntityExist
      L3_3 = L16_2
      L2_3 = L2_3(L3_3)
      if not L2_3 then
        break
      end
      L2_3 = GetGameTimer
      L2_3 = L2_3()
      L2_3 = L2_3 - L1_3
      L3_3 = math
      L3_3 = L3_3.min
      L4_3 = L2_3 / L0_3
      L5_3 = 1.0
      L3_3 = L3_3(L4_3, L5_3)
      L4_3 = nil
      L5_3 = 0.5
      if L3_3 < L5_3 then
        L5_3 = 2.0 * L3_3
        L4_3 = L5_3 * L3_3
      else
        L5_3 = 1.0
        L5_3 = L5_3 - L3_3
        L5_3 = 2.0 * L5_3
        L6_3 = 1.0
        L6_3 = L6_3 - L3_3
        L5_3 = L5_3 * L6_3
        L6_3 = 1.0
        L4_3 = L6_3 - L5_3
      end
      L5_3 = L13_2
      L6_3 = L14_2
      L6_3 = L4_3 * L6_3
      L5_3 = L5_3 + L6_3
      L6_3 = GetEntityCoords
      L7_3 = L16_2
      L6_3 = L6_3(L7_3)
      L7_3 = SetEntityCoords
      L8_3 = L16_2
      L9_3 = L6_3.x
      L10_3 = L6_3.y
      L11_3 = L5_3
      L12_3 = false
      L13_3 = false
      L14_3 = false
      L15_3 = false
      L7_3(L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3)
      L7_3 = Wait
      L8_3 = 16
      L7_3(L8_3)
    end
  end
  L17_2(L18_2)
  L17_2 = A0_2.bathtub
  L17_2.isInBathtub = true
  L0_1.waterFallPtfx = L10_2
  L0_1.objectHandle = A1_2
end
L3_1.useBathtub = L4_1
L3_1 = common
L4_1 = {}
L4_1.isCooking = false
L3_1.cooking = L4_1
L3_1 = common
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = A0_2.cooking
  L2_2 = L2_2.isCooking
  if L2_2 then
    return
  end
  if not A1_2 then
    L2_2 = Config
    A1_2 = L2_2.CookingRecipes
  end
  L2_2 = SendReactMessage
  L3_2 = "toggle_cooking"
  L4_2 = {}
  L4_2.visible = true
  L4_2.recipes = A1_2
  L2_2(L3_2, L4_2)
  L2_2 = SetNuiFocus
  L3_2 = true
  L4_2 = true
  L2_2(L3_2, L4_2)
end
L3_1.openCooking = L4_1
L3_1 = {}
L4_1 = -598185919
L5_1 = -1412276716
L6_1 = -1254540419
L7_1 = 692857360
L8_1 = 1027109416
L9_1 = -1555713785
L10_1 = -1630172026
L11_1 = -960996301
L12_1 = -708789241
L13_1 = 2017086435
L14_1 = 974883178
L15_1 = -245386275
L16_1 = -533655168
L17_1 = -1109340972
L18_1 = -801803927
L19_1 = 591916419
L20_1 = -1425058769
L21_1 = -461945070
L22_1 = -693032058
L23_1 = 2010247122
L24_1 = 1151364435
L25_1 = -1934174148
L26_1 = 176137803
L27_1 = -2013814998
L28_1 = -1910604593
L29_1 = 1338703913
L30_1 = -334989242
L31_1 = -839348691
L32_1 = 679927467
L33_1 = -66965919
L34_1 = -110986183
L35_1 = -1199910959
L36_1 = -113902346
L37_1 = -127739306
L38_1 = 1360563376
L39_1 = 2052737670
L40_1 = -1010290664
L41_1 = -580196246
L42_1 = -969349845
L3_1[1] = L4_1
L3_1[2] = L5_1
L3_1[3] = L6_1
L3_1[4] = L7_1
L3_1[5] = L8_1
L3_1[6] = L9_1
L3_1[7] = L10_1
L3_1[8] = L11_1
L3_1[9] = L12_1
L3_1[10] = L13_1
L3_1[11] = L14_1
L3_1[12] = L15_1
L3_1[13] = L16_1
L3_1[14] = L17_1
L3_1[15] = L18_1
L3_1[16] = L19_1
L3_1[17] = L20_1
L3_1[18] = L21_1
L3_1[19] = L22_1
L3_1[20] = L23_1
L3_1[21] = L24_1
L3_1[22] = L25_1
L3_1[23] = L26_1
L3_1[24] = L27_1
L3_1[25] = L28_1
L3_1[26] = L29_1
L3_1[27] = L30_1
L3_1[28] = L31_1
L3_1[29] = L32_1
L3_1[30] = L33_1
L3_1[31] = L34_1
L3_1[32] = L35_1
L3_1[33] = L36_1
L3_1[34] = L37_1
L3_1[35] = L38_1
L3_1[36] = L39_1
L3_1[37] = L40_1
L3_1[38] = L41_1
L3_1[39] = L42_1
L4_1 = common
function L5_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L2_2 = GetEntityCoords
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  L3_2 = 1
  L4_2 = L3_1
  L4_2 = #L4_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = GetClosestObjectOfType
    L8_2 = L2_2.x
    L9_2 = L2_2.y
    L10_2 = L2_2.z
    L11_2 = 1.0
    L12_2 = L3_1
    L12_2 = L12_2[L6_2]
    L13_2 = false
    L14_2 = true
    L15_2 = true
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    L8_2 = DoesEntityExist
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    if L8_2 then
      L8_2 = SetEntityAsMissionEntity
      L9_2 = L7_2
      L10_2 = false
      L11_2 = false
      L8_2(L9_2, L10_2, L11_2)
      L8_2 = DeleteObject
      L9_2 = L7_2
      L8_2(L9_2)
    end
  end
end
L4_1.cleanScenarioObjects = L5_1
L4_1 = common
function L5_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  if not A1_2 then
    return
  end
  L2_2 = A0_2.cooking
  L2_2.isCooking = true
  L2_2 = GetEntityCoords
  L3_2 = cache
  L3_2 = L3_2.ped
  L2_2 = L2_2(L3_2)
  L3_2 = GetEntityHeading
  L4_2 = cache
  L4_2 = L4_2.ped
  L3_2 = L3_2(L4_2)
  L4_2 = TaskStartScenarioAtPosition
  L5_2 = cache
  L5_2 = L5_2.ped
  L6_2 = "PROP_HUMAN_BBQ"
  L7_2 = L2_2.x
  L8_2 = L2_2.y
  L9_2 = L2_2.z
  L10_2 = L3_2
  L11_2 = -1
  L12_2 = false
  L13_2 = true
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L4_2 = lib
  L4_2 = L4_2.progressCircle
  L5_2 = {}
  L6_2 = A1_2.time
  L5_2.duration = L6_2
  L6_2 = i18n
  L6_2 = L6_2.t
  L7_2 = "cooking.cooking"
  L8_2 = {}
  L9_2 = A1_2.title
  L8_2.item = L9_2
  L6_2 = L6_2(L7_2, L8_2)
  if not L6_2 then
    L6_2 = string
    L6_2 = L6_2.format
    L7_2 = "Cooking %s..."
    L8_2 = A1_2.title
    L6_2 = L6_2(L7_2, L8_2)
  end
  L5_2.label = L6_2
  L5_2.position = "bottom"
  L5_2.useWhileDead = false
  L5_2.canCancel = true
  L6_2 = {}
  L6_2.car = true
  L6_2.move = true
  L6_2.combat = true
  L5_2.disable = L6_2
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L4_2 = ClearPedTasks
    L5_2 = cache
    L5_2 = L5_2.ped
    L4_2(L5_2)
    L4_2 = TriggerServerEvent
    L5_2 = "housing:finishCooking"
    L6_2 = A1_2.title
    L4_2(L5_2, L6_2)
  else
    L4_2 = ClearPedTasks
    L5_2 = cache
    L5_2 = L5_2.ped
    L4_2(L5_2)
    L4_2 = Notification
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "cooking.cancelled"
    L5_2 = L5_2(L6_2)
    if not L5_2 then
      L5_2 = "Cooking cancelled"
    end
    L6_2 = "error"
    L4_2(L5_2, L6_2)
  end
  L5_2 = A0_2
  L4_2 = A0_2.cleanScenarioObjects
  L6_2 = cache
  L6_2 = L6_2.ped
  L4_2(L5_2, L6_2)
  L4_2 = A0_2.cooking
  L4_2.isCooking = false
end
L4_1.startCooking = L5_1
L4_1 = RegisterNUICallback
L5_1 = "cooking:cook"
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = A0_2.recipe
  if not L2_2 then
    L3_2 = A1_2
    L4_2 = false
    L3_2(L4_2)
    return
  end
  L3_2 = SendReactMessage
  L4_2 = "toggle_cooking"
  L5_2 = {}
  L5_2.visible = false
  L6_2 = {}
  L5_2.recipes = L6_2
  L3_2(L4_2, L5_2)
  L3_2 = SetNuiFocus
  L4_2 = false
  L5_2 = false
  L3_2(L4_2, L5_2)
  L3_2 = lib
  L3_2 = L3_2.callback
  L3_2 = L3_2.await
  L4_2 = "housing:cook"
  L5_2 = false
  L6_2 = L2_2
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  if L3_2 then
    L4_2 = A1_2
    L5_2 = "ok"
    L4_2(L5_2)
  else
    L4_2 = A1_2
    L5_2 = false
    L4_2(L5_2)
  end
end
L4_1(L5_1, L6_1)
L4_1 = RegisterNUICallback
L5_1 = "cooking:close"
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = SendReactMessage
  L3_2 = "toggle_cooking"
  L4_2 = {}
  L4_2.visible = false
  L5_2 = {}
  L4_2.recipes = L5_2
  L2_2(L3_2, L4_2)
  L2_2 = SetNuiFocus
  L3_2 = false
  L4_2 = false
  L2_2(L3_2, L4_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L4_1(L5_1, L6_1)
L4_1 = common
L5_1 = {}
L4_1.dancers = L5_1
L4_1 = {}
function L5_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = pairs
  L1_2 = L4_1
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = L5_2.ped
    if L6_2 then
      L6_2 = DoesEntityExist
      L7_2 = L5_2.ped
      L6_2 = L6_2(L7_2)
      if L6_2 then
        L6_2 = DeleteEntity
        L7_2 = L5_2.ped
        L6_2(L7_2)
      end
    end
  end
  L0_2 = {}
  L4_1 = L0_2
end
function L6_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = Config
  L3_2 = L3_2.PedStreaming
  if not L3_2 then
    L3_2 = {}
  end
  L4_2 = L3_2.default
  if not L4_2 then
    L4_2 = {}
  end
  L5_2 = L3_2[A0_2]
  if not L5_2 then
    L5_2 = {}
  end
  L6_2 = L5_2.spawnDistance
  if not L6_2 then
    L6_2 = L4_2.spawnDistance
    if not L6_2 then
      L6_2 = A1_2
    end
  end
  L7_2 = L5_2.despawnDistance
  if not L7_2 then
    L7_2 = L4_2.despawnDistance
    if not L7_2 then
      L7_2 = A2_2
    end
  end
  if L6_2 >= L7_2 then
    L7_2 = L6_2 + 5.0
  end
  L8_2 = L6_2
  L9_2 = L7_2
  return L8_2, L9_2
end
function L7_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = vec3
  L2_2 = A0_2.coords
  L2_2 = L2_2.x
  L3_2 = A0_2.coords
  L3_2 = L3_2.y
  L4_2 = A0_2.coords
  L4_2 = L4_2.z
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  L2_2 = GetEntityCoords
  L3_2 = cache
  L3_2 = L3_2.ped
  L2_2 = L2_2(L3_2)
  L3_2 = L2_2 - L1_2
  L3_2 = #L3_2
  return L3_2
end
function L8_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L1_2 = A0_2.pedModel
  L2_2 = A0_2.coords
  L3_2 = A0_2.anim
  if L3_2 then
    L3_2 = A0_2.anim
    L3_2 = L3_2.dict
  end
  L4_2 = A0_2.anim
  if L4_2 then
    L4_2 = A0_2.anim
    L4_2 = L4_2.name
  end
  if not L1_2 or not L2_2 then
    L5_2 = nil
    L6_2 = L3_2
    L7_2 = L4_2
    return L5_2, L6_2, L7_2
  end
  L5_2 = lib
  L5_2 = L5_2.requestModel
  L6_2 = L1_2
  L7_2 = Config
  L7_2 = L7_2.DefaultRequestModelTimeout
  L5_2(L6_2, L7_2)
  L5_2 = 0.0
  L6_2 = type
  L7_2 = L2_2
  L6_2 = L6_2(L7_2)
  if "table" == L6_2 then
    L6_2 = L2_2.w
    L5_2 = L6_2 or L5_2
    if not L6_2 then
      L6_2 = L2_2.heading
      L5_2 = L6_2 or L5_2
      if not L6_2 then
        L5_2 = 0.0
      end
    end
  end
  L6_2 = CreatePed
  L7_2 = 28
  L8_2 = L1_2
  L9_2 = L2_2.x
  L10_2 = L2_2.y
  L11_2 = L2_2.z
  L11_2 = L11_2 - 1.0
  L12_2 = L5_2
  L13_2 = true
  L14_2 = false
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L7_2 = SetEntityInvincible
  L8_2 = L6_2
  L9_2 = true
  L7_2(L8_2, L9_2)
  L7_2 = SetBlockingOfNonTemporaryEvents
  L8_2 = L6_2
  L9_2 = true
  L7_2(L8_2, L9_2)
  L7_2 = FreezeEntityPosition
  L8_2 = L6_2
  L9_2 = true
  L7_2(L8_2, L9_2)
  L7_2 = SetEntityCollision
  L8_2 = L6_2
  L9_2 = false
  L10_2 = false
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = SetPedDefaultComponentVariation
  L8_2 = L6_2
  L7_2(L8_2)
  L7_2 = SetPedRandomProps
  L8_2 = L6_2
  L7_2(L8_2)
  if L3_2 and L4_2 then
    L7_2 = lib
    L7_2 = L7_2.requestAnimDict
    L8_2 = L3_2
    L7_2(L8_2)
    L7_2 = TaskPlayAnim
    L8_2 = L6_2
    L9_2 = L3_2
    L10_2 = L4_2
    L11_2 = 8.0
    L12_2 = -8.0
    L13_2 = -1
    L14_2 = 1
    L15_2 = 0
    L16_2 = false
    L17_2 = false
    L18_2 = false
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  end
  L7_2 = SetModelAsNoLongerNeeded
  L8_2 = L1_2
  L7_2(L8_2)
  L7_2 = L6_2
  L8_2 = L3_2
  L9_2 = L4_2
  return L7_2, L8_2, L9_2
end
function L9_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = {}
  L1_2 = ipairs
  L2_2 = Config
  L2_2 = L2_2.Dancers
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = table
    L7_2 = L7_2.insert
    L8_2 = L0_2
    L9_2 = {}
    L10_2 = L6_2.title
    L9_2.title = L10_2
    L10_2 = L6_2.description
    L9_2.description = L10_2
    L10_2 = L6_2.price
    L9_2.price = L10_2
    L10_2 = L6_2.pedModel
    L9_2.pedModel = L10_2
    L10_2 = L6_2.anim
    L9_2.anim = L10_2
    L10_2 = L6_2.image
    L9_2.image = L10_2
    L10_2 = L6_2.time
    L9_2.time = L10_2
    L7_2(L8_2, L9_2)
  end
  return L0_2
end
L10_1 = common
function L11_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = lib
  L1_2 = L1_2.callback
  L1_2 = L1_2.await
  L2_2 = "housing:getDancers"
  L3_2 = false
  L4_2 = CurrentHouse
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  L2_2 = {}
  L3_2 = L9_1
  L3_2 = L3_2()
  L2_2.available = L3_2
  L3_2 = L1_2 or L3_2
  if not L1_2 then
    L3_2 = {}
  end
  L2_2.pending = L3_2
  return L2_2
end
L10_1.getDancers = L11_1
L10_1 = common
function L11_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  if A1_2 then
    L2_2 = A1_2.coords
    if L2_2 then
      goto lbl_7
    end
  end
  do return end
  ::lbl_7::
  L2_2 = CurrentHouse
  if L2_2 then
    L2_2 = CurrentHouse
    L3_2 = A1_2.house
    if L2_2 == L3_2 then
      goto lbl_15
    end
  end
  do return end
  ::lbl_15::
  L2_2 = L6_1
  L3_2 = "dancers"
  L4_2 = 35.0
  L5_2 = 45.0
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = nil
  L4_2 = A1_2.anim
  if L4_2 then
    L4_2 = A1_2.anim
    L4_2 = L4_2.dict
  end
  L5_2 = A1_2.anim
  if L5_2 then
    L5_2 = A1_2.anim
    L5_2 = L5_2.name
  end
  L6_2 = L7_1
  L7_2 = A1_2
  L6_2 = L6_2(L7_2)
  if L2_2 >= L6_2 then
    L6_2 = L8_1
    L7_2 = A1_2
    L6_2, L7_2, L8_2 = L6_2(L7_2)
    L5_2 = L8_2
    L4_2 = L7_2
    L3_2 = L6_2
  end
  L7_2 = A1_2.id
  L6_2 = L4_1
  L8_2 = {}
  L8_2.data = A1_2
  L8_2.ped = L3_2
  L8_2.animDict = L4_2
  L8_2.animName = L5_2
  L6_2[L7_2] = L8_2
end
L10_1.spawnDancer = L11_1
L10_1 = common
function L11_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L4_1
  L2_2 = L2_2[A1_2]
  if not L2_2 then
    return
  end
  L2_2 = L4_1
  L2_2 = L2_2[A1_2]
  L3_2 = L2_2.ped
  if L3_2 then
    L3_2 = DoesEntityExist
    L4_2 = L2_2.ped
    L3_2 = L3_2(L4_2)
    if L3_2 then
      L3_2 = DeleteEntity
      L4_2 = L2_2.ped
      L3_2(L4_2)
    end
  end
  L3_2 = L4_1
  L3_2[A1_2] = nil
end
L10_1.removeDancer = L11_1
L10_1 = common
function L11_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = cache
  L1_2 = L1_2.ped
  L2_2 = L1_1.ptfxHandle
  if L2_2 then
    L2_2 = StopParticleFxLooped
    L3_2 = L1_1.ptfxHandle
    L4_2 = false
    L2_2(L3_2, L4_2)
    L1_1.ptfxHandle = nil
  end
  L2_2 = A0_2.shower
  L2_2.isInShower = false
  L1_1.animDict = nil
  L1_1.animName = nil
  L2_2 = L0_1.waterFallPtfx
  if L2_2 then
    L2_2 = StopParticleFxLooped
    L3_2 = L0_1.waterFallPtfx
    L4_2 = false
    L2_2(L3_2, L4_2)
    L0_1.waterFallPtfx = nil
  end
  L2_2 = L0_1.waterObject
  if L2_2 then
    L2_2 = DoesEntityExist
    L3_2 = L0_1.waterObject
    L2_2 = L2_2(L3_2)
    if L2_2 then
      L2_2 = DeleteObject
      L3_2 = L0_1.waterObject
      L2_2(L3_2)
      L0_1.waterObject = nil
    end
  end
  L0_1.objectHandle = nil
  L0_1.fillThreadActive = false
  L2_2 = A0_2.bathtub
  L2_2.isInBathtub = false
  L2_2 = L5_1
  L2_2()
  L2_2 = A0_2.robbery
  L2_2 = L2_2.carryingFurniture
  if L2_2 then
    L2_2 = A0_2.robbery
    L2_2 = L2_2.carriedObject
    if L2_2 then
      L3_2 = DoesEntityExist
      L4_2 = L2_2
      L3_2 = L3_2(L4_2)
      if L3_2 then
        L3_2 = DetachEntity
        L4_2 = L2_2
        L5_2 = false
        L6_2 = false
        L3_2(L4_2, L5_2, L6_2)
        L3_2 = SetEntityCompletelyDisableCollision
        L4_2 = L2_2
        L5_2 = false
        L6_2 = false
        L3_2(L4_2, L5_2, L6_2)
        L3_2 = FreezeEntityPosition
        L4_2 = L2_2
        L5_2 = true
        L3_2(L4_2, L5_2)
      end
    end
  end
  L2_2 = A0_2.robbery
  L2_2.carryingFurniture = false
  L2_2 = A0_2.robbery
  L2_2.carriedObject = nil
  L2_2 = A0_2.robbery
  L2_2.carriedObjectData = nil
  if L1_2 then
    L2_2 = DoesEntityExist
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    if L2_2 then
      L3_2 = A0_2
      L2_2 = A0_2.cleanScenarioObjects
      L4_2 = L1_2
      L2_2(L3_2, L4_2)
      L2_2 = ClearPedTasksImmediately
      L3_2 = L1_2
      L2_2(L3_2)
    end
  end
end
L10_1.cleanupRuntimeOnHouseExit = L11_1
L10_1 = common
function L11_1(A0_2)
  local L1_2, L2_2
  L1_2 = CreateThread
  function L2_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3
    while true do
      L0_3 = CurrentHouse
      if not L0_3 then
        break
      end
      L0_3 = Wait
      L1_3 = 1000
      L0_3(L1_3)
      L0_3 = CurrentHouse
      if L0_3 then
        L0_3 = L6_1
        L1_3 = "dancers"
        L2_3 = 35.0
        L3_3 = 45.0
        L0_3, L1_3 = L0_3(L1_3, L2_3, L3_3)
        L2_3 = pairs
        L3_3 = L4_1
        L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3)
        for L6_3, L7_3 in L2_3, L3_3, L4_3, L5_3 do
          L8_3 = L7_3.data
          if L8_3 then
            L8_3 = L7_3.data
            L8_3 = L8_3.coords
            if L8_3 then
              L8_3 = L7_3.data
              L8_3 = L8_3.house
              L9_3 = CurrentHouse
              if L8_3 == L9_3 then
                L8_3 = L7_1
                L9_3 = L7_3.data
                L8_3 = L8_3(L9_3)
                L9_3 = L7_3.ped
                if L9_3 then
                  L9_3 = DoesEntityExist
                  L10_3 = L7_3.ped
                  L9_3 = L9_3(L10_3)
                  if L9_3 and L1_3 <= L8_3 then
                    L9_3 = DeleteEntity
                    L10_3 = L7_3.ped
                    L9_3(L10_3)
                    L7_3.ped = nil
                end
                else
                  L9_3 = L7_3.ped
                  if L9_3 then
                    L9_3 = DoesEntityExist
                    L10_3 = L7_3.ped
                    L9_3 = L9_3(L10_3)
                  end
                  if not L9_3 and L0_3 >= L8_3 then
                    L9_3 = L8_1
                    L10_3 = L7_3.data
                    L9_3, L10_3, L11_3 = L9_3(L10_3)
                    L7_3.ped = L9_3
                    L7_3.animDict = L10_3
                    L7_3.animName = L11_3
                  end
                end
              end
            end
          end
          L8_3 = L7_3.ped
          if L8_3 then
            L8_3 = DoesEntityExist
            L9_3 = L7_3.ped
            L8_3 = L8_3(L9_3)
            if L8_3 then
              L8_3 = L7_3.animDict
              if L8_3 then
                L8_3 = L7_3.animName
                if L8_3 then
                  L8_3 = IsEntityPlayingAnim
                  L9_3 = L7_3.ped
                  L10_3 = L7_3.animDict
                  L11_3 = L7_3.animName
                  L12_3 = 3
                  L8_3 = L8_3(L9_3, L10_3, L11_3, L12_3)
                  if not L8_3 then
                    L8_3 = TaskPlayAnim
                    L9_3 = L7_3.ped
                    L10_3 = L7_3.animDict
                    L11_3 = L7_3.animName
                    L12_3 = 8.0
                    L13_3 = -8.0
                    L14_3 = -1
                    L15_3 = 1
                    L16_3 = 0
                    L17_3 = false
                    L18_3 = false
                    L19_3 = false
                    L8_3(L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3)
                  end
                end
              end
          end
          else
            L7_3.ped = nil
          end
        end
      end
    end
  end
  L1_2(L2_2)
end
L10_1.dancersTick = L11_1
L10_1 = RegisterNUICallback
L11_1 = "dancers:order"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = Config
  L2_2 = L2_2.DancersEnabled
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = false
    return L2_2(L3_2)
  end
  L2_2 = A0_2.title
  L3_2 = A0_2.price
  L4_2 = lib
  L4_2 = L4_2.callback
  L4_2 = L4_2.await
  L5_2 = "housing:orderDancer"
  L6_2 = false
  L7_2 = CurrentHouse
  L8_2 = L2_2
  L9_2 = L3_2
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  if L4_2 then
    L5_2 = Notification
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "dancers.order_placed"
    L6_2 = L6_2(L7_2)
    L7_2 = "success"
    L5_2(L6_2, L7_2)
    L5_2 = management
    L6_2 = L5_2
    L5_2 = L5_2.updateUI
    L5_2(L6_2)
  else
    L5_2 = Notification
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "no_money"
    L8_2 = {}
    L8_2.price = L3_2
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = "error"
    L5_2(L6_2, L7_2)
  end
  L5_2 = A1_2
  L6_2 = L4_2
  L5_2(L6_2)
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNUICallback
L11_1 = "dancers:place"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = Config
  L2_2 = L2_2.DancersEnabled
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = false
    return L2_2(L3_2)
  end
  L2_2 = A0_2.dancerId
  L3_2 = A0_2.coords
  L4_2 = lib
  L4_2 = L4_2.callback
  L4_2 = L4_2.await
  L5_2 = "housing:placeDancer"
  L6_2 = false
  L7_2 = L2_2
  L8_2 = L3_2
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  if L4_2 then
    L5_2 = Notification
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "dancers.placed"
    L6_2 = L6_2(L7_2)
    L7_2 = "success"
    L5_2(L6_2, L7_2)
    L5_2 = management
    L6_2 = L5_2
    L5_2 = L5_2.updateUI
    L5_2(L6_2)
  else
    L5_2 = Notification
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "dancers.place_failed"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    L5_2(L6_2, L7_2)
  end
  L5_2 = A1_2
  L6_2 = L4_2
  L5_2(L6_2)
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNUICallback
L11_1 = "dancers:remove"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = Config
  L2_2 = L2_2.DancersEnabled
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = false
    return L2_2(L3_2)
  end
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:removeDancer"
  L4_2 = false
  L5_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  if L2_2 then
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "dancers.removed"
    L4_2 = L4_2(L5_2)
    L5_2 = "success"
    L3_2(L4_2, L5_2)
    L3_2 = management
    L4_2 = L3_2
    L3_2 = L3_2.updateUI
    L3_2(L4_2)
  else
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "dancers.remove_failed"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  end
  L3_2 = A1_2
  L4_2 = L2_2
  L3_2(L4_2)
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNetEvent
L11_1 = "housing:spawnDancer"
function L12_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = common
  L2_2 = L1_2
  L1_2 = L1_2.spawnDancer
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNetEvent
L11_1 = "housing:removeDancer"
function L12_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = common
  L2_2 = L1_2
  L1_2 = L1_2.removeDancer
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L10_1(L11_1, L12_1)
L10_1 = AddEventHandler
L11_1 = "housing:onExitHouse"
function L12_1()
  local L0_2, L1_2
  L0_2 = common
  L1_2 = L0_2
  L0_2 = L0_2.cleanupRuntimeOnHouseExit
  L0_2(L1_2)
end
L10_1(L11_1, L12_1)
L10_1 = AddEventHandler
L11_1 = "onResourceStop"
function L12_1(A0_2)
  local L1_2, L2_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 == L1_2 then
    L1_2 = common
    L2_2 = L1_2
    L1_2 = L1_2.cleanupRuntimeOnHouseExit
    L1_2(L2_2)
  end
end
L10_1(L11_1, L12_1)
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = {}
  L1_2 = ipairs
  L2_2 = Config
  L2_2 = L2_2.Deliveries
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = table
    L7_2 = L7_2.insert
    L8_2 = L0_2
    L9_2 = {}
    L10_2 = L6_2.title
    L9_2.title = L10_2
    L10_2 = L6_2.description
    L9_2.description = L10_2
    L10_2 = L6_2.price
    L9_2.price = L10_2
    L10_2 = L6_2.items
    L9_2.items = L10_2
    L7_2(L8_2, L9_2)
  end
  return L0_2
end
L11_1 = common
function L12_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = lib
  L1_2 = L1_2.callback
  L1_2 = L1_2.await
  L2_2 = "housing:getDeliveries"
  L3_2 = false
  L4_2 = CurrentHouse
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  L2_2 = {}
  L3_2 = L10_1
  L3_2 = L3_2()
  L2_2.available = L3_2
  L3_2 = L1_2 or L3_2
  if not L1_2 then
    L3_2 = {}
  end
  L2_2.pending = L3_2
  return L2_2
end
L11_1.getDeliveries = L12_1
L11_1 = RegisterNUICallback
L12_1 = "delivery:order"
function L13_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L2_2 = Config
  L2_2 = L2_2.DeliveriesEnabled
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = false
    return L2_2(L3_2)
  end
  L2_2 = A0_2.title
  L3_2 = A0_2.price
  L4_2 = A0_2.items
  L5_2 = lib
  L5_2 = L5_2.callback
  L6_2 = "housing:orderDelivery"
  L7_2 = false
  function L8_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3
    if A0_3 then
      L1_3 = Notification
      L2_3 = i18n
      L2_3 = L2_3.t
      L3_3 = "delivery.order_placed"
      L2_3 = L2_3(L3_3)
      L3_3 = "success"
      L1_3(L2_3, L3_3)
      L1_3 = management
      L2_3 = L1_3
      L1_3 = L1_3.updateUI
      L1_3(L2_3)
    else
      L1_3 = Notification
      L2_3 = i18n
      L2_3 = L2_3.t
      L3_3 = "no_money"
      L4_3 = {}
      L5_3 = L3_2
      L4_3.price = L5_3
      L2_3 = L2_3(L3_3, L4_3)
      L3_3 = "error"
      L1_3(L2_3, L3_3)
    end
    L1_3 = A1_2
    L2_3 = A0_3
    L1_3(L2_3)
  end
  L9_2 = CurrentHouse
  L10_2 = L2_2
  L11_2 = L3_2
  L12_2 = L4_2
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
end
L11_1(L12_1, L13_1)
L11_1 = RegisterNUICallback
L12_1 = "delivery:collect"
function L13_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = Config
  L2_2 = L2_2.DeliveriesEnabled
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = false
    return L2_2(L3_2)
  end
  L2_2 = lib
  L2_2 = L2_2.callback
  L3_2 = "housing:collectDelivery"
  L4_2 = false
  function L5_2(A0_3)
    local L1_3, L2_3, L3_3
    if A0_3 then
      L1_3 = Notification
      L2_3 = i18n
      L2_3 = L2_3.t
      L3_3 = "delivery.collected"
      L2_3 = L2_3(L3_3)
      L3_3 = "success"
      L1_3(L2_3, L3_3)
      L1_3 = management
      L2_3 = L1_3
      L1_3 = L1_3.updateUI
      L1_3(L2_3)
    else
      L1_3 = Notification
      L2_3 = i18n
      L2_3 = L2_3.t
      L3_3 = "no_permission"
      L2_3 = L2_3(L3_3)
      L3_3 = "error"
      L1_3(L2_3, L3_3)
    end
    L1_3 = A1_2
    L2_3 = A0_3
    L1_3(L2_3)
  end
  L6_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2)
end
L11_1(L12_1, L13_1)
L11_1 = common
L12_1 = {}
L12_1.carryingFurniture = false
L12_1.carriedObject = nil
L12_1.carriedObjectData = nil
L11_1.robbery = L12_1
L11_1 = "anim@heists@box_carry@"
L12_1 = "idle"
L13_1 = common
function L14_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L3_2 = A0_2.robbery
  L3_2 = L3_2.carryingFurniture
  if L3_2 then
    return
  end
  L3_2 = DoesEntityExist
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    return
  end
  L3_2 = lib
  L3_2 = L3_2.requestAnimDict
  L4_2 = L11_1
  L3_2(L4_2)
  L3_2 = TaskPlayAnim
  L4_2 = cache
  L4_2 = L4_2.ped
  L5_2 = L11_1
  L6_2 = L12_1
  L7_2 = 8.0
  L8_2 = -8.0
  L9_2 = -1
  L10_2 = 49
  L11_2 = 0
  L12_2 = false
  L13_2 = false
  L14_2 = false
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L3_2 = GetPedBoneIndex
  L4_2 = cache
  L4_2 = L4_2.ped
  L5_2 = 18905
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = AttachEntityToEntity
  L5_2 = A1_2
  L6_2 = cache
  L6_2 = L6_2.ped
  L7_2 = L3_2
  L8_2 = 0.1
  L9_2 = 0.0
  L10_2 = 0.0
  L11_2 = 0.0
  L12_2 = 0.0
  L13_2 = 0.0
  L14_2 = false
  L15_2 = false
  L16_2 = false
  L17_2 = false
  L18_2 = 0
  L19_2 = true
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  L4_2 = SetEntityCompletelyDisableCollision
  L5_2 = A1_2
  L6_2 = true
  L7_2 = false
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = FreezeEntityPosition
  L5_2 = A1_2
  L6_2 = false
  L4_2(L5_2, L6_2)
  L4_2 = A0_2.robbery
  L4_2.carryingFurniture = true
  L4_2 = A0_2.robbery
  L4_2.carriedObject = A1_2
  L4_2 = A0_2.robbery
  L4_2.carriedObjectData = A2_2
  L4_2 = Notification
  L5_2 = i18n
  L5_2 = L5_2.t
  L6_2 = "robbery.carrying_furniture"
  L5_2 = L5_2(L6_2)
  L6_2 = "info"
  L4_2(L5_2, L6_2)
end
L13_1.startCarryingFurniture = L14_1
L13_1 = common
function L14_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = A0_2.robbery
  L2_2 = L2_2.carryingFurniture
  if not L2_2 then
    return
  end
  L2_2 = A0_2.robbery
  L2_2 = L2_2.carriedObject
  L3_2 = A0_2.robbery
  L3_2 = L3_2.carriedObjectData
  if L2_2 then
    L4_2 = DoesEntityExist
    L5_2 = L2_2
    L4_2 = L4_2(L5_2)
    if L4_2 then
      L4_2 = DetachEntity
      L5_2 = L2_2
      L6_2 = false
      L7_2 = false
      L4_2(L5_2, L6_2, L7_2)
      if A1_2 then
        L4_2 = GetEntityCoords
        L5_2 = cache
        L5_2 = L5_2.ped
        L4_2 = L4_2(L5_2)
        L5_2 = SetEntityCoords
        L6_2 = L2_2
        L7_2 = L4_2.x
        L8_2 = L4_2.y
        L9_2 = L4_2.z
        L10_2 = false
        L11_2 = false
        L12_2 = false
        L13_2 = false
        L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
        L5_2 = PlaceObjectOnGroundProperly
        L6_2 = L2_2
        L5_2(L6_2)
        L5_2 = SetEntityCompletelyDisableCollision
        L6_2 = L2_2
        L7_2 = false
        L8_2 = false
        L5_2(L6_2, L7_2, L8_2)
        L5_2 = FreezeEntityPosition
        L6_2 = L2_2
        L7_2 = true
        L5_2(L6_2, L7_2)
      end
    end
  end
  L4_2 = ClearPedTasks
  L5_2 = cache
  L5_2 = L5_2.ped
  L4_2(L5_2)
  L4_2 = A0_2.robbery
  L4_2.carryingFurniture = false
  L4_2 = A0_2.robbery
  L4_2.carriedObject = nil
  L4_2 = A0_2.robbery
  L4_2.carriedObjectData = nil
  L4_2 = Notification
  L5_2 = i18n
  L5_2 = L5_2.t
  L6_2 = "robbery.dropped_furniture"
  L5_2 = L5_2(L6_2)
  L6_2 = "info"
  L4_2(L5_2, L6_2)
end
L13_1.stopCarryingFurniture = L14_1
L13_1 = common
function L14_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = A0_2.robbery
  L3_2 = L3_2.carryingFurniture
  if L3_2 then
    return
  end
  L3_2 = DoesEntityExist
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    return
  end
  L4_2 = A0_2
  L3_2 = A0_2.startCarryingFurniture
  L5_2 = A1_2
  L6_2 = A2_2
  L3_2(L4_2, L5_2, L6_2)
end
L13_1.pickupFurniture = L14_1
L13_1 = common
function L14_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = A0_2.robbery
  L2_2 = L2_2.carryingFurniture
  if not L2_2 then
    return
  end
  L2_2 = A0_2.robbery
  L2_2 = L2_2.carriedObjectData
  if not L2_2 then
    return
  end
  L2_2 = A0_2.robbery
  L2_2 = L2_2.carriedObject
  L3_2 = A0_2.robbery
  L3_2 = L3_2.carriedObjectData
  if L2_2 then
    L4_2 = DoesEntityExist
    L5_2 = L2_2
    L4_2 = L4_2(L5_2)
    if L4_2 then
      L4_2 = DeleteObject
      L5_2 = L2_2
      L4_2(L5_2)
    end
  end
  L4_2 = ClearPedTasks
  L5_2 = cache
  L5_2 = L5_2.ped
  L4_2(L5_2)
  L4_2 = A0_2.robbery
  L4_2.carryingFurniture = false
  L4_2 = A0_2.robbery
  L4_2.carriedObject = nil
  if L3_2 then
    L4_2 = L3_2.id
    if L4_2 then
      L4_2 = TriggerServerEvent
      L5_2 = "housing:robbery:stealFurniture"
      L6_2 = A1_2
      L7_2 = L3_2.id
      L8_2 = L3_2
      L4_2(L5_2, L6_2, L7_2, L8_2)
    end
  end
  L4_2 = A0_2.robbery
  L4_2.carriedObjectData = nil
  L4_2 = Notification
  L5_2 = i18n
  L5_2 = L5_2.t
  L6_2 = "robbery.furniture_stolen"
  L5_2 = L5_2(L6_2)
  L6_2 = "success"
  L4_2(L5_2, L6_2)
end
L13_1.stealAtExit = L14_1
L13_1 = RegisterNetEvent
L14_1 = "housing:startCooking"
function L15_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = common
  L2_2 = L1_2
  L1_2 = L1_2.startCooking
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L13_1(L14_1, L15_1)
L13_1 = CreateThread
function L14_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  while true do
    L0_2 = 500
    L1_2 = cache
    L1_2 = L1_2.ped
    L2_2 = common
    L2_2 = L2_2.robbery
    L2_2 = L2_2.carryingFurniture
    if L2_2 then
      L2_2 = DoesEntityExist
      L3_2 = L1_2
      L2_2 = L2_2(L3_2)
      if L2_2 then
        L0_2 = 0
        L2_2 = IsEntityPlayingAnim
        L3_2 = L1_2
        L4_2 = L11_1
        L5_2 = L12_1
        L6_2 = 3
        L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
        if not L2_2 then
          L2_2 = TaskPlayAnim
          L3_2 = L1_2
          L4_2 = L11_1
          L5_2 = L12_1
          L6_2 = 8.0
          L7_2 = -8.0
          L8_2 = -1
          L9_2 = 49
          L10_2 = 0
          L11_2 = false
          L12_2 = false
          L13_2 = false
          L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
        end
        L2_2 = Config
        L2_2 = L2_2.Houses
        L3_2 = CurrentHouse
        L2_2 = L2_2[L3_2]
        if L2_2 then
          L3_2 = GetEntityCoords
          L4_2 = L1_2
          L3_2 = L3_2(L4_2)
          L4_2 = nil
          L5_2 = L2_2.mlo
          if L5_2 then
            L5_2 = vec3
            L6_2 = L2_2.coords
            L6_2 = L6_2.enter
            L6_2 = L6_2.x
            L7_2 = L2_2.coords
            L7_2 = L7_2.enter
            L7_2 = L7_2.y
            L8_2 = L2_2.coords
            L8_2 = L8_2.enter
            L8_2 = L8_2.z
            L5_2 = L5_2(L6_2, L7_2, L8_2)
            L4_2 = L5_2
          else
            L5_2 = L2_2.ipl
            if L5_2 then
              L5_2 = vec3
              L6_2 = L2_2.ipl
              L6_2 = L6_2.exit
              L6_2 = L6_2.x
              L7_2 = L2_2.ipl
              L7_2 = L7_2.exit
              L7_2 = L7_2.y
              L8_2 = L2_2.ipl
              L8_2 = L8_2.exit
              L8_2 = L8_2.z
              L5_2 = L5_2(L6_2, L7_2, L8_2)
              L4_2 = L5_2
            else
              L5_2 = L2_2.coords
              L5_2 = L5_2.exit
              if L5_2 then
                L5_2 = vec3
                L6_2 = L2_2.coords
                L6_2 = L6_2.exit
                L6_2 = L6_2.x
                L7_2 = L2_2.coords
                L7_2 = L7_2.exit
                L7_2 = L7_2.y
                L8_2 = L2_2.coords
                L8_2 = L8_2.exit
                L8_2 = L8_2.z
                L5_2 = L5_2(L6_2, L7_2, L8_2)
                L4_2 = L5_2
              end
            end
          end
          L5_2 = L4_2 or L5_2
          if L4_2 then
            L5_2 = L3_2 - L4_2
            L5_2 = #L5_2
            L5_2 = L5_2 <= 2
          end
          L6_2 = IsControlJustPressed
          L7_2 = 0
          L8_2 = Keys
          L8_2 = L8_2.E
          L6_2 = L6_2(L7_2, L8_2)
          if L6_2 and not L5_2 then
            L6_2 = common
            L7_2 = L6_2
            L6_2 = L6_2.stopCarryingFurniture
            L8_2 = true
            L6_2(L7_2, L8_2)
          end
        else
          L3_2 = IsControlJustPressed
          L4_2 = 0
          L5_2 = Keys
          L5_2 = L5_2.E
          L3_2 = L3_2(L4_2, L5_2)
          if L3_2 then
            L3_2 = common
            L4_2 = L3_2
            L3_2 = L3_2.stopCarryingFurniture
            L5_2 = true
            L3_2(L4_2, L5_2)
          end
        end
      end
    end
    L2_2 = Wait
    L3_2 = L0_2
    L2_2(L3_2)
  end
end
L13_1(L14_1)
L13_1 = common
L14_1 = {}
L14_1.ped = nil
L14_1.spawned = false
L14_1.blip = nil
L13_1.robberyNPC = L14_1
L13_1 = common
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L1_2 = A0_2.robberyNPC
  L1_2 = L1_2.spawned
  if L1_2 then
    L1_2 = DoesEntityExist
    L2_2 = A0_2.robberyNPC
    L2_2 = L2_2.ped
    L1_2 = L1_2(L2_2)
    if L1_2 then
      return
    end
  end
  L1_2 = Config
  L1_2 = L1_2.Robbery
  if L1_2 then
    L1_2 = Config
    L1_2 = L1_2.Robbery
    L1_2 = L1_2.sell
    if L1_2 then
      L1_2 = Config
      L1_2 = L1_2.Robbery
      L1_2 = L1_2.sell
      L1_2 = L1_2.enabled
      if L1_2 then
        goto lbl_28
      end
    end
  end
  do return end
  ::lbl_28::
  L1_2 = Config
  L1_2 = L1_2.Robbery
  L1_2 = L1_2.sell
  L2_2 = L1_2.location
  L3_2 = lib
  L3_2 = L3_2.requestModel
  L4_2 = L1_2.pedModel
  L5_2 = Config
  L5_2 = L5_2.DefaultRequestModelTimeout
  L3_2(L4_2, L5_2)
  L3_2 = CreatePed
  L4_2 = 28
  L5_2 = L1_2.pedModel
  L6_2 = L2_2.x
  L7_2 = L2_2.y
  L8_2 = L2_2.z
  L8_2 = L8_2 - 1.0
  L9_2 = L2_2.w
  if not L9_2 then
    L9_2 = 0.0
  end
  L10_2 = false
  L11_2 = false
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L4_2 = SetEntityInvincible
  L5_2 = L3_2
  L6_2 = true
  L4_2(L5_2, L6_2)
  L4_2 = SetBlockingOfNonTemporaryEvents
  L5_2 = L3_2
  L6_2 = true
  L4_2(L5_2, L6_2)
  L4_2 = FreezeEntityPosition
  L5_2 = L3_2
  L6_2 = true
  L4_2(L5_2, L6_2)
  L4_2 = SetEntityCollision
  L5_2 = L3_2
  L6_2 = false
  L7_2 = false
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = SetPedRandomComponentVariation
  L5_2 = L3_2
  L6_2 = 0
  L4_2(L5_2, L6_2)
  L4_2 = SetPedRandomProps
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = L1_2.anim
  if L4_2 then
    L4_2 = L1_2.anim
    L4_2 = L4_2.dict
    if L4_2 then
      L4_2 = L1_2.anim
      L4_2 = L4_2.name
      if L4_2 then
        L4_2 = lib
        L4_2 = L4_2.requestAnimDict
        L5_2 = L1_2.anim
        L5_2 = L5_2.dict
        L4_2(L5_2)
        L4_2 = TaskPlayAnim
        L5_2 = L3_2
        L6_2 = L1_2.anim
        L6_2 = L6_2.dict
        L7_2 = L1_2.anim
        L7_2 = L7_2.name
        L8_2 = 8.0
        L9_2 = -8.0
        L10_2 = -1
        L11_2 = 1
        L12_2 = 0
        L13_2 = false
        L14_2 = false
        L15_2 = false
        L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
      end
    end
  end
  L4_2 = A0_2.robberyNPC
  L4_2.ped = L3_2
  L4_2 = A0_2.robberyNPC
  L4_2.spawned = true
  L4_2 = L1_2.blip
  if L4_2 then
    L4_2 = L1_2.blip
    L4_2 = L4_2.enabled
    if L4_2 then
      L4_2 = L1_2.blip
      L5_2 = L4_2.text
      if not L5_2 then
        L5_2 = i18n
        L5_2 = L5_2.t
        L6_2 = "robbery.blip_name"
        L5_2 = L5_2(L6_2)
        if not L5_2 then
          L5_2 = "Fence"
        end
      end
      L6_2 = A0_2.robberyNPC
      L7_2 = Utils
      L7_2 = L7_2.CreateBlip
      L8_2 = {}
      L8_2.location = L2_2
      L9_2 = L4_2.sprite
      if not L9_2 then
        L9_2 = 1
      end
      L8_2.sprite = L9_2
      L9_2 = L4_2.color
      if not L9_2 then
        L9_2 = 4
      end
      L8_2.color = L9_2
      L9_2 = L4_2.scale
      if not L9_2 then
        L9_2 = 1.0
      end
      L8_2.scale = L9_2
      L8_2.text = L5_2
      L8_2.shortRange = true
      L7_2 = L7_2(L8_2)
      L6_2.blip = L7_2
    end
  end
  L4_2 = SetModelAsNoLongerNeeded
  L5_2 = L1_2.pedModel
  L4_2(L5_2)
end
L13_1.spawnRobberyNPC = L14_1
L13_1 = common
function L14_1(A0_2)
  local L1_2, L2_2
  L1_2 = A0_2.robberyNPC
  L1_2 = L1_2.ped
  if L1_2 then
    L1_2 = DoesEntityExist
    L2_2 = A0_2.robberyNPC
    L2_2 = L2_2.ped
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = DeleteEntity
      L2_2 = A0_2.robberyNPC
      L2_2 = L2_2.ped
      L1_2(L2_2)
    end
  end
  L1_2 = A0_2.robberyNPC
  L1_2 = L1_2.blip
  if L1_2 then
    L1_2 = Utils
    L1_2 = L1_2.RemoveBlip
    L2_2 = A0_2.robberyNPC
    L2_2 = L2_2.blip
    L1_2(L2_2)
  end
  L1_2 = A0_2.robberyNPC
  L1_2.ped = nil
  L1_2 = A0_2.robberyNPC
  L1_2.blip = nil
  L1_2 = A0_2.robberyNPC
  L1_2.spawned = false
end
L13_1.deleteRobberyNPC = L14_1
L13_1 = CreateThread
function L14_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  while true do
    L0_2 = Wait
    L1_2 = 1000
    L0_2(L1_2)
    L0_2 = Config
    L0_2 = L0_2.Robbery
    L1_2 = L0_2 or L1_2
    if L0_2 then
      L1_2 = L0_2.sell
    end
    if L1_2 then
      L2_2 = L1_2.enabled
      if L2_2 then
        L2_2 = L1_2.location
        if L2_2 then
          goto lbl_26
        end
      end
    end
    L2_2 = common
    L2_2 = L2_2.robberyNPC
    L2_2 = L2_2.spawned
    if L2_2 then
      L2_2 = common
      L3_2 = L2_2
      L2_2 = L2_2.deleteRobberyNPC
      L2_2(L3_2)
      goto lbl_67
      ::lbl_26::
      L2_2 = L6_1
      L3_2 = "robbery"
      L4_2 = 70.0
      L5_2 = 85.0
      L2_2, L3_2 = L2_2(L3_2, L4_2, L5_2)
      L4_2 = GetEntityCoords
      L5_2 = cache
      L5_2 = L5_2.ped
      L4_2 = L4_2(L5_2)
      L5_2 = vec3
      L6_2 = L1_2.location
      L6_2 = L6_2.x
      L7_2 = L1_2.location
      L7_2 = L7_2.y
      L8_2 = L1_2.location
      L8_2 = L8_2.z
      L5_2 = L5_2(L6_2, L7_2, L8_2)
      L6_2 = L4_2 - L5_2
      L6_2 = #L6_2
      if L2_2 >= L6_2 then
        L7_2 = common
        L7_2 = L7_2.robberyNPC
        L7_2 = L7_2.spawned
        if not L7_2 then
          L7_2 = common
          L8_2 = L7_2
          L7_2 = L7_2.spawnRobberyNPC
          L7_2(L8_2)
      end
      elseif L3_2 <= L6_2 then
        L7_2 = common
        L7_2 = L7_2.robberyNPC
        L7_2 = L7_2.spawned
        if L7_2 then
          L7_2 = common
          L8_2 = L7_2
          L7_2 = L7_2.deleteRobberyNPC
          L7_2(L8_2)
        end
      end
    end
    ::lbl_67::
  end
end
L13_1(L14_1)
L13_1 = AddEventHandler
L14_1 = "onResourceStop"
function L15_1(A0_2)
  local L1_2, L2_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 == L1_2 then
    L1_2 = common
    L2_2 = L1_2
    L1_2 = L1_2.deleteRobberyNPC
    L1_2(L2_2)
  end
end
L13_1(L14_1, L15_1)
L13_1 = CreateThread
function L14_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  while true do
    L0_2 = 1000
    L1_2 = common
    L1_2 = L1_2.robberyNPC
    L1_2 = L1_2.spawned
    if L1_2 then
      L1_2 = DoesEntityExist
      L2_2 = common
      L2_2 = L2_2.robberyNPC
      L2_2 = L2_2.ped
      L1_2 = L1_2(L2_2)
      if L1_2 then
        L1_2 = GetEntityCoords
        L2_2 = cache
        L2_2 = L2_2.ped
        L1_2 = L1_2(L2_2)
        L2_2 = GetEntityCoords
        L3_2 = common
        L3_2 = L3_2.robberyNPC
        L3_2 = L3_2.ped
        L2_2 = L2_2(L3_2)
        L3_2 = L1_2 - L2_2
        L3_2 = #L3_2
        if L3_2 < 2.0 then
          L0_2 = 0
          L4_2 = i18n
          L4_2 = L4_2.t
          L5_2 = "drawtext.sell_furniture"
          L4_2 = L4_2(L5_2)
          L5_2 = DrawText3D
          L6_2 = L2_2.x
          L7_2 = L2_2.y
          L8_2 = L2_2.z
          L8_2 = L8_2 + 0.3
          L9_2 = L4_2
          L10_2 = "sell_furniture_npc"
          L11_2 = "E"
          L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
          L5_2 = IsControlJustPressed
          L6_2 = 0
          L7_2 = Keys
          L7_2 = L7_2.E
          L5_2 = L5_2(L6_2, L7_2)
          if L5_2 then
            L5_2 = lib
            L5_2 = L5_2.callback
            L5_2 = L5_2.await
            L6_2 = "housing:robbery:getStolenFurniture"
            L7_2 = false
            L5_2 = L5_2(L6_2, L7_2)
            if L5_2 then
              L6_2 = #L5_2
              if 0 ~= L6_2 then
                goto lbl_72
              end
            end
            L6_2 = Notification
            L7_2 = i18n
            L7_2 = L7_2.t
            L8_2 = "robbery.no_stolen_furniture"
            L7_2 = L7_2(L8_2)
            if not L7_2 then
              L7_2 = "You have no stolen furniture"
            end
            L8_2 = "error"
            L6_2(L7_2, L8_2)
            do return end
            ::lbl_72::
            L6_2 = SendReactMessage
            L7_2 = "toggle_robbery_sell"
            L8_2 = {}
            L8_2.visible = true
            L8_2.furniture = L5_2
            L6_2(L7_2, L8_2)
            L6_2 = SetNuiFocus
            L7_2 = true
            L8_2 = true
            L6_2(L7_2, L8_2)
          end
        end
      end
    end
    L1_2 = Wait
    L2_2 = L0_2
    L1_2(L2_2)
  end
end
L13_1(L14_1)
L13_1 = RegisterNUICallback
L14_1 = "robbery_sell:close"
function L15_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = SendReactMessage
  L3_2 = "toggle_robbery_sell"
  L4_2 = {}
  L4_2.visible = false
  L5_2 = {}
  L4_2.furniture = L5_2
  L2_2(L3_2, L4_2)
  L2_2 = SetNuiFocus
  L3_2 = false
  L4_2 = false
  L2_2(L3_2, L4_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L13_1(L14_1, L15_1)
L13_1 = RegisterNUICallback
L14_1 = "robbery_sell:sell"
function L15_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = A0_2.furnitureId
  if not L2_2 then
    L3_2 = A1_2
    L4_2 = false
    L3_2(L4_2)
    return
  end
  L3_2 = TriggerServerEvent
  L4_2 = "housing:robbery:sellFurniture"
  L5_2 = L2_2
  L3_2(L4_2, L5_2)
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L13_1(L14_1, L15_1)






