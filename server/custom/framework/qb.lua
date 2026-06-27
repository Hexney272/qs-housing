





if Config.Framework ~= 'qb' then
    return
end

QBCore = exports['qb-core']:GetCoreObject()

userTable = 'players'          -- users
identifierColumn = 'citizenid' -- identifier
accountsColumn = 'money'

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
    local src = source
    Debug('Loaded player:', src)
    CreateQuests(src)
end)

CreateThread(function()
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        if v then
            Debug('Loaded player:', v)
            CreateQuests(v)
        end
    end
end)

function GetJobsData()
    local data = {}
    for k, v in pairs(QBCore.Shared.Jobs) do
        data[#data + 1] = {
            name = k,
            label = v.label,
            grades = table.map(v.grades, function(grade, index)
                return {
                    label = grade.name,
                    grade = tonumber(index)
                }
            end)
        }
    end
    return data
end

function RegisterServerCallback(name, cb)
    QBCore.Functions.CreateCallback(name, cb)
end

function RegisterUsableItem(name, cb)
    QBCore.Functions.CreateUseableItem(name, cb)
end

function GetPlayerFromId(source)
    return QBCore.Functions.GetPlayer(source)
end

function GetPlayerFromIdentifier(identifier)
    return QBCore.Functions.GetPlayerByCitizenId(identifier)
end

function AddItem(source, item, count, slot, info)
    local player = GetPlayerFromId(source)
    return player.Functions.AddItem(item, count, slot, info)
end

function AddMoneyToAccount(account, amount, isNotRent)
    local source = GetPlayerSourceFromIdentifier(account)
    if source then
        AddAccountMoney(source, 'bank', amount)
        if isNotRent then return end
        Notification(source, i18n.t('rent.payment', { price = amount }), 'error')
    else
        local result = MySQL.Sync.fetchAll('SELECT ' .. accountsColumn .. ' FROM ' .. userTable .. ' WHERE ' .. identifierColumn .. ' = ?', { account })
        if not result[1] then return print('Add Money Account : Not finded this account: ' .. account) end
        local accounts = json.decode(result[1].money)
        accounts.bank = accounts.bank + amount
        MySQL.Sync.execute('UPDATE ' .. userTable .. ' SET ' .. accountsColumn .. ' = ? WHERE ' .. identifierColumn .. ' = ?', {
            json.encode(accounts),
            account

        })
    end
end

function GetItems(player)
    if not player then return false end
    return player.PlayerData.items
end

function PlayerIsAdmin(source, doNotCheckJobs)
    local player = GetPlayerFromId(source)
    local job = player and player.PlayerData.job.name or nil

    if Config.AllowAdminsToCreateHouses then
        if QBCore.Functions.HasPermission(source, 'god') or
            IsPlayerAceAllowed(source, 'command') or
            QBCore.Functions.HasPermission(source, 'admin') then
            return true
        end
    end

    if not doNotCheckJobs then
        for _, v in pairs(Config.CreatorJobs) do
            if v.job == job then
                if not v.grade or v.grade == false then
                    return true
                end
                for _, g in pairs(v.grade) do
                    if player.PlayerData.job.grade.level == g then
                        return true
                    end
                end
            end
        end
    end

    return false
end

function GetJobName(source)
    local player = GetPlayerFromId(source)
    if not player then return '' end
    return player.PlayerData.job.name
end

function GetJobGrade(source)
    local player = GetPlayerFromId(source)
    if not player then return 0 end
    return player.PlayerData.job.grade?.level or 0
end

function GetCharacterName(source)
    local player = GetPlayerFromId(source).PlayerData.charinfo
    return player.firstname, player.lastname
end

function GetAccountMoney(source, account)
    local player = GetPlayerFromId(source)
    if account == 'money' then account = 'cash' end
    if account == 'black_money' then account = 'crypto' end
    return player.PlayerData.money[account]
end

function AddAccountMoney(source, account, amount)
    local player = GetPlayerFromId(source)
    if account == 'money' then account = 'cash' end
    player.Functions.AddMoney(account, amount)
end

function RemoveAccountMoney(source, account, amount)
    local player = GetPlayerFromId(source)
    if account == 'money' then account = 'cash' end
    player.Functions.RemoveMoney(account, amount)
end

function RemoveItem(source, item, count)
    local player = GetPlayerFromId(source)
    player.Functions.RemoveItem(item, count)
end

function GetIdentifier(source)
    local player = GetPlayerFromId(source)
    if not player then return false end
    return player.PlayerData.citizenid
end

function GetPlayerSourceFromIdentifier(identifier)
    local player = GetPlayerFromIdentifier(identifier)
    if not player then return false end
    return player.PlayerData.source
end

function GetPlayerSourceFromSource(source)
    local player = GetPlayerFromId(source)
    if not player then
        return false
    end
    return player.PlayerData.source
end

function GetCharacterFromIdentifier(identifier)
    local result = MySQL.Sync.fetchAll('SELECT charinfo FROM `players` WHERE citizenid = ?', { identifier })
    if not result[1] then
        return '', ''
    end
    result = result[1]
    result = json.decode(result.charinfo)
    return result?.firstname, result?.lastname
end

function RemoveMoneyFromAccount(account, amount, dontCheck, moneyAccount)
    moneyAccount = moneyAccount or 'bank'
    local source = GetPlayerSourceFromIdentifier(account)
    if source then
        RemoveAccountMoney(source, moneyAccount, amount)
        return true
    else
        local player = MySQL.Sync.fetchAll('SELECT ' .. accountsColumn .. ' FROM ' .. userTable .. ' WHERE ' .. identifierColumn .. ' = ?', { account })
        if player[1] then
            local accounts = json.decode(player[1].money)
            local accountKey = moneyAccount
            if accountKey == 'money' then accountKey = 'cash' end
            local balance = accounts[accountKey] or 0
            if balance >= amount or dontCheck then
                accounts[accountKey] = balance - amount
                MySQL.Sync.execute('UPDATE ' .. userTable .. ' SET ' .. accountsColumn .. ' = ? WHERE ' .. identifierColumn .. ' = ?', { json.encode(accounts), account })
                return true
            end
        end
    end
    return false
end

function GetPlayerSQLDataFromIdentifier(identifier)
    local result = MySQL.Sync.fetchAll('SELECT * FROM `players` WHERE citizenid = ? LIMIT 1', { identifier })
    if result[1] then
        return result[1]
    end
    return false
end

function UpdateInside(src, insideId, bool)
    local Player = GetPlayerFromId(src)
    Player.Functions.SetMetaData('currentHouseId', bool and insideId or nil)
end

---@param src number
---@return string|nil
function GetPlayerInsideHouse(src)
    local Player = GetPlayerFromId(src)
    if not Player or not Player.PlayerData or not Player.PlayerData.metadata then return nil end
    return Player.PlayerData.metadata.currentHouseId
end

RegisterServerCallback('qb-phone:server:MeosGetPlayerHouses', function(source, cb, input)
    if input then
        local search = escape_sqli(input)
        local searchData = {}
        local query = 'SELECT * FROM `' .. userTable .. '` WHERE `' .. identifierColumn .. '` = "' .. search .. '"'
        -- Split on " " and check each var individual
        local searchParameters = SplitStringToArray(search)
        -- Construct query dynamicly for individual parm check
        if #searchParameters > 1 then
            query = query .. ' OR `firstname` LIKE "%' .. searchParameters[1] .. '%" OR `lastname` LIKE "%' .. searchParameters[1] .. '%"'
            for i = 2, #searchParameters do
                query = query .. ' OR `firstname` LIKE "%' .. searchParameters[i] .. '%" OR `lastname` LIKE "%' .. searchParameters[i] .. '%"'
            end
        else
            query = query .. ' OR `firstname` LIKE "%' .. search .. '%" OR `lastname` LIKE "%' .. search .. '%"'
        end
        local result = MySQL.Sync.fetchAll(query)
        if result[1] then
            local houses = MySQL.Sync.fetchAll('SELECT * FROM player_houses WHERE citizenid = ?',
                { result[1][identifierColumn] })
            if houses[1] then
                for k, v in pairs(houses) do
                    local charinfo = {
                        firstname = result[1].firstname,
                        lastname = result[1].lastname,
                    }
                    searchData[#searchData + 1] = {
                        name = v.house,
                        keyholders = v.keyholders,
                        owner = v.citizenid,
                        price = Config.Houses[v.house].price,
                        label = Config.Houses[v.house].address,
                        tier = Config.Houses[v.house].tier,
                        garage = Config.Houses[v.house].garage,
                        charinfo = charinfo,
                        coords = {
                            x = Config.Houses[v.house].coords.enter.x,
                            y = Config.Houses[v.house].coords.enter.y,
                            z = Config.Houses[v.house].coords.enter.z
                        }
                    }
                end
                cb(searchData)
            end
        else
            cb(nil)
        end
    else
        cb(nil)
    end
end)






