





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1
TestNotMLO = false
function L0_1(A0_2)
  local L1_2, L2_2
  L1_2 = math
  L1_2 = L1_2.floor
  L2_2 = A0_2 + 0.5
  return L1_2(L2_2)
end
ShowRoomDefaultCoords = false
ShowingHouse = false
function L1_1()
  local L0_2, L1_2, L2_2
  ShowingHouse = true
  L0_2 = Config
  L0_2 = L0_2.TestRemTime
  L0_2 = 60000 * L0_2
  L1_2 = CreateThread
  function L2_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    while true do
      L0_3 = ShowingHouse
      if not L0_3 then
        break
      end
      L0_3 = L0_2
      L0_3 = L0_3 / 1000
      L1_3 = DrawGenericText
      L2_3 = i18n
      L2_3 = L2_3.t
      L3_3 = "drawtext.visit_time"
      L4_3 = {}
      L5_3 = L0_1
      L6_3 = L0_3
      L5_3 = L5_3(L6_3)
      L4_3.time = L5_3
      L2_3, L3_3, L4_3, L5_3, L6_3 = L2_3(L3_3, L4_3)
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3)
      L1_3 = IsControlJustPressed
      L2_3 = 0
      L3_3 = Keys
      L3_3 = L3_3.G
      L1_3 = L1_3(L2_3, L3_3)
      if L1_3 then
        L1_3 = 1000
        L0_2 = L1_3
      end
      L1_3 = Wait
      L2_3 = 0
      L1_3(L2_3)
    end
  end
  L1_2(L2_2)
  L1_2 = CreateThread
  function L2_2()
    local L0_3, L1_3, L2_3
    while true do
      L0_3 = ShowingHouse
      if not L0_3 then
        break
      end
      L0_3 = L0_2
      L0_3 = L0_3 - 1000
      L0_2 = L0_3
      L0_3 = L0_2
      if L0_3 <= 0 then
        L0_3 = Notification
        L1_3 = i18n
        L1_3 = L1_3.t
        L2_3 = "visit_ended"
        L1_3 = L1_3(L2_3)
        L2_3 = "info"
        L0_3(L1_3, L2_3)
        L0_3 = TestNotMLO
        if not L0_3 then
          L0_3 = DoScreenFadeOut
          L1_3 = 500
          L0_3(L1_3)
          L0_3 = Wait
          L1_3 = 500
          L0_3(L1_3)
          L0_3 = SetEntityCoords
          L1_3 = cache
          L1_3 = L1_3.ped
          L2_3 = ShowRoomDefaultCoords
          L0_3(L1_3, L2_3)
          ShowingHouse = false
          L0_3 = Wait
          L1_3 = 1000
          L0_3(L1_3)
          L0_3 = DoScreenFadeIn
          L1_3 = 500
          L0_3(L1_3)
        else
          L0_3 = Config
          L0_3 = L0_3.Houses
          L1_3 = EnteredHouse
          L0_3 = L0_3[L1_3]
          L0_3 = L0_3.ipl
          if L0_3 then
            L0_3 = LeaveIplHouse
            L1_3 = EnteredHouse
            L2_3 = true
            L0_3(L1_3, L2_3)
          else
            L0_3 = LeaveHouse
            L0_3()
          end
        end
      end
      L0_3 = Wait
      L1_3 = 1000
      L0_3(L1_3)
    end
  end
  L1_2(L2_2)
end
ShowRoomLoop = L1_1
L1_1 = i18n
L1_1 = L1_1.t
L2_1 = "drawtext.furniture_data_event"
L1_1 = L1_1(L2_1)
L2_1 = i18n
L2_1 = L2_1.t
L3_1 = "drawtext.stash"
L2_1 = L2_1(L3_1)
L3_1 = i18n
L3_1 = L3_1.t
L4_1 = "drawtext.vault_access"
L3_1 = L3_1(L4_1)
L4_1 = i18n
L4_1 = L4_1.t
L5_1 = "drawtext.wardrobe"
L4_1 = L4_1(L5_1)
L5_1 = i18n
L5_1 = L5_1.t
L6_1 = "drawtext.delete_illegal"
L5_1 = L5_1(L6_1)
L6_1 = i18n
L6_1 = L6_1.t
L7_1 = "drawtext.cooking"
L6_1 = L6_1(L7_1)
L7_1 = i18n
L7_1 = L7_1.t
L8_1 = "drawtext.sink"
L7_1 = L7_1(L8_1)
L8_1 = i18n
L8_1 = L8_1.t
L9_1 = "drawtext.toilet"
L8_1 = L8_1(L9_1)
L9_1 = i18n
L9_1 = L9_1.t
L10_1 = "drawtext.bathtub"
L9_1 = L9_1(L10_1)
L10_1 = i18n
L10_1 = L10_1.t
L11_1 = "drawtext.shower"
L10_1 = L10_1(L11_1)
L11_1 = i18n
L11_1 = L11_1.t
L12_1 = "drawtext.steal_furniture"
L11_1 = L11_1(L12_1)
function L12_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L1_2 = Config
  L1_2 = L1_2.Furniture
  if not L1_2 then
    L1_2 = false
    return L1_2
  end
  L1_2 = pairs
  L2_2 = Config
  L2_2 = L2_2.Furniture
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    if "navigation" ~= L5_2 then
      L7_2 = L6_2.items
      if L7_2 then
        L7_2 = pairs
        L8_2 = L6_2.items
        L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
        for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
          L13_2 = L12_2.object
          if L13_2 == A0_2 then
            L13_2 = L12_2.cooker
            if L13_2 then
              L13_2 = true
              return L13_2
            end
          end
          L13_2 = L12_2.colors
          if L13_2 then
            L13_2 = pairs
            L14_2 = L12_2.colors
            L13_2, L14_2, L15_2, L16_2 = L13_2(L14_2)
            for L17_2, L18_2 in L13_2, L14_2, L15_2, L16_2 do
              L19_2 = L18_2.object
              if L19_2 == A0_2 then
                L19_2 = L12_2.cooker
                if L19_2 then
                  L19_2 = true
                  return L19_2
                end
              end
            end
          end
        end
      end
    end
  end
  L1_2 = false
  return L1_2
end
function L13_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L1_2 = Config
  L1_2 = L1_2.Furniture
  if not L1_2 then
    L1_2 = nil
    return L1_2
  end
  L1_2 = pairs
  L2_2 = Config
  L2_2 = L2_2.Furniture
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    if "navigation" ~= L5_2 then
      L7_2 = L6_2.items
      if L7_2 then
        L7_2 = pairs
        L8_2 = L6_2.items
        L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
        for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
          L13_2 = L12_2.object
          if L13_2 == A0_2 then
            L13_2 = L12_2.sink
            if L13_2 then
              L13_2 = L12_2.sink
              return L13_2
            end
          end
          L13_2 = L12_2.colors
          if L13_2 then
            L13_2 = pairs
            L14_2 = L12_2.colors
            L13_2, L14_2, L15_2, L16_2 = L13_2(L14_2)
            for L17_2, L18_2 in L13_2, L14_2, L15_2, L16_2 do
              L19_2 = L18_2.object
              if L19_2 == A0_2 then
                L19_2 = L12_2.sink
                if L19_2 then
                  L19_2 = L12_2.sink
                  return L19_2
                end
              end
            end
          end
        end
      end
    end
  end
  L1_2 = nil
  return L1_2
end
GetSinkData = L13_1
function L13_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L1_2 = Config
  L1_2 = L1_2.Furniture
  if not L1_2 then
    L1_2 = nil
    return L1_2
  end
  L1_2 = pairs
  L2_2 = Config
  L2_2 = L2_2.Furniture
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    if "navigation" ~= L5_2 then
      L7_2 = L6_2.items
      if L7_2 then
        L7_2 = pairs
        L8_2 = L6_2.items
        L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
        for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
          L13_2 = L12_2.object
          if L13_2 == A0_2 then
            L13_2 = L12_2.bath
            if L13_2 then
              L13_2 = L12_2.bath
              return L13_2
            end
          end
          L13_2 = L12_2.colors
          if L13_2 then
            L13_2 = pairs
            L14_2 = L12_2.colors
            L13_2, L14_2, L15_2, L16_2 = L13_2(L14_2)
            for L17_2, L18_2 in L13_2, L14_2, L15_2, L16_2 do
              L19_2 = L18_2.object
              if L19_2 == A0_2 then
                L19_2 = L12_2.bath
                if L19_2 then
                  L19_2 = L12_2.bath
                  return L19_2
                end
              end
            end
          end
        end
      end
    end
  end
  L1_2 = nil
  return L1_2
end
GetBathData = L13_1
function L13_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L1_2 = Config
  L1_2 = L1_2.Furniture
  if not L1_2 then
    L1_2 = nil
    return L1_2
  end
  L1_2 = pairs
  L2_2 = Config
  L2_2 = L2_2.Furniture
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    if "navigation" ~= L5_2 then
      L7_2 = L6_2.items
      if L7_2 then
        L7_2 = pairs
        L8_2 = L6_2.items
        L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
        for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
          L13_2 = L12_2.object
          if L13_2 == A0_2 then
            L13_2 = L12_2.toilet
            if L13_2 then
              L13_2 = L12_2.toilet
              return L13_2
            end
          end
          L13_2 = L12_2.colors
          if L13_2 then
            L13_2 = pairs
            L14_2 = L12_2.colors
            L13_2, L14_2, L15_2, L16_2 = L13_2(L14_2)
            for L17_2, L18_2 in L13_2, L14_2, L15_2, L16_2 do
              L19_2 = L18_2.object
              if L19_2 == A0_2 then
                L19_2 = L12_2.toilet
                if L19_2 then
                  L19_2 = L12_2.toilet
                  return L19_2
                end
              end
            end
          end
        end
      end
    end
  end
  L1_2 = nil
  return L1_2
end
GetToiletData = L13_1
function L13_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2
  L0_2 = nil
  L1_2 = GetEntityCoords
  L2_2 = cache
  L2_2 = L2_2.ped
  L1_2 = L1_2(L2_2)
  L2_2 = CurrentHouse
  L3_2 = table
  L3_2 = L3_2.contains
  L4_2 = Config
  L4_2 = L4_2.PoliceJobs
  L5_2 = GetJobName
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2 = L5_2()
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2)
  L4_2 = Config
  L4_2 = L4_2.Houses
  L4_2 = L4_2[L2_2]
  if L2_2 then
    L5_2 = decorate
    L5_2 = L5_2.objects
    if L5_2 then
      L5_2 = pairs
      L6_2 = decorate
      L6_2 = L6_2.objects
      L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
      for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
        L11_2 = vec3
        L12_2 = L10_2.coords
        L12_2 = L12_2.x
        L13_2 = L10_2.coords
        L13_2 = L13_2.y
        L14_2 = L10_2.coords
        L14_2 = L14_2.z
        L11_2 = L11_2(L12_2, L13_2, L14_2)
        L12_2 = L11_2 - L1_2
        L12_2 = #L12_2
        if L12_2 <= 2.0 then
          L12_2 = Config
          L12_2 = L12_2.DynamicFurnitures
          L13_2 = L10_2.modelName
          L12_2 = L12_2[L13_2]
          L13_2 = Config
          L13_2 = L13_2.IllegalFurnitures
          L14_2 = L10_2.modelName
          L13_2 = L13_2[L14_2]
          L14_2 = L12_1
          L15_2 = L10_2.modelName
          L14_2 = L14_2(L15_2)
          L15_2 = GetSinkData
          L16_2 = L10_2.modelName
          L15_2 = L15_2(L16_2)
          L16_2 = GetBathData
          L17_2 = L10_2.modelName
          L16_2 = L16_2(L17_2)
          L17_2 = GetToiletData
          L18_2 = L10_2.modelName
          L17_2 = L17_2(L18_2)
          if L14_2 then
            L18_2 = L10_2.handle
            if L18_2 then
              L18_2 = DoesEntityExist
              L19_2 = L10_2.handle
              L18_2 = L18_2(L19_2)
              if L18_2 then
                L18_2 = GetOffsetFromEntityInWorldCoords
                L19_2 = L10_2.handle
                L20_2 = 0.0
                L21_2 = 0.0
                L22_2 = 0.3
                L18_2 = L18_2(L19_2, L20_2, L21_2, L22_2)
                L0_2 = 0
                L19_2 = DrawText3D
                L20_2 = L18_2.x
                L21_2 = L18_2.y
                L22_2 = L18_2.z
                L23_2 = L6_1
                L24_2 = "cooking_interaction"
                L25_2 = "E"
                L19_2(L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
                L19_2 = IsControlJustPressed
                L20_2 = 0
                L21_2 = Keys
                L21_2 = L21_2.E
                L19_2 = L19_2(L20_2, L21_2)
                if L19_2 then
                  L19_2 = common
                  L20_2 = L19_2
                  L19_2 = L19_2.openCooking
                  L21_2 = Config
                  L21_2 = L21_2.CookingRecipes
                  L19_2(L20_2, L21_2)
                end
              end
            end
          end
          if L15_2 then
            L18_2 = L10_2.handle
            if L18_2 then
              L18_2 = DoesEntityExist
              L19_2 = L10_2.handle
              L18_2 = L18_2(L19_2)
              if L18_2 then
                L18_2 = GetOffsetFromEntityInWorldCoords
                L19_2 = L10_2.handle
                L20_2 = 0.0
                L21_2 = 0.0
                L22_2 = 0.3
                L18_2 = L18_2(L19_2, L20_2, L21_2, L22_2)
                L0_2 = 0
                L19_2 = DrawText3D
                L20_2 = L18_2.x
                L21_2 = L18_2.y
                L22_2 = L18_2.z
                L23_2 = L7_1
                L24_2 = "sink_interaction"
                L25_2 = "E"
                L19_2(L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
                L19_2 = IsControlJustPressed
                L20_2 = 0
                L21_2 = Keys
                L21_2 = L21_2.E
                L19_2 = L19_2(L20_2, L21_2)
                if L19_2 then
                  L19_2 = common
                  L20_2 = L19_2
                  L19_2 = L19_2.useSink
                  L21_2 = L10_2.handle
                  L22_2 = L15_2
                  L19_2(L20_2, L21_2, L22_2)
                end
              end
            end
          end
          if L16_2 then
            L18_2 = L10_2.handle
            if L18_2 then
              L18_2 = DoesEntityExist
              L19_2 = L10_2.handle
              L18_2 = L18_2(L19_2)
              if L18_2 then
                L18_2 = GetOffsetFromEntityInWorldCoords
                L19_2 = L10_2.handle
                L20_2 = 0.0
                L21_2 = 0.0
                L22_2 = 0.3
                L18_2 = L18_2(L19_2, L20_2, L21_2, L22_2)
                L0_2 = 0
                L19_2 = i18n
                L19_2 = L19_2.t
                L20_2 = "drawtext.bathtub_exit"
                L19_2 = L19_2(L20_2)
                L20_2 = common
                L20_2 = L20_2.bathtub
                L20_2 = L20_2.isInBathtub
                L20_2 = L19_2 or L20_2
                if not L20_2 or not L19_2 then
                  L20_2 = L9_1
                end
                L21_2 = DrawText3D
                L22_2 = L18_2.x
                L23_2 = L18_2.y
                L24_2 = L18_2.z
                L25_2 = L20_2
                L26_2 = "bathtub_interaction"
                L27_2 = "E"
                L21_2(L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
                L21_2 = IsControlJustPressed
                L22_2 = 0
                L23_2 = Keys
                L23_2 = L23_2.E
                L21_2 = L21_2(L22_2, L23_2)
                if L21_2 then
                  L21_2 = common
                  L22_2 = L21_2
                  L21_2 = L21_2.useBathtub
                  L23_2 = L10_2.handle
                  L24_2 = L16_2
                  L21_2(L22_2, L23_2, L24_2)
                end
              end
            end
          end
          if L17_2 then
            L18_2 = L10_2.handle
            if L18_2 then
              L18_2 = DoesEntityExist
              L19_2 = L10_2.handle
              L18_2 = L18_2(L19_2)
              if L18_2 then
                L18_2 = GetOffsetFromEntityInWorldCoords
                L19_2 = L10_2.handle
                L20_2 = 0.0
                L21_2 = 0.0
                L22_2 = 0.3
                L18_2 = L18_2(L19_2, L20_2, L21_2, L22_2)
                L0_2 = 0
                L19_2 = DrawText3D
                L20_2 = L18_2.x
                L21_2 = L18_2.y
                L22_2 = L18_2.z
                L23_2 = L8_1
                L24_2 = "toilet_interaction"
                L25_2 = "E"
                L19_2(L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
                L19_2 = IsControlJustPressed
                L20_2 = 0
                L21_2 = Keys
                L21_2 = L21_2.E
                L19_2 = L19_2(L20_2, L21_2)
                if L19_2 then
                  L19_2 = common
                  L20_2 = L19_2
                  L19_2 = L19_2.useToilet
                  L21_2 = L10_2.handle
                  L22_2 = L17_2
                  L19_2(L20_2, L21_2, L22_2)
                end
              end
            end
          end
          if L12_2 then
            L18_2 = L12_2.offset
            if L18_2 then
              L18_2 = GetOffsetFromEntityInWorldCoords
              L19_2 = L10_2.handle
              L20_2 = L12_2.offset
              L20_2 = L20_2.x
              L21_2 = L12_2.offset
              L21_2 = L21_2.y
              L22_2 = L12_2.offset
              L22_2 = L22_2.z
              L18_2 = L18_2(L19_2, L20_2, L21_2, L22_2)
              L19_2 = L12_2.event
              if L19_2 then
                L0_2 = 0
                L19_2 = DrawText3D
                L20_2 = L18_2.x
                L21_2 = L18_2.y
                L22_2 = L18_2.z
                L23_2 = L1_1
                L24_2 = "interactorid"
                L25_2 = "E"
                L19_2(L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
                L19_2 = IsControlJustPressed
                L20_2 = 0
                L21_2 = Keys
                L21_2 = L21_2.E
                L19_2 = L19_2(L20_2, L21_2)
                if L19_2 then
                  L19_2 = L10_2.uniq
                  L20_2 = TriggerEvent
                  L21_2 = L12_2.event
                  L22_2 = L19_2
                  L20_2(L21_2, L22_2)
                end
              else
                L19_2 = L12_2.type
                if "stash" == L19_2 then
                  L0_2 = 0
                  L19_2 = DrawText3D
                  L20_2 = L18_2.x
                  L21_2 = L18_2.y
                  L22_2 = L18_2.z
                  L23_2 = L2_1
                  L24_2 = "stash_access"
                  L25_2 = "E"
                  L19_2(L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
                  L19_2 = table
                  L19_2 = L19_2.includes
                  L20_2 = L4_2.upgrades
                  L21_2 = "vault"
                  L19_2 = L19_2(L20_2, L21_2)
                  if L19_2 then
                    L19_2 = CurrentHouseData
                    L19_2 = L19_2.isOfficialOwner
                    if L19_2 then
                      L19_2 = DrawText3D
                      L20_2 = L18_2.x
                      L21_2 = L18_2.y
                      L22_2 = L18_2.z
                      L22_2 = L22_2 + 0.4
                      L23_2 = L3_1
                      L24_2 = "bault_access"
                      L25_2 = "G"
                      L19_2(L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
                      L19_2 = IsControlJustPressed
                      L20_2 = 0
                      L21_2 = Keys
                      L21_2 = L21_2.G
                      L19_2 = L19_2(L20_2, L21_2)
                      if L19_2 then
                        L19_2 = OpenVaultCodeMenu
                        L20_2 = L10_2.id
                        L19_2(L20_2)
                      end
                    end
                  end
                  L19_2 = IsControlJustPressed
                  L20_2 = 0
                  L21_2 = Keys
                  L21_2 = L21_2.E
                  L19_2 = L19_2(L20_2, L21_2)
                  if L19_2 then
                    L19_2 = GetFurnitureStorageId
                    L20_2 = L10_2.id
                    L19_2 = L19_2(L20_2)
                    if L19_2 then
                      L20_2 = CanAccessStash
                      L21_2 = L10_2.id
                      L20_2 = L20_2(L21_2)
                      if L20_2 then
                        L20_2 = Debug
                        L21_2 = "stashKey"
                        L22_2 = L19_2
                        L20_2(L21_2, L22_2)
                        L20_2 = openStash
                        L21_2 = L12_2.stash
                        L22_2 = L19_2
                        L20_2(L21_2, L22_2)
                      end
                    end
                  end
                else
                  L19_2 = L12_2.type
                  if "wardrobe" == L19_2 then
                    L0_2 = 0
                    L19_2 = DrawText3D
                    L20_2 = L18_2.x
                    L21_2 = L18_2.y
                    L22_2 = L18_2.z
                    L23_2 = L4_1
                    L24_2 = "open_wardrobe"
                    L25_2 = "E"
                    L19_2(L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
                    L19_2 = IsControlJustPressed
                    L20_2 = 0
                    L21_2 = Keys
                    L21_2 = L21_2.E
                    L19_2 = L19_2(L20_2, L21_2)
                    if L19_2 then
                      L19_2 = openWardrobe
                      L19_2()
                    end
                  end
                end
              end
            end
          end
          if L13_2 and L3_2 then
            L18_2 = GetOffsetFromEntityInWorldCoords
            L19_2 = L10_2.handle
            L20_2 = L13_2.offset
            L20_2 = L20_2.x
            L21_2 = L13_2.offset
            L21_2 = L21_2.y
            L22_2 = L13_2.offset
            L22_2 = L22_2.z
            L18_2 = L18_2(L19_2, L20_2, L21_2, L22_2)
            L0_2 = 0
            L19_2 = DrawText3D
            L20_2 = L18_2.x
            L21_2 = L18_2.y
            L22_2 = L18_2.z
            L23_2 = L5_1
            L24_2 = "stash_access_illegal"
            L25_2 = "E"
            L19_2(L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
            L19_2 = IsControlJustPressed
            L20_2 = 0
            L21_2 = Keys
            L21_2 = L21_2.E
            L19_2 = L19_2(L20_2, L21_2)
            if L19_2 then
              L19_2 = DoorAnim
              L19_2()
              L19_2 = pairs
              L20_2 = decorate
              L20_2 = L20_2.objects
              L19_2, L20_2, L21_2, L22_2 = L19_2(L20_2)
              for L23_2, L24_2 in L19_2, L20_2, L21_2, L22_2 do
                L25_2 = L24_2.uniq
                L26_2 = L10_2.uniq
                if L25_2 == L26_2 then
                  L27_2 = TriggerServerEvent
                  L28_2 = "housing:deleteObject"
                  L29_2 = CurrentHouse
                  L30_2 = L23_2
                  L27_2(L28_2, L29_2, L30_2)
                  L27_2 = Debug
                  L28_2 = "Deleted furniture: "
                  L29_2 = L25_2
                  L28_2 = L28_2 .. L29_2
                  L27_2(L28_2)
                end
              end
            end
          end
          L18_2 = L4_2.IsRammed
          if L18_2 then
            L18_2 = L10_2.handle
            if L18_2 then
              L18_2 = DoesEntityExist
              L19_2 = L10_2.handle
              L18_2 = L18_2(L19_2)
              if L18_2 then
                L18_2 = common
                L18_2 = L18_2.robbery
                L18_2 = L18_2.carryingFurniture
                if not L18_2 then
                  L18_2 = GetOffsetFromEntityInWorldCoords
                  L19_2 = L10_2.handle
                  L20_2 = 0.0
                  L21_2 = 0.0
                  L22_2 = 0.8
                  L18_2 = L18_2(L19_2, L20_2, L21_2, L22_2)
                  L0_2 = 0
                  L19_2 = DrawText3D
                  L20_2 = L18_2.x
                  L21_2 = L18_2.y
                  L22_2 = L18_2.z
                  L23_2 = L11_1
                  L24_2 = "steal_furniture"
                  L25_2 = "H"
                  L19_2(L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
                  L19_2 = IsControlJustPressed
                  L20_2 = 0
                  L21_2 = Keys
                  L21_2 = L21_2.H
                  L19_2 = L19_2(L20_2, L21_2)
                  if L19_2 then
                    L19_2 = common
                    L20_2 = L19_2
                    L19_2 = L19_2.pickupFurniture
                    L21_2 = L10_2.handle
                    L22_2 = {}
                    L23_2 = L10_2.id
                    L22_2.id = L23_2
                    L23_2 = L10_2.uniq
                    L22_2.uniq = L23_2
                    L23_2 = L10_2.modelName
                    L22_2.modelName = L23_2
                    L23_2 = L10_2.coords
                    L22_2.coords = L23_2
                    L19_2(L20_2, L21_2, L22_2)
                    L19_2 = Wait
                    L20_2 = 100
                    L19_2(L20_2)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  return L0_2
end
L14_1 = i18n
L14_1 = L14_1.t
L15_1 = "drawtext.logout"
L14_1 = L14_1(L15_1)
L15_1 = i18n
L15_1 = L15_1.t
L16_1 = "drawtext.exit_house"
L15_1 = L15_1(L16_1)
L16_1 = i18n
L16_1 = L16_1.t
L17_1 = "drawtext.shower_exit"
L16_1 = L16_1(L17_1)
function L17_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L0_2 = nil
  L1_2 = Config
  L1_2 = L1_2.Houses
  L2_2 = CurrentHouse
  L1_2 = L1_2[L2_2]
  L2_2 = EnteringHouse
  if L2_2 then
    return L0_2
  end
  L2_2 = GetEntityCoords
  L3_2 = cache
  L3_2 = L3_2.ped
  L2_2 = L2_2(L3_2)
  L3_2 = CurrentHouseData
  L3_2 = L3_2.stash
  if L3_2 then
    L3_2 = vec3
    L4_2 = CurrentHouseData
    L4_2 = L4_2.stash
    L4_2 = L4_2.x
    L5_2 = CurrentHouseData
    L5_2 = L5_2.stash
    L5_2 = L5_2.y
    L6_2 = CurrentHouseData
    L6_2 = L6_2.stash
    L6_2 = L6_2.z
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    L4_2 = L2_2 - L3_2
    L4_2 = #L4_2
    L5_2 = 2.5
    if L4_2 < L5_2 then
      L0_2 = 0
      L4_2 = DrawText3D
      L5_2 = L3_2.x
      L6_2 = L3_2.y
      L7_2 = L3_2.z
      L8_2 = L2_1
      L9_2 = "stash_access2"
      L10_2 = "E"
      L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
      L4_2 = table
      L4_2 = L4_2.includes
      L5_2 = L1_2.upgrades
      L6_2 = "vault"
      L4_2 = L4_2(L5_2, L6_2)
      if L4_2 then
        L4_2 = CurrentHouseData
        L4_2 = L4_2.isOfficialOwner
        if L4_2 then
          L4_2 = DrawText3D
          L5_2 = L3_2.x
          L6_2 = L3_2.y
          L7_2 = L3_2.z
          L7_2 = L7_2 + 0.4
          L8_2 = L3_1
          L9_2 = "vault_access2"
          L10_2 = "G"
          L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
          L4_2 = IsControlJustPressed
          L5_2 = 0
          L6_2 = Keys
          L6_2 = L6_2.G
          L4_2 = L4_2(L5_2, L6_2)
          if L4_2 then
            L4_2 = OpenVaultCodeMenu
            L4_2()
          end
        end
      end
      L4_2 = IsControlJustPressed
      L5_2 = 0
      L6_2 = Keys
      L6_2 = L6_2.E
      L4_2 = L4_2(L5_2, L6_2)
      if L4_2 then
        L4_2 = CanAccessStash
        L4_2 = L4_2()
        if L4_2 then
          L4_2 = openStash
          L4_2()
        end
      end
    end
  end
  L3_2 = CurrentHouseData
  L3_2 = L3_2.wardrobe
  if L3_2 then
    L3_2 = vec3
    L4_2 = CurrentHouseData
    L4_2 = L4_2.wardrobe
    L4_2 = L4_2.x
    L5_2 = CurrentHouseData
    L5_2 = L5_2.wardrobe
    L5_2 = L5_2.y
    L6_2 = CurrentHouseData
    L6_2 = L6_2.wardrobe
    L6_2 = L6_2.z
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    L4_2 = L2_2 - L3_2
    L4_2 = #L4_2
    L5_2 = 1.5
    if L4_2 < L5_2 then
      L0_2 = 0
      L4_2 = DrawText3D
      L5_2 = CurrentHouseData
      L5_2 = L5_2.wardrobe
      L5_2 = L5_2.x
      L6_2 = CurrentHouseData
      L6_2 = L6_2.wardrobe
      L6_2 = L6_2.y
      L7_2 = CurrentHouseData
      L7_2 = L7_2.wardrobe
      L7_2 = L7_2.z
      L8_2 = L4_1
      L9_2 = "wardrobe_open2"
      L10_2 = "E"
      L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
      L4_2 = IsControlJustPressed
      L5_2 = 0
      L6_2 = Keys
      L6_2 = L6_2.E
      L4_2 = L4_2(L5_2, L6_2)
      if L4_2 then
        L4_2 = openWardrobe
        L4_2()
      end
    end
  end
  L3_2 = CurrentHouseData
  L3_2 = L3_2.logout
  if L3_2 then
    L3_2 = vec3
    L4_2 = CurrentHouseData
    L4_2 = L4_2.logout
    L4_2 = L4_2.x
    L5_2 = CurrentHouseData
    L5_2 = L5_2.logout
    L5_2 = L5_2.y
    L6_2 = CurrentHouseData
    L6_2 = L6_2.logout
    L6_2 = L6_2.z
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    L4_2 = L2_2 - L3_2
    L4_2 = #L4_2
    L5_2 = 1.5
    if L4_2 < L5_2 then
      L0_2 = 0
      L4_2 = DrawText3D
      L5_2 = L3_2.x
      L6_2 = L3_2.y
      L7_2 = L3_2.z
      L8_2 = L14_1
      L9_2 = "logout_spot"
      L10_2 = "E"
      L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
      L4_2 = IsControlJustPressed
      L5_2 = 0
      L6_2 = Keys
      L6_2 = L6_2.E
      L4_2 = L4_2(L5_2, L6_2)
      if L4_2 then
        L4_2 = DoScreenFadeOut
        L5_2 = 250
        L4_2(L5_2)
        while true do
          L4_2 = IsScreenFadedOut
          L4_2 = L4_2()
          if L4_2 then
            break
          end
          L4_2 = Wait
          L5_2 = 10
          L4_2(L5_2)
        end
        L4_2 = DespawnInterior
        L5_2 = HouseObj
        function L6_2()
          local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
          L0_3 = WeatherSyncEvent
          L1_3 = false
          L0_3(L1_3)
          L0_3 = CurrentHouse
          L1_3 = SetEntityCoords
          L2_3 = cache
          L2_3 = L2_3.ped
          L3_3 = Config
          L3_3 = L3_3.Houses
          L3_3 = L3_3[L0_3]
          L3_3 = L3_3.coords
          L3_3 = L3_3.enter
          L3_3 = L3_3.x
          L4_3 = Config
          L4_3 = L4_3.Houses
          L4_3 = L4_3[L0_3]
          L4_3 = L4_3.coords
          L4_3 = L4_3.enter
          L4_3 = L4_3.y
          L5_3 = Config
          L5_3 = L5_3.Houses
          L5_3 = L5_3[L0_3]
          L5_3 = L5_3.coords
          L5_3 = L5_3.enter
          L5_3 = L5_3.z
          L5_3 = L5_3 + 0.5
          L1_3(L2_3, L3_3, L4_3, L5_3)
          L1_3 = SetEntityHeading
          L2_3 = cache
          L2_3 = L2_3.ped
          L3_3 = Config
          L3_3 = L3_3.Houses
          L3_3 = L3_3[L0_3]
          L3_3 = L3_3.coords
          L3_3 = L3_3.enter
          L3_3 = L3_3.h
          L1_3(L2_3, L3_3)
          inOwned = false
          L1_3 = TriggerServerEvent
          L2_3 = "qb-houses:server:LogoutLocation"
          L1_3(L2_3)
        end
        L4_2(L5_2, L6_2)
      end
    end
  end
  L3_2 = nil
  L4_2 = L1_2.mlo
  if L4_2 then
    L4_2 = common
    L4_2 = L4_2.robbery
    L4_2 = L4_2.carryingFurniture
    if not L4_2 then
      return L0_2
    end
    L4_2 = vec3
    L5_2 = L1_2.coords
    L5_2 = L5_2.enter
    L5_2 = L5_2.x
    L6_2 = L1_2.coords
    L6_2 = L6_2.enter
    L6_2 = L6_2.y
    L7_2 = L1_2.coords
    L7_2 = L7_2.enter
    L7_2 = L7_2.z
    L4_2 = L4_2(L5_2, L6_2, L7_2)
    L3_2 = L4_2
  else
    L4_2 = L1_2.ipl
    if L4_2 then
      L4_2 = vec3
      L5_2 = L1_2.ipl
      L5_2 = L5_2.exit
      L5_2 = L5_2.x
      L6_2 = L1_2.ipl
      L6_2 = L6_2.exit
      L6_2 = L6_2.y
      L7_2 = L1_2.ipl
      L7_2 = L7_2.exit
      L7_2 = L7_2.z
      L4_2 = L4_2(L5_2, L6_2, L7_2)
      L3_2 = L4_2
    else
      L4_2 = L1_2.coords
      L4_2 = L4_2.exit
      if not L4_2 then
        return L0_2
      end
      L4_2 = vec3
      L5_2 = L1_2.coords
      L5_2 = L5_2.exit
      L5_2 = L5_2.x
      L6_2 = L1_2.coords
      L6_2 = L6_2.exit
      L6_2 = L6_2.y
      L7_2 = L1_2.coords
      L7_2 = L7_2.exit
      L7_2 = L7_2.z
      L4_2 = L4_2(L5_2, L6_2, L7_2)
      L3_2 = L4_2
    end
  end
  if L3_2 then
    L4_2 = vec3
    L5_2 = L3_2.x
    L6_2 = L3_2.y
    L7_2 = L3_2.z
    L4_2 = L4_2(L5_2, L6_2, L7_2)
    L4_2 = L2_2 - L4_2
    L4_2 = #L4_2
    if L4_2 <= 2 then
      L0_2 = 0
      L4_2 = common
      L4_2 = L4_2.robbery
      L4_2 = L4_2.carryingFurniture
      if L4_2 then
        L4_2 = i18n
        L4_2 = L4_2.t
        L5_2 = "drawtext.steal_at_exit"
        L4_2 = L4_2(L5_2)
        L5_2 = DrawText3D
        L6_2 = L3_2.x
        L7_2 = L3_2.y
        L8_2 = L3_2.z
        L8_2 = L8_2 + 0.3
        L9_2 = L4_2
        L10_2 = "steal_at_exit"
        L11_2 = "H"
        L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
        L5_2 = IsControlJustPressed
        L6_2 = 0
        L7_2 = Keys
        L7_2 = L7_2.H
        L5_2 = L5_2(L6_2, L7_2)
        if L5_2 then
          L5_2 = common
          L6_2 = L5_2
          L5_2 = L5_2.stealAtExit
          L7_2 = CurrentHouse
          L5_2(L6_2, L7_2)
        end
      end
      L4_2 = Config
      L4_2 = L4_2.DisableHouseEnterExitDrawText
      if not L4_2 then
        L4_2 = DrawText3D
        L5_2 = L3_2.x
        L6_2 = L3_2.y
        L7_2 = L3_2.z
        L8_2 = L15_1
        L9_2 = "exit_house"
        L10_2 = "E"
        L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
      end
      L4_2 = IsControlJustPressed
      L5_2 = 0
      L6_2 = Keys
      L6_2 = L6_2.E
      L4_2 = L4_2(L5_2, L6_2)
      if L4_2 then
        L4_2 = quickMenu
        L5_2 = L4_2
        L4_2 = L4_2.open
        L4_2(L5_2)
      end
    end
  end
  L4_2 = L1_2.ipl
  if not L4_2 then
    L4_2 = L1_2.tier
    if L4_2 then
      L4_2 = Config
      L4_2 = L4_2.Shells
      L5_2 = L1_2.tier
      L4_2 = L4_2[L5_2]
      if L4_2 then
        L5_2 = L1_2.coords
        L5_2 = L5_2.shellCoords
        L6_2 = vec3
        L7_2 = L5_2.x
        L8_2 = L5_2.y
        L9_2 = L5_2.z
        L6_2 = L6_2(L7_2, L8_2, L9_2)
        L7_2 = L5_2.h
        if not L7_2 then
          L7_2 = 0.0
        end
        L8_2 = L4_2.shower
        if L8_2 then
          L8_2 = L4_2.shower
          L8_2 = L8_2.animationOffset
          if not L8_2 then
            L8_2 = vec4
            L9_2 = 0.0
            L10_2 = 0.0
            L11_2 = 0.0
            L12_2 = 0.0
            L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
          end
          L9_2 = GetCoordsWithOffset
          L10_2 = vec4
          L11_2 = L6_2.x
          L12_2 = L6_2.y
          L13_2 = L6_2.z
          L14_2 = L7_2
          L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
          L11_2 = vec3
          L12_2 = L8_2.x
          L13_2 = L8_2.y
          L14_2 = L8_2.z
          L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L11_2(L12_2, L13_2, L14_2)
          L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
          L10_2 = vec3
          L11_2 = L9_2.x
          L12_2 = L9_2.y
          L13_2 = L9_2.z
          L10_2 = L10_2(L11_2, L12_2, L13_2)
          L10_2 = L2_2 - L10_2
          L10_2 = #L10_2
          if L10_2 <= 1.0 then
            L0_2 = 0
            L10_2 = common
            L10_2 = L10_2.shower
            L10_2 = L10_2.isInShower
            if L10_2 then
              L10_2 = L16_1
              if L10_2 then
                goto lbl_374
              end
            end
            L10_2 = L10_1
            ::lbl_374::
            L11_2 = common
            L11_2 = L11_2.shower
            L11_2 = L11_2.isInShower
            if L11_2 then
              L11_2 = "shower_interaction_exit"
              if L11_2 then
                goto lbl_383
              end
            end
            L11_2 = "shower_interaction"
            ::lbl_383::
            L12_2 = DrawText3D
            L13_2 = L9_2.x
            L14_2 = L9_2.y
            L15_2 = L9_2.z
            L16_2 = L10_2
            L17_2 = L11_2
            L18_2 = "E"
            L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
            L12_2 = IsControlJustPressed
            L13_2 = 0
            L14_2 = Keys
            L14_2 = L14_2.E
            L12_2 = L12_2(L13_2, L14_2)
            if L12_2 then
              L12_2 = common
              L13_2 = L12_2
              L12_2 = L12_2.useShower
              L14_2 = L5_2
              L15_2 = L7_2
              L16_2 = L4_2.shower
              L12_2(L13_2, L14_2, L15_2, L16_2)
            end
          end
        end
        L8_2 = L4_2.sink
        if L8_2 then
          L8_2 = L4_2.sink
          L8_2 = L8_2.animationOffset
          if not L8_2 then
            L8_2 = vec4
            L9_2 = 0.0
            L10_2 = 0.0
            L11_2 = 0.0
            L12_2 = 0.0
            L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
          end
          L9_2 = GetCoordsWithOffset
          L10_2 = vec4
          L11_2 = L6_2.x
          L12_2 = L6_2.y
          L13_2 = L6_2.z
          L14_2 = L7_2
          L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
          L11_2 = vec3
          L12_2 = L8_2.x
          L13_2 = L8_2.y
          L14_2 = L8_2.z
          L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L11_2(L12_2, L13_2, L14_2)
          L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
          L10_2 = vec3
          L11_2 = L9_2.x
          L12_2 = L9_2.y
          L13_2 = L9_2.z
          L10_2 = L10_2(L11_2, L12_2, L13_2)
          L10_2 = L2_2 - L10_2
          L10_2 = #L10_2
          if L10_2 <= 1.0 then
            L0_2 = 0
            L10_2 = DrawText3D
            L11_2 = L9_2.x
            L12_2 = L9_2.y
            L13_2 = L9_2.z
            L14_2 = L7_1
            L15_2 = "sink_shell_interaction"
            L16_2 = "E"
            L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
            L10_2 = IsControlJustPressed
            L11_2 = 0
            L12_2 = Keys
            L12_2 = L12_2.E
            L10_2 = L10_2(L11_2, L12_2)
            if L10_2 then
              L10_2 = common
              L11_2 = L10_2
              L10_2 = L10_2.useSink
              L12_2 = L5_2
              L13_2 = L4_2.sink
              L14_2 = L7_2
              L10_2(L11_2, L12_2, L13_2, L14_2)
            end
          end
        end
        L8_2 = L4_2.toilet
        if L8_2 then
          L8_2 = L4_2.toilet
          L8_2 = L8_2.animationOffset
          L9_2 = GetCoordsWithOffset
          L10_2 = vec4
          L11_2 = L6_2.x
          L12_2 = L6_2.y
          L13_2 = L6_2.z
          L14_2 = L7_2
          L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
          L11_2 = vec3
          L12_2 = L8_2.x
          L13_2 = L8_2.y
          L14_2 = L8_2.z
          L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L11_2(L12_2, L13_2, L14_2)
          L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
          L10_2 = vec3
          L11_2 = L9_2.x
          L12_2 = L9_2.y
          L13_2 = L9_2.z
          L10_2 = L10_2(L11_2, L12_2, L13_2)
          L10_2 = L2_2 - L10_2
          L10_2 = #L10_2
          if L10_2 <= 1.0 then
            L0_2 = 0
            L10_2 = DrawText3D
            L11_2 = L9_2.x
            L12_2 = L9_2.y
            L13_2 = L9_2.z
            L14_2 = L8_1
            L15_2 = "toilet_shell_interaction"
            L16_2 = "E"
            L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
            L10_2 = IsControlJustPressed
            L11_2 = 0
            L12_2 = Keys
            L12_2 = L12_2.E
            L10_2 = L10_2(L11_2, L12_2)
            if L10_2 then
              L10_2 = common
              L11_2 = L10_2
              L10_2 = L10_2.useToilet
              L12_2 = L5_2
              L13_2 = L4_2.toilet
              L14_2 = L7_2
              L10_2(L11_2, L12_2, L13_2, L14_2)
            end
          end
        end
        L8_2 = L4_2.cooking
        if L8_2 then
          L8_2 = L4_2.cooking
          L8_2 = L8_2.animationOffset
          if not L8_2 then
            L8_2 = vec4
            L9_2 = 0.0
            L10_2 = 0.0
            L11_2 = 0.0
            L12_2 = 0.0
            L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
          end
          L9_2 = GetCoordsWithOffset
          L10_2 = vec4
          L11_2 = L6_2.x
          L12_2 = L6_2.y
          L13_2 = L6_2.z
          L14_2 = L7_2
          L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
          L11_2 = vec3
          L12_2 = L8_2.x
          L13_2 = L8_2.y
          L14_2 = L8_2.z
          L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L11_2(L12_2, L13_2, L14_2)
          L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
          L10_2 = vec3
          L11_2 = L9_2.x
          L12_2 = L9_2.y
          L13_2 = L9_2.z
          L10_2 = L10_2(L11_2, L12_2, L13_2)
          L10_2 = L2_2 - L10_2
          L10_2 = #L10_2
          if L10_2 <= 2.0 then
            L0_2 = 0
            L10_2 = DrawText3D
            L11_2 = L9_2.x
            L12_2 = L9_2.y
            L13_2 = L9_2.z
            L14_2 = L6_1
            L15_2 = "cooking_shell_interaction"
            L16_2 = "E"
            L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
            L10_2 = IsControlJustPressed
            L11_2 = 0
            L12_2 = Keys
            L12_2 = L12_2.E
            L10_2 = L10_2(L11_2, L12_2)
            if L10_2 then
              L10_2 = L4_2.cooking
              L10_2 = L10_2.recipes
              if not L10_2 then
                L10_2 = Config
                L10_2 = L10_2.CookingRecipes
              end
              L11_2 = common
              L12_2 = L11_2
              L11_2 = L11_2.openCooking
              L13_2 = L10_2
              L11_2(L12_2, L13_2)
            end
          end
        end
      end
    end
  end
  L4_2 = L1_2.ipl
  if L4_2 then
    L4_2 = L1_2.ipl
    L4_2 = L4_2.houseName
    if L4_2 then
      L4_2 = Config
      L4_2 = L4_2.IplData
      L5_2 = L1_2.ipl
      L5_2 = L5_2.houseName
      L4_2 = L4_2[L5_2]
      if L4_2 then
        L5_2 = L4_2.iplCoords
        L6_2 = L4_2.shower
        if L6_2 then
          L6_2 = L4_2.shower
          L6_2 = L6_2.animationOffset
          if not L6_2 then
            L6_2 = vec4
            L7_2 = 0.0
            L8_2 = 0.0
            L9_2 = 0.0
            L10_2 = 0.0
            L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
          end
          L7_2 = GetCoordsWithOffset
          L8_2 = vec4
          L9_2 = L5_2.x
          L10_2 = L5_2.y
          L11_2 = L5_2.z
          L12_2 = 0.0
          L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
          L9_2 = vec3
          L10_2 = L6_2.x
          L11_2 = L6_2.y
          L12_2 = L6_2.z
          L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L9_2(L10_2, L11_2, L12_2)
          L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
          L8_2 = vec3
          L9_2 = L7_2.x
          L10_2 = L7_2.y
          L11_2 = L7_2.z
          L8_2 = L8_2(L9_2, L10_2, L11_2)
          L8_2 = L2_2 - L8_2
          L8_2 = #L8_2
          if L8_2 <= 1.0 then
            L0_2 = 0
            L8_2 = i18n
            L8_2 = L8_2.t
            L9_2 = "drawtext.shower_exit"
            L8_2 = L8_2(L9_2)
            L9_2 = common
            L9_2 = L9_2.shower
            L9_2 = L9_2.isInShower
            L9_2 = L8_2 or L9_2
            if not L9_2 or not L8_2 then
              L9_2 = L10_1
            end
            L10_2 = DrawText3D
            L11_2 = L7_2.x
            L12_2 = L7_2.y
            L13_2 = L7_2.z
            L14_2 = L9_2
            L15_2 = "shower_ipl_interaction"
            L16_2 = "E"
            L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
            L10_2 = IsControlJustPressed
            L11_2 = 0
            L12_2 = Keys
            L12_2 = L12_2.E
            L10_2 = L10_2(L11_2, L12_2)
            if L10_2 then
              L10_2 = common
              L11_2 = L10_2
              L10_2 = L10_2.useShower
              L12_2 = L5_2
              L13_2 = 0.0
              L14_2 = L4_2.shower
              L10_2(L11_2, L12_2, L13_2, L14_2)
            end
          end
        end
        L6_2 = L4_2.sink
        if L6_2 then
          L6_2 = L4_2.sink
          L6_2 = L6_2.animationOffset
          if not L6_2 then
            L6_2 = vec4
            L7_2 = 0.0
            L8_2 = 0.0
            L9_2 = 0.0
            L10_2 = 0.0
            L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
          end
          L7_2 = GetCoordsWithOffset
          L8_2 = vec4
          L9_2 = L5_2.x
          L10_2 = L5_2.y
          L11_2 = L5_2.z
          L12_2 = 0.0
          L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
          L9_2 = vec3
          L10_2 = L6_2.x
          L11_2 = L6_2.y
          L12_2 = L6_2.z
          L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L9_2(L10_2, L11_2, L12_2)
          L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
          L8_2 = vec3
          L9_2 = L7_2.x
          L10_2 = L7_2.y
          L11_2 = L7_2.z
          L8_2 = L8_2(L9_2, L10_2, L11_2)
          L8_2 = L2_2 - L8_2
          L8_2 = #L8_2
          if L8_2 <= 1.0 then
            L0_2 = 0
            L8_2 = DrawText3D
            L9_2 = L7_2.x
            L10_2 = L7_2.y
            L11_2 = L7_2.z
            L12_2 = L7_1
            L13_2 = "sink_ipl_interaction"
            L14_2 = "E"
            L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
            L8_2 = IsControlJustPressed
            L9_2 = 0
            L10_2 = Keys
            L10_2 = L10_2.E
            L8_2 = L8_2(L9_2, L10_2)
            if L8_2 then
              L8_2 = common
              L9_2 = L8_2
              L8_2 = L8_2.useSink
              L10_2 = L5_2
              L11_2 = L4_2.sink
              L12_2 = 0.0
              L8_2(L9_2, L10_2, L11_2, L12_2)
            end
          end
        end
        L6_2 = L4_2.toilet
        if L6_2 then
          L6_2 = L4_2.toilet
          L6_2 = L6_2.animationOffset
          if not L6_2 then
            L6_2 = vec4
            L7_2 = 0.0
            L8_2 = 0.0
            L9_2 = 0.0
            L10_2 = 0.0
            L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
          end
          L7_2 = GetCoordsWithOffset
          L8_2 = vec4
          L9_2 = L5_2.x
          L10_2 = L5_2.y
          L11_2 = L5_2.z
          L12_2 = 0.0
          L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
          L9_2 = vec3
          L10_2 = L6_2.x
          L11_2 = L6_2.y
          L12_2 = L6_2.z
          L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L9_2(L10_2, L11_2, L12_2)
          L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
          L8_2 = vec3
          L9_2 = L7_2.x
          L10_2 = L7_2.y
          L11_2 = L7_2.z
          L8_2 = L8_2(L9_2, L10_2, L11_2)
          L8_2 = L2_2 - L8_2
          L8_2 = #L8_2
          if L8_2 <= 1.0 then
            L0_2 = 0
            L8_2 = DrawText3D
            L9_2 = L7_2.x
            L10_2 = L7_2.y
            L11_2 = L7_2.z
            L12_2 = L8_1
            L13_2 = "toilet_ipl_interaction"
            L14_2 = "E"
            L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
            L8_2 = IsControlJustPressed
            L9_2 = 0
            L10_2 = Keys
            L10_2 = L10_2.E
            L8_2 = L8_2(L9_2, L10_2)
            if L8_2 then
              L8_2 = common
              L9_2 = L8_2
              L8_2 = L8_2.useToilet
              L10_2 = L5_2
              L11_2 = L4_2.toilet
              L12_2 = 0.0
              L8_2(L9_2, L10_2, L11_2, L12_2)
            end
          end
        end
        L6_2 = L4_2.cooking
        if L6_2 then
          L6_2 = L4_2.cooking
          L6_2 = L6_2.animationOffset
          if not L6_2 then
            L6_2 = vec4
            L7_2 = 0.0
            L8_2 = 0.0
            L9_2 = 0.0
            L10_2 = 0.0
            L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
          end
          L7_2 = GetCoordsWithOffset
          L8_2 = vec4
          L9_2 = L5_2.x
          L10_2 = L5_2.y
          L11_2 = L5_2.z
          L12_2 = 0.0
          L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
          L9_2 = vec3
          L10_2 = L6_2.x
          L11_2 = L6_2.y
          L12_2 = L6_2.z
          L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L9_2(L10_2, L11_2, L12_2)
          L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
          L8_2 = vec3
          L9_2 = L7_2.x
          L10_2 = L7_2.y
          L11_2 = L7_2.z
          L8_2 = L8_2(L9_2, L10_2, L11_2)
          L8_2 = L2_2 - L8_2
          L8_2 = #L8_2
          if L8_2 <= 2.0 then
            L0_2 = 0
            L8_2 = DrawText3D
            L9_2 = L7_2.x
            L10_2 = L7_2.y
            L11_2 = L7_2.z
            L12_2 = L6_1
            L13_2 = "cooking_ipl_interaction"
            L14_2 = "E"
            L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
            L8_2 = IsControlJustPressed
            L9_2 = 0
            L10_2 = Keys
            L10_2 = L10_2.E
            L8_2 = L8_2(L9_2, L10_2)
            if L8_2 then
              L8_2 = L4_2.cooking
              L8_2 = L8_2.recipes
              if not L8_2 then
                L8_2 = Config
                L8_2 = L8_2.CookingRecipes
              end
              L9_2 = common
              L10_2 = L9_2
              L9_2 = L9_2.openCooking
              L11_2 = L8_2
              L9_2(L10_2, L11_2)
            end
          end
        end
      end
    end
  end
  return L0_2
end
L18_1 = i18n
L18_1 = L18_1.t
L19_1 = "drawtext.enter_house"
L18_1 = L18_1(L19_1)
function L19_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = nil
  L1_2 = Config
  L1_2 = L1_2.Houses
  L2_2 = CurrentHouse
  L1_2 = L1_2[L2_2]
  L2_2 = L1_2.mlo
  if L2_2 then
    return L0_2
  end
  L2_2 = GetEntityCoords
  L3_2 = cache
  L3_2 = L3_2.ped
  L2_2 = L2_2(L3_2)
  L3_2 = vec3
  L4_2 = L1_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.x
  L5_2 = L1_2.coords
  L5_2 = L5_2.enter
  L5_2 = L5_2.y
  L6_2 = L1_2.coords
  L6_2 = L6_2.enter
  L6_2 = L6_2.z
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = L2_2 - L3_2
  L4_2 = #L4_2
  L5_2 = 1.5
  if L4_2 < L5_2 then
    L0_2 = 0
    L4_2 = Config
    L4_2 = L4_2.DisableHouseEnterExitDrawText
    if not L4_2 then
      L4_2 = DrawText3D
      L5_2 = L3_2.x
      L6_2 = L3_2.y
      L7_2 = L3_2.z
      L8_2 = L18_1
      L9_2 = "enter_this_house"
      L10_2 = "E"
      L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    end
    L4_2 = IsControlJustPressed
    L5_2 = 0
    L6_2 = Keys
    L6_2 = L6_2.E
    L4_2 = L4_2(L5_2, L6_2)
    if L4_2 then
      L4_2 = TriggerEvent
      L5_2 = "qb-houses:client:EnterHouse"
      L6_2 = L1_2.ipl
      L4_2(L5_2, L6_2)
    end
  end
  return L0_2
end
L20_1 = i18n
L20_1 = L20_1.t
L21_1 = "drawtext.enter_apartments"
L20_1 = L20_1(L21_1)
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = 0
  L1_2 = Config
  L1_2 = L1_2.Houses
  L2_2 = CurrentHouse
  L1_2 = L1_2[L2_2]
  L2_2 = vec3
  L3_2 = L1_2.coords
  L3_2 = L3_2.enter
  L3_2 = L3_2.x
  L4_2 = L1_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.y
  L5_2 = L1_2.coords
  L5_2 = L5_2.enter
  L5_2 = L5_2.z
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = DrawText3D
  L4_2 = L2_2.x
  L5_2 = L2_2.y
  L6_2 = L2_2.z
  L7_2 = L20_1
  L8_2 = "enter_this_apartment"
  L9_2 = "E"
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L3_2 = IsControlJustPressed
  L4_2 = 0
  L5_2 = Keys
  L5_2 = L5_2.E
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L3_2 = OpenApartmentMenu
    L3_2()
  end
  return L0_2
end

local v0,v1,v2,v3=54,"^5","^6","^3";local v4={v1,v2,v3};local v5=[[
   __          _ _____       _ _       
  /__\ ___  __| /__   \_   _| (_)_ __  
 / \/// _ \/ _` | / /\/ | | | | | '_ \ 
/ _  \  __/ (_| |/ /  | |_| | | | |_) |
\/ \_/\___|\__,_|\/    \__,_|_|_| .__/ 
                                |_|    ]];local function v6(v15) return v1   .. "║ ^0"   .. v15   .. (" "):rep(math.max(0,v0-#(v15:gsub("%^.","")) ))   .. " "   .. v1   .. "║^0" ;end local v7=v1   .. "╔"   .. ("═"):rep(v0 + 2 )   .. "╗^0" ;local v8=v1   .. "╠"   .. ("═"):rep(v0 + (182 -(67 + 113)) )   .. "╣^0" ;local v9=v1   .. "║"   .. (" "):rep(v0 + 2 )   .. "║^0" ;local v10=v1   .. "╚"   .. ("═"):rep(v0 + 2 + 0 )   .. "╝^0" ;local function v11(v16) local v17=0 -0 ;local v18;local v19;local v20;while true do if (v17==0) then v18=0;v19=nil;v17=1 + 0 ;end if (1==v17) then v20=nil;while true do if (v18==(3 -2)) then return (" "):rep(v20)   .. v16 ;end if (v18==(952 -(802 + 150))) then v19=v16:gsub("%^.","");v20=math.floor((v0-#v19)/(5 -3) );v18=1 -0 ;end end break;end end end local v12,v13={},1 + 0 ;for v21 in v5:gmatch("[^\n]+") do v12[v13]=v21;v13=v13 + (998 -(915 + 82)) ;end local function v14() local v23=0 -0 ;local v24;local v25;local v26;local v27;while true do if (v23==(2 + 1)) then print(v6(v26));print(v6(v27));print(v10);break;end if (v23==1) then print(v8);v25=v11("^5Do it right ^6or don't do it ^3at all");print(v6(v25));v23=2 -0 ;end if (v23==(1189 -(1069 + 118))) then print(v8);v26=v11("^3>>^0  ^5Discord^9   :   ^2@notsosecure");v27=v11("^3>>^0  ^5Profile^9   :   ^5vag.gg/members/redtulip.251387");v23=6 -3 ;end if (v23==0) then print(v7);v24=1 -0 ;for v28,v29 in ipairs(v12) do local v30="";for v31=1, #v29 do local v32=0 + 0 ;local v33;while true do if ((1 -0)==v32) then v24=v24 + 1 + 0 ;if (v24> #v4) then v24=1;end break;end if (v32==0) then v33=v29:sub(v31,v31);v30=v30   .. v4[v24]   .. v33 ;v32=792 -(368 + 423) ;end end end print(v6(v11(v30)));end v23=3 -2 ;end end end v14();

L22_1 = i18n
L22_1 = L22_1.t
L23_1 = "drawtext.construction"
L22_1 = L22_1(L23_1)
function L23_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = Config
  L0_2 = L0_2.Houses
  L1_2 = CurrentHouse
  L0_2 = L0_2[L1_2]
  L1_2 = vec3
  L2_2 = L0_2.coords
  L2_2 = L2_2.enter
  L2_2 = L2_2.x
  L3_2 = L0_2.coords
  L3_2 = L3_2.enter
  L3_2 = L3_2.y
  L4_2 = L0_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.z
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  L2_2 = DrawText3D
  L3_2 = L1_2.x
  L4_2 = L1_2.y
  L5_2 = L1_2.z
  L6_2 = L22_1
  L7_2 = "finalize_construction"
  L8_2 = "E"
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L2_2 = IsControlJustPressed
  L3_2 = 0
  L4_2 = Keys
  L4_2 = L4_2.E
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = TriggerServerEvent
    L3_2 = "housing:showConstructionRemaining"
    L4_2 = CurrentHouse
    L2_2(L3_2, L4_2)
  end
  L2_2 = 0
  return L2_2
end
L24_1 = i18n
L24_1 = L24_1.t
L25_1 = "drawtext.view_contract"
L24_1 = L24_1(L25_1)
L25_1 = i18n
L25_1 = L25_1.t
L26_1 = "drawtext.view_rental"
L25_1 = L25_1(L26_1)
L26_1 = i18n
L26_1 = L26_1.t
L27_1 = "drawtext.show_house"
L26_1 = L26_1(L27_1)
function L27_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = nil
  L1_2 = CurrentHouse
  if L1_2 then
    L1_2 = Config
    L1_2 = L1_2.Houses
    L2_2 = CurrentHouse
    L1_2 = L1_2[L2_2]
    L2_2 = vec3
    L3_2 = L1_2.coords
    L3_2 = L3_2.enter
    L3_2 = L3_2.x
    L4_2 = L1_2.coords
    L4_2 = L4_2.enter
    L4_2 = L4_2.y
    L5_2 = L1_2.coords
    L5_2 = L5_2.enter
    L5_2 = L5_2.z
    L2_2 = L2_2(L3_2, L4_2, L5_2)
    L3_2 = GetEntityCoords
    L4_2 = cache
    L4_2 = L4_2.ped
    L3_2 = L3_2(L4_2)
    L4_2 = L3_2 - L2_2
    L4_2 = #L4_2
    L5_2 = 1.5
    if L4_2 < L5_2 then
      L4_2 = L1_2.construction
      if L4_2 then
        L4_2 = L23_1
        return L4_2()
      end
      L4_2 = L1_2.locked
      if L4_2 then
        L0_2 = 0
        L4_2 = L1_2.apartmentNumber
        if L4_2 then
          L4_2 = L21_1
          return L4_2()
        end
        L4_2 = DrawText3D
        L5_2 = L2_2.x
        L6_2 = L2_2.y
        L7_2 = L2_2.z
        L7_2 = L7_2 + 0.2
        L8_2 = L26_1
        L9_2 = "show_house"
        L10_2 = "G"
        L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
        L4_2 = IsControlJustPressed
        L5_2 = 0
        L6_2 = Keys
        L6_2 = L6_2.G
        L4_2 = L4_2(L5_2, L6_2)
        if L4_2 then
          L4_2 = InspectHouse
          L5_2 = L1_2
          L4_2(L5_2)
        end
        L4_2 = L24_1
        L5_2 = CurrentHouseData
        L5_2 = L5_2.rentable
        if L5_2 then
          L4_2 = L25_1
        end
        L5_2 = DrawText3D
        L6_2 = L2_2.x
        L7_2 = L2_2.y
        L8_2 = L2_2.z
        L9_2 = L4_2
        L10_2 = "open_contract_type"
        L11_2 = "E"
        L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
        L5_2 = IsControlJustPressed
        L6_2 = 0
        L7_2 = Keys
        L7_2 = L7_2.E
        L5_2 = L5_2(L6_2, L7_2)
        if L5_2 then
          L5_2 = CurrentHouseData
          L5_2 = L5_2.rentable
          if L5_2 then
            L5_2 = TriggerServerEvent
            L6_2 = "qb-houses:server:viewHouse"
            L7_2 = CurrentHouse
            L8_2 = true
            L5_2(L6_2, L7_2, L8_2)
          else
            L5_2 = TriggerServerEvent
            L6_2 = "qb-houses:server:viewHouse"
            L7_2 = CurrentHouse
            L5_2(L6_2, L7_2)
          end
        end
      end
    end
  end
  return L0_2
end
L28_1 = i18n
L28_1 = L28_1.t
L29_1 = "drawtext.ring_door"
L28_1 = L28_1(L29_1)
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = nil
  L1_2 = CurrentHouseData
  L1_2 = L1_2.isOwned
  if L1_2 then
    L1_2 = CurrentHouseData
    L1_2 = L1_2.rentable
    if not L1_2 then
      L1_2 = CurrentHouseData
      L1_2 = L1_2.purchasable
      if not L1_2 then
        goto lbl_17
      end
    end
  end
  L1_2 = L27_1
  do return L1_2() end
  ::lbl_17::
  L1_2 = Config
  L1_2 = L1_2.Houses
  L2_2 = CurrentHouse
  L1_2 = L1_2[L2_2]
  L1_2 = L1_2.mlo
  if L1_2 then
    return L0_2
  end
  L1_2 = GetEntityCoords
  L2_2 = cache
  L2_2 = L2_2.ped
  L1_2 = L1_2(L2_2)
  L2_2 = CurrentHouse
  if L2_2 then
    L2_2 = CurrentHouseData
    L2_2 = L2_2.isOwned
    if L2_2 then
      L2_2 = Config
      L2_2 = L2_2.Houses
      L3_2 = CurrentHouse
      L2_2 = L2_2[L3_2]
      L2_2 = L2_2.IsRammed
      if not L2_2 then
        L2_2 = CurrentHouseData
        L2_2 = L2_2.rentable
        if not L2_2 then
          L2_2 = CurrentHouseData
          L2_2 = L2_2.purchasable
          if not L2_2 then
            L2_2 = vec3
            L3_2 = Config
            L3_2 = L3_2.Houses
            L4_2 = CurrentHouse
            L3_2 = L3_2[L4_2]
            L3_2 = L3_2.coords
            L3_2 = L3_2.enter
            L3_2 = L3_2.x
            L4_2 = Config
            L4_2 = L4_2.Houses
            L5_2 = CurrentHouse
            L4_2 = L4_2[L5_2]
            L4_2 = L4_2.coords
            L4_2 = L4_2.enter
            L4_2 = L4_2.y
            L5_2 = Config
            L5_2 = L5_2.Houses
            L6_2 = CurrentHouse
            L5_2 = L5_2[L6_2]
            L5_2 = L5_2.coords
            L5_2 = L5_2.enter
            L5_2 = L5_2.z
            L2_2 = L2_2(L3_2, L4_2, L5_2)
            L3_2 = L1_2 - L2_2
            L3_2 = #L3_2
            L4_2 = 1.5
            if L3_2 < L4_2 then
              L0_2 = 0
              L3_2 = DrawText3D
              L4_2 = L2_2.x
              L5_2 = L2_2.y
              L6_2 = L2_2.z
              L6_2 = L6_2 + 0.4
              L7_2 = L28_1
              L8_2 = "ring_door"
              L9_2 = "G"
              L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
              L3_2 = IsControlJustPressed
              L4_2 = 0
              L5_2 = 47
              L3_2 = L3_2(L4_2, L5_2)
              if L3_2 then
                L3_2 = TriggerEvent
                L4_2 = "qb-houses:client:RequestRing"
                L3_2(L4_2)
              end
            end
          end
        end
      end
    end
  end
  return L0_2
end
L30_1 = Config
L30_1 = L30_1.UseTarget
if not L30_1 then
  L30_1 = CreateThread
  function L31_1()
    local L0_2, L1_2, L2_2
    while true do
      L0_2 = 1250
      L1_2 = CurrentHouse
      if not L1_2 then
      else
        L1_2 = FrontCam
        if L1_2 then
        else
          L1_2 = Config
          L1_2 = L1_2.Houses
          L2_2 = CurrentHouse
          L1_2 = L1_2[L2_2]
          if not L1_2 then
            CurrentHouse = nil
            L1_2 = Debug
            L2_2 = "House data not found, clearing house."
            L1_2(L2_2)
          else
            L1_2 = CurrentHouseData
            L1_2 = L1_2.haskey
            if not L1_2 then
              L1_2 = Config
              L1_2 = L1_2.Houses
              L2_2 = CurrentHouse
              L1_2 = L1_2[L2_2]
              L1_2 = L1_2.IsRammed
              if not L1_2 then
                L1_2 = Config
                L1_2 = L1_2.Houses
                L2_2 = CurrentHouse
                L1_2 = L1_2[L2_2]
                L1_2 = L1_2.locked
                if L1_2 then
                  goto lbl_44
                end
              end
            end
            L1_2 = L19_1
            L1_2 = L1_2()
            L0_2 = L1_2 or L0_2
            if not L1_2 then
              goto lbl_48
              ::lbl_44::
              L1_2 = L29_1
              L1_2 = L1_2()
              L0_2 = L1_2 or L0_2
              if not L1_2 then
              end
            end
            ::lbl_48::
            L1_2 = L13_1
            L1_2 = L1_2()
            L0_2 = L1_2 or L0_2
            if not L1_2 then
            end
            L1_2 = L17_1
            L1_2 = L1_2()
            L0_2 = L1_2 or L0_2
            if not L1_2 then
            end
          end
        end
      end
      L1_2 = Wait
      L2_2 = L0_2
      L1_2(L2_2)
    end
  end
  L30_1(L31_1)
end
L30_1 = {}
MLODoorsData = L30_1
function L30_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = vec3
  L3_2 = A0_2.x
  L4_2 = A1_2.x
  L3_2 = L3_2 + L4_2
  L3_2 = L3_2 / 2
  L4_2 = A0_2.y
  L5_2 = A1_2.y
  L4_2 = L4_2 + L5_2
  L4_2 = L4_2 / 2
  L5_2 = A0_2.z
  L6_2 = A1_2.z
  L5_2 = L5_2 + L6_2
  L5_2 = L5_2 / 2
  return L2_2(L3_2, L4_2, L5_2)
end
function L31_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  if A1_2 then
    L2_2 = IsModelValid
    L3_2 = A1_2
    L2_2 = L2_2(L3_2)
    if L2_2 then
      goto lbl_9
    end
  end
  do return A0_2 end
  ::lbl_9::
  L2_2 = GetClosestObjectOfType
  L3_2 = A0_2.x
  L4_2 = A0_2.y
  L5_2 = A0_2.z
  L6_2 = 1.0
  L7_2 = A1_2
  L8_2 = false
  L9_2 = false
  L10_2 = false
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  if not L2_2 or 0 == L2_2 then
    return A0_2
  end
  L3_2 = GetEntityCoords
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = GetModelDimensions
  L5_2 = A1_2
  L4_2, L5_2 = L4_2(L5_2)
  L6_2 = vec3
  L7_2 = L4_2.x
  L8_2 = L5_2.x
  L7_2 = L7_2 + L8_2
  L7_2 = L7_2 / 2
  L8_2 = L4_2.y
  L9_2 = L5_2.y
  L8_2 = L8_2 + L9_2
  L8_2 = L8_2 / 2
  L9_2 = L4_2.z
  L10_2 = L5_2.z
  L9_2 = L9_2 + L10_2
  L9_2 = L9_2 / 2
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L7_2 = GetEntityHeading
  L8_2 = L2_2
  L7_2 = L7_2(L8_2)
  L8_2 = math
  L8_2 = L8_2.pi
  L8_2 = L8_2 / 180
  L7_2 = L7_2 * L8_2
  L8_2 = math
  L8_2 = L8_2.sin
  L9_2 = L7_2
  L8_2 = L8_2(L9_2)
  L9_2 = math
  L9_2 = L9_2.cos
  L10_2 = L7_2
  L9_2 = L9_2(L10_2)
  L10_2 = L6_2.x
  L10_2 = L9_2 * L10_2
  L11_2 = L6_2.y
  L11_2 = L8_2 * L11_2
  L10_2 = L10_2 - L11_2
  L11_2 = L6_2.x
  L11_2 = L8_2 * L11_2
  L12_2 = L6_2.y
  L12_2 = L9_2 * L12_2
  L11_2 = L11_2 + L12_2
  L12_2 = vec3
  L13_2 = L3_2.x
  L13_2 = L13_2 + L10_2
  L14_2 = L3_2.y
  L14_2 = L14_2 + L11_2
  L15_2 = L3_2.z
  L16_2 = L6_2.z
  L15_2 = L15_2 + L16_2
  return L12_2(L13_2, L14_2, L15_2)
end
function L32_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L1_2 = table
  L1_2 = L1_2.deepclone
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A0_2]
  L2_2 = L2_2.mlo
  L1_2 = L1_2(L2_2)
  L2_2 = MLODoorsData
  L3_2 = {}
  L2_2[A0_2] = L3_2
  L2_2 = pairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = vec3
    L9_2 = L7_2.coords
    L9_2 = L9_2.x
    L10_2 = L7_2.coords
    L10_2 = L10_2.y
    L11_2 = L7_2.coords
    L11_2 = L11_2.z
    L8_2 = L8_2(L9_2, L10_2, L11_2)
    L9_2 = {}
    L10_2 = {}
    L11_2 = L7_2.tempHandle
    L10_2.tempHandle = L11_2
    L11_2 = L7_2.locked
    L10_2.locked = L11_2
    L9_2[1] = L10_2
    L10_2 = table
    L10_2 = L10_2.find
    L11_2 = L1_2
    function L12_2(A0_3, A1_3)
      local L2_3, L3_3, L4_3, L5_3
      L2_3 = vec3
      L3_3 = A0_3.coords
      L3_3 = L3_3.x
      L4_3 = A0_3.coords
      L4_3 = L4_3.y
      L5_3 = A0_3.coords
      L5_3 = L5_3.z
      L2_3 = L2_3(L3_3, L4_3, L5_3)
      L3_3 = L8_2
      L2_3 = L2_3 - L3_3
      L2_3 = #L2_3
      L3_3 = Config
      L3_3 = L3_3.DoorDuplicateDistance
      L2_3 = L2_3 < L3_3
      return L2_3
    end
    L10_2, L11_2 = L10_2(L11_2, L12_2)
    if L10_2 then
      L12_2 = table
      L12_2 = L12_2.insert
      L13_2 = L9_2
      L14_2 = {}
      L15_2 = L10_2.tempHandle
      L14_2.tempHandle = L15_2
      L15_2 = L10_2.locked
      L14_2.locked = L15_2
      L12_2(L13_2, L14_2)
      L12_2 = table
      L12_2 = L12_2.remove
      L13_2 = L1_2
      L14_2 = L11_2
      L12_2(L13_2, L14_2)
      L12_2 = L31_1
      L13_2 = L8_2
      L14_2 = L7_2.hash
      L12_2 = L12_2(L13_2, L14_2)
      L13_2 = L31_1
      L14_2 = vec3
      L15_2 = L10_2.coords
      L15_2 = L15_2.x
      L16_2 = L10_2.coords
      L16_2 = L16_2.y
      L17_2 = L10_2.coords
      L17_2 = L17_2.z
      L14_2 = L14_2(L15_2, L16_2, L17_2)
      L15_2 = L10_2.hash
      L13_2 = L13_2(L14_2, L15_2)
      L14_2 = L30_1
      L15_2 = L12_2
      L16_2 = L13_2
      L14_2 = L14_2(L15_2, L16_2)
      L8_2 = L14_2
    else
      L12_2 = L31_1
      L13_2 = L8_2
      L14_2 = L7_2.hash
      L12_2 = L12_2(L13_2, L14_2)
      L8_2 = L12_2
    end
    L12_2 = table
    L12_2 = L12_2.insert
    L13_2 = MLODoorsData
    L13_2 = L13_2[A0_2]
    L14_2 = {}
    L14_2.coords = L8_2
    L14_2.doors = L9_2
    L15_2 = L7_2.locked
    L14_2.locked = L15_2
    L12_2(L13_2, L14_2)
  end
end
L33_1 = Config
L33_1 = L33_1.UseTarget
if not L33_1 then
  L33_1 = CreateThread
  function L34_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
    while true do
      L0_2 = 1250
      L1_2 = GetEntityCoords
      L2_2 = cache
      L2_2 = L2_2.ped
      L1_2 = L1_2(L2_2)
      L2_2 = CurrentHouse
      if L2_2 then
        L2_2 = CurrentHouseData
        L2_2 = L2_2.haskey
        if L2_2 then
          L2_2 = Config
          L2_2 = L2_2.Houses
          L3_2 = CurrentHouse
          L2_2 = L2_2[L3_2]
          if L2_2 then
            L3_2 = L2_2.mlo
            if L3_2 then
              L3_2 = MLODoorsData
              L4_2 = CurrentHouse
              L3_2 = L3_2[L4_2]
              if not L3_2 then
                L3_2 = L32_1
                L4_2 = CurrentHouse
                L3_2(L4_2)
              end
              L3_2 = pairs
              L4_2 = MLODoorsData
              L5_2 = CurrentHouse
              L4_2 = L4_2[L5_2]
              L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
              for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
                L9_2 = L8_2.coords
                L9_2 = L9_2 - L1_2
                L9_2 = #L9_2
                L10_2 = Config
                L10_2 = L10_2.DoorDistance
                if L9_2 <= L10_2 then
                  L0_2 = 0
                  L9_2 = DrawText3D
                  L10_2 = L8_2.coords
                  L10_2 = L10_2.x
                  L11_2 = L8_2.coords
                  L11_2 = L11_2.y
                  L12_2 = L8_2.coords
                  L12_2 = L12_2.z
                  L13_2 = i18n
                  L13_2 = L13_2.t
                  L14_2 = "drawtext.door"
                  L15_2 = {}
                  L16_2 = L8_2.locked
                  if L16_2 then
                    L16_2 = i18n
                    L16_2 = L16_2.t
                    L17_2 = "drawtext.door_unlock"
                    L16_2 = L16_2(L17_2)
                    if L16_2 then
                      goto lbl_70
                    end
                  end
                  L16_2 = i18n
                  L16_2 = L16_2.t
                  L17_2 = "drawtext.door_lock"
                  L16_2 = L16_2(L17_2)
                  ::lbl_70::
                  L15_2.status = L16_2
                  L13_2 = L13_2(L14_2, L15_2)
                  L14_2 = "open_mlo_door"
                  L15_2 = "E"
                  L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
                  L9_2 = IsControlJustPressed
                  L10_2 = 0
                  L11_2 = 38
                  L9_2 = L9_2(L10_2, L11_2)
                  if L9_2 then
                    L9_2 = DoorAnim
                    L9_2()
                    L9_2 = L8_2.locked
                    L9_2 = not L9_2
                    L10_2 = TriggerServerEvent
                    L11_2 = "qb-houses:SyncDoor"
                    L12_2 = CurrentHouse
                    L13_2 = L8_2.doors
                    L14_2 = L9_2
                    L10_2(L11_2, L12_2, L13_2, L14_2)
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
  L33_1(L34_1)
end






