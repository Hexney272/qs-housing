RegisterNUICallback("creator_select_points", function(data, cb)
  creator:spawnTempEntities()
  local result = creator:raycastRectangle()
  creator:open()
  creator:destroyTempEntities()

  if not result then
    return cb(nil)
  end

  result.points = table.map(result.points, function(point)
    return {
      x = point.x,
      y = point.y,
      z = point.z
    }
  end)

  cb(result)
end)

RegisterNUICallback("select_house", function(data, cb)
  creator.raycast.island = data.island
  creator.raycast.houseObject = data.houseObject

  local hasZonePoints = data and data.zone and data.zone.points

  if hasZonePoints then
    creator.raycast.points = table.map(data.zone.points, function(point)
      return vec3(point.x, point.y, point.z)
    end)
    creator.raycast.height = data.zone.thickness
  else
    creator.raycast.points = {}
  end

  cb(true)
end)

RegisterNUICallback("select_point", function(data, cb)
  local hasModel = data and data.options and data.options.model

  if hasModel then
    if not IsModelInCdimage(data.options.model) then
      Notification(i18n.t("creator.raycast.model_is_not_valid", { model = data.options.model }), "error")
      return cb(nil)
    end
  end

  local pointType = (data and data.pointType) or "empty"
  local count = (data and data.count) or 1

  creator:spawnTempEntities()
  local result = creator:selectPoint(pointType, count, data and data.options)
  creator:open()
  creator:destroyTempEntities()

  if not result then
    return cb(nil)
  end

  local mapped = table.map(result, function(point)
    local entry = {
      x = point.x,
      y = point.y,
      z = point.z
    }
    if point.w then
      entry.w = point.w
    end
    return entry
  end)

  if 1 == count then
    cb(mapped[1])
    return
  end

  cb(mapped)
end)

RegisterNUICallback("select_entity", function(data, cb)
  local entityType = (data and data.entityType) or "object"
  local count = (data and data.count) or 1

  Debug("select_entity", data)

  creator:spawnTempEntities()
  local result = creator:selectEntity(entityType, count, data and data.options)
  creator:open()
  creator:destroyTempEntities()

  if not result then
    return cb(nil)
  end

  local mapped = table.map(result, function(entry)
    return {
      entity = entry.entity,
      coords = {
        x = entry.coords.x,
        y = entry.coords.y,
        z = entry.coords.z,
        w = entry.coords.w
      }
    }
  end)

  if 1 == count then
    cb(mapped[1])
    return
  end

  cb(mapped)
end)

RegisterNUICallback("create_house", function(data, cb)
  Debug("create_house", data)

  local name = data.name:lower():gsub("%s+", "_"):gsub("-", "_")
  data.name = name

  local apartmentCount = data.apartmentCount
  if 0 == apartmentCount or not apartmentCount then
    apartmentCount = nil
  end
  data.apartmentCount = apartmentCount

  data.coords.cam = {
    x = data.coords.enter.x,
    y = data.coords.enter.y,
    z = data.coords.enter.z,
    h = data.coords.enter.w,
    yaw = -10.0
  }

  data.coords.enter = {
    x = data.coords.enter.x,
    y = data.coords.enter.y,
    z = data.coords.enter.z,
    h = data.coords.enter.w
  }

  if data.coords.exit then
    data.coords.exit = {
      x = data.coords.exit.x,
      y = data.coords.exit.y,
      z = data.coords.exit.z,
      h = data.coords.exit.w
    }
  end

  if data.coords.shellCoords then
    local h = data.coords.shellCoords.w or data.coords.shellCoords.h
    data.coords.shellCoords = {
      x = data.coords.shellCoords.x,
      y = data.coords.shellCoords.y,
      z = data.coords.shellCoords.z,
      h = h
    }
  end

  local playerCoords = GetEntityCoords(cache.ped)
  local streetHash = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
  local streetName = GetStreetNameFromHashKey(streetHash)

  local result = lib.callback.await("housing:createHouse", false, streetName, data)
  cb(result)
end)

RegisterNUICallback("update_house", function(data, cb)
  data.coords.cam = {
    x = data.coords.enter.x,
    y = data.coords.enter.y,
    z = data.coords.enter.z,
    h = data.coords.enter.w,
    yaw = -10.0
  }

  data.coords.enter = {
    x = data.coords.enter.x,
    y = data.coords.enter.y,
    z = data.coords.enter.z,
    h = data.coords.enter.w
  }

  if data.coords.exit then
    data.coords.exit = {
      x = data.coords.exit.x,
      y = data.coords.exit.y,
      z = data.coords.exit.z,
      h = data.coords.exit.w
    }
  end

  if data.coords.shellCoords then
    local h = data.coords.shellCoords.w or data.coords.shellCoords.h
    data.coords.shellCoords = {
      x = data.coords.shellCoords.x,
      y = data.coords.shellCoords.y,
      z = data.coords.shellCoords.z,
      h = h
    }
  end

  local result = lib.callback.await("housing:updateHouse", false, data)

  if result then
    Notification(i18n.t("creator.house_updated"), "success")
  else
    Notification(i18n.t("creator.house_update_failed"), "error")
  end

  cb(result)
end)

RegisterNUICallback("remove_house", function(data, cb)
  local result = lib.callback.await("housing:removeHouse", false, data)
  cb(result)
end)

RegisterNUICallback("creator:remove_owner", function(data, cb)
  local result = lib.callback.await("housing:removeHouseOwner", false, data)
  cb(result)
end)

RegisterNUICallback("teleport_to_house", function(houseName, cb)
  local house = Config.Houses[houseName]

  if not house then
    Notification(i18n.t("house_not_found"), "error")
    return cb(false)
  end

  local hasPermission = lib.callback.await("housing:hasPermission", false, true)

  if not hasPermission then
    Notification(i18n.t("no_permission"), "error")
    return cb(false)
  end

  local enterCoords = house.coords.enter
  RequestCollisionAtCoord(enterCoords.x, enterCoords.y, enterCoords.z)
  SetEntityCoords(cache.ped, enterCoords.x, enterCoords.y, enterCoords.z, false, false, false, false)
  Notification(i18n.t("creator.teleported_to_house", { house = houseName }), "success")
  cb(true)
end)

RegisterNUICallback("creator_select_house_object", function(isIsland, cb)
  local options = nil
  if isIsland then
    options = {
      isIsland = true,
      camOffset = 20.0
    }
  end

  creator:spawnTempEntities()
  local tier, coords = RayCastSelector("customHouse", options)
  creator:destroyTempEntities()

  local key = isIsland and "island" or "houseObject"

  if not tier or not coords then
    creator.raycast[key] = nil
    creator:open()
    return cb(nil)
  end

  local model
  if isIsland then
    model = Config.Islands[tier].model
  else
    model = Config.HouseObjects[tier].model
  end

  creator.raycast[key] = {
    model = model,
    coords = {
      x = coords.x,
      y = coords.y,
      z = coords.z,
      w = coords.w
    }
  }

  creator:open()

  cb({
    model = model,
    coords = {
      x = coords.x,
      y = coords.y,
      z = coords.z,
      w = coords.w
    }
  })
end)

RegisterNUICallback("creator_select_mlo_doors", function(data, cb)
  creator:spawnTempEntities()
  local doors = RayCastGetMLO()
  creator:destroyTempEntities()

  if not doors then
    creator:open()
    return cb(nil)
  end

  creator:open()

  local mapped = table.map(doors, function(door)
    door.coords = {
      x = door.coords.x,
      y = door.coords.y,
      z = door.coords.z,
      w = door.coords.w
    }
    return door
  end)

  cb(mapped)
end)

RegisterNUICallback("creator_select_ipl", function(data, cb)
  creator:spawnTempEntities()
  local playerCoords = GetEntityCoords(cache.ped)
  CreatorStartedPosition = playerCoords

  local selectedIpl = showCaseOfIplHouse()
  creator:destroyTempEntities()

  if not selectedIpl then
    creator:open()
    return cb(nil)
  end

  local iplConfig = Config.IplData[selectedIpl]
  local exportFn = iplConfig and iplConfig.export

  if exportFn then
    exportFn = exportFn()
  end

  local result = {}
  result.houseName = selectedIpl
  result.exit = {
    x = iplConfig.exitCoords.x,
    y = iplConfig.exitCoords.y,
    z = iplConfig.exitCoords.z
  }
  result.theme = exportFn and exportFn.Style.Theme[iplConfig.defaultTheme]
  result.themes = iplConfig and iplConfig.themes
  result.stash = iplConfig and iplConfig.stash

  creator:open()
  cb(result)
end)

RegisterNUICallback("creator_select_shell", function(data, cb)
  creator:spawnTempEntities()
  local tier, coords = RayCastSelector("shell")
  creator:destroyTempEntities()

  if not tier or not coords then
    creator:open()
    return cb(nil)
  end

  creator:open()

  cb({
    tier = tier,
    coords = {
      x = coords.x,
      y = coords.y,
      z = coords.z,
      w = coords.w
    }
  })
end)

RegisterNUICallback("creator_select_exit_coords", function(data, cb)
  creator:spawnTempEntities()

  local shellCoords = vec4(data.coords.x, data.coords.y, data.coords.z, data.coords.w)
  local exitCoords = RayCastSelector("exit", { tier = data.tier, coords = shellCoords })

  creator:destroyTempEntities()

  if not exitCoords then
    creator:open()
    return cb(nil)
  end

  creator:open()

  cb({
    x = exitCoords.x,
    y = exitCoords.y,
    z = exitCoords.z,
    w = exitCoords.w
  })
end)

local function getGarageShellData()
  if "qs-advancedgarages" ~= Config.Garage then
    return {}
  end

  local shell = exports["qs-advancedgarages"]:ShowCaseOfGarageShell(nil, "vehicle")
  return { shell = shell }
end

exports("getGarageShell", getGarageShellData)

RegisterNUICallback("creator_select_garage", function(data, cb)
  creator:spawnTempEntities()

  local garageCoords = {
    x = data.coords.x,
    y = data.coords.y,
    z = data.coords.z,
    h = data.coords.w
  }

  local shellData = getGarageShellData()

  creator:destroyTempEntities()
  creator:open()

  cb({
    coords = garageCoords,
    shellData = shellData
  })
end)

RegisterNUICallback("create_furniture_shop", function(data, cb)
  Debug("create_furniture_shop", data)
  local result = lib.callback.await("housing:createFurnitureShop", false, data)
  cb(result)
end)

RegisterNUICallback("update_furniture_shop", function(data, cb)
  Debug("update_furniture_shop", data)
  local result = lib.callback.await("housing:updateFurnitureShop", false, data)
  cb(result)
end)

RegisterNUICallback("remove_furniture_shop", function(data, cb)
  Debug("remove_furniture_shop", data)
  local result = lib.callback.await("housing:removeFurnitureShop", false, data)
  cb(result)
end)

RegisterNUICallback("teleport_to_furniture_shop", function(shopId, cb)
  local shop = nil

  for _, furnitureShop in pairs(Config.FurnitureShops) do
    if furnitureShop.id == shopId then
      shop = furnitureShop
      break
    end
  end

  if not (shop and shop.enter) then
    local msg = i18n.t("creator.furniture_shop_creator.shop_not_found") or "Shop not found"
    Notification(msg, "error")
    return cb(false)
  end

  local hasPermission = lib.callback.await("housing:hasPermission", false, true)

  if not hasPermission then
    Notification(i18n.t("no_permission"), "error")
    return cb(false)
  end

  local enterCoords = shop.enter
  RequestCollisionAtCoord(enterCoords.x, enterCoords.y, enterCoords.z)
  SetEntityCoords(cache.ped, enterCoords.x, enterCoords.y, enterCoords.z, false, false, false, false)

  local msg = i18n.t("creator.furniture_shop_creator.teleported_to_shop", { name = shop.name }) or ("Teleported to " .. shop.name)
  Notification(msg, "success")
  cb(true)
end)

RegisterNUICallback("get_apartment_units", function(data, cb)
  local result = lib.callback.await("housing:getApartmentUnits", false, data)
  cb(result)
end)

RegisterNUICallback("change_apartment_shell", function(data, cb)
  creator:close()
  creator:spawnTempEntities()

  local tier, coords = RayCastSelector("shell")
  creator:destroyTempEntities()

  if not tier or not coords then
    creator:open()
    return cb(nil)
  end

  local msg = i18n.t("creator.raycast.select_exit") or "Select exit position inside the shell"
  Notification(msg, "info")

  local exitCoords = RayCastSelector("exit", { tier = tier, coords = coords })

  if not exitCoords then
    creator:open()
    return cb(nil)
  end

  local shellData = {
    tier = tier,
    shellCoords = {
      x = coords.x,
      y = coords.y,
      z = coords.z,
      h = coords.w
    },
    exit = {
      x = exitCoords.x,
      y = exitCoords.y,
      z = exitCoords.z,
      h = exitCoords.w
    }
  }

  local result = lib.callback.await("housing:updateApartmentShell", false, data.apartmentName, shellData)

  creator:open()

  if result then
    cb({ tier = tier })
  else
    cb(nil)
  end
end)

RegisterNUICallback("change_apartment_ipl", function(data, cb)
  creator:spawnTempEntities()

  local playerCoords = GetEntityCoords(cache.ped)
  CreatorStartedPosition = playerCoords

  local selectedIpl = showCaseOfIplHouse()
  creator:destroyTempEntities()

  if not selectedIpl then
    creator:open()
    return cb(nil)
  end

  local iplConfig = Config.IplData[selectedIpl]
  local exportFn = iplConfig and iplConfig.export

  if exportFn then
    exportFn = exportFn()
  end

  local result = {}
  result.houseName = selectedIpl
  result.exit = {
    x = iplConfig.exitCoords.x,
    y = iplConfig.exitCoords.y,
    z = iplConfig.exitCoords.z
  }

  if exportFn then
    result.theme = exportFn.Style.Theme[iplConfig.defaultTheme]
  else
    result.theme = nil
  end

  result.themes = iplConfig.themes
  result.stash = iplConfig.stash

  local updateResult = lib.callback.await("housing:updateApartmentIpl", false, data.apartmentName, result)

  creator:open()

  if updateResult then
    cb({ houseName = selectedIpl })
  else
    cb(nil)
  end
end)
