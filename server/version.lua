local currentVersion = GetResourceMetadata(GetCurrentResourceName(), "version", 0)
local resourceName = GetCurrentResourceName()

function string.split(str, delimiter)
    delimiter = delimiter or ":"
    local result = {}
    local pattern = string.format("([^%s]+)", delimiter)
    str:gsub(pattern, function(match)
        result[#result + 1] = match
    end)
    return result
end

local function versionToNumber(versionStr)
    local parts = versionStr:split(".")
    local combined = ""
    for i = 1, #parts do
        combined = combined .. parts[i]
    end
    return tonumber(combined)
end

local function compareVersions(latestVersion, descriptions)
    local currentNum = versionToNumber(currentVersion)
    local latestNum = versionToNumber(latestVersion)
    local diff = latestNum - currentNum
    return diff, descriptions
end

if currentVersion then
    local versionUrl = "https://raw.githubusercontent.com/quasar-scripts/version/main/" .. resourceName .. ".json"

    PerformHttpRequest(versionUrl, function(statusCode, responseBody, headers)
        if statusCode == 404 then
            print("^1API is not available. Unable to check the version.^0")
            return
        end

        if statusCode == 200 then
            local data = json.decode(responseBody)
            local latestVersion = data.version
            local descriptions = data.descriptions
            local diff, desc = compareVersions(latestVersion, descriptions)

            if diff == 0 then
                print("^2You are using the latest version of " .. resourceName .. "!^0")
            elseif diff > 0 then
                print("^3New version available for " .. resourceName .. "!^0")
                for _, description in pairs(desc) do
                    print("^3- " .. description .. "^0")
                end
                print("^3You have version " .. currentVersion .. ", upgrade to version " .. latestVersion .. "!^0")
            else
                print("^1You are using a newer version of " .. resourceName .. " than the one available on GitHub.^0")
            end
        end
    end, "GET", "", {}, {})
else
    print("Unable to obtain the version of " .. resourceName .. ". Make sure it is defined in your fxmanifest.lua.")
end
