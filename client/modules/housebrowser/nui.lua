RegisterNUICallback("house_browser:set_waypoint", function(data, cb)
    if not data or not data.houseName then
        return cb(false)
    end

    housebrowser:setWaypoint(data.houseName)
    cb(true)
end)

RegisterNUICallback("house_browser:get_house_details", function(data, cb)
    if not data or not data.houseName then
        return cb(nil)
    end

    local houseConfig = Config.Houses[data.houseName]
    if not houseConfig then
        return cb(nil)
    end

    local details = {}
    details.name = data.houseName
    details.owner = houseConfig.owned and "Owner Info" or nil
    cb(details)
end)

RegisterNUICallback("house_browser:refresh", function(data, cb)
    housebrowser.houses = housebrowser:collectHouses()
    cb(housebrowser.houses)
end)
