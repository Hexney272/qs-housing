





local L0_1, L1_1, L2_1, L3_1
L0_1 = _G
L1_1 = {}
L1_1.visible = false
L2_1 = {}
L1_1.houses = L2_1
L0_1.housebrowser = L1_1
L0_1 = housebrowser
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2
  L1_2 = {}
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:getHouseBrowserData"
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L2_2 = {}
  end
  L3_2 = pairs
  L4_2 = Config
  L4_2 = L4_2.Houses
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = L8_2.hideFromBrowser
    if L9_2 then
    else
      L9_2 = L8_2.apartmentNumber
      if L9_2 then
        L9_2 = L8_2.apartmentNumber
        if "apt-0" ~= L9_2 then
      end
      else
        L9_2 = L2_2[L7_2]
        if not L9_2 then
          L9_2 = {}
        end
        L10_2 = L9_2.rentable
        if not L10_2 then
          L10_2 = false
        end
        L11_2 = L9_2.purchasable
        if not L11_2 then
          L11_2 = false
        end
        L12_2 = L9_2.owned
        if not L12_2 then
          L12_2 = false
        end
        if L12_2 and not L10_2 and not L11_2 then
        else
          L13_2 = L8_2.coords
          L13_2 = L13_2.enter
          L14_2 = "shell"
          L15_2 = L8_2.mlo
          if L15_2 then
            L14_2 = "mlo"
          else
            L15_2 = L8_2.ipl
            if L15_2 then
              L14_2 = "ipl"
            end
          end
          L15_2 = "purchasable"
          L16_2 = nil
          if L10_2 then
            L15_2 = "rentable"
          elseif L11_2 and L12_2 then
            L15_2 = "player_selling"
            L17_2 = L9_2.ownerName
            if L17_2 then
              L17_2 = {}
              L18_2 = L9_2.ownerName
              L17_2.name = L18_2
              L16_2 = L17_2
            end
          elseif L11_2 then
            L15_2 = "purchasable"
          elseif not L12_2 then
            L15_2 = "purchasable"
            goto lbl_94
            goto lbl_212
            ::lbl_94::
            L17_2 = nil
            if L12_2 then
              L18_2 = L9_2.ownerName
              if L18_2 then
                L18_2 = {}
                L19_2 = L9_2.ownerName
                L18_2.name = L19_2
                L19_2 = L9_2.ownerPhone
                L18_2.phone = L19_2
                L17_2 = L18_2
              end
            end
            L18_2 = L8_2.photos
            if not L18_2 then
              L18_2 = {}
            end
            L19_2 = type
            L20_2 = L8_2.description
            L19_2 = L19_2(L20_2)
            if "string" == L19_2 then
              L19_2 = L8_2.description
              if "" ~= L19_2 then
                L19_2 = L8_2.description
                if L19_2 then
                  goto lbl_127
                end
              end
            end
            L19_2 = i18n
            L19_2 = L19_2.t
            L20_2 = "housebrowser.no_description"
            L19_2 = L19_2(L20_2)
            ::lbl_127::
            L20_2 = nil
            if "player_selling" == L15_2 then
              L20_2 = L9_2.saleFurnished
            end
            L21_2 = L8_2.apartmentCount
            L21_2 = nil ~= L21_2
            if L21_2 then
              L22_2 = L8_2.apartmentCount
              if L22_2 then
                goto lbl_145
              end
            end
            L22_2 = nil
            ::lbl_145::
            L23_2 = {}
            L23_2.id = L7_2
            L24_2 = L8_2.apartmentName
            if not L24_2 then
              L25_2 = L7_2
              L24_2 = L7_2.gsub
              L26_2 = "_"
              L27_2 = " "
              L24_2 = L24_2(L25_2, L26_2, L27_2)
              L25_2 = L24_2
              L24_2 = L24_2.gsub
              L26_2 = "^%l"
              L27_2 = string
              L27_2 = L27_2.upper
              L24_2 = L24_2(L25_2, L26_2, L27_2)
            end
            L23_2.name = L24_2
            L24_2 = L8_2.address
            if not L24_2 then
              L24_2 = i18n
              L24_2 = L24_2.t
              L25_2 = "housebrowser.unknown_address"
              L24_2 = L24_2(L25_2)
            end
            L23_2.address = L24_2
            L24_2 = L8_2.price
            if not L24_2 then
              L24_2 = 0
            end
            L23_2.price = L24_2
            L23_2.sellType = L15_2
            L23_2.type = L14_2
            L23_2.owned = L12_2
            L24_2 = L8_2.locked
            if not L24_2 then
              L24_2 = false
            end
            L23_2.locked = L24_2
            L24_2 = L8_2.garage
            L24_2 = nil ~= L24_2
            L23_2.hasGarage = L24_2
            L23_2.photos = L18_2
            L23_2.description = L19_2
            L24_2 = L8_2.tier
            L23_2.tier = L24_2
            L24_2 = {}
            L25_2 = L13_2.x
            L24_2.x = L25_2
            L25_2 = L13_2.y
            L24_2.y = L25_2
            L25_2 = L13_2.z
            L24_2.z = L25_2
            L23_2.coords = L24_2
            L24_2 = L8_2.blip
            L23_2.blip = L24_2
            L23_2.owner = L17_2
            L23_2.seller = L16_2
            L23_2.furnished = L20_2
            L23_2.isApartment = L21_2
            L23_2.apartmentCount = L22_2
            L24_2 = #L1_2
            L24_2 = L24_2 + 1
            L1_2[L24_2] = L23_2
          end
        end
      end
    end
    ::lbl_212::
  end
  return L1_2
end
L0_1.collectHouses = L1_1
L0_1 = housebrowser
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = A0_2.visible
  if L1_2 then
    return
  end
  L1_2 = IsNuiFocused
  L1_2 = L1_2()
  if L1_2 then
    return
  end
  L2_2 = A0_2
  L1_2 = A0_2.collectHouses
  L1_2 = L1_2(L2_2)
  A0_2.houses = L1_2
  A0_2.visible = true
  L1_2 = SetNuiFocus
  L2_2 = true
  L3_2 = true
  L1_2(L2_2, L3_2)
  L1_2 = ToggleHud
  L2_2 = false
  L1_2(L2_2)
  L1_2 = math
  L1_2 = L1_2.huge
  L2_2 = 0
  L3_2 = pairs
  L4_2 = A0_2.houses
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = L8_2.price
    if L1_2 > L9_2 then
      L1_2 = L8_2.price
    end
    L9_2 = L8_2.price
    if L2_2 < L9_2 then
      L2_2 = L8_2.price
    end
  end
  L3_2 = math
  L3_2 = L3_2.huge
  if L1_2 == L3_2 then
    L1_2 = 0
  end
  if 0 == L2_2 then
    L2_2 = 10000000
  end
  L3_2 = PlayerPedId
  L3_2 = L3_2()
  L4_2 = GetEntityCoords
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = SendReactMessage
  L6_2 = "toggle_house_browser"
  L7_2 = {}
  L7_2.visible = true
  L8_2 = A0_2.houses
  L7_2.houses = L8_2
  L8_2 = {}
  L9_2 = L1_2
  L10_2 = L2_2
  L8_2[1] = L9_2
  L8_2[2] = L10_2
  L7_2.priceRange = L8_2
  L8_2 = {}
  L9_2 = L4_2.x
  L8_2.x = L9_2
  L9_2 = L4_2.y
  L8_2.y = L9_2
  L9_2 = L4_2.z
  L8_2.z = L9_2
  L7_2.playerCoords = L8_2
  L5_2(L6_2, L7_2)
  L5_2 = Debug
  L6_2 = "HouseBrowser opened with"
  L7_2 = A0_2.houses
  L7_2 = #L7_2
  L8_2 = "houses"
  L5_2(L6_2, L7_2, L8_2)
end
L0_1.open = L1_1
L0_1 = housebrowser
function L1_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = A0_2.visible
  if not L1_2 then
    return
  end
  A0_2.visible = false
  L1_2 = SetNuiFocus
  L2_2 = false
  L3_2 = false
  L1_2(L2_2, L3_2)
  L1_2 = ToggleHud
  L2_2 = true
  L1_2(L2_2)
  L1_2 = SendReactMessage
  L2_2 = "toggle_house_browser"
  L3_2 = {}
  L3_2.visible = false
  L1_2(L2_2, L3_2)
  L1_2 = Debug
  L2_2 = "HouseBrowser closed"
  L1_2(L2_2)
end
L0_1.close = L1_1
L0_1 = housebrowser
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A1_2]
  if not L2_2 then
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "house_not_found"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    return L3_2(L4_2, L5_2)
  end
  L3_2 = L2_2.coords
  L3_2 = L3_2.enter
  if L3_2 then
    L4_2 = L3_2.x
    if L4_2 then
      L4_2 = L3_2.y
      if L4_2 then
        L4_2 = SetNewWaypoint
        L5_2 = L3_2.x
        L6_2 = L3_2.y
        L4_2(L5_2, L6_2)
        L4_2 = Notification
        L5_2 = i18n
        L5_2 = L5_2.t
        L6_2 = "housebrowser.waypoint_set"
        L7_2 = {}
        L8_2 = L2_2.address
        L7_2.house = L8_2
        L5_2 = L5_2(L6_2, L7_2)
        L6_2 = "success"
        L4_2(L5_2, L6_2)
      end
    end
  end
end
L0_1.setWaypoint = L1_1
L0_1 = housebrowser
L1_1 = {}
L1_1.ped = nil
L1_1.spawned = false
L1_1.blip = nil
L0_1.realeStateNPC = L1_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = Config
  L3_2 = L3_2.PedStreaming
  if not L3_2 then
    L3_2 = {}
  end
  L4_2 = L3_2.default
  if not L4_2 then
    L4_2 = {}
  end
  L5_2 = L3_2[A0_2]
  if not L5_2 then
    L5_2 = {}
  end
  L6_2 = L5_2.spawnDistance
  if not L6_2 then
    L6_2 = L4_2.spawnDistance
    if not L6_2 then
      L6_2 = A1_2
    end
  end
  L7_2 = L5_2.despawnDistance
  if not L7_2 then
    L7_2 = L4_2.despawnDistance
    if not L7_2 then
      L7_2 = A2_2
    end
  end
  if L6_2 >= L7_2 then
    L7_2 = L6_2 + 5.0
  end
  L8_2 = L6_2
  L9_2 = L7_2
  return L8_2, L9_2
end
L1_1 = housebrowser
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L1_2 = A0_2.realeStateNPC
  L1_2 = L1_2.spawned
  if L1_2 then
    L1_2 = DoesEntityExist
    L2_2 = A0_2.realeStateNPC
    L2_2 = L2_2.ped
    L1_2 = L1_2(L2_2)
    if L1_2 then
      return
    end
  end
  L1_2 = Config
  L1_2 = L1_2.RealeStateNPC
  if L1_2 then
    L1_2 = Config
    L1_2 = L1_2.RealeStateNPC
    L1_2 = L1_2.enabled
    if L1_2 then
      goto lbl_22
    end
  end
  do return end
  ::lbl_22::
  L1_2 = Config
  L1_2 = L1_2.RealeStateNPC
  L2_2 = L1_2.location
  L3_2 = lib
  L3_2 = L3_2.requestModel
  L4_2 = L1_2.pedModel
  L5_2 = Config
  L5_2 = L5_2.DefaultRequestModelTimeout
  L3_2(L4_2, L5_2)
  L3_2 = CreatePed
  L4_2 = 28
  L5_2 = L1_2.pedModel
  L6_2 = L2_2.x
  L7_2 = L2_2.y
  L8_2 = L2_2.z
  L8_2 = L8_2 - 1.0
  L9_2 = L2_2.w
  if not L9_2 then
    L9_2 = 0.0
  end
  L10_2 = false
  L11_2 = false
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L4_2 = SetEntityInvincible
  L5_2 = L3_2
  L6_2 = true
  L4_2(L5_2, L6_2)
  L4_2 = SetBlockingOfNonTemporaryEvents
  L5_2 = L3_2
  L6_2 = true
  L4_2(L5_2, L6_2)
  L4_2 = FreezeEntityPosition
  L5_2 = L3_2
  L6_2 = true
  L4_2(L5_2, L6_2)
  L4_2 = SetEntityCollision
  L5_2 = L3_2
  L6_2 = false
  L7_2 = false
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = SetPedRandomComponentVariation
  L5_2 = L3_2
  L6_2 = 0
  L4_2(L5_2, L6_2)
  L4_2 = SetPedRandomProps
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = L1_2.anim
  if L4_2 then
    L4_2 = L1_2.anim
    L4_2 = L4_2.dict
    if L4_2 then
      L4_2 = L1_2.anim
      L4_2 = L4_2.name
      if L4_2 then
        L4_2 = lib
        L4_2 = L4_2.requestAnimDict
        L5_2 = L1_2.anim
        L5_2 = L5_2.dict
        L4_2(L5_2)
        L4_2 = TaskPlayAnim
        L5_2 = L3_2
        L6_2 = L1_2.anim
        L6_2 = L6_2.dict
        L7_2 = L1_2.anim
        L7_2 = L7_2.name
        L8_2 = 8.0
        L9_2 = -8.0
        L10_2 = -1
        L11_2 = 1
        L12_2 = 0
        L13_2 = false
        L14_2 = false
        L15_2 = false
        L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
      end
    end
  end
  L4_2 = A0_2.realeStateNPC
  L4_2.ped = L3_2
  L4_2 = A0_2.realeStateNPC
  L4_2.spawned = true
  L4_2 = L1_2.blip
  if L4_2 then
    L4_2 = L1_2.blip
    L4_2 = L4_2.enabled
    if L4_2 then
      L4_2 = L1_2.blip
      L5_2 = L4_2.text
      if not L5_2 then
        L5_2 = i18n
        L5_2 = L5_2.t
        L6_2 = "housebrowser.reale_state"
        L5_2 = L5_2(L6_2)
        if not L5_2 then
          L5_2 = "Real Estate"
        end
      end
      L6_2 = A0_2.realeStateNPC
      L7_2 = Utils
      L7_2 = L7_2.CreateBlip
      L8_2 = {}
      L8_2.location = L2_2
      L9_2 = L4_2.sprite
      if not L9_2 then
        L9_2 = 374
      end
      L8_2.sprite = L9_2
      L9_2 = L4_2.color
      if not L9_2 then
        L9_2 = 3
      end
      L8_2.color = L9_2
      L9_2 = L4_2.scale
      if not L9_2 then
        L9_2 = 0.8
      end
      L8_2.scale = L9_2
      L8_2.text = L5_2
      L8_2.shortRange = true
      L7_2 = L7_2(L8_2)
      L6_2.blip = L7_2
    end
  end
  L4_2 = SetModelAsNoLongerNeeded
  L5_2 = L1_2.pedModel
  L4_2(L5_2)
end
L1_1.spawnRealeStateNPC = L2_1
L1_1 = housebrowser
function L2_1(A0_2)
  local L1_2, L2_2
  L1_2 = A0_2.realeStateNPC
  L1_2 = L1_2.ped
  if L1_2 then
    L1_2 = DoesEntityExist
    L2_2 = A0_2.realeStateNPC
    L2_2 = L2_2.ped
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = DeleteEntity
      L2_2 = A0_2.realeStateNPC
      L2_2 = L2_2.ped
      L1_2(L2_2)
    end
  end
  L1_2 = A0_2.realeStateNPC
  L1_2 = L1_2.blip
  if L1_2 then
    L1_2 = Utils
    L1_2 = L1_2.RemoveBlip
    L2_2 = A0_2.realeStateNPC
    L2_2 = L2_2.blip
    L1_2(L2_2)
  end
  L1_2 = A0_2.realeStateNPC
  L1_2.ped = nil
  L1_2 = A0_2.realeStateNPC
  L1_2.blip = nil
  L1_2 = A0_2.realeStateNPC
  L1_2.spawned = false
end
L1_1.deleteRealeStateNPC = L2_1
L1_1 = Config
L1_1 = L1_1.HouseBrowserCommand
if L1_1 then
  L1_1 = RegisterCommand
  L2_1 = "housebrowser"
  function L3_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2
    L3_2 = IsNuiFocused
    L3_2 = L3_2()
    if L3_2 then
      return
    end
    L3_2 = housebrowser
    L4_2 = L3_2
    L3_2 = L3_2.open
    L3_2(L4_2)
  end
  L1_1(L2_1, L3_1)
end
L1_1 = CreateThread
function L2_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  while true do
    L0_2 = Wait
    L1_2 = 1000
    L0_2(L1_2)
    L0_2 = Config
    L0_2 = L0_2.RealeStateNPC
    if L0_2 then
      L1_2 = L0_2.enabled
      if L1_2 then
        L1_2 = L0_2.location
        if L1_2 then
          goto lbl_23
        end
      end
    end
    L1_2 = housebrowser
    L1_2 = L1_2.realeStateNPC
    L1_2 = L1_2.spawned
    if L1_2 then
      L1_2 = housebrowser
      L2_2 = L1_2
      L1_2 = L1_2.deleteRealeStateNPC
      L1_2(L2_2)
      goto lbl_64
      ::lbl_23::
      L1_2 = L0_1
      L2_2 = "realEstate"
      L3_2 = 70.0
      L4_2 = 85.0
      L1_2, L2_2 = L1_2(L2_2, L3_2, L4_2)
      L3_2 = GetEntityCoords
      L4_2 = cache
      L4_2 = L4_2.ped
      L3_2 = L3_2(L4_2)
      L4_2 = vec3
      L5_2 = L0_2.location
      L5_2 = L5_2.x
      L6_2 = L0_2.location
      L6_2 = L6_2.y
      L7_2 = L0_2.location
      L7_2 = L7_2.z
      L4_2 = L4_2(L5_2, L6_2, L7_2)
      L5_2 = L3_2 - L4_2
      L5_2 = #L5_2
      if L1_2 >= L5_2 then
        L6_2 = housebrowser
        L6_2 = L6_2.realeStateNPC
        L6_2 = L6_2.spawned
        if not L6_2 then
          L6_2 = housebrowser
          L7_2 = L6_2
          L6_2 = L6_2.spawnRealeStateNPC
          L6_2(L7_2)
      end
      elseif L2_2 <= L5_2 then
        L6_2 = housebrowser
        L6_2 = L6_2.realeStateNPC
        L6_2 = L6_2.spawned
        if L6_2 then
          L6_2 = housebrowser
          L7_2 = L6_2
          L6_2 = L6_2.deleteRealeStateNPC
          L6_2(L7_2)
        end
      end
    end
    ::lbl_64::
  end
end
L1_1(L2_1)
L1_1 = AddEventHandler
L2_1 = "onResourceStop"
function L3_1(A0_2)
  local L1_2, L2_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 == L1_2 then
    L1_2 = housebrowser
    L2_2 = L1_2
    L1_2 = L1_2.deleteRealeStateNPC
    L1_2(L2_2)
  end
end
L1_1(L2_1, L3_1)
L1_1 = CreateThread
function L2_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  while true do
    L0_2 = 1000
    L1_2 = housebrowser
    L1_2 = L1_2.realeStateNPC
    L1_2 = L1_2.spawned
    if L1_2 then
      L1_2 = DoesEntityExist
      L2_2 = housebrowser
      L2_2 = L2_2.realeStateNPC
      L2_2 = L2_2.ped
      L1_2 = L1_2(L2_2)
      if L1_2 then
        L1_2 = GetEntityCoords
        L2_2 = cache
        L2_2 = L2_2.ped
        L1_2 = L1_2(L2_2)
        L2_2 = GetEntityCoords
        L3_2 = housebrowser
        L3_2 = L3_2.realeStateNPC
        L3_2 = L3_2.ped
        L2_2 = L2_2(L3_2)
        L3_2 = L1_2 - L2_2
        L3_2 = #L3_2
        if L3_2 < 2.0 then
          L0_2 = 0
          L4_2 = i18n
          L4_2 = L4_2.t
          L5_2 = "drawtext.reale_state_interact"
          L4_2 = L4_2(L5_2)
          if not L4_2 then
            L4_2 = "[E] - Open House Browser"
          end
          L5_2 = DrawText3D
          L6_2 = L2_2.x
          L7_2 = L2_2.y
          L8_2 = L2_2.z
          L8_2 = L8_2 + 0.3
          L9_2 = L4_2
          L10_2 = "reale_state_npc"
          L11_2 = "E"
          L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
          L5_2 = IsControlJustPressed
          L6_2 = 0
          L7_2 = Keys
          L7_2 = L7_2.E
          L5_2 = L5_2(L6_2, L7_2)
          if L5_2 then
            L5_2 = IsNuiFocused
            L5_2 = L5_2()
            if L5_2 then
              return
            end
            L5_2 = housebrowser
            L6_2 = L5_2
            L5_2 = L5_2.open
            L5_2(L6_2)
          end
        end
      end
    end
    L1_2 = Wait
    L2_2 = L0_2
    L1_2(L2_2)
  end
end
L1_1(L2_1)






