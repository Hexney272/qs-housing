RegisterCommand("resetentrycoords", function(source, args)
    if source ~= 0 then
        return Error("This command can only be executed from the server console.")
    end

    local affectedRows = MySQL.Sync.execute([[
        UPDATE houselocations
        SET coords = JSON_REMOVE(coords, '$.exit')
        WHERE JSON_EXTRACT(coords, '$.exit') IS NOT NULL
    ]])

    if affectedRows and affectedRows > 0 then
        LoopError("^2[QS-HOUSING]^7 Successfully removed exit coords from " .. affectedRows .. " houses. You need to restart the script!")
    else
        print("^3[QS-HOUSING]^7 No houses found with exit coords to remove")
    end

    print("^2[QS-HOUSING]^7 Process completed!")
end, false)
