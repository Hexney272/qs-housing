local function IsSmartphoneStarted()
    local state = GetResourceState("qs-smartphone")
    return state == "started"
end

local function ParseChargeCoords(chargeStr)
    if type(chargeStr) ~= "string" or chargeStr == "" or chargeStr == "null" then
        return nil
    end

    local ok, decoded = pcall(json.decode, chargeStr)
    if not ok or type(decoded) ~= "table" then
        return nil
    end

    local x = tonumber(decoded.x)
    local y = tonumber(decoded.y)
    local z = tonumber(decoded.z)

    if x and y and z then
        return vector3(x, y, z)
    end

    return nil
end

function HousingBatteryBridge_SyncFromDatabase()
    if not IsSmartphoneStarted() then
        return
    end

    local rows = MySQL.query.await(
        "SELECT house, charge FROM player_houses WHERE charge IS NOT NULL AND charge <> ? AND charge <> ?",
        { "", "null" }
    )

    if not rows then
        return
    end

    for i = 1, #rows do
        local row = rows[i]
        local house = row.house
        local coords = ParseChargeCoords(row.charge)

        if type(house) == "string" and house ~= "" and coords then
            exports["qs-smartphone"]:BatteryRegisterHousingCharger(house, coords, nil)
        end
    end
end

function HousingBatteryBridge_Register(house, coords)
    if not IsSmartphoneStarted() then
        return
    end

    if type(house) ~= "string" or house == "" then
        return
    end

    exports["qs-smartphone"]:BatteryRegisterHousingCharger(house, coords, nil)
end

function HousingBatteryBridge_Unregister(house)
    if not IsSmartphoneStarted() then
        return
    end

    if type(house) ~= "string" or house == "" then
        return
    end

    exports["qs-smartphone"]:BatteryUnregisterHousingCharger(house)
end

AddEventHandler("onResourceStart", function(resourceName)
    if resourceName == "qs-smartphone" then
        HousingBatteryBridge_SyncFromDatabase()
    else
        if resourceName == GetCurrentResourceName() then
            if IsSmartphoneStarted() then
                HousingBatteryBridge_SyncFromDatabase()
            end
        end
    end
end)
