





local L0_1, L1_1, L2_1, L3_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = GetJobName
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = GetJobGrade
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = PlayerIsAdmin
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L4_2 = Config
    L4_2 = L4_2.AllowAdminsToCreateHouses
    if L4_2 then
      L4_2 = true
      return L4_2
    end
  end
  L4_2 = pairs
  L5_2 = Config
  L5_2 = L5_2.CreatorJobs
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = L9_2.job
    if L10_2 == L1_2 then
      L10_2 = L9_2.grade
      if L10_2 then
        L10_2 = table
        L10_2 = L10_2.contains
        L11_2 = L9_2.grade
        L12_2 = L2_2
        L10_2 = L10_2(L11_2, L12_2)
        if not L10_2 then
          goto lbl_38
        end
      end
      L10_2 = true
      return L10_2
    end
    ::lbl_38::
  end
  L4_2 = false
  return L4_2
end
L1_1 = lib
L1_1 = L1_1.callback
L1_1 = L1_1.register
L2_1 = "housing:createFurnitureItem"
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = L0_1
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = Error
    L3_2 = "housing:createFurnitureItem"
    L4_2 = "Player does not have permission"
    L2_2(L3_2, L4_2)
    L2_2 = false
    return L2_2
  end
  L2_2 = db
  L2_2 = L2_2.createFurnitureItem
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L3_2 = Error
    L4_2 = "housing:createFurnitureItem"
    L5_2 = "Failed to create furniture item"
    L3_2(L4_2, L5_2)
    L3_2 = false
    return L3_2
  end
  L3_2 = A1_2.category
  L4_2 = A1_2.item
  L4_2.creator = true
  L4_2.id = L2_2
  L4_2.key = L3_2
  L5_2 = Config
  L5_2 = L5_2.Furniture
  L5_2 = L5_2[L3_2]
  if not L5_2 then
    L5_2 = Config
    L5_2 = L5_2.Furniture
    L6_2 = {}
    L6_2.dynamic = false
    L7_2 = {}
    L6_2.items = L7_2
    L6_2.img = ""
    L6_2.navigation = 999
    L6_2.dynamicIcon = ""
    L8_2 = L3_2
    L7_2 = L3_2.gsub
    L9_2 = "_"
    L10_2 = " "
    L7_2 = L7_2(L8_2, L9_2, L10_2)
    L8_2 = L7_2
    L7_2 = L7_2.gsub
    L9_2 = "(%a)([%w_']*)"
    function L10_2(A0_3, A1_3)
      local L2_3, L3_3, L4_3
      L3_3 = A0_3
      L2_3 = A0_3.upper
      L2_3 = L2_3(L3_3)
      L4_3 = A1_3
      L3_3 = A1_3.lower
      L3_3 = L3_3(L4_3)
      L2_3 = L2_3 .. L3_3
      return L2_3
    end
    L7_2 = L7_2(L8_2, L9_2, L10_2)
    L6_2.label = L7_2
    L7_2 = {}
    L7_2.width = 100
    L7_2.height = 100
    L7_2.top = 0
    L7_2.left = 0
    L7_2.zIndex = 1
    L6_2.css = L7_2
    L5_2[L3_2] = L6_2
  end
  L5_2 = table
  L5_2 = L5_2.insert
  L6_2 = Config
  L6_2 = L6_2.Furniture
  L6_2 = L6_2[L3_2]
  L6_2 = L6_2.items
  L7_2 = L4_2
  L5_2(L6_2, L7_2)
  L5_2 = TriggerClientEvent
  L6_2 = "housing:syncFurnitureItem"
  L7_2 = -1
  L8_2 = "create"
  L9_2 = L3_2
  L10_2 = L4_2
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = Debug
  L6_2 = "Furniture item created:"
  L7_2 = L3_2
  L8_2 = L4_2.object
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = true
  return L5_2
end
L1_1(L2_1, L3_1)
L1_1 = lib
L1_1 = L1_1.callback
L1_1 = L1_1.register
L2_1 = "housing:updateFurnitureItem"
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L2_2 = L0_1
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = Error
    L3_2 = "housing:updateFurnitureItem"
    L4_2 = "Player does not have permission"
    L2_2(L3_2, L4_2)
    L2_2 = false
    return L2_2
  end
  L2_2 = A1_2.category
  L3_2 = A1_2.item
  L4_2 = L3_2.id
  if not L4_2 then
    L4_2 = Debug
    L5_2 = "No ID found, inserting as new item"
    L6_2 = L3_2.object
    L4_2(L5_2, L6_2)
    L4_2 = db
    L4_2 = L4_2.createFurnitureItem
    L5_2 = A0_2
    L6_2 = A1_2
    L4_2 = L4_2(L5_2, L6_2)
    if not L4_2 then
      L5_2 = Error
      L6_2 = "housing:updateFurnitureItem"
      L7_2 = "Failed to insert new furniture item"
      L5_2(L6_2, L7_2)
      L5_2 = false
      return L5_2
    end
    L3_2.id = L4_2
    L3_2.creator = true
    L3_2.key = L2_2
    L5_2 = Config
    L5_2 = L5_2.Furniture
    L5_2 = L5_2[L2_2]
    if not L5_2 then
      L5_2 = Config
      L5_2 = L5_2.Furniture
      L6_2 = {}
      L6_2.dynamic = false
      L7_2 = {}
      L6_2.items = L7_2
      L6_2.img = ""
      L6_2.navigation = 999
      L6_2.dynamicIcon = ""
      L8_2 = L2_2
      L7_2 = L2_2.gsub
      L9_2 = "_"
      L10_2 = " "
      L7_2 = L7_2(L8_2, L9_2, L10_2)
      L8_2 = L7_2
      L7_2 = L7_2.gsub
      L9_2 = "(%a)([%w_']*)"
      function L10_2(A0_3, A1_3)
        local L2_3, L3_3, L4_3
        L3_3 = A0_3
        L2_3 = A0_3.upper
        L2_3 = L2_3(L3_3)
        L4_3 = A1_3
        L3_3 = A1_3.lower
        L3_3 = L3_3(L4_3)
        L2_3 = L2_3 .. L3_3
        return L2_3
      end
      L7_2 = L7_2(L8_2, L9_2, L10_2)
      L6_2.label = L7_2
      L7_2 = {}
      L7_2.width = 100
      L7_2.height = 100
      L7_2.top = 0
      L7_2.left = 0
      L7_2.zIndex = 1
      L6_2.css = L7_2
      L5_2[L2_2] = L6_2
    end
    L5_2 = table
    L5_2 = L5_2.insert
    L6_2 = Config
    L6_2 = L6_2.Furniture
    L6_2 = L6_2[L2_2]
    L6_2 = L6_2.items
    L7_2 = L3_2
    L5_2(L6_2, L7_2)
    L5_2 = TriggerClientEvent
    L6_2 = "housing:syncFurnitureItem"
    L7_2 = -1
    L8_2 = "create"
    L9_2 = L2_2
    L10_2 = L3_2
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
    L5_2 = Debug
    L6_2 = "Config item converted to database item:"
    L7_2 = L2_2
    L8_2 = L3_2.object
    L9_2 = "ID:"
    L10_2 = L4_2
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
    L5_2 = true
    return L5_2
  end
  L4_2 = db
  L4_2 = L4_2.updateFurnitureItem
  L5_2 = A0_2
  L6_2 = A1_2
  L4_2 = L4_2(L5_2, L6_2)
  if not L4_2 then
    L5_2 = Error
    L6_2 = "housing:updateFurnitureItem"
    L7_2 = "Failed to update furniture item"
    L5_2(L6_2, L7_2)
    L5_2 = false
    return L5_2
  end
  L3_2.creator = true
  L3_2.key = L2_2
  L5_2 = Config
  L5_2 = L5_2.Furniture
  L5_2 = L5_2[L2_2]
  if L5_2 then
    L5_2 = ipairs
    L6_2 = Config
    L6_2 = L6_2.Furniture
    L6_2 = L6_2[L2_2]
    L6_2 = L6_2.items
    L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
    for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
      L11_2 = L10_2.id
      L12_2 = L3_2.id
      if L11_2 == L12_2 then
        L11_2 = Config
        L11_2 = L11_2.Furniture
        L11_2 = L11_2[L2_2]
        L11_2 = L11_2.items
        L11_2[L9_2] = L3_2
        break
      end
    end
  end
  L5_2 = TriggerClientEvent
  L6_2 = "housing:syncFurnitureItem"
  L7_2 = -1
  L8_2 = "update"
  L9_2 = L2_2
  L10_2 = L3_2
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = Debug
  L6_2 = "Furniture item updated:"
  L7_2 = L2_2
  L8_2 = L3_2.object
  L9_2 = "ID:"
  L10_2 = L3_2.id
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = true
  return L5_2
end
L1_1(L2_1, L3_1)
L1_1 = lib
L1_1 = L1_1.callback
L1_1 = L1_1.register
L2_1 = "housing:removeFurnitureItem"
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = L0_1
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = Error
    L3_2 = "housing:removeFurnitureItem"
    L4_2 = "Player does not have permission"
    L2_2(L3_2, L4_2)
    L2_2 = false
    return L2_2
  end
  L2_2 = assert
  L3_2 = A1_2.id
  L4_2 = "housing:removeFurnitureItem id is required"
  L2_2(L3_2, L4_2)
  L2_2 = db
  L2_2 = L2_2.removeFurnitureItem
  L3_2 = A1_2.id
  L4_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L3_2 = Error
    L4_2 = "housing:removeFurnitureItem"
    L5_2 = "Failed to remove furniture item"
    L3_2(L4_2, L5_2)
    L3_2 = false
    return L3_2
  end
  L3_2 = Config
  L3_2 = L3_2.Furniture
  L4_2 = A1_2.category
  L3_2 = L3_2[L4_2]
  if L3_2 then
    L3_2 = ipairs
    L4_2 = Config
    L4_2 = L4_2.Furniture
    L5_2 = A1_2.category
    L4_2 = L4_2[L5_2]
    L4_2 = L4_2.items
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = L8_2.id
      L10_2 = A1_2.id
      if L9_2 == L10_2 then
        L9_2 = table
        L9_2 = L9_2.remove
        L10_2 = Config
        L10_2 = L10_2.Furniture
        L11_2 = A1_2.category
        L10_2 = L10_2[L11_2]
        L10_2 = L10_2.items
        L11_2 = L7_2
        L9_2(L10_2, L11_2)
        break
      end
    end
  end
  L3_2 = TriggerClientEvent
  L4_2 = "housing:syncFurnitureItem"
  L5_2 = -1
  L6_2 = "delete"
  L7_2 = A1_2.category
  L8_2 = {}
  L9_2 = A1_2.id
  L8_2.id = L9_2
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = Debug
  L4_2 = "Furniture item removed:"
  L5_2 = "ID:"
  L6_2 = A1_2.id
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = true
  return L3_2
end
L1_1(L2_1, L3_1)
L1_1 = exports
L2_1 = "AddFurniture"
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = Config
  L2_2 = L2_2.Furniture
  L2_2 = L2_2[A0_2]
  if not L2_2 then
    L2_2 = Error
    L3_2 = "AddFurniture"
    L4_2 = "Category does not exist in furniture settings:"
    L5_2 = A0_2
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = false
    return L2_2
  end
  L2_2 = table
  L2_2 = L2_2.insert
  L3_2 = Config
  L3_2 = L3_2.Furniture
  L3_2 = L3_2[A0_2]
  L3_2 = L3_2.items
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
  L2_2 = TriggerClientEvent
  L3_2 = "housing:syncFurnitureItem"
  L4_2 = -1
  L5_2 = "create"
  L6_2 = A0_2
  L7_2 = A1_2
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = Debug
  L3_2 = "AddFurniture: added item to"
  L4_2 = A0_2
  L5_2 = A1_2.object
  if not L5_2 then
    L5_2 = A1_2
  end
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = true
  return L2_2
end
L1_1(L2_1, L3_1)
L1_1 = CreateThread
function L2_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L0_2 = Wait
  L1_2 = 1000
  L0_2(L1_2)
  L0_2 = db
  L0_2 = L0_2.getMergedFurnitureData
  L0_2 = L0_2()
  L1_2 = pairs
  L2_2 = L0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = Config
    L7_2 = L7_2.Furniture
    L7_2 = L7_2[L5_2]
    if not L7_2 then
      L7_2 = Config
      L7_2 = L7_2.Furniture
      L7_2[L5_2] = L6_2
    else
      L7_2 = ipairs
      L8_2 = L6_2.items
      L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
      for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
        L13_2 = L12_2.creator
        if L13_2 then
          L13_2 = false
          L14_2 = ipairs
          L15_2 = Config
          L15_2 = L15_2.Furniture
          L15_2 = L15_2[L5_2]
          L15_2 = L15_2.items
          L14_2, L15_2, L16_2, L17_2 = L14_2(L15_2)
          for L18_2, L19_2 in L14_2, L15_2, L16_2, L17_2 do
            L20_2 = L19_2.object
            L21_2 = L12_2.object
            if L20_2 == L21_2 then
              L20_2 = Config
              L20_2 = L20_2.Furniture
              L20_2 = L20_2[L5_2]
              L20_2 = L20_2.items
              L20_2[L18_2] = L12_2
              L13_2 = true
              break
            end
          end
          if not L13_2 then
            L14_2 = table
            L14_2 = L14_2.insert
            L15_2 = Config
            L15_2 = L15_2.Furniture
            L15_2 = L15_2[L5_2]
            L15_2 = L15_2.items
            L16_2 = L12_2
            L14_2(L15_2, L16_2)
          end
        end
      end
    end
  end
  L1_2 = Info
  L2_2 = "Furniture Creator initialized:"
  L3_2 = db
  L3_2 = L3_2.getFurnitureItems
  L3_2 = L3_2()
  L3_2 = #L3_2
  L4_2 = "custom items loaded"
  L1_2(L2_2, L3_2, L4_2)
end
L1_1(L2_1)






