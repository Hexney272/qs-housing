local function hasCreatorPermission(source)
  local jobName = GetJobName(source)
  local jobGrade = GetJobGrade(source)
  local isAdmin = PlayerIsAdmin(source)

  if isAdmin then
    if Config.AllowAdminsToCreateHouses then
      return true
    end
  end

  for _, creatorJob in pairs(Config.CreatorJobs) do
    if creatorJob.job == jobName then
      if creatorJob.grade then
        if not table.contains(creatorJob.grade, jobGrade) then
          goto continue
        end
      end
      return true
    end
    ::continue::
  end

  return false
end

lib.callback.register("housing:createFurnitureItem", function(source, data)
  if not hasCreatorPermission(source) then
    Error("housing:createFurnitureItem", "Player does not have permission")
    return false
  end

  local insertId = db.createFurnitureItem(source, data)
  if not insertId then
    Error("housing:createFurnitureItem", "Failed to create furniture item")
    return false
  end

  local category = data.category
  local item = data.item
  item.creator = true
  item.id = insertId
  item.key = category

  local categoryData = Config.Furniture[category]
  if not categoryData then
    local label = category:gsub("_", " ")
    label = label:gsub("(%a)([%w_']*)", function(first, rest)
      return first:upper() .. rest:lower()
    end)

    Config.Furniture[category] = {
      dynamic = false,
      items = {},
      img = "",
      navigation = 999,
      dynamicIcon = "",
      label = label,
      css = {
        width = 100,
        height = 100,
        top = 0,
        left = 0,
        zIndex = 1,
      },
    }
  end

  table.insert(Config.Furniture[category].items, item)
  TriggerClientEvent("housing:syncFurnitureItem", -1, "create", category, item)
  Debug("Furniture item created:", category, item.object)

  return true
end)

lib.callback.register("housing:updateFurnitureItem", function(source, data)
  if not hasCreatorPermission(source) then
    Error("housing:updateFurnitureItem", "Player does not have permission")
    return false
  end

  local category = data.category
  local item = data.item
  local itemId = item.id

  if not itemId then
    Debug("No ID found, inserting as new item", item.object)

    local insertId = db.createFurnitureItem(source, data)
    if not insertId then
      Error("housing:updateFurnitureItem", "Failed to insert new furniture item")
      return false
    end

    item.id = insertId
    item.creator = true
    item.key = category

    local categoryData = Config.Furniture[category]
    if not categoryData then
      local label = category:gsub("_", " ")
      label = label:gsub("(%a)([%w_']*)", function(first, rest)
        return first:upper() .. rest:lower()
      end)

      Config.Furniture[category] = {
        dynamic = false,
        items = {},
        img = "",
        navigation = 999,
        dynamicIcon = "",
        label = label,
        css = {
          width = 100,
          height = 100,
          top = 0,
          left = 0,
          zIndex = 1,
        },
      }
    end

    table.insert(Config.Furniture[category].items, item)
    TriggerClientEvent("housing:syncFurnitureItem", -1, "create", category, item)
    Debug("Config item converted to database item:", category, item.object, "ID:", insertId)

    return true
  end

  local success = db.updateFurnitureItem(source, data)
  if not success then
    Error("housing:updateFurnitureItem", "Failed to update furniture item")
    return false
  end

  item.creator = true
  item.key = category

  local categoryData = Config.Furniture[category]
  if categoryData then
    for i, existingItem in ipairs(Config.Furniture[category].items) do
      if existingItem.id == item.id then
        Config.Furniture[category].items[i] = item
        break
      end
    end
  end

  TriggerClientEvent("housing:syncFurnitureItem", -1, "update", category, item)
  Debug("Furniture item updated:", category, item.object, "ID:", item.id)

  return true
end)

lib.callback.register("housing:removeFurnitureItem", function(source, data)
  if not hasCreatorPermission(source) then
    Error("housing:removeFurnitureItem", "Player does not have permission")
    return false
  end

  assert(data.id, "housing:removeFurnitureItem id is required")

  local success = db.removeFurnitureItem(data.id, source)
  if not success then
    Error("housing:removeFurnitureItem", "Failed to remove furniture item")
    return false
  end

  local categoryData = Config.Furniture[data.category]
  if categoryData then
    for i, existingItem in ipairs(Config.Furniture[data.category].items) do
      if existingItem.id == data.id then
        table.remove(Config.Furniture[data.category].items, i)
        break
      end
    end
  end

  TriggerClientEvent("housing:syncFurnitureItem", -1, "delete", data.category, { id = data.id })
  Debug("Furniture item removed:", "ID:", data.id)

  return true
end)

exports("AddFurniture", function(category, item)
  local categoryData = Config.Furniture[category]
  if not categoryData then
    Error("AddFurniture", "Category does not exist in furniture settings:", category)
    return false
  end

  table.insert(Config.Furniture[category].items, item)
  TriggerClientEvent("housing:syncFurnitureItem", -1, "create", category, item)
  Debug("AddFurniture: added item to", category, item.object or item)

  return true
end)

CreateThread(function()
  Wait(1000)

  local mergedData = db.getMergedFurnitureData()

  for categoryKey, categoryData in pairs(mergedData) do
    local existingCategory = Config.Furniture[categoryKey]
    if not existingCategory then
      Config.Furniture[categoryKey] = categoryData
    else
      for _, dbItem in ipairs(categoryData.items) do
        if dbItem.creator then
          local found = false
          for i, configItem in ipairs(Config.Furniture[categoryKey].items) do
            if configItem.object == dbItem.object then
              Config.Furniture[categoryKey].items[i] = dbItem
              found = true
              break
            end
          end
          if not found then
            table.insert(Config.Furniture[categoryKey].items, dbItem)
          end
        end
      end
    end
  end

  Info("Furniture Creator initialized:", #db.getFurnitureItems(), "custom items loaded")
end)
