db.createHouse = function(source, creatorJob, data)
  local identifier = GetIdentifier(source)
  if not identifier then
    Error("db.createHouse", "Player does not have an identifier")
    return false
  end

  assert(data, "db.createHouse data must be provided")
  assert(identifier, "db.createHouse identifier is nil")

  local query = [[
		INSERT INTO houselocations
		(name, label, coords, blip, owned, price, board, defaultPrice, tier, creator, creatorJob, apartmentCount, mlo, ipl, garage, garageShell, paymentMethod, photos, description, hideFromBrowser, allowPlantInside, allowPlantOutside)
		VALUES
		(@name, @label, @coords, @blip, @owned, @price, @board, @defaultPrice, @tier, @creator, @creatorJob, @apartmentCount, @mlo, @ipl, @garage, @garageShell, @paymentMethod, @photos, @description, @hideFromBrowser, @allowPlantInside, @allowPlantOutside)
	]]

  local createdNames = {}
  local startIndex = data.apartmentCount and 0 or 1
  local endIndex = data.apartmentCount or 1

  for i = startIndex, endIndex, 1 do
    local houseName = (data.apartmentCount and ("%s-apt-%s"):format(data.name, i)) or data.name
    local apartmentNumber = data.apartmentCount and houseName:match("apt%-%d+")

    table.insert(createdNames, houseName)

    local insertId = MySQL.insert.await(query, {
      ["@name"] = houseName,
      ["@label"] = data.address,
      ["@coords"] = json.encode(data.coords),
      ["@blip"] = (data.blip and json.encode(data.blip)) or nil,
      ["@owned"] = 0,
      ["@price"] = data.price,
      ["@defaultPrice"] = data.price,
      ["@tier"] = data.tier,
      ["@creator"] = identifier,
      ["@ipl"] = json.encode(data.ipl),
      ["@board"] = json.encode(data.board),
      ["@mlo"] = json.encode(data.mlo),
      ["@creatorJob"] = creatorJob,
      ["@apartmentCount"] = data.apartmentCount or 0,
      ["@garage"] = data.garage and json.encode(data.garage),
      ["@garageShell"] = data.garageShell and json.encode(data.garageShell),
      ["@paymentMethod"] = data.paymentMethod,
      ["@photos"] = (data.photos and json.encode(data.photos)) or nil,
      ["@description"] = data.description or "",
      ["@hideFromBrowser"] = data.hideFromBrowser and 1 or 0,
      ["@allowPlantInside"] = (false ~= data.allowPlantInside) and 1 or 0,
      ["@allowPlantOutside"] = (false ~= data.allowPlantOutside) and 1 or 0,
    })

    Config.Houses[houseName] = {
      id = insertId,
      coords = data.coords,
      owned = false,
      price = data.price,
      locked = true,
      address = data.address,
      tier = data.tier,
      garage = data.garage,
      garageShell = data.garageShell,
      ipl = data.ipl,
      creator = identifier,
      board = data.board,
      mlo = data.mlo or nil,
      creatorJob = creatorJob,
      blip = data.blip,
      apartmentNumber = apartmentNumber,
      apartmentName = data.name,
      apartmentCount = data.apartmentCount,
      paymentMethod = data.paymentMethod,
      photos = data.photos or {},
      description = data.description or "",
      hideFromBrowser = data.hideFromBrowser or false,
      assistantZoneMessagesEnabled = true,
      allowPlantInside = false ~= data.allowPlantInside,
      allowPlantOutside = false ~= data.allowPlantOutside,
    }
  end

  TriggerClientEvent("housing:setHouse", -1, createdNames, Config.Houses[createdNames[1]])

  if "rentable" == data.sellType then
    if data.apartmentCount then
      BuyWholeApartment(source, createdNames[1], data.price)
    else
      BuyHouse(source, data.name, nil, true)
    end
  end

  if data.garage then
    local garageData = {
      label = data.address,
      takeVehicle = data.garage,
      shell = data.garageShell,
    }
    TriggerAddHouseGarage(data.name, garageData)
    HouseGarages[data.name] = garageData
  end

  SendLog(DiscordWebhook, {
    title = "House Created",
    description = "A new house has been created",
    fields = {
      { name = "Creator", value = GetPlayerName(source), inline = true },
      { name = "House Name", value = data.name, inline = true },
      { name = "Price", value = data.price, inline = true },
      { name = "Tier", value = data.tier, inline = true },
    },
    color = WebhookColor,
  })

  Debug("db.createHouse", "Inserted", createdNames, "Identifier", identifier)
  return true
end

db.updateHouse = function(source, data)
  local identifier = GetIdentifier(source)
  if not identifier then
    Error("db.updateHouse", "Player does not have an identifier")
    return false
  end

  assert(data, "db.updateHouse data must be provided")
  assert(identifier, "db.updateHouse identifier is nil")

  local coordsEncoded = json.encode(data.coords)
  local blipEncoded = (data.blip and json.encode(data.blip)) or nil
  local price = data.price
  local boardEncoded = (data.board and json.encode(data.board)) or nil
  local defaultPrice = data.price
  local tier = data.tier
  local mloEncoded = (data.mlo and json.encode(data.mlo)) or nil
  local iplEncoded = (data.ipl and json.encode(data.ipl)) or nil
  local garageEncoded = (data.garage and json.encode(data.garage)) or nil
  local garageShellEncoded = (data.garageShell and json.encode(data.garageShell)) or nil
  local paymentMethod = data.paymentMethod
  local photosEncoded = (data.photos and json.encode(data.photos)) or nil
  local description = data.description or ""
  local hideFromBrowser = data.hideFromBrowser and 1 or 0
  local allowPlantInside = (false ~= data.allowPlantInside) and 1 or 0
  local allowPlantOutside = (false ~= data.allowPlantOutside) and 1 or 0
  local houseName = data.name

  local affectedRows = MySQL.update.await(
    "UPDATE houselocations SET coords = ?, blip = ?, price = ?, board = ?, defaultPrice = ?, tier = ?, mlo = ?, ipl = ?, garage = ?, garageShell = ?, paymentMethod = ?, photos = ?, description = ?, hideFromBrowser = ?, allowPlantInside = ?, allowPlantOutside = ? WHERE name = ?",
    { coordsEncoded, blipEncoded, price, boardEncoded, defaultPrice, tier, mloEncoded, iplEncoded, garageEncoded, garageShellEncoded, paymentMethod, photosEncoded, description, hideFromBrowser, allowPlantInside, allowPlantOutside, houseName }
  )

  if affectedRows then
    Config.Houses[data.name].coords = data.coords
    Config.Houses[data.name].price = data.price
    Config.Houses[data.name].tier = data.tier
    Config.Houses[data.name].ipl = data.ipl
    Config.Houses[data.name].board = data.board
    Config.Houses[data.name].mlo = data.mlo
    Config.Houses[data.name].blip = data.blip
    Config.Houses[data.name].paymentMethod = data.paymentMethod
    Config.Houses[data.name].photos = data.photos or {}
    Config.Houses[data.name].description = data.description or ""
    Config.Houses[data.name].hideFromBrowser = data.hideFromBrowser or false
    Config.Houses[data.name].allowPlantInside = false ~= data.allowPlantInside
    Config.Houses[data.name].allowPlantOutside = false ~= data.allowPlantOutside

    -- Handle garage updates
    if Config.Houses[data.name].garage then
      if data.garage then
        HouseGarages[data.name] = {
          label = data.address,
          takeVehicle = data.garage,
          shell = data.garageShell,
        }
        TriggerHouseUpdateGarage(HouseGarages)
      end
    else
      if Config.Houses[data.name].garage then
        if not data.garage then
          HouseGarages[data.name] = nil
          TriggerHouseRemoveGarage(data.name)
        end
      else
        if data.garage then
          if not Config.Houses[data.name].garage then
            local garageData = {
              label = data.address,
              takeVehicle = data.garage,
              shell = data.garageShell,
            }
            TriggerAddHouseGarage(data.name, garageData)
            HouseGarages[data.name] = garageData
          end
        end
      end
    end

    Config.Houses[data.name].garage = data.garage
    Config.Houses[data.name].garageShell = data.garageShell

    TriggerClientEvent("housing:setHouse", -1, data.name, Config.Houses[data.name])

    TriggerEvent("housing:syncIkeaDeliveryPoint", data.name, (data.coords and data.coords.delivery) or nil)

    if data.coords and data.coords.delivery then
      TriggerClientEvent("qb-houses:client:refreshLocations", -1, data.name, json.encode(data.coords.delivery), 8)
    end

    SendLog(DiscordWebhook, {
      title = "House Updated",
      description = "A house has been updated",
      fields = {
        { name = "Updater", value = GetPlayerName(source), inline = true },
        { name = "House Name", value = data.name, inline = true },
        { name = "Price", value = data.price, inline = true },
        { name = "Tier", value = data.tier, inline = true },
      },
      color = WebhookColor,
    })

    Debug("db.updateHouse", "Updated", data.name, "Identifier", identifier)
    return true
  end

  return false
end

db.removeGarage = function(garageName)
  assert(garageName, "db.removeGarage garage is nil")

  local query = "DELETE FROM player_garages WHERE name = ?"
  local result = MySQL.update.await(query, { garageName })

  Debug("db.removeGarage", "Deleted", result, "Garage", garageName)
  return result
end

db.getApartmentUnits = function(baseName)
  assert(baseName, "db.getApartmentUnits baseName is nil")

  local units = {}

  for name, house in pairs(Config.Houses) do
    if house.apartmentName == baseName then
      if house.apartmentNumber then
        table.insert(units, {
          id = house.id,
          name = name,
          apartmentNumber = house.apartmentNumber,
          tier = house.tier,
          coords = house.coords,
          ipl = house.ipl,
          owned = house.owned,
          price = house.price,
        })
      end
    end
  end

  table.sort(units, function(a, b)
    local numA = tonumber(a.apartmentNumber:match("%d+"))
    if not numA then
      numA = 0
    end
    local numB = tonumber(b.apartmentNumber:match("%d+"))
    if not numB then
      numB = 0
    end
    return numA < numB
  end)

  Debug("db.getApartmentUnits", "Found", #units, "units for", baseName)
  return units
end

db.updateApartmentShell = function(apartmentName, shellData)
  assert(apartmentName, "db.updateApartmentShell apartmentName is nil")
  assert(shellData, "db.updateApartmentShell shellData is nil")
  assert(shellData.tier, "db.updateApartmentShell shellData.tier is nil")

  local house = Config.Houses[apartmentName]
  if not house then
    Debug("db.updateApartmentShell", "House not found", apartmentName)
    return false
  end

  local coords = house.coords
  coords.shellCoords = shellData.shellCoords
  coords.exit = shellData.exit

  local affectedRows = MySQL.update.await(
    "UPDATE houselocations SET tier = ?, coords = ? WHERE name = ?",
    { shellData.tier, json.encode(coords), apartmentName }
  )

  if affectedRows then
    Config.Houses[apartmentName].tier = shellData.tier
    Config.Houses[apartmentName].coords = coords
    TriggerClientEvent("housing:setHouse", -1, apartmentName, Config.Houses[apartmentName])
    Debug("db.updateApartmentShell", "Updated", apartmentName, "tier", shellData.tier)
    return true
  end

  return false
end

db.updateApartmentIpl = function(apartmentName, iplData)
  assert(apartmentName, "db.updateApartmentIpl apartmentName is nil")
  assert(iplData, "db.updateApartmentIpl iplData is nil")

  local house = Config.Houses[apartmentName]
  if not house then
    Debug("db.updateApartmentIpl", "House not found", apartmentName)
    return false
  end

  local affectedRows = MySQL.update.await(
    "UPDATE houselocations SET ipl = ? WHERE name = ?",
    { json.encode(iplData), apartmentName }
  )

  if affectedRows then
    Config.Houses[apartmentName].ipl = iplData
    TriggerClientEvent("housing:setHouse", -1, apartmentName, Config.Houses[apartmentName])
    Debug("db.updateApartmentIpl", "Updated", apartmentName, "ipl", iplData)
    return true
  end

  return false
end
