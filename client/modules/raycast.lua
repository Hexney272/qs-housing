





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1
L0_1 = require
L1_1 = "glm"
L0_1 = L0_1(L1_1)
L0_1 = L0_1.sincos
L1_1 = require
L2_1 = "glm"
L1_1 = L1_1(L2_1)
L1_1 = L1_1.rad
L2_1 = math
L2_1 = L2_1.abs
L3_1 = GetFinalRenderedCamCoord
L4_1 = GetFinalRenderedCamRot
L5_1 = GetEntityCoords
L6_1 = DisableAllControlActions
L7_1 = DrawLine
L8_1 = GetCamMatrix
L9_1 = Utils
L9_1 = L9_1.CreateCamera
L10_1 = Utils
L10_1 = L10_1.HandleFlyCam
L11_1 = Utils
L11_1 = L11_1.DrawScaleform
L12_1 = _G
L13_1 = {}
L14_1 = {}
L15_1 = {}
L16_1 = "up"
L17_1 = "right"
L18_1 = "forward"
L15_1[1] = L16_1
L15_1[2] = L17_1
L15_1[3] = L18_1
L14_1.controls = L15_1
L13_1.cameraOptions = L14_1
L12_1.raycast = L13_1
L12_1 = raycast
function L13_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = L0_1
  L2_2 = L1_1
  L3_2 = L4_1
  L4_2 = 2
  L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2)
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L1_2, L2_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  L3_2 = vec3
  L4_2 = L1_2.z
  L4_2 = -L4_2
  L5_2 = L2_1
  L6_2 = L2_2.x
  L5_2 = L5_2(L6_2)
  L4_2 = L4_2 * L5_2
  L5_2 = L2_2.z
  L6_2 = L2_1
  L7_2 = L2_2.x
  L6_2 = L6_2(L7_2)
  L5_2 = L5_2 * L6_2
  L6_2 = L1_2.x
  return L3_2(L4_2, L5_2, L6_2)
end
L12_1.getForwardVector = L13_1
L12_1 = raycast
function L13_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2
  L5_2 = assert
  L6_2 = type
  L7_2 = A1_2
  L6_2 = L6_2(L7_2)
  L6_2 = "function" == L6_2
  L7_2 = "raycast:gameplayCamera ::: fn must be a function"
  L5_2(L6_2, L7_2)
  if not A2_2 then
    L5_2 = {}
    A2_2 = L5_2
  end
  L5_2 = Utils
  L5_2 = L5_2.GetControls
  L6_2 = A2_2
  L5_2 = L5_2(L6_2)
  A0_2.controls = L5_2
  L5_2 = Utils
  L5_2 = L5_2.CreateInstructional
  L6_2 = A0_2.controls
  L5_2 = L5_2(L6_2)
  A0_2.scaleform = L5_2
  A0_2.active = true
  if not A3_2 then
    A3_2 = 17
  end
  while true do
    L5_2 = A0_2.active
    if not L5_2 then
      break
    end
    L5_2 = DisablePlayerFiring
    L6_2 = cache
    L6_2 = L6_2.playerId
    L7_2 = true
    L5_2(L6_2, L7_2)
    L5_2 = L3_1
    L5_2 = L5_2()
    L7_2 = A0_2
    L6_2 = A0_2.getForwardVector
    L6_2 = L6_2(L7_2)
    L6_2 = L6_2 * 50.0
    L6_2 = L5_2 + L6_2
    L7_2 = _ENV
    L8_2 = "StartExpensiveSynchronousShapeTestLosProbe"
    L7_2 = L7_2[L8_2]
    L8_2 = L5_2.x
    L9_2 = L5_2.y
    L10_2 = L5_2.z
    L11_2 = L6_2.x
    L12_2 = L6_2.y
    L13_2 = L6_2.z
    L14_2 = A3_2
    L15_2 = A4_2 or L15_2
    if not A4_2 then
      L15_2 = cache
      L15_2 = L15_2.ped
    end
    L16_2 = 4
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    L8_2 = L5_1
    L9_2 = cache
    L9_2 = L9_2.ped
    L8_2 = L8_2(L9_2)
    L9_2 = GetShapeTestResultIncludingMaterial
    L10_2 = L7_2
    L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L9_2(L10_2)
    L15_2 = 1 == L10_2
    L16_2 = L14_2 or L16_2
    if 0 == L14_2 or not L14_2 then
      L16_2 = nil
    end
    A0_2.coords = L11_2
    A0_2.entity = L16_2
    A0_2.hit = L15_2
    L15_2 = A0_2.hit
    if L15_2 then
      L15_2 = DrawMarker
      L16_2 = 28
      L17_2 = A0_2.coords
      L17_2 = L17_2.x
      L18_2 = A0_2.coords
      L18_2 = L18_2.y
      L19_2 = A0_2.coords
      L19_2 = L19_2.z
      L20_2 = 0.0
      L21_2 = 0.0
      L22_2 = 0.0
      L23_2 = 0.0
      L24_2 = 0.0
      L25_2 = 0.0
      L26_2 = 0.2
      L27_2 = 0.2
      L28_2 = 0.2
      L29_2 = 255
      L30_2 = 42
      L31_2 = 24
      L32_2 = 100
      L33_2 = false
      L34_2 = false
      L35_2 = 0
      L36_2 = true
      L37_2 = false
      L38_2 = false
      L39_2 = false
      L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2)
      L15_2 = DrawLine
      L16_2 = L8_2.x
      L17_2 = L8_2.y
      L18_2 = L8_2.z
      L19_2 = A0_2.coords
      L19_2 = L19_2.x
      L20_2 = A0_2.coords
      L20_2 = L20_2.y
      L21_2 = A0_2.coords
      L21_2 = L21_2.z
      L22_2 = 255
      L23_2 = 42
      L24_2 = 24
      L25_2 = 100
      L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
    end
    L15_2 = A1_2
    L16_2 = A0_2
    L15_2(L16_2)
    L15_2 = L11_1
    L16_2 = A0_2.scaleform
    L15_2(L16_2)
    L15_2 = A0_2.coords
    A0_2.lastCoords = L15_2
    L15_2 = Wait
    L16_2 = 0
    L15_2(L16_2)
  end
end
L12_1.gameplayCamera = L13_1
L12_1 = raycast
function L13_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2
  L4_2 = assert
  L5_2 = type
  L6_2 = A1_2
  L5_2 = L5_2(L6_2)
  L5_2 = "function" == L5_2
  L6_2 = "raycast:camera ::: fn must be a function"
  L4_2(L5_2, L6_2)
  if A3_2 then
    L4_2 = type
    L5_2 = A3_2
    L4_2 = L4_2(L5_2)
    if "table" == L4_2 then
      goto lbl_23
    end
  end
  L4_2 = {}
  L4_2.line = true
  L4_2.scaleform = true
  A3_2 = L4_2
  ::lbl_23::
  L4_2 = GetEntityMatrix
  L5_2 = cache
  L5_2 = L5_2.ped
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  L8_2 = L6_2 * 2
  L8_2 = L7_2 + L8_2
  L9_2 = GetEntityRotation
  L10_2 = cache
  L10_2 = L10_2.ped
  L9_2 = L9_2(L10_2)
  A0_2.camRot = L9_2
  A0_2.camPos = L8_2
  L8_2 = L9_1
  L9_2 = "DEFAULT_SCRIPTED_CAMERA"
  L10_2 = A0_2.camPos
  L11_2 = A0_2.camRot
  L12_2 = true
  L13_2 = nil
  L14_2 = 1000
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  A0_2.camera = L8_2
  A0_2.active = true
  L8_2 = SetPlayerControl
  L9_2 = cache
  L9_2 = L9_2.playerId
  L10_2 = false
  L11_2 = 0
  L8_2(L9_2, L10_2, L11_2)
  L8_2 = table
  L8_2 = L8_2.deepclone
  L9_2 = A0_2.cameraOptions
  L9_2 = L9_2.controls
  L8_2 = L8_2(L9_2)
  if A2_2 then
    L9_2 = pairs
    L10_2 = A2_2
    L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
    for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
      L15_2 = #L8_2
      L15_2 = L15_2 + 1
      L8_2[L15_2] = L14_2
    end
  end
  L9_2 = Utils
  L9_2 = L9_2.GetControls
  L10_2 = L8_2
  L9_2 = L9_2(L10_2)
  A0_2.controls = L9_2
  L9_2 = Utils
  L9_2 = L9_2.CreateInstructional
  L10_2 = A0_2.controls
  L9_2 = L9_2(L10_2)
  A0_2.scaleform = L9_2
  while true do
    L9_2 = A0_2.active
    if not L9_2 then
      break
    end
    L9_2 = L6_1
    L10_2 = 0
    L9_2(L10_2)
    L9_2 = L10_1
    L10_2 = A0_2.camera
    L9_2, L10_2 = L9_2(L10_2)
    A0_2.camRot = L10_2
    A0_2.camPos = L9_2
    L9_2 = L8_1
    L10_2 = A0_2.camera
    L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
    L13_2 = vec3
    L14_2 = A0_2.camPos
    L14_2 = L14_2.x
    L15_2 = L10_2.x
    L15_2 = L15_2 * 100.0
    L14_2 = L14_2 + L15_2
    L15_2 = A0_2.camPos
    L15_2 = L15_2.y
    L16_2 = L10_2.y
    L16_2 = L16_2 * 100.0
    L15_2 = L15_2 + L16_2
    L16_2 = A0_2.camPos
    L16_2 = L16_2.z
    L17_2 = L10_2.z
    L17_2 = L17_2 * 100.0
    L16_2 = L16_2 + L17_2
    L13_2 = L13_2(L14_2, L15_2, L16_2)
    L14_2 = _ENV
    L15_2 = "StartExpensiveSynchronousShapeTestLosProbe"
    L14_2 = L14_2[L15_2]
    L15_2 = A0_2.camPos
    L15_2 = L15_2.x
    L16_2 = A0_2.camPos
    L16_2 = L16_2.y
    L17_2 = A0_2.camPos
    L17_2 = L17_2.z
    L18_2 = L13_2.x
    L19_2 = L13_2.y
    L20_2 = L13_2.z
    L21_2 = 17
    L22_2 = cache
    L22_2 = L22_2.ped
    L23_2 = 4
    L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
    L15_2 = GetShapeTestResultIncludingMaterial
    L16_2 = L14_2
    L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L15_2(L16_2)
    L21_2 = 1 == L16_2
    L22_2 = L20_2
    A0_2.coords = L17_2
    A0_2.entity = L22_2
    A0_2.hit = L21_2
    L21_2 = A3_2.line
    if L21_2 then
      L21_2 = L7_1
      L22_2 = A0_2.coords
      L22_2 = L22_2.x
      L22_2 = L22_2 - 0.3
      L23_2 = A0_2.coords
      L23_2 = L23_2.y
      L24_2 = A0_2.coords
      L24_2 = L24_2.z
      L25_2 = A0_2.coords
      L25_2 = L25_2.x
      L25_2 = L25_2 + 0.3
      L26_2 = A0_2.coords
      L26_2 = L26_2.y
      L27_2 = A0_2.coords
      L27_2 = L27_2.z
      L28_2 = 255
      L29_2 = 0
      L30_2 = 0
      L31_2 = 255
      L21_2(L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2)
      L21_2 = L7_1
      L22_2 = A0_2.coords
      L22_2 = L22_2.x
      L23_2 = A0_2.coords
      L23_2 = L23_2.y
      L24_2 = A0_2.coords
      L24_2 = L24_2.z
      L25_2 = A0_2.coords
      L25_2 = L25_2.x
      L26_2 = A0_2.coords
      L26_2 = L26_2.y
      L27_2 = A0_2.coords
      L27_2 = L27_2.z
      L27_2 = L27_2 + 0.3
      L28_2 = 255
      L29_2 = 0
      L30_2 = 0
      L31_2 = 255
      L21_2(L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2)
      L21_2 = L7_1
      L22_2 = A0_2.coords
      L22_2 = L22_2.x
      L23_2 = A0_2.coords
      L23_2 = L23_2.y
      L23_2 = L23_2 - 0.3
      L24_2 = A0_2.coords
      L24_2 = L24_2.z
      L25_2 = A0_2.coords
      L25_2 = L25_2.x
      L26_2 = A0_2.coords
      L26_2 = L26_2.y
      L26_2 = L26_2 + 0.3
      L27_2 = A0_2.coords
      L27_2 = L27_2.z
      L28_2 = 255
      L29_2 = 0
      L30_2 = 0
      L31_2 = 255
      L21_2(L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2)
    end
    L21_2 = A3_2.scaleform
    if L21_2 then
      L21_2 = L11_1
      L22_2 = A0_2.scaleform
      L21_2(L22_2)
    end
    L21_2 = A1_2
    L22_2 = A0_2
    L21_2(L22_2)
    L21_2 = Wait
    L22_2 = 0
    L21_2(L22_2)
  end
end
L12_1.freeCamera = L13_1
L12_1 = raycast
function L13_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  A0_2.active = false
  L1_2 = A0_2.camera
  if L1_2 then
    L1_2 = Utils
    L1_2 = L1_2.DestroyFlyCam
    L2_2 = A0_2.camera
    L3_2 = 1000
    L1_2(L2_2, L3_2)
    A0_2.camera = nil
    L1_2 = SetPlayerControl
    L2_2 = cache
    L2_2 = L2_2.playerId
    L3_2 = true
    L4_2 = 0
    L1_2(L2_2, L3_2, L4_2)
  end
end
L12_1.destroy = L13_1
L12_1 = AddEventHandler
L13_1 = "onResourceStop"
function L14_1(A0_2)
  local L1_2, L2_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 == L1_2 then
    L1_2 = raycast
    L2_2 = L1_2
    L1_2 = L1_2.destroy
    L1_2(L2_2)
  end
end
L12_1(L13_1, L14_1)






