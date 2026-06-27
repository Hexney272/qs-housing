





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1
L0_1 = {}
function L1_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = A0_2._properties
  L1_2 = L1_2.handle
  if not L1_2 then
    L1_2 = IsNamedRendertargetRegistered
    L2_2 = A0_2._properties
    L2_2 = L2_2.targetName
    L1_2 = L1_2(L2_2)
    if not L1_2 then
      L1_2 = IsNamedRendertargetLinked
      L2_2 = A0_2._properties
      L2_2 = L2_2.model
      L1_2 = L1_2(L2_2)
      if not L1_2 then
        L1_2 = RegisterNamedRendertarget
        L2_2 = A0_2._properties
        L2_2 = L2_2.targetName
        L3_2 = false
        L1_2(L2_2, L3_2)
        L1_2 = LinkNamedRendertarget
        L2_2 = A0_2._properties
        L2_2 = L2_2.model
        L1_2(L2_2)
      end
    end
    L1_2 = A0_2._properties
    L2_2 = GetNamedRendertargetRenderId
    L3_2 = A0_2._properties
    L3_2 = L3_2.targetName
    L2_2 = L2_2(L3_2)
    L1_2.handle = L2_2
  end
  L1_2 = A0_2._properties
  L1_2 = L1_2.handle
  return L1_2
end
L0_1.attach = L1_1
function L1_1(A0_2)
  local L1_2, L2_2
  L1_2 = ReleaseNamedRendertarget
  L2_2 = A0_2._properties
  L2_2 = L2_2.targetName
  L1_2(L2_2)
  L1_2 = A0_2._properties
  L1_2.handle = nil
end
L0_1.release = L1_1
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = A0_2._properties
  L2_2 = L2_2.handle
  if not L2_2 then
    L3_2 = A0_2
    L2_2 = A0_2.attach
    L2_2(L3_2)
  end
  L2_2 = A0_2._properties
  L2_2 = L2_2.handle
  if L2_2 then
    L2_2 = SetTextRenderId
    L3_2 = A0_2._properties
    L3_2 = L3_2.handle
    L2_2(L3_2)
    L2_2 = SetScriptGfxDrawOrder
    L3_2 = A0_2._properties
    L3_2 = L3_2.drawOrder
    L2_2(L3_2)
    L2_2 = pcall
    L3_2 = A1_2
    L2_2, L3_2 = L2_2(L3_2)
    if not L2_2 then
      return L3_2
    end
    L4_2 = SetTextRenderId
    L5_2 = 1
    L4_2(L5_2)
  else
    L2_2 = "Render target handle unavailable?!"
    return L2_2
  end
end
L0_1.select = L1_1
L1_1 = {}
L2_1 = L0_1.select
L1_1.__call = L2_1
function L2_1(A0_2, A1_2)
  local L2_2
  L2_2 = A0_2._methods
  L2_2 = L2_2[A1_2]
  return L2_2
end
L1_1.__index = L2_1
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = type
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if "string" == L3_2 then
    L3_2 = GetHashKey
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    A0_2 = L3_2
  end
  L3_2 = assert
  L4_2 = IsModelValid
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L5_2 = "RenderTarget requires a valid model as it's first argument!"
  L3_2(L4_2, L5_2)
  L3_2 = assert
  L4_2 = type
  L5_2 = A1_2
  L4_2 = L4_2(L5_2)
  L4_2 = "string" == L4_2
  L5_2 = "RenderTarget requires a string for it's second argument, targetName!"
  L3_2(L4_2, L5_2)
  if not A2_2 then
    A2_2 = 4
  end
  L3_2 = assert
  L4_2 = type
  L5_2 = A2_2
  L4_2 = L4_2(L5_2)
  L4_2 = "number" == L4_2
  L5_2 = "RenderTarget requires a number for it's third argument. drawOrder is usually 4 and can be left out."
  L3_2(L4_2, L5_2)
  L3_2 = {}
  L4_2 = {}
  L4_2.model = A0_2
  L4_2.targetName = A1_2
  L4_2.drawOrder = A2_2
  L3_2._properties = L4_2
  L4_2 = L0_1
  L3_2._methods = L4_2
  L4_2 = setmetatable
  L5_2 = L3_2
  L6_2 = L1_1
  L4_2(L5_2, L6_2)
  L5_2 = L3_2
  L4_2 = L3_2.attach
  L4_2(L5_2)
  return L3_2
end
RenderTarget = L2_1
L2_1 = 0
L3_1 = 2.0
L4_1 = 1
L5_1 = {}
L6_1 = {}
L6_1.model = -1528588652
L6_1.name = "prop_x17_tv_scrn_01"
L7_1 = {}
L7_1.model = -684524750
L7_1.name = "prop_x17_tv_scrn_02"
L8_1 = {}
L8_1.model = 8834525
L8_1.name = "prop_x17_tv_scrn_03"
L9_1 = {}
L9_1.model = 583602785
L9_1.name = "prop_x17_tv_scrn_04"
L10_1 = {}
L10_1.model = -601553638
L10_1.name = "prop_x17_tv_scrn_05"
L11_1 = {}
L11_1.model = 240019820
L11_1.name = "prop_x17_tv_scrn_06"
L12_1 = {}
L12_1.model = -867605065
L12_1.name = "prop_x17_tv_scrn_07"
L13_1 = {}
L13_1.model = -1650456475
L13_1.name = "prop_x17_tv_scrn_08"
L14_1 = {}
L14_1.model = -1345213240
L14_1.name = "prop_x17_tv_scrn_09"
L15_1 = {}
L15_1.model = 1481571468
L15_1.name = "prop_x17_tv_scrn_10"
L16_1 = {}
L16_1.model = -473459841
L16_1.name = "prop_x17_tv_scrn_11"
L17_1 = {}
L17_1.model = -167692302
L17_1.name = "prop_x17_tv_scrn_12"
L18_1 = {}
L18_1.model = -1993253308
L18_1.name = "prop_x17_tv_scrn_13"
L19_1 = {}
L19_1.model = 1542587334
L19_1.name = "prop_x17_tv_scrn_14"
L20_1 = {}
L20_1.model = 636360651
L20_1.name = "prop_x17_tv_scrn_15"
L21_1 = {}
L21_1.model = 908867655
L21_1.name = "prop_x17_tv_scrn_16"
L22_1 = {}
L22_1.model = -829757194
L22_1.name = "prop_x17_tv_scrn_17"
L23_1 = {}
L23_1.model = -1605825421
L23_1.name = "prop_x17_tv_scrn_18"
L24_1 = {}
L24_1.model = 1794089409
L24_1.name = "prop_x17_tv_scrn_19"
L5_1[1] = L6_1
L5_1[2] = L7_1
L5_1[3] = L8_1
L5_1[4] = L9_1
L5_1[5] = L10_1
L5_1[6] = L11_1
L5_1[7] = L12_1
L5_1[8] = L13_1
L5_1[9] = L14_1
L5_1[10] = L15_1
L5_1[11] = L16_1
L5_1[12] = L17_1
L5_1[13] = L18_1
L5_1[14] = L19_1
L5_1[15] = L20_1
L5_1[16] = L21_1
L5_1[17] = L22_1
L5_1[18] = L23_1
L5_1[19] = L24_1
function L6_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L3_2 = vector3
  L4_2 = 0
  L5_2 = 0
  L6_2 = 0.5
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L3_2 = A0_2 + L3_2
  L4_2 = IsSphereVisible
  L5_2 = L3_2
  L6_2 = L3_1
  L4_2 = L4_2(L5_2, L6_2)
  if not L4_2 then
    L4_2 = "Not on screen"
    return L4_2
  end
  L4_2 = GetFinalRenderedCamCoord
  L4_2 = L4_2()
  L5_2 = L4_2 - A0_2
  L5_2 = #L5_2
  if L5_2 > 100 then
    L6_2 = "Point out of range"
    return L6_2
  end
  L6_2 = L3_2 - L4_2
  L7_2 = math
  L7_2 = L7_2.deg
  L8_2 = math
  L8_2 = L8_2.atan
  L9_2 = L6_2.y
  L10_2 = L6_2.x
  L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L8_2(L9_2, L10_2)
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  L8_2 = L7_2 - A1_2
  if L8_2 < 0 then
    L9_2 = -180
    if L8_2 > L9_2 then
      L9_2 = "Not a visible angle"
      return L9_2
    end
  end
  L9_2 = GetGameTimer
  L9_2 = L9_2()
  L10_2 = L2_1
  if L10_2 == L9_2 then
    L10_2 = L4_1
    L10_2 = L10_2 + 1
    L4_1 = L10_2
  else
    L10_2 = 1
    L4_1 = L10_2
  end
  L11_2 = L4_1
  L10_2 = L5_1
  L10_2 = L10_2[L11_2]
  if L10_2 then
    L2_1 = L9_2
    L11_2 = L4_1
    L10_2 = L5_1
    L10_2 = L10_2[L11_2]
    L11_2 = L10_2.rt
    if not L11_2 then
      L11_2 = RenderTarget
      L12_2 = L10_2.model
      L13_2 = L10_2.name
      L11_2 = L11_2(L12_2, L13_2)
      L10_2.rt = L11_2
    end
    L11_2 = L10_2.entity
    if L11_2 then
      L11_2 = DoesEntityExist
      L12_2 = L10_2.entity
      L11_2 = L11_2(L12_2)
      if L11_2 then
        goto lbl_106
      end
    end
    L11_2 = CreateObjectNoOffset
    L12_2 = L10_2.model
    L13_2 = A0_2
    L14_2 = false
    L15_2 = false
    L16_2 = false
    L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
    L10_2.entity = L11_2
    L11_2 = SetEntityAsMissionEntity
    L12_2 = L10_2.entity
    L13_2 = true
    L14_2 = true
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = SetEntityCollision
    L12_2 = L10_2.entity
    L13_2 = false
    L14_2 = false
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = SetEntityAlpha
    L12_2 = L10_2.entity
    L13_2 = 254
    L11_2(L12_2, L13_2)
    L11_2 = SetModelAsNoLongerNeeded
    L12_2 = L10_2.model
    L11_2(L12_2)
    ::lbl_106::
    L11_2 = SetEntityCoordsNoOffset
    L12_2 = L10_2.entity
    L13_2 = A0_2
    L14_2 = false
    L15_2 = false
    L16_2 = false
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
    L11_2 = SetEntityHeading
    L12_2 = L10_2.entity
    L13_2 = A1_2
    L11_2(L12_2, L13_2)
    L11_2 = L10_2.rt
    function L12_2()
      local L0_3, L1_3, L2_3
      L0_3 = A2_2
      L1_3 = L10_2.entity
      L2_3 = L5_2
      L0_3(L1_3, L2_3)
    end
    L11_2 = L11_2(L12_2)
    if L11_2 then
      L12_2 = print
      L13_2 = "FloatyDraw failed callback: "
      L14_2 = message
      L13_2 = L13_2 .. L14_2
      L12_2(L13_2)
      L12_2 = Citizen
      L12_2 = L12_2.Wait
      L13_2 = 1000
      L12_2(L13_2)
      L12_2 = "Failed callback: "
      L13_2 = message
      L12_2 = L12_2 .. L13_2
      return L12_2
    end
  else
    L10_2 = print
    L11_2 = "FloatyDraw ran out of draw targets! Can only do 19 at a time!"
    L10_2(L11_2)
    L10_2 = Citizen
    L10_2 = L10_2.Wait
    L11_2 = 1000
    L10_2(L11_2)
    L10_2 = "Too many targets!"
    return L10_2
  end
end
FloatyDraw = L6_1
L6_1 = AddEventHandler
L7_1 = "onResourceStop"
function L8_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 == L1_2 then
    L1_2 = pairs
    L2_2 = L5_1
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = L6_2.rt
      if L7_2 then
        L7_2 = L6_2.rt
        L8_2 = L7_2
        L7_2 = L7_2.release
        L7_2(L8_2)
      end
      L7_2 = L6_2.entity
      if L7_2 then
        L7_2 = DoesEntityExist
        L8_2 = L6_2.entity
        L7_2 = L7_2(L8_2)
        if L7_2 then
          L7_2 = DeleteEntity
          L8_2 = L6_2.entity
          L7_2(L8_2)
        end
      end
    end
  end
end
L6_1(L7_1, L8_1)






