





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1
L0_1 = IsDisabledControlJustPressed
L1_1 = IsDisabledControlPressed
L2_1 = DrawLine
L3_1 = DrawPoly
L4_1 = ActionControls
L5_1 = _G
L6_1 = {}
L7_1 = {}
L8_1 = {}
L8_1.ped = 17
L8_1.vehicle = 17
L8_1.object = 1
L7_1.flags = L8_1
L8_1 = {}
L9_1 = {}
L9_1.ped = "mp_m_freemode_01"
L9_1.vehicle = "t20"
L9_1.object = "prop_paper_bag_01"
L8_1.models = L9_1
L7_1.defaults = L8_1
L8_1 = {}
L8_1.ped = 1
L8_1.vehicle = 2
L8_1.object = 3
L7_1.entities = L8_1
L8_1 = Config
L8_1 = L8_1.MinPointLength
L7_1.minPointLength = L8_1
L7_1.height = 25.0
L8_1 = {}
L7_1.points = L8_1
L6_1.raycast = L7_1
L7_1 = {}
L6_1.temp = L7_1
L7_1 = {}
L7_1.isInShell = false
L7_1.initialPlayerCoords = nil
L7_1.initialCameraPos = nil
L6_1.photo = L7_1
L5_1.creator = L6_1
L5_1 = creator
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = A0_2.visible
  if not L1_2 then
    return
  end
  L1_2 = {}
  L2_2 = GetEntityCoords
  L3_2 = cache
  L3_2 = L3_2.ped
  L2_2 = L2_2(L3_2)
  L3_2 = pairs
  L4_2 = Config
  L4_2 = L4_2.Houses
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = L8_2.creator
    if L9_2 then
      L9_2 = L8_2.apartmentNumber
      if L9_2 then
        L9_2 = L8_2.apartmentNumber
        if "apt-0" ~= L9_2 then
      end
      else
        L9_2 = table
        L9_2 = L9_2.find
        L10_2 = HouseObjects
        function L11_2(A0_3)
          local L1_3, L2_3
          L1_3 = A0_3.house
          L2_3 = L7_2
          L1_3 = A0_3.isIsland
          L1_3 = L1_3 == L2_3 and L1_3
          return L1_3
        end
        L9_2 = L9_2(L10_2, L11_2)
        L10_2 = table
        L10_2 = L10_2.find
        L11_2 = HouseObjects
        function L12_2(A0_3)
          local L1_3, L2_3
          L1_3 = A0_3.house
          L2_3 = L7_2
          L1_3 = L1_3 == L2_3 and L1_3
          return L1_3
        end
        L10_2 = L10_2(L11_2, L12_2)
        L11_2 = nil
        L12_2 = L8_2.mlo
        if L12_2 then
          L11_2 = "mlo"
        else
          L12_2 = L8_2.ipl
          if L12_2 then
            L11_2 = "ipl"
          else
            L11_2 = "shell"
          end
        end
        L8_2.type = L11_2
        L8_2.name = L7_2
        L12_2 = {}
        if L9_2 then
          L13_2 = true
          if L13_2 then
            goto lbl_58
          end
        end
        L13_2 = false
        ::lbl_58::
        L12_2.enable = L13_2
        L13_2 = L9_2 or L13_2
        if L9_2 then
          L13_2 = {}
          L14_2 = L9_2.model
          L13_2.model = L14_2
          L14_2 = L9_2.coords
          L13_2.coords = L14_2
        end
        L12_2.data = L13_2
        L8_2.showOnMap = L12_2
        L12_2 = {}
        if L10_2 then
          L13_2 = true
          if L13_2 then
            goto lbl_77
          end
        end
        L13_2 = false
        ::lbl_77::
        L12_2.enable = L13_2
        L13_2 = L10_2 or L13_2
        if L10_2 then
          L13_2 = {}
          L14_2 = L10_2.model
          L13_2.model = L14_2
          L14_2 = L10_2.coords
          L13_2.coords = L14_2
        end
        L12_2.data = L13_2
        L8_2.island = L12_2
        L12_2 = L8_2.coords
        if L12_2 then
          L12_2 = L8_2.coords
          L12_2 = L12_2.enter
          if L12_2 then
            L12_2 = L8_2.coords
            L12_2 = L12_2.enter
            L13_2 = vector3
            L14_2 = L12_2.x
            L15_2 = L12_2.y
            L16_2 = L12_2.z
            L13_2 = L13_2(L14_2, L15_2, L16_2)
            L13_2 = L2_2 - L13_2
            L13_2 = #L13_2
            L8_2.distance = L13_2
        end
        else
          L8_2.distance = 999999.0
        end
        L12_2 = #L1_2
        L12_2 = L12_2 + 1
        L1_2[L12_2] = L8_2
      end
    end
  end
  L3_2 = SendReactMessage
  L4_2 = "toggle_creator"
  L5_2 = {}
  L5_2.visible = true
  L6_2 = {}
  L6_2.houses = L1_2
  L7_2 = A0_2.jobs
  L6_2.jobs = L7_2
  L7_2 = GetJobName
  L7_2 = L7_2()
  L6_2.job = L7_2
  L7_2 = Config
  L7_2 = L7_2.FurnitureShops
  L6_2.furnitureShops = L7_2
  L7_2 = A0_2.furnitureCategories
  L6_2.furnitureCategories = L7_2
  L5_2.data = L6_2
  L3_2(L4_2, L5_2)
end
L5_1.updateUI = L6_1
L5_1 = creator
function L6_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = A0_2.temp
  L1_2 = L1_2.island
  if L1_2 then
    L1_2 = DeleteEntity
    L2_2 = A0_2.temp
    L2_2 = L2_2.island
    L1_2(L2_2)
    L1_2 = A0_2.temp
    L1_2.island = nil
  end
  L1_2 = A0_2.temp
  L1_2 = L1_2.houseObject
  if L1_2 then
    L1_2 = DeleteEntity
    L2_2 = A0_2.temp
    L2_2 = L2_2.houseObject
    L1_2(L2_2)
    L1_2 = A0_2.temp
    L1_2.houseObject = nil
  end
  L1_2 = Debug
  L2_2 = "creator:destroyTemp"
  L3_2 = A0_2.temp
  L1_2(L2_2, L3_2)
end
L5_1.destroyTempEntities = L6_1
L5_1 = creator
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L2_2 = A0_2
  L1_2 = A0_2.destroyTempEntities
  L1_2(L2_2)
  L1_2 = A0_2.raycast
  L1_2 = L1_2.island
  if L1_2 then
    L1_2 = A0_2.temp
    L2_2 = SpawnHouseObject
    L3_2 = A0_2.raycast
    L3_2 = L3_2.island
    L3_2 = L3_2.model
    L4_2 = A0_2.raycast
    L4_2 = L4_2.island
    L4_2 = L4_2.coords
    L5_2 = A0_2.raycast
    L5_2 = L5_2.island
    L5_2 = L5_2.coords
    L5_2 = L5_2.w
    L2_2 = L2_2(L3_2, L4_2, L5_2)
    L1_2.island = L2_2
  end
  L1_2 = A0_2.raycast
  L1_2 = L1_2.houseObject
  if L1_2 then
    L1_2 = A0_2.temp
    L2_2 = SpawnHouseObject
    L3_2 = A0_2.raycast
    L3_2 = L3_2.houseObject
    L3_2 = L3_2.model
    L4_2 = A0_2.raycast
    L4_2 = L4_2.houseObject
    L4_2 = L4_2.coords
    L5_2 = A0_2.raycast
    L5_2 = L5_2.houseObject
    L5_2 = L5_2.coords
    L5_2 = L5_2.w
    L2_2 = L2_2(L3_2, L4_2, L5_2)
    L1_2.houseObject = L2_2
  end
  L1_2 = Debug
  L2_2 = "creator:spawnTempEntities"
  L3_2 = A0_2.temp
  L1_2(L2_2, L3_2)
end
L5_1.spawnTempEntities = L6_1
L5_1 = creator
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = raycast
  L1_2 = L1_2.active
  if L1_2 then
    L1_2 = Notification
    L2_2 = i18n
    L2_2 = L2_2.t
    L3_2 = "raycast.must_be_completed"
    L2_2 = L2_2(L3_2)
    L3_2 = "error"
    return L1_2(L2_2, L3_2)
  end
  L1_2 = A0_2.jobs
  if not L1_2 then
    L1_2 = lib
    L1_2 = L1_2.callback
    L1_2 = L1_2.await
    L2_2 = "housing:getCreatorData"
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    if not L1_2 then
      L2_2 = Error
      L3_2 = "creator:open"
      L4_2 = "No data returned from server. Did you follow the docs?"
      L5_2 = L1_2
      return L2_2(L3_2, L4_2, L5_2)
    end
    L2_2 = L1_2.jobs
    A0_2.jobs = L2_2
    L2_2 = L1_2.furnitureCategories
    A0_2.furnitureCategories = L2_2
  end
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
  L2_2 = "Creator opened"
  L1_2(L2_2)
end
L5_1.open = L6_1
L5_1 = creator
function L6_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = A0_2.visible
  if not L1_2 then
    return
  end
  A0_2.visible = false
  L1_2 = SendReactMessage
  L2_2 = "toggle_creator"
  L3_2 = {}
  L3_2.visible = false
  L1_2(L2_2, L3_2)
  L1_2 = ToggleHud
  L2_2 = true
  L1_2(L2_2)
  L1_2 = Debug
  L2_2 = "Creator closed"
  L1_2(L2_2)
end
L5_1.close = L6_1
L5_1 = RegisterCommand
L6_1 = "realestate"
function L7_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = IsNuiFocused
  L3_2 = L3_2()
  if L3_2 then
    return
  end
  L3_2 = lib
  L3_2 = L3_2.callback
  L3_2 = L3_2.await
  L4_2 = "housing:hasPermission"
  L5_2 = false
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L4_2 = Debug
    L5_2 = "You do not have isAdmin permissions"
    return L4_2(L5_2)
  end
  L4_2 = creator
  L5_2 = L4_2
  L4_2 = L4_2.open
  L4_2(L5_2)
end
L5_1(L6_1, L7_1)
L5_1 = Config
L5_1 = L5_1.OpenJobMenu
if L5_1 then
  L5_1 = RegisterKeyMapping
  L6_1 = "realestate"
  L7_1 = "Real estate menu"
  L8_1 = "keyboard"
  L9_1 = Config
  L9_1 = L9_1.OpenJobMenu
  L5_1(L6_1, L7_1, L8_1, L9_1)
end
L5_1 = creator
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = 0.0
  L3_2 = 1
  L4_2 = #A1_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = L6_2 + 1
    L7_2 = A1_2[L7_2]
    if not L7_2 then
      L7_2 = A1_2[1]
    end
    L8_2 = A1_2[L6_2]
    L8_2 = L8_2 - L7_2
    L8_2 = #L8_2
    L2_2 = L2_2 + L8_2
  end
  return L2_2
end
L5_1.getPointLength = L6_1
L5_1 = creator
function L6_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L4_2 = A0_2
  L3_2 = A0_2.getPointLength
  L5_2 = A2_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = #A2_2
  L4_2 = L4_2 >= 4
  if L4_2 then
    L5_2 = 0
    if L5_2 then
      goto lbl_19
    end
  end
  L5_2 = 255
  ::lbl_19::
  if L4_2 then
    L6_2 = 255
    if L6_2 then
      goto lbl_25
    end
  end
  L6_2 = 40
  ::lbl_25::
  if L4_2 then
    L7_2 = 0
    if L7_2 then
      goto lbl_31
    end
  end
  L7_2 = 24
  ::lbl_31::
  L8_2 = L3_1
  L9_2 = A1_2[1]
  L9_2 = L9_2.x
  L10_2 = A1_2[1]
  L10_2 = L10_2.y
  L11_2 = A1_2[1]
  L11_2 = L11_2.z
  L12_2 = A1_2[2]
  L12_2 = L12_2.x
  L13_2 = A1_2[2]
  L13_2 = L13_2.y
  L14_2 = A1_2[2]
  L14_2 = L14_2.z
  L15_2 = A1_2[3]
  L15_2 = L15_2.x
  L16_2 = A1_2[3]
  L16_2 = L16_2.y
  L17_2 = A1_2[3]
  L17_2 = L17_2.z
  L18_2 = L5_2
  L19_2 = L6_2
  L20_2 = L7_2
  L21_2 = 100
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
  L8_2 = L3_1
  L9_2 = A1_2[2]
  L9_2 = L9_2.x
  L10_2 = A1_2[2]
  L10_2 = L10_2.y
  L11_2 = A1_2[2]
  L11_2 = L11_2.z
  L12_2 = A1_2[1]
  L12_2 = L12_2.x
  L13_2 = A1_2[1]
  L13_2 = L13_2.y
  L14_2 = A1_2[1]
  L14_2 = L14_2.z
  L15_2 = A1_2[3]
  L15_2 = L15_2.x
  L16_2 = A1_2[3]
  L16_2 = L16_2.y
  L17_2 = A1_2[3]
  L17_2 = L17_2.z
  L18_2 = L5_2
  L19_2 = L6_2
  L20_2 = L7_2
  L21_2 = 100
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
  L8_2 = L3_1
  L9_2 = A1_2[1]
  L9_2 = L9_2.x
  L10_2 = A1_2[1]
  L10_2 = L10_2.y
  L11_2 = A1_2[1]
  L11_2 = L11_2.z
  L12_2 = A1_2[4]
  L12_2 = L12_2.x
  L13_2 = A1_2[4]
  L13_2 = L13_2.y
  L14_2 = A1_2[4]
  L14_2 = L14_2.z
  L15_2 = A1_2[3]
  L15_2 = L15_2.x
  L16_2 = A1_2[3]
  L16_2 = L16_2.y
  L17_2 = A1_2[3]
  L17_2 = L17_2.z
  L18_2 = L5_2
  L19_2 = L6_2
  L20_2 = L7_2
  L21_2 = 100
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
  L8_2 = L3_1
  L9_2 = A1_2[4]
  L9_2 = L9_2.x
  L10_2 = A1_2[4]
  L10_2 = L10_2.y
  L11_2 = A1_2[4]
  L11_2 = L11_2.z
  L12_2 = A1_2[1]
  L12_2 = L12_2.x
  L13_2 = A1_2[1]
  L13_2 = L13_2.y
  L14_2 = A1_2[1]
  L14_2 = L14_2.z
  L15_2 = A1_2[3]
  L15_2 = L15_2.x
  L16_2 = A1_2[3]
  L16_2 = L16_2.y
  L17_2 = A1_2[3]
  L17_2 = L17_2.z
  L18_2 = L5_2
  L19_2 = L6_2
  L20_2 = L7_2
  L21_2 = 100
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
end
L5_1.drawRectangle = L6_1
L5_1 = creator
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  L1_2 = vec
  L2_2 = 0
  L3_2 = 0
  L4_2 = A0_2.raycast
  L4_2 = L4_2.height
  L4_2 = L4_2 / 2
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  L2_2 = 1
  L3_2 = A0_2.raycast
  L3_2 = L3_2.points
  L3_2 = #L3_2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = A0_2.raycast
    L6_2 = L6_2.zCoords
    if not L6_2 then
      L6_2 = A0_2.raycast
      L6_2 = L6_2.points
      L6_2 = L6_2[L5_2]
      L6_2 = L6_2.z
    end
    L7_2 = A0_2.raycast
    L7_2 = L7_2.points
    L8_2 = vec
    L9_2 = A0_2.raycast
    L9_2 = L9_2.points
    L9_2 = L9_2[L5_2]
    L9_2 = L9_2.x
    L10_2 = A0_2.raycast
    L10_2 = L10_2.points
    L10_2 = L10_2[L5_2]
    L10_2 = L10_2.y
    L11_2 = L6_2
    L8_2 = L8_2(L9_2, L10_2, L11_2)
    L7_2[L5_2] = L8_2
    L7_2 = A0_2.raycast
    L7_2 = L7_2.points
    L7_2 = L7_2[L5_2]
    L7_2 = L7_2 + L1_2
    L8_2 = A0_2.raycast
    L8_2 = L8_2.points
    L8_2 = L8_2[L5_2]
    L8_2 = L8_2 - L1_2
    L9_2 = A0_2.raycast
    L9_2 = L9_2.points
    L10_2 = L5_2 + 1
    L9_2 = L9_2[L10_2]
    if L9_2 then
      L9_2 = vec
      L10_2 = A0_2.raycast
      L10_2 = L10_2.points
      L11_2 = L5_2 + 1
      L10_2 = L10_2[L11_2]
      L10_2 = L10_2.x
      L11_2 = A0_2.raycast
      L11_2 = L11_2.points
      L12_2 = L5_2 + 1
      L11_2 = L11_2[L12_2]
      L11_2 = L11_2.y
      L12_2 = L6_2
      L9_2 = L9_2(L10_2, L11_2, L12_2)
      if L9_2 then
        goto lbl_74
      end
    end
    L9_2 = A0_2.raycast
    L9_2 = L9_2.points
    L9_2 = L9_2[1]
    ::lbl_74::
    L9_2 = L9_2 + L1_2
    L10_2 = A0_2.raycast
    L10_2 = L10_2.points
    L11_2 = L5_2 + 1
    L10_2 = L10_2[L11_2]
    if L10_2 then
      L10_2 = vec
      L11_2 = A0_2.raycast
      L11_2 = L11_2.points
      L12_2 = L5_2 + 1
      L11_2 = L11_2[L12_2]
      L11_2 = L11_2.x
      L12_2 = A0_2.raycast
      L12_2 = L12_2.points
      L13_2 = L5_2 + 1
      L12_2 = L12_2[L13_2]
      L12_2 = L12_2.y
      L13_2 = L6_2
      L10_2 = L10_2(L11_2, L12_2, L13_2)
      if L10_2 then
        goto lbl_103
      end
    end
    L10_2 = A0_2.raycast
    L10_2 = L10_2.points
    L10_2 = L10_2[1]
    ::lbl_103::
    L10_2 = L10_2 - L1_2
    L11_2 = A0_2.raycast
    L11_2 = L11_2.points
    L11_2 = L11_2[L5_2]
    L12_2 = A0_2.raycast
    L12_2 = L12_2.points
    L13_2 = L5_2 + 1
    L12_2 = L12_2[L13_2]
    if L12_2 then
      L12_2 = vec
      L13_2 = A0_2.raycast
      L13_2 = L13_2.points
      L14_2 = L5_2 + 1
      L13_2 = L13_2[L14_2]
      L13_2 = L13_2.x
      L14_2 = A0_2.raycast
      L14_2 = L14_2.points
      L15_2 = L5_2 + 1
      L14_2 = L14_2[L15_2]
      L14_2 = L14_2.y
      L15_2 = L6_2
      L12_2 = L12_2(L13_2, L14_2, L15_2)
      if L12_2 then
        goto lbl_135
      end
    end
    L12_2 = A0_2.raycast
    L12_2 = L12_2.points
    L12_2 = L12_2[1]
    ::lbl_135::
    L13_2 = L2_1
    L14_2 = L7_2.x
    L15_2 = L7_2.y
    L16_2 = L7_2.z
    L17_2 = L8_2.x
    L18_2 = L8_2.y
    L19_2 = L8_2.z
    L20_2 = 255
    L21_2 = 42
    L22_2 = 24
    L23_2 = 225
    L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
    L13_2 = L2_1
    L14_2 = L7_2.x
    L15_2 = L7_2.y
    L16_2 = L7_2.z
    L17_2 = L9_2.x
    L18_2 = L9_2.y
    L19_2 = L9_2.z
    L20_2 = 255
    L21_2 = 42
    L22_2 = 24
    L23_2 = 225
    L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
    L13_2 = L2_1
    L14_2 = L8_2.x
    L15_2 = L8_2.y
    L16_2 = L8_2.z
    L17_2 = L10_2.x
    L18_2 = L10_2.y
    L19_2 = L10_2.z
    L20_2 = 255
    L21_2 = 42
    L22_2 = 24
    L23_2 = 225
    L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
    L13_2 = L2_1
    L14_2 = L11_2.x
    L15_2 = L11_2.y
    L16_2 = L11_2.z
    L17_2 = L12_2.x
    L18_2 = L12_2.y
    L19_2 = L12_2.z
    L20_2 = 255
    L21_2 = 42
    L22_2 = 24
    L23_2 = 225
    L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
    L14_2 = A0_2
    L13_2 = A0_2.drawRectangle
    L15_2 = {}
    L16_2 = L7_2
    L17_2 = L8_2
    L18_2 = L10_2
    L19_2 = L9_2
    L15_2[1] = L16_2
    L15_2[2] = L17_2
    L15_2[3] = L18_2
    L15_2[4] = L19_2
    L16_2 = A0_2.raycast
    L16_2 = L16_2.points
    L13_2(L14_2, L15_2, L16_2)
  end
end
L5_1.drawLines = L6_1
L5_1 = creator
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = pairs
  L3_2 = HouseZones
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L9_2 = L7_2
    L8_2 = L7_2.contains
    L10_2 = A1_2
    L8_2 = L8_2(L9_2, L10_2)
    if L8_2 then
      L8_2 = true
      return L8_2
    end
  end
  L2_2 = false
  return L2_2
end
L5_1.isPointInAnyZone = L6_1
L5_1 = creator
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = A0_2.raycast
  L2_2 = {}
  L1_2.points = L2_2
  L1_2 = GetEntityCoords
  L2_2 = cache
  L2_2 = L2_2.ped
  L1_2 = L1_2(L2_2)
  L2_2 = A0_2.raycast
  L3_2 = math
  L3_2 = L3_2.round
  L4_2 = L1_2.z
  L3_2 = L3_2(L4_2)
  L3_2 = L3_2 + 0.0
  L2_2.zCoords = L3_2
  L2_2 = A0_2.raycast
  L2_2.height = 25.0
  L2_2 = L4_1.leftClick
  L3_2 = i18n
  L3_2 = L3_2.t
  L4_2 = "creator.raycast.add_point"
  L3_2 = L3_2(L4_2)
  L2_2.label = L3_2
  L2_2 = L4_1.rotate_z_scroll
  L3_2 = i18n
  L3_2 = L3_2.t
  L4_2 = "creator.raycast.point_size"
  L3_2 = L3_2(L4_2)
  L2_2.label = L3_2
  L2_2 = Notification
  L3_2 = i18n
  L3_2 = L3_2.t
  L4_2 = "creator.raycast.info"
  L3_2 = L3_2(L4_2)
  L4_2 = "info"
  L2_2(L3_2, L4_2)
  L2_2 = raycast
  L3_2 = L2_2
  L2_2 = L2_2.freeCamera
  function L4_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    L1_3 = creator
    L2_3 = L1_3
    L1_3 = L1_3.drawLines
    L1_3(L2_3)
    L1_3 = L0_1
    L2_3 = 0
    L3_3 = L4_1.cancel
    L3_3 = L3_3.codes
    L3_3 = L3_3[1]
    L1_3 = L1_3(L2_3, L3_3)
    if not L1_3 then
      L1_3 = L0_1
      L2_3 = 0
      L3_3 = 322
      L1_3 = L1_3(L2_3, L3_3)
      if not L1_3 then
        goto lbl_20
      end
    end
    L2_3 = A0_3
    L1_3 = A0_3.destroy
    L1_3(L2_3)
    ::lbl_20::
    L1_3 = L0_1
    L2_3 = 0
    L3_3 = L4_1.done
    L3_3 = L3_3.codes
    L3_3 = L3_3[1]
    L1_3 = L1_3(L2_3, L3_3)
    if L1_3 then
      L1_3 = A0_2.raycast
      L1_3 = L1_3.points
      if not L1_3 then
        L1_3 = Notification
        L2_3 = i18n
        L2_3 = L2_3.t
        L3_3 = "creator.raycast.no_point_selected"
        L2_3 = L2_3(L3_3)
        L3_3 = "error"
        L1_3(L2_3, L3_3)
      else
        L2_3 = A0_3
        L1_3 = A0_3.destroy
        L1_3(L2_3)
      end
    end
    L1_3 = L0_1
    L2_3 = 0
    L3_3 = L4_1.leftClick
    L3_3 = L3_3.codes
    L3_3 = L3_3[1]
    L1_3 = L1_3(L2_3, L3_3)
    if L1_3 then
      L1_3 = A0_3.hit
      if L1_3 then
        L1_3 = A0_2
        L2_3 = L1_3
        L1_3 = L1_3.isPointInAnyZone
        L3_3 = A0_3.coords
        L1_3 = L1_3(L2_3, L3_3)
        if L1_3 then
          L1_3 = Notification
          L2_3 = i18n
          L2_3 = L2_3.t
          L3_3 = "creator.raycast.point_in_another_zone"
          L2_3 = L2_3(L3_3)
          L3_3 = "error"
          L1_3(L2_3, L3_3)
        else
          L1_3 = A0_2.raycast
          L1_3 = L1_3.points
          L2_3 = A0_2.raycast
          L2_3 = L2_3.points
          L2_3 = #L2_3
          L2_3 = L2_3 + 1
          L3_3 = vec3
          L4_3 = A0_3.coords
          L4_3 = L4_3.x
          L5_3 = A0_3.coords
          L5_3 = L5_3.y
          L6_3 = A0_3.coords
          L6_3 = L6_3.z
          L3_3 = L3_3(L4_3, L5_3, L6_3)
          L1_3[L2_3] = L3_3
        end
      end
    end
    L1_3 = L0_1
    L2_3 = 0
    L3_3 = L4_1.undo_point
    L3_3 = L3_3.codes
    L3_3 = L3_3[1]
    L1_3 = L1_3(L2_3, L3_3)
    if L1_3 then
      L1_3 = A0_2.raycast
      L1_3 = L1_3.points
      L1_3 = #L1_3
      if L1_3 > 0 then
        L1_3 = A0_2.raycast
        L1_3 = L1_3.points
        L2_3 = A0_2.raycast
        L2_3 = L2_3.points
        L2_3 = #L2_3
        L1_3[L2_3] = nil
      end
    end
    L1_3 = L1_1
    L2_3 = 0
    L3_3 = L4_1.boundary_height
    L3_3 = L3_3.codes
    L3_3 = L3_3[1]
    L1_3 = L1_3(L2_3, L3_3)
    if L1_3 then
      L1_3 = A0_2.raycast
      L2_3 = A0_2.raycast
      L2_3 = L2_3.height
      L3_3 = GetFrameTime
      L3_3 = L3_3()
      L3_3 = 15.0 * L3_3
      L2_3 = L2_3 + L3_3
      L1_3.height = L2_3
    else
      L1_3 = L1_1
      L2_3 = 0
      L3_3 = L4_1.boundary_height
      L3_3 = L3_3.codes
      L3_3 = L3_3[2]
      L1_3 = L1_3(L2_3, L3_3)
      if L1_3 then
        L1_3 = A0_2.raycast
        L2_3 = A0_2.raycast
        L2_3 = L2_3.height
        L3_3 = GetFrameTime
        L3_3 = L3_3()
        L3_3 = 15.0 * L3_3
        L2_3 = L2_3 - L3_3
        L1_3.height = L2_3
      end
    end
  end
  L5_2 = {}
  L6_2 = "done"
  L7_2 = "undo_point"
  L8_2 = "leftClick"
  L9_2 = "cancel"
  L10_2 = "boundary_height"
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L5_2[3] = L8_2
  L5_2[4] = L9_2
  L5_2[5] = L10_2
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = A0_2.raycast
  L2_2.zCoords = nil
  L2_2 = A0_2.raycast
  L2_2 = L2_2.points
  L2_2 = #L2_2
  if L2_2 < 4 then
    L2_2 = nil
    return L2_2
  end
  L2_2 = {}
  L3_2 = A0_2.raycast
  L3_2 = L3_2.points
  L2_2.points = L3_2
  L3_2 = A0_2.raycast
  L3_2 = L3_2.height
  L2_2.thickness = L3_2
  return L2_2
end
L5_1.raycastRectangle = L6_1
L5_1 = creator
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L2_2 = A0_2.raycast
  L2_2 = L2_2.points
  L3_2 = A0_2.raycast
  L3_2 = L3_2.height
  L3_2 = L3_2 / 2.4
  L4_2 = #L2_2
  if L4_2 < 3 then
    L4_2 = false
    return L4_2
  end
  L4_2 = L2_2[1]
  L4_2 = L4_2.z
  L5_2 = L2_2[1]
  L5_2 = L5_2.z
  L6_2 = 2
  L7_2 = #L2_2
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = L2_2[L9_2]
    L10_2 = L10_2.z
    if L4_2 > L10_2 then
      L4_2 = L10_2
    end
    if L5_2 < L10_2 then
      L5_2 = L10_2
    end
  end
  L6_2 = A1_2.z
  L7_2 = L4_2 - L3_2
  if not (L6_2 < L7_2) then
    L6_2 = A1_2.z
    L7_2 = L5_2 + L3_2
    if not (L6_2 > L7_2) then
      goto lbl_41
    end
  end
  L6_2 = false
  do return L6_2 end
  ::lbl_41::
  L6_2 = A1_2.x
  L7_2 = A1_2.y
  L8_2 = false
  L9_2 = 1
  L10_2 = #L2_2
  L11_2 = 1
  for L12_2 = L9_2, L10_2, L11_2 do
    L13_2 = L12_2 + 1
    L14_2 = #L2_2
    if L13_2 > L14_2 then
      L13_2 = 1
    end
    L14_2 = L2_2[L12_2]
    L14_2 = L14_2.x
    L15_2 = L2_2[L12_2]
    L15_2 = L15_2.y
    L16_2 = L2_2[L13_2]
    L16_2 = L16_2.x
    L17_2 = L2_2[L13_2]
    L17_2 = L17_2.y
    L18_2 = L7_2 < L15_2
    L19_2 = L7_2 < L17_2
    if L18_2 ~= L19_2 then
      L18_2 = L16_2 - L14_2
      L19_2 = L7_2 - L15_2
      L18_2 = L18_2 * L19_2
      L19_2 = L17_2 - L15_2
      L18_2 = L18_2 / L19_2
      L18_2 = L18_2 + L14_2
      if L6_2 < L18_2 then
        L8_2 = not L8_2
      end
    end
  end
  return L8_2
end
L5_1.isInPoints = L6_1
L5_1 = creator
function L6_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L4_2 = Debug
  L5_2 = "creator:selectPoint"
  L4_2(L5_2)
  L4_2 = A0_2.raycast
  L4_2 = L4_2.points
  L4_2 = #L4_2
  if 0 == L4_2 then
    L4_2 = A3_2 or L4_2
    if A3_2 then
      L4_2 = A3_2.externalUsage
    end
    if not L4_2 then
      L4_2 = Notification
      L5_2 = i18n
      L5_2 = L5_2.t
      L6_2 = "creator.no_points_selected"
      L5_2 = L5_2(L6_2)
      L6_2 = "error"
      return L4_2(L5_2, L6_2)
    end
  end
  if not A1_2 then
    A1_2 = "empty"
  end
  if not A2_2 then
    A2_2 = 1
  end
  if not A3_2 then
    L4_2 = {}
    A3_2 = L4_2
  end
  L4_2 = {}
  L5_2 = 0
  L6_2 = {}
  L7_2 = A3_2.points
  if not L7_2 then
    L7_2 = {}
  end
  A3_2.points = L7_2
  L7_2 = A0_2.raycast
  L7_2 = L7_2.flags
  L7_2 = L7_2[A1_2]
  if "empty" ~= A1_2 then
    L8_2 = A3_2.model
    if not L8_2 then
      L8_2 = creator
      L8_2 = L8_2.raycast
      L8_2 = L8_2.defaults
      L8_2 = L8_2.models
      L8_2 = L8_2[A1_2]
    end
    A3_2.model = L8_2
    L8_2 = lib
    L8_2 = L8_2.requestModel
    L9_2 = A3_2.model
    L10_2 = Config
    L10_2 = L10_2.DefaultRequestModelTimeout
    L8_2(L9_2, L10_2)
  end
  function L8_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    if not A0_3 then
      A0_3 = A3_2.model
    end
    if not A1_3 then
      L2_3 = vec4
      L3_3 = 0
      L4_3 = 0
      L5_3 = 0
      L6_3 = 0
      L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
      A1_3 = L2_3
    end
    L2_3 = nil
    L3_3 = A1_2
    if "empty" == L3_3 then
      return L2_3
    end
    L3_3 = A1_2
    if "ped" == L3_3 then
      L3_3 = CreatePed
      L4_3 = 28
      L5_3 = A0_3
      L6_3 = A1_3.x
      L7_3 = A1_3.y
      L8_3 = A1_3.z
      L9_3 = A1_3.w
      L10_3 = false
      L11_3 = false
      L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
      L2_3 = L3_3
    else
      L3_3 = A1_2
      if "vehicle" == L3_3 then
        L3_3 = CreateVehicle
        L4_3 = A0_3
        L5_3 = A1_3.x
        L6_3 = A1_3.y
        L7_3 = A1_3.z
        L8_3 = A1_3.w
        L9_3 = false
        L10_3 = true
        L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
        L2_3 = L3_3
      else
        L3_3 = A1_2
        if "object" == L3_3 then
          L3_3 = CreateObject
          L4_3 = A0_3
          L5_3 = A1_3.x
          L6_3 = A1_3.y
          L7_3 = A1_3.z
          L8_3 = false
          L9_3 = false
          L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
          L2_3 = L3_3
          L3_3 = A1_3.w
          if L3_3 then
            L3_3 = SetEntityHeading
            L4_3 = L2_3
            L5_3 = A1_3.w
            L3_3(L4_3, L5_3)
          end
        end
      end
    end
    L3_3 = Wait
    L4_3 = 0
    L3_3(L4_3)
    L3_3 = FreezeEntityPosition
    L4_3 = L2_3
    L5_3 = true
    L3_3(L4_3, L5_3)
    L3_3 = SetEntityInvincible
    L4_3 = L2_3
    L5_3 = true
    L3_3(L4_3, L5_3)
    return L2_3
  end
  function L9_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3
    L1_3 = A1_2
    if "ped" == L1_3 and A0_3 then
      L1_3 = DoesEntityExist
      L2_3 = A0_3
      L1_3 = L1_3(L2_3)
      if L1_3 then
        goto lbl_12
      end
    end
    do return end
    ::lbl_12::
    L1_3 = A3_2.ped
    if L1_3 then
      L1_3 = A3_2.ped
      L1_3 = L1_3.anim
      if L1_3 then
        L1_3 = A3_2.ped
        L1_3 = L1_3.anim
        L2_3 = L1_3.dict
        if L2_3 then
          L2_3 = L1_3.name
          if L2_3 then
            L2_3 = lib
            L2_3 = L2_3.requestAnimDict
            L3_3 = L1_3.dict
            L4_3 = 3000
            L2_3(L3_3, L4_3)
            L2_3 = TaskPlayAnim
            L3_3 = A0_3
            L4_3 = L1_3.dict
            L5_3 = L1_3.name
            L6_3 = 8.0
            L7_3 = -8.0
            L8_3 = -1
            L9_3 = 1
            L10_3 = 0
            L11_3 = false
            L12_3 = false
            L13_3 = false
            L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
          end
        end
      end
    end
    L1_3 = A3_2.ped
    if L1_3 then
      L1_3 = A3_2.ped
      L1_3 = L1_3.attachObject
      if L1_3 then
        L1_3 = A3_2.ped
        L1_3 = L1_3.attachObject
        L1_3 = L1_3.model
        if L1_3 then
          L1_3 = A3_2.ped
          L1_3 = L1_3.attachObject
          L2_3 = joaat
          L3_3 = L1_3.model
          L2_3 = L2_3(L3_3)
          L3_3 = lib
          L3_3 = L3_3.requestModel
          L4_3 = L2_3
          L5_3 = Config
          L5_3 = L5_3.DefaultRequestModelTimeout
          L3_3(L4_3, L5_3)
          L3_3 = GetEntityCoords
          L4_3 = A0_3
          L3_3 = L3_3(L4_3)
          L4_3 = CreateObject
          L5_3 = L2_3
          L6_3 = L3_3.x
          L7_3 = L3_3.y
          L8_3 = L3_3.z
          L9_3 = false
          L10_3 = false
          L11_3 = false
          L4_3 = L4_3(L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
          L5_3 = SetEntityAsMissionEntity
          L6_3 = L4_3
          L7_3 = true
          L8_3 = true
          L5_3(L6_3, L7_3, L8_3)
          L5_3 = SetEntityInvincible
          L6_3 = L4_3
          L7_3 = true
          L5_3(L6_3, L7_3)
          L5_3 = SetEntityCompletelyDisableCollision
          L6_3 = L4_3
          L7_3 = true
          L8_3 = false
          L5_3(L6_3, L7_3, L8_3)
          L5_3 = tonumber
          L6_3 = L1_3.bone
          L5_3 = L5_3(L6_3)
          if not L5_3 then
            L5_3 = 18905
          end
          L6_3 = vec3
          L7_3 = L1_3.pos
          L7_3 = L7_3.x
          L8_3 = L1_3.pos
          L8_3 = L8_3.y
          L9_3 = L1_3.pos
          L9_3 = L9_3.z
          L6_3 = L6_3(L7_3, L8_3, L9_3)
          L7_3 = vec3
          L8_3 = L1_3.rot
          L8_3 = L8_3.x
          L9_3 = L1_3.rot
          L9_3 = L9_3.y
          L10_3 = L1_3.rot
          L10_3 = L10_3.z
          L7_3 = L7_3(L8_3, L9_3, L10_3)
          L8_3 = AttachEntityToEntity
          L9_3 = L4_3
          L10_3 = A0_3
          L11_3 = GetPedBoneIndex
          L12_3 = A0_3
          L13_3 = L5_3
          L11_3 = L11_3(L12_3, L13_3)
          L12_3 = L6_3.x
          L13_3 = L6_3.y
          L14_3 = L6_3.z
          L15_3 = L7_3.x
          L16_3 = L7_3.y
          L17_3 = L7_3.z
          L18_3 = false
          L19_3 = false
          L20_3 = false
          L21_3 = false
          L22_3 = 2
          L23_3 = true
          L8_3(L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3)
          L8_3 = L6_2
          L8_3 = #L8_3
          L9_3 = L8_3 + 1
          L8_3 = L6_2
          L8_3[L9_3] = L4_3
          L8_3 = SetModelAsNoLongerNeeded
          L9_3 = L2_3
          L8_3(L9_3)
        end
      end
    end
  end
  L10_2 = L8_2
  L10_2 = L10_2()
  L11_2 = L9_2
  L12_2 = L10_2
  L11_2(L12_2)
  L11_2 = {}
  L12_2 = "leftClick"
  L11_2[1] = L12_2
  if "empty" ~= A1_2 then
    L12_2 = #L11_2
    L12_2 = L12_2 + 1
    L11_2[L12_2] = "rotate_z"
    L12_2 = pairs
    L13_2 = A3_2.points
    L12_2, L13_2, L14_2, L15_2 = L12_2(L13_2)
    for L16_2, L17_2 in L12_2, L13_2, L14_2, L15_2 do
      L18_2 = L17_2.model
      if L18_2 then
        L18_2 = lib
        L18_2 = L18_2.requestModel
        L19_2 = L17_2.model
        L20_2 = Config
        L20_2 = L20_2.DefaultRequestModelTimeout
        L18_2(L19_2, L20_2)
        L18_2 = L8_2
        L19_2 = joaat
        L20_2 = L17_2.model
        L19_2 = L19_2(L20_2)
        L20_2 = L17_2.coords
        L18_2 = L18_2(L19_2, L20_2)
        L17_2.handle = L18_2
        L18_2 = SetEntityDrawOutline
        L19_2 = L17_2.handle
        L20_2 = true
        L18_2(L19_2, L20_2)
        L18_2 = L17_2.coords
        L18_2 = L18_2.w
        if L18_2 then
          L18_2 = SetEntityHeading
          L19_2 = L17_2.handle
          L20_2 = L17_2.coords
          L20_2 = L20_2.w
          L18_2(L19_2, L20_2)
        end
      end
    end
  end
  L12_2 = L4_1.leftClick
  L13_2 = i18n
  L13_2 = L13_2.t
  L14_2 = "creator.raycast.add_point"
  L13_2 = L13_2(L14_2)
  L12_2.label = L13_2
  L12_2 = L4_1.rotate_z
  L13_2 = i18n
  L13_2 = L13_2.t
  L14_2 = "creator.raycast.rotate_z_scroll"
  L13_2 = L13_2(L14_2)
  L12_2.label = L13_2
  L12_2 = A3_2.freeCamera
  if L12_2 then
    L12_2 = raycast
    L12_2 = L12_2.freeCamera
    if L12_2 then
      goto lbl_138
    end
  end
  L12_2 = raycast
  L12_2 = L12_2.gameplayCamera
  ::lbl_138::
  L13_2 = L12_2
  L14_2 = raycast
  function L15_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3
    L1_3 = DisableControlAction
    L2_3 = 0
    L3_3 = 25
    L4_3 = true
    L1_3(L2_3, L3_3, L4_3)
    L1_3 = DisableControlAction
    L2_3 = 0
    L3_3 = 20
    L4_3 = true
    L1_3(L2_3, L3_3, L4_3)
    L1_3 = DisableControlAction
    L2_3 = 0
    L3_3 = 73
    L4_3 = true
    L1_3(L2_3, L3_3, L4_3)
    L1_3 = pairs
    L2_3 = A3_2.points
    L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3)
    for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
      L7_3 = DrawMarker
      L8_3 = 28
      L9_3 = L6_3.coords
      L9_3 = L9_3.x
      L10_3 = L6_3.coords
      L10_3 = L10_3.y
      L11_3 = L6_3.coords
      L11_3 = L11_3.z
      L12_3 = 0.0
      L13_3 = 0.0
      L14_3 = 0.0
      L15_3 = 0.0
      L16_3 = 0.0
      L17_3 = 0.0
      L18_3 = 0.2
      L19_3 = 0.2
      L20_3 = 0.2
      L21_3 = 255
      L22_3 = 42
      L23_3 = 24
      L24_3 = 100
      L25_3 = false
      L26_3 = false
      L27_3 = 0
      L28_3 = true
      L29_3 = false
      L30_3 = false
      L31_3 = false
      L7_3(L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3)
    end
    L1_3 = creator
    L2_3 = L1_3
    L1_3 = L1_3.drawLines
    L1_3(L2_3)
    L1_3 = A0_3.hit
    if not L1_3 then
      return
    end
    L1_3 = L10_2
    if L1_3 then
      L1_3 = A0_3.lastCoords
      L2_3 = A0_3.coords
      if L1_3 ~= L2_3 then
        L1_3 = SetEntityCoords
        L2_3 = L10_2
        L3_3 = A0_3.coords
        L3_3 = L3_3.x
        L4_3 = A0_3.coords
        L4_3 = L4_3.y
        L5_3 = A0_3.coords
        L5_3 = L5_3.z
        L6_3 = false
        L7_3 = false
        L8_3 = true
        L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3)
      end
    end
    L1_3 = L0_1
    L2_3 = 0
    L3_3 = 24
    L1_3 = L1_3(L2_3, L3_3)
    if L1_3 then
      L1_3 = creator
      L2_3 = L1_3
      L1_3 = L1_3.isInPoints
      L3_3 = A0_3.coords
      L1_3 = L1_3(L2_3, L3_3)
      if not L1_3 then
        L1_3 = A3_2
        if L1_3 then
          L1_3 = L1_3.externalUsage
        end
        if not L1_3 then
          L1_3 = Notification
          L2_3 = i18n
          L2_3 = L2_3.t
          L3_3 = "creator.raycast.not_in_points"
          L2_3 = L2_3(L3_3)
          L3_3 = "error"
          return L1_3(L2_3, L3_3)
        end
      end
      L1_3 = A3_2
      if L1_3 then
        L1_3 = L1_3.checkInside
      end
      if L1_3 then
        L1_3 = A3_2.checkInside
        L2_3 = A0_3.coords
        L1_3 = L1_3(L2_3)
        if not L1_3 then
          L1_3 = Notification
          L2_3 = i18n
          L2_3 = L2_3.t
          L3_3 = "creator.raycast.not_in_points"
          L2_3 = L2_3(L3_3)
          L3_3 = "error"
          return L1_3(L2_3, L3_3)
        end
      end
      L1_3 = vec3
      L2_3 = A0_3.coords
      L2_3 = L2_3.x
      L3_3 = A0_3.coords
      L3_3 = L3_3.y
      L4_3 = A0_3.coords
      L4_3 = L4_3.z
      L1_3 = L1_3(L2_3, L3_3, L4_3)
      L2_3 = nil
      L3_3 = A1_2
      if "empty" ~= L3_3 then
        L3_3 = GetEntityCoords
        L4_3 = L10_2
        L3_3 = L3_3(L4_3)
        L4_3 = GetEntityHeading
        L5_3 = L10_2
        L4_3 = L4_3(L5_3)
        L5_3 = vec4
        L6_3 = L3_3.x
        L7_3 = L3_3.y
        L8_3 = L3_3.z
        L9_3 = L4_3
        L5_3 = L5_3(L6_3, L7_3, L8_3, L9_3)
        L1_3 = L5_3
        L5_3 = L8_2
        L6_3 = nil
        L7_3 = L1_3
        L5_3 = L5_3(L6_3, L7_3)
        L2_3 = L5_3
        L5_3 = L9_2
        L6_3 = L2_3
        L5_3(L6_3)
        L5_3 = SetEntityAlpha
        L6_3 = L2_3
        L7_3 = 170
        L8_3 = false
        L5_3(L6_3, L7_3, L8_3)
      end
      L3_3 = L4_2
      L3_3 = #L3_3
      L4_3 = L3_3 + 1
      L3_3 = L4_2
      L5_3 = {}
      L5_3.coords = L1_3
      L5_3.handle = L2_3
      L3_3[L4_3] = L5_3
      L3_3 = L4_2
      L3_3 = #L3_3
      L4_3 = A2_2
      if L3_3 == L4_3 then
        L3_3 = Notification
        L4_3 = i18n
        L4_3 = L4_3.t
        L5_3 = "creator.raycast.completed"
        L4_3 = L4_3(L5_3)
        L5_3 = "info"
        L3_3(L4_3, L5_3)
        L4_3 = A0_3
        L3_3 = A0_3.destroy
        L3_3(L4_3)
      else
        L3_3 = Notification
        L4_3 = i18n
        L4_3 = L4_3.t
        L5_3 = "creator.raycast.selected_point"
        L6_3 = {}
        L7_3 = L4_2
        L7_3 = #L7_3
        L6_3.count = L7_3
        L4_3 = L4_3(L5_3, L6_3)
        L5_3 = "info"
        L3_3(L4_3, L5_3)
      end
    end
    L1_3 = A1_2
    if "empty" ~= L1_3 then
      L1_3 = L1_1
      L2_3 = 0
      L3_3 = 20
      L1_3 = L1_3(L2_3, L3_3)
      if L1_3 then
        L1_3 = L5_2
        L1_3 = L1_3 + 0.5
        L5_2 = L1_3
        L1_3 = L5_2
        L1_3 = L1_3 % 360
        L5_2 = L1_3
        L1_3 = SetEntityHeading
        L2_3 = L10_2
        L3_3 = L5_2
        L1_3(L2_3, L3_3)
      else
        L1_3 = L1_1
        L2_3 = 0
        L3_3 = 73
        L1_3 = L1_3(L2_3, L3_3)
        if L1_3 then
          L1_3 = L5_2
          L1_3 = L1_3 - 0.5
          L5_2 = L1_3
          L1_3 = L5_2
          L1_3 = L1_3 % 360
          L5_2 = L1_3
          L1_3 = SetEntityHeading
          L2_3 = L10_2
          L3_3 = L5_2
          L1_3(L2_3, L3_3)
        end
      end
    end
  end
  L16_2 = L11_2
  L17_2 = L7_2
  L18_2 = L10_2
  L13_2(L14_2, L15_2, L16_2, L17_2, L18_2)
  L13_2 = pairs
  L14_2 = L4_2
  L13_2, L14_2, L15_2, L16_2 = L13_2(L14_2)
  for L17_2, L18_2 in L13_2, L14_2, L15_2, L16_2 do
    L19_2 = L18_2.handle
    if L19_2 then
      L19_2 = DeleteEntity
      L20_2 = L18_2.handle
      L19_2(L20_2)
    end
  end
  L13_2 = pairs
  L14_2 = L6_2
  L13_2, L14_2, L15_2, L16_2 = L13_2(L14_2)
  for L17_2, L18_2 in L13_2, L14_2, L15_2, L16_2 do
    if L18_2 then
      L19_2 = DoesEntityExist
      L20_2 = L18_2
      L19_2 = L19_2(L20_2)
      if L19_2 then
        L19_2 = DeleteEntity
        L20_2 = L18_2
        L19_2(L20_2)
      end
    end
  end
  L13_2 = pairs
  L14_2 = A3_2.points
  L13_2, L14_2, L15_2, L16_2 = L13_2(L14_2)
  for L17_2, L18_2 in L13_2, L14_2, L15_2, L16_2 do
    L19_2 = L18_2.model
    if L19_2 then
      L19_2 = DeleteEntity
      L20_2 = L18_2.handle
      L19_2(L20_2)
      L19_2 = SetModelAsNoLongerNeeded
      L20_2 = L18_2.model
      L19_2(L20_2)
    end
  end
  L13_2 = Utils
  L13_2 = L13_2.RemoveInstructional
  L13_2()
  if L10_2 then
    L13_2 = DeleteEntity
    L14_2 = L10_2
    L13_2(L14_2)
    L13_2 = SetModelAsNoLongerNeeded
    L14_2 = A3_2.model
    L13_2(L14_2)
  end
  L13_2 = table
  L13_2 = L13_2.map
  L14_2 = L4_2
  function L15_2(A0_3)
    local L1_3
    L1_3 = A0_3.coords
    return L1_3
  end
  return L13_2(L14_2, L15_2)
end
L5_1.selectPoint = L6_1
L5_1 = creator
function L6_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L4_2 = A0_2.raycast
  L4_2 = L4_2.points
  L4_2 = #L4_2
  if 0 == L4_2 then
    L4_2 = Notification
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "creator.no_points_selected"
    L5_2 = L5_2(L6_2)
    L6_2 = "error"
    return L4_2(L5_2, L6_2)
  end
  L4_2 = assert
  L5_2 = A1_2
  L6_2 = "creator:selectEntity ::: entityType is required"
  L4_2(L5_2, L6_2)
  if not A2_2 then
    A2_2 = 1
  end
  if not A3_2 then
    L4_2 = {}
    A3_2 = L4_2
  end
  L4_2 = {}
  L5_2 = 0
  L6_2 = nil
  L7_2 = vec4
  L8_2 = 0
  L9_2 = 0
  L10_2 = 0
  L11_2 = 0
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
  L8_2 = L4_1.leftClick
  L9_2 = i18n
  L9_2 = L9_2.t
  L10_2 = "creator.raycast.select_entity"
  L9_2 = L9_2(L10_2)
  L8_2.label = L9_2
  L8_2 = A3_2.disabledEntities
  if not L8_2 then
    L8_2 = {}
  end
  A3_2.disabledEntities = L8_2
  L8_2 = {}
  L9_2 = "leftClick"
  L8_2[1] = L9_2
  L9_2 = pairs
  L10_2 = A3_2.disabledEntities
  L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
  for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
    L15_2 = SetEntityDrawOutline
    L16_2 = L14_2
    L17_2 = true
    L15_2(L16_2, L17_2)
  end
  L9_2 = A3_2.ped
  if L9_2 then
    L9_2 = lib
    L9_2 = L9_2.requestModel
    L10_2 = A3_2.ped
    L10_2 = L10_2.model
    L11_2 = Config
    L11_2 = L11_2.DefaultRequestModelTimeout
    L9_2(L10_2, L11_2)
    L9_2 = CreatePed
    L10_2 = 28
    L11_2 = A3_2.ped
    L11_2 = L11_2.model
    L12_2 = 0
    L13_2 = 0
    L14_2 = 0
    L15_2 = 0
    L16_2 = false
    L17_2 = false
    L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L6_2 = L9_2
    L9_2 = SetEntityVisible
    L10_2 = L6_2
    L11_2 = false
    L12_2 = false
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = SetEntityInvincible
    L10_2 = L6_2
    L11_2 = true
    L9_2(L10_2, L11_2)
    L9_2 = FreezeEntityPosition
    L10_2 = L6_2
    L11_2 = true
    L9_2(L10_2, L11_2)
    L9_2 = SetEntityCompletelyDisableCollision
    L10_2 = L6_2
    L11_2 = true
    L12_2 = false
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = A3_2.ped
    L9_2 = L9_2.anim
    L10_2 = lib
    L10_2 = L10_2.requestAnimDict
    L11_2 = L9_2.dict
    L12_2 = 3000
    L10_2(L11_2, L12_2)
    L10_2 = TaskPlayAnim
    L11_2 = L6_2
    L12_2 = L9_2.dict
    L13_2 = L9_2.name
    L14_2 = 8.0
    L15_2 = 1.0
    L16_2 = -1
    L17_2 = 1
    L18_2 = 0
    L19_2 = false
    L20_2 = false
    L21_2 = false
    L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
    L10_2 = RemoveAnimDict
    L11_2 = L9_2.dict
    L10_2(L11_2)
    L10_2 = A3_2.disabledEntities
    L11_2 = A3_2.disabledEntities
    L11_2 = #L11_2
    L11_2 = L11_2 + 1
    L10_2[L11_2] = L6_2
    L10_2 = #L8_2
    L10_2 = L10_2 + 1
    L8_2[L10_2] = "rotate_z"
    L10_2 = #L8_2
    L10_2 = L10_2 + 1
    L8_2[L10_2] = "offset_z"
  end
  L9_2 = Notification
  L10_2 = i18n
  L10_2 = L10_2.t
  L11_2 = "creator.raycast.select_entity_info"
  L12_2 = {}
  L12_2.entityType = A1_2
  L10_2 = L10_2(L11_2, L12_2)
  L11_2 = "info"
  L9_2(L10_2, L11_2)
  L9_2 = raycast
  L10_2 = L9_2
  L9_2 = L9_2.gameplayCamera
  function L11_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    L1_3 = DisableControlAction
    L2_3 = 0
    L3_3 = L4_1.rotate_z
    L3_3 = L3_3.codes
    L3_3 = L3_3[1]
    L4_3 = true
    L1_3(L2_3, L3_3, L4_3)
    L1_3 = DisableControlAction
    L2_3 = 0
    L3_3 = L4_1.rotate_z
    L3_3 = L3_3.codes
    L3_3 = L3_3[2]
    L4_3 = true
    L1_3(L2_3, L3_3, L4_3)
    L1_3 = DisableControlAction
    L2_3 = 0
    L3_3 = L4_1.offset_z
    L3_3 = L3_3.codes
    L3_3 = L3_3[1]
    L4_3 = true
    L1_3(L2_3, L3_3, L4_3)
    L1_3 = DisableControlAction
    L2_3 = 0
    L3_3 = L4_1.offset_z
    L3_3 = L3_3.codes
    L3_3 = L3_3[2]
    L4_3 = true
    L1_3(L2_3, L3_3, L4_3)
    L1_3 = creator
    L2_3 = L1_3
    L1_3 = L1_3.drawLines
    L1_3(L2_3)
    L1_3 = L6_2
    if L1_3 then
      L1_3 = Utils
      L1_3 = L1_3.DrawEntityBoundingBox
      L2_3 = L6_2
      L3_3 = 255
      L4_3 = 42
      L5_3 = 24
      L6_3 = 100
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3)
    end
    L1_3 = L5_2
    L2_3 = A0_3.entity
    L1_3 = L1_3 ~= L2_3
    if L1_3 then
      L2_3 = table
      L2_3 = L2_3.contains
      L3_3 = A3_2.disabledEntities
      L4_3 = L5_2
      L2_3 = L2_3(L3_3, L4_3)
      if not L2_3 then
        L2_3 = SetEntityDrawOutline
        L3_3 = L5_2
        L4_3 = false
        L2_3(L3_3, L4_3)
        L2_3 = L6_2
        if L2_3 then
          L2_3 = SetEntityVisible
          L3_3 = L6_2
          L4_3 = false
          L5_3 = false
          L2_3(L3_3, L4_3, L5_3)
        end
      end
    end
    L2_3 = A0_3.entity
    L5_2 = L2_3
    L2_3 = A0_3.hit
    if L2_3 then
      L2_3 = A0_3.entity
      if L2_3 then
        if L1_3 then
          L2_3 = table
          L2_3 = L2_3.contains
          L3_3 = A3_2.disabledEntities
          L4_3 = L5_2
          L2_3 = L2_3(L3_3, L4_3)
          if not L2_3 then
            L2_3 = SetEntityDrawOutline
            L3_3 = A0_3.entity
            L4_3 = true
            L2_3(L3_3, L4_3)
            L2_3 = L6_2
            if L2_3 then
              L2_3 = GetEntityCoords
              L3_3 = A0_3.entity
              L2_3 = L2_3(L3_3)
              L3_3 = L7_2.xyz
              L2_3 = L2_3 + L3_3
              L3_3 = SetEntityCoords
              L4_3 = L6_2
              L5_3 = L2_3.x
              L6_3 = L2_3.y
              L7_3 = L2_3.z
              L8_3 = false
              L9_3 = false
              L10_3 = false
              L11_3 = false
              L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
              L3_3 = SetEntityVisible
              L4_3 = L6_2
              L5_3 = true
              L6_3 = false
              L3_3(L4_3, L5_3, L6_3)
              L3_3 = SetEntityHeading
              L4_3 = L6_2
              L5_3 = GetEntityHeading
              L6_3 = A0_3.entity
              L5_3 = L5_3(L6_3)
              L6_3 = L7_2.w
              L5_3 = L5_3 + L6_3
              L3_3(L4_3, L5_3)
            end
          end
        end
        L2_3 = L6_2
        if L2_3 then
          L2_3 = L1_1
          L3_3 = 0
          L4_3 = L4_1.rotate_z
          L4_3 = L4_3.codes
          L4_3 = L4_3[1]
          L2_3 = L2_3(L3_3, L4_3)
          if L2_3 then
            L2_3 = L7_2
            L3_3 = vec4
            L4_3 = 0
            L5_3 = 0
            L6_3 = 0
            L7_3 = 0.5
            L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3)
            L2_3 = L2_3 + L3_3
            L7_2 = L2_3
            L2_3 = 0
            L5_2 = L2_3
          else
            L2_3 = L1_1
            L3_3 = 0
            L4_3 = L4_1.rotate_z
            L4_3 = L4_3.codes
            L4_3 = L4_3[2]
            L2_3 = L2_3(L3_3, L4_3)
            if L2_3 then
              L2_3 = L7_2
              L3_3 = vec4
              L4_3 = 0
              L5_3 = 0
              L6_3 = 0
              L7_3 = -0.5
              L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3)
              L2_3 = L2_3 + L3_3
              L7_2 = L2_3
              L2_3 = 0
              L5_2 = L2_3
            end
          end
          L2_3 = L1_1
          L3_3 = 0
          L4_3 = L4_1.offset_z
          L4_3 = L4_3.codes
          L4_3 = L4_3[1]
          L2_3 = L2_3(L3_3, L4_3)
          if L2_3 then
            L2_3 = L7_2
            L3_3 = vec4
            L4_3 = 0
            L5_3 = 0
            L6_3 = 0.005
            L7_3 = 0
            L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3)
            L2_3 = L2_3 + L3_3
            L7_2 = L2_3
            L2_3 = 0
            L5_2 = L2_3
          else
            L2_3 = L1_1
            L3_3 = 0
            L4_3 = L4_1.offset_z
            L4_3 = L4_3.codes
            L4_3 = L4_3[2]
            L2_3 = L2_3(L3_3, L4_3)
            if L2_3 then
              L2_3 = L7_2
              L3_3 = vec4
              L4_3 = 0
              L5_3 = 0
              L6_3 = -0.005
              L7_3 = 0
              L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3)
              L2_3 = L2_3 + L3_3
              L7_2 = L2_3
              L2_3 = 0
              L5_2 = L2_3
            end
          end
        end
        L2_3 = L0_1
        L3_3 = 0
        L4_3 = L4_1.leftClick
        L4_3 = L4_3.codes
        L4_3 = L4_3[1]
        L2_3 = L2_3(L3_3, L4_3)
        if L2_3 then
          L2_3 = creator
          L3_3 = L2_3
          L2_3 = L2_3.isInPoints
          L4_3 = GetEntityCoords
          L5_3 = A0_3.entity
          L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3 = L4_3(L5_3)
          L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
          if not L2_3 then
            L2_3 = Notification
            L3_3 = i18n
            L3_3 = L3_3.t
            L4_3 = "creator.raycast.not_in_points"
            L3_3 = L3_3(L4_3)
            L4_3 = "error"
            return L2_3(L3_3, L4_3)
          end
          L2_3 = table
          L2_3 = L2_3.contains
          L3_3 = A3_2.disabledEntities
          L4_3 = A0_3.entity
          L2_3 = L2_3(L3_3, L4_3)
          if L2_3 then
            L2_3 = Notification
            L3_3 = i18n
            L3_3 = L3_3.t
            L4_3 = "creator.raycast.entity_disabled"
            L3_3 = L3_3(L4_3)
            L4_3 = "error"
            return L2_3(L3_3, L4_3)
          end
          L2_3 = GetEntityCoords
          L3_3 = A0_3.entity
          L2_3 = L2_3(L3_3)
          L3_3 = GetEntityHeading
          L4_3 = A0_3.entity
          L3_3 = L3_3(L4_3)
          L4_3 = L4_2
          L4_3 = #L4_3
          L5_3 = L4_3 + 1
          L4_3 = L4_2
          L6_3 = {}
          L7_3 = A0_3.entity
          L6_3.entity = L7_3
          L7_3 = vec4
          L8_3 = L2_3.x
          L9_3 = L2_3.y
          L10_3 = L2_3.z
          L11_3 = L3_3
          L7_3 = L7_3(L8_3, L9_3, L10_3, L11_3)
          L8_3 = L7_2
          L7_3 = L7_3 + L8_3
          L6_3.coords = L7_3
          L4_3[L5_3] = L6_3
          L4_3 = L4_2
          L4_3 = #L4_3
          L5_3 = A2_2
          if L4_3 == L5_3 then
            L4_3 = Notification
            L5_3 = i18n
            L5_3 = L5_3.t
            L6_3 = "creator.raycast.completed"
            L5_3 = L5_3(L6_3)
            L6_3 = "info"
            L4_3(L5_3, L6_3)
            L5_3 = A0_3
            L4_3 = A0_3.destroy
            L4_3(L5_3)
          else
            L4_3 = Notification
            L5_3 = i18n
            L5_3 = L5_3.t
            L6_3 = "creator.raycast.selected_entity"
            L7_3 = {}
            L8_3 = L4_2
            L8_3 = #L8_3
            L7_3.count = L8_3
            L5_3 = L5_3(L6_3, L7_3)
            L6_3 = "info"
            L4_3(L5_3, L6_3)
          end
        end
      end
    end
  end
  L12_2 = L8_2
  L9_2(L10_2, L11_2, L12_2)
  L9_2 = SetEntityDrawOutline
  L10_2 = L5_2
  L11_2 = false
  L9_2(L10_2, L11_2)
  L9_2 = pairs
  L10_2 = A3_2.disabledEntities
  L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
  for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
    L15_2 = SetEntityDrawOutline
    L16_2 = L14_2
    L17_2 = false
    L15_2(L16_2, L17_2)
  end
  if L6_2 then
    L9_2 = DeleteEntity
    L10_2 = L6_2
    L9_2(L10_2)
    L9_2 = SetModelAsNoLongerNeeded
    L10_2 = A3_2.ped
    L10_2 = L10_2.model
    L9_2(L10_2)
  end
  L9_2 = #L4_2
  L9_2 = L4_2 or L9_2
  if not (L9_2 > 0) or not L4_2 then
    L9_2 = nil
  end
  return L9_2
end
L5_1.selectEntity = L6_1
L5_1 = creator
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = RayCastSelector
  L2_2 = "customHouse"
  L1_2, L2_2 = L1_2(L2_2)
  if not L1_2 or not L2_2 then
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "creator.no_points_selected"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    return L3_2(L4_2, L5_2)
  end
  L3_2 = {}
  L3_2.tier = L1_2
  L3_2.coords = L2_2
  return L3_2
end
L5_1.selectHouseObject = L6_1
L5_1 = creator
function L6_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2)
  local L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L7_2 = A0_2
  L6_2 = A0_2.spawnTempEntities
  L6_2(L7_2)
  L6_2 = DisplayRadar
  L7_2 = false
  L6_2(L7_2)
  L6_2 = A0_2.photo
  L7_2 = {}
  L7_2.name = A1_2
  L7_2.type = A2_2
  L7_2.tier = A3_2
  L7_2.shellCoords = A4_2
  L7_2.exitCoords = A5_2
  L6_2.houseData = L7_2
  L6_2 = A0_2.photo
  L7_2 = GetEntityCoords
  L8_2 = cache
  L8_2 = L8_2.ped
  L7_2 = L7_2(L8_2)
  L6_2.initialPlayerCoords = L7_2
  L6_2 = A0_2.photo
  L6_2.isInShell = false
  if "shell" == A2_2 and A3_2 and A4_2 then
    L6_2 = Config
    L6_2 = L6_2.Shells
    L6_2 = L6_2[A3_2]
    if L6_2 then
      L7_2 = lib
      L7_2 = L7_2.requestModel
      L8_2 = L6_2.model
      L9_2 = Config
      L9_2 = L9_2.DefaultRequestModelTimeout
      L7_2(L8_2, L9_2)
      L7_2 = CreateObject
      L8_2 = joaat
      L9_2 = L6_2.model
      L8_2 = L8_2(L9_2)
      L9_2 = A4_2.x
      L10_2 = A4_2.y
      L11_2 = A4_2.z
      L12_2 = false
      L13_2 = false
      L14_2 = false
      L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
      L8_2 = SetEntityHeading
      L9_2 = L7_2
      L10_2 = A4_2.h
      if not L10_2 then
        L10_2 = 0.0
      end
      L8_2(L9_2, L10_2)
      L8_2 = FreezeEntityPosition
      L9_2 = L7_2
      L10_2 = true
      L8_2(L9_2, L10_2)
      L8_2 = SetEntityCompletelyDisableCollision
      L9_2 = L7_2
      L10_2 = true
      L11_2 = false
      L8_2(L9_2, L10_2, L11_2)
      L8_2 = SetEntityInvincible
      L9_2 = L7_2
      L10_2 = true
      L8_2(L9_2, L10_2)
      L8_2 = SetModelAsNoLongerNeeded
      L9_2 = L6_2.model
      L8_2(L9_2)
      L8_2 = A0_2.photo
      L9_2 = {}
      L10_2 = {}
      L11_2 = L7_2
      L10_2[1] = L11_2
      L9_2.objects = L10_2
      L10_2 = L6_2.model
      L9_2.model = L10_2
      L8_2.shellData = L9_2
    end
  end
  L6_2 = creator
  L7_2 = L6_2
  L6_2 = L6_2.close
  L6_2(L7_2)
  L6_2 = SendReactMessage
  L7_2 = "toggle_photo_mode"
  L8_2 = {}
  L8_2.visible = true
  L6_2(L7_2, L8_2)
  L6_2 = nil
  L7_2 = raycast
  L8_2 = L7_2
  L7_2 = L7_2.freeCamera
  function L9_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    L1_3 = L0_1
    L2_3 = 0
    L3_3 = 191
    L1_3 = L1_3(L2_3, L3_3)
    if L1_3 then
      L1_3 = lib
      L1_3 = L1_3.callback
      L1_3 = L1_3.await
      L2_3 = "housing:getPresignedUrl"
      L3_3 = false
      L4_3 = "image"
      L1_3 = L1_3(L2_3, L3_3, L4_3)
      if not L1_3 then
        L2_3 = Notification
        L3_3 = i18n
        L3_3 = L3_3.t
        L4_3 = "creator.photos.token_not_set"
        L3_3 = L3_3(L4_3)
        L4_3 = "error"
        return L2_3(L3_3, L4_3)
      end
      L2_3 = SendReactMessage
      L3_3 = "toggle_photo_mode"
      L4_3 = {}
      L4_3.visible = true
      L4_3.loading = true
      L2_3(L3_3, L4_3)
      L2_3 = promise
      L2_3 = L2_3.new
      L2_3 = L2_3()
      L3_3 = exports
      L3_3 = L3_3["screenshot-basic"]
      L4_3 = L3_3
      L3_3 = L3_3.requestScreenshotUpload
      L5_3 = L1_3
      L6_3 = "file"
      function L7_3(A0_4)
        local L1_4, L2_4, L3_4, L4_4
        L1_4 = json
        L1_4 = L1_4.decode
        L2_4 = A0_4
        L1_4 = L1_4(L2_4)
        if L1_4 then
          L2_4 = L1_4.data
          if L2_4 then
            goto lbl_22
          end
        end
        L2_4 = L2_3
        L3_4 = L2_4
        L2_4 = L2_4.resolve
        L4_4 = false
        L2_4(L3_4, L4_4)
        L2_4 = Notification
        L3_4 = i18n
        L3_4 = L3_4.t
        L4_4 = "creator.photos.upload_failed"
        L3_4 = L3_4(L4_4)
        L4_4 = "error"
        do return L2_4(L3_4, L4_4) end
        ::lbl_22::
        L2_4 = L2_3
        L3_4 = L2_4
        L2_4 = L2_4.resolve
        L4_4 = L1_4.data
        L4_4 = L4_4.url
        L2_4(L3_4, L4_4)
        L2_4 = L1_4.data
        L2_4 = L2_4.url
        L6_2 = L2_4
      end
      L3_3(L4_3, L5_3, L6_3, L7_3)
      L3_3 = Citizen
      L3_3 = L3_3.Await
      L4_3 = L2_3
      L3_3(L4_3)
      L4_3 = A0_3
      L3_3 = A0_3.destroy
      L3_3(L4_3)
    end
    L1_3 = A2_2
    if "shell" == L1_3 then
      L1_3 = L0_1
      L2_3 = 0
      L3_3 = 23
      L1_3 = L1_3(L2_3, L3_3)
      if L1_3 then
        L1_3 = A0_2.photo
        L1_3 = L1_3.shellData
        if L1_3 then
          L1_3 = A5_2
          if L1_3 then
            L1_3 = A0_2.photo
            L1_3 = L1_3.isInShell
            if not L1_3 then
              L1_3 = vec3
              L2_3 = A5_2.x
              L3_3 = A5_2.y
              L4_3 = A5_2.z
              L1_3 = L1_3(L2_3, L3_3, L4_3)
              L2_3 = SetEntityCoords
              L3_3 = cache
              L3_3 = L3_3.ped
              L4_3 = L1_3.x
              L5_3 = L1_3.y
              L6_3 = L1_3.z
              L7_3 = false
              L8_3 = false
              L9_3 = false
              L10_3 = false
              L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
              L2_3 = SetEntityHeading
              L3_3 = cache
              L3_3 = L3_3.ped
              L4_3 = A5_2.w
              if not L4_3 then
                L4_3 = 0.0
              end
              L2_3(L3_3, L4_3)
              L2_3 = A0_3.camera
              if L2_3 then
                L2_3 = GetEntityMatrix
                L3_3 = cache
                L3_3 = L3_3.ped
                L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3)
                L6_3 = L4_3 * 2.0
                L7_3 = L1_3 + L6_3
                A0_3.camPos = L7_3
                L7_3 = SetCamCoord
                L8_3 = A0_3.camera
                L9_3 = A0_3.camPos
                L9_3 = L9_3.x
                L10_3 = A0_3.camPos
                L10_3 = L10_3.y
                L11_3 = A0_3.camPos
                L11_3 = L11_3.z
                L7_3(L8_3, L9_3, L10_3, L11_3)
              end
              L2_3 = A0_2.photo
              L2_3.isInShell = true
            else
              L1_3 = A0_2.photo
              L1_3 = L1_3.initialPlayerCoords
              if L1_3 then
                L2_3 = SetEntityCoords
                L3_3 = cache
                L3_3 = L3_3.ped
                L4_3 = L1_3.x
                L5_3 = L1_3.y
                L6_3 = L1_3.z
                L7_3 = false
                L8_3 = false
                L9_3 = false
                L10_3 = false
                L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
                L2_3 = A0_3.camera
                if L2_3 then
                  L2_3 = GetEntityMatrix
                  L3_3 = cache
                  L3_3 = L3_3.ped
                  L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3)
                  L6_3 = L4_3 * 2
                  L6_3 = L1_3 + L6_3
                  A0_3.camPos = L6_3
                  L6_3 = SetCamCoord
                  L7_3 = A0_3.camera
                  L8_3 = A0_3.camPos
                  L8_3 = L8_3.x
                  L9_3 = A0_3.camPos
                  L9_3 = L9_3.y
                  L10_3 = A0_3.camPos
                  L10_3 = L10_3.z
                  L6_3(L7_3, L8_3, L9_3, L10_3)
                end
              end
              L2_3 = A0_2.photo
              L2_3.isInShell = false
            end
          end
        end
      end
    end
    L1_3 = L0_1
    L2_3 = 0
    L3_3 = 322
    L1_3 = L1_3(L2_3, L3_3)
    if L1_3 then
      L2_3 = A0_3
      L1_3 = A0_3.destroy
      L1_3(L2_3)
    end
  end
  L10_2 = nil
  L11_2 = {}
  L11_2.line = false
  L11_2.scaleform = false
  L7_2(L8_2, L9_2, L10_2, L11_2)
  L8_2 = A0_2
  L7_2 = A0_2.destroyPhotoMode
  L7_2(L8_2)
  return L6_2
end
L5_1.startPhotoMode = L6_1
L5_1 = creator
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = A0_2.photo
  L1_2 = L1_2.isInShell
  if L1_2 then
    L1_2 = A0_2.photo
    L1_2 = L1_2.initialPlayerCoords
    if L1_2 then
      L1_2 = A0_2.photo
      L1_2 = L1_2.initialPlayerCoords
      L2_2 = SetEntityCoords
      L3_2 = cache
      L3_2 = L3_2.ped
      L4_2 = L1_2.x
      L5_2 = L1_2.y
      L6_2 = L1_2.z
      L7_2 = false
      L8_2 = false
      L9_2 = false
      L10_2 = false
      L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    end
  end
  L1_2 = A0_2.photo
  L1_2 = L1_2.shellData
  if L1_2 then
    L1_2 = A0_2.photo
    L1_2 = L1_2.shellData
    L1_2 = L1_2.objects
    if L1_2 then
      L1_2 = pairs
      L2_2 = A0_2.photo
      L2_2 = L2_2.shellData
      L2_2 = L2_2.objects
      L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
      for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
        L7_2 = DoesEntityExist
        L8_2 = L6_2
        L7_2 = L7_2(L8_2)
        if L7_2 then
          L7_2 = DeleteObject
          L8_2 = L6_2
          L7_2(L8_2)
        end
      end
      L1_2 = A0_2.photo
      L1_2.shellData = nil
    end
  end
  L1_2 = DisplayRadar
  L2_2 = true
  L1_2(L2_2)
  L1_2 = SendReactMessage
  L2_2 = "toggle_photo_mode"
  L3_2 = {}
  L3_2.visible = false
  L1_2(L2_2, L3_2)
  L1_2 = A0_2.photo
  L1_2.houseData = nil
  L1_2 = A0_2.photo
  L1_2.shellData = nil
  L1_2 = A0_2.photo
  L1_2.isInShell = false
  L1_2 = A0_2.photo
  L1_2.initialPlayerCoords = nil
  L1_2 = A0_2.photo
  L1_2.initialCameraPos = nil
  L2_2 = A0_2
  L1_2 = A0_2.destroyTempEntities
  L1_2(L2_2)
end
L5_1.destroyPhotoMode = L6_1
L5_1 = RegisterNUICallback
L6_1 = "creator_take_photo"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = A0_2.houseName
  L3_2 = A0_2.houseType
  L4_2 = A0_2.houseTier
  L5_2 = A0_2.shellCoords
  L6_2 = A0_2.exitCoords
  if not L2_2 then
    L7_2 = Notification
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "creator.photos.house_name_required"
    L8_2 = L8_2(L9_2)
    L9_2 = "error"
    L7_2(L8_2, L9_2)
    L7_2 = creator
    L8_2 = L7_2
    L7_2 = L7_2.open
    L7_2(L8_2)
    L7_2 = A1_2
    L8_2 = nil
    return L7_2(L8_2)
  end
  L7_2 = creator
  L8_2 = L7_2
  L7_2 = L7_2.startPhotoMode
  L9_2 = L2_2
  L10_2 = L3_2
  L11_2 = L4_2
  L12_2 = L5_2
  L13_2 = L6_2
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L8_2 = creator
  L9_2 = L8_2
  L8_2 = L8_2.open
  L8_2(L9_2)
  L8_2 = A1_2
  L9_2 = L7_2
  L8_2(L9_2)
end
L5_1(L6_1, L7_1)






