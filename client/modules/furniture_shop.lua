





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1
L0_1 = nil
L1_1 = nil
L2_1 = nil
L3_1 = nil
L4_1 = nil
L5_1 = false
L6_1 = {}
function L7_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = pairs
  L1_2 = L6_1
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = RemoveBlip
    L7_2 = L5_2
    L6_2(L7_2)
  end
  L0_2 = {}
  L6_1 = L0_2
  L0_2 = pairs
  L1_2 = Config
  L1_2 = L1_2.FurnitureShops
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = L5_2.blip
    if L6_2 then
      L6_2 = L5_2.blip
      L6_2 = L6_2.active
      if L6_2 then
        L6_2 = L5_2.blip
        L7_2 = Utils
        L7_2 = L7_2.CreateBlip
        L8_2 = {}
        L9_2 = L5_2.enter
        L8_2.location = L9_2
        L9_2 = L6_2.sprite
        L8_2.sprite = L9_2
        L9_2 = L6_2.color
        L8_2.color = L9_2
        L9_2 = L6_2.label
        L8_2.label = L9_2
        L9_2 = L6_2.scale
        L8_2.scale = L9_2
        L9_2 = L6_2.label
        L8_2.text = L9_2
        L8_2.shortRange = true
        L7_2 = L7_2(L8_2)
        L8_2 = L6_1
        L8_2 = #L8_2
        L9_2 = L8_2 + 1
        L8_2 = L6_1
        L8_2[L9_2] = L7_2
      end
    end
  end
end
L8_1 = CreateThread
function L9_1()
  local L0_2, L1_2
  L0_2 = L7_1
  L0_2()
end
L8_1(L9_1)
L8_1 = RegisterNetEvent
L9_1 = "housing:syncFurnitureShops"
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = Config
  L2_2 = A0_2 or L2_2
  if not A0_2 then
    L2_2 = {}
  end
  L1_2.FurnitureShops = L2_2
  L1_2 = L7_1
  L1_2()
  L1_2 = Debug
  L2_2 = "housing:syncFurnitureShops"
  L3_2 = "Synced"
  L4_2 = Config
  L4_2 = L4_2.FurnitureShops
  L4_2 = #L4_2
  L5_2 = "shops"
  L1_2(L2_2, L3_2, L4_2, L5_2)
end
L8_1(L9_1, L10_1)
function L8_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = L1_1
  if L0_2 then
    L0_2 = DeleteObject
    L1_2 = L1_1
    L0_2(L1_2)
    L0_2 = nil
    L1_1 = L0_2
  end
  L0_2 = L0_1
  if L0_2 then
    L0_2 = RenderScriptCams
    L1_2 = false
    L2_2 = false
    L3_2 = 0
    L4_2 = true
    L5_2 = true
    L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
    L0_2 = SetCamActive
    L1_2 = L0_1
    L2_2 = false
    L0_2(L1_2, L2_2)
    L0_2 = DestroyCam
    L1_2 = L0_1
    L2_2 = false
    L0_2(L1_2, L2_2)
    L0_2 = nil
    L0_1 = L0_2
  end
  L0_2 = nil
  L2_1 = L0_2
  L0_2 = nil
  L3_1 = L0_2
  L0_2 = nil
  L4_1 = L0_2
  L0_2 = false
  L5_1 = L0_2
  L0_2 = ToggleHud
  L1_2 = true
  L0_2(L1_2)
  L0_2 = SetNuiFocus
  L1_2 = false
  L2_2 = false
  L0_2(L1_2, L2_2)
end
function L9_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = TriggerServerCallbackSync
  L2_2 = "qb-houses:server:getPlayerHouses"
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L2_2 = #L1_2
    if 0 ~= L2_2 then
      L2_2 = table
      L2_2 = L2_2.find
      L3_2 = L1_2
      function L4_2(A0_3)
        local L1_3, L2_3
        L1_3 = A0_3.owner
        L2_3 = GetIdentifier
        L2_3 = L2_3()
        L1_3 = L1_3 == L2_3
        return L1_3
      end
      L2_2 = L2_2(L3_2, L4_2)
      if L2_2 then
        goto lbl_24
      end
    end
  end
  L2_2 = Notification
  L3_2 = i18n
  L3_2 = L3_2.t
  L4_2 = "creator.left_panel.no_houses_found"
  L3_2 = L3_2(L4_2)
  L4_2 = "error"
  L2_2(L3_2, L4_2)
  do return end
  ::lbl_24::
  L4_1 = A0_2
  L2_2 = true
  L5_1 = L2_2
  L2_2 = {}
  L3_2 = pairs
  L4_2 = L1_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = L8_2.owner
    L10_2 = GetIdentifier
    L10_2 = L10_2()
    L9_2 = L9_2 == L10_2
    if not L9_2 then
    else
      L10_2 = table
      L10_2 = L10_2.insert
      L11_2 = L2_2
      L12_2 = {}
      L13_2 = Config
      L13_2 = L13_2.Houses
      L14_2 = L8_2.house
      L13_2 = L13_2[L14_2]
      L13_2 = L13_2.address
      L12_2.label = L13_2
      L13_2 = Config
      L13_2 = L13_2.Houses
      L14_2 = L8_2.house
      L13_2 = L13_2[L14_2]
      L13_2 = L13_2.address
      L12_2.description = L13_2
      L13_2 = L8_2.house
      L12_2.name = L13_2
      L10_2(L11_2, L12_2)
    end
  end
  L3_2 = #L2_2
  if 0 == L3_2 then
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "creator.left_panel.no_houses_found"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
    L3_2 = L8_1
    L3_2()
    return
  end
  L3_2 = L2_2[1]
  if L3_2 then
    L3_2 = L2_2[1]
    L3_2 = L3_2.name
    if L3_2 then
      goto lbl_87
    end
  end
  L3_2 = nil
  ::lbl_87::
  L3_1 = L3_2
  L3_2 = {}
  L4_2 = pairs
  L5_2 = A0_2.categories
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = Config
    L10_2 = L10_2.Furniture
    L10_2 = L10_2[L9_2]
    if L10_2 then
      L10_2 = {}
      L11_2 = Config
      L11_2 = L11_2.Furniture
      L11_2 = L11_2[L9_2]
      L11_2 = L11_2.label
      L10_2.label = L11_2
      L11_2 = Config
      L11_2 = L11_2.Furniture
      L11_2 = L11_2[L9_2]
      L11_2 = L11_2.img
      L10_2.img = L11_2
      L11_2 = Config
      L11_2 = L11_2.Furniture
      L11_2 = L11_2[L9_2]
      L11_2 = L11_2.items
      L10_2.items = L11_2
      L3_2[L9_2] = L10_2
    end
  end
  L4_2 = ToggleHud
  L5_2 = false
  L4_2(L5_2)
  L4_2 = SetNuiFocus
  L5_2 = true
  L6_2 = true
  L4_2(L5_2, L6_2)
  L4_2 = SendReactMessage
  L5_2 = "toggle_furniture_shop"
  L6_2 = {}
  L6_2.visible = true
  L7_2 = A0_2.name
  L6_2.shopName = L7_2
  L6_2.categories = L3_2
  L6_2.houses = L2_2
  L7_2 = L3_1
  L6_2.selectedHouse = L7_2
  L4_2(L5_2, L6_2)
end
L10_1 = RegisterNUICallback
L11_1 = "furniture_shop:close"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L8_1
  L2_2()
  L2_2 = SendReactMessage
  L3_2 = "toggle_furniture_shop"
  L4_2 = {}
  L4_2.visible = false
  L2_2(L3_2, L4_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNUICallback
L11_1 = "furniture_shop:select_item"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = L5_1
  if L2_2 then
    L2_2 = L4_1
    if L2_2 then
      goto lbl_11
    end
  end
  L2_2 = A1_2
  L3_2 = "ok"
  do return L2_2(L3_2) end
  ::lbl_11::
  L2_2 = A0_2.category
  L3_2 = A0_2.itemIndex
  L4_2 = A0_2.colorObject
  L5_2 = Config
  L5_2 = L5_2.Furniture
  L5_2 = L5_2[L2_2]
  if L5_2 then
    L5_2 = Config
    L5_2 = L5_2.Furniture
    L5_2 = L5_2[L2_2]
    L5_2 = L5_2.items
    L5_2 = L5_2[L3_2]
    if L5_2 then
      goto lbl_30
    end
  end
  L5_2 = A1_2
  L6_2 = "ok"
  do return L5_2(L6_2) end
  ::lbl_30::
  L5_2 = Config
  L5_2 = L5_2.Furniture
  L5_2 = L5_2[L2_2]
  L5_2 = L5_2.items
  L5_2 = L5_2[L3_2]
  if L4_2 then
    L6_2 = L5_2.colors
    if L6_2 then
      L6_2 = table
      L6_2 = L6_2.find
      L7_2 = L5_2.colors
      function L8_2(A0_3)
        local L1_3, L2_3
        L1_3 = A0_3.object
        L2_3 = L4_2
        L1_3 = L1_3 == L2_3
        return L1_3
      end
      L6_2 = L6_2(L7_2, L8_2)
      if L6_2 then
        L7_2 = {}
        L8_2 = L6_2.object
        L7_2.object = L8_2
        L8_2 = L6_2.label
        L7_2.label = L8_2
        L8_2 = L6_2.price
        L7_2.price = L8_2
        L8_2 = L5_2.description
        L7_2.description = L8_2
        L8_2 = L5_2.img
        L7_2.img = L8_2
        L8_2 = L6_2.type
        if not L8_2 then
          L8_2 = L5_2.type
        end
        L7_2.type = L8_2
        L8_2 = L6_2.stash
        if not L8_2 then
          L8_2 = L5_2.stash
        end
        L7_2.stash = L8_2
        L8_2 = L6_2.offset
        if not L8_2 then
          L8_2 = L5_2.offset
        end
        L7_2.offset = L8_2
        L8_2 = L6_2.label
        L7_2.colorlabel = L8_2
        L2_1 = L7_2
      else
        L7_2 = L5_2.object
        if L7_2 == L4_2 then
          L2_1 = L5_2
        else
          L2_1 = L5_2
        end
      end
  end
  else
    L2_1 = L5_2
  end
  L6_2 = A1_2
  L7_2 = "ok"
  L6_2(L7_2)
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNUICallback
L11_1 = "furniture_shop:select_house"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = L5_1
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = "ok"
    return L2_2(L3_2)
  end
  L2_2 = A0_2.houseName
  L3_1 = L2_2
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNUICallback
L11_1 = "furniture_shop:buy_item"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = L5_1
  if L2_2 then
    L2_2 = L2_1
    if L2_2 then
      L2_2 = L3_1
      if L2_2 then
        goto lbl_21
      end
    end
  end
  L2_2 = Debug
  L3_2 = "furniture_shop:buy_item"
  L4_2 = "Not shop active or current object data or selected house"
  L5_2 = L5_1
  L6_2 = L2_1
  L7_2 = L3_1
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = A1_2
  L3_2 = false
  do return L2_2(L3_2) end
  ::lbl_21::
  if A0_2 then
    L2_2 = A0_2.colorObject
    if L2_2 then
      goto lbl_27
    end
  end
  L2_2 = L2_1.object
  ::lbl_27::
  L3_2 = L2_1.price
  L4_2 = IsOnlyInsideModel
  L5_2 = L2_2
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L4_2 = EnteredHouse
    if not L4_2 then
      L4_2 = Notification
      L5_2 = i18n
      L5_2 = L5_2.t
      L6_2 = "decorate.only_inside_purchase"
      L5_2 = L5_2(L6_2)
      L6_2 = "error"
      L4_2(L5_2, L6_2)
      L4_2 = A1_2
      L5_2 = false
      return L4_2(L5_2)
    end
  end
  L4_2 = lib
  L4_2 = L4_2.callback
  L4_2 = L4_2.await
  L5_2 = "housing:createFurnitureOrder"
  L6_2 = 0
  L7_2 = L3_1
  L8_2 = {}
  L8_2.modelName = L2_2
  L8_2.price = L3_2
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  if not L4_2 then
    L5_2 = Notification
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "no_money"
    L8_2 = {}
    L8_2.price = L3_2
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = "error"
    L5_2(L6_2, L7_2)
    L5_2 = A1_2
    L6_2 = false
    return L5_2(L6_2)
  end
  L5_2 = Notification
  L6_2 = i18n
  L6_2 = L6_2.t
  L7_2 = "furniture_shop.item_purchased"
  L6_2 = L6_2(L7_2)
  L7_2 = "success"
  L5_2(L6_2, L7_2)
  L5_2 = A1_2
  L6_2 = true
  L5_2(L6_2)
end
L10_1(L11_1, L12_1)
L10_1 = i18n
L10_1 = L10_1.t
L11_1 = "drawtext.enter_furniture_shop"
L10_1 = L10_1(L11_1)
L11_1 = CreateThread
function L12_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  while true do
    L0_2 = 1250
    L1_2 = GetEntityCoords
    L2_2 = cache
    L2_2 = L2_2.ped
    L1_2 = L1_2(L2_2)
    L2_2 = pairs
    L3_2 = Config
    L3_2 = L3_2.FurnitureShops
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = L7_2.enter
      L8_2 = L1_2 - L8_2
      L8_2 = #L8_2
      if L8_2 < 2.0 then
        L0_2 = 0
        L9_2 = DrawText3D
        L10_2 = L7_2.enter
        L10_2 = L10_2.x
        L11_2 = L7_2.enter
        L11_2 = L11_2.y
        L12_2 = L7_2.enter
        L12_2 = L12_2.z
        L13_2 = L10_1
        L14_2 = "open_ikea"
        L15_2 = "E"
        L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
        L9_2 = IsControlJustPressed
        L10_2 = 0
        L11_2 = Keys
        L11_2 = L11_2.E
        L9_2 = L9_2(L10_2, L11_2)
        if L9_2 then
          L9_2 = L9_1
          L10_2 = L7_2
          L9_2(L10_2)
        end
      end
    end
    L2_2 = Wait
    L3_2 = L0_2
    L2_2(L3_2)
  end
end
L11_1(L12_1)






