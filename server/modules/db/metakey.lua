if not Config.EnableMetaKey then
    return
end

function db.isMetaKeyValid(self, keyId, house)
    local cached = self:getCache("meta_key_valid", keyId .. ":" .. house)
    if cached then
        return cached
    end

    local result = MySQL.single.await("SELECT key_id FROM house_meta_keys WHERE key_id = ? AND house = ?", { keyId, house })
    Debug("db:isMetaKeyValid", "Key ID:", keyId, "House:", house, "Result:", result)

    local isValid = nil ~= result
    self:saveCache("meta_key_valid", isValid, keyId .. ":" .. house)
    return isValid
end

function db.createMetaKey(self, house, keyId, ownerIdentifier)
    local insertedId = MySQL.insert.await(
        "INSERT INTO house_meta_keys (house, key_id, owner_identifier) VALUES (?, ?, ?)",
        { house, keyId, ownerIdentifier }
    )

    self:clearCache("house_meta_keys", house)
    self:clearCache("meta_key_valid", keyId .. ":" .. house)
    return insertedId
end

function db.deleteMetaKey(self, keyId, house)
    local result = MySQL.query.await(
        "DELETE FROM house_meta_keys WHERE key_id = ? AND house = ?",
        { keyId, house }
    )

    self:clearCache("house_meta_keys", house)
    self:clearCache("meta_key_valid", keyId .. ":" .. house)
    return result
end

function db.getHouseMetaKeys(self, house)
    local cached = self:getCache("house_meta_keys", house)
    if cached then
        return cached
    end

    local results = MySQL.query.await(
        "SELECT * FROM house_meta_keys WHERE house = ? ORDER BY created_at DESC",
        { house }
    )

    self:saveCache("house_meta_keys", results, house)
    return results
end
