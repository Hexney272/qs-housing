local sincos = require("glm").sincos
local rad = require("glm").rad

local CleanerRobot = lib.class("CleanerRobot")

local TICK_RATE = 16
local DOCK_ARRIVAL_DISTANCE = 0.3

local WALL_DETECT_FRONT = 0.4
local WALL_DETECT_SIDE = 0.4
local WALL_FOLLOW_MAX_DIST = 1.5
local OPENING_THRESHOLD = 2.0
local JUNK_ANGLE_THRESHOLD = 15
local OPENING_PASS_DISTANCE = 0.3


local function getDefaultConfig()
    local cfg = Config.CleanerRobot or {}
    return {
        moveSpeed = cfg.moveSpeed or 0.012,
        maxSpeed = cfg.maxSpeed or 0.018,
        acceleration = cfg.acceleration or 3.0E-4,
        deceleration = cfg.deceleration or 8.0E-4,
        raycastDistance = cfg.raycastDistance or 0.8,
        junkDetectRadius = cfg.junkDetectRadius or 15.0,
        maxDistanceFromDock = cfg.maxDistanceFromDock or 15.0,
        cleaningTimeout = cfg.cleaningTimeout or 300000,
        randomDirectionTime = cfg.randomDirectionTime or 8000,
        maxStuckTime = cfg.maxStuckTime or 3000,
        wobbleEnabled = false ~= cfg.wobbleEnabled,
        wobbleAmount = cfg.wobbleAmount or 0.15,
        wobbleSpeed = cfg.wobbleSpeed or 0.08,
    }
end


function CleanerRobot:constructor()
    local config = getDefaultConfig()
    self.robots = {}
    self.activeThread = false
    self.interactionThread = false
    self.moveSpeed = config.moveSpeed
    self.maxSpeed = config.maxSpeed
    self.acceleration = config.acceleration
    self.deceleration = config.deceleration
    self.raycastDistance = config.raycastDistance
    self.junkDetectRadius = config.junkDetectRadius
    self.maxDistanceFromDock = config.maxDistanceFromDock
    self.cleaningTimeout = config.cleaningTimeout
    self.randomDirectionTime = config.randomDirectionTime
    self.maxStuckTime = config.maxStuckTime
    self.wobbleEnabled = config.wobbleEnabled
    self.wobbleAmount = config.wobbleAmount
    self.wobbleSpeed = config.wobbleSpeed
    self.cleanerModels = {}
    return self
end


function CleanerRobot:buildModelList()
    self.cleanerModels = {}
    for _, category in pairs(Config.Furniture) do
        if category.items then
            for _, item in ipairs(category.items) do
                if item.isCleanerRobot then
                    self.cleanerModels[item.object] = {
                        model = item.object,
                        dockerModel = item.isCleanerRobot.dockerModel,
                    }
                end
                if item.colors then
                    for _, colorVariant in pairs(item.colors) do
                        if colorVariant.isCleanerRobot then
                            self.cleanerModels[colorVariant.object] = {
                                model = colorVariant.object,
                                dockerModel = colorVariant.isCleanerRobot.dockerModel,
                            }
                        end
                    end
                end
            end
        end
    end
end


function CleanerRobot:isCleanerModel(modelName)
    local modelData = self.cleanerModels[modelName]
    return nil ~= modelData, modelData
end

function CleanerRobot:performRaycast(origin, direction, distance, ignoreEntities)
    local endPos = origin + direction * distance
    local ignoreEntity
    if ignoreEntities and ignoreEntities[1] then
        ignoreEntity = ignoreEntities[1]
    else
        ignoreEntity = 0
    end
    local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(
        origin.x, origin.y, origin.z,
        endPos.x, endPos.y, endPos.z,
        17, ignoreEntity, 4
    )
    local _, hitResult, hitCoords, _, _, hitEntity = GetShapeTestResultIncludingMaterial(rayHandle)
    if 1 == hitResult then
        return true, vec3(hitCoords.x, hitCoords.y, hitCoords.z), hitEntity
    end
    return false, nil, nil
end


function CleanerRobot:headingToDirection(heading)
    local sin, cos = sincos(rad(vec3(0, 0, heading)))
    return vec3(sin.z, cos.z, 0.0)
end

function CleanerRobot:canMoveInDirection(robot, angle)
    if not DoesEntityExist(robot.robotHandle) then
        return false
    end
    local coords = GetEntityCoords(robot.robotHandle)
    local normalizedAngle = self:normalizeAngle(angle)
    local direction = self:headingToDirection(normalizedAngle)
    local rayOrigin = vec3(coords.x, coords.y, coords.z + 0.15)
    local hit, hitPos, hitEntity = self:performRaycast(rayOrigin, direction, self.raycastDistance, { robot.dockHandle })
    if hit then
        if hitEntity ~= robot.dockHandle then
            if hitPos then
                local hitDistance = #(coords - hitPos)
                Debug("CleanerRobot: Hit obstacle in direction:", normalizedAngle, "distance", hitDistance)
                return hitDistance >= self.raycastDistance
            end
            return false
        end
    end
    return true
end


function CleanerRobot:isForwardClear(robot)
    if not DoesEntityExist(robot.robotHandle) then
        return false
    end
    local heading = robot.currentHeading
    if not heading then
        heading = GetEntityHeading(robot.robotHandle)
    end
    return self:canMoveInDirection(robot, heading)
end

function CleanerRobot:getDistanceInDirection(robot, angle, maxDistance)
    if not DoesEntityExist(robot.robotHandle) then
        return maxDistance
    end
    local coords = GetEntityCoords(robot.robotHandle)
    local direction = self:headingToDirection(angle)
    local rayOrigin = vec3(coords.x, coords.y, coords.z + 0.15)
    local hit, hitPos, hitEntity = self:performRaycast(rayOrigin, direction, maxDistance, { robot.robotHandle, robot.dockHandle })
    if hit then
        if hitEntity ~= robot.dockHandle and hitPos then
            return #(coords - hitPos)
        end
    end
    return maxDistance
end


function CleanerRobot:initRoombaState(robot)
    local heading = robot.currentHeading
    if not heading then
        heading = GetEntityHeading(robot.robotHandle)
        if not heading then
            heading = 0
        end
    end
    robot.navState = "moving"
    robot.moveDirection = heading
    robot.lastWallDistance = nil
    robot.wallFollowStartTime = nil
    robot.openingDetected = false
    robot.openingDirection = nil
    robot.turnCompletePosition = nil
    robot.isInitialized = true
    Debug("CleanerRobot: Wall-following initialized, direction:", robot.moveDirection)
end

function CleanerRobot:getWallDistance(robot, angle, maxDistance)
    return self:getDistanceInDirection(robot, angle, maxDistance)
end

function CleanerRobot:isFrontBlocked(robot)
    local dist = self:getWallDistance(robot, robot.moveDirection, WALL_DETECT_FRONT)
    return dist < WALL_DETECT_FRONT, dist
end


function CleanerRobot:getRightWallDistance(robot)
    local rightAngle = self:normalizeAngle(robot.moveDirection - 90)
    return self:getWallDistance(robot, rightAngle, WALL_DETECT_SIDE)
end

function CleanerRobot:checkRightOpening(robot)
    local rightDist = self:getRightWallDistance(robot)
    local lastDist = robot.lastWallDistance
    if not lastDist then
        lastDist = rightDist
    end
    local distDelta = rightDist - lastDist
    if distDelta > OPENING_THRESHOLD then
        local openingAngle = self:normalizeAngle(robot.moveDirection - 90)
        Debug("CleanerRobot: Opening detected! Distance jump from", lastDist, "to", rightDist)
        return true, openingAngle
    end
    return false, 0
end


function CleanerRobot:findAllJunkInRange(robot, maxRange)
    local results = {}
    local robotCoords = GetEntityCoords(robot.robotHandle)
    if not maxRange then
        maxRange = self.maxDistanceFromDock
    end
    local allJunk = junk:getAll()
    if not allJunk then
        return results
    end
    for junkId, junkData in pairs(allJunk) do
        local alreadyCleaned = false
        for _, cleanedId in ipairs(robot.cleanedJunk) do
            if cleanedId == junkId then
                alreadyCleaned = true
                break
            end
        end
        if not alreadyCleaned then
            if junkData.handle then
                if DoesEntityExist(junkData.handle) then
                    local junkCoords = GetEntityCoords(junkData.handle)
                    local dist = #(robotCoords - junkCoords)
                    if maxRange >= dist then
                        table.insert(results, {
                            id = junkId,
                            coords = junkCoords,
                            distance = dist,
                            handle = junkData.handle,
                        })
                    end
                end
            end
        end
    end
    table.sort(results, function(a, b)
        return a.distance < b.distance
    end)
    return results
end


function CleanerRobot:findNearbyJunk(robot)
    local junkList = self:findAllJunkInRange(robot, self.maxDistanceFromDock)
    if #junkList > 0 then
        local closest = junkList[1]
        if closest.handle then
            if DoesEntityExist(closest.handle) then
                return closest.id, closest.coords
            end
        end
    end
    return nil, nil
end


function CleanerRobot:findVeryCloseJunk(robot, maxRange)
    if not maxRange then
        maxRange = 1.5
    end
    local robotCoords = GetEntityCoords(robot.robotHandle)
    local allJunk = junk:getAll()
    if not allJunk then
        return nil, nil, nil
    end
    local closest = nil
    local closestDist = math.huge
    for junkId, junkData in pairs(allJunk) do
        local alreadyCleaned = false
        for _, cleanedId in ipairs(robot.cleanedJunk) do
            if cleanedId == junkId then
                alreadyCleaned = true
                break
            end
        end
        if not alreadyCleaned then
            if junkData.handle then
                if DoesEntityExist(junkData.handle) then
                    local junkCoords = GetEntityCoords(junkData.handle)
                    local dist = #(robotCoords - junkCoords)
                    if maxRange >= dist and closestDist > dist then
                        closest = {
                            id = junkId,
                            coords = junkCoords,
                            distance = dist,
                        }
                        closestDist = dist
                    end
                end
            end
        end
    end
    if closest then
        return closest.id, closest.coords, closest.distance
    end
    return nil, nil, nil
end


function CleanerRobot:findVisibleJunk(robot)
    local robotCoords = GetEntityCoords(robot.robotHandle)
    local allJunk = junk:getAll()
    if not allJunk then
        return nil, nil, nil
    end
    local visibleJunk = {}
    for junkId, junkData in pairs(allJunk) do
        local alreadyCleaned = false
        for _, cleanedId in ipairs(robot.cleanedJunk) do
            if cleanedId == junkId then
                alreadyCleaned = true
                break
            end
        end
        if not alreadyCleaned then
            if junkData.handle then
                if DoesEntityExist(junkData.handle) then
                    local junkCoords = GetEntityCoords(junkData.handle)
                    local dist = #(robotCoords - junkCoords)
                    local isVisible = self:isJunkVisible(robot, junkData.handle)
                    if isVisible then
                        table.insert(visibleJunk, {
                            id = junkId,
                            coords = junkCoords,
                            distance = dist,
                        })
                    end
                end
            end
        end
    end
    if 0 == #visibleJunk then
        return nil, nil, nil
    end
    table.sort(visibleJunk, function(a, b)
        return a.distance < b.distance
    end)
    local nearest = visibleJunk[1]
    return nearest.id, nearest.coords, nearest.distance
end


function CleanerRobot:cleanJunk(robot, junkId)
    local alreadyCleaned = false
    for _, cleanedId in ipairs(robot.cleanedJunk) do
        if cleanedId == junkId then
            alreadyCleaned = true
            break
        end
    end
    if alreadyCleaned then
        Debug("CleanerRobot: Junk already cleaned:", junkId)
        return
    end
    table.insert(robot.cleanedJunk, junkId)
    local allJunk = junk:getAll()
    if allJunk then
        if allJunk[junkId] then
            if allJunk[junkId].handle then
                if DoesEntityExist(allJunk[junkId].handle) then
                    SetEntityDrawOutline(allJunk[junkId].handle, false)
                end
            end
        end
    end
    local success = lib.callback.await("housing:junk:remove", false, junkId, robot.house)
    if success then
        junk:remove(junkId)
        Debug("CleanerRobot: Cleaned and removed junk", junkId)
        PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
    else
        for i, cleanedId in ipairs(robot.cleanedJunk) do
            if cleanedId == junkId then
                table.remove(robot.cleanedJunk, i)
                break
            end
        end
        Debug("CleanerRobot: Failed to remove junk on server:", junkId)
    end
end


function CleanerRobot:lerp(from, to, alpha)
    local t = math.min(alpha, 1.0)
    return from + (to - from) * t
end

function CleanerRobot:normalizeAngle(angle)
    while angle < 0 do
        angle = angle + 360
    end
    while angle >= 360 do
        angle = angle - 360
    end
    return angle
end

function CleanerRobot:getAngleDifference(from, to)
    local diff = to - from
    while diff > 180 do
        diff = diff - 360
    end
    while diff < -180 do
        diff = diff + 360
    end
    return diff
end

function CleanerRobot:hasReachedTargetHeading(robot, tolerance)
    if not tolerance then
        tolerance = 5
    end
    local currentHeading = robot.currentHeading or 0
    local targetHeading = robot.targetHeading or 0
    local absDiff = math.abs(self:getAngleDifference(currentHeading, targetHeading))
    return tolerance >= absDiff
end


function CleanerRobot:canUpdateTargetHeading(robot)
    local now = GetGameTimer()
    if not robot.headingLockTime then
        return true
    end
    local elapsed = now - robot.headingLockTime
    if elapsed > 500 then
        return true
    end
    if self:hasReachedTargetHeading(robot, 10) then
        return true
    end
    return false
end


function CleanerRobot:updateRotation(robot, targetAngle, forceUpdate)
    if not DoesEntityExist(robot.robotHandle) then
        return
    end
    local normalizedTarget = self:normalizeAngle(targetAngle)
    if not forceUpdate then
        if robot.targetHeading then
            local angleDiff = math.abs(self:getAngleDifference(robot.targetHeading, normalizedTarget))
            if angleDiff > 30 then
                if not self:canUpdateTargetHeading(robot) then
                    normalizedTarget = robot.targetHeading
                end
            else
                robot.headingLockTime = GetGameTimer()
            end
        end
    else
        robot.headingLockTime = GetGameTimer()
    end
    robot.targetHeading = normalizedTarget
    local currentHeading = robot.currentHeading
    if not currentHeading then
        currentHeading = GetEntityHeading(robot.robotHandle)
    end
    local diff = self:getAngleDifference(currentHeading, normalizedTarget)
    local turnSpeed = 8.0
    local stepSize = math.min(math.abs(diff), turnSpeed)
    local newHeading
    if math.abs(diff) < 1 then
        newHeading = normalizedTarget
    else
        local sign = diff > 0 and 1 or -1
        newHeading = self:normalizeAngle(currentHeading + stepSize * sign)
    end


    if self.wobbleEnabled then
        if robot.velocity > 0.001 then
            if math.abs(diff) < 10 then
                local wobblePhase = robot.wobblePhase or 0
                wobblePhase = wobblePhase + self.wobbleSpeed
                robot.wobblePhase = wobblePhase
                local wobbleOffset = math.sin(wobblePhase) * self.wobbleAmount
                wobbleOffset = wobbleOffset * (robot.velocity / self.maxSpeed)
                newHeading = newHeading + wobbleOffset
            end
        end
    end
    robot.currentHeading = newHeading
    local entityHeading = self:normalizeAngle(newHeading + 180)
    SetEntityHeading(robot.robotHandle, entityHeading)
end


function CleanerRobot:updateVelocity(robot, shouldAccelerate)
    local currentVelocity = robot.velocity or 0
    if shouldAccelerate then
        local targetSpeed = self.moveSpeed
        robot.velocity = self:lerp(currentVelocity, targetSpeed, self.acceleration * 10)
        if robot.velocity > self.maxSpeed then
            robot.velocity = self.maxSpeed
        end
    else
        robot.velocity = self:lerp(currentVelocity, 0, self.deceleration * 10)
        if robot.velocity < 1.0E-4 then
            robot.velocity = 0
        end
    end
end


function CleanerRobot:applyMovement(robot, _unused)
    if not DoesEntityExist(robot.robotHandle) then
        return false
    end
    if robot.velocity < 1.0E-4 then
        return false
    end
    local coords = GetEntityCoords(robot.robotHandle)
    local heading = robot.currentHeading
    if not heading then
        heading = GetEntityHeading(robot.robotHandle)
    end
    local direction = self:headingToDirection(heading)
    local moveVec = direction * robot.velocity
    local newX = coords.x + moveVec.x
    local newY = coords.y + moveVec.y
    local newZ = robot.baseZ + robot.robotHeightOffset
    SetEntityCoords(robot.robotHandle, newX, newY, newZ, false, false, false, false)
    robot.lastMoveTime = GetGameTimer()
    return true
end


function CleanerRobot:isJunkVisible(robot, junkHandle)
    if not DoesEntityExist(robot.robotHandle) then
        return false
    end
    if not DoesEntityExist(junkHandle) then
        return false
    end
    local robotCoords = GetEntityCoords(robot.robotHandle)
    local junkCoords = GetEntityCoords(junkHandle)
    local zDiff = math.abs(robotCoords.z - junkCoords.z)
    if zDiff > 3.0 then
        return false
    end
    return HasEntityClearLosToEntity(robot.robotHandle, junkHandle, 17)
end


function CleanerRobot:updateCleaningState(robot, _unused)
    if not DoesEntityExist(robot.robotHandle) then
        return 0, false
    end
    local robotCoords = GetEntityCoords(robot.robotHandle)
    local currentHeading = robot.currentHeading
    if not currentHeading then
        currentHeading = GetEntityHeading(robot.robotHandle)
    end
    if not robot.isInitialized then
        self:initRoombaState(robot)
    end
    if not robot.navState then
        robot.navState = "moving"
    end
    if not robot.moveDirection or type(robot.moveDirection) ~= "number" then
        robot.moveDirection = currentHeading
    end
    local headingDiff = math.abs(self:getAngleDifference(currentHeading, robot.moveDirection))

    -- Check for visible junk
    local visibleJunkId, visibleJunkCoords, visibleJunkDist = self:findVisibleJunk(robot)
    if visibleJunkId and visibleJunkCoords then
        if visibleJunkDist < 1.2 then
            self:cleanJunk(robot, visibleJunkId)
            robot.currentTarget = nil
            robot.turnCompletePosition = nil
            robot.navState = "moving"
            robot.lastWallDistance = nil
            robot.moveDirection = currentHeading
            Debug("CleanerRobot: Cleaned visible junk, back to normal movement")
            return currentHeading, true
        end


        local dx = visibleJunkCoords.x - robotCoords.x
        local dy = visibleJunkCoords.y - robotCoords.y
        local angleToJunk = self:normalizeAngle(math.deg(math.atan(dx, dy)))
        local angleDiffToJunk = math.abs(self:getAngleDifference(currentHeading, angleToJunk))
        if angleDiffToJunk > JUNK_ANGLE_THRESHOLD then
            robot.moveDirection = angleToJunk
            robot.navState = "turning_to_junk"
            robot.currentTarget = visibleJunkCoords
            Debug("CleanerRobot: Visible junk found! OVERRIDING current state, turning to face it. Distance:", visibleJunkDist)
            return angleToJunk, false
        else
            robot.navState = "moving"
            robot.lastWallDistance = nil
            robot.moveDirection = angleToJunk
            robot.currentTarget = visibleJunkCoords
            Debug("CleanerRobot: Visible junk found! OVERRIDING current state, going straight to it. Distance:", visibleJunkDist)
            return angleToJunk, true
        end
    end


    -- Check for very close junk (fallback)
    local closeJunkId, closeJunkCoords, closeJunkDist = self:findVeryCloseJunk(robot, 1.5)
    if closeJunkId and closeJunkCoords then
        self:cleanJunk(robot, closeJunkId)
        robot.currentTarget = nil
        robot.turnCompletePosition = nil
        robot.navState = "moving"
        robot.lastWallDistance = nil
        robot.moveDirection = currentHeading
        Debug("CleanerRobot: Cleaned very close junk (1.5m), back to normal movement. Distance:", closeJunkDist)
        return currentHeading, true
    end


    -- State: turning_to_junk
    if "turning_to_junk" == robot.navState then
        if visibleJunkId and visibleJunkCoords then
            local dx = visibleJunkCoords.x - robotCoords.x
            local dy = visibleJunkCoords.y - robotCoords.y
            local angleToJunk = self:normalizeAngle(math.deg(math.atan(dx, dy)))
            local angleDiffToJunk = math.abs(self:getAngleDifference(currentHeading, angleToJunk))
            if angleDiffToJunk > JUNK_ANGLE_THRESHOLD then
                robot.moveDirection = angleToJunk
                robot.currentTarget = visibleJunkCoords
                return angleToJunk, false
            else
                robot.navState = "moving"
                robot.lastWallDistance = nil
                robot.moveDirection = angleToJunk
                robot.currentTarget = visibleJunkCoords
                return angleToJunk, true
            end
        end
        if headingDiff < JUNK_ANGLE_THRESHOLD then
            robot.navState = "moving"
            robot.moveDirection = currentHeading
            robot.turnCompletePosition = vec3(robotCoords.x, robotCoords.y, robotCoords.z)
            Debug("CleanerRobot: Turned to junk, moving towards it")
            return currentHeading, true
        end
        return robot.moveDirection, false
    end


    -- State: turning
    if "turning" == robot.navState then
        if visibleJunkId and visibleJunkCoords then
            local dx = visibleJunkCoords.x - robotCoords.x
            local dy = visibleJunkCoords.y - robotCoords.y
            local angleToJunk = self:normalizeAngle(math.deg(math.atan(dx, dy)))
            robot.moveDirection = angleToJunk
            robot.navState = "turning_to_junk"
            robot.currentTarget = visibleJunkCoords
            Debug("CleanerRobot: Visible junk found while turning, switching to junk!")
            return angleToJunk, false
        end
        if headingDiff < JUNK_ANGLE_THRESHOLD then
            robot.turnCompletePosition = vec3(robotCoords.x, robotCoords.y, robotCoords.z)
            robot.moveDirection = currentHeading
            if robot.openingDetected then
                robot.navState = "passing_opening"
                robot.openingDetected = false
                Debug("CleanerRobot: Now passing through opening")
            else
                robot.navState = "following_wall"
                robot.lastWallDistance = self:getRightWallDistance(robot)
                robot.wallFollowStartTime = GetGameTimer()
                Debug("CleanerRobot: Turn complete, now following wall. Right wall dist:", robot.lastWallDistance)
            end
            return currentHeading, true
        end
        return robot.moveDirection, false
    end


    -- State: passing_opening
    if "passing_opening" == robot.navState then
        if visibleJunkId and visibleJunkCoords then
            local dx = visibleJunkCoords.x - robotCoords.x
            local dy = visibleJunkCoords.y - robotCoords.y
            local angleToJunk = self:normalizeAngle(math.deg(math.atan(dx, dy)))
            local angleDiffToJunk = math.abs(self:getAngleDifference(currentHeading, angleToJunk))
            if angleDiffToJunk > JUNK_ANGLE_THRESHOLD then
                robot.moveDirection = angleToJunk
                robot.navState = "turning_to_junk"
                robot.currentTarget = visibleJunkCoords
                Debug("CleanerRobot: Visible junk found while passing opening, switching to junk!")
                return angleToJunk, false
            else
                robot.navState = "moving"
                robot.lastWallDistance = nil
                robot.moveDirection = angleToJunk
                robot.currentTarget = visibleJunkCoords
                Debug("CleanerRobot: Visible junk found while passing opening, going straight!")
                return angleToJunk, true
            end
        end
        if robot.turnCompletePosition then
            local dx = robotCoords.x - robot.turnCompletePosition.x
            local dy = robotCoords.y - robot.turnCompletePosition.y
            local distFromTurn = math.sqrt(dx * dx + dy * dy)
            if distFromTurn > OPENING_PASS_DISTANCE + 0.5 then
                robot.navState = "moving"
                robot.turnCompletePosition = nil
                robot.lastWallDistance = nil
                Debug("CleanerRobot: Passed through opening, RESET to normal movement")
            end
        else
            robot.navState = "moving"
            robot.lastWallDistance = nil
        end


        local frontDist = self:getWallDistance(robot, currentHeading, WALL_DETECT_FRONT)
        if frontDist < WALL_DETECT_FRONT then
            Debug("CleanerRobot: Passing opening, frontDist:", frontDist, "WALL_DETECT_FRONT:", WALL_DETECT_FRONT)
            local newDir = self:normalizeAngle(currentHeading + 90)
            robot.moveDirection = newDir
            robot.navState = "turning"
            robot.openingDetected = false
            return robot.moveDirection, false
        end
        return currentHeading, true
    end


    -- State: following_wall
    if "following_wall" == robot.navState then
        if visibleJunkId and visibleJunkCoords then
            local dx = visibleJunkCoords.x - robotCoords.x
            local dy = visibleJunkCoords.y - robotCoords.y
            local angleToJunk = self:normalizeAngle(math.deg(math.atan(dx, dy)))
            local angleDiffToJunk = math.abs(self:getAngleDifference(currentHeading, angleToJunk))
            if angleDiffToJunk > JUNK_ANGLE_THRESHOLD then
                robot.moveDirection = angleToJunk
                robot.navState = "turning_to_junk"
                robot.currentTarget = visibleJunkCoords
                Debug("CleanerRobot: Visible junk found while following wall, switching to junk!")
                return angleToJunk, false
            else
                robot.navState = "moving"
                robot.lastWallDistance = nil
                robot.moveDirection = angleToJunk
                robot.currentTarget = visibleJunkCoords
                Debug("CleanerRobot: Visible junk found while following wall, going straight!")
                return angleToJunk, true
            end
        end
        local frontDist = self:getWallDistance(robot, currentHeading, WALL_DETECT_FRONT)
        if frontDist < WALL_DETECT_FRONT then
            Debug("838 CleanerRobot: Wall ahead while following, frontDist:", frontDist, "WALL_DETECT_FRONT:", WALL_DETECT_FRONT)
            local newDir = self:normalizeAngle(currentHeading + 90)
            robot.moveDirection = newDir
            robot.navState = "turning"
            robot.openingDetected = false
            Debug("CleanerRobot: Wall ahead while following, turning left")
            return robot.moveDirection, false
        end


        local rightDist = self:getRightWallDistance(robot)
        local lastWallDist = robot.lastWallDistance
        if not lastWallDist then
            lastWallDist = rightDist
        end
        local distDelta = rightDist - lastWallDist
        if distDelta > OPENING_THRESHOLD then
            local rightAngle = self:normalizeAngle(currentHeading - 90)
            local rightFrontDist = self:getWallDistance(robot, rightAngle, WALL_DETECT_FRONT)
            if rightFrontDist >= WALL_DETECT_FRONT then
                Debug("859 CleanerRobot: Opening detected! Dist jumped from", lastWallDist, "to", rightDist)
                robot.moveDirection = rightAngle
                robot.navState = "turning"
                robot.openingDetected = true
                robot.openingDirection = rightAngle
                Debug("CleanerRobot: Opening detected! Dist jumped from", lastWallDist, "to", rightDist)
                return robot.moveDirection, false
            end
        end
        robot.lastWallDistance = rightDist
        return currentHeading, true
    end


    -- State: moving (default)
    if robot.turnCompletePosition then
        local dx = robotCoords.x - robot.turnCompletePosition.x
        local dy = robotCoords.y - robot.turnCompletePosition.y
        local distFromTurn = math.sqrt(dx * dx + dy * dy)
        if distFromTurn < OPENING_PASS_DISTANCE then
            return currentHeading, true
        else
            robot.turnCompletePosition = nil
        end
    end
    local frontDist = self:getWallDistance(robot, currentHeading, WALL_DETECT_FRONT)
    if frontDist < WALL_DETECT_FRONT then
        local newDir = self:normalizeAngle(currentHeading + 90)
        robot.moveDirection = newDir
        robot.navState = "turning"
        robot.openingDetected = false
        return robot.moveDirection, false
    end
    robot.moveDirection = currentHeading
    return currentHeading, true
end


function CleanerRobot:isPathBlocked(robot, angle)
    local dist = self:getWallDistance(robot, angle, WALL_DETECT_FRONT)
    return dist < WALL_DETECT_FRONT, dist
end


function CleanerRobot:updateReturningState(robot)
    if not DoesEntityExist(robot.robotHandle) then
        return true
    end
    local robotCoords = GetEntityCoords(robot.robotHandle)
    local dockCoords = robot.dockCoords
    local distToDock = math.sqrt((robotCoords.x - dockCoords.x) ^ 2 + (robotCoords.y - dockCoords.y) ^ 2)

    if distToDock < DOCK_ARRIVAL_DISTANCE then
        robot.velocity = 0
        robot.state = "docked"
        if robot.isOwner then
            if robot.networkedRobotHandle then
                if DoesEntityExist(robot.networkedRobotHandle) then
                    DeleteEntity(robot.networkedRobotHandle)
                end
                robot.networkedRobotHandle = nil
                if robot.decorationHandle then
                    if DoesEntityExist(robot.decorationHandle) then
                        robot.robotHandle = robot.decorationHandle
                        SetEntityCoords(robot.robotHandle, dockCoords.x, dockCoords.y, dockCoords.z, false, false, false, false)
                        SetEntityHeading(robot.robotHandle, robot.dockRotation.z)
                    end
                end
                TriggerServerEvent("housing:cleaner:stopped", robot.house, robot.id)
                robot.isOwner = false
            end
        end
        robot.currentHeading = robot.dockRotation.z
        Debug("CleanerRobot: Returned to dock")
        PlaySoundFrontend(-1, "Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true)
        SendReactMessage("cleaner_sound", { action = "stop" })
        return true
    end


    -- Move towards dock
    local dirX = dockCoords.x - robotCoords.x
    local dirY = dockCoords.y - robotCoords.y
    local dirLength = math.sqrt(dirX * dirX + dirY * dirY)
    if dirLength > 0 then
        dirX = dirX / dirLength
        dirY = dirY / dirLength
    end
    local headingToDock = math.deg(math.atan(dirX, dirY))
    robot.currentHeading = self:normalizeAngle(headingToDock)
    SetEntityHeading(robot.robotHandle, robot.currentHeading)
    local speed = self.moveSpeed * 1.5
    local newX = robotCoords.x + dirX * speed
    local newY = robotCoords.y + dirY * speed
    local newZ = robot.baseZ + robot.robotHeightOffset
    SetEntityCoords(robot.robotHandle, newX, newY, newZ, false, false, false, false)
    robot.lastMoveTime = GetGameTimer()
    return false
end


function CleanerRobot:startUpdateLoop()
    if self.activeThread then
        return
    end
    self.activeThread = true
    CreateThread(function()
        while self.activeThread do
            local hasActive = false
            for robotId, robot in pairs(self.robots) do
                if robot.state == "cleaning" or robot.state == "returning" then
                    hasActive = true
                    if not robot.velocity then
                        robot.velocity = 0
                    end
                    if not robot.wobblePhase then
                        robot.wobblePhase = 0
                    end
                    if not robot.currentHeading then
                        robot.currentHeading = GetEntityHeading(robot.robotHandle)
                    end
                    if not robot.isInitialized then
                        self:initRoombaState(robot)
                    end


                    if robot.state == "cleaning" then
                        if robot.cleaningStartTime then
                            local elapsed = GetGameTimer() - robot.cleaningStartTime
                            if elapsed >= self.cleaningTimeout then
                                robot.state = "returning"
                                robot.cleaningStartTime = nil
                                Notification(i18n.t("cleaner.returning"), "info")
                                Debug("CleanerRobot: Cleaning timeout, returning to dock", robotId)
                            end
                        else
                            local targetDir, shouldMove = self:updateCleaningState(robot)
                            self:updateRotation(robot, targetDir, false)
                            self:updateVelocity(robot, shouldMove)
                            if shouldMove then
                                self:applyMovement(robot, false)
                            end
                        end
                    elseif robot.state == "returning" then
                        self:updateReturningState(robot)
                    end
                end
            end
            if not hasActive then
                self.activeThread = false
                break
            end
            Wait(TICK_RATE)
        end
    end)
end


function CleanerRobot:spawnForDecoration(decoration, houseId)
    if not decoration or not decoration.id then
        return false
    end
    local isModel, modelData = self:isCleanerModel(decoration.modelName)
    if not isModel or not modelData then
        return false
    end
    if self.robots[decoration.id] then
        Debug("CleanerRobot: Robot already exists for decoration", decoration.id)
        return true
    end
    local decoHandle = decoration.handle
    if not decoHandle or not DoesEntityExist(decoHandle) then
        Debug("CleanerRobot: Decoration object handle not found")
        return false
    end
    local coords = decoration.coords
    local rotation = decoration.rotation
    if not rotation then
        rotation = vec3(0, 0, 0)
    end


    local robotModelHash = joaat(modelData.model)
    local dockModelHash = joaat(modelData.dockerModel)

    lib.requestModel(dockModelHash, Config.DefaultRequestModelTimeout or 5000)
    local dockHandle = CreateObject(dockModelHash, coords.x, coords.y, coords.z - 0.07, false, false, false)
    if not DoesEntityExist(dockHandle) then
        Debug("CleanerRobot: Failed to spawn dock")
        SetModelAsNoLongerNeeded(dockModelHash)
        return false
    end
    SetEntityRotation(dockHandle, rotation.x, rotation.y, rotation.z, 0, false)
    FreezeEntityPosition(dockHandle, true)
    SetEntityCompletelyDisableCollision(dockHandle, true, false)
    SetModelAsNoLongerNeeded(dockModelHash)

    local dockMin, dockMax = GetModelDimensions(dockModelHash)
    local dockHeight = dockMax.z - dockMin.z
    local baseZ = coords.z

    local robotMin, robotMax = GetModelDimensions(robotModelHash)
    local robotHeightOffset = (robotMax.z - robotMin.z) * 0.5
    local dockPosition = vec3(coords.x, coords.y, baseZ + robotHeightOffset)


    local robotData = {
        id = decoration.id,
        decorationObj = decoration,
        robotHandle = decoHandle,
        dockHandle = dockHandle,
        robotModel = modelData.model,
        dockModel = modelData.dockerModel,
        dockCoords = dockPosition,
        dockRotation = rotation,
        baseZ = baseZ,
        robotHeightOffset = robotHeightOffset,
        state = "docked",
        currentTarget = nil,
        cleanedJunk = {},
        house = houseId,
        velocity = 0,
        targetHeading = rotation.z,
        currentHeading = rotation.z,
        wobblePhase = 0,
        lastMoveTime = 0,
        lastKnownCoords = vec3(coords.x, coords.y, coords.z),
        isInitialized = false,
        navState = "moving",
        moveDirection = nil,
        lastWallDistance = nil,
        wallFollowStartTime = nil,
        openingDetected = false,
        openingDirection = nil,
        turnCompletePosition = nil,
    }
    self.robots[decoration.id] = robotData
    Debug("CleanerRobot: Initialized cleaner for decoration", decoration.id)
    return true
end


function CleanerRobot:despawn(robotId)
    local robot = self.robots[robotId]
    if not robot then
        return
    end
    if robot.isOwner then
        if robot.state == "cleaning" or robot.state == "returning" then
            TriggerServerEvent("housing:cleaner:stopped", robot.house, robotId)
            SendReactMessage("cleaner_sound", { action = "stop" })
        end
    end
    if robot.networkedRobotHandle then
        if DoesEntityExist(robot.networkedRobotHandle) then
            DeleteEntity(robot.networkedRobotHandle)
            robot.networkedRobotHandle = nil
        end
    end
    if DoesEntityExist(robot.dockHandle) then
        DeleteEntity(robot.dockHandle)
    end
    if DoesEntityExist(robot.robotHandle) then
        SetEntityCoords(robot.robotHandle, robot.dockCoords.x, robot.dockCoords.y, robot.dockCoords.z, false, false, false, false)
        SetEntityHeading(robot.robotHandle, robot.dockRotation.z)
    end
    self.robots[robotId] = nil
    Debug("CleanerRobot: Despawned cleaner", robotId)
end


function CleanerRobot:startCleaning(robotId)
    local robot = self.robots[robotId]
    if not robot then
        Debug("CleanerRobot: Robot not found", robotId)
        return
    end
    if robot.state ~= "docked" and robot.state ~= "idle" then
        Debug("CleanerRobot: Robot is not ready to clean", robot.state)
        return
    end
    local success, reason = lib.callback.await("housing:cleaner:start", false, robot.house, robotId, robot.robotModel)
    if not success then
        if "already_active" == reason then
            Notification(i18n.t("cleaner.already_active"), "error")
        end
        Debug("CleanerRobot: Server rejected start", reason)
        return
    end
    robot.decorationHandle = robot.robotHandle
    robot.isOwner = true


    local robotModelHash = joaat(robot.robotModel)
    lib.requestModel(robotModelHash, Config.DefaultRequestModelTimeout or 5000)
    local dockCoords = robot.dockCoords
    local networkedHandle = CreateObject(robotModelHash, dockCoords.x, dockCoords.y, dockCoords.z, true, true, true)
    if not DoesEntityExist(networkedHandle) then
        Debug("CleanerRobot: Failed to spawn networked robot")
        TriggerServerEvent("housing:cleaner:stopped", robot.house, robotId)
        SetModelAsNoLongerNeeded(robotModelHash)
        return
    end
    SetEntityInvincible(networkedHandle, true)
    SetEntityRotation(networkedHandle, 0.0, 0.0, robot.dockRotation.z, 0, false)
    SetEntityCompletelyDisableCollision(networkedHandle, true, false)
    SetModelAsNoLongerNeeded(robotModelHash)
    robot.networkedRobotHandle = networkedHandle
    robot.robotHandle = networkedHandle
    local networkId = NetworkGetNetworkIdFromEntity(networkedHandle)
    TriggerServerEvent("housing:cleaner:updateNetworkId", robot.house, robotId, networkId)


    robot.state = "cleaning"
    robot.cleanedJunk = {}
    robot.velocity = 0
    robot.wobblePhase = 0
    robot.currentHeading = GetEntityHeading(networkedHandle)
    robot.targetHeading = robot.currentHeading
    robot.lastMoveTime = GetGameTimer()
    robot.cleaningStartTime = GetGameTimer()
    self:initRoombaState(robot)
    robot.currentTarget = nil
    Debug("CleanerRobot: Started cleaning with networked robot", robotId, "networkId", networkId)
    Notification(i18n.t("cleaner.cleaning"), "info")
    self:startUpdateLoop()
    PlaySoundFrontend(-1, "Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true)
    SendReactMessage("cleaner_sound", { action = "start" })
end


function CleanerRobot:stopCleaning(robotId)
    local robot = self.robots[robotId]
    if not robot then
        return
    end
    if robot.state == "cleaning" then
        robot.state = "returning"
        robot.cleaningStartTime = nil
        Notification(i18n.t("cleaner.returning"), "info")
        Debug("CleanerRobot: Returning to dock", robotId)
        self:startUpdateLoop()
    end
end

function CleanerRobot:returnToDock(robotId)
    local robot = self.robots[robotId]
    if not robot then
        return
    end
    robot.state = "returning"
    Notification(i18n.t("cleaner.returning"), "info")
    self:startUpdateLoop()
    Debug("CleanerRobot: Manually returning to dock", robotId)
end

function CleanerRobot:get(robotId)
    return self.robots[robotId]
end

function CleanerRobot:getAll()
    return self.robots
end


function CleanerRobot:getState(robotId)
    local robot = self.robots[robotId]
    if not robot then
        return "unknown"
    end
    return robot.state
end

function CleanerRobot:isActive(robotId)
    local robot = self.robots[robotId]
    if not robot then
        return false
    end
    return "cleaning" == robot.state
end

function CleanerRobot:hasRobots()
    return nil ~= next(self.robots)
end

function CleanerRobot:hasActiveCleaningRobot()
    for robotId, robot in pairs(self.robots) do
        if robot.state == "cleaning" or robot.state == "returning" then
            return true, robotId
        end
    end
    return false, nil
end


function CleanerRobot:reinitializeAtPosition(robotId, newCoords, newRotation)
    local robot = self.robots[robotId]
    if not robot then
        return
    end
    if robot.state ~= "docked" then
        Debug("CleanerRobot: Cannot reinitialize - robot not docked")
        return
    end
    local modelInfo = self.cleanerModels[robot.robotModel]
    if not modelInfo then
        return
    end
    if DoesEntityExist(robot.dockHandle) then
        DeleteEntity(robot.dockHandle)
    end
    local dockModelHash = joaat(modelInfo.dockerModel)
    lib.requestModel(dockModelHash, Config.DefaultRequestModelTimeout or 5000)
    local newDockHandle = CreateObject(dockModelHash, newCoords.x, newCoords.y, newCoords.z, false, false, false)
    if not DoesEntityExist(newDockHandle) then
        Debug("CleanerRobot: Failed to respawn dock")
        SetModelAsNoLongerNeeded(dockModelHash)
        return
    end
    SetEntityRotation(newDockHandle, newRotation.x, newRotation.y, newRotation.z, 0, false)
    FreezeEntityPosition(newDockHandle, true)
    SetEntityCompletelyDisableCollision(newDockHandle, true, false)
    SetEntityInvincible(newDockHandle, true)
    SetModelAsNoLongerNeeded(dockModelHash)


    local dockMin, dockMax = GetModelDimensions(dockModelHash)
    local dockHeight = dockMax.z - dockMin.z
    local newBaseZ = newCoords.z + dockHeight + 0.02

    if DoesEntityExist(robot.robotHandle) then
        SetEntityCoords(robot.robotHandle, newCoords.x, newCoords.y, newBaseZ, false, false, false, false)
        SetEntityRotation(robot.robotHandle, 0.0, 0.0, newRotation.z, 0, false)
    end

    local robotModelHash = joaat(robot.robotModel)
    local robotMin, robotMax = GetModelDimensions(robotModelHash)
    local robotHeightOffset = (robotMax.z - robotMin.z) * 0.5

    robot.dockHandle = newDockHandle
    robot.dockCoords = vec3(newCoords.x, newCoords.y, newCoords.z + robotHeightOffset)
    robot.dockRotation = newRotation
    robot.baseZ = newCoords.z
    robot.lastKnownCoords = vec3(newCoords.x, newCoords.y, newCoords.z)
    robot.currentHeading = newRotation.z
    robot.targetHeading = newRotation.z
    Debug("CleanerRobot: Reinitialized at new position", robotId)
end

function CleanerRobot:getCleanerModels()
    return self.cleanerModels
end


function CleanerRobot:cleanAll()
    for robotId, robot in pairs(self.robots) do
        if robot.isOwner then
            if robot.state == "cleaning" or robot.state == "returning" then
                TriggerServerEvent("housing:cleaner:stopped", robot.house, robotId)
            end
        end
        if robot.networkedRobotHandle then
            if DoesEntityExist(robot.networkedRobotHandle) then
                DeleteEntity(robot.networkedRobotHandle)
            end
        end
        if DoesEntityExist(robot.dockHandle) then
            DeleteEntity(robot.dockHandle)
        end
    end
    SendReactMessage("cleaner_sound", { action = "stop" })
    self.activeThread = false
    self.interactionThread = false
    self.robots = {}
end


function CleanerRobot:scanAndSpawnFromDecorations(houseId)
    if not decorate or not decorate.objects then
        return
    end
    for _, obj in pairs(decorate.objects) do
        if obj.spawned and obj.coords and obj.handle then
            if self:isCleanerModel(obj.modelName) then
                self:spawnForDecoration(obj, houseId)
            end
        end
    end
end


function CleanerRobot:startInteractionLoop()
    if self.interactionThread then
        return
    end
    if Config.UseTarget then
        return
    end
    self.interactionThread = true
    CreateThread(function()
        while self.interactionThread and CurrentHouse do
            local playerCoords = GetEntityCoords(cache.ped)
            local nearest = nil
            local nearestDist = 2.5
            for robotId, robot in pairs(self.robots) do
                if DoesEntityExist(robot.dockHandle) then
                    local dockCoords = GetEntityCoords(robot.dockHandle)
                    local dist = #(playerCoords - dockCoords)
                    if nearestDist > dist then
                        nearestDist = dist
                        nearest = { id = robotId, data = robot }
                    end
                end
            end
            if nearest then
                if CurrentHouseData and CurrentHouseData.haskey then
                    local dockPos = GetEntityCoords(nearest.data.dockHandle)
                    local state = nearest.data.state
                    local text = ""
                    if state == "docked" or state == "idle" then
                        text = i18n.t("cleaner.press_start")
                    elseif state == "cleaning" then
                        text = i18n.t("cleaner.press_stop")
                    elseif state == "returning" then
                        text = i18n.t("cleaner.returning")
                    end
                    DrawText3D(dockPos.x, dockPos.y, dockPos.z + 0.3, text, "cleaner_robot", "E")
                    if IsControlJustPressed(0, 38) then
                        if state == "docked" or state == "idle" then
                            self:startCleaning(nearest.id)
                        elseif state == "cleaning" then
                            self:stopCleaning(nearest.id)
                        end
                    end
                end
            end
            Wait(0)
        end
        self.interactionThread = false
    end)
end

function CleanerRobot:stopInteractionLoop()
    self.interactionThread = false
end


-- Global instance
_G.cleanerRobot = CleanerRobot:new()

CreateThread(function()
    Wait(1000)
    cleanerRobot:buildModelList()
end)

-- Decoration tracking for spawn/despawn
local trackedDecorations = {}

CreateThread(function()
    while true do
        Wait(500)
        if not CurrentHouse then
            trackedDecorations = {}
        elseif decorate and decorate.objects then
            for _, obj in pairs(decorate.objects) do
                if obj.id and obj.spawned and obj.coords and obj.handle then
                    if cleanerRobot:isCleanerModel(obj.modelName) then
                        local existing = cleanerRobot:get(obj.id)
                        if not existing then
                            local objCoords = vec3(obj.coords.x, obj.coords.y, obj.coords.z)
                            local objRotation
                            if obj.rotation then
                                objRotation = vec3(obj.rotation.x, obj.rotation.y, obj.rotation.z)
                            end
                            if not objRotation then
                                objRotation = vec3(0, 0, 0)
                            end
                            trackedDecorations[obj.id] = { coords = objCoords, rotation = objRotation }
                            cleanerRobot:spawnForDecoration(obj, CurrentHouse)


                        else
                            local tracked = trackedDecorations[obj.id]
                            if tracked then
                                local objCoords = vec3(obj.coords.x, obj.coords.y, obj.coords.z)
                                local objRotation
                                if obj.rotation then
                                    objRotation = vec3(obj.rotation.x, obj.rotation.y, obj.rotation.z)
                                end
                                if not objRotation then
                                    objRotation = vec3(0, 0, 0)
                                end
                                local coordsMoved = #(objCoords - tracked.coords) > 0.1
                                local rotationChanged = math.abs(objRotation.z - tracked.rotation.z) > 1.0
                                if coordsMoved or rotationChanged then
                                    existing.robotHandle = obj.handle
                                    cleanerRobot:reinitializeAtPosition(obj.id, objCoords, objRotation)
                                    trackedDecorations[obj.id] = { coords = objCoords, rotation = objRotation }
                                end
                            end
                        end
                    end
                end
            end


            -- Remove robots for deleted decorations
            for trackedId, _ in pairs(trackedDecorations) do
                local stillExists = false
                for _, obj in pairs(decorate.objects) do
                    if obj.id == trackedId then
                        stillExists = true
                        break
                    end
                end
                if not stillExists then
                    trackedDecorations[trackedId] = nil
                    cleanerRobot:despawn(trackedId)
                end
            end
        end
    end
end)


-- Target system integration
if Config.UseTarget then
    CreateThread(function()
        Wait(2000)
        local models = cleanerRobot:getCleanerModels()
        while nil == next(models) do
            Wait(500)
            models = cleanerRobot:getCleanerModels()
        end

        local robotModelHashes = {}
        local dockModelHashes = {}
        for modelName, data in pairs(models) do
            table.insert(robotModelHashes, joaat(modelName))
            if data.dockerModel then
                local dockHash = joaat(data.dockerModel)
                local alreadyAdded = false
                for _, existing in ipairs(dockModelHashes) do
                    if existing == dockHash then
                        alreadyAdded = true
                        break
                    end
                end
                if not alreadyAdded then
                    table.insert(dockModelHashes, dockHash)
                end
            end
        end
        if #robotModelHashes == 0 then
            return
        end


        -- Helper: can interact check (house key required)
        local function canInteractBase(entity, checkFn)
            if not CurrentHouse then return false end
            if not CurrentHouseData or not CurrentHouseData.haskey then return false end
            for robotId, robot in pairs(cleanerRobot:getAll()) do
                if checkFn(robot) == entity then
                    return true
                end
            end
            return false
        end

        -- ox_target options for robot models
        local robotOptions = {
            {
                icon = "fas fa-play",
                label = i18n.t("cleaner.start"),
                onSelect = function(data)
                    for robotId, robot in pairs(cleanerRobot:getAll()) do
                        if robot.robotHandle == data.entity then
                            if robot.state == "docked" or robot.state == "idle" then
                                cleanerRobot:startCleaning(robotId)
                            end
                            break
                        end
                    end
                end,
                canInteract = function(entity)
                    if not CurrentHouse then return false end
                    if not CurrentHouseData or not CurrentHouseData.haskey then return false end
                    for _, robot in pairs(cleanerRobot:getAll()) do
                        if robot.robotHandle == entity then
                            return "docked" == robot.state
                        end
                    end
                    return false
                end,
                distance = 2.5,
            },


            {
                icon = "fas fa-stop",
                label = i18n.t("cleaner.stop"),
                onSelect = function(data)
                    for robotId, robot in pairs(cleanerRobot:getAll()) do
                        if robot.robotHandle == data.entity then
                            if robot.state == "cleaning" then
                                cleanerRobot:stopCleaning(robotId)
                            end
                            break
                        end
                    end
                end,
                canInteract = function(entity)
                    if not CurrentHouse then return false end
                    if not CurrentHouseData or not CurrentHouseData.haskey then return false end
                    for _, robot in pairs(cleanerRobot:getAll()) do
                        if robot.robotHandle == entity then
                            return "cleaning" == robot.state
                        end
                    end
                    return false
                end,
                distance = 2.5,
            },
        }


        -- ox_target options for dock models
        local dockOptions = {
            {
                icon = "fas fa-home",
                label = i18n.t("cleaner.return_dock"),
                onSelect = function(data)
                    for robotId, robot in pairs(cleanerRobot:getAll()) do
                        if robot.dockHandle == data.entity then
                            cleanerRobot:returnToDock(robotId)
                            break
                        end
                    end
                end,
                canInteract = function(entity)
                    if not CurrentHouse then return false end
                    if not CurrentHouseData or not CurrentHouseData.haskey then return false end
                    for _, robot in pairs(cleanerRobot:getAll()) do
                        if robot.dockHandle == entity then
                            return "cleaning" == robot.state
                        end
                    end
                    return false
                end,
                distance = 2.5,
            },
            {
                icon = "fas fa-play",
                label = i18n.t("cleaner.start"),
                onSelect = function(data)
                    for robotId, robot in pairs(cleanerRobot:getAll()) do
                        if robot.dockHandle == data.entity then
                            if robot.state == "docked" or robot.state == "idle" then
                                cleanerRobot:startCleaning(robotId)
                            end
                            break
                        end
                    end
                end,


                canInteract = function(entity)
                    if not CurrentHouse then return false end
                    if not CurrentHouseData or not CurrentHouseData.haskey then return false end
                    for _, robot in pairs(cleanerRobot:getAll()) do
                        if robot.dockHandle == entity then
                            return "docked" == robot.state
                        end
                    end
                    return false
                end,
                distance = 2.5,
            },
            {
                icon = "fas fa-stop",
                label = i18n.t("cleaner.stop"),
                onSelect = function(data)
                    for robotId, robot in pairs(cleanerRobot:getAll()) do
                        if robot.dockHandle == data.entity then
                            if robot.state == "cleaning" then
                                cleanerRobot:stopCleaning(robotId)
                            end
                            break
                        end
                    end
                end,
                canInteract = function(entity)
                    if not CurrentHouse then return false end
                    if not CurrentHouseData or not CurrentHouseData.haskey then return false end
                    for _, robot in pairs(cleanerRobot:getAll()) do
                        if robot.dockHandle == entity then
                            return "cleaning" == robot.state
                        end
                    end
                    return false
                end,
                distance = 2.5,
            },
        }


        local targetResource = GetResourceState("ox_target")
        if "started" == targetResource then
            exports.ox_target:addModel(robotModelHashes, robotOptions)
            if #dockModelHashes > 0 then
                exports.ox_target:addModel(dockModelHashes, dockOptions)
            end
            Debug("CleanerRobot: Registered ox_target models (robot + dock)")
        else
            targetResource = GetResourceState("qb-target")
            if "started" == targetResource then
                -- qb-target robot options
                exports["qb-target"]:AddTargetModel(robotModelHashes, {
                    options = {
                        {
                            icon = "fas fa-play",
                            label = i18n.t("cleaner.start"),
                            action = function(entity)
                                for robotId, robot in pairs(cleanerRobot:getAll()) do
                                    if robot.robotHandle == entity then
                                        if robot.state == "docked" or robot.state == "idle" then
                                            cleanerRobot:startCleaning(robotId)
                                        end
                                        break
                                    end
                                end
                            end,
                            canInteract = function(entity)
                                if not CurrentHouse then return false end
                                if not CurrentHouseData or not CurrentHouseData.haskey then return false end
                                for _, robot in pairs(cleanerRobot:getAll()) do
                                    if robot.robotHandle == entity then
                                        return "docked" == robot.state
                                    end
                                end
                                return false
                            end,
                        },


                        {
                            icon = "fas fa-stop",
                            label = i18n.t("cleaner.stop"),
                            action = function(entity)
                                for robotId, robot in pairs(cleanerRobot:getAll()) do
                                    if robot.robotHandle == entity then
                                        if robot.state == "cleaning" then
                                            cleanerRobot:stopCleaning(robotId)
                                        end
                                        break
                                    end
                                end
                            end,
                            canInteract = function(entity)
                                if not CurrentHouse then return false end
                                if not CurrentHouseData or not CurrentHouseData.haskey then return false end
                                for _, robot in pairs(cleanerRobot:getAll()) do
                                    if robot.robotHandle == entity then
                                        return "cleaning" == robot.state
                                    end
                                end
                                return false
                            end,
                        },
                    },
                    distance = 2.5,
                })


                -- qb-target dock options
                if #dockModelHashes > 0 then
                    exports["qb-target"]:AddTargetModel(dockModelHashes, {
                        options = {
                            {
                                icon = "fas fa-home",
                                label = i18n.t("cleaner.return_dock"),
                                action = function(entity)
                                    for robotId, robot in pairs(cleanerRobot:getAll()) do
                                        if robot.dockHandle == entity then
                                            cleanerRobot:returnToDock(robotId)
                                            break
                                        end
                                    end
                                end,
                                canInteract = function(entity)
                                    if not CurrentHouse then return false end
                                    if not CurrentHouseData or not CurrentHouseData.haskey then return false end
                                    for _, robot in pairs(cleanerRobot:getAll()) do
                                        if robot.dockHandle == entity then
                                            return "cleaning" == robot.state
                                        end
                                    end
                                    return false
                                end,
                            },
                            {
                                icon = "fas fa-play",
                                label = i18n.t("cleaner.start"),
                                action = function(entity)
                                    for robotId, robot in pairs(cleanerRobot:getAll()) do
                                        if robot.dockHandle == entity then
                                            if robot.state == "docked" or robot.state == "idle" then
                                                cleanerRobot:startCleaning(robotId)
                                            end
                                            break
                                        end
                                    end
                                end,


                                canInteract = function(entity)
                                    if not CurrentHouse then return false end
                                    if not CurrentHouseData or not CurrentHouseData.haskey then return false end
                                    for _, robot in pairs(cleanerRobot:getAll()) do
                                        if robot.dockHandle == entity then
                                            return "docked" == robot.state
                                        end
                                    end
                                    return false
                                end,
                            },
                            {
                                icon = "fas fa-stop",
                                label = i18n.t("cleaner.stop"),
                                action = function(entity)
                                    for robotId, robot in pairs(cleanerRobot:getAll()) do
                                        if robot.dockHandle == entity then
                                            if robot.state == "cleaning" then
                                                cleanerRobot:stopCleaning(robotId)
                                            end
                                            break
                                        end
                                    end
                                end,
                                canInteract = function(entity)
                                    if not CurrentHouse then return false end
                                    if not CurrentHouseData or not CurrentHouseData.haskey then return false end
                                    for _, robot in pairs(cleanerRobot:getAll()) do
                                        if robot.dockHandle == entity then
                                            return "cleaning" == robot.state
                                        end
                                    end
                                    return false
                                end,
                            },
                        },
                        distance = 2.5,
                    })
                end
                Debug("CleanerRobot: Registered qb-target models (robot + dock)")
            end
        end
    end)
end


-- Event handlers
AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        cleanerRobot:cleanAll()
    end
end)

RegisterNetEvent("housing:cleaner:setDecorationAlpha", function(houseId, decorationId, alpha)
    if not decorate or not decorate.objects then
        return
    end
    for _, obj in pairs(decorate.objects) do
        if obj.id == decorationId then
            if obj.handle then
                if DoesEntityExist(obj.handle) then
                    SetEntityAlpha(obj.handle, alpha, false)
                    Debug("CleanerRobot: Set decoration alpha", decorationId, alpha)
                end
            end
            break
        end
    end
    local robot = cleanerRobot:get(decorationId)
    if robot then
        if robot.decorationHandle then
            if DoesEntityExist(robot.decorationHandle) then
                SetEntityAlpha(robot.decorationHandle, alpha, false)
            end
        end
    end
end)


RegisterNetEvent("housing:cleaner:deleteNetworkedRobot", function(houseId, decorationId)
    local robot = cleanerRobot:get(decorationId)
    if not robot then
        return
    end
    if robot.networkedRobotHandle then
        if DoesEntityExist(robot.networkedRobotHandle) then
            DeleteEntity(robot.networkedRobotHandle)
            robot.networkedRobotHandle = nil
            Debug("CleanerRobot: Deleted networked robot by server request", decorationId)
        end
    end
    if robot.decorationHandle then
        if DoesEntityExist(robot.decorationHandle) then
            robot.robotHandle = robot.decorationHandle
            SetEntityCoords(robot.robotHandle, robot.dockCoords.x, robot.dockCoords.y, robot.dockCoords.z, false, false, false, false)
            SetEntityHeading(robot.robotHandle, robot.dockRotation.z)
        end
    end
    robot.state = "docked"
    robot.isOwner = false
end)
