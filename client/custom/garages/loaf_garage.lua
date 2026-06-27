





--[[
    Loaf Garage integration for qs-housing (client/custom/garages/loaf_garage.lua)

    Fixes:
    - Uses Loaf Garage exports (BrowseVehicles / StoreVehicle) instead of non-existent events:
        * 'loaf_garage:viewVehicles'  (does not exist)
        * 'loaf_garage:storeVehicle'  (store is handled via export/callback in loaf_garage)
    - Uses the built-in special garage id "property" that Loaf Garage creates automatically.
]]

if Config.Garage ~= 'loaf_garage' then
    return
end

function TriggerHouseUpdateGarage() end

function StoreVehicle(house)
    local vehicle = GetVehiclePedIsUsing(cache.ped)
    if not DoesEntityExist(vehicle) then
        return
    end

    if GetResourceState('loaf_garage') ~= 'started' then
        print('[qs-housing] loaf_garage is not started - cannot store vehicle')
        return
    end

    exports['loaf_garage']:StoreVehicle('property', vehicle)

    FreezeEntityPosition(cache.ped, false)
end

function OpenGarage(house)
    if GetResourceState('loaf_garage') ~= 'started' then
        print('[qs-housing] loaf_garage is not started - cannot open garage')
        return
    end

    local ped = cache.ped
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)

    exports['loaf_garage']:BrowseVehicles('property', vector4(coords.x, coords.y, coords.z, heading), false)

    FreezeEntityPosition(cache.ped, false)
end

CreateThread(function()
    while true do
        Wait(0)
        local ped = cache.ped
        local pos = GetEntityCoords(ped)

        if CurrentHouse ~= nil
            and (CurrentHouseData.haskey or not Config.Houses[CurrentHouse].locked)
            and Config.Houses
            and Config.Houses[CurrentHouse]
            and Config.Houses[CurrentHouse].garage
        then
            local g = Config.Houses[CurrentHouse].garage
            local dist = GetDistanceBetweenCoords(pos, g.x, g.y, g.z, true)

            if dist < 5.0 then
                DrawMarker(20, g.x, g.y, g.z + 0.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 120, 10, 20, 155, false, false, false, 1, false, false, false)

                if dist < 2.0 then
                    local vehicle = GetVehiclePedIsIn(ped, false)

                    if vehicle and vehicle ~= 0 then
                        DrawText3D(g.x, g.y, g.z + 0.3, 'Store Vehicle', 'open_garage_store', 'E')

                        if IsControlJustPressed(0, Keys['E']) or IsDisabledControlJustPressed(0, Keys['E']) then
                            if not StoreVehicle then
                                return print('Your client/custom/garages/*.lua is not correctly configured')
                            end
                            StoreVehicle(CurrentHouse)
                        end
                    else
                        DrawText3D(g.x, g.y, g.z + 0.3, 'Open Garage', 'open_garage_open', 'E')

                        if IsControlJustPressed(0, Keys['E']) or IsDisabledControlJustPressed(0, Keys['E']) then
                            if not OpenGarage then
                                return print('Your client/custom/garages/*.lua is not correctly configured')
                            end
                            OpenGarage(CurrentHouse)
                        end
                    end
                end
            else
                Wait(1000)
            end
        end
    end
end)






