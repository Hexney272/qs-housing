





local L0_1, L1_1, L2_1, L3_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = Debug
  L3_2 = "isObjectValid"
  L4_2 = A0_2
  L5_2 = A1_2
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = joaat
  L3_2 = A0_2.object
  L2_2 = L2_2(L3_2)
  L3_2 = IsModelValid
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "furniture_creator.object_is_not_valid"
    L6_2 = {}
    L7_2 = A0_2.object
    L6_2.object = L7_2
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
    L3_2 = false
    return L3_2
  end
  if A1_2 then
    L3_2 = Config
    L3_2 = L3_2.Furniture
    L3_2 = L3_2[A1_2]
    if L3_2 then
      L3_2 = table
      L3_2 = L3_2.find
      L4_2 = Config
      L4_2 = L4_2.Furniture
      L4_2 = L4_2[A1_2]
      L4_2 = L4_2.items
      function L5_2(A0_3)
        local L1_3, L2_3
        L1_3 = A0_3.object
        L2_3 = A0_2.object
        L1_3 = L1_3 == L2_3
        return L1_3
      end
      L3_2 = L3_2(L4_2, L5_2)
      if L3_2 then
        L4_2 = L3_2.id
        L5_2 = A0_2.id
        if L4_2 ~= L5_2 then
          L4_2 = Notification
          L5_2 = i18n
          L5_2 = L5_2.t
          L6_2 = "furniture_creator.object_already_in_category"
          L7_2 = {}
          L8_2 = A0_2.object
          L7_2.object = L8_2
          L7_2.category = A1_2
          L5_2 = L5_2(L6_2, L7_2)
          L6_2 = "error"
          L4_2(L5_2, L6_2)
          L4_2 = false
          return L4_2
        end
      end
    end
  end
  L3_2 = true
  return L3_2
end
L1_1 = RegisterNUICallback
L2_1 = "create_furniture_item"
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = L0_1
  L3_2 = A0_2.item
  L4_2 = A0_2.category
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = false
    return L2_2(L3_2)
  end
  L2_2 = Debug
  L3_2 = "create_furniture_item"
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:createFurnitureItem"
  L4_2 = false
  L5_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  if L2_2 then
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "furniture_creator.item_created"
    L4_2 = L4_2(L5_2)
    L5_2 = "success"
    L3_2(L4_2, L5_2)
  else
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "furniture_creator.item_create_failed"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  end
  L3_2 = A1_2
  L4_2 = L2_2
  L3_2(L4_2)
end
L1_1(L2_1, L3_1)
L1_1 = RegisterNUICallback
L2_1 = "update_furniture_item"
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = L0_1
  L3_2 = A0_2.item
  L4_2 = A0_2.category
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = false
    return L2_2(L3_2)
  end
  L2_2 = Debug
  L3_2 = "update_furniture_item"
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:updateFurnitureItem"
  L4_2 = false
  L5_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  if L2_2 then
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "furniture_creator.item_updated"
    L4_2 = L4_2(L5_2)
    L5_2 = "success"
    L3_2(L4_2, L5_2)
  else
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "furniture_creator.item_update_failed"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  end
  L3_2 = A1_2
  L4_2 = L2_2
  L3_2(L4_2)
end
L1_1(L2_1, L3_1)
L1_1 = RegisterNUICallback
L2_1 = "remove_furniture_item"
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = Debug
  L3_2 = "remove_furniture_item"
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
  L2_2 = A0_2.id
  if not L2_2 then
    L2_2 = Notification
    L3_2 = i18n
    L3_2 = L3_2.t
    L4_2 = "furniture_creator.cannot_delete_config_item"
    L3_2 = L3_2(L4_2)
    L4_2 = "error"
    L2_2(L3_2, L4_2)
    L2_2 = A1_2
    L3_2 = false
    return L2_2(L3_2)
  end
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:removeFurnitureItem"
  L4_2 = false
  L5_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  if L2_2 then
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "furniture_creator.item_removed"
    L4_2 = L4_2(L5_2)
    L5_2 = "success"
    L3_2(L4_2, L5_2)
    L3_2 = furnitureCreator
    L4_2 = L3_2
    L3_2 = L3_2.updateUI
    L3_2(L4_2)
  else
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "furniture_creator.item_remove_failed"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  end
  L3_2 = A1_2
  L4_2 = L2_2
  L3_2(L4_2)
end
L1_1(L2_1, L3_1)
L1_1 = RegisterNetEvent
L2_1 = "housing:syncFurnitureItem"
function L3_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L3_2 = Debug
  L4_2 = "housing:syncFurnitureItem"
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = A2_2.object
  if not L7_2 then
    L7_2 = A2_2
  end
  L3_2(L4_2, L5_2, L6_2, L7_2)
  if "create" == A0_2 then
    L3_2 = Config
    L3_2 = L3_2.Furniture
    L3_2 = L3_2[A1_2]
    if not L3_2 then
      L3_2 = Error
      L4_2 = "housing:syncFurnitureItem"
      L5_2 = "Category not found"
      L6_2 = A1_2
      L3_2(L4_2, L5_2, L6_2)
      return
    end
    L3_2 = table
    L3_2 = L3_2.insert
    L4_2 = Config
    L4_2 = L4_2.Furniture
    L4_2 = L4_2[A1_2]
    L4_2 = L4_2.items
    L5_2 = A2_2
    L3_2(L4_2, L5_2)
  elseif "update" == A0_2 then
    L3_2 = Config
    L3_2 = L3_2.Furniture
    L3_2 = L3_2[A1_2]
    if L3_2 then
      L3_2 = pairs
      L4_2 = Config
      L4_2 = L4_2.Furniture
      L4_2 = L4_2[A1_2]
      L4_2 = L4_2.items
      L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
      for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
        L9_2 = L8_2.id
        L10_2 = A2_2.id
        if L9_2 == L10_2 then
          L9_2 = Config
          L9_2 = L9_2.Furniture
          L9_2 = L9_2[A1_2]
          L9_2 = L9_2.items
          L9_2[L7_2] = A2_2
          break
        end
      end
    end
  elseif "delete" == A0_2 then
    L3_2 = Config
    L3_2 = L3_2.Furniture
    L3_2 = L3_2[A1_2]
    if L3_2 then
      L3_2 = Config
      L3_2 = L3_2.Furniture
      L3_2 = L3_2[A1_2]
      L4_2 = table
      L4_2 = L4_2.filter
      L5_2 = Config
      L5_2 = L5_2.Furniture
      L5_2 = L5_2[A1_2]
      L5_2 = L5_2.items
      function L6_2(A0_3)
        local L1_3, L2_3
        L1_3 = A0_3.id
        L2_3 = A2_2.id
        L1_3 = L1_3 ~= L2_3
        return L1_3
      end
      L4_2 = L4_2(L5_2, L6_2)
      L3_2.items = L4_2
    end
  end
  L3_2 = furnitureCreator
  L4_2 = L3_2
  L3_2 = L3_2.updateUI
  L3_2(L4_2)
  L3_2 = InitializeFurnitures
  L3_2()
  L3_2 = Debug
  L4_2 = "Config.Furniture updated:"
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = A2_2.object
  if not L7_2 then
    L7_2 = A2_2
  end
  L3_2(L4_2, L5_2, L6_2, L7_2)
end
L1_1(L2_1, L3_1)
L1_1 = RegisterNUICallback
L2_1 = "furniture_take_screenshot"
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  if not A0_2 then
    L2_2 = Notification
    L3_2 = i18n
    L3_2 = L3_2.t
    L4_2 = "furniture_creator.object_required"
    L3_2 = L3_2(L4_2)
    L4_2 = "error"
    L2_2(L3_2, L4_2)
    L2_2 = furnitureCreator
    L3_2 = L2_2
    L2_2 = L2_2.open
    L2_2(L3_2)
    L2_2 = A1_2
    L3_2 = nil
    return L2_2(L3_2)
  end
  L2_2 = joaat
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = IsModelValid
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "furniture_creator.object_is_not_valid"
    L6_2 = {}
    L6_2.object = A0_2
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
    L3_2 = furnitureCreator
    L4_2 = L3_2
    L3_2 = L3_2.open
    L3_2(L4_2)
    L3_2 = A1_2
    L4_2 = nil
    return L3_2(L4_2)
  end
  L3_2 = furnitureCreator
  L4_2 = L3_2
  L3_2 = L3_2.takeObjectScreenshot
  L5_2 = A0_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = furnitureCreator
  L5_2 = L4_2
  L4_2 = L4_2.open
  L4_2(L5_2)
  L4_2 = A1_2
  L5_2 = L3_2
  L4_2(L5_2)
end
L1_1(L2_1, L3_1)






