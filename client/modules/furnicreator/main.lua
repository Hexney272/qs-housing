





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1
L0_1 = _G
L1_1 = {}
L1_1.visible = false
L1_1.token = nil
L0_1.furnitureCreator = L1_1
L0_1 = furnitureCreator
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = A0_2.visible
  if not L1_2 then
    return
  end
  L1_2 = table
  L1_2 = L1_2.deepclone
  L2_2 = Config
  L2_2 = L2_2.Furniture
  L1_2 = L1_2(L2_2)
  L2_2 = pairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = table
    L8_2 = L8_2.filter
    L9_2 = L7_2.items
    function L10_2(A0_3)
      local L1_3
      L1_3 = A0_3.creator
      return L1_3
    end
    L8_2 = L8_2(L9_2, L10_2)
    L7_2.items = L8_2
  end
  L2_2 = SendReactMessage
  L3_2 = "toggle_furniture_creator"
  L4_2 = {}
  L4_2.visible = true
  L4_2.furniture = L1_2
  L2_2(L3_2, L4_2)
end
L0_1.updateUI = L1_1
L0_1 = furnitureCreator
function L1_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = ToggleHud
  L2_2 = false
  L1_2(L2_2)
  A0_2.visible = true
  L1_2 = SetNuiFocus
  L2_2 = true
  L3_2 = true
  L1_2(L2_2, L3_2)
  L2_2 = A0_2
  L1_2 = A0_2.updateUI
  L1_2(L2_2)
  L1_2 = Debug
  L2_2 = "Furniture Creator opened"
  L1_2(L2_2)
end
L0_1.open = L1_1
L0_1 = furnitureCreator
function L1_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = A0_2.visible
  if not L1_2 then
    return
  end
  A0_2.visible = false
  L1_2 = SendReactMessage
  L2_2 = "toggle_furniture_creator"
  L3_2 = {}
  L3_2.visible = false
  L1_2(L2_2, L3_2)
  L1_2 = ToggleHud
  L2_2 = true
  L1_2(L2_2)
  L1_2 = SetNuiFocus
  L2_2 = false
  L3_2 = false
  L1_2(L2_2, L3_2)
  L1_2 = Debug
  L2_2 = "Furniture Creator closed"
  L1_2(L2_2)
end
L0_1.close = L1_1
L0_1 = RegisterNetEvent
L1_1 = "housing:syncFurnitureData"
function L2_1(A0_2)
  local L1_2
  L1_2 = Config
  L1_2.Furniture = A0_2
  L1_2 = InitializeFurnitures
  L1_2()
end
L0_1(L1_1, L2_1)
L0_1 = RegisterCommand
L1_1 = Config
L1_1 = L1_1.FurniCreatorCommand
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = lib
  L3_2 = L3_2.callback
  L3_2 = L3_2.await
  L4_2 = "housing:hasPermission"
  L5_2 = 0
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L4_2 = Notification
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "no_permission"
    L5_2 = L5_2(L6_2)
    L6_2 = "error"
    return L4_2(L5_2, L6_2)
  end
  L4_2 = furnitureCreator
  L5_2 = L4_2
  L4_2 = L4_2.open
  L4_2(L5_2)
end
L0_1(L1_1, L2_1)
L0_1 = {}
PendingScreenshots = L0_1
L0_1 = {}
ScreenshotResults = L0_1
L0_1 = furnitureCreator
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = Wait
  L3_2 = Config
  L3_2 = L3_2.FurniCreator
  L3_2 = L3_2.interval
  L2_2(L3_2)
  L2_2 = A0_2.token
  if not L2_2 then
    L2_2 = lib
    L2_2 = L2_2.callback
    L2_2 = L2_2.await
    L3_2 = "housing:getFiveManageToken"
    L4_2 = false
    L2_2 = L2_2(L3_2, L4_2)
    A0_2.token = L2_2
  end
  L2_2 = A0_2.token
  if not L2_2 then
    L2_2 = Notification
    L3_2 = i18n
    L3_2 = L3_2.t
    L4_2 = "furniture_creator.token_not_set"
    L3_2 = L3_2(L4_2)
    L4_2 = "error"
    L2_2(L3_2, L4_2)
    return
  end
  L2_2 = PendingScreenshots
  L3_2 = {}
  L3_2.name = A1_2
  L4_2 = GetGameTimer
  L4_2 = L4_2()
  L3_2.timestamp = L4_2
  L2_2[A1_2] = L3_2
  L2_2 = Notification
  L3_2 = i18n
  L3_2 = L3_2.t
  L4_2 = "furniture_creator.uploading_image"
  L3_2 = L3_2(L4_2)
  L4_2 = "info"
  L2_2(L3_2, L4_2)
  L2_2 = exports
  L2_2 = L2_2["screenshot-basic"]
  L3_2 = L2_2
  L2_2 = L2_2.requestScreenshot
  L4_2 = {}
  L4_2.encoding = "png"
  function L5_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3
    L1_3 = SendReactMessage
    L2_3 = "upload_image"
    L3_3 = {}
    L3_3.image = A0_3
    L4_3 = A0_2.token
    L3_3.fiveManageToken = L4_3
    L4_3 = A1_2
    L3_3.requestId = L4_3
    L1_3(L2_3, L3_3)
  end
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = Debug
  L3_2 = "Screenshot Request Sent"
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
  return A1_2
end
L0_1.takeScreenshot = L1_1
L0_1 = furnitureCreator
function L1_1(A0_2)
  local L1_2, L2_2
  L1_2 = next
  L2_2 = PendingScreenshots
  L1_2 = L1_2(L2_2)
  L1_2 = nil ~= L1_2
  return L1_2
end
L0_1.hasPendingScreenshots = L1_1
L0_1 = RegisterNUICallback
L1_1 = "handle_uploaded_image"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = PendingScreenshots
  L3_2 = A0_2.requestId
  L2_2 = L2_2[L3_2]
  if not L2_2 then
    L3_2 = Error
    L4_2 = "No data found for requestId"
    L5_2 = A0_2.requestId
    L3_2(L4_2, L5_2)
    L3_2 = A1_2
    L4_2 = "error"
    return L3_2(L4_2)
  end
  L3_2 = ScreenshotResults
  L4_2 = A0_2.requestId
  L5_2 = {}
  L6_2 = A0_2.url
  L5_2.filePath = L6_2
  L6_2 = L2_2.name
  L5_2.name = L6_2
  L3_2[L4_2] = L5_2
  L3_2 = Debug
  L4_2 = "Screenshot Results"
  L5_2 = ScreenshotResults
  L6_2 = A0_2.requestId
  L5_2 = L5_2[L6_2]
  L6_2 = "data"
  L7_2 = A0_2
  L3_2(L4_2, L5_2, L6_2, L7_2)
  L3_2 = PendingScreenshots
  L4_2 = A0_2.requestId
  L3_2[L4_2] = nil
  L3_2 = Notification
  L4_2 = i18n
  L4_2 = L4_2.t
  L5_2 = "furniture_creator.image_uploaded"
  L4_2 = L4_2(L5_2)
  L5_2 = "success"
  L3_2(L4_2, L5_2)
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L0_1(L1_1, L2_1)
L0_1 = vec3
L1_1 = -2407.29736328125
L2_1 = -2023.800537109375
L3_1 = 690.6831665039062
L0_1 = L0_1(L1_1, L2_1, L3_1)
L1_1 = vec3
L2_1 = 0.0
L3_1 = 0.0
L4_1 = 0.5
L1_1 = L1_1(L2_1, L3_1, L4_1)
L2_1 = 3.0
L3_1 = 1.0
L4_1 = 10.0
L5_1 = 15.0
L6_1 = 2.0
L7_1 = furnitureCreator
function L8_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2
  L2_2 = A0_2.inGreenBox
  if L2_2 then
    return
  end
  L2_2 = joaat
  L3_2 = "qs_gradient_032"
  L2_2 = L2_2(L3_2)
  L3_2 = RequestModel
  L4_2 = L2_2
  L3_2(L4_2)
  while true do
    L3_2 = HasModelLoaded
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      break
    end
    L3_2 = Wait
    L4_2 = 0
    L3_2(L4_2)
  end
  L3_2 = CreateObject
  L4_2 = L2_2
  L5_2 = L0_1.x
  L6_2 = L0_1.y
  L7_2 = L0_1.z
  L8_2 = false
  L9_2 = false
  L10_2 = false
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  A0_2.greenBox = L3_2
  L3_2 = FreezeEntityPosition
  L4_2 = A0_2.greenBox
  L5_2 = true
  L3_2(L4_2, L5_2)
  L3_2 = joaat
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  L4_2 = RequestModel
  L5_2 = L3_2
  L4_2(L5_2)
  while true do
    L4_2 = HasModelLoaded
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    if L4_2 then
      break
    end
    L4_2 = Wait
    L5_2 = 0
    L4_2(L5_2)
  end
  L4_2 = L0_1
  L5_2 = L1_1
  L4_2 = L4_2 + L5_2
  L5_2 = CreateObject
  L6_2 = L3_2
  L7_2 = L4_2.x
  L8_2 = L4_2.y
  L9_2 = L4_2.z
  L10_2 = false
  L11_2 = false
  L12_2 = false
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  A0_2.object = L5_2
  L5_2 = FreezeEntityPosition
  L6_2 = A0_2.object
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = SetEntityHeading
  L6_2 = A0_2.object
  L7_2 = 0.0
  L5_2(L6_2, L7_2)
  A0_2.inGreenBox = true
  L5_2 = GetEntityCoords
  L6_2 = cache
  L6_2 = L6_2.ped
  L5_2 = L5_2(L6_2)
  A0_2.initialPlayerCoords = L5_2
  L5_2 = FreezeEntityPosition
  L6_2 = cache
  L6_2 = L6_2.ped
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = SetEntityAlpha
  L6_2 = cache
  L6_2 = L6_2.ped
  L7_2 = 0
  L8_2 = false
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = Wait
  L6_2 = 100
  L5_2(L6_2)
  L5_2 = GetEntityCoords
  L6_2 = A0_2.object
  L5_2 = L5_2(L6_2)
  L6_2 = GetModelDimensions
  L7_2 = L3_2
  L6_2, L7_2 = L6_2(L7_2)
  L8_2 = L7_2 - L6_2
  L8_2 = #L8_2
  L9_2 = math
  L9_2 = L9_2.min
  L10_2 = L8_2 * 2.5
  L11_2 = L2_1
  L9_2 = L9_2(L10_2, L11_2)
  L10_2 = L9_2
  L11_2 = 0.0
  L12_2 = L7_2.z
  L13_2 = L6_2.z
  L12_2 = L12_2 - L13_2
  L12_2 = L12_2 / 2
  L13_2 = GetEntityCoords
  L14_2 = A0_2.object
  L13_2 = L13_2(L14_2)
  L14_2 = vec3
  L15_2 = L13_2.x
  L16_2 = math
  L16_2 = L16_2.cos
  L17_2 = L11_2
  L16_2 = L16_2(L17_2)
  L16_2 = L10_2 * L16_2
  L15_2 = L15_2 + L16_2
  L16_2 = L13_2.y
  L17_2 = math
  L17_2 = L17_2.sin
  L18_2 = L11_2
  L17_2 = L17_2(L18_2)
  L17_2 = L10_2 * L17_2
  L16_2 = L16_2 + L17_2
  L17_2 = L13_2.z
  L17_2 = L17_2 + L12_2
  L14_2 = L14_2(L15_2, L16_2, L17_2)
  L15_2 = Utils
  L15_2 = L15_2.CreateCamera
  L16_2 = "DEFAULT_SCRIPTED_CAMERA"
  L17_2 = L14_2
  L18_2 = vec3
  L19_2 = 0
  L20_2 = 0
  L21_2 = 0
  L18_2 = L18_2(L19_2, L20_2, L21_2)
  L19_2 = true
  L15_2 = L15_2(L16_2, L17_2, L18_2, L19_2)
  A0_2.greenBoxCamera = L15_2
  L15_2 = SetCamCoord
  L16_2 = A0_2.greenBoxCamera
  L17_2 = L14_2.x
  L18_2 = L14_2.y
  L19_2 = L14_2.z
  L15_2(L16_2, L17_2, L18_2, L19_2)
  L15_2 = PointCamAtCoord
  L16_2 = A0_2.greenBoxCamera
  L17_2 = L13_2.x
  L18_2 = L13_2.y
  L19_2 = L13_2.z
  L15_2(L16_2, L17_2, L18_2, L19_2)
  L15_2 = L13_2
  L16_2 = 0.0
  L17_2 = 100.0
  L18_2 = 0.0
  L19_2 = 0.5
  L20_2 = 0.0
  L21_2 = 0.0
  L22_2 = Utils
  L22_2 = L22_2.DrawInstructional
  L23_2 = {}
  L24_2 = "zoom"
  L25_2 = "done"
  L26_2 = "cancel"
  L27_2 = "up"
  L28_2 = "rotate_z"
  L29_2 = {}
  L29_2.key = "forward"
  L29_2.label = "Move Object Forward/Back (W/S)"
  L30_2 = {}
  L30_2.key = "right"
  L30_2.label = "Move Object Left/Right (A/D)"
  L23_2[1] = L24_2
  L23_2[2] = L25_2
  L23_2[3] = L26_2
  L23_2[4] = L27_2
  L23_2[5] = L28_2
  L23_2[6] = L29_2
  L23_2[7] = L30_2
  L22_2(L23_2)
  L22_2 = false
  while true do
    L23_2 = A0_2.inGreenBox
    if not L23_2 then
      break
    end
    L23_2 = DisableAllControlActions
    L24_2 = 0
    L23_2(L24_2)
    L23_2 = SetEntityHeading
    L24_2 = A0_2.object
    L25_2 = L16_2
    L23_2(L24_2, L25_2)
    L23_2 = IsDisabledControlPressed
    L24_2 = 0
    L25_2 = 32
    L23_2 = L23_2(L24_2, L25_2)
    if L23_2 then
      L23_2 = math
      L23_2 = L23_2.cos
      L24_2 = L11_2
      L23_2 = L23_2(L24_2)
      L23_2 = -L23_2
      L24_2 = L6_1
      L23_2 = L23_2 * L24_2
      L24_2 = GetFrameTime
      L24_2 = L24_2()
      L23_2 = L23_2 * L24_2
      L24_2 = math
      L24_2 = L24_2.sin
      L25_2 = L11_2
      L24_2 = L24_2(L25_2)
      L24_2 = -L24_2
      L25_2 = L6_1
      L24_2 = L24_2 * L25_2
      L25_2 = GetFrameTime
      L25_2 = L25_2()
      L24_2 = L24_2 * L25_2
      L20_2 = L20_2 + L23_2
      L21_2 = L21_2 + L24_2
    else
      L23_2 = IsDisabledControlPressed
      L24_2 = 0
      L25_2 = 8
      L23_2 = L23_2(L24_2, L25_2)
      if L23_2 then
        L23_2 = math
        L23_2 = L23_2.cos
        L24_2 = L11_2
        L23_2 = L23_2(L24_2)
        L24_2 = L6_1
        L23_2 = L23_2 * L24_2
        L24_2 = GetFrameTime
        L24_2 = L24_2()
        L23_2 = L23_2 * L24_2
        L24_2 = math
        L24_2 = L24_2.sin
        L25_2 = L11_2
        L24_2 = L24_2(L25_2)
        L25_2 = L6_1
        L24_2 = L24_2 * L25_2
        L25_2 = GetFrameTime
        L25_2 = L25_2()
        L24_2 = L24_2 * L25_2
        L20_2 = L20_2 + L23_2
        L21_2 = L21_2 + L24_2
      end
    end
    L23_2 = IsDisabledControlPressed
    L24_2 = 0
    L25_2 = 34
    L23_2 = L23_2(L24_2, L25_2)
    if L23_2 then
      L23_2 = math
      L23_2 = L23_2.sin
      L24_2 = L11_2
      L23_2 = L23_2(L24_2)
      L23_2 = -L23_2
      L24_2 = L6_1
      L23_2 = L23_2 * L24_2
      L24_2 = GetFrameTime
      L24_2 = L24_2()
      L23_2 = L23_2 * L24_2
      L24_2 = math
      L24_2 = L24_2.cos
      L25_2 = L11_2
      L24_2 = L24_2(L25_2)
      L25_2 = L6_1
      L24_2 = L24_2 * L25_2
      L25_2 = GetFrameTime
      L25_2 = L25_2()
      L24_2 = L24_2 * L25_2
      L20_2 = L20_2 + L23_2
      L21_2 = L21_2 + L24_2
    else
      L23_2 = IsDisabledControlPressed
      L24_2 = 0
      L25_2 = 9
      L23_2 = L23_2(L24_2, L25_2)
      if L23_2 then
        L23_2 = math
        L23_2 = L23_2.sin
        L24_2 = L11_2
        L23_2 = L23_2(L24_2)
        L24_2 = L6_1
        L23_2 = L23_2 * L24_2
        L24_2 = GetFrameTime
        L24_2 = L24_2()
        L23_2 = L23_2 * L24_2
        L24_2 = math
        L24_2 = L24_2.cos
        L25_2 = L11_2
        L24_2 = L24_2(L25_2)
        L24_2 = -L24_2
        L25_2 = L6_1
        L24_2 = L24_2 * L25_2
        L25_2 = GetFrameTime
        L25_2 = L25_2()
        L24_2 = L24_2 * L25_2
        L20_2 = L20_2 + L23_2
        L21_2 = L21_2 + L24_2
      end
    end
    L23_2 = SetEntityCoords
    L24_2 = A0_2.object
    L25_2 = L5_2.x
    L25_2 = L25_2 + L20_2
    L26_2 = L5_2.y
    L26_2 = L26_2 + L21_2
    L27_2 = L5_2.z
    L27_2 = L27_2 + L18_2
    L28_2 = false
    L29_2 = false
    L30_2 = false
    L31_2 = false
    L23_2(L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2)
    L23_2 = IsDisabledControlPressed
    L24_2 = 0
    L25_2 = ActionControls
    L25_2 = L25_2.rotate_z
    L25_2 = L25_2.codes
    L25_2 = L25_2[1]
    L23_2 = L23_2(L24_2, L25_2)
    if L23_2 then
      L23_2 = GetFrameTime
      L23_2 = L23_2()
      L23_2 = L17_2 * L23_2
      L23_2 = L16_2 + L23_2
      L16_2 = L23_2 % 360
    else
      L23_2 = IsDisabledControlPressed
      L24_2 = 0
      L25_2 = ActionControls
      L25_2 = L25_2.rotate_z
      L25_2 = L25_2.codes
      L25_2 = L25_2[2]
      L23_2 = L23_2(L24_2, L25_2)
      if L23_2 then
        L23_2 = GetFrameTime
        L23_2 = L23_2()
        L23_2 = L17_2 * L23_2
        L23_2 = L16_2 - L23_2
        L16_2 = L23_2 % 360
      end
    end
    L23_2 = IsDisabledControlPressed
    L24_2 = 0
    L25_2 = ActionControls
    L25_2 = L25_2.up
    L25_2 = L25_2.codes
    L25_2 = L25_2[1]
    L23_2 = L23_2(L24_2, L25_2)
    if L23_2 then
      L23_2 = GetFrameTime
      L23_2 = L23_2()
      L23_2 = L19_2 * L23_2
      L18_2 = L18_2 + L23_2
    else
      L23_2 = IsDisabledControlPressed
      L24_2 = 0
      L25_2 = ActionControls
      L25_2 = L25_2.up
      L25_2 = L25_2.codes
      L25_2 = L25_2[2]
      L23_2 = L23_2(L24_2, L25_2)
      if L23_2 then
        L23_2 = GetFrameTime
        L23_2 = L23_2()
        L23_2 = L19_2 * L23_2
        L18_2 = L18_2 - L23_2
      end
    end
    L23_2 = IsDisabledControlPressed
    L24_2 = 0
    L25_2 = ActionControls
    L25_2 = L25_2.rotate_z_scroll
    L25_2 = L25_2.codes
    L25_2 = L25_2[1]
    L23_2 = L23_2(L24_2, L25_2)
    if L23_2 then
      L23_2 = math
      L23_2 = L23_2.max
      L24_2 = L3_1
      L25_2 = L5_1
      L26_2 = GetFrameTime
      L26_2 = L26_2()
      L25_2 = L25_2 * L26_2
      L25_2 = L10_2 - L25_2
      L23_2 = L23_2(L24_2, L25_2)
      L10_2 = L23_2
      L23_2 = GetCamCoord
      L24_2 = A0_2.greenBoxCamera
      L23_2 = L23_2(L24_2)
      L24_2 = vec3
      L25_2 = L15_2.x
      L26_2 = L23_2.x
      L25_2 = L25_2 - L26_2
      L26_2 = L15_2.y
      L27_2 = L23_2.y
      L26_2 = L26_2 - L27_2
      L27_2 = L15_2.z
      L28_2 = L23_2.z
      L27_2 = L27_2 - L28_2
      L24_2 = L24_2(L25_2, L26_2, L27_2)
      L25_2 = math
      L25_2 = L25_2.sqrt
      L26_2 = L24_2.x
      L26_2 = L26_2 ^ 2
      L27_2 = L24_2.y
      L27_2 = L27_2 ^ 2
      L26_2 = L26_2 + L27_2
      L27_2 = L24_2.z
      L27_2 = L27_2 ^ 2
      L26_2 = L26_2 + L27_2
      L25_2 = L25_2(L26_2)
      L26_2 = 0.01
      if L25_2 > L26_2 then
        L26_2 = vec3
        L27_2 = L24_2.x
        L27_2 = L27_2 / L25_2
        L28_2 = L24_2.y
        L28_2 = L28_2 / L25_2
        L29_2 = L24_2.z
        L29_2 = L29_2 / L25_2
        L26_2 = L26_2(L27_2, L28_2, L29_2)
        L27_2 = vec3
        L28_2 = L15_2.x
        L29_2 = L26_2.x
        L29_2 = L29_2 * L10_2
        L28_2 = L28_2 - L29_2
        L29_2 = L15_2.y
        L30_2 = L26_2.y
        L30_2 = L30_2 * L10_2
        L29_2 = L29_2 - L30_2
        L30_2 = L15_2.z
        L31_2 = L26_2.z
        L31_2 = L31_2 * L10_2
        L30_2 = L30_2 - L31_2
        L27_2 = L27_2(L28_2, L29_2, L30_2)
        L28_2 = SetCamCoord
        L29_2 = A0_2.greenBoxCamera
        L30_2 = L27_2.x
        L31_2 = L27_2.y
        L32_2 = L27_2.z
        L28_2(L29_2, L30_2, L31_2, L32_2)
      end
    else
      L23_2 = IsDisabledControlPressed
      L24_2 = 0
      L25_2 = ActionControls
      L25_2 = L25_2.rotate_z_scroll
      L25_2 = L25_2.codes
      L25_2 = L25_2[2]
      L23_2 = L23_2(L24_2, L25_2)
      if L23_2 then
        L23_2 = math
        L23_2 = L23_2.min
        L24_2 = L4_1
        L25_2 = L5_1
        L26_2 = GetFrameTime
        L26_2 = L26_2()
        L25_2 = L25_2 * L26_2
        L25_2 = L10_2 + L25_2
        L23_2 = L23_2(L24_2, L25_2)
        L10_2 = L23_2
        L23_2 = GetCamCoord
        L24_2 = A0_2.greenBoxCamera
        L23_2 = L23_2(L24_2)
        L24_2 = vec3
        L25_2 = L15_2.x
        L26_2 = L23_2.x
        L25_2 = L25_2 - L26_2
        L26_2 = L15_2.y
        L27_2 = L23_2.y
        L26_2 = L26_2 - L27_2
        L27_2 = L15_2.z
        L28_2 = L23_2.z
        L27_2 = L27_2 - L28_2
        L24_2 = L24_2(L25_2, L26_2, L27_2)
        L25_2 = math
        L25_2 = L25_2.sqrt
        L26_2 = L24_2.x
        L26_2 = L26_2 ^ 2
        L27_2 = L24_2.y
        L27_2 = L27_2 ^ 2
        L26_2 = L26_2 + L27_2
        L27_2 = L24_2.z
        L27_2 = L27_2 ^ 2
        L26_2 = L26_2 + L27_2
        L25_2 = L25_2(L26_2)
        L26_2 = 0.01
        if L25_2 > L26_2 then
          L26_2 = vec3
          L27_2 = L24_2.x
          L27_2 = L27_2 / L25_2
          L28_2 = L24_2.y
          L28_2 = L28_2 / L25_2
          L29_2 = L24_2.z
          L29_2 = L29_2 / L25_2
          L26_2 = L26_2(L27_2, L28_2, L29_2)
          L27_2 = vec3
          L28_2 = L15_2.x
          L29_2 = L26_2.x
          L29_2 = L29_2 * L10_2
          L28_2 = L28_2 - L29_2
          L29_2 = L15_2.y
          L30_2 = L26_2.y
          L30_2 = L30_2 * L10_2
          L29_2 = L29_2 - L30_2
          L30_2 = L15_2.z
          L31_2 = L26_2.z
          L31_2 = L31_2 * L10_2
          L30_2 = L30_2 - L31_2
          L27_2 = L27_2(L28_2, L29_2, L30_2)
          L28_2 = SetCamCoord
          L29_2 = A0_2.greenBoxCamera
          L30_2 = L27_2.x
          L31_2 = L27_2.y
          L32_2 = L27_2.z
          L28_2(L29_2, L30_2, L31_2, L32_2)
        end
      end
    end
    L23_2 = IsDisabledControlJustPressed
    L24_2 = 0
    L25_2 = ActionControls
    L25_2 = L25_2.done
    L25_2 = L25_2.codes
    L25_2 = L25_2[1]
    L23_2 = L23_2(L24_2, L25_2)
    if L23_2 then
      L22_2 = true
      A0_2.inGreenBox = false
      break
    end
    L23_2 = IsDisabledControlJustPressed
    L24_2 = 0
    L25_2 = ActionControls
    L25_2 = L25_2.cancel
    L25_2 = L25_2.codes
    L25_2 = L25_2[1]
    L23_2 = L23_2(L24_2, L25_2)
    if not L23_2 then
      L23_2 = IsDisabledControlJustPressed
      L24_2 = 0
      L25_2 = 322
      L23_2 = L23_2(L24_2, L25_2)
      if not L23_2 then
        goto lbl_642
      end
    end
    A0_2.inGreenBox = false
    L23_2 = Notification
    L24_2 = i18n
    L24_2 = L24_2.t
    L25_2 = "furniture_creator.screenshot_cancelled"
    L24_2 = L24_2(L25_2)
    L25_2 = "error"
    L23_2(L24_2, L25_2)
    do break end
    ::lbl_642::
    L23_2 = Wait
    L24_2 = 0
    L23_2(L24_2)
  end
  L23_2 = Utils
  L23_2 = L23_2.RemoveInstructional
  L23_2()
  if L22_2 then
    L24_2 = A0_2
    L23_2 = A0_2.takeScreenshot
    L25_2 = A1_2
    L23_2 = L23_2(L24_2, L25_2)
    if not L23_2 then
      return
    end
    while true do
      L25_2 = A0_2
      L24_2 = A0_2.hasPendingScreenshots
      L24_2 = L24_2(L25_2)
      if not L24_2 then
        break
      end
      L24_2 = Wait
      L25_2 = 0
      L24_2(L25_2)
    end
    L24_2 = ScreenshotResults
    L24_2 = L24_2[L23_2]
    L26_2 = A0_2
    L25_2 = A0_2.destroyScreenshot
    L25_2(L26_2)
    L25_2 = ScreenshotResults
    L25_2[L23_2] = nil
    L25_2 = L24_2.filePath
    return L25_2
  else
    L24_2 = A0_2
    L23_2 = A0_2.destroyScreenshot
    L23_2(L24_2)
    L23_2 = nil
    return L23_2
  end
end
L7_1.takeObjectScreenshot = L8_1
L7_1 = furnitureCreator
function L8_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = A0_2.greenBox
  if L1_2 then
    L1_2 = DoesEntityExist
    L2_2 = A0_2.greenBox
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = DeleteEntity
      L2_2 = A0_2.greenBox
      L1_2(L2_2)
      A0_2.greenBox = nil
    end
  end
  L1_2 = A0_2.object
  if L1_2 then
    L1_2 = DoesEntityExist
    L2_2 = A0_2.object
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = DeleteEntity
      L2_2 = A0_2.object
      L1_2(L2_2)
      A0_2.object = nil
    end
  end
  L1_2 = A0_2.greenBoxCamera
  if L1_2 then
    L1_2 = Utils
    L1_2 = L1_2.DestroyFlyCam
    L2_2 = A0_2.greenBoxCamera
    L1_2(L2_2)
    A0_2.greenBoxCamera = nil
  end
  L1_2 = A0_2.initialPlayerCoords
  if L1_2 then
    L1_2 = SetEntityCoords
    L2_2 = cache
    L2_2 = L2_2.ped
    L3_2 = A0_2.initialPlayerCoords
    L3_2 = L3_2.x
    L4_2 = A0_2.initialPlayerCoords
    L4_2 = L4_2.y
    L5_2 = A0_2.initialPlayerCoords
    L5_2 = L5_2.z
    L6_2 = false
    L7_2 = false
    L8_2 = false
    L9_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    L1_2 = FreezeEntityPosition
    L2_2 = cache
    L2_2 = L2_2.ped
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = SetEntityAlpha
    L2_2 = cache
    L2_2 = L2_2.ped
    L3_2 = 255
    L4_2 = false
    L1_2(L2_2, L3_2, L4_2)
    A0_2.initialPlayerCoords = nil
  end
  A0_2.inGreenBox = false
end
L7_1.destroyScreenshot = L8_1
L7_1 = AddEventHandler
L8_1 = "onResourceStop"
function L9_1(A0_2)
  local L1_2, L2_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 == L1_2 then
    L1_2 = furnitureCreator
    L2_2 = L1_2
    L1_2 = L1_2.destroyScreenshot
    L1_2(L2_2)
  end
end
L7_1(L8_1, L9_1)






