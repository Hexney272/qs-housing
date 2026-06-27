SpawnedBoards = {}

local useDrawText = Config.UseDrawTextOnBoard

local function drawBoardInfo(boardData, offsetCoords, heading)
    if useDrawText then
        DrawTextBoard(
            offsetCoords.x,
            offsetCoords.y - 0.1,
            offsetCoords.z + 1.36,
            i18n.t("drawtext.board_agent") .. boardData.name
        )
        DrawTextBoard(
            offsetCoords.x,
            offsetCoords.y - 0.1,
            offsetCoords.z + 1.14,
            i18n.t("drawtext.board_phone") .. (boardData.phone or "Unknown")
        )
        DrawTextBoard(
            offsetCoords.x,
            offsetCoords.y - 0.1,
            offsetCoords.z + 0.92,
            i18n.t("drawtext.board_money") .. boardData.price
        )
        return
    end

    -- Agent name text
    AddTextEntry("HOUSE_AGENT", i18n.t("drawtext.board_agent"))
    local brokenName = Utils.BreakString(boardData.name, 15)

    FloatyDraw(vec3(offsetCoords.x, offsetCoords.y, offsetCoords.z + 1), heading, function(screenPos)
        BeginTextCommandDisplayText("HOUSE_AGENT")
        SetTextFont(1)
        SetTextCentre(false)
        SetTextOutline()
        SetTextJustification(0)
        SetTextScale(Config.SignTextScale, Config.SignTextScale)
        AddTextComponentSubstringPlayerName(brokenName)
        SetTextColour(100, 100, 255, 255)
        EndTextCommandDisplayText(0.46, 0.62)
    end)

    -- Phone number text
    if boardData.phone then
        AddTextEntry("HOUSE_PHONE", i18n.t("drawtext.board_phone"))

        FloatyDraw(vec3(offsetCoords.x, offsetCoords.y, offsetCoords.z + 0.7), heading, function(screenPos)
            BeginTextCommandDisplayText("HOUSE_PHONE")
            SetTextFont(1)
            SetTextCentre(false)
            SetTextOutline()
            SetTextJustification(0)
            SetTextScale(Config.SignTextScale, Config.SignTextScale)
            AddTextComponentSubstringPlayerName(boardData.phone or "Unknown")
            SetTextColour(255, 255, 255, 255)
            EndTextCommandDisplayText(0.46, 0.52)
        end)
    end

    -- Price text
    local priceZOffset
    if boardData.phone then
        priceZOffset = 0.4
    else
        priceZOffset = 0.7
    end

    AddTextEntry("HOUSE_PRICE", i18n.t("drawtext.board_money"))

    FloatyDraw(vec3(offsetCoords.x, offsetCoords.y, offsetCoords.z + priceZOffset), heading, function(screenPos)
        BeginTextCommandDisplayText("HOUSE_PRICE")
        SetTextFont(1)
        SetTextCentre(false)
        SetTextOutline()
        SetTextJustification(0)
        SetTextScale(Config.SignTextScale, Config.SignTextScale)
        AddTextComponentSubstringPlayerName(boardData.price)
        SetTextColour(0, 255, 0, 255)
        EndTextCommandDisplayText(0.46, 0.42)
    end)
end

local function removeBoardSpawnedObject(board)
    if not board.spawned then
        Error("removeBoardSpawnedObject :: Object is not spawned", "data", board)
        return false
    end

    DeleteObject(board.handle)
    board.spawned = false
    Debug("removeBoardSpawnedObject", "object", board.handle)
end

-- Thread: spawn/despawn boards based on player distance
CreateThread(function()
    while true do
        local playerCoords = GetEntityCoords(cache.ped)

        for _, board in pairs(SpawnedBoards) do
            local boardPos = vec3(board.coords.x, board.coords.y, board.coords.z)
            local distance = #(playerCoords - boardPos)

            if distance <= Config.BoardSpawnDistance then
                if not board.spawned then
                    local modelHash = joaat(board.object)
                    lib.requestModel(modelHash, Config.DefaultRequestModelTimeout)

                    local obj = CreateObject(modelHash, board.coords.x, board.coords.y, board.coords.z, false, true, false)
                    SetEntityHeading(obj, board.coords.w)
                    PlaceObjectOnGroundProperly(obj)
                    FreezeEntityPosition(obj, true)
                    SetEntityCollision(obj, true, true)
                    SetModelAsNoLongerNeeded(modelHash)

                    if obj then
                        board.handle = obj
                        board.spawned = true
                    end
                end
            else
                if distance > Config.BoardSpawnDistance then
                    if board.spawned then
                        removeBoardSpawnedObject(board)
                    end
                end
            end
        end

        Wait(1250)
    end
end)

-- Thread: draw board text when player is close
CreateThread(function()
    while true do
        local sleepTime = 1250

        for _, board in pairs(SpawnedBoards) do
            local coords = board.coords
            local heading = board.coords.w
            local playerCoords = GetEntityCoords(cache.ped)
            local boardPos = vec3(coords.x, coords.y, coords.z)
            local distance = #(playerCoords - boardPos)

            if distance < 30.0 then
                sleepTime = 0
                local offsetCoords = GetOffsetFromEntityInWorldCoords(board.handle, -0.2, 0.0, 0.0)
                drawBoardInfo(board, offsetCoords, heading)
            end
        end

        Wait(sleepTime)
    end
end)

function InitHouseBoards()
    if not Config.EnableBoard then
        return
    end

    -- Clean up existing boards
    if #SpawnedBoards > 0 then
        local oldBoards = table.deepclone(SpawnedBoards)
        SpawnedBoards = {}

        for _, board in pairs(oldBoards) do
            DeleteEntity(board.handle)
        end
    end

    -- Populate boards from config
    for _, house in pairs(Config.Houses) do
        if house.apartmentNumber then
            if "apt-0" ~= house.apartmentNumber then
                goto continue
            end
        end

        if not house.owned then
            if house.board then
                if house.board.coords then
                    house.board.price = house.price
                    table.insert(SpawnedBoards, house.board)
                end
            end
        end

        ::continue::
    end

    Debug("Boards initialized", SpawnedBoards)
end

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end

    for _, board in pairs(SpawnedBoards) do
        DeleteEntity(board.handle)
    end

    SpawnedBoards = {}
end)
