





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1
L0_1 = lib
L0_1 = L0_1.class
L1_1 = "Junk"
L0_1 = L0_1(L1_1)
L1_1 = 15
function L2_1(A0_2)
  local L1_2
  L1_2 = {}
  A0_2.objects = L1_2
  A0_2.active = false
  A0_2.isLoopRunning = false
  L1_2 = {}
  A0_2.pendingCoordUpdates = L1_2
  return A0_2
end
L0_1.constructor = L2_1
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L3_2 = joaat
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  L4_2 = lib
  L4_2 = L4_2.requestModel
  L5_2 = L3_2
  L6_2 = Config
  L6_2 = L6_2.DefaultRequestModelTimeout
  L4_2(L5_2, L6_2)
  L4_2 = HasModelLoaded
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  if not L4_2 then
    L4_2 = Debug
    L5_2 = "Junk:spawnObject - Model not loaded:"
    L6_2 = A1_2
    L4_2(L5_2, L6_2)
    L4_2 = nil
    return L4_2
  end
  L5_2 = A0_2
  L4_2 = A0_2.getGroundZ
  L6_2 = A2_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = vec3
  L6_2 = A2_2.x
  L7_2 = A2_2.y
  L8_2 = L4_2
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L6_2 = CreateObject
  L7_2 = L3_2
  L8_2 = L5_2.x
  L9_2 = L5_2.y
  L10_2 = L5_2.z
  L11_2 = false
  L12_2 = false
  L13_2 = false
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L7_2 = DoesEntityExist
  L8_2 = L6_2
  L7_2 = L7_2(L8_2)
  if not L7_2 then
    L7_2 = Debug
    L8_2 = "Junk:spawnObject - Failed to create object:"
    L9_2 = A1_2
    L7_2(L8_2, L9_2)
    L7_2 = SetModelAsNoLongerNeeded
    L8_2 = L3_2
    L7_2(L8_2)
    L7_2 = nil
    return L7_2
  end
  L7_2 = PlaceObjectOnGroundProperly
  L8_2 = L6_2
  L7_2(L8_2)
  L7_2 = FreezeEntityPosition
  L8_2 = L6_2
  L9_2 = true
  L7_2(L8_2, L9_2)
  L7_2 = SetEntityAsMissionEntity
  L8_2 = L6_2
  L9_2 = false
  L10_2 = true
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = SetModelAsNoLongerNeeded
  L8_2 = L3_2
  L7_2(L8_2)
  L7_2 = math
  L7_2 = L7_2.random
  L8_2 = 0
  L9_2 = 360
  L7_2 = L7_2(L8_2, L9_2)
  L8_2 = SetEntityHeading
  L9_2 = L6_2
  L10_2 = L7_2 + 0.0
  L8_2(L9_2, L10_2)
  L8_2 = Debug
  L9_2 = "Junk:spawnObject - Spawned:"
  L10_2 = A1_2
  L11_2 = "at"
  L12_2 = L5_2
  L13_2 = "handle:"
  L14_2 = L6_2
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  return L6_2
end
L0_1.spawnObject = L2_1
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = A1_2.z
  L3_2 = GetGroundZFor_3dCoord
  L4_2 = A1_2.x
  L5_2 = A1_2.y
  L6_2 = A1_2.z
  L6_2 = L6_2 + 5.0
  L7_2 = false
  L3_2, L4_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  if L3_2 and L4_2 then
    L2_2 = L4_2
  end
  return L2_2
end
L0_1.getGroundZ = L2_1
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A1_2]
  if not L2_2 then
    L3_2 = false
    L4_2 = nil
    L5_2 = nil
    L6_2 = nil
    return L3_2, L4_2, L5_2, L6_2
  end
  L3_2 = L2_2.tier
  L3_2 = L2_2.coords
  L3_2 = L3_2.shellCoords
  L3_2 = L2_2.ipl
  L3_2 = nil ~= L3_2 and L3_2
  if L3_2 then
    L4_2 = Config
    L4_2 = L4_2.Shells
    L5_2 = L2_2.tier
    L4_2 = L4_2[L5_2]
    if L4_2 then
      L5_2 = L4_2.model
      if L5_2 then
        L5_2 = joaat
        L6_2 = L4_2.model
        L5_2 = L5_2(L6_2)
        L6_2 = lib
        L6_2 = L6_2.requestModel
        L7_2 = L5_2
        L8_2 = Config
        L8_2 = L8_2.DefaultRequestModelTimeout
        L6_2(L7_2, L8_2)
        L6_2 = HasModelLoaded
        L7_2 = L5_2
        L6_2 = L6_2(L7_2)
        if L6_2 then
          L6_2 = GetModelDimensions
          L7_2 = L5_2
          L6_2, L7_2 = L6_2(L7_2)
          L8_2 = L2_2.coords
          L8_2 = L8_2.shellCoords
          L9_2 = vec3
          L10_2 = L8_2.x
          L11_2 = L8_2.y
          L12_2 = L8_2.z
          L9_2 = L9_2(L10_2, L11_2, L12_2)
          L10_2 = SetModelAsNoLongerNeeded
          L11_2 = L5_2
          L10_2(L11_2)
          L10_2 = Debug
          L11_2 = "Junk:getHouseTypeInfo - Shell dimensions:"
          L12_2 = L6_2
          L13_2 = L7_2
          L10_2(L11_2, L12_2, L13_2)
          L10_2 = true
          L11_2 = L9_2
          L12_2 = L6_2
          L13_2 = L7_2
          return L10_2, L11_2, L12_2, L13_2
        end
      end
    end
  end
  L4_2 = false
  L5_2 = nil
  L6_2 = nil
  L7_2 = nil
  return L4_2, L5_2, L6_2, L7_2
end
L0_1.getHouseTypeInfo = L2_1
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A1_2]
  if not L2_2 then
    L3_2 = Debug
    L4_2 = "Junk:generateRandomCoords - No house data for:"
    L5_2 = A1_2
    L3_2(L4_2, L5_2)
    L3_2 = nil
    return L3_2
  end
  L3_2 = L2_2.coords
  L3_2 = L3_2.exit
  if not L3_2 then
    L4_2 = Debug
    L5_2 = "Junk:generateRandomCoords - No exit coords for:"
    L6_2 = A1_2
    L4_2(L5_2, L6_2)
    L4_2 = nil
    return L4_2
  end
  L4_2 = GetEntityCoords
  L5_2 = cache
  L5_2 = L5_2.ped
  L4_2 = L4_2(L5_2)
  L5_2 = GetInteriorAtCoords
  L6_2 = L4_2.x
  L7_2 = L4_2.y
  L8_2 = L4_2.z
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L7_2 = A0_2
  L6_2 = A0_2.getHouseTypeInfo
  L8_2 = A1_2
  L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2, L8_2)
  L10_2 = 1
  L11_2 = L1_1
  L12_2 = 1
  for L13_2 = L10_2, L11_2, L12_2 do
    L14_2 = nil
    if L6_2 and L7_2 and L8_2 and L9_2 then
      L15_2 = 0.7
      L16_2 = L9_2.x
      L17_2 = L8_2.x
      L16_2 = L16_2 - L17_2
      L16_2 = L16_2 / 2
      L16_2 = L16_2 * L15_2
      L17_2 = L9_2.y
      L18_2 = L8_2.y
      L17_2 = L17_2 - L18_2
      L17_2 = L17_2 / 2
      L17_2 = L17_2 * L15_2
      L18_2 = 1.5
      L19_2 = math
      L19_2 = L19_2.random
      L19_2 = L19_2()
      L19_2 = L19_2 * 2
      L20_2 = math
      L20_2 = L20_2.pi
      L19_2 = L19_2 * L20_2
      L20_2 = math
      L20_2 = L20_2.min
      L21_2 = L16_2
      L22_2 = L17_2
      L20_2 = L20_2(L21_2, L22_2)
      L21_2 = math
      L21_2 = L21_2.random
      L21_2 = L21_2()
      L22_2 = L20_2 - L18_2
      L21_2 = L21_2 * L22_2
      L21_2 = L18_2 + L21_2
      L22_2 = vec3
      L23_2 = L7_2.x
      L24_2 = math
      L24_2 = L24_2.cos
      L25_2 = L19_2
      L24_2 = L24_2(L25_2)
      L24_2 = L24_2 * L21_2
      L23_2 = L23_2 + L24_2
      L24_2 = L7_2.y
      L25_2 = math
      L25_2 = L25_2.sin
      L26_2 = L19_2
      L25_2 = L25_2(L26_2)
      L25_2 = L25_2 * L21_2
      L24_2 = L24_2 + L25_2
      L25_2 = L3_2.z
      L22_2 = L22_2(L23_2, L24_2, L25_2)
      L14_2 = L22_2
    else
      L15_2 = L3_2.x
      L16_2 = L3_2.y
      L17_2 = L3_2.z
      L18_2 = 6.0
      L19_2 = 1.5
      L20_2 = math
      L20_2 = L20_2.random
      L20_2 = L20_2()
      L20_2 = L20_2 * 2
      L21_2 = math
      L21_2 = L21_2.pi
      L20_2 = L20_2 * L21_2
      L21_2 = math
      L21_2 = L21_2.random
      L21_2 = L21_2()
      L22_2 = L18_2 - L19_2
      L21_2 = L21_2 * L22_2
      L21_2 = L19_2 + L21_2
      L22_2 = vec3
      L23_2 = math
      L23_2 = L23_2.cos
      L24_2 = L20_2
      L23_2 = L23_2(L24_2)
      L23_2 = L23_2 * L21_2
      L23_2 = L15_2 + L23_2
      L24_2 = math
      L24_2 = L24_2.sin
      L25_2 = L20_2
      L24_2 = L24_2(L25_2)
      L24_2 = L24_2 * L21_2
      L24_2 = L16_2 + L24_2
      L25_2 = L17_2
      L22_2 = L22_2(L23_2, L24_2, L25_2)
      L14_2 = L22_2
      L22_2 = GetInteriorAtCoords
      L23_2 = L14_2.x
      L24_2 = L14_2.y
      L25_2 = L14_2.z
      L22_2 = L22_2(L23_2, L24_2, L25_2)
      if L22_2 ~= L5_2 then
        L23_2 = Debug
        L24_2 = "Junk:generateRandomCoords - Interior mismatch, attempt:"
        L25_2 = L13_2
        L23_2(L24_2, L25_2)
    end
    else
      L15_2 = GetGroundZFor_3dCoord
      L16_2 = L14_2.x
      L17_2 = L14_2.y
      L18_2 = L14_2.z
      L18_2 = L18_2 + 5.0
      L19_2 = false
      L15_2, L16_2 = L15_2(L16_2, L17_2, L18_2, L19_2)
      if L15_2 and L16_2 then
        L17_2 = vec3
        L18_2 = L14_2.x
        L19_2 = L14_2.y
        L20_2 = L16_2
        L17_2 = L17_2(L18_2, L19_2, L20_2)
        L14_2 = L17_2
      end
      L17_2 = vec3
      L18_2 = L3_2.x
      L19_2 = L3_2.y
      L20_2 = L3_2.z
      L17_2 = L17_2(L18_2, L19_2, L20_2)
      L17_2 = L14_2 - L17_2
      L17_2 = #L17_2
      if L17_2 < 20.0 then
        L18_2 = Debug
        L19_2 = "Junk:generateRandomCoords - Generated coords:"
        L20_2 = L14_2
        L21_2 = "for house:"
        L22_2 = A1_2
        L23_2 = "attempt:"
        L24_2 = L13_2
        L18_2(L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
        return L14_2
      end
    end
  end
  L10_2 = Debug
  L11_2 = "Junk:generateRandomCoords - Failed to generate valid coords after"
  L12_2 = L1_1
  L13_2 = "attempts"
  L10_2(L11_2, L12_2, L13_2)
  L10_2 = nil
  return L10_2
end
L0_1.generateRandomCoords = L2_1
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L3_2 = A1_2.spawned
  if L3_2 then
    L3_2 = A1_2.handle
    if L3_2 then
      L3_2 = DoesEntityExist
      L4_2 = A1_2.handle
      L3_2 = L3_2(L4_2)
      if L3_2 then
        L3_2 = Debug
        L4_2 = "Junk:spawnSingle - Already spawned:"
        L5_2 = A1_2.id
        L3_2(L4_2, L5_2)
        return
      end
    end
  end
  L3_2 = A1_2.coords
  L4_2 = false
  if not L3_2 then
    L6_2 = A0_2
    L5_2 = A0_2.generateRandomCoords
    L7_2 = A1_2.house
    L5_2 = L5_2(L6_2, L7_2)
    L3_2 = L5_2
    if not L3_2 then
      L5_2 = Debug
      L6_2 = "Junk:spawnSingle - Failed to generate coords for:"
      L7_2 = A1_2.id
      L5_2(L6_2, L7_2)
      return
    end
    L4_2 = true
  end
  L6_2 = A0_2
  L5_2 = A0_2.spawnObject
  L7_2 = A1_2.model
  L8_2 = L3_2
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  if L5_2 then
    A1_2.coords = L3_2
    A1_2.handle = L5_2
    A1_2.spawned = true
    L6_2 = A0_2.objects
    L7_2 = A1_2.id
    L6_2[L7_2] = A1_2
    L6_2 = Debug
    L7_2 = "Junk:spawnSingle - Spawned junk:"
    L8_2 = A1_2.id
    L9_2 = A1_2.model
    L6_2(L7_2, L8_2, L9_2)
    if L4_2 and not A2_2 then
      L6_2 = A0_2.pendingCoordUpdates
      L7_2 = A1_2.id
      L6_2 = L6_2[L7_2]
      if not L6_2 then
        L6_2 = A0_2.pendingCoordUpdates
        L7_2 = A1_2.id
        L6_2[L7_2] = true
        L6_2 = lib
        L6_2 = L6_2.callback
        L7_2 = "housing:junk:updateCoords"
        L8_2 = false
        function L9_2(A0_3)
          local L1_3, L2_3, L3_3
          L1_3 = A0_2.pendingCoordUpdates
          L2_3 = A1_2.id
          L1_3[L2_3] = nil
          if A0_3 then
            L1_3 = Debug
            L2_3 = "Junk:spawnSingle - Saved coords to server:"
            L3_3 = A1_2.id
            L1_3(L2_3, L3_3)
          else
            L1_3 = Debug
            L2_3 = "Junk:spawnSingle - Failed to save coords to server:"
            L3_3 = A1_2.id
            L1_3(L2_3, L3_3)
          end
        end
        L10_2 = A1_2.id
        L11_2 = {}
        L12_2 = L3_2.x
        L11_2.x = L12_2
        L12_2 = L3_2.y
        L11_2.y = L12_2
        L12_2 = L3_2.z
        L11_2.z = L12_2
        L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
      end
    end
  end
end
L0_1.spawnSingle = L2_1
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = A0_2.objects
  L2_2 = L2_2[A1_2]
  if not L2_2 then
    return
  end
  L3_2 = L2_2.handle
  if L3_2 then
    L3_2 = DoesEntityExist
    L4_2 = L2_2.handle
    L3_2 = L3_2(L4_2)
    if L3_2 then
      L3_2 = DeleteEntity
      L4_2 = L2_2.handle
      L3_2(L4_2)
      L3_2 = Debug
      L4_2 = "Junk:despawn - Despawned:"
      L5_2 = A1_2
      L3_2(L4_2, L5_2)
    end
  end
  L2_2.handle = nil
  L2_2.spawned = false
end
L0_1.despawn = L2_1
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L3_2 = A0_2.objects
  L3_2 = L3_2[A1_2]
  if not L3_2 then
    return
  end
  L4_2 = L3_2.handle
  if L4_2 then
    L5_2 = DoesEntityExist
    L6_2 = L4_2
    L5_2 = L5_2(L6_2)
    if L5_2 then
      goto lbl_19
    end
  end
  L5_2 = A0_2.objects
  L5_2[A1_2] = nil
  L5_2 = A0_2.pendingCoordUpdates
  L5_2[A1_2] = nil
  do return end
  ::lbl_19::
  if not A2_2 then
    A2_2 = 500
  end
  L5_2 = GetGameTimer
  L5_2 = L5_2()
  L6_2 = GetEntityAlpha
  L7_2 = L4_2
  L6_2 = L6_2(L7_2)
  L7_2 = SetEntityAlpha
  L8_2 = L4_2
  L9_2 = L6_2
  L10_2 = false
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = CreateThread
  function L8_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    while true do
      L0_3 = DoesEntityExist
      L1_3 = L4_2
      L0_3 = L0_3(L1_3)
      if not L0_3 then
        break
      end
      L0_3 = GetGameTimer
      L0_3 = L0_3()
      L1_3 = L5_2
      L1_3 = L0_3 - L1_3
      L2_3 = math
      L2_3 = L2_3.min
      L3_3 = A2_2
      L3_3 = L1_3 / L3_3
      L4_3 = 1.0
      L2_3 = L2_3(L3_3, L4_3)
      L3_3 = math
      L3_3 = L3_3.floor
      L4_3 = L6_2
      L5_3 = 1.0
      L5_3 = L5_3 - L2_3
      L4_3 = L4_3 * L5_3
      L3_3 = L3_3(L4_3)
      L4_3 = SetEntityAlpha
      L5_3 = L4_2
      L6_3 = L3_3
      L7_3 = false
      L4_3(L5_3, L6_3, L7_3)
      if L2_3 >= 1.0 then
        L4_3 = Wait
        L5_3 = 50
        L4_3(L5_3)
        L4_3 = DoesEntityExist
        L5_3 = L4_2
        L4_3 = L4_3(L5_3)
        if L4_3 then
          L4_3 = DeleteEntity
          L5_3 = L4_2
          L4_3(L5_3)
        end
        break
      end
      L4_3 = Wait
      L5_3 = 0
      L4_3(L5_3)
    end
    L0_3 = L3_2
    if L0_3 then
      L3_2.handle = nil
      L3_2.spawned = false
    end
    L0_3 = A0_2.objects
    L1_3 = A1_2
    L0_3[L1_3] = nil
    L0_3 = A0_2.pendingCoordUpdates
    L1_3 = A1_2
    L0_3[L1_3] = nil
    L0_3 = Debug
    L1_3 = "Junk:fadeOutAndRemove - Fade-out complete and removed:"
    L2_3 = A1_2
    L0_3(L1_3, L2_3)
  end
  L7_2(L8_2)
end
L0_1.fadeOutAndRemove = L2_1
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = A0_2.objects
  L3_2 = L3_2[A1_2]
  if not L3_2 then
    return
  end
  if nil == A2_2 then
    A2_2 = true
  end
  if A2_2 then
    L4_2 = L3_2.handle
    if L4_2 then
      L4_2 = DoesEntityExist
      L5_2 = L3_2.handle
      L4_2 = L4_2(L5_2)
      if L4_2 then
        L5_2 = A0_2
        L4_2 = A0_2.fadeOutAndRemove
        L6_2 = A1_2
        L7_2 = 500
        L4_2(L5_2, L6_2, L7_2)
    end
  end
  else
    L5_2 = A0_2
    L4_2 = A0_2.despawn
    L6_2 = A1_2
    L4_2(L5_2, L6_2)
    L4_2 = A0_2.objects
    L4_2[A1_2] = nil
    L4_2 = A0_2.pendingCoordUpdates
    L4_2[A1_2] = nil
    L4_2 = Debug
    L5_2 = "Junk:remove - Removed from local cache:"
    L6_2 = A1_2
    L4_2(L5_2, L6_2)
  end
end
L0_1.remove = L2_1
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L2_2 = Config
  L2_2 = L2_2.Cleaning
  if not L2_2 then
    L2_2 = Debug
    L3_2 = "Junk:loadForHouse - Cleaning is disabled"
    L2_2(L3_2)
    return
  end
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:junk:getForHouse"
  L4_2 = false
  L5_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  if L2_2 then
    L3_2 = #L2_2
    if 0 ~= L3_2 then
      goto lbl_26
    end
  end
  L3_2 = Debug
  L4_2 = "Junk:loadForHouse - No junk for house:"
  L5_2 = A1_2
  L3_2(L4_2, L5_2)
  do return end
  ::lbl_26::
  L3_2 = {}
  L4_2 = {}
  L5_2 = ipairs
  L6_2 = L2_2
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = {}
    L12_2 = L10_2.id
    L11_2.id = L12_2
    L12_2 = L10_2.house
    L11_2.house = L12_2
    L12_2 = L10_2.model
    L11_2.model = L12_2
    L12_2 = L10_2.coords
    if L12_2 then
      L12_2 = vec3
      L13_2 = L10_2.coords
      L13_2 = L13_2.x
      L14_2 = L10_2.coords
      L14_2 = L14_2.y
      L15_2 = L10_2.coords
      L15_2 = L15_2.z
      L12_2 = L12_2(L13_2, L14_2, L15_2)
      if L12_2 then
        goto lbl_56
      end
    end
    L12_2 = nil
    ::lbl_56::
    L11_2.coords = L12_2
    L11_2.spawned = false
    L12_2 = L11_2.coords
    if L12_2 then
      L12_2 = table
      L12_2 = L12_2.insert
      L13_2 = L4_2
      L14_2 = L11_2
      L12_2(L13_2, L14_2)
    else
      L12_2 = table
      L12_2 = L12_2.insert
      L13_2 = L3_2
      L14_2 = L11_2
      L12_2(L13_2, L14_2)
    end
  end
  L5_2 = ipairs
  L6_2 = L4_2
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L12_2 = A0_2
    L11_2 = A0_2.spawnSingle
    L13_2 = L10_2
    L14_2 = true
    L11_2(L12_2, L13_2, L14_2)
  end
  L5_2 = #L3_2
  if L5_2 > 0 then
    L5_2 = CreateThread
    function L6_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3
      L0_3 = ipairs
      L1_3 = L3_2
      L0_3, L1_3, L2_3, L3_3 = L0_3(L1_3)
      for L4_3, L5_3 in L0_3, L1_3, L2_3, L3_3 do
        L6_3 = EnteredHouse
        if L6_3 then
          L6_3 = EnteredHouse
          L7_3 = A1_2
          if L6_3 == L7_3 then
            goto lbl_16
          end
        end
        L6_3 = Debug
        L7_3 = "Junk:loadForHouse - Left house during processing"
        L6_3(L7_3)
        do return end
        ::lbl_16::
        L6_3 = A0_2
        L7_3 = L6_3
        L6_3 = L6_3.generateRandomCoords
        L8_3 = L5_3.house
        L6_3 = L6_3(L7_3, L8_3)
        if L6_3 then
          L5_3.coords = L6_3
          L7_3 = A0_2.pendingCoordUpdates
          L8_3 = L5_3.id
          L7_3[L8_3] = true
          L7_3 = lib
          L7_3 = L7_3.callback
          L7_3 = L7_3.await
          L8_3 = "housing:junk:updateCoords"
          L9_3 = false
          L10_3 = L5_3.id
          L11_3 = {}
          L12_3 = L6_3.x
          L11_3.x = L12_3
          L12_3 = L6_3.y
          L11_3.y = L12_3
          L12_3 = L6_3.z
          L11_3.z = L12_3
          L7_3 = L7_3(L8_3, L9_3, L10_3, L11_3)
          L8_3 = A0_2.pendingCoordUpdates
          L9_3 = L5_3.id
          L8_3[L9_3] = nil
          if L7_3 then
            L8_3 = A0_2
            L9_3 = L8_3
            L8_3 = L8_3.spawnSingle
            L10_3 = L5_3
            L11_3 = true
            L8_3(L9_3, L10_3, L11_3)
            L8_3 = Debug
            L9_3 = "Junk:loadForHouse - Processed junk:"
            L10_3 = L5_3.id
            L8_3(L9_3, L10_3)
          else
            L8_3 = Debug
            L9_3 = "Junk:loadForHouse - Failed to update coords for:"
            L10_3 = L5_3.id
            L8_3(L9_3, L10_3)
          end
        end
        L7_3 = Wait
        L8_3 = 50
        L7_3(L8_3)
      end
    end
    L5_2(L6_2)
  end
  L5_2 = Debug
  L6_2 = "Junk:loadForHouse - Loaded"
  L7_2 = #L2_2
  L8_2 = "junk objects for house:"
  L9_2 = A1_2
  L5_2(L6_2, L7_2, L8_2, L9_2)
end
L0_1.loadForHouse = L2_1
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = pairs
  L3_2 = A0_2.objects
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = L7_2.house
    if L8_2 == A1_2 then
      L9_2 = A0_2
      L8_2 = A0_2.despawn
      L10_2 = L6_2
      L8_2(L9_2, L10_2)
      L8_2 = A0_2.objects
      L8_2[L6_2] = nil
    end
  end
  L2_2 = {}
  A0_2.pendingCoordUpdates = L2_2
  L2_2 = Debug
  L3_2 = "Junk:unloadForHouse - Unloaded all junk for house:"
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
end
L0_1.unloadForHouse = L2_1
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = pairs
  L2_2 = A0_2.objects
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = A0_2
    L6_2 = A0_2.despawn
    L8_2 = L5_2
    L6_2(L7_2, L8_2)
  end
  L1_2 = {}
  A0_2.objects = L1_2
  L1_2 = {}
  A0_2.pendingCoordUpdates = L1_2
  L1_2 = Debug
  L2_2 = "Junk:cleanAll - Cleaned all junk"
  L1_2(L2_2)
end
L0_1.cleanAll = L2_1
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  L3_2 = CurrentHouseData
  if L3_2 then
    L3_2 = CurrentHouseData
    L3_2 = L3_2.haskey
    if L3_2 then
      goto lbl_16
    end
  end
  L3_2 = Notification
  L4_2 = i18n
  L4_2 = L4_2.t
  L5_2 = "junk.no_permission"
  L4_2 = L4_2(L5_2)
  L5_2 = "error"
  L3_2(L4_2, L5_2)
  do return end
  ::lbl_16::
  L3_2 = A0_2.objects
  L3_2 = L3_2[A1_2]
  if not L3_2 then
    L4_2 = Notification
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "junk.not_found"
    L5_2 = L5_2(L6_2)
    L6_2 = "error"
    L4_2(L5_2, L6_2)
    return
  end
  L4_2 = "amb@world_human_janitor@male@idle_a"
  L5_2 = "idle_a"
  L6_2 = joaat
  L7_2 = "prop_tool_broom"
  L6_2 = L6_2(L7_2)
  L7_2 = lib
  L7_2 = L7_2.requestModel
  L8_2 = L6_2
  L7_2(L8_2)
  L7_2 = GetOffsetFromEntityInWorldCoords
  L8_2 = cache
  L8_2 = L8_2.ped
  L9_2 = 0.0
  L10_2 = 0.0
  L11_2 = -5.0
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
  L8_2 = CreateObject
  L9_2 = L6_2
  L10_2 = L7_2.x
  L11_2 = L7_2.y
  L12_2 = L7_2.z
  L13_2 = true
  L14_2 = true
  L15_2 = true
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L9_2 = lib
  L9_2 = L9_2.requestAnimDict
  L10_2 = L4_2
  L9_2(L10_2)
  L9_2 = TaskPlayAnim
  L10_2 = cache
  L10_2 = L10_2.ped
  L11_2 = L4_2
  L12_2 = L5_2
  L13_2 = 8.0
  L14_2 = -8.0
  L15_2 = -1
  L16_2 = 0
  L17_2 = 0
  L18_2 = false
  L19_2 = false
  L20_2 = false
  L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  L9_2 = AttachEntityToEntity
  L10_2 = L8_2
  L11_2 = cache
  L11_2 = L11_2.ped
  L12_2 = GetPedBoneIndex
  L13_2 = cache
  L13_2 = L13_2.ped
  L14_2 = 28422
  L12_2 = L12_2(L13_2, L14_2)
  L13_2 = -0.005
  L14_2 = 0.0
  L15_2 = 0.0
  L16_2 = 360.0
  L17_2 = 360.0
  L18_2 = 0.0
  L19_2 = 1
  L20_2 = 1
  L21_2 = 0
  L22_2 = 1
  L23_2 = 0
  L24_2 = 1
  L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  L9_2 = lib
  L9_2 = L9_2.progressCircle
  L10_2 = {}
  L10_2.duration = 3000
  L11_2 = i18n
  L11_2 = L11_2.t
  L12_2 = "junk.cleaning"
  L11_2 = L11_2(L12_2)
  L10_2.label = L11_2
  L10_2.position = "bottom"
  L10_2.useWhileDead = false
  L10_2.canCancel = true
  L11_2 = {}
  L11_2.car = true
  L11_2.move = true
  L11_2.combat = true
  L10_2.disable = L11_2
  L9_2 = L9_2(L10_2)
  if L9_2 then
    L9_2 = ClearPedTasks
    L10_2 = cache
    L10_2 = L10_2.ped
    L9_2(L10_2)
    L9_2 = DeleteEntity
    L10_2 = L8_2
    L9_2(L10_2)
    L9_2 = lib
    L9_2 = L9_2.callback
    L9_2 = L9_2.await
    L10_2 = "housing:junk:remove"
    L11_2 = false
    L12_2 = A1_2
    L13_2 = A2_2
    L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
    if L9_2 then
      L11_2 = A0_2
      L10_2 = A0_2.remove
      L12_2 = A1_2
      L10_2(L11_2, L12_2)
      L10_2 = Notification
      L11_2 = i18n
      L11_2 = L11_2.t
      L12_2 = "junk.cleaned"
      L11_2 = L11_2(L12_2)
      L12_2 = "success"
      L10_2(L11_2, L12_2)
    else
      L10_2 = Notification
      L11_2 = i18n
      L11_2 = L11_2.t
      L12_2 = "junk.failed"
      L11_2 = L11_2(L12_2)
      L12_2 = "error"
      L10_2(L11_2, L12_2)
    end
  else
    L9_2 = ClearPedTasks
    L10_2 = cache
    L10_2 = L10_2.ped
    L9_2(L10_2)
    L9_2 = Notification
    L10_2 = i18n
    L10_2 = L10_2.t
    L11_2 = "junk.cancelled"
    L10_2 = L10_2(L11_2)
    L11_2 = "info"
    L9_2(L10_2, L11_2)
  end
end
L0_1.pickup = L2_1
function L2_1(A0_2, A1_2)
  local L2_2
  L2_2 = A0_2.objects
  L2_2 = L2_2[A1_2]
  return L2_2
end
L0_1.get = L2_1
function L2_1(A0_2)
  local L1_2
  L1_2 = A0_2.objects
  return L1_2
end
L0_1.getAll = L2_1
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = GetEntityCoords
  L2_2 = cache
  L2_2 = L2_2.ped
  L1_2 = L1_2(L2_2)
  L2_2 = nil
  L3_2 = 2.0
  L4_2 = pairs
  L5_2 = A0_2.objects
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = L9_2.spawned
    if L10_2 then
      L10_2 = L9_2.handle
      if L10_2 then
        L10_2 = DoesEntityExist
        L11_2 = L9_2.handle
        L10_2 = L10_2(L11_2)
        if L10_2 then
          L10_2 = GetEntityCoords
          L11_2 = L9_2.handle
          L10_2 = L10_2(L11_2)
          L11_2 = L1_2 - L10_2
          L11_2 = #L11_2
          if L3_2 > L11_2 then
            L3_2 = L11_2
            L2_2 = L8_2
          end
        end
      end
    end
  end
  return L2_2
end
L0_1.findNearby = L2_1
L2_1 = i18n
L2_1 = L2_1.t
L3_1 = "junk.press_to_clean"
L2_1 = L2_1(L3_1)
function L3_1(A0_2)
  local L1_2, L2_2
  L1_2 = A0_2.isLoopRunning
  if L1_2 then
    return
  end
  A0_2.active = true
  A0_2.isLoopRunning = true
  L1_2 = CreateThread
  function L2_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    while true do
      L0_3 = A0_2.active
      if not L0_3 then
        break
      end
      L0_3 = EnteredHouse
      if not L0_3 then
        break
      end
      L0_3 = A0_2
      L1_3 = L0_3
      L0_3 = L0_3.findNearby
      L0_3 = L0_3(L1_3)
      L1_3 = 500
      if L0_3 then
        L2_3 = Config
        L2_3 = L2_3.UseTarget
        if not L2_3 then
          L2_3 = A0_2.objects
          L2_3 = L2_3[L0_3]
          if L2_3 then
            L3_3 = L2_3.handle
            if L3_3 then
              L3_3 = DoesEntityExist
              L4_3 = L2_3.handle
              L3_3 = L3_3(L4_3)
              if L3_3 then
                L1_3 = 0
                L3_3 = GetEntityCoords
                L4_3 = L2_3.handle
                L3_3 = L3_3(L4_3)
                L4_3 = DrawText3D
                L5_3 = L3_3.x
                L6_3 = L3_3.y
                L7_3 = L3_3.z
                L7_3 = L7_3 + 0.3
                L8_3 = L2_1
                L9_3 = "clean_junk"
                L10_3 = "E"
                L4_3(L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
                L4_3 = IsControlJustPressed
                L5_3 = 0
                L6_3 = Keys
                L6_3 = L6_3.E
                L4_3 = L4_3(L5_3, L6_3)
                if L4_3 then
                  L4_3 = A0_2
                  L5_3 = L4_3
                  L4_3 = L4_3.pickup
                  L6_3 = L0_3
                  L7_3 = EnteredHouse
                  L4_3(L5_3, L6_3, L7_3)
                end
              end
            end
          end
        end
      end
      L2_3 = Wait
      L3_3 = L1_3
      L2_3(L3_3)
    end
    A0_2.isLoopRunning = false
    A0_2.active = false
  end
  L1_2(L2_2)
end
L0_1.startInteractionLoop = L3_1
function L3_1(A0_2)
  local L1_2
  A0_2.active = false
end
L0_1.stopInteractionLoop = L3_1
L3_1 = _G
L5_1 = L0_1
L4_1 = L0_1.new
L4_1 = L4_1(L5_1)
L3_1.junk = L4_1
L3_1 = RegisterNetEvent
L4_1 = "housing:junk:spawn"
function L5_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = EnteredHouse
  if L1_2 then
    L1_2 = EnteredHouse
    L2_2 = A0_2.house
    if L1_2 == L2_2 then
      goto lbl_9
    end
  end
  do return end
  ::lbl_9::
  L1_2 = {}
  L2_2 = A0_2.id
  L1_2.id = L2_2
  L2_2 = A0_2.house
  L1_2.house = L2_2
  L2_2 = A0_2.model
  L1_2.model = L2_2
  L1_2.coords = nil
  L1_2.spawned = false
  L2_2 = junk
  L3_2 = L2_2
  L2_2 = L2_2.spawnSingle
  L4_2 = L1_2
  L2_2(L3_2, L4_2)
  L2_2 = Debug
  L3_2 = "housing:junk:spawn - New junk spawned:"
  L4_2 = A0_2.id
  L2_2(L3_2, L4_2)
end
L3_1(L4_1, L5_1)
L3_1 = RegisterNetEvent
L4_1 = "housing:junk:remove"
function L5_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = junk
  L2_2 = L1_2
  L1_2 = L1_2.remove
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
  L1_2 = Debug
  L2_2 = "housing:junk:remove - Junk removed:"
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L3_1(L4_1, L5_1)
L3_1 = AddEventHandler
L4_1 = "housing:onEnterHouse"
function L5_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = Config
  L1_2 = L1_2.Cleaning
  if not L1_2 then
    return
  end
  L1_2 = Wait
  L2_2 = 1000
  L1_2(L2_2)
  L1_2 = junk
  L2_2 = L1_2
  L1_2 = L1_2.loadForHouse
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
  L1_2 = junk
  L2_2 = L1_2
  L1_2 = L1_2.startInteractionLoop
  L1_2(L2_2)
end
L3_1(L4_1, L5_1)
L3_1 = AddEventHandler
L4_1 = "housing:onExitHouse"
function L5_1(A0_2)
  local L1_2, L2_2
  L1_2 = junk
  L2_2 = L1_2
  L1_2 = L1_2.stopInteractionLoop
  L1_2(L2_2)
  L1_2 = junk
  L2_2 = L1_2
  L1_2 = L1_2.cleanAll
  L1_2(L2_2)
end
L3_1(L4_1, L5_1)
L3_1 = AddEventHandler
L4_1 = "onResourceStop"
function L5_1(A0_2)
  local L1_2, L2_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 == L1_2 then
    L1_2 = junk
    L2_2 = L1_2
    L1_2 = L1_2.cleanAll
    L1_2(L2_2)
  end
end
L3_1(L4_1, L5_1)






