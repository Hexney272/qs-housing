_G.db = {
    cache = {}
}

function db:saveCache(name, data, id, expire)
    if not data then
        Debug("No data to save to cache", name, id)
        return
    end

    if expire then
        expire = os.time() + expire
    else
        expire = os.time() + 3600000
    end

    self.cache[#self.cache + 1] = {
        name = name,
        id = id,
        time = os.time(),
        expire = expire,
        data = data
    }

    Debug("db:saveCache", name, id)
end

function db:clearCache(name, id)
    local filterFn

    if not id then
        filterFn = function(entry)
            return entry.name ~= name
        end
    else
        filterFn = function(entry)
            return entry.name ~= name
        end
    end

    self.cache = table.filter(self.cache, filterFn)
    Debug("db:clearCache", name, id)
end

function db:getCache(name, id)
    local filterFn

    if not id then
        filterFn = function(entry)
            return entry.name == name
        end
    else
        filterFn = function(entry)
            return entry.name == name
        end
    end

    local found = table.find(self.cache, filterFn)

    if found then
        Debug("db:getCache", name, id)
        return found.data
    end

    return nil
end

function db:convertVectors(data)
    if type(data) ~= "table" then
        return data
    end

    if data.w and data.x and data.y and data.z then
        return vec4(data.x, data.y, data.z, data.w)
    end

    for key, value in pairs(data) do
        if type(value) == "table" then
            data[key] = self:convertVectors(value)
        end
    end

    return data
end

function db:getBills(houseId)
    local cached = self:getCache("bills", houseId)
    if cached then
        return cached
    end

    local results = MySQL.query.await("SELECT * FROM house_bills WHERE house = ? ORDER BY payed ASC, date DESC LIMIT 100", { houseId })

    for _, bill in pairs(results) do
        bill.breakdown = json.decode(bill.breakdown)
    end

    self:saveCache("bills", results, houseId)
    return results
end

function db:payBill(billId, houseId, payerIdentifier)
    MySQL.update.await("UPDATE house_bills SET payed = 1, payed_by = ? WHERE id = ?", { payerIdentifier, billId })
    self:clearCache("bills", houseId)
end

function db:payAllBills(houseId, payerIdentifier)
    local affectedRows = MySQL.update.await("UPDATE house_bills SET payed = 1, payed_by = ? WHERE house = ? AND payed = 0", { payerIdentifier, houseId })
    self:clearCache("bills", houseId)
    return affectedRows or 0
end

function db.getBill(billId)
    local bill = MySQL.prepare.await("SELECT * FROM house_bills WHERE id = ?", { billId })

    if bill then
        bill.breakdown = json.decode(bill.breakdown)
        bill.payed = (1 == bill.payed)
    end

    return bill
end

function db:cleanupOldBills(days)
    local cleanupConfig = Config.Cleanup
    if cleanupConfig then
        cleanupConfig = cleanupConfig.Enabled
    end

    if not cleanupConfig then
        return 0
    end

    local cutoffTime = os.time() - (days * 24 * 60 * 60)
    local deleted = 0

    local result = MySQL.query.await([[
            DELETE FROM house_bills
            WHERE payed = 1
            AND date < FROM_UNIXTIME(?)
        ]], { cutoffTime })

    local affectedRows = result.affectedRows or 0
    deleted = deleted + affectedRows

    if deleted > 0 then
        Debug("db:cleanupOldBills", "Deleted", deleted, "old paid bills (older than", days, "days)")
    end

    return deleted
end

function db:cleanupOldRent(days)
    local cleanupConfig = Config.Cleanup
    if cleanupConfig then
        cleanupConfig = cleanupConfig.Enabled
    end

    if not cleanupConfig then
        return 0
    end

    local cutoffTime = os.time() - (days * 24 * 60 * 60)
    local deleted = 0

    local result = MySQL.query.await([[
            DELETE FROM house_rents
            WHERE payed = 1
            AND date < FROM_UNIXTIME(?)
        ]], { cutoffTime })

    local affectedRows = result.affectedRows or 0
    deleted = deleted + affectedRows

    if deleted > 0 then
        Debug("db:cleanupOldRent", "Deleted", deleted, "old paid rent records (older than", days, "days)   ")
    end

    return deleted
end

function db:runCleanup()
    local cleanupConfig = Config.Cleanup
    if cleanupConfig then
        cleanupConfig = cleanupConfig.Enabled
    end

    if not cleanupConfig then
        return { bills = 0, rent = 0, total = 0 }
    end

    local results = { bills = 0, rent = 0, total = 0 }

    if Config.Cleanup.Bills then
        results.bills = self:cleanupOldBills(Config.Cleanup.Bills.KeepDays)
    end

    if Config.Cleanup.Rent then
        results.rent = self:cleanupOldRent(Config.Cleanup.Rent.KeepDays)
    end

    results.total = results.bills + results.rent

    if results.total > 0 then
        Debug("db:runCleanup", "Cleanup completed", "Bills:", results.bills, "Rent:", results.rent, "Total:", results.total)
    end

    return results
end

CreateThread(function()
    local cleanupConfig = Config.Cleanup
    if cleanupConfig then
        cleanupConfig = cleanupConfig.Enabled
    end

    if not cleanupConfig then
        return
    end

    local intervalMs = Config.Cleanup.IntervalHours * 60 * 60 * 1000

    while true do
        local result = db:runCleanup()

        if result.total > 0 then
            Debug("Cleanup cycle completed", "Deleted records:", result.total)
        end

        Wait(intervalMs)
    end
end)
