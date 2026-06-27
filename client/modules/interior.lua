function TeleportToInterior(x, y, z, heading)
    CreateThread(function()
        SetEntityCoords(cache.ped, x, y, z, 0, 0, 0, false)
        SetEntityHeading(cache.ped, heading)
        Wait(100)
        DoScreenFadeIn(1000)
    end)
end

function CreateShell(spawnCoords, exitCoords, modelHash)
    local objects = {}
    local data = { exit = exitCoords }

    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end

    lib.requestModel(modelHash, Config.DefaultRequestModelTimeout)
    local shellObj = CreateObject(modelHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, false, false, false)

    if spawnCoords.h then
        SetEntityHeading(shellObj, spawnCoords.h)
    end

    SetModelAsNoLongerNeeded(modelHash)
    FreezeEntityPosition(shellObj, true)

    objects[#objects + 1] = shellObj

    Debug("CreateShell.exitCoords", exitCoords, "spawn coords", spawnCoords)

    TeleportToInterior(exitCoords.x, exitCoords.y, exitCoords.z, exitCoords.h)

    return { objects, data }
end

function DespawnInterior(objects, callback)
    CreateThread(function()
        for _, obj in pairs(objects) do
            if obj and DoesEntityExist(obj) then
                DeleteEntity(obj)
            end
        end
        callback()
    end)
end
