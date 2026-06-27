





if Config.Framework ~= 'esx' then
    return
end

userTable = 'users'             -- users
identifierColumn = 'identifier' -- identifier
accountsColumn = 'accounts'

ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('esx:playerLoaded', function(id, data)
    Wait(2000)
    Debug('Loaded player:', id)
    CreateQuests(id)
end)

function GetJobsData()
    local jobs = ESX.GetJobs()
    local data = {}
    for k, v in pairs(jobs) do
        data[#data + 1] = {
            name = v.name,
            label = v.label,
            grades = table.map(v.grades, function(grade)
                return {
                    id = grade.id,
                    name = grade.name,
                    label = grade.label,
                    grade = grade.grade
                }
            end)
        }
    end
    return data
end

CreateThread(function()
    for k, v in pairs(ESX.Players) do
        if v and v.source then
            Debug('Loaded player:', v.source)
            CreateQuests(v.source)
        end
    end
end)

function RegisterServerCallback(name, cb)
    ESX.RegisterServerCallback(name, cb)
end

function RegisterUsableItem(name, cb)
    ESX.RegisterUsableItem(name, cb)
end

function GetPlayerFromId(source)
    return ESX.GetPlayerFromId(source)
end

function GetPlayerFromIdentifier(identifier)
    return ESX.GetPlayerFromIdentifier(identifier)
end

function GetItems(player)
    if not player then return end
    local inventory = player.getInventory()
    for k, v in pairs(inventory) do
        if v.count <= 0 then
            inventory[k] = nil
        end
        if not v.info and Config.Inventory == 'codem' then
            v.info = {}
        end
    end
    return inventory
end

function PlayerIsAdmin(source, doNotCheckJobs)
    local xPlayer = GetPlayerFromId(source)
    if not xPlayer then return false end

    if Config.AllowAdminsToCreateHouses then
        local group = xPlayer.getGroup()
        if group == 'admin' or group == 'superadmin' then
            return true
        end
    end

    local job = xPlayer.getJob() and xPlayer.getJob().name or nil
    local grade = xPlayer.getJob() and xPlayer.getJob().grade or 0

    if not doNotCheckJobs then
        for _, v in pairs(Config.CreatorJobs) do
            if v.job == job then
                if not v.grade or v.grade == false then
                    return true
                end
                for _, g in pairs(v.grade) do
                    if grade == g then
                        return true
                    end
                end
            end
        end
    end

    return false
end

function AddItem(source, item, count, slot, info)
    local player = GetPlayerFromId(source)
    player.addInventoryItem(item, count, info, slot)
    return true
end

function AddMoneyToAccount(account, amount, isNotRent)
    local source = GetPlayerSourceFromIdentifier(account)
    if source then
        AddAccountMoney(source, 'bank', amount)
        if isNotRent then return end
        Notification(source, i18n.t('rent.payment', { price = amount }), 'error')
    else
        local result = MySQL.Sync.fetchAll('SELECT accounts FROM users WHERE identifier = ?', { account })
        if not result[1] then return print('Add Money Account : Not finded this account: ' .. account) end
        local accounts = json.decode(result[1].accounts)
        accounts.bank = accounts.bank + amount
        MySQL.Sync.execute('UPDATE users SET accounts = ? WHERE identifier = ?', {
            json.encode(accounts),
            account
        })
    end
end

function RemoveMoneyFromAccount(account, amount, dontCheck, moneyAccount)
    moneyAccount = moneyAccount or 'bank'
    local source = GetPlayerSourceFromIdentifier(account)
    if source then
        RemoveAccountMoney(source, moneyAccount, amount)
        return true
    else
        local player = MySQL.Sync.fetchAll('SELECT accounts FROM users WHERE identifier = ?', { account })
        if player[1] then
            local accounts = json.decode(player[1].accounts)
            local balance = accounts[moneyAccount]
            if balance == nil and moneyAccount == 'money' then
                balance = accounts.cash
                moneyAccount = 'cash'
            end
            balance = balance or 0
            if balance >= amount or dontCheck then
                accounts[moneyAccount] = balance - amount
                MySQL.Sync.execute('UPDATE users SET accounts = ? WHERE identifier = ?', { json.encode(accounts), account })
                return true
            end
        end
    end
    return false
end

function GetJobName(source)
    local player = GetPlayerFromId(source)
    if not player then return '' end
    return player.getJob().name
end

function GetJobGrade(source)
    local player = GetPlayerFromId(source)
    if not player then return 0 end
    return player.getJob().grade
end

function GetCharacterName(source)
    local xPlayer = GetPlayerFromId(source)
    local firstName, lastName
    if xPlayer.get and xPlayer.get('firstName') and xPlayer.get('lastName') then
        firstName = xPlayer.get('firstName')
        lastName = xPlayer.get('lastName')
    else
        local name = MySQL.Sync.fetchAll('SELECT `firstname`, `lastname` FROM `users` WHERE `identifier`=@identifier', { ['@identifier'] = ESX.GetIdentifier(source) })
        firstName, lastName = name[1]?.firstname or ESX.GetPlayerName(source), name[1]?.lastname or ''
    end

    return firstName, lastName
end

function GetAccountMoney(source, account)
    local player = GetPlayerFromId(source)
    return player.getAccount(account).money
end

function AddAccountMoney(source, account, amount)
    local player = GetPlayerFromId(source)
    player.addAccountMoney(account, amount)
end

function RemoveAccountMoney(source, account, amount)
    local player = GetPlayerFromId(source)
    player.removeAccountMoney(account, amount)
end

function RemoveItem(source, item, count)
    local player = GetPlayerFromId(source)
    player.removeInventoryItem(item, count)
end

function GetIdentifier(source)
    local player = GetPlayerFromId(source)
    if not player then
        return false
    end
    return player.identifier
end

function GetPlayerSourceFromIdentifier(identifier)
    local player = GetPlayerFromIdentifier(identifier)
    if not player then
        return false
    end
    return player.source
end

function GetPlayerSourceFromSource(source)
    local player = GetPlayerFromId(source)
    if not player then
        return false
    end
    return player.source
end

function GetCharacterFromIdentifier(identifier)
    local result = MySQL.Sync.fetchAll('SELECT * FROM `users` WHERE identifier = ?', { identifier })
    if not result[1] then
        return '', ''
    end
    result = result[1]
    return result?.firstname, result?.lastname
end

RegisterServerCallback('qb-houses:GetInside', function(source, cb)
    local src = source
    local identifier = GetIdentifier(src)
    local fetch = ([[
		SELECT inside
		FROM %s
		WHERE %s = @id;
	]]):format(userTable, identifierColumn)
    local fetchData = { ['@id'] = identifier }
    local result = MySQL.Sync.fetchAll(fetch, fetchData)
    if result and result[1] then
        cb(result[1].inside)
        Debug('qb-houses:GetInside: ', result[1].inside)
    else
        cb(false)
        Debug('qb-houses:GetInside: ', false)
    end
end)

function GetPlayerSQLDataFromIdentifier(identifier)
    local result = MySQL.Sync.fetchAll('SELECT * FROM `users` WHERE identifier = ?', { identifier })
    if result[1] then
        return result[1]
    end
    return false
end

function UpdateInside(src, insideId, bool)
    local identifier = GetIdentifier(src)
    local update = ([[
			UPDATE %s SET inside = @inside
			WHERE %s = @id;
	]]):format(userTable, identifierColumn)
    local updateData = {
        ['@inside'] = insideId,
        ['@id'] = identifier
    }
    if bool then
        MySQL.Sync.execute(update, updateData)
    else
        updateData = {
            ['@inside'] = nil,
            ['@id'] = identifier
        }
        MySQL.Sync.execute(update, updateData)
    end
end

---@param src number
---@return string|nil
function GetPlayerInsideHouse(src)
    local identifier = GetIdentifier(src)
    if not identifier then return nil end
    local row = MySQL.single.await(
        ('SELECT `inside` AS inside FROM `%s` WHERE `%s` = ? LIMIT 1'):format(userTable, identifierColumn),
        { identifier }
    )
    if not row or not row.inside or row.inside == '' then return nil end
    return row.inside
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






