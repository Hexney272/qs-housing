





if not Config.Debug then return end

Debug('`gizmo` debug command initialized')
RegisterCommand('gizmo', function(source, args, raw)
    decorate:open()
end)

---@param shellCoords vector4
---@param playerPos vector3
---@return vector3
local function GetOffsetFromShell(shellCoords, playerPos)
    local dx = playerPos.x - shellCoords.x
    local dy = playerPos.y - shellCoords.y
    local dz = playerPos.z - shellCoords.z
    local heading = shellCoords.w or 0.0
    local hRad = math.rad(heading + 90)

    local offsetX = dx * math.cos(hRad) + dy * math.sin(hRad)
    local offsetY = -dx * math.sin(hRad) + dy * math.cos(hRad)
    local offsetZ = dz

    return vec3(offsetX, offsetY, offsetZ)
end

---@param shellHeading number
---@param playerHeading number
---@return number
local function GetRelativeHeading(shellHeading, playerHeading)
    local relativeHeading = playerHeading - shellHeading

    while relativeHeading > 180.0 do
        relativeHeading = relativeHeading - 360.0
    end
    while relativeHeading < -180.0 do
        relativeHeading = relativeHeading + 360.0
    end

    return relativeHeading
end


RegisterCommand('take_offset', function(source, args, raw)
    if not CurrentHouse then
        lib.notify({
            title = 'Error',
            description = 'You must be in a house to use this command',
            type = 'error'
        })
        return
    end

    local houseData = Config.Houses[CurrentHouse]
    if not houseData then
        Notification('House data not found')
        return
    end

    -- Show type selection menu
    local input = lib.inputDialog('Take Offset', {
        {
            type = 'select',
            label = 'Type',
            description = 'Select offset type',
            options = {
                { value = 'shell', label = 'Shell' },
                { value = 'ipl',   label = 'IPL' }
            },
            required = true
        },
        {
            type = 'input',
            label = 'Object Type',
            description = 'Type of object (e.g., shower, sink, cooking)',
            default = 'shower',
            required = true
        }
    })

    if not input or not input[1] or not input[2] then
        return
    end

    local offsetType = input[1]
    local objectType = input[2]

    local playerPos = GetEntityCoords(cache.ped)
    local playerHeading = GetEntityHeading(cache.ped)

    if offsetType == 'shell' then
        local tier = houseData.tier
        local shellModel = Config.Shells[tier].model
        if not tier then
            Notification('This house does not have a tier (not a shell house)')
            return
        end

        local shellData = Config.Shells[tier]
        if not shellData then
            Notification('Shell data not found for tier ' .. tier)
            return
        end

        local shellCoords = houseData.coords and houseData.coords.shellCoords or nil
        if not shellCoords then
            Notification('Shell coordinates not found for this house')
            return
        end

        local shellPos = vec4(shellCoords.x, shellCoords.y, shellCoords.z, shellCoords.h or 0.0)
        local ptfxOffset = GetOffsetFromShell(shellPos, playerPos)
        local calculatedHeading = GetRelativeHeading(shellPos.w, playerHeading)
        local animationOffset = vec4(ptfxOffset.x, ptfxOffset.y, ptfxOffset.z, calculatedHeading)

        if not shellData[objectType] then
            shellData[objectType] = {}
        end
        shellData[objectType].ptfxOffset = ptfxOffset
        shellData[objectType].animationOffset = animationOffset

        Debug('^2' .. objectType .. ' offset calculated and updated for shell tier ' .. shellModel .. '^0')
        Debug('^3ptfxOffset: vec3(' .. string.format('%.3f', ptfxOffset.x) .. ', ' .. string.format('%.3f', ptfxOffset.y) .. ', ' .. string.format('%.3f', ptfxOffset.z) .. ')^0')
        Debug('^3animationOffset: vec4(' .. string.format('%.3f', animationOffset.x) .. ', ' .. string.format('%.3f', animationOffset.y) .. ', ' .. string.format('%.3f', animationOffset.z) .. ', ' .. string.format('%.3f', animationOffset.w) .. ')^0')
    elseif offsetType == 'ipl' then
        if not houseData.ipl or not houseData.ipl.houseName then
            Notification('This house does not have IPL data')
            return
        end

        local iplIndex = houseData.ipl.houseName
        local iplData = Config.IplData[iplIndex]
        if not iplData then
            Notification('IPL data not found for index ' .. iplIndex)
            return
        end

        local iplCoords = iplData.iplCoords
        if not iplCoords then
            Notification('IPL coordinates not found')
            return
        end

        local iplHeading = iplCoords.h or 0.0
        local iplPos = vec4(iplCoords.x, iplCoords.y, iplCoords.z, iplHeading)
        local ptfxOffset = GetOffsetFromShell(iplPos, playerPos)
        local calculatedHeading = GetRelativeHeading(iplHeading, playerHeading)
        local animationOffset = vec4(ptfxOffset.x, ptfxOffset.y, ptfxOffset.z, calculatedHeading)

        if not iplData[objectType] then
            iplData[objectType] = {}
        end
        iplData[objectType].ptfxOffset = ptfxOffset
        iplData[objectType].animationOffset = animationOffset

        print('^2' .. objectType .. ' offset calculated and updated for IPL index ' .. iplIndex .. '^0')
        print('^3ptfxOffset: vec3(' .. string.format('%.3f', ptfxOffset.x) .. ', ' .. string.format('%.3f', ptfxOffset.y) .. ', ' .. string.format('%.3f', ptfxOffset.z) .. ')^0')
        print('^3animationOffset: vec4(' .. string.format('%.3f', animationOffset.x) .. ', ' .. string.format('%.3f', animationOffset.y) .. ', ' .. string.format('%.3f', animationOffset.z) .. ', ' .. string.format('%.3f', animationOffset.w) .. ')^0')
    end
end)

RegisterCommand('update_offset', function(source, args, raw)
    if not CurrentHouse then
        Notification('You must be in a house to use this command')
        return
    end

    local houseData = Config.Houses[CurrentHouse]
    if not houseData then
        Notification('House data not found')
        return
    end

    local input = lib.inputDialog('Update Offset', {
        {
            type = 'select',
            label = 'Type',
            description = 'Select offset type',
            options = {
                { value = 'shell', label = 'Shell' },
                { value = 'ipl',   label = 'IPL' }
            },
            required = true
        },
        {
            type = 'input',
            label = 'Object Type',
            description = 'Type of object (e.g., shower, sink, cooking)',
            default = 'shower',
            required = true
        },
        {
            type = 'select',
            label = 'Offset Type',
            description = 'Select which offset to update',
            options = {
                { value = 'ptfxOffset',      label = 'Particle FX Offset' },
                { value = 'animationOffset', label = 'Animation Offset' }
            },
            required = true
        },
        {
            type = 'input',
            label = 'X Offset',
            description = 'X coordinate offset',
            default = '0.0',
            required = true
        },
        {
            type = 'input',
            label = 'Y Offset',
            description = 'Y coordinate offset',
            default = '0.0',
            required = true
        },
        {
            type = 'input',
            label = 'Z Offset',
            description = 'Z coordinate offset',
            default = '0.0',
            required = true
        },
        {
            type = 'input',
            label = 'W/Heading Offset (Optional)',
            description = 'W/Heading offset (only for animationOffset)',
            default = '0.0',
            required = false
        }
    })

    if not input or not input[1] or not input[2] or not input[3] then
        return
    end

    local offsetType = input[1]
    local objectType = input[2]
    local offsetToUpdate = input[3]
    local x = tonumber(input[4]) or 0.0
    local y = tonumber(input[5]) or 0.0
    local z = tonumber(input[6]) or 0.0
    local w = tonumber(input[7]) or 0.0

    if offsetType == 'shell' then
        local tier = houseData.tier
        if not tier then
            Notification('This house does not have a tier (not a shell house)')
            return
        end

        local shellData = Config.Shells[tier]
        if not shellData then
            Notification('Shell data not found for tier ' .. tier)
            return
        end

        if not shellData[objectType] then
            shellData[objectType] = {}
        end

        if offsetToUpdate == 'ptfxOffset' then
            shellData[objectType].ptfxOffset = vec3(x, y, z)
            Debug('^2ptfxOffset updated: vec3(' .. string.format('%.3f', x) .. ', ' .. string.format('%.3f', y) .. ', ' .. string.format('%.3f', z) .. ')^0')
        elseif offsetToUpdate == 'animationOffset' then
            shellData[objectType].animationOffset = vec4(x, y, z, w)
            Debug('^2animationOffset updated: vec4(' .. string.format('%.3f', x) .. ', ' .. string.format('%.3f', y) .. ', ' .. string.format('%.3f', z) .. ', ' .. string.format('%.3f', w) .. ')^0')
        end
    elseif offsetType == 'ipl' then
        if not houseData.ipl or not houseData.ipl.houseName then
            Notification('This house does not have IPL data')
            return
        end

        local iplIndex = houseData.ipl.houseName
        local iplData = Config.IplData[iplIndex]
        if not iplData then
            Notification('IPL data not found for index ' .. iplIndex)
            return
        end

        if not iplData[objectType] then
            iplData[objectType] = {}
        end

        if offsetToUpdate == 'ptfxOffset' then
            iplData[objectType].ptfxOffset = vec3(x, y, z)
            Debug('^2ptfxOffset updated: vec3(' .. string.format('%.3f', x) .. ', ' .. string.format('%.3f', y) .. ', ' .. string.format('%.3f', z) .. ')^0')
        elseif offsetToUpdate == 'animationOffset' then
            iplData[objectType].animationOffset = vec4(x, y, z, w)
            Debug('^2animationOffset updated: vec4(' .. string.format('%.3f', x) .. ', ' .. string.format('%.3f', y) .. ', ' .. string.format('%.3f', z) .. ', ' .. string.format('%.3f', w) .. ')^0')
        end
    end
end)






