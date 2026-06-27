





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1
L0_1 = require
L1_1 = "glm"
L0_1 = L0_1(L1_1)
L0_1 = L0_1.sincos
L1_1 = require
L2_1 = "glm"
L1_1 = L1_1(L2_1)
L1_1 = L1_1.rad
L2_1 = lib
L2_1 = L2_1.class
L3_1 = "CleanerRobot"
L2_1 = L2_1(L3_1)
function L3_1()
  local L0_2, L1_2, L2_2
  L0_2 = Config
  L0_2 = L0_2.CleanerRobot
  if not L0_2 then
    L0_2 = {}
  end
  L1_2 = {}
  L2_2 = L0_2.moveSpeed
  if not L2_2 then
    L2_2 = 0.012
  end
  L1_2.moveSpeed = L2_2
  L2_2 = L0_2.maxSpeed
  if not L2_2 then
    L2_2 = 0.018
  end
  L1_2.maxSpeed = L2_2
  L2_2 = L0_2.acceleration
  if not L2_2 then
    L2_2 = 3.0E-4
  end
  L1_2.acceleration = L2_2
  L2_2 = L0_2.deceleration
  if not L2_2 then
    L2_2 = 8.0E-4
  end
  L1_2.deceleration = L2_2
  L2_2 = L0_2.raycastDistance
  if not L2_2 then
    L2_2 = 0.8
  end
  L1_2.raycastDistance = L2_2
  L2_2 = L0_2.junkDetectRadius
  if not L2_2 then
    L2_2 = 15.0
  end
  L1_2.junkDetectRadius = L2_2
  L2_2 = L0_2.maxDistanceFromDock
  if not L2_2 then
    L2_2 = 15.0
  end
  L1_2.maxDistanceFromDock = L2_2
  L2_2 = L0_2.cleaningTimeout
  if not L2_2 then
    L2_2 = 300000
  end
  L1_2.cleaningTimeout = L2_2
  L2_2 = L0_2.randomDirectionTime
  if not L2_2 then
    L2_2 = 8000
  end
  L1_2.randomDirectionTime = L2_2
  L2_2 = L0_2.maxStuckTime
  if not L2_2 then
    L2_2 = 3000
  end
  L1_2.maxStuckTime = L2_2
  L2_2 = L0_2.wobbleEnabled
  L2_2 = false ~= L2_2
  L1_2.wobbleEnabled = L2_2
  L2_2 = L0_2.wobbleAmount
  if not L2_2 then
    L2_2 = 0.15
  end
  L1_2.wobbleAmount = L2_2
  L2_2 = L0_2.wobbleSpeed
  if not L2_2 then
    L2_2 = 0.08
  end
  L1_2.wobbleSpeed = L2_2
  return L1_2
end
L4_1 = 16
L5_1 = 0.3
function L6_1(A0_2)
  local L1_2, L2_2
  L1_2 = L3_1
  L1_2 = L1_2()
  L2_2 = {}
  A0_2.robots = L2_2
  A0_2.activeThread = false
  A0_2.interactionThread = false
  L2_2 = L1_2.moveSpeed
  A0_2.moveSpeed = L2_2
  L2_2 = L1_2.maxSpeed
  A0_2.maxSpeed = L2_2
  L2_2 = L1_2.acceleration
  A0_2.acceleration = L2_2
  L2_2 = L1_2.deceleration
  A0_2.deceleration = L2_2
  L2_2 = L1_2.raycastDistance
  A0_2.raycastDistance = L2_2
  L2_2 = L1_2.junkDetectRadius
  A0_2.junkDetectRadius = L2_2
  L2_2 = L1_2.maxDistanceFromDock
  A0_2.maxDistanceFromDock = L2_2
  L2_2 = L1_2.cleaningTimeout
  A0_2.cleaningTimeout = L2_2
  L2_2 = L1_2.randomDirectionTime
  A0_2.randomDirectionTime = L2_2
  L2_2 = L1_2.maxStuckTime
  A0_2.maxStuckTime = L2_2
  L2_2 = L1_2.wobbleEnabled
  A0_2.wobbleEnabled = L2_2
  L2_2 = L1_2.wobbleAmount
  A0_2.wobbleAmount = L2_2
  L2_2 = L1_2.wobbleSpeed
  A0_2.wobbleSpeed = L2_2
  L2_2 = {}
  A0_2.cleanerModels = L2_2
  return A0_2
end
L2_1.constructor = L6_1
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L1_2 = {}
  A0_2.cleanerModels = L1_2
  L1_2 = pairs
  L2_2 = Config
  L2_2 = L2_2.Furniture
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = L6_2.items
    if L7_2 then
      L7_2 = ipairs
      L8_2 = L6_2.items
      L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
      for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
        L13_2 = L12_2.isCleanerRobot
        if L13_2 then
          L13_2 = A0_2.cleanerModels
          L14_2 = L12_2.object
          L15_2 = {}
          L16_2 = L12_2.object
          L15_2.model = L16_2
          L16_2 = L12_2.isCleanerRobot
          L16_2 = L16_2.dockerModel
          L15_2.dockerModel = L16_2
          L13_2[L14_2] = L15_2
        end
        L13_2 = L12_2.colors
        if L13_2 then
          L13_2 = pairs
          L14_2 = L12_2.colors
          L13_2, L14_2, L15_2, L16_2 = L13_2(L14_2)
          for L17_2, L18_2 in L13_2, L14_2, L15_2, L16_2 do
            L19_2 = L18_2.isCleanerRobot
            if L19_2 then
              L19_2 = A0_2.cleanerModels
              L20_2 = L18_2.object
              L21_2 = {}
              L22_2 = L18_2.object
              L21_2.model = L22_2
              L22_2 = L18_2.isCleanerRobot
              L22_2 = L22_2.dockerModel
              L21_2.dockerModel = L22_2
              L19_2[L20_2] = L21_2
            end
          end
        end
      end
    end
  end
end
L2_1.buildModelList = L6_1
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = A0_2.cleanerModels
  L2_2 = L2_2[A1_2]
  L3_2 = nil ~= L2_2
  L4_2 = L2_2
  return L3_2, L4_2
end
L2_1.isCleanerModel = L6_1
function L6_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L5_2 = A2_2 * A3_2
  L5_2 = A1_2 + L5_2
  L6_2 = _ENV
  L7_2 = "StartExpensiveSynchronousShapeTestLosProbe"
  L6_2 = L6_2[L7_2]
  L7_2 = A1_2.x
  L8_2 = A1_2.y
  L9_2 = A1_2.z
  L10_2 = L5_2.x
  L11_2 = L5_2.y
  L12_2 = L5_2.z
  L13_2 = 17
  if A4_2 then
    L14_2 = A4_2[1]
    if L14_2 then
      goto lbl_21
    end
  end
  L14_2 = 0
  ::lbl_21::
  L15_2 = 4
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L7_2 = GetShapeTestResultIncludingMaterial
  L8_2 = L6_2
  L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L7_2(L8_2)
  if 1 == L8_2 then
    L13_2 = true
    L14_2 = vec3
    L15_2 = L9_2.x
    L16_2 = L9_2.y
    L17_2 = L9_2.z
    L14_2 = L14_2(L15_2, L16_2, L17_2)
    L15_2 = L12_2
    return L13_2, L14_2, L15_2
  end
  L13_2 = false
  L14_2 = nil
  L15_2 = nil
  return L13_2, L14_2, L15_2
end
L2_1.performRaycast = L6_1
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = L0_1
  L3_2 = L1_1
  L4_2 = vec3
  L5_2 = 0
  L6_2 = 0
  L7_2 = A1_2
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2, L6_2, L7_2)
  L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L2_2, L3_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L4_2 = vec3
  L5_2 = L2_2.z
  L6_2 = L3_2.z
  L7_2 = 0.0
  return L4_2(L5_2, L6_2, L7_2)
end
L2_1.headingToDirection = L6_1
function L6_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L3_2 = DoesEntityExist
  L4_2 = A1_2.robotHandle
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = GetEntityCoords
  L4_2 = A1_2.robotHandle
  L3_2 = L3_2(L4_2)
  L5_2 = A0_2
  L4_2 = A0_2.normalizeAngle
  L6_2 = A2_2
  L4_2 = L4_2(L5_2, L6_2)
  L6_2 = A0_2
  L5_2 = A0_2.headingToDirection
  L7_2 = L4_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = vec3
  L7_2 = L3_2.x
  L8_2 = L3_2.y
  L9_2 = L3_2.z
  L9_2 = L9_2 + 0.15
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L8_2 = A0_2
  L7_2 = A0_2.performRaycast
  L9_2 = L6_2
  L10_2 = L5_2
  L11_2 = A0_2.raycastDistance
  L12_2 = {}
  L13_2 = A1_2.dockHandle
  L12_2[1] = L13_2
  L7_2, L8_2, L9_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
  if L7_2 then
    L10_2 = A1_2.dockHandle
    if L9_2 ~= L10_2 then
      if L8_2 then
        L10_2 = L3_2 - L8_2
        L10_2 = #L10_2
        L11_2 = Debug
        L12_2 = "CleanerRobot: Hit obstacle in direction:"
        L13_2 = L4_2
        L14_2 = "distance"
        L15_2 = L10_2
        L11_2(L12_2, L13_2, L14_2, L15_2)
        L11_2 = A0_2.raycastDistance
        L11_2 = L10_2 >= L11_2
        return L11_2
      end
      L10_2 = false
      return L10_2
    end
  end
  L10_2 = true
  return L10_2
end
L2_1.canMoveInDirection = L6_1
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = DoesEntityExist
  L3_2 = A1_2.robotHandle
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = A1_2.currentHeading
  if not L2_2 then
    L2_2 = GetEntityHeading
    L3_2 = A1_2.robotHandle
    L2_2 = L2_2(L3_2)
  end
  L4_2 = A0_2
  L3_2 = A0_2.canMoveInDirection
  L5_2 = A1_2
  L6_2 = L2_2
  return L3_2(L4_2, L5_2, L6_2)
end
L2_1.isForwardClear = L6_1
L6_1 = 0.4
L7_1 = 1.5
L8_1 = 0.4
L9_1 = 2.0
L10_1 = 15
L11_1 = 0.3
function L12_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L4_2 = DoesEntityExist
  L5_2 = A1_2.robotHandle
  L4_2 = L4_2(L5_2)
  if not L4_2 then
    return A3_2
  end
  L4_2 = GetEntityCoords
  L5_2 = A1_2.robotHandle
  L4_2 = L4_2(L5_2)
  L6_2 = A0_2
  L5_2 = A0_2.headingToDirection
  L7_2 = A2_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = vec3
  L7_2 = L4_2.x
  L8_2 = L4_2.y
  L9_2 = L4_2.z
  L9_2 = L9_2 + 0.15
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L8_2 = A0_2
  L7_2 = A0_2.performRaycast
  L9_2 = L6_2
  L10_2 = L5_2
  L11_2 = A3_2
  L12_2 = {}
  L13_2 = A1_2.robotHandle
  L14_2 = A1_2.dockHandle
  L12_2[1] = L13_2
  L12_2[2] = L14_2
  L7_2, L8_2, L9_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
  if L7_2 then
    L10_2 = A1_2.dockHandle
    if L9_2 ~= L10_2 and L8_2 then
      L10_2 = L4_2 - L8_2
      L10_2 = #L10_2
      return L10_2
    end
  end
  return A3_2
end
L2_1.getDistanceInDirection = L12_1
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = A1_2.currentHeading
  if not L2_2 then
    L2_2 = GetEntityHeading
    L3_2 = A1_2.robotHandle
    L2_2 = L2_2(L3_2)
    if not L2_2 then
      L2_2 = 0
    end
  end
  A1_2.navState = "moving"
  A1_2.moveDirection = L2_2
  A1_2.lastWallDistance = nil
  A1_2.wallFollowStartTime = nil
  A1_2.openingDetected = false
  A1_2.openingDirection = nil
  A1_2.turnCompletePosition = nil
  A1_2.isInitialized = true
  L3_2 = Debug
  L4_2 = "CleanerRobot: Wall-following initialized, direction:"
  L5_2 = A1_2.moveDirection
  L3_2(L4_2, L5_2)
end
L2_1.initRoombaState = L12_1
function L12_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2
  L5_2 = A0_2
  L4_2 = A0_2.getDistanceInDirection
  L6_2 = A1_2
  L7_2 = A2_2
  L8_2 = A3_2
  return L4_2(L5_2, L6_2, L7_2, L8_2)
end
L2_1.getWallDistance = L12_1
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L3_2 = A0_2
  L2_2 = A0_2.getWallDistance
  L4_2 = A1_2
  L5_2 = A1_2.moveDirection
  L6_2 = L6_1
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = L6_1
  L3_2 = L2_2 < L3_2
  L4_2 = L2_2
  return L3_2, L4_2
end
L2_1.isFrontBlocked = L12_1
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = A0_2
  L2_2 = A0_2.normalizeAngle
  L4_2 = A1_2.moveDirection
  L4_2 = L4_2 - 90
  L2_2 = L2_2(L3_2, L4_2)
  L4_2 = A0_2
  L3_2 = A0_2.getWallDistance
  L5_2 = A1_2
  L6_2 = L2_2
  L7_2 = L8_1
  return L3_2(L4_2, L5_2, L6_2, L7_2)
end
L2_1.getRightWallDistance = L12_1
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = A0_2
  L2_2 = A0_2.getRightWallDistance
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = A1_2.lastWallDistance
  if not L3_2 then
    L3_2 = L2_2
  end
  L4_2 = L2_2 - L3_2
  L5_2 = L9_1
  if L4_2 > L5_2 then
    L5_2 = A0_2
    L4_2 = A0_2.normalizeAngle
    L6_2 = A1_2.moveDirection
    L6_2 = L6_2 - 90
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = Debug
    L6_2 = "CleanerRobot: Opening detected! Distance jump from"
    L7_2 = L3_2
    L8_2 = "to"
    L9_2 = L2_2
    L5_2(L6_2, L7_2, L8_2, L9_2)
    L5_2 = true
    L6_2 = L4_2
    return L5_2, L6_2
  end
  L4_2 = false
  L5_2 = 0
  return L4_2, L5_2
end
L2_1.checkRightOpening = L12_1
function L12_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L3_2 = {}
  L4_2 = GetEntityCoords
  L5_2 = A1_2.robotHandle
  L4_2 = L4_2(L5_2)
  if not A2_2 then
    A2_2 = A0_2.maxDistanceFromDock
  end
  L5_2 = junk
  L6_2 = L5_2
  L5_2 = L5_2.getAll
  L5_2 = L5_2(L6_2)
  if not L5_2 then
    return L3_2
  end
  L6_2 = pairs
  L7_2 = L5_2
  L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
  for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
    L12_2 = false
    L13_2 = ipairs
    L14_2 = A1_2.cleanedJunk
    L13_2, L14_2, L15_2, L16_2 = L13_2(L14_2)
    for L17_2, L18_2 in L13_2, L14_2, L15_2, L16_2 do
      if L18_2 == L10_2 then
        L12_2 = true
        break
      end
    end
    if not L12_2 then
      L13_2 = L11_2.handle
      if L13_2 then
        L13_2 = DoesEntityExist
        L14_2 = L11_2.handle
        L13_2 = L13_2(L14_2)
        if L13_2 then
          L13_2 = GetEntityCoords
          L14_2 = L11_2.handle
          L13_2 = L13_2(L14_2)
          L14_2 = L4_2 - L13_2
          L14_2 = #L14_2
          if A2_2 >= L14_2 then
            L15_2 = table
            L15_2 = L15_2.insert
            L16_2 = L3_2
            L17_2 = {}
            L17_2.id = L10_2
            L17_2.coords = L13_2
            L17_2.distance = L14_2
            L18_2 = L11_2.handle
            L17_2.handle = L18_2
            L15_2(L16_2, L17_2)
          end
        end
      end
    end
  end
  L6_2 = table
  L6_2 = L6_2.sort
  L7_2 = L3_2
  function L8_2(A0_3, A1_3)
    local L2_3, L3_3
    L2_3 = A0_3.distance
    L3_3 = A1_3.distance
    L2_3 = L2_3 < L3_3
    return L2_3
  end
  L6_2(L7_2, L8_2)
  return L3_2
end
L2_1.findAllJunkInRange = L12_1
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L3_2 = A0_2
  L2_2 = A0_2.findAllJunkInRange
  L4_2 = A1_2
  L5_2 = A0_2.maxDistanceFromDock
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = #L2_2
  if L3_2 > 0 then
    L3_2 = L2_2[1]
    L4_2 = L3_2.handle
    if L4_2 then
      L4_2 = DoesEntityExist
      L5_2 = L3_2.handle
      L4_2 = L4_2(L5_2)
      if L4_2 then
        L4_2 = L3_2.id
        L5_2 = L3_2.coords
        return L4_2, L5_2
      end
    end
  end
  L3_2 = nil
  L4_2 = nil
  return L3_2, L4_2
end
L2_1.findNearbyJunk = L12_1
function L12_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  if not A2_2 then
    A2_2 = 1.5
  end
  L3_2 = GetEntityCoords
  L4_2 = A1_2.robotHandle
  L3_2 = L3_2(L4_2)
  L4_2 = junk
  L5_2 = L4_2
  L4_2 = L4_2.getAll
  L4_2 = L4_2(L5_2)
  if not L4_2 then
    L5_2 = nil
    L6_2 = nil
    L7_2 = nil
    return L5_2, L6_2, L7_2
  end
  L5_2 = nil
  L6_2 = math
  L6_2 = L6_2.huge
  L7_2 = pairs
  L8_2 = L4_2
  L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
  for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
    L13_2 = false
    L14_2 = ipairs
    L15_2 = A1_2.cleanedJunk
    L14_2, L15_2, L16_2, L17_2 = L14_2(L15_2)
    for L18_2, L19_2 in L14_2, L15_2, L16_2, L17_2 do
      if L19_2 == L11_2 then
        L13_2 = true
        break
      end
    end
    if not L13_2 then
      L14_2 = L12_2.handle
      if L14_2 then
        L14_2 = DoesEntityExist
        L15_2 = L12_2.handle
        L14_2 = L14_2(L15_2)
        if L14_2 then
          L14_2 = GetEntityCoords
          L15_2 = L12_2.handle
          L14_2 = L14_2(L15_2)
          L15_2 = L3_2 - L14_2
          L15_2 = #L15_2
          if A2_2 >= L15_2 and L6_2 > L15_2 then
            L16_2 = {}
            L16_2.id = L11_2
            L16_2.coords = L14_2
            L16_2.distance = L15_2
            L5_2 = L16_2
            L6_2 = L15_2
          end
        end
      end
    end
  end
  if L5_2 then
    L7_2 = L5_2.id
    L8_2 = L5_2.coords
    L9_2 = L5_2.distance
    return L7_2, L8_2, L9_2
  end
  L7_2 = nil
  L8_2 = nil
  L9_2 = nil
  return L7_2, L8_2, L9_2
end
L2_1.findVeryCloseJunk = L12_1
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L2_2 = GetEntityCoords
  L3_2 = A1_2.robotHandle
  L2_2 = L2_2(L3_2)
  L3_2 = junk
  L4_2 = L3_2
  L3_2 = L3_2.getAll
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L4_2 = nil
    L5_2 = nil
    L6_2 = nil
    return L4_2, L5_2, L6_2
  end
  L4_2 = {}
  L5_2 = pairs
  L6_2 = L3_2
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = false
    L12_2 = ipairs
    L13_2 = A1_2.cleanedJunk
    L12_2, L13_2, L14_2, L15_2 = L12_2(L13_2)
    for L16_2, L17_2 in L12_2, L13_2, L14_2, L15_2 do
      if L17_2 == L9_2 then
        L11_2 = true
        break
      end
    end
    if not L11_2 then
      L12_2 = L10_2.handle
      if L12_2 then
        L12_2 = DoesEntityExist
        L13_2 = L10_2.handle
        L12_2 = L12_2(L13_2)
        if L12_2 then
          L12_2 = GetEntityCoords
          L13_2 = L10_2.handle
          L12_2 = L12_2(L13_2)
          L13_2 = L2_2 - L12_2
          L13_2 = #L13_2
          L15_2 = A0_2
          L14_2 = A0_2.isJunkVisible
          L16_2 = A1_2
          L17_2 = L10_2.handle
          L14_2 = L14_2(L15_2, L16_2, L17_2)
          if L14_2 then
            L14_2 = table
            L14_2 = L14_2.insert
            L15_2 = L4_2
            L16_2 = {}
            L16_2.id = L9_2
            L16_2.coords = L12_2
            L16_2.distance = L13_2
            L14_2(L15_2, L16_2)
          end
        end
      end
    end
  end
  L5_2 = #L4_2
  if 0 == L5_2 then
    L5_2 = nil
    L6_2 = nil
    L7_2 = nil
    return L5_2, L6_2, L7_2
  end
  L5_2 = table
  L5_2 = L5_2.sort
  L6_2 = L4_2
  function L7_2(A0_3, A1_3)
    local L2_3, L3_3
    L2_3 = A0_3.distance
    L3_3 = A1_3.distance
    L2_3 = L2_3 < L3_3
    return L2_3
  end
  L5_2(L6_2, L7_2)
  L5_2 = L4_2[1]
  L6_2 = L5_2.id
  L7_2 = L5_2.coords
  L8_2 = L5_2.distance
  return L6_2, L7_2, L8_2
end
L2_1.findVisibleJunk = L12_1
function L12_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L3_2 = false
  L4_2 = ipairs
  L5_2 = A1_2.cleanedJunk
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    if L9_2 == A2_2 then
      L3_2 = true
      break
    end
  end
  if L3_2 then
    L4_2 = Debug
    L5_2 = "CleanerRobot: Junk already cleaned:"
    L6_2 = A2_2
    L4_2(L5_2, L6_2)
    return
  end
  L4_2 = table
  L4_2 = L4_2.insert
  L5_2 = A1_2.cleanedJunk
  L6_2 = A2_2
  L4_2(L5_2, L6_2)
  L4_2 = junk
  L5_2 = L4_2
  L4_2 = L4_2.getAll
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L5_2 = L4_2[A2_2]
    if L5_2 then
      L5_2 = L4_2[A2_2]
      L5_2 = L5_2.handle
      if L5_2 then
        L5_2 = DoesEntityExist
        L6_2 = L4_2[A2_2]
        L6_2 = L6_2.handle
        L5_2 = L5_2(L6_2)
        if L5_2 then
          L5_2 = SetEntityDrawOutline
          L6_2 = L4_2[A2_2]
          L6_2 = L6_2.handle
          L7_2 = false
          L5_2(L6_2, L7_2)
        end
      end
    end
  end
  L5_2 = lib
  L5_2 = L5_2.callback
  L5_2 = L5_2.await
  L6_2 = "housing:junk:remove"
  L7_2 = false
  L8_2 = A2_2
  L9_2 = A1_2.house
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  if L5_2 then
    L6_2 = junk
    L7_2 = L6_2
    L6_2 = L6_2.remove
    L8_2 = A2_2
    L6_2(L7_2, L8_2)
    L6_2 = Debug
    L7_2 = "CleanerRobot: Cleaned and removed junk"
    L8_2 = A2_2
    L6_2(L7_2, L8_2)
    L6_2 = PlaySoundFrontend
    L7_2 = -1
    L8_2 = "PICK_UP"
    L9_2 = "HUD_FRONTEND_DEFAULT_SOUNDSET"
    L10_2 = true
    L6_2(L7_2, L8_2, L9_2, L10_2)
  else
    L6_2 = ipairs
    L7_2 = A1_2.cleanedJunk
    L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
    for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
      if L11_2 == A2_2 then
        L12_2 = table
        L12_2 = L12_2.remove
        L13_2 = A1_2.cleanedJunk
        L14_2 = L10_2
        L12_2(L13_2, L14_2)
        break
      end
    end
    L6_2 = Debug
    L7_2 = "CleanerRobot: Failed to remove junk on server:"
    L8_2 = A2_2
    L6_2(L7_2, L8_2)
  end
end
L2_1.cleanJunk = L12_1
function L12_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2
  L4_2 = A2_2 - A1_2
  L5_2 = math
  L5_2 = L5_2.min
  L6_2 = A3_2
  L7_2 = 1.0
  L5_2 = L5_2(L6_2, L7_2)
  L4_2 = L4_2 * L5_2
  L4_2 = A1_2 + L4_2
  return L4_2
end
L2_1.lerp = L12_1
function L12_1(A0_2, A1_2)
  local L2_2
  while A1_2 < 0 do
    A1_2 = A1_2 + 360
  end
  while true do
    L2_2 = 360
    if not (A1_2 >= L2_2) then
      break
    end
    A1_2 = A1_2 - 360
  end
  return A1_2
end
L2_1.normalizeAngle = L12_1
function L12_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2
  L3_2 = A2_2 - A1_2
  while true do
    L4_2 = 180
    if not (L3_2 > L4_2) then
      break
    end
    L3_2 = L3_2 - 360
  end
  while true do
    L4_2 = -180
    if not (L3_2 < L4_2) then
      break
    end
    L3_2 = L3_2 + 360
  end
  return L3_2
end
L2_1.getAngleDifference = L12_1
function L12_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  if not A2_2 then
    A2_2 = 5
  end
  L3_2 = math
  L3_2 = L3_2.abs
  L5_2 = A0_2
  L4_2 = A0_2.getAngleDifference
  L6_2 = A1_2.currentHeading
  if not L6_2 then
    L6_2 = 0
  end
  L7_2 = A1_2.targetHeading
  if not L7_2 then
    L7_2 = 0
  end
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2, L6_2, L7_2)
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L4_2 = A2_2 >= L3_2
  return L4_2
end
L2_1.hasReachedTargetHeading = L12_1
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = GetGameTimer
  L2_2 = L2_2()
  L3_2 = A1_2.headingLockTime
  if not L3_2 then
    L3_2 = true
    return L3_2
  end
  L3_2 = A1_2.headingLockTime
  L3_2 = L2_2 - L3_2
  L4_2 = 500
  if L3_2 > L4_2 then
    L4_2 = true
    return L4_2
  end
  L5_2 = A0_2
  L4_2 = A0_2.hasReachedTargetHeading
  L6_2 = A1_2
  L7_2 = 10
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  if L4_2 then
    L4_2 = true
    return L4_2
  end
  L4_2 = false
  return L4_2
end
L2_1.canUpdateTargetHeading = L12_1
function L12_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L4_2 = DoesEntityExist
  L5_2 = A1_2.robotHandle
  L4_2 = L4_2(L5_2)
  if not L4_2 then
    return
  end
  L5_2 = A0_2
  L4_2 = A0_2.normalizeAngle
  L6_2 = A2_2
  L4_2 = L4_2(L5_2, L6_2)
  if not A3_2 then
    L5_2 = A1_2.targetHeading
    if L5_2 then
      L5_2 = math
      L5_2 = L5_2.abs
      L7_2 = A0_2
      L6_2 = A0_2.getAngleDifference
      L8_2 = A1_2.targetHeading
      L9_2 = L4_2
      L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2(L7_2, L8_2, L9_2)
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
      if L5_2 > 30 then
        L7_2 = A0_2
        L6_2 = A0_2.canUpdateTargetHeading
        L8_2 = A1_2
        L6_2 = L6_2(L7_2, L8_2)
        if not L6_2 then
          L4_2 = A1_2.targetHeading
      end
      else
        L6_2 = GetGameTimer
        L6_2 = L6_2()
        A1_2.headingLockTime = L6_2
      end
  end
  else
    L5_2 = GetGameTimer
    L5_2 = L5_2()
    A1_2.headingLockTime = L5_2
  end
  A1_2.targetHeading = L4_2
  L5_2 = A1_2.currentHeading
  if not L5_2 then
    L5_2 = GetEntityHeading
    L6_2 = A1_2.robotHandle
    L5_2 = L5_2(L6_2)
  end
  L7_2 = A0_2
  L6_2 = A0_2.getAngleDifference
  L8_2 = L5_2
  L9_2 = L4_2
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L7_2 = 8.0
  L8_2 = math
  L8_2 = L8_2.min
  L9_2 = math
  L9_2 = L9_2.abs
  L10_2 = L6_2
  L9_2 = L9_2(L10_2)
  L10_2 = L7_2
  L8_2 = L8_2(L9_2, L10_2)
  L9_2 = nil
  L10_2 = math
  L10_2 = L10_2.abs
  L11_2 = L6_2
  L10_2 = L10_2(L11_2)
  if L10_2 < 1 then
    L9_2 = L4_2
  else
    if L6_2 > 0 then
      L10_2 = 1
      if L10_2 then
        goto lbl_73
      end
    end
    L10_2 = -1
    ::lbl_73::
    L12_2 = A0_2
    L11_2 = A0_2.normalizeAngle
    L13_2 = L8_2 * L10_2
    L13_2 = L5_2 + L13_2
    L11_2 = L11_2(L12_2, L13_2)
    L9_2 = L11_2
  end
  L10_2 = A0_2.wobbleEnabled
  if L10_2 then
    L10_2 = A1_2.velocity
    L11_2 = 0.001
    if L10_2 > L11_2 then
      L10_2 = math
      L10_2 = L10_2.abs
      L11_2 = L6_2
      L10_2 = L10_2(L11_2)
      if L10_2 < 10 then
        L10_2 = A1_2.wobblePhase
        if not L10_2 then
          L10_2 = 0
        end
        L11_2 = A0_2.wobbleSpeed
        L10_2 = L10_2 + L11_2
        A1_2.wobblePhase = L10_2
        L10_2 = math
        L10_2 = L10_2.sin
        L11_2 = A1_2.wobblePhase
        L10_2 = L10_2(L11_2)
        L11_2 = A0_2.wobbleAmount
        L10_2 = L10_2 * L11_2
        L11_2 = A1_2.velocity
        L12_2 = A0_2.maxSpeed
        L11_2 = L11_2 / L12_2
        L10_2 = L10_2 * L11_2
        L9_2 = L9_2 + L10_2
      end
    end
  end
  A1_2.currentHeading = L9_2
  L11_2 = A0_2
  L10_2 = A0_2.normalizeAngle
  L12_2 = L9_2 + 180
  L10_2 = L10_2(L11_2, L12_2)
  L11_2 = SetEntityHeading
  L12_2 = A1_2.robotHandle
  L13_2 = L10_2
  L11_2(L12_2, L13_2)
end
L2_1.updateRotation = L12_1
function L12_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = A1_2.velocity
  if not L3_2 then
    L3_2 = 0
  end
  if A2_2 then
    L4_2 = A0_2.moveSpeed
    L6_2 = A0_2
    L5_2 = A0_2.lerp
    L7_2 = L3_2
    L8_2 = L4_2
    L9_2 = A0_2.acceleration
    L9_2 = L9_2 * 10
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
    A1_2.velocity = L5_2
    L5_2 = A1_2.velocity
    L6_2 = A0_2.maxSpeed
    if L5_2 > L6_2 then
      L5_2 = A0_2.maxSpeed
      A1_2.velocity = L5_2
    end
  else
    L5_2 = A0_2
    L4_2 = A0_2.lerp
    L6_2 = L3_2
    L7_2 = 0
    L8_2 = A0_2.deceleration
    L8_2 = L8_2 * 10
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
    A1_2.velocity = L4_2
    L4_2 = A1_2.velocity
    L5_2 = 1.0E-4
    if L4_2 < L5_2 then
      A1_2.velocity = 0
    end
  end
end
L2_1.updateVelocity = L12_1
function L12_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L3_2 = DoesEntityExist
  L4_2 = A1_2.robotHandle
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = A1_2.velocity
  L4_2 = 1.0E-4
  if L3_2 < L4_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = GetEntityCoords
  L4_2 = A1_2.robotHandle
  L3_2 = L3_2(L4_2)
  L4_2 = A1_2.currentHeading
  if not L4_2 then
    L4_2 = GetEntityHeading
    L5_2 = A1_2.robotHandle
    L4_2 = L4_2(L5_2)
  end
  L6_2 = A0_2
  L5_2 = A0_2.headingToDirection
  L7_2 = L4_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = A1_2.velocity
  L6_2 = L5_2 * L6_2
  L7_2 = L3_2.x
  L8_2 = L6_2.x
  L7_2 = L7_2 + L8_2
  L8_2 = L3_2.y
  L9_2 = L6_2.y
  L8_2 = L8_2 + L9_2
  L9_2 = A1_2.baseZ
  L10_2 = A1_2.robotHeightOffset
  L9_2 = L9_2 + L10_2
  L10_2 = SetEntityCoords
  L11_2 = A1_2.robotHandle
  L12_2 = L7_2
  L13_2 = L8_2
  L14_2 = L9_2
  L15_2 = false
  L16_2 = false
  L17_2 = false
  L18_2 = false
  L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L10_2 = GetGameTimer
  L10_2 = L10_2()
  A1_2.lastMoveTime = L10_2
  L10_2 = true
  return L10_2
end
L2_1.applyMovement = L12_1
function L12_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L3_2 = DoesEntityExist
  L4_2 = A1_2.robotHandle
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = DoesEntityExist
  L4_2 = A2_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = GetEntityCoords
  L4_2 = A1_2.robotHandle
  L3_2 = L3_2(L4_2)
  L4_2 = GetEntityCoords
  L5_2 = A2_2
  L4_2 = L4_2(L5_2)
  L5_2 = math
  L5_2 = L5_2.abs
  L6_2 = L3_2.z
  L7_2 = L4_2.z
  L6_2 = L6_2 - L7_2
  L5_2 = L5_2(L6_2)
  if L5_2 > 3.0 then
    L5_2 = false
    return L5_2
  end
  L5_2 = HasEntityClearLosToEntity
  L6_2 = A1_2.robotHandle
  L7_2 = A2_2
  L8_2 = 17
  return L5_2(L6_2, L7_2, L8_2)
end
L2_1.isJunkVisible = L12_1
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L2_2 = DoesEntityExist
  L3_2 = A1_2.robotHandle
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = 0
    L3_2 = false
    return L2_2, L3_2
  end
  L2_2 = GetEntityCoords
  L3_2 = A1_2.robotHandle
  L2_2 = L2_2(L3_2)
  L3_2 = A1_2.currentHeading
  if not L3_2 then
    L3_2 = GetEntityHeading
    L4_2 = A1_2.robotHandle
    L3_2 = L3_2(L4_2)
  end
  L4_2 = A1_2.isInitialized
  if not L4_2 then
    L5_2 = A0_2
    L4_2 = A0_2.initRoombaState
    L6_2 = A1_2
    L4_2(L5_2, L6_2)
  end
  L4_2 = A1_2.navState
  if not L4_2 then
    A1_2.navState = "moving"
  end
  L4_2 = A1_2.moveDirection
  if L4_2 then
    L4_2 = type
    L5_2 = A1_2.moveDirection
    L4_2 = L4_2(L5_2)
    if "number" == L4_2 then
      goto lbl_37
    end
  end
  A1_2.moveDirection = L3_2
  ::lbl_37::
  L4_2 = math
  L4_2 = L4_2.abs
  L6_2 = A0_2
  L5_2 = A0_2.getAngleDifference
  L7_2 = L3_2
  L8_2 = A1_2.moveDirection
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L5_2(L6_2, L7_2, L8_2)
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  L6_2 = A0_2
  L5_2 = A0_2.findVisibleJunk
  L7_2 = A1_2
  L5_2, L6_2, L7_2 = L5_2(L6_2, L7_2)
  if L5_2 and L6_2 then
    L8_2 = 1.2
    if L7_2 < L8_2 then
      L9_2 = A0_2
      L8_2 = A0_2.cleanJunk
      L10_2 = A1_2
      L11_2 = L5_2
      L8_2(L9_2, L10_2, L11_2)
      A1_2.currentTarget = nil
      A1_2.turnCompletePosition = nil
      A1_2.navState = "moving"
      A1_2.lastWallDistance = nil
      A1_2.moveDirection = L3_2
      L8_2 = Debug
      L9_2 = "CleanerRobot: Cleaned visible junk, back to normal movement"
      L8_2(L9_2)
      L8_2 = L3_2
      L9_2 = true
      return L8_2, L9_2
    end
    L8_2 = L6_2.x
    L9_2 = L2_2.x
    L8_2 = L8_2 - L9_2
    L9_2 = L6_2.y
    L10_2 = L2_2.y
    L9_2 = L9_2 - L10_2
    L11_2 = A0_2
    L10_2 = A0_2.normalizeAngle
    L12_2 = math
    L12_2 = L12_2.deg
    L13_2 = math
    L13_2 = L13_2.atan
    L14_2 = L8_2
    L15_2 = L9_2
    L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L13_2(L14_2, L15_2)
    L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    L11_2 = math
    L11_2 = L11_2.abs
    L13_2 = A0_2
    L12_2 = A0_2.getAngleDifference
    L14_2 = L3_2
    L15_2 = L10_2
    L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L12_2(L13_2, L14_2, L15_2)
    L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    L12_2 = L10_1
    if L11_2 > L12_2 then
      A1_2.moveDirection = L10_2
      A1_2.navState = "turning_to_junk"
      A1_2.currentTarget = L6_2
      L12_2 = Debug
      L13_2 = "CleanerRobot: Visible junk found! OVERRIDING current state, turning to face it. Distance:"
      L14_2 = L7_2
      L12_2(L13_2, L14_2)
      L12_2 = L10_2
      L13_2 = false
      return L12_2, L13_2
    else
      A1_2.navState = "moving"
      A1_2.lastWallDistance = nil
      A1_2.moveDirection = L10_2
      A1_2.currentTarget = L6_2
      L12_2 = Debug
      L13_2 = "CleanerRobot: Visible junk found! OVERRIDING current state, going straight to it. Distance:"
      L14_2 = L7_2
      L12_2(L13_2, L14_2)
      L12_2 = L10_2
      L13_2 = true
      return L12_2, L13_2
    end
  end
  L9_2 = A0_2
  L8_2 = A0_2.findVeryCloseJunk
  L10_2 = A1_2
  L11_2 = 1.5
  L8_2, L9_2, L10_2 = L8_2(L9_2, L10_2, L11_2)
  if L8_2 and L9_2 then
    L12_2 = A0_2
    L11_2 = A0_2.cleanJunk
    L13_2 = A1_2
    L14_2 = L8_2
    L11_2(L12_2, L13_2, L14_2)
    A1_2.currentTarget = nil
    A1_2.turnCompletePosition = nil
    A1_2.navState = "moving"
    A1_2.lastWallDistance = nil
    A1_2.moveDirection = L3_2
    L11_2 = Debug
    L12_2 = "CleanerRobot: Cleaned very close junk (1.5m), back to normal movement. Distance:"
    L13_2 = L10_2
    L11_2(L12_2, L13_2)
    L11_2 = L3_2
    L12_2 = true
    return L11_2, L12_2
  end
  L11_2 = A1_2.navState
  if "turning_to_junk" == L11_2 then
    if L5_2 and L6_2 then
      L11_2 = L6_2.x
      L12_2 = L2_2.x
      L11_2 = L11_2 - L12_2
      L12_2 = L6_2.y
      L13_2 = L2_2.y
      L12_2 = L12_2 - L13_2
      L14_2 = A0_2
      L13_2 = A0_2.normalizeAngle
      L15_2 = math
      L15_2 = L15_2.deg
      L16_2 = math
      L16_2 = L16_2.atan
      L17_2 = L11_2
      L18_2 = L12_2
      L16_2, L17_2, L18_2, L19_2, L20_2 = L16_2(L17_2, L18_2)
      L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L15_2(L16_2, L17_2, L18_2, L19_2, L20_2)
      L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
      L14_2 = math
      L14_2 = L14_2.abs
      L16_2 = A0_2
      L15_2 = A0_2.getAngleDifference
      L17_2 = L3_2
      L18_2 = L13_2
      L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L15_2(L16_2, L17_2, L18_2)
      L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
      L15_2 = L10_1
      if L14_2 > L15_2 then
        A1_2.moveDirection = L13_2
        A1_2.currentTarget = L6_2
        L15_2 = L13_2
        L16_2 = false
        return L15_2, L16_2
      else
        A1_2.navState = "moving"
        A1_2.lastWallDistance = nil
        A1_2.moveDirection = L13_2
        A1_2.currentTarget = L6_2
        L15_2 = L13_2
        L16_2 = true
        return L15_2, L16_2
      end
    end
    L11_2 = L10_1
    if L4_2 < L11_2 then
      A1_2.navState = "moving"
      A1_2.moveDirection = L3_2
      L11_2 = vec3
      L12_2 = L2_2.x
      L13_2 = L2_2.y
      L14_2 = L2_2.z
      L11_2 = L11_2(L12_2, L13_2, L14_2)
      A1_2.turnCompletePosition = L11_2
      L11_2 = Debug
      L12_2 = "CleanerRobot: Turned to junk, moving towards it"
      L11_2(L12_2)
      L11_2 = L3_2
      L12_2 = true
      return L11_2, L12_2
    end
    L11_2 = A1_2.moveDirection
    L12_2 = false
    return L11_2, L12_2
  end
  L11_2 = A1_2.navState
  if "turning" == L11_2 then
    if L5_2 and L6_2 then
      L11_2 = L6_2.x
      L12_2 = L2_2.x
      L11_2 = L11_2 - L12_2
      L12_2 = L6_2.y
      L13_2 = L2_2.y
      L12_2 = L12_2 - L13_2
      L14_2 = A0_2
      L13_2 = A0_2.normalizeAngle
      L15_2 = math
      L15_2 = L15_2.deg
      L16_2 = math
      L16_2 = L16_2.atan
      L17_2 = L11_2
      L18_2 = L12_2
      L16_2, L17_2, L18_2, L19_2, L20_2 = L16_2(L17_2, L18_2)
      L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L15_2(L16_2, L17_2, L18_2, L19_2, L20_2)
      L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
      A1_2.moveDirection = L13_2
      A1_2.navState = "turning_to_junk"
      A1_2.currentTarget = L6_2
      L14_2 = Debug
      L15_2 = "CleanerRobot: Visible junk found while turning, switching to junk!"
      L14_2(L15_2)
      L14_2 = L13_2
      L15_2 = false
      return L14_2, L15_2
    end
    L11_2 = L10_1
    if L4_2 < L11_2 then
      L11_2 = vec3
      L12_2 = L2_2.x
      L13_2 = L2_2.y
      L14_2 = L2_2.z
      L11_2 = L11_2(L12_2, L13_2, L14_2)
      A1_2.turnCompletePosition = L11_2
      A1_2.moveDirection = L3_2
      L11_2 = A1_2.openingDetected
      if L11_2 then
        A1_2.navState = "passing_opening"
        A1_2.openingDetected = false
        L11_2 = Debug
        L12_2 = "CleanerRobot: Now passing through opening"
        L11_2(L12_2)
      else
        A1_2.navState = "following_wall"
        L12_2 = A0_2
        L11_2 = A0_2.getRightWallDistance
        L13_2 = A1_2
        L11_2 = L11_2(L12_2, L13_2)
        A1_2.lastWallDistance = L11_2
        L11_2 = GetGameTimer
        L11_2 = L11_2()
        A1_2.wallFollowStartTime = L11_2
        L11_2 = Debug
        L12_2 = "CleanerRobot: Turn complete, now following wall. Right wall dist:"
        L13_2 = A1_2.lastWallDistance
        L11_2(L12_2, L13_2)
      end
      L11_2 = L3_2
      L12_2 = true
      return L11_2, L12_2
    end
    L11_2 = A1_2.moveDirection
    L12_2 = false
    return L11_2, L12_2
  end
  L11_2 = A1_2.navState
  if "passing_opening" == L11_2 then
    if L5_2 and L6_2 then
      L11_2 = L6_2.x
      L12_2 = L2_2.x
      L11_2 = L11_2 - L12_2
      L12_2 = L6_2.y
      L13_2 = L2_2.y
      L12_2 = L12_2 - L13_2
      L14_2 = A0_2
      L13_2 = A0_2.normalizeAngle
      L15_2 = math
      L15_2 = L15_2.deg
      L16_2 = math
      L16_2 = L16_2.atan
      L17_2 = L11_2
      L18_2 = L12_2
      L16_2, L17_2, L18_2, L19_2, L20_2 = L16_2(L17_2, L18_2)
      L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L15_2(L16_2, L17_2, L18_2, L19_2, L20_2)
      L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
      L14_2 = math
      L14_2 = L14_2.abs
      L16_2 = A0_2
      L15_2 = A0_2.getAngleDifference
      L17_2 = L3_2
      L18_2 = L13_2
      L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L15_2(L16_2, L17_2, L18_2)
      L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
      L15_2 = L10_1
      if L14_2 > L15_2 then
        A1_2.moveDirection = L13_2
        A1_2.navState = "turning_to_junk"
        A1_2.currentTarget = L6_2
        L15_2 = Debug
        L16_2 = "CleanerRobot: Visible junk found while passing opening, switching to junk!"
        L15_2(L16_2)
        L15_2 = L13_2
        L16_2 = false
        return L15_2, L16_2
      else
        A1_2.navState = "moving"
        A1_2.lastWallDistance = nil
        A1_2.moveDirection = L13_2
        A1_2.currentTarget = L6_2
        L15_2 = Debug
        L16_2 = "CleanerRobot: Visible junk found while passing opening, going straight!"
        L15_2(L16_2)
        L15_2 = L13_2
        L16_2 = true
        return L15_2, L16_2
      end
    end
    L11_2 = A1_2.turnCompletePosition
    if L11_2 then
      L11_2 = L2_2.x
      L12_2 = A1_2.turnCompletePosition
      L12_2 = L12_2.x
      L11_2 = L11_2 - L12_2
      L12_2 = L2_2.y
      L13_2 = A1_2.turnCompletePosition
      L13_2 = L13_2.y
      L12_2 = L12_2 - L13_2
      L13_2 = math
      L13_2 = L13_2.sqrt
      L14_2 = L11_2 * L11_2
      L15_2 = L12_2 * L12_2
      L14_2 = L14_2 + L15_2
      L13_2 = L13_2(L14_2)
      L14_2 = L11_1
      L14_2 = L14_2 + 0.5
      if L13_2 > L14_2 then
        A1_2.navState = "moving"
        A1_2.turnCompletePosition = nil
        A1_2.lastWallDistance = nil
        L14_2 = Debug
        L15_2 = "CleanerRobot: Passed through opening, RESET to normal movement"
        L14_2(L15_2)
      end
    else
      A1_2.navState = "moving"
      A1_2.lastWallDistance = nil
    end
    L12_2 = A0_2
    L11_2 = A0_2.getWallDistance
    L13_2 = A1_2
    L14_2 = L3_2
    L15_2 = L6_1
    L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2)
    L12_2 = L6_1
    if L11_2 < L12_2 then
      L12_2 = Debug
      L13_2 = "CleanerRobot: Passing opening, frontDist:"
      L14_2 = L11_2
      L15_2 = "WALL_DETECT_FRONT:"
      L16_2 = L6_1
      L12_2(L13_2, L14_2, L15_2, L16_2)
      L13_2 = A0_2
      L12_2 = A0_2.normalizeAngle
      L14_2 = L3_2 + 90
      L12_2 = L12_2(L13_2, L14_2)
      A1_2.moveDirection = L12_2
      A1_2.navState = "turning"
      A1_2.openingDetected = false
      L12_2 = A1_2.moveDirection
      L13_2 = false
      return L12_2, L13_2
    end
    L12_2 = L3_2
    L13_2 = true
    return L12_2, L13_2
  end
  L11_2 = A1_2.navState
  if "following_wall" == L11_2 then
    if L5_2 and L6_2 then
      L11_2 = L6_2.x
      L12_2 = L2_2.x
      L11_2 = L11_2 - L12_2
      L12_2 = L6_2.y
      L13_2 = L2_2.y
      L12_2 = L12_2 - L13_2
      L14_2 = A0_2
      L13_2 = A0_2.normalizeAngle
      L15_2 = math
      L15_2 = L15_2.deg
      L16_2 = math
      L16_2 = L16_2.atan
      L17_2 = L11_2
      L18_2 = L12_2
      L16_2, L17_2, L18_2, L19_2, L20_2 = L16_2(L17_2, L18_2)
      L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L15_2(L16_2, L17_2, L18_2, L19_2, L20_2)
      L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
      L14_2 = math
      L14_2 = L14_2.abs
      L16_2 = A0_2
      L15_2 = A0_2.getAngleDifference
      L17_2 = L3_2
      L18_2 = L13_2
      L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L15_2(L16_2, L17_2, L18_2)
      L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
      L15_2 = L10_1
      if L14_2 > L15_2 then
        A1_2.moveDirection = L13_2
        A1_2.navState = "turning_to_junk"
        A1_2.currentTarget = L6_2
        L15_2 = Debug
        L16_2 = "CleanerRobot: Visible junk found while following wall, switching to junk!"
        L15_2(L16_2)
        L15_2 = L13_2
        L16_2 = false
        return L15_2, L16_2
      else
        A1_2.navState = "moving"
        A1_2.lastWallDistance = nil
        A1_2.moveDirection = L13_2
        A1_2.currentTarget = L6_2
        L15_2 = Debug
        L16_2 = "CleanerRobot: Visible junk found while following wall, going straight!"
        L15_2(L16_2)
        L15_2 = L13_2
        L16_2 = true
        return L15_2, L16_2
      end
    end
    L12_2 = A0_2
    L11_2 = A0_2.getWallDistance
    L13_2 = A1_2
    L14_2 = L3_2
    L15_2 = L6_1
    L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2)
    L12_2 = L6_1
    if L11_2 < L12_2 then
      L12_2 = Debug
      L13_2 = "838 CleanerRobot: Wall ahead while following, frontDist:"
      L14_2 = L11_2
      L15_2 = "WALL_DETECT_FRONT:"
      L16_2 = L6_1
      L12_2(L13_2, L14_2, L15_2, L16_2)
      L13_2 = A0_2
      L12_2 = A0_2.normalizeAngle
      L14_2 = L3_2 + 90
      L12_2 = L12_2(L13_2, L14_2)
      A1_2.moveDirection = L12_2
      A1_2.navState = "turning"
      A1_2.openingDetected = false
      L12_2 = Debug
      L13_2 = "CleanerRobot: Wall ahead while following, turning left"
      L12_2(L13_2)
      L12_2 = A1_2.moveDirection
      L13_2 = false
      return L12_2, L13_2
    end
    L13_2 = A0_2
    L12_2 = A0_2.getRightWallDistance
    L14_2 = A1_2
    L12_2 = L12_2(L13_2, L14_2)
    L13_2 = A1_2.lastWallDistance
    if not L13_2 then
      L13_2 = L12_2
    end
    L14_2 = L12_2 - L13_2
    L15_2 = L9_1
    if L14_2 > L15_2 then
      L15_2 = A0_2
      L14_2 = A0_2.normalizeAngle
      L16_2 = L3_2 - 90
      L14_2 = L14_2(L15_2, L16_2)
      L16_2 = A0_2
      L15_2 = A0_2.getWallDistance
      L17_2 = A1_2
      L18_2 = L14_2
      L19_2 = L6_1
      L15_2 = L15_2(L16_2, L17_2, L18_2, L19_2)
      L16_2 = L6_1
      if L15_2 >= L16_2 then
        L16_2 = Debug
        L17_2 = "859 CleanerRobot: Opening detected! Dist jumped from"
        L18_2 = L13_2
        L19_2 = "to"
        L20_2 = L12_2
        L16_2(L17_2, L18_2, L19_2, L20_2)
        A1_2.moveDirection = L14_2
        A1_2.navState = "turning"
        A1_2.openingDetected = true
        A1_2.openingDirection = L14_2
        L16_2 = Debug
        L17_2 = "CleanerRobot: Opening detected! Dist jumped from"
        L18_2 = L13_2
        L19_2 = "to"
        L20_2 = L12_2
        L16_2(L17_2, L18_2, L19_2, L20_2)
        L16_2 = A1_2.moveDirection
        L17_2 = false
        return L16_2, L17_2
      end
    end
    A1_2.lastWallDistance = L12_2
    L14_2 = L3_2
    L15_2 = true
    return L14_2, L15_2
  end
  L11_2 = A1_2.turnCompletePosition
  if L11_2 then
    L11_2 = L2_2.x
    L12_2 = A1_2.turnCompletePosition
    L12_2 = L12_2.x
    L11_2 = L11_2 - L12_2
    L12_2 = L2_2.y
    L13_2 = A1_2.turnCompletePosition
    L13_2 = L13_2.y
    L12_2 = L12_2 - L13_2
    L13_2 = math
    L13_2 = L13_2.sqrt
    L14_2 = L11_2 * L11_2
    L15_2 = L12_2 * L12_2
    L14_2 = L14_2 + L15_2
    L13_2 = L13_2(L14_2)
    L14_2 = L11_1
    if L13_2 < L14_2 then
      L14_2 = L3_2
      L15_2 = true
      return L14_2, L15_2
    else
      A1_2.turnCompletePosition = nil
    end
  end
  L12_2 = A0_2
  L11_2 = A0_2.getWallDistance
  L13_2 = A1_2
  L14_2 = L3_2
  L15_2 = L6_1
  L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2)
  L12_2 = L6_1
  if L11_2 < L12_2 then
    L13_2 = A0_2
    L12_2 = A0_2.normalizeAngle
    L14_2 = L3_2 + 90
    L12_2 = L12_2(L13_2, L14_2)
    A1_2.moveDirection = L12_2
    A1_2.navState = "turning"
    A1_2.openingDetected = false
    L12_2 = A1_2.moveDirection
    L13_2 = false
    return L12_2, L13_2
  end
  A1_2.moveDirection = L3_2
  L12_2 = L3_2
  L13_2 = true
  return L12_2, L13_2
end
L2_1.updateCleaningState = L12_1
function L12_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L4_2 = A0_2
  L3_2 = A0_2.getWallDistance
  L5_2 = A1_2
  L6_2 = A2_2
  L7_2 = L6_1
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L4_2 = L6_1
  L4_2 = L3_2 < L4_2
  L5_2 = L3_2
  return L4_2, L5_2
end
L2_1.isPathBlocked = L12_1
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L2_2 = DoesEntityExist
  L3_2 = A1_2.robotHandle
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = true
    return L2_2
  end
  L2_2 = GetEntityCoords
  L3_2 = A1_2.robotHandle
  L2_2 = L2_2(L3_2)
  L3_2 = A1_2.dockCoords
  L4_2 = math
  L4_2 = L4_2.sqrt
  L5_2 = L2_2.x
  L6_2 = L3_2.x
  L5_2 = L5_2 - L6_2
  L5_2 = L5_2 ^ 2
  L6_2 = L2_2.y
  L7_2 = L3_2.y
  L6_2 = L6_2 - L7_2
  L6_2 = L6_2 ^ 2
  L5_2 = L5_2 + L6_2
  L4_2 = L4_2(L5_2)
  L5_2 = L5_1
  if L4_2 < L5_2 then
    A1_2.velocity = 0
    A1_2.state = "docked"
    L5_2 = A1_2.isOwner
    if L5_2 then
      L5_2 = A1_2.networkedRobotHandle
      if L5_2 then
        L5_2 = DoesEntityExist
        L6_2 = A1_2.networkedRobotHandle
        L5_2 = L5_2(L6_2)
        if L5_2 then
          L5_2 = DeleteEntity
          L6_2 = A1_2.networkedRobotHandle
          L5_2(L6_2)
        end
        A1_2.networkedRobotHandle = nil
        L5_2 = A1_2.decorationHandle
        if L5_2 then
          L5_2 = DoesEntityExist
          L6_2 = A1_2.decorationHandle
          L5_2 = L5_2(L6_2)
          if L5_2 then
            L5_2 = A1_2.decorationHandle
            A1_2.robotHandle = L5_2
            L5_2 = SetEntityCoords
            L6_2 = A1_2.robotHandle
            L7_2 = L3_2.x
            L8_2 = L3_2.y
            L9_2 = L3_2.z
            L10_2 = false
            L11_2 = false
            L12_2 = false
            L13_2 = false
            L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
            L5_2 = SetEntityHeading
            L6_2 = A1_2.robotHandle
            L7_2 = A1_2.dockRotation
            L7_2 = L7_2.z
            L5_2(L6_2, L7_2)
          end
        end
        L5_2 = TriggerServerEvent
        L6_2 = "housing:cleaner:stopped"
        L7_2 = A1_2.house
        L8_2 = A1_2.id
        L5_2(L6_2, L7_2, L8_2)
        A1_2.isOwner = false
      end
    end
    L5_2 = A1_2.dockRotation
    L5_2 = L5_2.z
    A1_2.currentHeading = L5_2
    L5_2 = Debug
    L6_2 = "CleanerRobot: Returned to dock"
    L5_2(L6_2)
    L5_2 = PlaySoundFrontend
    L6_2 = -1
    L7_2 = "Beep_Green"
    L8_2 = "DLC_HEIST_HACKING_SNAKE_SOUNDS"
    L9_2 = true
    L5_2(L6_2, L7_2, L8_2, L9_2)
    L5_2 = SendReactMessage
    L6_2 = "cleaner_sound"
    L7_2 = {}
    L7_2.action = "stop"
    L5_2(L6_2, L7_2)
    L5_2 = true
    return L5_2
  end
  L5_2 = L3_2.x
  L6_2 = L2_2.x
  L5_2 = L5_2 - L6_2
  L6_2 = L3_2.y
  L7_2 = L2_2.y
  L6_2 = L6_2 - L7_2
  L7_2 = math
  L7_2 = L7_2.sqrt
  L8_2 = L5_2 * L5_2
  L9_2 = L6_2 * L6_2
  L8_2 = L8_2 + L9_2
  L7_2 = L7_2(L8_2)
  if L7_2 > 0 then
    L5_2 = L5_2 / L7_2
    L6_2 = L6_2 / L7_2
  end
  L8_2 = math
  L8_2 = L8_2.deg
  L9_2 = math
  L9_2 = L9_2.atan
  L10_2 = L5_2
  L11_2 = L6_2
  L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L9_2(L10_2, L11_2)
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
  L10_2 = A0_2
  L9_2 = A0_2.normalizeAngle
  L11_2 = L8_2
  L9_2 = L9_2(L10_2, L11_2)
  A1_2.currentHeading = L9_2
  L9_2 = SetEntityHeading
  L10_2 = A1_2.robotHandle
  L11_2 = A1_2.currentHeading
  L9_2(L10_2, L11_2)
  L9_2 = A0_2.moveSpeed
  L9_2 = L9_2 * 1.5
  L10_2 = L2_2.x
  L11_2 = L5_2 * L9_2
  L10_2 = L10_2 + L11_2
  L11_2 = L2_2.y
  L12_2 = L6_2 * L9_2
  L11_2 = L11_2 + L12_2
  L12_2 = A1_2.baseZ
  L13_2 = A1_2.robotHeightOffset
  L12_2 = L12_2 + L13_2
  L13_2 = SetEntityCoords
  L14_2 = A1_2.robotHandle
  L15_2 = L10_2
  L16_2 = L11_2
  L17_2 = L12_2
  L18_2 = false
  L19_2 = false
  L20_2 = false
  L21_2 = false
  L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
  L13_2 = GetGameTimer
  L13_2 = L13_2()
  A1_2.lastMoveTime = L13_2
  L13_2 = false
  return L13_2
end
L2_1.updateReturningState = L12_1
function L12_1(A0_2)
  local L1_2, L2_2
  L1_2 = A0_2.activeThread
  if L1_2 then
    return
  end
  A0_2.activeThread = true
  L1_2 = CreateThread
  function L2_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3
    while true do
      L0_3 = A0_2.activeThread
      if not L0_3 then
        break
      end
      L0_3 = false
      L1_3 = pairs
      L2_3 = A0_2.robots
      L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3)
      for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
        L7_3 = L6_3.state
        if "cleaning" ~= L7_3 then
          L7_3 = L6_3.state
          if "returning" ~= L7_3 then
            goto lbl_99
          end
        end
        L0_3 = true
        L7_3 = L6_3.velocity
        if not L7_3 then
          L6_3.velocity = 0
        end
        L7_3 = L6_3.wobblePhase
        if not L7_3 then
          L6_3.wobblePhase = 0
        end
        L7_3 = L6_3.currentHeading
        if not L7_3 then
          L7_3 = GetEntityHeading
          L8_3 = L6_3.robotHandle
          L7_3 = L7_3(L8_3)
          L6_3.currentHeading = L7_3
        end
        L7_3 = L6_3.isInitialized
        if not L7_3 then
          L7_3 = A0_2
          L8_3 = L7_3
          L7_3 = L7_3.initRoombaState
          L9_3 = L6_3
          L7_3(L8_3, L9_3)
        end
        L7_3 = L6_3.state
        if "cleaning" == L7_3 then
          L7_3 = L6_3.cleaningStartTime
          if L7_3 then
            L7_3 = GetGameTimer
            L7_3 = L7_3()
            L8_3 = L6_3.cleaningStartTime
            L7_3 = L7_3 - L8_3
            L8_3 = A0_2.cleaningTimeout
            if L7_3 >= L8_3 then
              L6_3.state = "returning"
              L6_3.cleaningStartTime = nil
              L8_3 = Notification
              L9_3 = i18n
              L9_3 = L9_3.t
              L10_3 = "cleaner.returning"
              L9_3 = L9_3(L10_3)
              L10_3 = "info"
              L8_3(L9_3, L10_3)
              L8_3 = Debug
              L9_3 = "CleanerRobot: Cleaning timeout, returning to dock"
              L10_3 = L5_3
              L8_3(L9_3, L10_3)
          end
          else
            L7_3 = A0_2
            L8_3 = L7_3
            L7_3 = L7_3.updateCleaningState
            L9_3 = L6_3
            L7_3, L8_3 = L7_3(L8_3, L9_3)
            L9_3 = A0_2
            L10_3 = L9_3
            L9_3 = L9_3.updateRotation
            L11_3 = L6_3
            L12_3 = L7_3
            L13_3 = false
            L9_3(L10_3, L11_3, L12_3, L13_3)
            L9_3 = A0_2
            L10_3 = L9_3
            L9_3 = L9_3.updateVelocity
            L11_3 = L6_3
            L12_3 = L8_3
            L9_3(L10_3, L11_3, L12_3)
            if L8_3 then
              L9_3 = A0_2
              L10_3 = L9_3
              L9_3 = L9_3.applyMovement
              L11_3 = L6_3
              L12_3 = false
              L9_3(L10_3, L11_3, L12_3)
            end
          end
        else
          L7_3 = L6_3.state
          if "returning" == L7_3 then
            L7_3 = A0_2
            L8_3 = L7_3
            L7_3 = L7_3.updateReturningState
            L9_3 = L6_3
            L7_3 = L7_3(L8_3, L9_3)
            if L7_3 then
            else
            end
          end
        end
        ::lbl_99::
      end
      if not L0_3 then
        A0_2.activeThread = false
        break
      end
      L1_3 = Wait
      L2_3 = L4_1
      L1_3(L2_3)
    end
  end
  L1_2(L2_2)
end
L2_1.startUpdateLoop = L12_1
function L12_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  if A1_2 then
    L3_2 = A1_2.id
    if L3_2 then
      goto lbl_8
    end
  end
  L3_2 = false
  do return L3_2 end
  ::lbl_8::
  L4_2 = A0_2
  L3_2 = A0_2.isCleanerModel
  L5_2 = A1_2.modelName
  L3_2, L4_2 = L3_2(L4_2, L5_2)
  if not L3_2 or not L4_2 then
    L5_2 = false
    return L5_2
  end
  L5_2 = A0_2.robots
  L6_2 = A1_2.id
  L5_2 = L5_2[L6_2]
  if L5_2 then
    L5_2 = Debug
    L6_2 = "CleanerRobot: Robot already exists for decoration"
    L7_2 = A1_2.id
    L5_2(L6_2, L7_2)
    L5_2 = true
    return L5_2
  end
  L5_2 = A1_2.handle
  if L5_2 then
    L6_2 = DoesEntityExist
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    if L6_2 then
      goto lbl_41
    end
  end
  L6_2 = Debug
  L7_2 = "CleanerRobot: Decoration object handle not found"
  L6_2(L7_2)
  L6_2 = false
  do return L6_2 end
  ::lbl_41::
  L6_2 = A1_2.coords
  L7_2 = A1_2.rotation
  if not L7_2 then
    L7_2 = vec3
    L8_2 = 0
    L9_2 = 0
    L10_2 = 0
    L7_2 = L7_2(L8_2, L9_2, L10_2)
  end
  L8_2 = joaat
  L9_2 = L4_2.model
  L8_2 = L8_2(L9_2)
  L9_2 = joaat
  L10_2 = L4_2.dockerModel
  L9_2 = L9_2(L10_2)
  L10_2 = lib
  L10_2 = L10_2.requestModel
  L11_2 = L9_2
  L12_2 = Config
  L12_2 = L12_2.DefaultRequestModelTimeout
  if not L12_2 then
    L12_2 = 5000
  end
  L10_2(L11_2, L12_2)
  L10_2 = CreateObject
  L11_2 = L9_2
  L12_2 = L6_2.x
  L13_2 = L6_2.y
  L14_2 = L6_2.z
  L14_2 = L14_2 - 0.07
  L15_2 = false
  L16_2 = false
  L17_2 = false
  L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L11_2 = DoesEntityExist
  L12_2 = L10_2
  L11_2 = L11_2(L12_2)
  if not L11_2 then
    L11_2 = Debug
    L12_2 = "CleanerRobot: Failed to spawn dock"
    L11_2(L12_2)
    L11_2 = SetModelAsNoLongerNeeded
    L12_2 = L9_2
    L11_2(L12_2)
    L11_2 = false
    return L11_2
  end
  L11_2 = SetEntityRotation
  L12_2 = L10_2
  L13_2 = L7_2.x
  L14_2 = L7_2.y
  L15_2 = L7_2.z
  L16_2 = 0
  L17_2 = false
  L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L11_2 = FreezeEntityPosition
  L12_2 = L10_2
  L13_2 = true
  L11_2(L12_2, L13_2)
  L11_2 = SetEntityCompletelyDisableCollision
  L12_2 = L10_2
  L13_2 = true
  L14_2 = false
  L11_2(L12_2, L13_2, L14_2)
  L11_2 = SetModelAsNoLongerNeeded
  L12_2 = L9_2
  L11_2(L12_2)
  L11_2 = GetModelDimensions
  L12_2 = L9_2
  L11_2, L12_2 = L11_2(L12_2)
  L13_2 = L12_2.z
  L14_2 = L11_2.z
  L13_2 = L13_2 - L14_2
  L14_2 = L6_2.z
  L15_2 = GetModelDimensions
  L16_2 = L8_2
  L15_2, L16_2 = L15_2(L16_2)
  L17_2 = L16_2.z
  L18_2 = L15_2.z
  L17_2 = L17_2 - L18_2
  L17_2 = L17_2 * 0.5
  L18_2 = vec3
  L19_2 = L6_2.x
  L20_2 = L6_2.y
  L21_2 = L14_2 + L17_2
  L18_2 = L18_2(L19_2, L20_2, L21_2)
  L19_2 = {}
  L20_2 = A1_2.id
  L19_2.id = L20_2
  L19_2.decorationObj = A1_2
  L19_2.robotHandle = L5_2
  L19_2.dockHandle = L10_2
  L20_2 = L4_2.model
  L19_2.robotModel = L20_2
  L20_2 = L4_2.dockerModel
  L19_2.dockModel = L20_2
  L19_2.dockCoords = L18_2
  L19_2.dockRotation = L7_2
  L19_2.baseZ = L14_2
  L19_2.robotHeightOffset = L17_2
  L19_2.state = "docked"
  L19_2.currentTarget = nil
  L20_2 = {}
  L19_2.cleanedJunk = L20_2
  L19_2.house = A2_2
  L19_2.velocity = 0
  L20_2 = L7_2.z
  L19_2.targetHeading = L20_2
  L20_2 = L7_2.z
  L19_2.currentHeading = L20_2
  L19_2.wobblePhase = 0
  L19_2.lastMoveTime = 0
  L20_2 = vec3
  L21_2 = L6_2.x
  L22_2 = L6_2.y
  L23_2 = L6_2.z
  L20_2 = L20_2(L21_2, L22_2, L23_2)
  L19_2.lastKnownCoords = L20_2
  L19_2.isInitialized = false
  L19_2.navState = "moving"
  L19_2.moveDirection = nil
  L19_2.lastWallDistance = nil
  L19_2.wallFollowStartTime = nil
  L19_2.openingDetected = false
  L19_2.openingDirection = nil
  L19_2.turnCompletePosition = nil
  L20_2 = A0_2.robots
  L21_2 = A1_2.id
  L20_2[L21_2] = L19_2
  L20_2 = Debug
  L21_2 = "CleanerRobot: Initialized cleaner for decoration"
  L22_2 = A1_2.id
  L20_2(L21_2, L22_2)
  L20_2 = true
  return L20_2
end
L2_1.spawnForDecoration = L12_1
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = A0_2.robots
  L2_2 = L2_2[A1_2]
  if not L2_2 then
    return
  end
  L3_2 = L2_2.isOwner
  if L3_2 then
    L3_2 = L2_2.state
    if "cleaning" ~= L3_2 then
      L3_2 = L2_2.state
      if "returning" ~= L3_2 then
        goto lbl_26
      end
    end
    L3_2 = TriggerServerEvent
    L4_2 = "housing:cleaner:stopped"
    L5_2 = L2_2.house
    L6_2 = A1_2
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = SendReactMessage
    L4_2 = "cleaner_sound"
    L5_2 = {}
    L5_2.action = "stop"
    L3_2(L4_2, L5_2)
  end
  ::lbl_26::
  L3_2 = L2_2.networkedRobotHandle
  if L3_2 then
    L3_2 = DoesEntityExist
    L4_2 = L2_2.networkedRobotHandle
    L3_2 = L3_2(L4_2)
    if L3_2 then
      L3_2 = DeleteEntity
      L4_2 = L2_2.networkedRobotHandle
      L3_2(L4_2)
      L2_2.networkedRobotHandle = nil
    end
  end
  L3_2 = DoesEntityExist
  L4_2 = L2_2.dockHandle
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = DeleteEntity
    L4_2 = L2_2.dockHandle
    L3_2(L4_2)
  end
  L3_2 = DoesEntityExist
  L4_2 = L2_2.robotHandle
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = SetEntityCoords
    L4_2 = L2_2.robotHandle
    L5_2 = L2_2.dockCoords
    L5_2 = L5_2.x
    L6_2 = L2_2.dockCoords
    L6_2 = L6_2.y
    L7_2 = L2_2.dockCoords
    L7_2 = L7_2.z
    L8_2 = false
    L9_2 = false
    L10_2 = false
    L11_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L3_2 = SetEntityHeading
    L4_2 = L2_2.robotHandle
    L5_2 = L2_2.dockRotation
    L5_2 = L5_2.z
    L3_2(L4_2, L5_2)
  end
  L3_2 = A0_2.robots
  L3_2[A1_2] = nil
  L3_2 = Debug
  L4_2 = "CleanerRobot: Despawned cleaner"
  L5_2 = A1_2
  L3_2(L4_2, L5_2)
end
L2_1.despawn = L12_1
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L2_2 = A0_2.robots
  L2_2 = L2_2[A1_2]
  if not L2_2 then
    L3_2 = Debug
    L4_2 = "CleanerRobot: Robot not found"
    L5_2 = A1_2
    L3_2(L4_2, L5_2)
    return
  end
  L3_2 = L2_2.state
  if "docked" ~= L3_2 then
    L3_2 = L2_2.state
    if "idle" ~= L3_2 then
      L3_2 = Debug
      L4_2 = "CleanerRobot: Robot is not ready to clean"
      L5_2 = L2_2.state
      L3_2(L4_2, L5_2)
      return
    end
  end
  L3_2 = lib
  L3_2 = L3_2.callback
  L3_2 = L3_2.await
  L4_2 = "housing:cleaner:start"
  L5_2 = false
  L6_2 = L2_2.house
  L7_2 = A1_2
  L8_2 = L2_2.robotModel
  L3_2, L4_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  if not L3_2 then
    if "already_active" == L4_2 then
      L5_2 = Notification
      L6_2 = i18n
      L6_2 = L6_2.t
      L7_2 = "cleaner.already_active"
      L6_2 = L6_2(L7_2)
      L7_2 = "error"
      L5_2(L6_2, L7_2)
    end
    L5_2 = Debug
    L6_2 = "CleanerRobot: Server rejected start"
    L7_2 = L4_2
    L5_2(L6_2, L7_2)
    return
  end
  L5_2 = L2_2.robotHandle
  L2_2.decorationHandle = L5_2
  L2_2.isOwner = true
  L5_2 = joaat
  L6_2 = L2_2.robotModel
  L5_2 = L5_2(L6_2)
  L6_2 = lib
  L6_2 = L6_2.requestModel
  L7_2 = L5_2
  L8_2 = Config
  L8_2 = L8_2.DefaultRequestModelTimeout
  if not L8_2 then
    L8_2 = 5000
  end
  L6_2(L7_2, L8_2)
  L6_2 = L2_2.dockCoords
  L7_2 = CreateObject
  L8_2 = L5_2
  L9_2 = L6_2.x
  L10_2 = L6_2.y
  L11_2 = L6_2.z
  L12_2 = true
  L13_2 = true
  L14_2 = true
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L8_2 = DoesEntityExist
  L9_2 = L7_2
  L8_2 = L8_2(L9_2)
  if not L8_2 then
    L8_2 = Debug
    L9_2 = "CleanerRobot: Failed to spawn networked robot"
    L8_2(L9_2)
    L8_2 = TriggerServerEvent
    L9_2 = "housing:cleaner:stopped"
    L10_2 = L2_2.house
    L11_2 = A1_2
    L8_2(L9_2, L10_2, L11_2)
    L8_2 = SetModelAsNoLongerNeeded
    L9_2 = L5_2
    L8_2(L9_2)
    return
  end
  L8_2 = SetEntityInvincible
  L9_2 = L7_2
  L10_2 = true
  L8_2(L9_2, L10_2)
  L8_2 = SetEntityRotation
  L9_2 = L7_2
  L10_2 = 0.0
  L11_2 = 0.0
  L12_2 = L2_2.dockRotation
  L12_2 = L12_2.z
  L13_2 = 0
  L14_2 = false
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L8_2 = SetEntityCompletelyDisableCollision
  L9_2 = L7_2
  L10_2 = true
  L11_2 = false
  L8_2(L9_2, L10_2, L11_2)
  L8_2 = SetModelAsNoLongerNeeded
  L9_2 = L5_2
  L8_2(L9_2)
  L2_2.networkedRobotHandle = L7_2
  L2_2.robotHandle = L7_2
  L8_2 = NetworkGetNetworkIdFromEntity
  L9_2 = L7_2
  L8_2 = L8_2(L9_2)
  L9_2 = TriggerServerEvent
  L10_2 = "housing:cleaner:updateNetworkId"
  L11_2 = L2_2.house
  L12_2 = A1_2
  L13_2 = L8_2
  L9_2(L10_2, L11_2, L12_2, L13_2)
  L2_2.state = "cleaning"
  L9_2 = {}
  L2_2.cleanedJunk = L9_2
  L2_2.velocity = 0
  L2_2.wobblePhase = 0
  L9_2 = GetEntityHeading
  L10_2 = L7_2
  L9_2 = L9_2(L10_2)
  L2_2.currentHeading = L9_2
  L9_2 = L2_2.currentHeading
  L2_2.targetHeading = L9_2
  L9_2 = GetGameTimer
  L9_2 = L9_2()
  L2_2.lastMoveTime = L9_2
  L9_2 = GetGameTimer
  L9_2 = L9_2()
  L2_2.cleaningStartTime = L9_2
  L10_2 = A0_2
  L9_2 = A0_2.initRoombaState
  L11_2 = L2_2
  L9_2(L10_2, L11_2)
  L2_2.currentTarget = nil
  L9_2 = Debug
  L10_2 = "CleanerRobot: Started cleaning with networked robot"
  L11_2 = A1_2
  L12_2 = "networkId"
  L13_2 = L8_2
  L9_2(L10_2, L11_2, L12_2, L13_2)
  L9_2 = Notification
  L10_2 = i18n
  L10_2 = L10_2.t
  L11_2 = "cleaner.cleaning"
  L10_2 = L10_2(L11_2)
  L11_2 = "info"
  L9_2(L10_2, L11_2)
  L10_2 = A0_2
  L9_2 = A0_2.startUpdateLoop
  L9_2(L10_2)
  L9_2 = PlaySoundFrontend
  L10_2 = -1
  L11_2 = "Beep_Green"
  L12_2 = "DLC_HEIST_HACKING_SNAKE_SOUNDS"
  L13_2 = true
  L9_2(L10_2, L11_2, L12_2, L13_2)
  L9_2 = SendReactMessage
  L10_2 = "cleaner_sound"
  L11_2 = {}
  L11_2.action = "start"
  L9_2(L10_2, L11_2)
end
L2_1.startCleaning = L12_1
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = A0_2.robots
  L2_2 = L2_2[A1_2]
  if not L2_2 then
    return
  end
  L3_2 = L2_2.state
  if "cleaning" == L3_2 then
    L2_2.state = "returning"
    L2_2.cleaningStartTime = nil
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "cleaner.returning"
    L4_2 = L4_2(L5_2)
    L5_2 = "info"
    L3_2(L4_2, L5_2)
    L3_2 = Debug
    L4_2 = "CleanerRobot: Returning to dock"
    L5_2 = A1_2
    L3_2(L4_2, L5_2)
    L4_2 = A0_2
    L3_2 = A0_2.startUpdateLoop
    L3_2(L4_2)
  end
end
L2_1.stopCleaning = L12_1
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = A0_2.robots
  L2_2 = L2_2[A1_2]
  if not L2_2 then
    return
  end
  L2_2.state = "returning"
  L3_2 = Notification
  L4_2 = i18n
  L4_2 = L4_2.t
  L5_2 = "cleaner.returning"
  L4_2 = L4_2(L5_2)
  L5_2 = "info"
  L3_2(L4_2, L5_2)
  L4_2 = A0_2
  L3_2 = A0_2.startUpdateLoop
  L3_2(L4_2)
  L3_2 = Debug
  L4_2 = "CleanerRobot: Manually returning to dock"
  L5_2 = A1_2
  L3_2(L4_2, L5_2)
end
L2_1.returnToDock = L12_1
function L12_1(A0_2, A1_2)
  local L2_2
  L2_2 = A0_2.robots
  L2_2 = L2_2[A1_2]
  return L2_2
end
L2_1.get = L12_1
function L12_1(A0_2)
  local L1_2
  L1_2 = A0_2.robots
  return L1_2
end
L2_1.getAll = L12_1
function L12_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = A0_2.robots
  L2_2 = L2_2[A1_2]
  if not L2_2 then
    L3_2 = "unknown"
    return L3_2
  end
  L3_2 = L2_2.state
  return L3_2
end
L2_1.getState = L12_1
function L12_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = A0_2.robots
  L2_2 = L2_2[A1_2]
  if not L2_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = L2_2.state
  L3_2 = "cleaning" == L3_2
  return L3_2
end
L2_1.isActive = L12_1
function L12_1(A0_2)
  local L1_2, L2_2
  L1_2 = next
  L2_2 = A0_2.robots
  L1_2 = L1_2(L2_2)
  L1_2 = nil ~= L1_2
  return L1_2
end
L2_1.hasRobots = L12_1
function L12_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = pairs
  L2_2 = A0_2.robots
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = L6_2.state
    if "cleaning" ~= L7_2 then
      L7_2 = L6_2.state
      if "returning" ~= L7_2 then
        goto lbl_14
      end
    end
    L7_2 = true
    L8_2 = L5_2
    do return L7_2, L8_2 end
    ::lbl_14::
  end
  L1_2 = false
  L2_2 = nil
  return L1_2, L2_2
end
L2_1.hasActiveCleaningRobot = L12_1
function L12_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L4_2 = A0_2.robots
  L4_2 = L4_2[A1_2]
  if not L4_2 then
    return
  end
  L5_2 = L4_2.state
  if "docked" ~= L5_2 then
    L5_2 = Debug
    L6_2 = "CleanerRobot: Cannot reinitialize - robot not docked"
    L5_2(L6_2)
    return
  end
  L5_2 = A0_2.cleanerModels
  L6_2 = L4_2.robotModel
  L5_2 = L5_2[L6_2]
  if not L5_2 then
    return
  end
  L6_2 = DoesEntityExist
  L7_2 = L4_2.dockHandle
  L6_2 = L6_2(L7_2)
  if L6_2 then
    L6_2 = DeleteEntity
    L7_2 = L4_2.dockHandle
    L6_2(L7_2)
  end
  L6_2 = joaat
  L7_2 = L5_2.dockerModel
  L6_2 = L6_2(L7_2)
  L7_2 = lib
  L7_2 = L7_2.requestModel
  L8_2 = L6_2
  L9_2 = Config
  L9_2 = L9_2.DefaultRequestModelTimeout
  if not L9_2 then
    L9_2 = 5000
  end
  L7_2(L8_2, L9_2)
  L7_2 = CreateObject
  L8_2 = L6_2
  L9_2 = A2_2.x
  L10_2 = A2_2.y
  L11_2 = A2_2.z
  L12_2 = false
  L13_2 = false
  L14_2 = false
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L8_2 = DoesEntityExist
  L9_2 = L7_2
  L8_2 = L8_2(L9_2)
  if not L8_2 then
    L8_2 = Debug
    L9_2 = "CleanerRobot: Failed to respawn dock"
    L8_2(L9_2)
    L8_2 = SetModelAsNoLongerNeeded
    L9_2 = L6_2
    L8_2(L9_2)
    return
  end
  L8_2 = SetEntityRotation
  L9_2 = L7_2
  L10_2 = A3_2.x
  L11_2 = A3_2.y
  L12_2 = A3_2.z
  L13_2 = 0
  L14_2 = false
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
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
  L9_2 = L6_2
  L8_2(L9_2)
  L8_2 = GetModelDimensions
  L9_2 = L6_2
  L8_2, L9_2 = L8_2(L9_2)
  L10_2 = L9_2.z
  L11_2 = L8_2.z
  L10_2 = L10_2 - L11_2
  L11_2 = A2_2.z
  L11_2 = L11_2 + L10_2
  L11_2 = L11_2 + 0.02
  L12_2 = DoesEntityExist
  L13_2 = L4_2.robotHandle
  L12_2 = L12_2(L13_2)
  if L12_2 then
    L12_2 = SetEntityCoords
    L13_2 = L4_2.robotHandle
    L14_2 = A2_2.x
    L15_2 = A2_2.y
    L16_2 = L11_2
    L17_2 = false
    L18_2 = false
    L19_2 = false
    L20_2 = false
    L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    L12_2 = SetEntityRotation
    L13_2 = L4_2.robotHandle
    L14_2 = 0.0
    L15_2 = 0.0
    L16_2 = A3_2.z
    L17_2 = 0
    L18_2 = false
    L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  end
  L12_2 = joaat
  L13_2 = L4_2.robotModel
  L12_2 = L12_2(L13_2)
  L13_2 = GetModelDimensions
  L14_2 = L12_2
  L13_2, L14_2 = L13_2(L14_2)
  L15_2 = L14_2.z
  L16_2 = L13_2.z
  L15_2 = L15_2 - L16_2
  L15_2 = L15_2 * 0.5
  L4_2.dockHandle = L7_2
  L16_2 = vec3
  L17_2 = A2_2.x
  L18_2 = A2_2.y
  L19_2 = A2_2.z
  L19_2 = L19_2 + L15_2
  L16_2 = L16_2(L17_2, L18_2, L19_2)
  L4_2.dockCoords = L16_2
  L4_2.dockRotation = A3_2
  L16_2 = A2_2.z
  L4_2.baseZ = L16_2
  L16_2 = vec3
  L17_2 = A2_2.x
  L18_2 = A2_2.y
  L19_2 = A2_2.z
  L16_2 = L16_2(L17_2, L18_2, L19_2)
  L4_2.lastKnownCoords = L16_2
  L16_2 = A3_2.z
  L4_2.currentHeading = L16_2
  L16_2 = A3_2.z
  L4_2.targetHeading = L16_2
  L16_2 = Debug
  L17_2 = "CleanerRobot: Reinitialized at new position"
  L18_2 = A1_2
  L16_2(L17_2, L18_2)
end
L2_1.reinitializeAtPosition = L12_1
function L12_1(A0_2)
  local L1_2
  L1_2 = A0_2.cleanerModels
  return L1_2
end
L2_1.getCleanerModels = L12_1
function L12_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = pairs
  L2_2 = A0_2.robots
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = L6_2.isOwner
    if L7_2 then
      L7_2 = L6_2.state
      if "cleaning" ~= L7_2 then
        L7_2 = L6_2.state
        if "returning" ~= L7_2 then
          goto lbl_19
        end
      end
      L7_2 = TriggerServerEvent
      L8_2 = "housing:cleaner:stopped"
      L9_2 = L6_2.house
      L10_2 = L5_2
      L7_2(L8_2, L9_2, L10_2)
    end
    ::lbl_19::
    L7_2 = L6_2.networkedRobotHandle
    if L7_2 then
      L7_2 = DoesEntityExist
      L8_2 = L6_2.networkedRobotHandle
      L7_2 = L7_2(L8_2)
      if L7_2 then
        L7_2 = DeleteEntity
        L8_2 = L6_2.networkedRobotHandle
        L7_2(L8_2)
      end
    end
    L7_2 = DoesEntityExist
    L8_2 = L6_2.dockHandle
    L7_2 = L7_2(L8_2)
    if L7_2 then
      L7_2 = DeleteEntity
      L8_2 = L6_2.dockHandle
      L7_2(L8_2)
    end
  end
  L1_2 = SendReactMessage
  L2_2 = "cleaner_sound"
  L3_2 = {}
  L3_2.action = "stop"
  L1_2(L2_2, L3_2)
  A0_2.activeThread = false
  A0_2.interactionThread = false
  L1_2 = {}
  A0_2.robots = L1_2
end
L2_1.cleanAll = L12_1
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L2_2 = decorate
  if L2_2 then
    L2_2 = decorate
    L2_2 = L2_2.objects
    if L2_2 then
      goto lbl_9
    end
  end
  do return end
  ::lbl_9::
  L2_2 = pairs
  L3_2 = decorate
  L3_2 = L3_2.objects
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = L7_2.spawned
    if L8_2 then
      L8_2 = L7_2.coords
      if L8_2 then
        L8_2 = L7_2.handle
        if L8_2 then
          L9_2 = A0_2
          L8_2 = A0_2.isCleanerModel
          L10_2 = L7_2.modelName
          L8_2 = L8_2(L9_2, L10_2)
          if L8_2 then
            L10_2 = A0_2
            L9_2 = A0_2.spawnForDecoration
            L11_2 = L7_2
            L12_2 = A1_2
            L9_2(L10_2, L11_2, L12_2)
          end
        end
      end
    end
  end
end
L2_1.scanAndSpawnFromDecorations = L12_1
function L12_1(A0_2)
  local L1_2, L2_2
  L1_2 = A0_2.interactionThread
  if L1_2 then
    return
  end
  L1_2 = Config
  L1_2 = L1_2.UseTarget
  if L1_2 then
    return
  end
  A0_2.interactionThread = true
  L1_2 = CreateThread
  function L2_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3
    while true do
      L0_3 = A0_2.interactionThread
      if not L0_3 then
        break
      end
      L0_3 = CurrentHouse
      if not L0_3 then
        break
      end
      L0_3 = GetEntityCoords
      L1_3 = cache
      L1_3 = L1_3.ped
      L0_3 = L0_3(L1_3)
      L1_3 = nil
      L2_3 = 2.5
      L3_3 = pairs
      L4_3 = A0_2.robots
      L3_3, L4_3, L5_3, L6_3 = L3_3(L4_3)
      for L7_3, L8_3 in L3_3, L4_3, L5_3, L6_3 do
        L9_3 = DoesEntityExist
        L10_3 = L8_3.dockHandle
        L9_3 = L9_3(L10_3)
        if L9_3 then
          L9_3 = GetEntityCoords
          L10_3 = L8_3.dockHandle
          L9_3 = L9_3(L10_3)
          L10_3 = L0_3 - L9_3
          L10_3 = #L10_3
          if L2_3 > L10_3 then
            L2_3 = L10_3
            L11_3 = {}
            L11_3.id = L7_3
            L11_3.data = L8_3
            L1_3 = L11_3
          end
        end
      end
      if L1_3 then
        L3_3 = CurrentHouseData
        if L3_3 then
          L3_3 = CurrentHouseData
          L3_3 = L3_3.haskey
          if L3_3 then
            L3_3 = GetEntityCoords
            L4_3 = L1_3.data
            L4_3 = L4_3.dockHandle
            L3_3 = L3_3(L4_3)
            L4_3 = L1_3.data
            L4_3 = L4_3.state
            L5_3 = ""
            if "docked" == L4_3 or "idle" == L4_3 then
              L6_3 = i18n
              L6_3 = L6_3.t
              L7_3 = "cleaner.press_start"
              L6_3 = L6_3(L7_3)
              L5_3 = L6_3
            elseif "cleaning" == L4_3 then
              L6_3 = i18n
              L6_3 = L6_3.t
              L7_3 = "cleaner.press_stop"
              L6_3 = L6_3(L7_3)
              L5_3 = L6_3
            elseif "returning" == L4_3 then
              L6_3 = i18n
              L6_3 = L6_3.t
              L7_3 = "cleaner.returning"
              L6_3 = L6_3(L7_3)
              L5_3 = L6_3
            end
            L6_3 = DrawText3D
            L7_3 = L3_3.x
            L8_3 = L3_3.y
            L9_3 = L3_3.z
            L9_3 = L9_3 + 0.3
            L10_3 = L5_3
            L11_3 = "cleaner_robot"
            L12_3 = "E"
            L6_3(L7_3, L8_3, L9_3, L10_3, L11_3, L12_3)
            L6_3 = IsControlJustPressed
            L7_3 = 0
            L8_3 = 38
            L6_3 = L6_3(L7_3, L8_3)
            if L6_3 then
              if "docked" == L4_3 or "idle" == L4_3 then
                L6_3 = A0_2
                L7_3 = L6_3
                L6_3 = L6_3.startCleaning
                L8_3 = L1_3.id
                L6_3(L7_3, L8_3)
              elseif "cleaning" == L4_3 then
                L6_3 = A0_2
                L7_3 = L6_3
                L6_3 = L6_3.stopCleaning
                L8_3 = L1_3.id
                L6_3(L7_3, L8_3)
              end
            end
          end
        end
      end
      L3_3 = Wait
      L4_3 = 0
      L3_3(L4_3)
    end
    A0_2.interactionThread = false
  end
  L1_2(L2_2)
end
L2_1.startInteractionLoop = L12_1
function L12_1(A0_2)
  local L1_2
  A0_2.interactionThread = false
end
L2_1.stopInteractionLoop = L12_1
L12_1 = _G
L14_1 = L2_1
L13_1 = L2_1.new
L13_1 = L13_1(L14_1)
L12_1.cleanerRobot = L13_1
L12_1 = CreateThread
function L13_1()
  local L0_2, L1_2
  L0_2 = Wait
  L1_2 = 1000
  L0_2(L1_2)
  L0_2 = cleanerRobot
  L1_2 = L0_2
  L0_2 = L0_2.buildModelList
  L0_2(L1_2)
end
L12_1(L13_1)
L12_1 = {}
L13_1 = CreateThread
function L14_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  while true do
    L0_2 = Wait
    L1_2 = 500
    L0_2(L1_2)
    L0_2 = CurrentHouse
    if not L0_2 then
      L0_2 = {}
      L12_1 = L0_2
    else
      L0_2 = decorate
      if L0_2 then
        L0_2 = decorate
        L0_2 = L0_2.objects
        if not L0_2 then
        else
          L0_2 = pairs
          L1_2 = decorate
          L1_2 = L1_2.objects
          L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
          for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
            L6_2 = L5_2.id
            if L6_2 then
              L6_2 = L5_2.spawned
              if L6_2 then
                L6_2 = L5_2.coords
                if L6_2 then
                  L6_2 = L5_2.handle
                  if L6_2 then
                    L6_2 = cleanerRobot
                    L7_2 = L6_2
                    L6_2 = L6_2.isCleanerModel
                    L8_2 = L5_2.modelName
                    L6_2 = L6_2(L7_2, L8_2)
                    if L6_2 then
                      L7_2 = cleanerRobot
                      L8_2 = L7_2
                      L7_2 = L7_2.get
                      L9_2 = L5_2.id
                      L7_2 = L7_2(L8_2, L9_2)
                      if not L7_2 then
                        L9_2 = L5_2.id
                        L8_2 = L12_1
                        L10_2 = {}
                        L11_2 = vec3
                        L12_2 = L5_2.coords
                        L12_2 = L12_2.x
                        L13_2 = L5_2.coords
                        L13_2 = L13_2.y
                        L14_2 = L5_2.coords
                        L14_2 = L14_2.z
                        L11_2 = L11_2(L12_2, L13_2, L14_2)
                        L10_2.coords = L11_2
                        L11_2 = L5_2.rotation
                        if L11_2 then
                          L11_2 = vec3
                          L12_2 = L5_2.rotation
                          L12_2 = L12_2.x
                          L13_2 = L5_2.rotation
                          L13_2 = L13_2.y
                          L14_2 = L5_2.rotation
                          L14_2 = L14_2.z
                          L11_2 = L11_2(L12_2, L13_2, L14_2)
                          if L11_2 then
                            goto lbl_79
                          end
                        end
                        L11_2 = vec3
                        L12_2 = 0
                        L13_2 = 0
                        L14_2 = 0
                        L11_2 = L11_2(L12_2, L13_2, L14_2)
                        ::lbl_79::
                        L10_2.rotation = L11_2
                        L8_2[L9_2] = L10_2
                        L8_2 = cleanerRobot
                        L9_2 = L8_2
                        L8_2 = L8_2.spawnForDecoration
                        L10_2 = L5_2
                        L11_2 = CurrentHouse
                        L8_2(L9_2, L10_2, L11_2)
                      else
                        L9_2 = L5_2.id
                        L8_2 = L12_1
                        L8_2 = L8_2[L9_2]
                        if L8_2 then
                          L9_2 = vec3
                          L10_2 = L5_2.coords
                          L10_2 = L10_2.x
                          L11_2 = L5_2.coords
                          L11_2 = L11_2.y
                          L12_2 = L5_2.coords
                          L12_2 = L12_2.z
                          L9_2 = L9_2(L10_2, L11_2, L12_2)
                          L10_2 = L5_2.rotation
                          if L10_2 then
                            L10_2 = vec3
                            L11_2 = L5_2.rotation
                            L11_2 = L11_2.x
                            L12_2 = L5_2.rotation
                            L12_2 = L12_2.y
                            L13_2 = L5_2.rotation
                            L13_2 = L13_2.z
                            L10_2 = L10_2(L11_2, L12_2, L13_2)
                            if L10_2 then
                              goto lbl_118
                            end
                          end
                          L10_2 = vec3
                          L11_2 = 0
                          L12_2 = 0
                          L13_2 = 0
                          L10_2 = L10_2(L11_2, L12_2, L13_2)
                          ::lbl_118::
                          L11_2 = L8_2.coords
                          L11_2 = L9_2 - L11_2
                          L11_2 = #L11_2
                          L12_2 = 0.1
                          L11_2 = L11_2 > L12_2
                          L12_2 = math
                          L12_2 = L12_2.abs
                          L13_2 = L10_2.z
                          L14_2 = L8_2.rotation
                          L14_2 = L14_2.z
                          L13_2 = L13_2 - L14_2
                          L12_2 = L12_2(L13_2)
                          L12_2 = L12_2 > 1.0
                          if L11_2 or L12_2 then
                            L13_2 = L5_2.handle
                            L7_2.robotHandle = L13_2
                            L13_2 = cleanerRobot
                            L14_2 = L13_2
                            L13_2 = L13_2.reinitializeAtPosition
                            L15_2 = L5_2.id
                            L16_2 = L9_2
                            L17_2 = L10_2
                            L13_2(L14_2, L15_2, L16_2, L17_2)
                            L14_2 = L5_2.id
                            L13_2 = L12_1
                            L15_2 = {}
                            L15_2.coords = L9_2
                            L15_2.rotation = L10_2
                            L13_2[L14_2] = L15_2
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
          L0_2 = pairs
          L1_2 = L12_1
          L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
          for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
            L6_2 = false
            L7_2 = pairs
            L8_2 = decorate
            L8_2 = L8_2.objects
            L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
            for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
              L13_2 = L12_2.id
              if L13_2 == L4_2 then
                L6_2 = true
                break
              end
            end
            if not L6_2 then
              L7_2 = L12_1
              L7_2[L4_2] = nil
              L7_2 = cleanerRobot
              L8_2 = L7_2
              L7_2 = L7_2.despawn
              L9_2 = L4_2
              L7_2(L8_2, L9_2)
            end
          end
        end
      end
    end
  end
end
L13_1(L14_1)
L13_1 = Config
L13_1 = L13_1.UseTarget
if L13_1 then
  L13_1 = CreateThread
  function L14_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
    L0_2 = Wait
    L1_2 = 2000
    L0_2(L1_2)
    L0_2 = cleanerRobot
    L1_2 = L0_2
    L0_2 = L0_2.getCleanerModels
    L0_2 = L0_2(L1_2)
    while true do
      L1_2 = next
      L2_2 = L0_2
      L1_2 = L1_2(L2_2)
      if nil ~= L1_2 then
        break
      end
      L1_2 = Wait
      L2_2 = 500
      L1_2(L2_2)
      L1_2 = cleanerRobot
      L2_2 = L1_2
      L1_2 = L1_2.getCleanerModels
      L1_2 = L1_2(L2_2)
      L0_2 = L1_2
    end
    L1_2 = {}
    L2_2 = {}
    L3_2 = pairs
    L4_2 = L0_2
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = table
      L9_2 = L9_2.insert
      L10_2 = L1_2
      L11_2 = joaat
      L12_2 = L7_2
      L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L11_2(L12_2)
      L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
      L9_2 = L8_2.dockerModel
      if L9_2 then
        L9_2 = joaat
        L10_2 = L8_2.dockerModel
        L9_2 = L9_2(L10_2)
        L10_2 = false
        L11_2 = ipairs
        L12_2 = L2_2
        L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2)
        for L15_2, L16_2 in L11_2, L12_2, L13_2, L14_2 do
          if L16_2 == L9_2 then
            L10_2 = true
            break
          end
        end
        if not L10_2 then
          L11_2 = table
          L11_2 = L11_2.insert
          L12_2 = L2_2
          L13_2 = L9_2
          L11_2(L12_2, L13_2)
        end
      end
    end
    L3_2 = #L1_2
    if 0 == L3_2 then
      return
    end
    L3_2 = {}
    L4_2 = {}
    L4_2.icon = "fas fa-play"
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "cleaner.start"
    L5_2 = L5_2(L6_2)
    L4_2.label = L5_2
    function L5_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
      L1_3 = pairs
      L2_3 = cleanerRobot
      L3_3 = L2_3
      L2_3 = L2_3.getAll
      L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3 = L2_3(L3_3)
      L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
      for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
        L7_3 = L6_3.robotHandle
        L8_3 = A0_3.entity
        if L7_3 == L8_3 then
          L7_3 = L6_3.state
          if "docked" ~= L7_3 then
            L7_3 = L6_3.state
            if "idle" ~= L7_3 then
              break
            end
          end
          L7_3 = cleanerRobot
          L8_3 = L7_3
          L7_3 = L7_3.startCleaning
          L9_3 = L5_3
          L7_3(L8_3, L9_3)
          break
        end
      end
    end
    L4_2.onSelect = L5_2
    function L5_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
      L1_3 = CurrentHouse
      if not L1_3 then
        L1_3 = false
        return L1_3
      end
      L1_3 = CurrentHouseData
      if L1_3 then
        L1_3 = CurrentHouseData
        L1_3 = L1_3.haskey
        if L1_3 then
          goto lbl_15
        end
      end
      L1_3 = false
      do return L1_3 end
      ::lbl_15::
      L1_3 = pairs
      L2_3 = cleanerRobot
      L3_3 = L2_3
      L2_3 = L2_3.getAll
      L2_3, L3_3, L4_3, L5_3, L6_3, L7_3 = L2_3(L3_3)
      L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
      for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
        L7_3 = L6_3.robotHandle
        if L7_3 == A0_3 then
          L7_3 = L6_3.state
          L7_3 = "docked" == L7_3
          return L7_3
        end
      end
      L1_3 = false
      return L1_3
    end
    L4_2.canInteract = L5_2
    L4_2.distance = 2.5
    L5_2 = {}
    L5_2.icon = "fas fa-stop"
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "cleaner.stop"
    L6_2 = L6_2(L7_2)
    L5_2.label = L6_2
    function L6_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
      L1_3 = pairs
      L2_3 = cleanerRobot
      L3_3 = L2_3
      L2_3 = L2_3.getAll
      L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3 = L2_3(L3_3)
      L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
      for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
        L7_3 = L6_3.robotHandle
        L8_3 = A0_3.entity
        if L7_3 == L8_3 then
          L7_3 = L6_3.state
          if "cleaning" == L7_3 then
            L7_3 = cleanerRobot
            L8_3 = L7_3
            L7_3 = L7_3.stopCleaning
            L9_3 = L5_3
            L7_3(L8_3, L9_3)
          end
          break
        end
      end
    end
    L5_2.onSelect = L6_2
    function L6_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
      L1_3 = CurrentHouse
      if not L1_3 then
        L1_3 = false
        return L1_3
      end
      L1_3 = CurrentHouseData
      if L1_3 then
        L1_3 = CurrentHouseData
        L1_3 = L1_3.haskey
        if L1_3 then
          goto lbl_15
        end
      end
      L1_3 = false
      do return L1_3 end
      ::lbl_15::
      L1_3 = pairs
      L2_3 = cleanerRobot
      L3_3 = L2_3
      L2_3 = L2_3.getAll
      L2_3, L3_3, L4_3, L5_3, L6_3, L7_3 = L2_3(L3_3)
      L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
      for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
        L7_3 = L6_3.robotHandle
        if L7_3 == A0_3 then
          L7_3 = L6_3.state
          L7_3 = "cleaning" == L7_3
          return L7_3
        end
      end
      L1_3 = false
      return L1_3
    end
    L5_2.canInteract = L6_2
    L5_2.distance = 2.5
    L3_2[1] = L4_2
    L3_2[2] = L5_2
    L4_2 = {}
    L5_2 = {}
    L5_2.icon = "fas fa-home"
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "cleaner.return_dock"
    L6_2 = L6_2(L7_2)
    L5_2.label = L6_2
    function L6_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
      L1_3 = pairs
      L2_3 = cleanerRobot
      L3_3 = L2_3
      L2_3 = L2_3.getAll
      L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3 = L2_3(L3_3)
      L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
      for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
        L7_3 = L6_3.dockHandle
        L8_3 = A0_3.entity
        if L7_3 == L8_3 then
          L7_3 = cleanerRobot
          L8_3 = L7_3
          L7_3 = L7_3.returnToDock
          L9_3 = L5_3
          L7_3(L8_3, L9_3)
          break
        end
      end
    end
    L5_2.onSelect = L6_2
    function L6_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
      L1_3 = CurrentHouse
      if not L1_3 then
        L1_3 = false
        return L1_3
      end
      L1_3 = CurrentHouseData
      if L1_3 then
        L1_3 = CurrentHouseData
        L1_3 = L1_3.haskey
        if L1_3 then
          goto lbl_15
        end
      end
      L1_3 = false
      do return L1_3 end
      ::lbl_15::
      L1_3 = pairs
      L2_3 = cleanerRobot
      L3_3 = L2_3
      L2_3 = L2_3.getAll
      L2_3, L3_3, L4_3, L5_3, L6_3, L7_3 = L2_3(L3_3)
      L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
      for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
        L7_3 = L6_3.dockHandle
        if L7_3 == A0_3 then
          L7_3 = L6_3.state
          L7_3 = "cleaning" == L7_3
          return L7_3
        end
      end
      L1_3 = false
      return L1_3
    end
    L5_2.canInteract = L6_2
    L5_2.distance = 2.5
    L6_2 = {}
    L6_2.icon = "fas fa-play"
    L7_2 = i18n
    L7_2 = L7_2.t
    L8_2 = "cleaner.start"
    L7_2 = L7_2(L8_2)
    L6_2.label = L7_2
    function L7_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
      L1_3 = pairs
      L2_3 = cleanerRobot
      L3_3 = L2_3
      L2_3 = L2_3.getAll
      L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3 = L2_3(L3_3)
      L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
      for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
        L7_3 = L6_3.dockHandle
        L8_3 = A0_3.entity
        if L7_3 == L8_3 then
          L7_3 = L6_3.state
          if "docked" ~= L7_3 then
            L7_3 = L6_3.state
            if "idle" ~= L7_3 then
              break
            end
          end
          L7_3 = cleanerRobot
          L8_3 = L7_3
          L7_3 = L7_3.startCleaning
          L9_3 = L5_3
          L7_3(L8_3, L9_3)
          break
        end
      end
    end
    L6_2.onSelect = L7_2
    function L7_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
      L1_3 = CurrentHouse
      if not L1_3 then
        L1_3 = false
        return L1_3
      end
      L1_3 = CurrentHouseData
      if L1_3 then
        L1_3 = CurrentHouseData
        L1_3 = L1_3.haskey
        if L1_3 then
          goto lbl_15
        end
      end
      L1_3 = false
      do return L1_3 end
      ::lbl_15::
      L1_3 = pairs
      L2_3 = cleanerRobot
      L3_3 = L2_3
      L2_3 = L2_3.getAll
      L2_3, L3_3, L4_3, L5_3, L6_3, L7_3 = L2_3(L3_3)
      L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
      for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
        L7_3 = L6_3.dockHandle
        if L7_3 == A0_3 then
          L7_3 = L6_3.state
          L7_3 = "docked" == L7_3
          return L7_3
        end
      end
      L1_3 = false
      return L1_3
    end
    L6_2.canInteract = L7_2
    L6_2.distance = 2.5
    L7_2 = {}
    L7_2.icon = "fas fa-stop"
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "cleaner.stop"
    L8_2 = L8_2(L9_2)
    L7_2.label = L8_2
    function L8_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
      L1_3 = pairs
      L2_3 = cleanerRobot
      L3_3 = L2_3
      L2_3 = L2_3.getAll
      L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3 = L2_3(L3_3)
      L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
      for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
        L7_3 = L6_3.dockHandle
        L8_3 = A0_3.entity
        if L7_3 == L8_3 then
          L7_3 = L6_3.state
          if "cleaning" == L7_3 then
            L7_3 = cleanerRobot
            L8_3 = L7_3
            L7_3 = L7_3.stopCleaning
            L9_3 = L5_3
            L7_3(L8_3, L9_3)
          end
          break
        end
      end
    end
    L7_2.onSelect = L8_2
    function L8_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
      L1_3 = CurrentHouse
      if not L1_3 then
        L1_3 = false
        return L1_3
      end
      L1_3 = CurrentHouseData
      if L1_3 then
        L1_3 = CurrentHouseData
        L1_3 = L1_3.haskey
        if L1_3 then
          goto lbl_15
        end
      end
      L1_3 = false
      do return L1_3 end
      ::lbl_15::
      L1_3 = pairs
      L2_3 = cleanerRobot
      L3_3 = L2_3
      L2_3 = L2_3.getAll
      L2_3, L3_3, L4_3, L5_3, L6_3, L7_3 = L2_3(L3_3)
      L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
      for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
        L7_3 = L6_3.dockHandle
        if L7_3 == A0_3 then
          L7_3 = L6_3.state
          L7_3 = "cleaning" == L7_3
          return L7_3
        end
      end
      L1_3 = false
      return L1_3
    end
    L7_2.canInteract = L8_2
    L7_2.distance = 2.5
    L4_2[1] = L5_2
    L4_2[2] = L6_2
    L4_2[3] = L7_2
    L5_2 = GetResourceState
    L6_2 = "ox_target"
    L5_2 = L5_2(L6_2)
    if "started" == L5_2 then
      L5_2 = exports
      L5_2 = L5_2.ox_target
      L6_2 = L5_2
      L5_2 = L5_2.addModel
      L7_2 = L1_2
      L8_2 = L3_2
      L5_2(L6_2, L7_2, L8_2)
      L5_2 = #L2_2
      if L5_2 > 0 then
        L5_2 = exports
        L5_2 = L5_2.ox_target
        L6_2 = L5_2
        L5_2 = L5_2.addModel
        L7_2 = L2_2
        L8_2 = L4_2
        L5_2(L6_2, L7_2, L8_2)
      end
      L5_2 = Debug
      L6_2 = "CleanerRobot: Registered ox_target models (robot + dock)"
      L5_2(L6_2)
    else
      L5_2 = GetResourceState
      L6_2 = "qb-target"
      L5_2 = L5_2(L6_2)
      if "started" == L5_2 then
        L5_2 = exports
        L5_2 = L5_2["qb-target"]
        L6_2 = L5_2
        L5_2 = L5_2.AddTargetModel
        L7_2 = L1_2
        L8_2 = {}
        L9_2 = {}
        L10_2 = {}
        L10_2.icon = "fas fa-play"
        L11_2 = i18n
        L11_2 = L11_2.t
        L12_2 = "cleaner.start"
        L11_2 = L11_2(L12_2)
        L10_2.label = L11_2
        function L11_2(A0_3)
          local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
          L1_3 = pairs
          L2_3 = cleanerRobot
          L3_3 = L2_3
          L2_3 = L2_3.getAll
          L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3 = L2_3(L3_3)
          L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
          for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
            L7_3 = L6_3.robotHandle
            if L7_3 == A0_3 then
              L7_3 = L6_3.state
              if "docked" ~= L7_3 then
                L7_3 = L6_3.state
                if "idle" ~= L7_3 then
                  break
                end
              end
              L7_3 = cleanerRobot
              L8_3 = L7_3
              L7_3 = L7_3.startCleaning
              L9_3 = L5_3
              L7_3(L8_3, L9_3)
              break
            end
          end
        end
        L10_2.action = L11_2
        function L11_2(A0_3)
          local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
          L1_3 = CurrentHouse
          if not L1_3 then
            L1_3 = false
            return L1_3
          end
          L1_3 = CurrentHouseData
          if L1_3 then
            L1_3 = CurrentHouseData
            L1_3 = L1_3.haskey
            if L1_3 then
              goto lbl_15
            end
          end
          L1_3 = false
          do return L1_3 end
          ::lbl_15::
          L1_3 = pairs
          L2_3 = cleanerRobot
          L3_3 = L2_3
          L2_3 = L2_3.getAll
          L2_3, L3_3, L4_3, L5_3, L6_3, L7_3 = L2_3(L3_3)
          L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
          for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
            L7_3 = L6_3.robotHandle
            if L7_3 == A0_3 then
              L7_3 = L6_3.state
              L7_3 = "docked" == L7_3
              return L7_3
            end
          end
          L1_3 = false
          return L1_3
        end
        L10_2.canInteract = L11_2
        L11_2 = {}
        L11_2.icon = "fas fa-stop"
        L12_2 = i18n
        L12_2 = L12_2.t
        L13_2 = "cleaner.stop"
        L12_2 = L12_2(L13_2)
        L11_2.label = L12_2
        function L12_2(A0_3)
          local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
          L1_3 = pairs
          L2_3 = cleanerRobot
          L3_3 = L2_3
          L2_3 = L2_3.getAll
          L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3 = L2_3(L3_3)
          L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
          for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
            L7_3 = L6_3.robotHandle
            if L7_3 == A0_3 then
              L7_3 = L6_3.state
              if "cleaning" == L7_3 then
                L7_3 = cleanerRobot
                L8_3 = L7_3
                L7_3 = L7_3.stopCleaning
                L9_3 = L5_3
                L7_3(L8_3, L9_3)
              end
              break
            end
          end
        end
        L11_2.action = L12_2
        function L12_2(A0_3)
          local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
          L1_3 = CurrentHouse
          if not L1_3 then
            L1_3 = false
            return L1_3
          end
          L1_3 = CurrentHouseData
          if L1_3 then
            L1_3 = CurrentHouseData
            L1_3 = L1_3.haskey
            if L1_3 then
              goto lbl_15
            end
          end
          L1_3 = false
          do return L1_3 end
          ::lbl_15::
          L1_3 = pairs
          L2_3 = cleanerRobot
          L3_3 = L2_3
          L2_3 = L2_3.getAll
          L2_3, L3_3, L4_3, L5_3, L6_3, L7_3 = L2_3(L3_3)
          L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
          for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
            L7_3 = L6_3.robotHandle
            if L7_3 == A0_3 then
              L7_3 = L6_3.state
              L7_3 = "cleaning" == L7_3
              return L7_3
            end
          end
          L1_3 = false
          return L1_3
        end
        L11_2.canInteract = L12_2
        L9_2[1] = L10_2
        L9_2[2] = L11_2
        L8_2.options = L9_2
        L8_2.distance = 2.5
        L5_2(L6_2, L7_2, L8_2)
        L5_2 = #L2_2
        if L5_2 > 0 then
          L5_2 = exports
          L5_2 = L5_2["qb-target"]
          L6_2 = L5_2
          L5_2 = L5_2.AddTargetModel
          L7_2 = L2_2
          L8_2 = {}
          L9_2 = {}
          L10_2 = {}
          L10_2.icon = "fas fa-home"
          L11_2 = i18n
          L11_2 = L11_2.t
          L12_2 = "cleaner.return_dock"
          L11_2 = L11_2(L12_2)
          L10_2.label = L11_2
          function L11_2(A0_3)
            local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
            L1_3 = pairs
            L2_3 = cleanerRobot
            L3_3 = L2_3
            L2_3 = L2_3.getAll
            L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3 = L2_3(L3_3)
            L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
            for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
              L7_3 = L6_3.dockHandle
              if L7_3 == A0_3 then
                L7_3 = cleanerRobot
                L8_3 = L7_3
                L7_3 = L7_3.returnToDock
                L9_3 = L5_3
                L7_3(L8_3, L9_3)
                break
              end
            end
          end
          L10_2.action = L11_2
          function L11_2(A0_3)
            local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
            L1_3 = CurrentHouse
            if not L1_3 then
              L1_3 = false
              return L1_3
            end
            L1_3 = CurrentHouseData
            if L1_3 then
              L1_3 = CurrentHouseData
              L1_3 = L1_3.haskey
              if L1_3 then
                goto lbl_15
              end
            end
            L1_3 = false
            do return L1_3 end
            ::lbl_15::
            L1_3 = pairs
            L2_3 = cleanerRobot
            L3_3 = L2_3
            L2_3 = L2_3.getAll
            L2_3, L3_3, L4_3, L5_3, L6_3, L7_3 = L2_3(L3_3)
            L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
            for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
              L7_3 = L6_3.dockHandle
              if L7_3 == A0_3 then
                L7_3 = L6_3.state
                L7_3 = "cleaning" == L7_3
                return L7_3
              end
            end
            L1_3 = false
            return L1_3
          end
          L10_2.canInteract = L11_2
          L11_2 = {}
          L11_2.icon = "fas fa-play"
          L12_2 = i18n
          L12_2 = L12_2.t
          L13_2 = "cleaner.start"
          L12_2 = L12_2(L13_2)
          L11_2.label = L12_2
          function L12_2(A0_3)
            local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
            L1_3 = pairs
            L2_3 = cleanerRobot
            L3_3 = L2_3
            L2_3 = L2_3.getAll
            L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3 = L2_3(L3_3)
            L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
            for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
              L7_3 = L6_3.dockHandle
              if L7_3 == A0_3 then
                L7_3 = L6_3.state
                if "docked" ~= L7_3 then
                  L7_3 = L6_3.state
                  if "idle" ~= L7_3 then
                    break
                  end
                end
                L7_3 = cleanerRobot
                L8_3 = L7_3
                L7_3 = L7_3.startCleaning
                L9_3 = L5_3
                L7_3(L8_3, L9_3)
                break
              end
            end
          end
          L11_2.action = L12_2
          function L12_2(A0_3)
            local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
            L1_3 = CurrentHouse
            if not L1_3 then
              L1_3 = false
              return L1_3
            end
            L1_3 = CurrentHouseData
            if L1_3 then
              L1_3 = CurrentHouseData
              L1_3 = L1_3.haskey
              if L1_3 then
                goto lbl_15
              end
            end
            L1_3 = false
            do return L1_3 end
            ::lbl_15::
            L1_3 = pairs
            L2_3 = cleanerRobot
            L3_3 = L2_3
            L2_3 = L2_3.getAll
            L2_3, L3_3, L4_3, L5_3, L6_3, L7_3 = L2_3(L3_3)
            L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
            for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
              L7_3 = L6_3.dockHandle
              if L7_3 == A0_3 then
                L7_3 = L6_3.state
                L7_3 = "docked" == L7_3
                return L7_3
              end
            end
            L1_3 = false
            return L1_3
          end
          L11_2.canInteract = L12_2
          L12_2 = {}
          L12_2.icon = "fas fa-stop"
          L13_2 = i18n
          L13_2 = L13_2.t
          L14_2 = "cleaner.stop"
          L13_2 = L13_2(L14_2)
          L12_2.label = L13_2
          function L13_2(A0_3)
            local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
            L1_3 = pairs
            L2_3 = cleanerRobot
            L3_3 = L2_3
            L2_3 = L2_3.getAll
            L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3 = L2_3(L3_3)
            L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
            for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
              L7_3 = L6_3.dockHandle
              if L7_3 == A0_3 then
                L7_3 = L6_3.state
                if "cleaning" == L7_3 then
                  L7_3 = cleanerRobot
                  L8_3 = L7_3
                  L7_3 = L7_3.stopCleaning
                  L9_3 = L5_3
                  L7_3(L8_3, L9_3)
                end
                break
              end
            end
          end
          L12_2.action = L13_2
          function L13_2(A0_3)
            local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
            L1_3 = CurrentHouse
            if not L1_3 then
              L1_3 = false
              return L1_3
            end
            L1_3 = CurrentHouseData
            if L1_3 then
              L1_3 = CurrentHouseData
              L1_3 = L1_3.haskey
              if L1_3 then
                goto lbl_15
              end
            end
            L1_3 = false
            do return L1_3 end
            ::lbl_15::
            L1_3 = pairs
            L2_3 = cleanerRobot
            L3_3 = L2_3
            L2_3 = L2_3.getAll
            L2_3, L3_3, L4_3, L5_3, L6_3, L7_3 = L2_3(L3_3)
            L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
            for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
              L7_3 = L6_3.dockHandle
              if L7_3 == A0_3 then
                L7_3 = L6_3.state
                L7_3 = "cleaning" == L7_3
                return L7_3
              end
            end
            L1_3 = false
            return L1_3
          end
          L12_2.canInteract = L13_2
          L9_2[1] = L10_2
          L9_2[2] = L11_2
          L9_2[3] = L12_2
          L8_2.options = L9_2
          L8_2.distance = 2.5
          L5_2(L6_2, L7_2, L8_2)
        end
        L5_2 = Debug
        L6_2 = "CleanerRobot: Registered qb-target models (robot + dock)"
        L5_2(L6_2)
      end
    end
  end
  L13_1(L14_1)
end
L13_1 = AddEventHandler
L14_1 = "onResourceStop"
function L15_1(A0_2)
  local L1_2, L2_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 == L1_2 then
    L1_2 = cleanerRobot
    L2_2 = L1_2
    L1_2 = L1_2.cleanAll
    L1_2(L2_2)
  end
end
L13_1(L14_1, L15_1)
L13_1 = RegisterNetEvent
L14_1 = "housing:cleaner:setDecorationAlpha"
function L15_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L3_2 = decorate
  if L3_2 then
    L3_2 = decorate
    L3_2 = L3_2.objects
    if L3_2 then
      goto lbl_9
    end
  end
  do return end
  ::lbl_9::
  L3_2 = pairs
  L4_2 = decorate
  L4_2 = L4_2.objects
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = L8_2.id
    if L9_2 == A1_2 then
      L9_2 = L8_2.handle
      if L9_2 then
        L9_2 = DoesEntityExist
        L10_2 = L8_2.handle
        L9_2 = L9_2(L10_2)
        if L9_2 then
          L9_2 = SetEntityAlpha
          L10_2 = L8_2.handle
          L11_2 = A2_2
          L12_2 = false
          L9_2(L10_2, L11_2, L12_2)
          L9_2 = Debug
          L10_2 = "CleanerRobot: Set decoration alpha"
          L11_2 = A1_2
          L12_2 = A2_2
          L9_2(L10_2, L11_2, L12_2)
        end
      end
      break
    end
  end
  L3_2 = cleanerRobot
  L4_2 = L3_2
  L3_2 = L3_2.get
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L4_2 = L3_2.decorationHandle
    if L4_2 then
      L4_2 = DoesEntityExist
      L5_2 = L3_2.decorationHandle
      L4_2 = L4_2(L5_2)
      if L4_2 then
        L4_2 = SetEntityAlpha
        L5_2 = L3_2.decorationHandle
        L6_2 = A2_2
        L7_2 = false
        L4_2(L5_2, L6_2, L7_2)
      end
    end
  end
end
L13_1(L14_1, L15_1)
L13_1 = RegisterNetEvent
L14_1 = "housing:cleaner:deleteNetworkedRobot"
function L15_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = cleanerRobot
  L3_2 = L2_2
  L2_2 = L2_2.get
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    return
  end
  L3_2 = L2_2.networkedRobotHandle
  if L3_2 then
    L3_2 = DoesEntityExist
    L4_2 = L2_2.networkedRobotHandle
    L3_2 = L3_2(L4_2)
    if L3_2 then
      L3_2 = DeleteEntity
      L4_2 = L2_2.networkedRobotHandle
      L3_2(L4_2)
      L2_2.networkedRobotHandle = nil
      L3_2 = Debug
      L4_2 = "CleanerRobot: Deleted networked robot by server request"
      L5_2 = A1_2
      L3_2(L4_2, L5_2)
    end
  end
  L3_2 = L2_2.decorationHandle
  if L3_2 then
    L3_2 = DoesEntityExist
    L4_2 = L2_2.decorationHandle
    L3_2 = L3_2(L4_2)
    if L3_2 then
      L3_2 = L2_2.decorationHandle
      L2_2.robotHandle = L3_2
      L3_2 = SetEntityCoords
      L4_2 = L2_2.robotHandle
      L5_2 = L2_2.dockCoords
      L5_2 = L5_2.x
      L6_2 = L2_2.dockCoords
      L6_2 = L6_2.y
      L7_2 = L2_2.dockCoords
      L7_2 = L7_2.z
      L8_2 = false
      L9_2 = false
      L10_2 = false
      L11_2 = false
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      L3_2 = SetEntityHeading
      L4_2 = L2_2.robotHandle
      L5_2 = L2_2.dockRotation
      L5_2 = L5_2.z
      L3_2(L4_2, L5_2)
    end
  end
  L2_2.state = "docked"
  L2_2.isOwner = false
end
L13_1(L14_1, L15_1)






