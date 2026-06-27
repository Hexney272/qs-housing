





if Config.Garage ~= 'vms_garagesv2' then
    return
end

function TriggerHouseUpdateGarage()
    return
end

local storeText = i18n.t('drawtext.store_vehicle')
local openText = i18n.t('drawtext.open_garage')
CreateThread(function()
    while true do
        Wait(0)
        local ped = cache.ped
        local pos = GetEntityCoords(cache.ped)
        if ped and CurrentHouse ~= nil and (CurrentHouseData.haskey or not Config.Houses[CurrentHouse].locked) and Config.Houses and Config.Houses[CurrentHouse] and Config.Houses[CurrentHouse].garage and Config.Houses[CurrentHouse].garage.x then
            local dist = #(pos - vector3(Config.Houses[CurrentHouse].garage.x, Config.Houses[CurrentHouse].garage.y, Config.Houses[CurrentHouse].garage.z))
            if dist < 5.0 then
                DrawMarker(20, Config.Houses[CurrentHouse].garage.x, Config.Houses[CurrentHouse].garage.y, Config.Houses[CurrentHouse].garage.z + 0.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 120, 10, 20, 155, false, false, false, 1, false, false, false)
                if dist < 2.0 then
                    local vehicle = GetVehiclePedIsIn(cache.ped, false)
                    if Config.Houses[CurrentHouse].garage and Config.Houses[CurrentHouse].garage.x and Config.Houses[CurrentHouse].garage.y and Config.Houses[CurrentHouse].garage.z then
                        if vehicle and vehicle ~= 0 then
                            DrawText3Ds(Config.Houses[CurrentHouse].garage.x, Config.Houses[CurrentHouse].garage.y, Config.Houses[CurrentHouse].garage.z + 0.3, storeText, 'open_garage1', 'E')

                            if IsControlJustPressed(0, Keys['E']) or IsDisabledControlJustPressed(0, Keys['E']) then
                                exports['vms_garagesv2']:enterHouseGarage()
                            end
                        else
                            DrawText3Ds(Config.Houses[CurrentHouse].garage.x, Config.Houses[CurrentHouse].garage.y, Config.Houses[CurrentHouse].garage.z + 0.3, openText, 'open_garage2', 'E')

                            if IsControlJustPressed(0, Keys['E']) or IsDisabledControlJustPressed(0, Keys['E']) then
                                exports['vms_garagesv2']:enterHouseGarage()
                            end
                        end
                    end
                end
            else
                Wait(1000)
            end
        end
    end
end)






