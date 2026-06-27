





local L0_1, L1_1, L2_1, L3_1, L4_1
L0_1 = RegisterServerCallback
L1_1 = "housing:buyUpgrade"
function L2_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L4_2 = A0_2
  L5_2 = GetIdentifier
  L6_2 = L4_2
  L5_2 = L5_2(L6_2)
  L6_2 = HouseOwnerIdentifierList
  L6_2 = L6_2[A2_2]
  if L6_2 == L5_2 then
    L6_2 = HouseOwnerCitizenidList
    L6_2 = L6_2[A2_2]
    if L6_2 == L5_2 then
      goto lbl_25
    end
  end
  L6_2 = Notification
  L7_2 = L4_2
  L8_2 = i18n
  L8_2 = L8_2.t
  L9_2 = "you_are_not_owner"
  L8_2 = L8_2(L9_2)
  L9_2 = "error"
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = A1_2
  L7_2 = false
  do return L6_2(L7_2) end
  ::lbl_25::
  L6_2 = table
  L6_2 = L6_2.find
  L7_2 = Config
  L7_2 = L7_2.Upgrades
  function L8_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.name
    L2_3 = A3_2
    L1_3 = L1_3 == L2_3
    return L1_3
  end
  L6_2 = L6_2(L7_2, L8_2)
  if not L6_2 then
    L7_2 = Notification
    L8_2 = L4_2
    L9_2 = i18n
    L9_2 = L9_2.t
    L10_2 = "no_upgrade"
    L9_2 = L9_2(L10_2)
    L10_2 = "error"
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = A1_2
    L8_2 = false
    return L7_2(L8_2)
  end
  L7_2 = L6_2.price
  L8_2 = GetAccountMoney
  L9_2 = L4_2
  L10_2 = "bank"
  L8_2 = L8_2(L9_2, L10_2)
  if L7_2 > L8_2 then
    L9_2 = Notification
    L10_2 = L4_2
    L11_2 = i18n
    L11_2 = L11_2.t
    L12_2 = "no_money"
    L13_2 = {}
    L13_2.price = L7_2
    L11_2 = L11_2(L12_2, L13_2)
    L12_2 = "error"
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = A1_2
    L10_2 = false
    return L9_2(L10_2)
  end
  L9_2 = RemoveAccountMoney
  L10_2 = L4_2
  L11_2 = "bank"
  L12_2 = L7_2
  L9_2(L10_2, L11_2, L12_2)
  L9_2 = Config
  L9_2 = L9_2.Houses
  L9_2 = L9_2[A2_2]
  L10_2 = L9_2.upgrades
  if not L10_2 then
    L10_2 = {}
  end
  L9_2.upgrades = L10_2
  L10_2 = table
  L10_2 = L10_2.insert
  L11_2 = L9_2.upgrades
  L12_2 = A3_2
  L10_2(L11_2, L12_2)
  L10_2 = MySQL
  L10_2 = L10_2.Sync
  L10_2 = L10_2.execute
  L11_2 = "UPDATE houselocations SET upgrades = ? WHERE name = ?"
  L12_2 = {}
  L13_2 = json
  L13_2 = L13_2.encode
  L14_2 = L9_2.upgrades
  L13_2 = L13_2(L14_2)
  L14_2 = A2_2
  L12_2[1] = L13_2
  L12_2[2] = L14_2
  L10_2(L11_2, L12_2)
  L10_2 = TriggerClientEvent
  L11_2 = "housing:updateHouseData"
  L12_2 = -1
  L13_2 = A2_2
  L14_2 = "upgrades"
  L15_2 = L9_2.upgrades
  L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
  L10_2 = Debug
  L11_2 = "housing:buyUpgrade"
  L12_2 = "Bought upgrade"
  L13_2 = A3_2
  L14_2 = A2_2
  L10_2(L11_2, L12_2, L13_2, L14_2)
  L10_2 = A1_2
  L11_2 = true
  L10_2(L11_2)
  L10_2 = GetResourceState
  L11_2 = "qs-inventory"
  L10_2 = L10_2(L11_2)
  L11_2 = L10_2
  L10_2 = L10_2.find
  L12_2 = "started"
  L10_2 = L10_2(L11_2, L12_2)
  if L10_2 then
    L10_2 = Config
    L10_2 = L10_2.EnableQuests
    if L10_2 then
      L10_2 = exports
      L10_2 = L10_2["qs-inventory"]
      L11_2 = L10_2
      L10_2 = L10_2.UpdateQuestProgress
      L12_2 = L4_2
      L13_2 = "install_home_upgrade"
      L14_2 = 100
      L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
      if L10_2 then
        L11_2 = Debug
        L12_2 = "Quest \"install_home_upgrade\" progress updated"
        L11_2(L12_2)
      else
        L11_2 = Debug
        L12_2 = "Failed to update quest \"install_home_upgrade\""
        L11_2(L12_2)
      end
    end
  end
  L10_2 = SendLog
  L11_2 = DiscordWebhook
  L12_2 = {}
  L12_2.title = "Housing"
  L12_2.description = "Player bought an upgrade"
  L13_2 = {}
  L14_2 = {}
  L14_2.name = "Player"
  L15_2 = GetPlayerName
  L16_2 = L4_2
  L15_2 = L15_2(L16_2)
  L14_2.value = L15_2
  L14_2.inline = true
  L15_2 = {}
  L15_2.name = "House"
  L15_2.value = A2_2
  L15_2.inline = true
  L16_2 = {}
  L16_2.name = "Upgrade"
  L16_2.value = A3_2
  L16_2.inline = true
  L17_2 = {}
  L17_2.name = "Price"
  L17_2.value = L7_2
  L17_2.inline = true
  L13_2[1] = L14_2
  L13_2[2] = L15_2
  L13_2[3] = L16_2
  L13_2[4] = L17_2
  L12_2.fields = L13_2
  L13_2 = WebhookColor
  L12_2.color = L13_2
  L10_2(L11_2, L12_2)
end
L0_1(L1_1, L2_1)
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L3_2 = A0_2
  L4_2 = GetIdentifier
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = GetPlayerFromId
  L6_2 = A1_2
  L5_2 = L5_2(L6_2)
  L6_2 = GetIdentifier
  L7_2 = A1_2
  L6_2 = L6_2(L7_2)
  L7_2 = GetPlayerSourceFromIdentifier
  L8_2 = L6_2
  L7_2 = L7_2(L8_2)
  L8_2 = HouseOwnerIdentifierList
  L8_2 = L8_2[A2_2]
  if L8_2 == L4_2 then
    L8_2 = HouseOwnerCitizenidList
    L8_2 = L8_2[A2_2]
    if L8_2 == L4_2 then
      goto lbl_38
    end
  end
  L8_2 = Error
  L9_2 = "housing:giveKey"
  L10_2 = "Player tried to give key to a house they do not own"
  L11_2 = L3_2
  L12_2 = A2_2
  L8_2(L9_2, L10_2, L11_2, L12_2)
  L8_2 = Notification
  L9_2 = L3_2
  L10_2 = i18n
  L10_2 = L10_2.t
  L11_2 = "you_are_not_owner"
  L10_2 = L10_2(L11_2)
  L11_2 = "error"
  L8_2(L9_2, L10_2, L11_2)
  L8_2 = false
  do return L8_2 end
  ::lbl_38::
  if L5_2 then
    L8_2 = HouseKeyholdersList
    L8_2 = L8_2[A2_2]
    if L8_2 then
      L8_2 = pairs
      L9_2 = HouseKeyholdersList
      L9_2 = L9_2[A2_2]
      L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
      for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
        if L13_2 == L6_2 then
          L14_2 = Notification
          L15_2 = L3_2
          L16_2 = i18n
          L16_2 = L16_2.t
          L17_2 = "keyholders.already_have_key"
          L16_2 = L16_2(L17_2)
          L17_2 = "info"
          L14_2(L15_2, L16_2, L17_2)
          L14_2 = false
          return L14_2
        end
      end
      L8_2 = table
      L8_2 = L8_2.insert
      L9_2 = HouseKeyholdersList
      L9_2 = L9_2[A2_2]
      L10_2 = L6_2
      L8_2(L9_2, L10_2)
      L8_2 = MySQL
      L8_2 = L8_2.Sync
      L8_2 = L8_2.execute
      L9_2 = "UPDATE player_houses SET keyholders = ? WHERE house = ?"
      L10_2 = {}
      L11_2 = json
      L11_2 = L11_2.encode
      L12_2 = HouseKeyholdersList
      L12_2 = L12_2[A2_2]
      L11_2 = L11_2(L12_2)
      L12_2 = A2_2
      L10_2[1] = L11_2
      L10_2[2] = L12_2
      L8_2(L9_2, L10_2)
      L8_2 = TriggerClientEvent
      L9_2 = "housing:refreshHouse"
      L10_2 = L7_2
      L11_2 = A2_2
      L8_2(L9_2, L10_2, L11_2)
      L8_2 = Notification
      L9_2 = L7_2
      L10_2 = i18n
      L10_2 = L10_2.t
      L11_2 = "keyholders.received_key"
      L12_2 = {}
      L13_2 = Config
      L13_2 = L13_2.Houses
      L13_2 = L13_2[A2_2]
      L13_2 = L13_2.address
      L12_2.address = L13_2
      L10_2 = L10_2(L11_2, L12_2)
      L11_2 = "success"
      L8_2(L9_2, L10_2, L11_2)
      L8_2 = Notification
      L9_2 = L3_2
      L10_2 = i18n
      L10_2 = L10_2.t
      L11_2 = "keyholders.key_given"
      L12_2 = {}
      L13_2 = Config
      L13_2 = L13_2.Houses
      L13_2 = L13_2[A2_2]
      L13_2 = L13_2.address
      L12_2.address = L13_2
      L10_2 = L10_2(L11_2, L12_2)
      L11_2 = "success"
      L8_2(L9_2, L10_2, L11_2)
      L8_2 = true
      return L8_2
    else
      L8_2 = HouseKeyholdersList
      L9_2 = {}
      L9_2[1] = L4_2
      L8_2[A2_2] = L9_2
      L8_2 = table
      L8_2 = L8_2.insert
      L9_2 = HouseKeyholdersList
      L9_2 = L9_2[A2_2]
      L10_2 = L6_2
      L8_2(L9_2, L10_2)
      L8_2 = MySQL
      L8_2 = L8_2.Sync
      L8_2 = L8_2.execute
      L9_2 = "UPDATE player_houses SET keyholders = ? WHERE house = ?"
      L10_2 = {}
      L11_2 = json
      L11_2 = L11_2.encode
      L12_2 = HouseKeyholdersList
      L12_2 = L12_2[A2_2]
      L11_2 = L11_2(L12_2)
      L12_2 = A2_2
      L10_2[1] = L11_2
      L10_2[2] = L12_2
      L8_2(L9_2, L10_2)
      L8_2 = TriggerClientEvent
      L9_2 = "housing:refreshHouse"
      L10_2 = L7_2
      L11_2 = A2_2
      L8_2(L9_2, L10_2, L11_2)
      L8_2 = Notification
      L9_2 = L7_2
      L10_2 = i18n
      L10_2 = L10_2.t
      L11_2 = "keyholders.received_key"
      L12_2 = {}
      L13_2 = Config
      L13_2 = L13_2.Houses
      L13_2 = L13_2[A2_2]
      L13_2 = L13_2.address
      L12_2.address = L13_2
      L10_2 = L10_2(L11_2, L12_2)
      L11_2 = "success"
      L8_2(L9_2, L10_2, L11_2)
      L8_2 = Notification
      L9_2 = L3_2
      L10_2 = i18n
      L10_2 = L10_2.t
      L11_2 = "keyholders.key_given"
      L12_2 = {}
      L13_2 = Config
      L13_2 = L13_2.Houses
      L13_2 = L13_2[A2_2]
      L13_2 = L13_2.address
      L12_2.address = L13_2
      L10_2 = L10_2(L11_2, L12_2)
      L11_2 = "success"
      L8_2(L9_2, L10_2, L11_2)
      L8_2 = true
      return L8_2
    end
    L8_2 = GetResourceState
    L9_2 = "qs-inventory"
    L8_2 = L8_2(L9_2)
    L9_2 = L8_2
    L8_2 = L8_2.find
    L10_2 = "started"
    L8_2 = L8_2(L9_2, L10_2)
    if L8_2 then
      L8_2 = Config
      L8_2 = L8_2.EnableQuests
      if L8_2 then
        L8_2 = exports
        L8_2 = L8_2["qs-inventory"]
        L9_2 = L8_2
        L8_2 = L8_2.UpdateQuestProgress
        L10_2 = L3_2
        L11_2 = "give_house_keys"
        L12_2 = 100
        L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
        if L8_2 then
          L9_2 = Debug
          L10_2 = "Quest \"give_house_keys\" progress updated"
          L9_2(L10_2)
        else
          L9_2 = Debug
          L10_2 = "Failed to update quest \"give_house_keys\""
          L9_2(L10_2)
        end
      end
    end
  else
    L8_2 = Notification
    L9_2 = L3_2
    L10_2 = i18n
    L10_2 = L10_2.t
    L11_2 = "keyholders.offline"
    L10_2 = L10_2(L11_2)
    L11_2 = "error"
    L8_2(L9_2, L10_2, L11_2)
    L8_2 = false
    return L8_2
  end
end
L1_1 = lib
L1_1 = L1_1.callback
L1_1 = L1_1.register
L2_1 = "housing:giveKey"
function L3_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = L0_1
  L4_2 = A0_2
  L5_2 = A1_2
  L6_2 = A2_2
  return L3_2(L4_2, L5_2, L6_2)
end
L1_1(L2_1, L3_1)
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L3_2 = GetIdentifier
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = HouseOwnerIdentifierList
  L4_2 = L4_2[A1_2]
  if L4_2 == L3_2 then
    L4_2 = HouseOwnerCitizenidList
    L4_2 = L4_2[A1_2]
    if L4_2 == L3_2 then
      goto lbl_22
    end
  end
  L4_2 = Notification
  L5_2 = A0_2
  L6_2 = i18n
  L6_2 = L6_2.t
  L7_2 = "you_are_not_owner"
  L6_2 = L6_2(L7_2)
  L7_2 = "error"
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = false
  do return L4_2 end
  ::lbl_22::
  L4_2 = HouseKeyholdersList
  L4_2 = L4_2[A1_2]
  if nil ~= L4_2 then
    L4_2 = pairs
    L5_2 = HouseKeyholdersList
    L5_2 = L5_2[A1_2]
    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
    for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
      L10_2 = HouseKeyholdersList
      L10_2 = L10_2[A1_2]
      L10_2 = L10_2[L8_2]
      L11_2 = A2_2.citizenid
      if L10_2 == L11_2 then
        L10_2 = table
        L10_2 = L10_2.remove
        L11_2 = HouseKeyholdersList
        L11_2 = L11_2[A1_2]
        L12_2 = L8_2
        L10_2(L11_2, L12_2)
        L10_2 = MySQL
        L10_2 = L10_2.Sync
        L10_2 = L10_2.execute
        L11_2 = "UPDATE player_houses SET keyholders = ? WHERE house = ?"
        L12_2 = {}
        L13_2 = json
        L13_2 = L13_2.encode
        L14_2 = HouseKeyholdersList
        L14_2 = L14_2[A1_2]
        L13_2 = L13_2(L14_2)
        L14_2 = A1_2
        L12_2[1] = L13_2
        L12_2[2] = L14_2
        L10_2(L11_2, L12_2)
        L10_2 = Notification
        L11_2 = A0_2
        L12_2 = i18n
        L12_2 = L12_2.t
        L13_2 = "keyholders.removed_key"
        L14_2 = {}
        L15_2 = A2_2.firstname
        L16_2 = " "
        L17_2 = A2_2.lastname
        L15_2 = L15_2 .. L16_2 .. L17_2
        L14_2.player = L15_2
        L12_2 = L12_2(L13_2, L14_2)
        L13_2 = "success"
        L10_2(L11_2, L12_2, L13_2)
        L10_2 = GetPlayerSourceFromIdentifier
        L11_2 = A2_2.citizenid
        L10_2 = L10_2(L11_2)
        if L10_2 then
          L11_2 = TriggerClientEvent
          L12_2 = "housing:refreshHouse"
          L13_2 = L10_2
          L14_2 = A1_2
          L11_2(L12_2, L13_2, L14_2)
          L11_2 = Notification
          L12_2 = L10_2
          L13_2 = i18n
          L13_2 = L13_2.t
          L14_2 = "keyholders.removed_key_target"
          L15_2 = {}
          L16_2 = Config
          L16_2 = L16_2.Houses
          L16_2 = L16_2[A1_2]
          L16_2 = L16_2.address
          L15_2.address = L16_2
          L13_2 = L13_2(L14_2, L15_2)
          L14_2 = "success"
          L11_2(L12_2, L13_2, L14_2)
        end
        L11_2 = true
        return L11_2
      end
    end
  end
  L4_2 = false
  return L4_2
end
L2_1 = lib
L2_1 = L2_1.callback
L2_1 = L2_1.register
L3_1 = "housing:takeKey"
function L4_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = L1_1
  L4_2 = A0_2
  L5_2 = A1_2
  L6_2 = A2_2
  return L3_2(L4_2, L5_2, L6_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "housing:updatePermissions"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = source
  L3_2 = GetIdentifier
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  if A0_2 then
    L4_2 = type
    L5_2 = A1_2
    L4_2 = L4_2(L5_2)
    if "table" == L4_2 then
      goto lbl_13
    end
  end
  do return end
  ::lbl_13::
  L4_2 = HouseOwnerIdentifierList
  L4_2 = L4_2[A0_2]
  if L4_2 ~= L3_2 then
    L4_2 = Notification
    L5_2 = L2_2
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "you_are_not_owner"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    L4_2(L5_2, L6_2, L7_2)
    return
  end
  L4_2 = MySQL
  L4_2 = L4_2.update
  L4_2 = L4_2.await
  L5_2 = "UPDATE houselocations SET permissions = ? WHERE name = ?"
  L6_2 = {}
  L7_2 = json
  L7_2 = L7_2.encode
  L8_2 = A1_2
  L7_2 = L7_2(L8_2)
  L8_2 = A0_2
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L4_2(L5_2, L6_2)
  L4_2 = Config
  L4_2 = L4_2.Houses
  L4_2 = L4_2[A0_2]
  L4_2.permissions = A1_2
  L4_2 = TriggerClientEvent
  L5_2 = "housing:updateHouseData"
  L6_2 = -1
  L7_2 = A0_2
  L8_2 = "permissions"
  L9_2 = A1_2
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = Notification
  L5_2 = L2_2
  L6_2 = i18n
  L6_2 = L6_2.t
  L7_2 = "management.permissions.updated"
  L6_2 = L6_2(L7_2)
  L7_2 = "success"
  L4_2(L5_2, L6_2, L7_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "housing:updateDoorbellSound"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = source
  L3_2 = GetIdentifier
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  if A0_2 then
    L4_2 = type
    L5_2 = A1_2
    L4_2 = L4_2(L5_2)
    if "string" == L4_2 then
      goto lbl_13
    end
  end
  do return end
  ::lbl_13::
  L4_2 = HouseOwnerIdentifierList
  L4_2 = L4_2[A0_2]
  if L4_2 ~= L3_2 then
    L4_2 = Notification
    L5_2 = L2_2
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "you_are_not_owner"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    L4_2(L5_2, L6_2, L7_2)
    return
  end
  L4_2 = Config
  L4_2 = L4_2.Houses
  L4_2 = L4_2[A0_2]
  if not L4_2 then
    return
  end
  L5_2 = table
  L5_2 = L5_2.includes
  L6_2 = L4_2.upgrades
  if not L6_2 then
    L6_2 = {}
  end
  L7_2 = "doorbell"
  L5_2 = L5_2(L6_2, L7_2)
  if not L5_2 then
    L6_2 = Notification
    L7_2 = L2_2
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "management.settings.doorbell.upgrade_required"
    L8_2 = L8_2(L9_2)
    if not L8_2 then
      L8_2 = "You need to purchase the Custom Doorbell upgrade to change the doorbell sound."
    end
    L9_2 = "error"
    L6_2(L7_2, L8_2, L9_2)
    return
  end
  L6_2 = MySQL
  L6_2 = L6_2.update
  L6_2 = L6_2.await
  L7_2 = "UPDATE houselocations SET doorbellSound = ? WHERE name = ?"
  L8_2 = {}
  L9_2 = A1_2
  L10_2 = A0_2
  L8_2[1] = L9_2
  L8_2[2] = L10_2
  L6_2(L7_2, L8_2)
  L6_2 = Config
  L6_2 = L6_2.Houses
  L6_2 = L6_2[A0_2]
  L6_2.doorbellSound = A1_2
  L6_2 = TriggerClientEvent
  L7_2 = "housing:updateHouseData"
  L8_2 = -1
  L9_2 = A0_2
  L10_2 = "doorbellSound"
  L11_2 = A1_2
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  L6_2 = Notification
  L7_2 = L2_2
  L8_2 = i18n
  L8_2 = L8_2.t
  L9_2 = "management.settings.doorbell.updated"
  L8_2 = L8_2(L9_2)
  L9_2 = "success"
  L6_2(L7_2, L8_2, L9_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "housing:updateAssistantZoneMessages"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = source
  L3_2 = GetIdentifier
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  if A0_2 then
    L4_2 = type
    L5_2 = A1_2
    L4_2 = L4_2(L5_2)
    if "boolean" == L4_2 then
      goto lbl_13
    end
  end
  do return end
  ::lbl_13::
  L4_2 = HouseOwnerIdentifierList
  L4_2 = L4_2[A0_2]
  if L4_2 ~= L3_2 then
    L4_2 = Notification
    L5_2 = L2_2
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "you_are_not_owner"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    L4_2(L5_2, L6_2, L7_2)
    return
  end
  L4_2 = Config
  L4_2 = L4_2.Houses
  L4_2 = L4_2[A0_2]
  if not L4_2 then
    return
  end
  L5_2 = MySQL
  L5_2 = L5_2.update
  L5_2 = L5_2.await
  L6_2 = "UPDATE houselocations SET assistantZoneMessagesEnabled = ? WHERE name = ?"
  L7_2 = {}
  if A1_2 then
    L8_2 = 1
    if L8_2 then
      goto lbl_44
    end
  end
  L8_2 = 0
  ::lbl_44::
  L9_2 = A0_2
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L5_2(L6_2, L7_2)
  L5_2 = Config
  L5_2 = L5_2.Houses
  L5_2 = L5_2[A0_2]
  L5_2.assistantZoneMessagesEnabled = A1_2
  L5_2 = TriggerClientEvent
  L6_2 = "housing:updateHouseData"
  L7_2 = -1
  L8_2 = A0_2
  L9_2 = "assistantZoneMessagesEnabled"
  L10_2 = A1_2
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "housing:server:removeHouseKey"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = source
  L3_2 = L1_1
  L4_2 = L2_2
  L5_2 = A0_2
  L6_2 = A1_2
  L3_2(L4_2, L5_2, L6_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "housing:server:giveHouseKey"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = source
  L3_2 = L0_1
  L4_2 = L2_2
  L5_2 = A0_2
  L6_2 = A1_2
  L3_2(L4_2, L5_2, L6_2)
end
L2_1(L3_1, L4_1)






