





local L0_1, L1_1
L0_1 = db
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L3_2 = GetIdentifier
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L4_2 = Error
    L5_2 = "db.createHouse"
    L6_2 = "Player does not have an identifier"
    L4_2(L5_2, L6_2)
    L4_2 = false
    return L4_2
  end
  L4_2 = assert
  L5_2 = A2_2
  L6_2 = "db.createHouse data must be provided"
  L4_2(L5_2, L6_2)
  L4_2 = assert
  L5_2 = L3_2
  L6_2 = "db.createHouse identifier is nil"
  L4_2(L5_2, L6_2)
  L4_2 = [[
		INSERT INTO houselocations
		(name, label, coords, blip, owned, price, board, defaultPrice, tier, creator, creatorJob, apartmentCount, mlo, ipl, garage, garageShell, paymentMethod, photos, description, hideFromBrowser, assistantZoneMessagesEnabled, allowPlantInside, allowPlantOutside)
		VALUES
		(@name, @label, @coords, @blip, @owner, @price, @board, @defaultPrice, @tier, @creator, @creatorJob, @apartmentCount, @mlo, @ipl, @garage, @garageShell, @paymentMethod, @photos, @description, @hideFromBrowser, @assistantZoneMessagesEnabled, @allowPlantInside, @allowPlantOutside)
	]]
  L5_2 = {}
  L6_2 = A2_2.apartmentCount
  if L6_2 then
    L6_2 = 0
    if L6_2 then
      goto lbl_30
    end
  end
  L6_2 = 1
  ::lbl_30::
  L7_2 = A2_2.apartmentCount
  if not L7_2 then
    L7_2 = 1
  end
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = A2_2.apartmentCount
    if L10_2 then
      L10_2 = "%s-apt-%s"
      L11_2 = L10_2
      L10_2 = L10_2.format
      L12_2 = A2_2.name
      L13_2 = L9_2
      L10_2 = L10_2(L11_2, L12_2, L13_2)
      if L10_2 then
        goto lbl_47
      end
    end
    L10_2 = A2_2.name
    ::lbl_47::
    L11_2 = A2_2.apartmentCount
    if L11_2 then
      L12_2 = L10_2
      L11_2 = L10_2.match
      L13_2 = "apt%-%d+"
      L11_2 = L11_2(L12_2, L13_2)
    end
    L12_2 = table
    L12_2 = L12_2.insert
    L13_2 = L5_2
    L14_2 = L10_2
    L12_2(L13_2, L14_2)
    L12_2 = MySQL
    L12_2 = L12_2.insert
    L12_2 = L12_2.await
    L13_2 = L4_2
    L14_2 = {}
    L14_2["@name"] = L10_2
    L15_2 = A2_2.address
    L14_2["@label"] = L15_2
    L15_2 = json
    L15_2 = L15_2.encode
    L16_2 = A2_2.coords
    L15_2 = L15_2(L16_2)
    L14_2["@coords"] = L15_2
    L15_2 = A2_2.blip
    if L15_2 then
      L15_2 = json
      L15_2 = L15_2.encode
      L16_2 = A2_2.blip
      L15_2 = L15_2(L16_2)
      if L15_2 then
        goto lbl_82
      end
    end
    L15_2 = nil
    ::lbl_82::
    L14_2["@blip"] = L15_2
    L14_2["@owned"] = 0
    L15_2 = A2_2.price
    L14_2["@price"] = L15_2
    L15_2 = A2_2.price
    L14_2["@defaultPrice"] = L15_2
    L15_2 = A2_2.tier
    L14_2["@tier"] = L15_2
    L14_2["@creator"] = L3_2
    L15_2 = json
    L15_2 = L15_2.encode
    L16_2 = A2_2.ipl
    L15_2 = L15_2(L16_2)
    L14_2["@ipl"] = L15_2
    L15_2 = json
    L15_2 = L15_2.encode
    L16_2 = A2_2.board
    L15_2 = L15_2(L16_2)
    L14_2["@board"] = L15_2
    L15_2 = json
    L15_2 = L15_2.encode
    L16_2 = A2_2.mlo
    L15_2 = L15_2(L16_2)
    L14_2["@mlo"] = L15_2
    L14_2["@creatorJob"] = A1_2
    L15_2 = A2_2.apartmentCount
    if not L15_2 then
      L15_2 = 0
    end
    L14_2["@apartmentCount"] = L15_2
    L15_2 = A2_2.garage
    if L15_2 then
      L15_2 = json
      L15_2 = L15_2.encode
      L16_2 = A2_2.garage
      L15_2 = L15_2(L16_2)
    end
    L14_2["@garage"] = L15_2
    L15_2 = A2_2.garageShell
    if L15_2 then
      L15_2 = json
      L15_2 = L15_2.encode
      L16_2 = A2_2.garageShell
      L15_2 = L15_2(L16_2)
    end
    L14_2["@garageShell"] = L15_2
    L15_2 = A2_2.paymentMethod
    L14_2["@paymentMethod"] = L15_2
    L15_2 = A2_2.photos
    if L15_2 then
      L15_2 = json
      L15_2 = L15_2.encode
      L16_2 = A2_2.photos
      L15_2 = L15_2(L16_2)
      if L15_2 then
        goto lbl_140
      end
    end
    L15_2 = nil
    ::lbl_140::
    L14_2["@photos"] = L15_2
    L15_2 = A2_2.description
    if not L15_2 then
      L15_2 = ""
    end
    L14_2["@description"] = L15_2
    L15_2 = A2_2.hideFromBrowser
    if L15_2 then
      L15_2 = 1
      if L15_2 then
        goto lbl_153
      end
    end
    L15_2 = 0
    ::lbl_153::
    L14_2["@hideFromBrowser"] = L15_2
    L14_2["@assistantZoneMessagesEnabled"] = 1
    L15_2 = A2_2.allowPlantInside
    if false ~= L15_2 then
      L15_2 = 1
      if L15_2 then
        goto lbl_162
      end
    end
    L15_2 = 0
    ::lbl_162::
    L14_2["@allowPlantInside"] = L15_2
    L15_2 = A2_2.allowPlantOutside
    if false ~= L15_2 then
      L15_2 = 1
      if L15_2 then
        goto lbl_170
      end
    end
    L15_2 = 0
    ::lbl_170::
    L14_2["@allowPlantOutside"] = L15_2
    L12_2 = L12_2(L13_2, L14_2)
    L13_2 = Config
    L13_2 = L13_2.Houses
    L14_2 = {}
    L14_2.id = L12_2
    L15_2 = A2_2.coords
    L14_2.coords = L15_2
    L14_2.owned = false
    L15_2 = A2_2.price
    L14_2.price = L15_2
    L14_2.locked = true
    L15_2 = A2_2.address
    L14_2.address = L15_2
    L15_2 = A2_2.tier
    L14_2.tier = L15_2
    L15_2 = A2_2.garage
    L14_2.garage = L15_2
    L15_2 = A2_2.garageShell
    L14_2.garageShell = L15_2
    L15_2 = A2_2.ipl
    L14_2.ipl = L15_2
    L14_2.creator = L3_2
    L15_2 = A2_2.board
    L14_2.board = L15_2
    L15_2 = A2_2.mlo
    if not L15_2 then
      L15_2 = nil
    end
    L14_2.mlo = L15_2
    L14_2.creatorJob = A1_2
    L15_2 = A2_2.blip
    L14_2.blip = L15_2
    L14_2.apartmentNumber = L11_2
    L15_2 = A2_2.name
    L14_2.apartmentName = L15_2
    L15_2 = A2_2.apartmentCount
    L14_2.apartmentCount = L15_2
    L15_2 = A2_2.paymentMethod
    L14_2.paymentMethod = L15_2
    L15_2 = A2_2.photos
    if not L15_2 then
      L15_2 = {}
    end
    L14_2.photos = L15_2
    L15_2 = A2_2.description
    if not L15_2 then
      L15_2 = ""
    end
    L14_2.description = L15_2
    L15_2 = A2_2.hideFromBrowser
    if not L15_2 then
      L15_2 = false
    end
    L14_2.hideFromBrowser = L15_2
    L14_2.assistantZoneMessagesEnabled = true
    L15_2 = A2_2.allowPlantInside
    L15_2 = false ~= L15_2
    L14_2.allowPlantInside = L15_2
    L15_2 = A2_2.allowPlantOutside
    L15_2 = false ~= L15_2
    L14_2.allowPlantOutside = L15_2
    L13_2[L10_2] = L14_2
  end
  L6_2 = TriggerClientEvent
  L7_2 = "housing:setHouse"
  L8_2 = -1
  L9_2 = L5_2
  L10_2 = Config
  L10_2 = L10_2.Houses
  L11_2 = L5_2[1]
  L10_2 = L10_2[L11_2]
  L6_2(L7_2, L8_2, L9_2, L10_2)
  L6_2 = A2_2.sellType
  if "rentable" == L6_2 then
    L6_2 = A2_2.apartmentCount
    if L6_2 then
      L6_2 = BuyWholeApartment
      L7_2 = A0_2
      L8_2 = L5_2[1]
      L9_2 = A2_2.price
      L6_2(L7_2, L8_2, L9_2)
    else
      L6_2 = BuyHouse
      L7_2 = A0_2
      L8_2 = A2_2.name
      L9_2 = nil
      L10_2 = true
      L6_2(L7_2, L8_2, L9_2, L10_2)
    end
  end
  L6_2 = A2_2.garage
  if L6_2 then
    L6_2 = {}
    L7_2 = A2_2.address
    L6_2.label = L7_2
    L7_2 = A2_2.garage
    L6_2.takeVehicle = L7_2
    L7_2 = A2_2.garageShell
    L6_2.shell = L7_2
    L7_2 = TriggerAddHouseGarage
    L8_2 = A2_2.name
    L9_2 = L6_2
    L7_2(L8_2, L9_2)
    L7_2 = HouseGarages
    L8_2 = A2_2.name
    L7_2[L8_2] = L6_2
  end
  L6_2 = SendLog
  L7_2 = DiscordWebhook
  L8_2 = {}
  L8_2.title = "House Created"
  L8_2.description = "A new house has been created"
  L9_2 = {}
  L10_2 = {}
  L10_2.name = "Creator"
  L11_2 = GetPlayerName
  L12_2 = A0_2
  L11_2 = L11_2(L12_2)
  L10_2.value = L11_2
  L10_2.inline = true
  L11_2 = {}
  L11_2.name = "House Name"
  L12_2 = A2_2.name
  L11_2.value = L12_2
  L11_2.inline = true
  L12_2 = {}
  L12_2.name = "Price"
  L13_2 = A2_2.price
  L12_2.value = L13_2
  L12_2.inline = true
  L13_2 = {}
  L13_2.name = "Tier"
  L14_2 = A2_2.tier
  L13_2.value = L14_2
  L13_2.inline = true
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  L9_2[4] = L13_2
  L8_2.fields = L9_2
  L9_2 = WebhookColor
  L8_2.color = L9_2
  L6_2(L7_2, L8_2)
  L6_2 = Debug
  L7_2 = "db.createHouse"
  L8_2 = "Inserted"
  L9_2 = L5_2
  L10_2 = "Identifier"
  L11_2 = L3_2
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  L6_2 = true
  return L6_2
end
L0_1.createHouse = L1_1
L0_1 = db
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L2_2 = GetIdentifier
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L3_2 = Error
    L4_2 = "db.updateHouse"
    L5_2 = "Player does not have an identifier"
    L3_2(L4_2, L5_2)
    L3_2 = false
    return L3_2
  end
  L3_2 = assert
  L4_2 = A1_2
  L5_2 = "db.updateHouse data must be provided"
  L3_2(L4_2, L5_2)
  L3_2 = assert
  L4_2 = L2_2
  L5_2 = "db.updateHouse identifier is nil"
  L3_2(L4_2, L5_2)
  L3_2 = MySQL
  L3_2 = L3_2.update
  L3_2 = L3_2.await
  L4_2 = "UPDATE houselocations SET coords = ?, blip = ?, price = ?, board = ?, defaultPrice = ?, tier = ?, mlo = ?, ipl = ?, garage = ?, garageShell = ?, paymentMethod = ?, photos = ?, description = ?, hideFromBrowser = ?, allowPlantInside = ?, allowPlantOutside = ? WHERE name = ?"
  L5_2 = {}
  L6_2 = json
  L6_2 = L6_2.encode
  L7_2 = A1_2.coords
  L6_2 = L6_2(L7_2)
  L7_2 = A1_2.blip
  if L7_2 then
    L7_2 = json
    L7_2 = L7_2.encode
    L8_2 = A1_2.blip
    L7_2 = L7_2(L8_2)
    if L7_2 then
      goto lbl_40
    end
  end
  L7_2 = nil
  ::lbl_40::
  L8_2 = A1_2.price
  L9_2 = A1_2.board
  if L9_2 then
    L9_2 = json
    L9_2 = L9_2.encode
    L10_2 = A1_2.board
    L9_2 = L9_2(L10_2)
    if L9_2 then
      goto lbl_51
    end
  end
  L9_2 = nil
  ::lbl_51::
  L10_2 = A1_2.price
  L11_2 = A1_2.tier
  L12_2 = A1_2.mlo
  if L12_2 then
    L12_2 = json
    L12_2 = L12_2.encode
    L13_2 = A1_2.mlo
    L12_2 = L12_2(L13_2)
    if L12_2 then
      goto lbl_63
    end
  end
  L12_2 = nil
  ::lbl_63::
  L13_2 = A1_2.ipl
  if L13_2 then
    L13_2 = json
    L13_2 = L13_2.encode
    L14_2 = A1_2.ipl
    L13_2 = L13_2(L14_2)
    if L13_2 then
      goto lbl_73
    end
  end
  L13_2 = nil
  ::lbl_73::
  L14_2 = A1_2.garage
  if L14_2 then
    L14_2 = json
    L14_2 = L14_2.encode
    L15_2 = A1_2.garage
    L14_2 = L14_2(L15_2)
    if L14_2 then
      goto lbl_83
    end
  end
  L14_2 = nil
  ::lbl_83::
  L15_2 = A1_2.garageShell
  if L15_2 then
    L15_2 = json
    L15_2 = L15_2.encode
    L16_2 = A1_2.garageShell
    L15_2 = L15_2(L16_2)
    if L15_2 then
      goto lbl_93
    end
  end
  L15_2 = nil
  ::lbl_93::
  L16_2 = A1_2.paymentMethod
  L17_2 = A1_2.photos
  if L17_2 then
    L17_2 = json
    L17_2 = L17_2.encode
    L18_2 = A1_2.photos
    L17_2 = L17_2(L18_2)
    if L17_2 then
      goto lbl_104
    end
  end
  L17_2 = nil
  ::lbl_104::
  L18_2 = A1_2.description
  if not L18_2 then
    L18_2 = ""
  end
  L19_2 = A1_2.hideFromBrowser
  if L19_2 then
    L19_2 = 1
    if L19_2 then
      goto lbl_115
    end
  end
  L19_2 = 0
  ::lbl_115::
  L20_2 = A1_2.allowPlantInside
  if false ~= L20_2 then
    L20_2 = 1
    if L20_2 then
      goto lbl_122
    end
  end
  L20_2 = 0
  ::lbl_122::
  L21_2 = A1_2.allowPlantOutside
  if false ~= L21_2 then
    L21_2 = 1
    if L21_2 then
      goto lbl_129
    end
  end
  L21_2 = 0
  ::lbl_129::
  L22_2 = A1_2.name
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L5_2[3] = L8_2
  L5_2[4] = L9_2
  L5_2[5] = L10_2
  L5_2[6] = L11_2
  L5_2[7] = L12_2
  L5_2[8] = L13_2
  L5_2[9] = L14_2
  L5_2[10] = L15_2
  L5_2[11] = L16_2
  L5_2[12] = L17_2
  L5_2[13] = L18_2
  L5_2[14] = L19_2
  L5_2[15] = L20_2
  L5_2[16] = L21_2
  L5_2[17] = L22_2
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = A1_2.name
    L4_2 = L4_2[L5_2]
    L5_2 = A1_2.coords
    L4_2.coords = L5_2
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = A1_2.name
    L4_2 = L4_2[L5_2]
    L5_2 = A1_2.price
    L4_2.price = L5_2
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = A1_2.name
    L4_2 = L4_2[L5_2]
    L5_2 = A1_2.tier
    L4_2.tier = L5_2
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = A1_2.name
    L4_2 = L4_2[L5_2]
    L5_2 = A1_2.ipl
    L4_2.ipl = L5_2
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = A1_2.name
    L4_2 = L4_2[L5_2]
    L5_2 = A1_2.board
    L4_2.board = L5_2
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = A1_2.name
    L4_2 = L4_2[L5_2]
    L5_2 = A1_2.mlo
    L4_2.mlo = L5_2
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = A1_2.name
    L4_2 = L4_2[L5_2]
    L5_2 = A1_2.blip
    L4_2.blip = L5_2
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = A1_2.name
    L4_2 = L4_2[L5_2]
    L5_2 = A1_2.paymentMethod
    L4_2.paymentMethod = L5_2
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = A1_2.name
    L4_2 = L4_2[L5_2]
    L5_2 = A1_2.photos
    if not L5_2 then
      L5_2 = {}
    end
    L4_2.photos = L5_2
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = A1_2.name
    L4_2 = L4_2[L5_2]
    L5_2 = A1_2.description
    if not L5_2 then
      L5_2 = ""
    end
    L4_2.description = L5_2
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = A1_2.name
    L4_2 = L4_2[L5_2]
    L5_2 = A1_2.hideFromBrowser
    if not L5_2 then
      L5_2 = false
    end
    L4_2.hideFromBrowser = L5_2
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = A1_2.name
    L4_2 = L4_2[L5_2]
    L5_2 = A1_2.allowPlantInside
    L5_2 = false ~= L5_2
    L4_2.allowPlantInside = L5_2
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = A1_2.name
    L4_2 = L4_2[L5_2]
    L5_2 = A1_2.allowPlantOutside
    L5_2 = false ~= L5_2
    L4_2.allowPlantOutside = L5_2
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = A1_2.name
    L4_2 = L4_2[L5_2]
    L4_2 = L4_2.garage
    if L4_2 then
      L4_2 = A1_2.garage
      if L4_2 then
        L4_2 = HouseGarages
        L5_2 = A1_2.name
        L6_2 = {}
        L7_2 = A1_2.address
        L6_2.label = L7_2
        L7_2 = A1_2.garage
        L6_2.takeVehicle = L7_2
        L7_2 = A1_2.garageShell
        L6_2.shell = L7_2
        L4_2[L5_2] = L6_2
        L4_2 = TriggerHouseUpdateGarage
        L5_2 = HouseGarages
        L4_2(L5_2)
    end
    else
      L4_2 = Config
      L4_2 = L4_2.Houses
      L5_2 = A1_2.name
      L4_2 = L4_2[L5_2]
      L4_2 = L4_2.garage
      if L4_2 then
        L4_2 = A1_2.garage
        if not L4_2 then
          L4_2 = HouseGarages
          L5_2 = A1_2.name
          L4_2[L5_2] = nil
          L4_2 = TriggerHouseRemoveGarage
          L5_2 = A1_2.name
          L4_2(L5_2)
      end
      else
        L4_2 = A1_2.garage
        if L4_2 then
          L4_2 = Config
          L4_2 = L4_2.Houses
          L5_2 = A1_2.name
          L4_2 = L4_2[L5_2]
          L4_2 = L4_2.garage
          if not L4_2 then
            L4_2 = {}
            L5_2 = A1_2.address
            L4_2.label = L5_2
            L5_2 = A1_2.garage
            L4_2.takeVehicle = L5_2
            L5_2 = A1_2.garageShell
            L4_2.shell = L5_2
            L5_2 = TriggerAddHouseGarage
            L6_2 = A1_2.name
            L7_2 = L4_2
            L5_2(L6_2, L7_2)
            L5_2 = HouseGarages
            L6_2 = A1_2.name
            L5_2[L6_2] = L4_2
          end
        end
      end
    end
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = A1_2.name
    L4_2 = L4_2[L5_2]
    L5_2 = A1_2.garage
    L4_2.garage = L5_2
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = A1_2.name
    L4_2 = L4_2[L5_2]
    L5_2 = A1_2.garageShell
    L4_2.garageShell = L5_2
    L4_2 = TriggerClientEvent
    L5_2 = "housing:setHouse"
    L6_2 = -1
    L7_2 = A1_2.name
    L8_2 = Config
    L8_2 = L8_2.Houses
    L9_2 = A1_2.name
    L8_2 = L8_2[L9_2]
    L4_2(L5_2, L6_2, L7_2, L8_2)
    L4_2 = TriggerEvent
    L5_2 = "housing:syncIkeaDeliveryPoint"
    L6_2 = A1_2.name
    L7_2 = A1_2.coords
    if L7_2 then
      L7_2 = A1_2.coords
      L7_2 = L7_2.delivery
      if L7_2 then
        goto lbl_329
      end
    end
    L7_2 = nil
    ::lbl_329::
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = A1_2.coords
    if L4_2 then
      L4_2 = A1_2.coords
      L4_2 = L4_2.delivery
      if L4_2 then
        L4_2 = TriggerClientEvent
        L5_2 = "qb-houses:client:refreshLocations"
        L6_2 = -1
        L7_2 = A1_2.name
        L8_2 = json
        L8_2 = L8_2.encode
        L9_2 = A1_2.coords
        L9_2 = L9_2.delivery
        L8_2 = L8_2(L9_2)
        L9_2 = 8
        L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
      end
    end
    L4_2 = SendLog
    L5_2 = DiscordWebhook
    L6_2 = {}
    L6_2.title = "House Updated"
    L6_2.description = "A house has been updated"
    L7_2 = {}
    L8_2 = {}
    L8_2.name = "Updater"
    L9_2 = GetPlayerName
    L10_2 = A0_2
    L9_2 = L9_2(L10_2)
    L8_2.value = L9_2
    L8_2.inline = true
    L9_2 = {}
    L9_2.name = "House Name"
    L10_2 = A1_2.name
    L9_2.value = L10_2
    L9_2.inline = true
    L10_2 = {}
    L10_2.name = "Price"
    L11_2 = A1_2.price
    L10_2.value = L11_2
    L10_2.inline = true
    L11_2 = {}
    L11_2.name = "Tier"
    L12_2 = A1_2.tier
    L11_2.value = L12_2
    L11_2.inline = true
    L7_2[1] = L8_2
    L7_2[2] = L9_2
    L7_2[3] = L10_2
    L7_2[4] = L11_2
    L6_2.fields = L7_2
    L7_2 = WebhookColor
    L6_2.color = L7_2
    L4_2(L5_2, L6_2)
    L4_2 = Debug
    L5_2 = "db.updateHouse"
    L6_2 = "Updated"
    L7_2 = A1_2.name
    L8_2 = "Identifier"
    L9_2 = L2_2
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
    L4_2 = true
    return L4_2
  end
  L4_2 = false
  return L4_2
end
L0_1.updateHouse = L1_1
L0_1 = db
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = assert
  L2_2 = A0_2
  L3_2 = "db.removeGarage garage is nil"
  L1_2(L2_2, L3_2)
  L1_2 = "DELETE FROM player_garages WHERE name = ?"
  L2_2 = MySQL
  L2_2 = L2_2.update
  L2_2 = L2_2.await
  L3_2 = L1_2
  L4_2 = {}
  L5_2 = A0_2
  L4_2[1] = L5_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = Debug
  L4_2 = "db.removeGarage"
  L5_2 = "Deleted"
  L6_2 = L2_2
  L7_2 = "Garage"
  L8_2 = A0_2
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  return L2_2
end
L0_1.removeGarage = L1_1
L0_1 = db
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = assert
  L2_2 = A0_2
  L3_2 = "db.getApartmentUnits baseName is nil"
  L1_2(L2_2, L3_2)
  L1_2 = {}
  L2_2 = pairs
  L3_2 = Config
  L3_2 = L3_2.Houses
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = L7_2.apartmentName
    if L8_2 == A0_2 then
      L8_2 = L7_2.apartmentNumber
      if L8_2 then
        L8_2 = table
        L8_2 = L8_2.insert
        L9_2 = L1_2
        L10_2 = {}
        L11_2 = L7_2.id
        L10_2.id = L11_2
        L10_2.name = L6_2
        L11_2 = L7_2.apartmentNumber
        L10_2.apartmentNumber = L11_2
        L11_2 = L7_2.tier
        L10_2.tier = L11_2
        L11_2 = L7_2.coords
        L10_2.coords = L11_2
        L11_2 = L7_2.ipl
        L10_2.ipl = L11_2
        L11_2 = L7_2.owned
        L10_2.owned = L11_2
        L11_2 = L7_2.price
        L10_2.price = L11_2
        L8_2(L9_2, L10_2)
      end
    end
  end
  L2_2 = table
  L2_2 = L2_2.sort
  L3_2 = L1_2
  function L4_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3
    L2_3 = tonumber
    L3_3 = A0_3.apartmentNumber
    L4_3 = L3_3
    L3_3 = L3_3.match
    L5_3 = "%d+"
    L3_3, L4_3, L5_3, L6_3 = L3_3(L4_3, L5_3)
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
    if not L2_3 then
      L2_3 = 0
    end
    L3_3 = tonumber
    L4_3 = A1_3.apartmentNumber
    L5_3 = L4_3
    L4_3 = L4_3.match
    L6_3 = "%d+"
    L4_3, L5_3, L6_3 = L4_3(L5_3, L6_3)
    L3_3 = L3_3(L4_3, L5_3, L6_3)
    if not L3_3 then
      L3_3 = 0
    end
    L4_3 = L2_3 < L3_3
    return L4_3
  end
  L2_2(L3_2, L4_2)
  L2_2 = Debug
  L3_2 = "db.getApartmentUnits"
  L4_2 = "Found"
  L5_2 = #L1_2
  L6_2 = "units for"
  L7_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  return L1_2
end
L0_1.getApartmentUnits = L1_1
L0_1 = db
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = assert
  L3_2 = A0_2
  L4_2 = "db.updateApartmentShell apartmentName is nil"
  L2_2(L3_2, L4_2)
  L2_2 = assert
  L3_2 = A1_2
  L4_2 = "db.updateApartmentShell shellData is nil"
  L2_2(L3_2, L4_2)
  L2_2 = assert
  L3_2 = A1_2.tier
  L4_2 = "db.updateApartmentShell shellData.tier is nil"
  L2_2(L3_2, L4_2)
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A0_2]
  if not L2_2 then
    L3_2 = Debug
    L4_2 = "db.updateApartmentShell"
    L5_2 = "House not found"
    L6_2 = A0_2
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = false
    return L3_2
  end
  L3_2 = L2_2.coords
  L4_2 = A1_2.shellCoords
  L3_2.shellCoords = L4_2
  L4_2 = A1_2.exit
  L3_2.exit = L4_2
  L4_2 = MySQL
  L4_2 = L4_2.update
  L4_2 = L4_2.await
  L5_2 = "UPDATE houselocations SET tier = ?, coords = ? WHERE name = ?"
  L6_2 = {}
  L7_2 = A1_2.tier
  L8_2 = json
  L8_2 = L8_2.encode
  L9_2 = L3_2
  L8_2 = L8_2(L9_2)
  L9_2 = A0_2
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L6_2[3] = L9_2
  L4_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L5_2 = Config
    L5_2 = L5_2.Houses
    L5_2 = L5_2[A0_2]
    L6_2 = A1_2.tier
    L5_2.tier = L6_2
    L5_2 = Config
    L5_2 = L5_2.Houses
    L5_2 = L5_2[A0_2]
    L5_2.coords = L3_2
    L5_2 = TriggerClientEvent
    L6_2 = "housing:setHouse"
    L7_2 = -1
    L8_2 = A0_2
    L9_2 = Config
    L9_2 = L9_2.Houses
    L9_2 = L9_2[A0_2]
    L5_2(L6_2, L7_2, L8_2, L9_2)
    L5_2 = Debug
    L6_2 = "db.updateApartmentShell"
    L7_2 = "Updated"
    L8_2 = A0_2
    L9_2 = "tier"
    L10_2 = A1_2.tier
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
    L5_2 = true
    return L5_2
  end
  L5_2 = false
  return L5_2
end
L0_1.updateApartmentShell = L1_1
L0_1 = db
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = assert
  L3_2 = A0_2
  L4_2 = "db.updateApartmentIpl apartmentName is nil"
  L2_2(L3_2, L4_2)
  L2_2 = assert
  L3_2 = A1_2
  L4_2 = "db.updateApartmentIpl iplData is nil"
  L2_2(L3_2, L4_2)
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A0_2]
  if not L2_2 then
    L3_2 = Debug
    L4_2 = "db.updateApartmentIpl"
    L5_2 = "House not found"
    L6_2 = A0_2
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = false
    return L3_2
  end
  L3_2 = MySQL
  L3_2 = L3_2.update
  L3_2 = L3_2.await
  L4_2 = "UPDATE houselocations SET ipl = ? WHERE name = ?"
  L5_2 = {}
  L6_2 = json
  L6_2 = L6_2.encode
  L7_2 = A1_2
  L6_2 = L6_2(L7_2)
  L7_2 = A0_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L4_2 = Config
    L4_2 = L4_2.Houses
    L4_2 = L4_2[A0_2]
    L4_2.ipl = A1_2
    L4_2 = TriggerClientEvent
    L5_2 = "housing:setHouse"
    L6_2 = -1
    L7_2 = A0_2
    L8_2 = Config
    L8_2 = L8_2.Houses
    L8_2 = L8_2[A0_2]
    L4_2(L5_2, L6_2, L7_2, L8_2)
    L4_2 = Debug
    L5_2 = "db.updateApartmentIpl"
    L6_2 = "Updated"
    L7_2 = A0_2
    L8_2 = "ipl"
    L9_2 = A1_2
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
    L4_2 = true
    return L4_2
  end
  L4_2 = false
  return L4_2
end
L0_1.updateApartmentIpl = L1_1






