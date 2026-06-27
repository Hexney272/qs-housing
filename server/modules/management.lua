local function GiveKey(ownerSource, targetIdentifier, houseName)
    local ownerIdentifier = GetIdentifier(ownerSource)
    local targetPlayer = GetPlayerFromId(targetIdentifier)
    local targetCitizenid = GetIdentifier(targetIdentifier)
    local targetSource = GetPlayerSourceFromIdentifier(targetCitizenid)

    local isOwner = HouseOwnerIdentifierList[houseName] == ownerIdentifier and HouseOwnerCitizenidList[houseName] == ownerIdentifier
    if not isOwner then
        Notification(ownerSource, i18n.t("you_are_not_owner"), "error")
        return false
    end

    if targetPlayer then
        if HouseKeyholdersList[houseName] then
            for index, keyholder in pairs(HouseKeyholdersList[houseName]) do
                if keyholder == targetCitizenid then
                    Notification(ownerSource, i18n.t("keyholders.already_have_key"), "info")
                    return false
                end
            end

            table.insert(HouseKeyholdersList[houseName], targetCitizenid)

            MySQL.Sync.execute("UPDATE player_houses SET keyholders = ? WHERE house = ?", {
                json.encode(HouseKeyholdersList[houseName]),
                houseName
            })

            TriggerClientEvent("housing:refreshHouse", targetSource, houseName)

            Notification(targetSource, i18n.t("keyholders.received_key", {
                address = Config.Houses[houseName].address
            }), "success")

            Notification(ownerSource, i18n.t("keyholders.key_given", {
                address = Config.Houses[houseName].address
            }), "success")

            return true
        else
            HouseKeyholdersList[houseName] = { ownerIdentifier }

            table.insert(HouseKeyholdersList[houseName], targetCitizenid)

            MySQL.Sync.execute("UPDATE player_houses SET keyholders = ? WHERE house = ?", {
                json.encode(HouseKeyholdersList[houseName]),
                houseName
            })

            TriggerClientEvent("housing:refreshHouse", targetSource, houseName)

            Notification(targetSource, i18n.t("keyholders.received_key", {
                address = Config.Houses[houseName].address
            }), "success")

            Notification(ownerSource, i18n.t("keyholders.key_given", {
                address = Config.Houses[houseName].address
            }), "success")

            return true
        end

        local resourceState = GetResourceState("qs-inventory")
        if resourceState:find("started") then
            if Config.EnableQuests then
                local questResult = exports["qs-inventory"]:UpdateQuestProgress(ownerSource, "give_house_keys", 100)
                if questResult then
                    Debug("Quest \"give_house_keys\" progress updated")
                else
                    Debug("Failed to update quest \"give_house_keys\"")
                end
            end
        end
    else
        Notification(ownerSource, i18n.t("keyholders.offline"), "error")
        return false
    end
end

RegisterServerCallback("housing:buyUpgrade", function(source, cb, houseName, upgradeName)
    local playerSource = source
    local identifier = GetIdentifier(playerSource)

    local isOwner = HouseOwnerIdentifierList[houseName] == identifier and HouseOwnerCitizenidList[houseName] == identifier
    if not isOwner then
        Notification(playerSource, i18n.t("you_are_not_owner"), "error")
        return cb(false)
    end

    local upgrade = table.find(Config.Upgrades, function(item)
        return item.name == upgradeName
    end)

    if not upgrade then
        Notification(playerSource, i18n.t("no_upgrade"), "error")
        return cb(false)
    end

    local price = upgrade.price
    local bankBalance = GetAccountMoney(playerSource, "bank")

    if price > bankBalance then
        Notification(playerSource, i18n.t("no_money", { price = price }), "error")
        return cb(false)
    end

    RemoveAccountMoney(playerSource, "bank", price)

    local houseData = Config.Houses[houseName]
    local upgrades = houseData.upgrades
    if not upgrades then
        upgrades = {}
    end
    houseData.upgrades = upgrades

    table.insert(houseData.upgrades, upgradeName)

    MySQL.Sync.execute("UPDATE houselocations SET upgrades = ? WHERE name = ?", {
        json.encode(houseData.upgrades),
        houseName
    })

    TriggerClientEvent("housing:updateHouseData", -1, houseName, "upgrades", houseData.upgrades)

    Debug("housing:buyUpgrade", "Bought upgrade", upgradeName, houseName)
    cb(true)

    local resourceState = GetResourceState("qs-inventory")
    if resourceState:find("started") then
        if Config.EnableQuests then
            local questResult = exports["qs-inventory"]:UpdateQuestProgress(playerSource, "install_home_upgrade", 100)
            if questResult then
                Debug("Quest \"install_home_upgrade\" progress updated")
            else
                Debug("Failed to update quest \"install_home_upgrade\"")
            end
        end
    end

    SendLog(DiscordWebhook, {
        title = "Housing",
        description = "Player bought an upgrade",
        fields = {
            {
                name = "Player",
                value = GetPlayerName(playerSource),
                inline = true
            },
            {
                name = "House",
                value = houseName,
                inline = true
            },
            {
                name = "Upgrade",
                value = upgradeName,
                inline = true
            },
            {
                name = "Price",
                value = price,
                inline = true
            }
        },
        color = WebhookColor
    })
end)

local function TakeKey(ownerSource, houseName, targetData)
    local ownerIdentifier = GetIdentifier(ownerSource)

    local isOwner = HouseOwnerIdentifierList[houseName] == ownerIdentifier and HouseOwnerCitizenidList[houseName] == ownerIdentifier
    if not isOwner then
        Notification(ownerSource, i18n.t("you_are_not_owner"), "error")
        return false
    end

    if HouseKeyholdersList[houseName] ~= nil then
        for index, keyholder in pairs(HouseKeyholdersList[houseName]) do
            if HouseKeyholdersList[houseName][index] == targetData.citizenid then
                table.remove(HouseKeyholdersList[houseName], index)

                MySQL.Sync.execute("UPDATE player_houses SET keyholders = ? WHERE house = ?", {
                    json.encode(HouseKeyholdersList[houseName]),
                    houseName
                })

                Notification(ownerSource, i18n.t("keyholders.removed_key", {
                    player = targetData.firstname .. " " .. targetData.lastname
                }), "success")

                local targetSource = GetPlayerSourceFromIdentifier(targetData.citizenid)
                if targetSource then
                    TriggerClientEvent("housing:refreshHouse", targetSource, houseName)
                    Notification(targetSource, i18n.t("keyholders.removed_key_target", {
                        address = Config.Houses[houseName].address
                    }), "success")
                end

                return true
            end
        end
    end

    return false
end

lib.callback.register("housing:giveKey", function(source, targetIdentifier, houseName)
    return GiveKey(source, targetIdentifier, houseName)
end)

lib.callback.register("housing:takeKey", function(source, houseName, targetData)
    return TakeKey(source, houseName, targetData)
end)

RegisterNetEvent("housing:updatePermissions", function(houseName, permissions)
    local playerSource = source
    local identifier = GetIdentifier(playerSource)

    if not houseName or type(permissions) ~= "table" then
        return
    end

    if HouseOwnerIdentifierList[houseName] ~= identifier then
        Notification(playerSource, i18n.t("you_are_not_owner"), "error")
        return
    end

    MySQL.update.await("UPDATE houselocations SET permissions = ? WHERE name = ?", {
        json.encode(permissions),
        houseName
    })

    Config.Houses[houseName].permissions = permissions

    TriggerClientEvent("housing:updateHouseData", -1, houseName, "permissions", permissions)

    Notification(playerSource, i18n.t("management.permissions.updated"), "success")
end)

RegisterNetEvent("housing:updateDoorbellSound", function(houseName, soundName)
    local playerSource = source
    local identifier = GetIdentifier(playerSource)

    if not houseName or type(soundName) ~= "string" then
        return
    end

    if HouseOwnerIdentifierList[houseName] ~= identifier then
        Notification(playerSource, i18n.t("you_are_not_owner"), "error")
        return
    end

    local houseData = Config.Houses[houseName]
    if not houseData then
        return
    end

    local hasDoorbellUpgrade = table.includes(houseData.upgrades or {}, "doorbell")
    if not hasDoorbellUpgrade then
        Notification(playerSource, i18n.t("management.settings.doorbell.upgrade_required") or "You need to purchase the Custom Doorbell upgrade to change the doorbell sound.", "error")
        return
    end

    MySQL.update.await("UPDATE houselocations SET doorbellSound = ? WHERE name = ?", {
        soundName,
        houseName
    })

    Config.Houses[houseName].doorbellSound = soundName

    TriggerClientEvent("housing:updateHouseData", -1, houseName, "doorbellSound", soundName)

    Notification(playerSource, i18n.t("management.settings.doorbell.updated"), "success")
end)

RegisterNetEvent("housing:updateAssistantZoneMessages", function(houseName, enabled)
    local playerSource = source
    local identifier = GetIdentifier(playerSource)

    if not houseName or type(enabled) ~= "boolean" then
        return
    end

    if HouseOwnerIdentifierList[houseName] ~= identifier then
        Notification(playerSource, i18n.t("you_are_not_owner"), "error")
        return
    end

    local houseData = Config.Houses[houseName]
    if not houseData then
        return
    end

    MySQL.update.await("UPDATE houselocations SET assistantZoneMessagesEnabled = ? WHERE name = ?", {
        enabled and 1 or 0,
        houseName
    })

    Config.Houses[houseName].assistantZoneMessagesEnabled = enabled

    TriggerClientEvent("housing:updateHouseData", -1, houseName, "assistantZoneMessagesEnabled", enabled)
end)

RegisterNetEvent("housing:server:removeHouseKey", function(houseName, targetData)
    local playerSource = source
    TakeKey(playerSource, houseName, targetData)
end)

RegisterNetEvent("housing:server:giveHouseKey", function(targetIdentifier, houseName)
    local playerSource = source
    GiveKey(playerSource, targetIdentifier, houseName)
end)
