





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1
L0_1 = _G
L1_1 = {}
L0_1.management = L1_1
L0_1 = nil
L1_1 = RegisterNUICallback
L2_1 = "fast-action"
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = A0_2.action
  L3_2 = Debug
  L4_2 = "fast-action"
  L5_2 = L2_2
  L3_2(L4_2, L5_2)
  if "decorate" == L2_2 then
    L3_2 = CurrentApartment
    if L3_2 then
      L3_2 = Notification
      L4_2 = i18n
      L4_2 = L4_2.t
      L5_2 = "creator.polyzone_nearby"
      L4_2 = L4_2(L5_2)
      L5_2 = "error"
      L3_2(L4_2, L5_2)
      L3_2 = A1_2
      L4_2 = "error"
      return L3_2(L4_2)
    end
    L3_2 = TriggerEvent
    L4_2 = "housing:decorate:open"
    L3_2(L4_2)
  elseif "wardrobe" == L2_2 then
    L3_2 = CurrentApartment
    if L3_2 then
      L3_2 = Notification
      L4_2 = i18n
      L4_2 = L4_2.t
      L5_2 = "creator.polyzone_nearby"
      L4_2 = L4_2(L5_2)
      L5_2 = "error"
      L3_2(L4_2, L5_2)
      L3_2 = A1_2
      L4_2 = "error"
      return L3_2(L4_2)
    end
    L3_2 = SetLocation
    L4_2 = "wardrobe"
    L3_2(L4_2)
  elseif "charge" == L2_2 then
    L3_2 = CurrentApartment
    if L3_2 then
      L3_2 = Notification
      L4_2 = i18n
      L4_2 = L4_2.t
      L5_2 = "creator.polyzone_nearby"
      L4_2 = L4_2(L5_2)
      L5_2 = "error"
      L3_2(L4_2, L5_2)
      L3_2 = A1_2
      L4_2 = "error"
      return L3_2(L4_2)
    end
    L3_2 = GetResourceState
    L4_2 = "qs-smartphone"
    L3_2 = L3_2(L4_2)
    if "started" ~= L3_2 then
      L3_2 = GetResourceState
      L4_2 = "qs-smartphone-pro"
      L3_2 = L3_2(L4_2)
      if "started" ~= L3_2 then
        L3_2 = Notification
        L4_2 = i18n
        L4_2 = L4_2.t
        L5_2 = "management.missing_best_phone"
        L4_2 = L4_2(L5_2)
        L5_2 = "error"
        L3_2(L4_2, L5_2)
        L3_2 = A1_2
        L4_2 = "error"
        return L3_2(L4_2)
      end
    end
    L3_2 = SetLocation
    L4_2 = "charge"
    L3_2(L4_2)
  elseif "storage" == L2_2 then
    L3_2 = CurrentApartment
    if L3_2 then
      L3_2 = Notification
      L4_2 = i18n
      L4_2 = L4_2.t
      L5_2 = "creator.polyzone_nearby"
      L4_2 = L4_2(L5_2)
      L5_2 = "error"
      L3_2(L4_2, L5_2)
      L3_2 = A1_2
      L4_2 = "error"
      return L3_2(L4_2)
    end
    L3_2 = SetLocation
    L4_2 = "stash"
    L3_2(L4_2)
  elseif "delivery" == L2_2 then
    L3_2 = CurrentApartment
    if L3_2 then
      L3_2 = Notification
      L4_2 = i18n
      L4_2 = L4_2.t
      L5_2 = "creator.polyzone_nearby"
      L4_2 = L4_2(L5_2)
      L5_2 = "error"
      L3_2(L4_2, L5_2)
      L3_2 = A1_2
      L4_2 = "error"
      return L3_2(L4_2)
    end
    L3_2 = creator
    L4_2 = L3_2
    L3_2 = L3_2.spawnTempEntities
    L3_2(L4_2)
    L3_2 = creator
    L4_2 = L3_2
    L3_2 = L3_2.selectPoint
    L5_2 = "ped"
    L6_2 = 1
    L7_2 = {}
    L8_2 = Config
    L8_2 = L8_2.IkeaDeliveryPedModel
    L7_2.model = L8_2
    L8_2 = {}
    L9_2 = Config
    L9_2 = L9_2.IkeaDeliveryPedAnim
    L8_2.anim = L9_2
    L9_2 = {}
    L10_2 = Config
    L10_2 = L10_2.IkeaDeliveryBoxModel
    L9_2.model = L10_2
    L10_2 = Config
    L10_2 = L10_2.IkeaDeliveryPedAttach
    L10_2 = L10_2.bone
    L9_2.bone = L10_2
    L10_2 = Config
    L10_2 = L10_2.IkeaDeliveryPedAttach
    L10_2 = L10_2.pos
    L9_2.pos = L10_2
    L10_2 = Config
    L10_2 = L10_2.IkeaDeliveryPedAttach
    L10_2 = L10_2.rot
    L9_2.rot = L10_2
    L8_2.attachObject = L9_2
    L7_2.ped = L8_2
    L7_2.externalUsage = true
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
    L4_2 = creator
    L5_2 = L4_2
    L4_2 = L4_2.destroyTempEntities
    L4_2(L5_2)
    if L3_2 then
      L4_2 = L3_2[1]
      if L4_2 then
        goto lbl_180
      end
    end
    L4_2 = Notification
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "quick_menu.delivery_point_cancelled"
    L5_2 = L5_2(L6_2)
    L6_2 = "info"
    L4_2(L5_2, L6_2)
    L4_2 = A1_2
    L5_2 = "ok"
    do return L4_2(L5_2) end
    ::lbl_180::
    L4_2 = L3_2[1]
    L5_2 = {}
    L6_2 = L4_2.x
    L5_2.x = L6_2
    L6_2 = L4_2.y
    L5_2.y = L6_2
    L6_2 = L4_2.z
    L5_2.z = L6_2
    L6_2 = L4_2.w
    if not L6_2 then
      L6_2 = 0.0
    end
    L5_2.w = L6_2
    L6_2 = TriggerServerEvent
    L7_2 = "qb-houses:server:setLocation"
    L8_2 = L5_2
    L9_2 = CurrentHouse
    L10_2 = 8
    L6_2(L7_2, L8_2, L9_2, L10_2)
    L6_2 = Notification
    L7_2 = i18n
    L7_2 = L7_2.t
    L8_2 = "quick_menu.delivery_point_saved"
    L7_2 = L7_2(L8_2)
    L8_2 = "success"
    L6_2(L7_2, L8_2)
  elseif "fix-door" == L2_2 then
    L3_2 = TriggerEvent
    L4_2 = "qb-houses:client:ResetHouse"
    L3_2(L4_2)
  elseif "toggle-door" == L2_2 then
    L3_2 = TriggerEvent
    L4_2 = "qb-houses:client:toggleDoorlock"
    L3_2(L4_2)
  elseif "rent" == L2_2 then
    L3_2 = TriggerServerEvent
    L4_2 = "housing:lease"
    L5_2 = CurrentHouse
    L6_2 = tonumber
    L7_2 = A0_2.price
    L6_2 = L6_2(L7_2)
    L7_2 = {}
    L8_2 = A0_2.photos
    if not L8_2 then
      L8_2 = {}
    end
    L7_2.photos = L8_2
    L8_2 = A0_2.description
    if not L8_2 then
      L8_2 = ""
    end
    L7_2.description = L8_2
    L8_2 = A0_2.furnished
    L8_2 = false ~= L8_2
    L7_2.furnished = L8_2
    L8_2 = A0_2.hideFromBrowser
    if not L8_2 then
      L8_2 = false
    end
    L7_2.hideFromBrowser = L8_2
    L3_2(L4_2, L5_2, L6_2, L7_2)
  elseif "cancel-rent" == L2_2 then
    L3_2 = TriggerServerEvent
    L4_2 = "qb-houses:disspossesHouse"
    L5_2 = CurrentHouse
    L3_2(L4_2, L5_2)
  elseif "sell-bank" == L2_2 then
    L3_2 = CurrentHouseData
    L3_2 = L3_2.billsCutOff
    if L3_2 then
      L3_2 = Notification
      L4_2 = i18n
      L4_2 = L4_2.t
      L5_2 = "pay_your_bills"
      L4_2 = L4_2(L5_2)
      L5_2 = "error"
      L3_2(L4_2, L5_2)
      L3_2 = A1_2
      L4_2 = "error"
      return L3_2(L4_2)
    end
    L3_2 = TriggerServerEvent
    L4_2 = "qb-houses:sellHouse"
    L5_2 = CurrentHouse
    L3_2(L4_2, L5_2)
  elseif "sell-player" == L2_2 then
    L3_2 = CurrentHouseData
    L3_2 = L3_2.billsCutOff
    if L3_2 then
      L3_2 = Notification
      L4_2 = i18n
      L4_2 = L4_2.t
      L5_2 = "pay_your_bills"
      L4_2 = L4_2(L5_2)
      L5_2 = "error"
      L3_2(L4_2, L5_2)
      L3_2 = A1_2
      L4_2 = "error"
      return L3_2(L4_2)
    end
    L3_2 = TriggerServerEvent
    L4_2 = "qb-houses:sellHouseToPlayer"
    L5_2 = CurrentHouse
    L6_2 = tonumber
    L7_2 = A0_2.price
    L6_2 = L6_2(L7_2)
    L7_2 = {}
    L8_2 = A0_2.photos
    if not L8_2 then
      L8_2 = {}
    end
    L7_2.photos = L8_2
    L8_2 = A0_2.description
    if not L8_2 then
      L8_2 = ""
    end
    L7_2.description = L8_2
    L8_2 = A0_2.furnished
    L8_2 = false ~= L8_2
    L7_2.furnished = L8_2
    L8_2 = A0_2.hideFromBrowser
    if not L8_2 then
      L8_2 = false
    end
    L7_2.hideFromBrowser = L8_2
    L3_2(L4_2, L5_2, L6_2, L7_2)
  elseif "leave" == L2_2 then
    L3_2 = CurrentHouseData
    L3_2 = L3_2.billsCutOff
    if L3_2 then
      L3_2 = Notification
      L4_2 = i18n
      L4_2 = L4_2.t
      L5_2 = "pay_your_bills"
      L4_2 = L4_2(L5_2)
      L5_2 = "error"
      L3_2(L4_2, L5_2)
      L3_2 = A1_2
      L4_2 = "error"
      return L3_2(L4_2)
    end
    L3_2 = TriggerServerEvent
    L4_2 = "qb-houses:leftHouse"
    L5_2 = CurrentHouse
    L3_2(L4_2, L5_2)
  elseif "cancel-sell-house" == L2_2 then
    L3_2 = TriggerServerEvent
    L4_2 = "qb-houses:cancelSellHouse"
    L5_2 = CurrentHouse
    L3_2(L4_2, L5_2)
  end
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L1_1(L2_1, L3_1)
L1_1 = _G
L2_1 = {}
L2_1.active = false
L2_1.isInside = false
L2_1.initialPlayerCoords = nil
L2_1.spawnedShell = nil
L2_1.wasInsideBeforePhoto = false
L1_1.sellHousePhoto = L2_1
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L2_2 = A0_2.coords
  L2_2 = L2_2.shellCoords
  L3_2 = A0_2.coords
  L3_2 = L3_2.exit
  L4_2 = A0_2.tier
  L5_2 = Config
  L5_2 = L5_2.Shells
  L5_2 = L5_2[L4_2]
  if not L5_2 or not L3_2 then
    L6_2 = false
    return L6_2
  end
  L6_2 = sellHousePhoto
  L6_2 = L6_2.wasInsideBeforePhoto
  if not L6_2 then
    L6_2 = lib
    L6_2 = L6_2.requestModel
    L7_2 = L5_2.model
    L8_2 = Config
    L8_2 = L8_2.DefaultRequestModelTimeout
    L6_2(L7_2, L8_2)
    L6_2 = CreateObject
    L7_2 = joaat
    L8_2 = L5_2.model
    L7_2 = L7_2(L8_2)
    L8_2 = L2_2.x
    L9_2 = L2_2.y
    L10_2 = L2_2.z
    L11_2 = false
    L12_2 = false
    L13_2 = false
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L7_2 = SetEntityHeading
    L8_2 = L6_2
    L9_2 = L2_2.h
    if not L9_2 then
      L9_2 = 0.0
    end
    L7_2(L8_2, L9_2)
    L7_2 = FreezeEntityPosition
    L8_2 = L6_2
    L9_2 = true
    L7_2(L8_2, L9_2)
    L7_2 = SetModelAsNoLongerNeeded
    L8_2 = L5_2.model
    L7_2(L8_2)
    L7_2 = sellHousePhoto
    L7_2.spawnedShell = L6_2
  end
  L6_2 = vec3
  L7_2 = L3_2.x
  L8_2 = L3_2.y
  L9_2 = L3_2.z
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L7_2 = SetEntityCoords
  L8_2 = cache
  L8_2 = L8_2.ped
  L9_2 = L6_2.x
  L10_2 = L6_2.y
  L11_2 = L6_2.z
  L12_2 = false
  L13_2 = false
  L14_2 = false
  L15_2 = false
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L7_2 = SetEntityHeading
  L8_2 = cache
  L8_2 = L8_2.ped
  L9_2 = L3_2.w
  if not L9_2 then
    L9_2 = L3_2.h
    if not L9_2 then
      L9_2 = 0.0
    end
  end
  L7_2(L8_2, L9_2)
  if A1_2 then
    L7_2 = A1_2.camera
    if L7_2 then
      L7_2 = GetEntityMatrix
      L8_2 = cache
      L8_2 = L8_2.ped
      L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
      L11_2 = L9_2 * 2.0
      L12_2 = L6_2 + L11_2
      A1_2.camPos = L12_2
      L12_2 = SetCamCoord
      L13_2 = A1_2.camera
      L14_2 = A1_2.camPos
      L14_2 = L14_2.x
      L15_2 = A1_2.camPos
      L15_2 = L15_2.y
      L16_2 = A1_2.camPos
      L16_2 = L16_2.z
      L12_2(L13_2, L14_2, L15_2, L16_2)
    end
  end
  L7_2 = sellHousePhoto
  L7_2.isInside = true
  L7_2 = true
  return L7_2
end
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = sellHousePhoto
  L1_2 = L1_2.initialPlayerCoords
  if L1_2 then
    L2_2 = SetEntityCoords
    L3_2 = cache
    L3_2 = L3_2.ped
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = false
    L8_2 = false
    L9_2 = false
    L10_2 = false
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    if A0_2 then
      L2_2 = A0_2.camera
      if L2_2 then
        L2_2 = GetEntityMatrix
        L3_2 = cache
        L3_2 = L3_2.ped
        L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
        L6_2 = L4_2 * 2
        L6_2 = L1_2 + L6_2
        A0_2.camPos = L6_2
        L6_2 = SetCamCoord
        L7_2 = A0_2.camera
        L8_2 = A0_2.camPos
        L8_2 = L8_2.x
        L9_2 = A0_2.camPos
        L9_2 = L9_2.y
        L10_2 = A0_2.camPos
        L10_2 = L10_2.z
        L6_2(L7_2, L8_2, L9_2, L10_2)
      end
    end
  end
  L2_2 = sellHousePhoto
  L2_2.isInside = false
end
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L2_2 = A0_2.ipl
  if L2_2 then
    L3_2 = L2_2.exit
    if L3_2 then
      goto lbl_9
    end
  end
  L3_2 = false
  do return L3_2 end
  ::lbl_9::
  L3_2 = Config
  L3_2 = L3_2.IplData
  L4_2 = L2_2.houseName
  L3_2 = L3_2[L4_2]
  if L3_2 then
    L4_2 = L3_2.export
    if L4_2 then
      L4_2 = L3_2.export
      L4_2 = L4_2()
      if L4_2 then
        L5_2 = L4_2.Style
        if L5_2 then
          L5_2 = L2_2.theme
          if L5_2 then
            L5_2 = L4_2.Style
            L5_2 = L5_2.Set
            L6_2 = L2_2.theme
            L7_2 = true
            L5_2(L6_2, L7_2)
          end
        end
      end
    end
  end
  L4_2 = vec3
  L5_2 = L2_2.exit
  L5_2 = L5_2.x
  L6_2 = L2_2.exit
  L6_2 = L6_2.y
  L7_2 = L2_2.exit
  L7_2 = L7_2.z
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = SetEntityCoords
  L6_2 = cache
  L6_2 = L6_2.ped
  L7_2 = L4_2.x
  L8_2 = L4_2.y
  L9_2 = L4_2.z
  L10_2 = false
  L11_2 = false
  L12_2 = false
  L13_2 = false
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  if A1_2 then
    L5_2 = A1_2.camera
    if L5_2 then
      L5_2 = GetEntityMatrix
      L6_2 = cache
      L6_2 = L6_2.ped
      L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
      L9_2 = L7_2 * 2.0
      L10_2 = L4_2 + L9_2
      A1_2.camPos = L10_2
      L10_2 = SetCamCoord
      L11_2 = A1_2.camera
      L12_2 = A1_2.camPos
      L12_2 = L12_2.x
      L13_2 = A1_2.camPos
      L13_2 = L13_2.y
      L14_2 = A1_2.camPos
      L14_2 = L14_2.z
      L10_2(L11_2, L12_2, L13_2, L14_2)
    end
  end
  L5_2 = sellHousePhoto
  L5_2.isInside = true
  L5_2 = true
  return L5_2
end
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = sellHousePhoto
  L1_2 = L1_2.initialPlayerCoords
  if L1_2 then
    L2_2 = SetEntityCoords
    L3_2 = cache
    L3_2 = L3_2.ped
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = false
    L8_2 = false
    L9_2 = false
    L10_2 = false
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    if A0_2 then
      L2_2 = A0_2.camera
      if L2_2 then
        L2_2 = GetEntityMatrix
        L3_2 = cache
        L3_2 = L3_2.ped
        L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
        L6_2 = L4_2 * 2
        L6_2 = L1_2 + L6_2
        A0_2.camPos = L6_2
        L6_2 = SetCamCoord
        L7_2 = A0_2.camera
        L8_2 = A0_2.camPos
        L8_2 = L8_2.x
        L9_2 = A0_2.camPos
        L9_2 = L9_2.y
        L10_2 = A0_2.camPos
        L10_2 = L10_2.z
        L6_2(L7_2, L8_2, L9_2, L10_2)
      end
    end
  end
  L2_2 = sellHousePhoto
  L2_2.isInside = false
end
function L5_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = sellHousePhoto
  L0_2 = L0_2.isInside
  if L0_2 then
    L0_2 = sellHousePhoto
    L0_2 = L0_2.initialPlayerCoords
    if L0_2 then
      L0_2 = sellHousePhoto
      L0_2 = L0_2.initialPlayerCoords
      L1_2 = SetEntityCoords
      L2_2 = cache
      L2_2 = L2_2.ped
      L3_2 = L0_2.x
      L4_2 = L0_2.y
      L5_2 = L0_2.z
      L6_2 = false
      L7_2 = false
      L8_2 = false
      L9_2 = false
      L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    end
  end
  L0_2 = sellHousePhoto
  L0_2 = L0_2.spawnedShell
  if L0_2 then
    L0_2 = DoesEntityExist
    L1_2 = sellHousePhoto
    L1_2 = L1_2.spawnedShell
    L0_2 = L0_2(L1_2)
    if L0_2 then
      L0_2 = DeleteObject
      L1_2 = sellHousePhoto
      L1_2 = L1_2.spawnedShell
      L0_2(L1_2)
      L0_2 = sellHousePhoto
      L0_2.spawnedShell = nil
    end
  end
  L0_2 = DisplayRadar
  L1_2 = true
  L0_2(L1_2)
  L0_2 = SendReactMessage
  L1_2 = "toggle_photo_mode"
  L2_2 = {}
  L2_2.visible = false
  L0_2(L1_2, L2_2)
  L0_2 = sellHousePhoto
  L0_2.active = false
  L0_2 = sellHousePhoto
  L0_2.isInside = false
  L0_2 = sellHousePhoto
  L0_2.initialPlayerCoords = nil
  L0_2 = sellHousePhoto
  L0_2.wasInsideBeforePhoto = false
end
L6_1 = RegisterNUICallback
L7_1 = "sell_house_take_photo"
function L8_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = CurrentHouse
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = nil
    return L2_2(L3_2)
  end
  L2_2 = Config
  L2_2 = L2_2.Houses
  L3_2 = CurrentHouse
  L2_2 = L2_2[L3_2]
  if not L2_2 then
    L3_2 = A1_2
    L4_2 = nil
    return L3_2(L4_2)
  end
  L3_2 = sellHousePhoto
  L3_2.active = true
  L3_2 = sellHousePhoto
  L3_2.isInside = false
  L3_2 = sellHousePhoto
  L4_2 = GetEntityCoords
  L5_2 = cache
  L5_2 = L5_2.ped
  L4_2 = L4_2(L5_2)
  L3_2.initialPlayerCoords = L4_2
  L3_2 = sellHousePhoto
  L3_2.spawnedShell = nil
  L3_2 = sellHousePhoto
  L4_2 = EnteredHouse
  L5_2 = CurrentHouse
  L4_2 = L4_2 == L5_2
  L3_2.wasInsideBeforePhoto = L4_2
  L3_2 = L2_2.coords
  if L3_2 then
    L3_2 = L2_2.coords
    L3_2 = L3_2.shellCoords
    if L3_2 then
      L3_2 = L2_2.coords
      L3_2 = L3_2.exit
      if L3_2 then
        L3_2 = L2_2.mlo
        L3_2 = L2_2.ipl
        L3_2 = not L3_2 and L3_2
      end
    end
  end
  L4_2 = L2_2.ipl
  if L4_2 then
    L4_2 = L2_2.ipl
    L4_2 = L4_2.exit
  end
  L5_2 = L3_2 or L5_2
  if not L3_2 then
    L5_2 = L4_2
  end
  L6_2 = management
  L7_2 = L6_2
  L6_2 = L6_2.close
  L6_2(L7_2)
  L6_2 = SetNuiFocus
  L7_2 = false
  L8_2 = false
  L6_2(L7_2, L8_2)
  L6_2 = DisplayRadar
  L7_2 = false
  L6_2(L7_2)
  L6_2 = SendReactMessage
  L7_2 = "toggle_photo_mode"
  L8_2 = {}
  L8_2.visible = true
  L6_2(L7_2, L8_2)
  L6_2 = nil
  L7_2 = raycast
  L8_2 = L7_2
  L7_2 = L7_2.freeCamera
  function L9_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    L1_3 = IsDisabledControlJustPressed
    L2_3 = 0
    L3_3 = 191
    L1_3 = L1_3(L2_3, L3_3)
    if L1_3 then
      L1_3 = lib
      L1_3 = L1_3.callback
      L1_3 = L1_3.await
      L2_3 = "housing:getPresignedUrl"
      L3_3 = false
      L4_3 = "image"
      L1_3 = L1_3(L2_3, L3_3, L4_3)
      if not L1_3 then
        L2_3 = Notification
        L3_3 = i18n
        L3_3 = L3_3.t
        L4_3 = "creator.photos.token_not_set"
        L3_3 = L3_3(L4_3)
        L4_3 = "error"
        L2_3(L3_3, L4_3)
        L3_3 = A0_3
        L2_3 = A0_3.destroy
        L2_3(L3_3)
        return
      end
      L2_3 = SendReactMessage
      L3_3 = "toggle_photo_mode"
      L4_3 = {}
      L4_3.visible = true
      L4_3.loading = true
      L2_3(L3_3, L4_3)
      L2_3 = promise
      L2_3 = L2_3.new
      L2_3 = L2_3()
      L3_3 = exports
      L3_3 = L3_3["screenshot-basic"]
      L4_3 = L3_3
      L3_3 = L3_3.requestScreenshotUpload
      L5_3 = L1_3
      L6_3 = "file"
      function L7_3(A0_4)
        local L1_4, L2_4, L3_4, L4_4
        L1_4 = json
        L1_4 = L1_4.decode
        L2_4 = A0_4
        L1_4 = L1_4(L2_4)
        if L1_4 then
          L2_4 = L1_4.data
          if L2_4 then
            goto lbl_22
          end
        end
        L2_4 = L2_3
        L3_4 = L2_4
        L2_4 = L2_4.resolve
        L4_4 = nil
        L2_4(L3_4, L4_4)
        L2_4 = Notification
        L3_4 = i18n
        L3_4 = L3_4.t
        L4_4 = "creator.photos.upload_failed"
        L3_4 = L3_4(L4_4)
        L4_4 = "error"
        L2_4(L3_4, L4_4)
        do return end
        ::lbl_22::
        L2_4 = L2_3
        L3_4 = L2_4
        L2_4 = L2_4.resolve
        L4_4 = L1_4.data
        L4_4 = L4_4.url
        L2_4(L3_4, L4_4)
        L2_4 = L1_4.data
        L2_4 = L2_4.url
        L6_2 = L2_4
      end
      L3_3(L4_3, L5_3, L6_3, L7_3)
      L3_3 = Citizen
      L3_3 = L3_3.Await
      L4_3 = L2_3
      L3_3(L4_3)
      L4_3 = A0_3
      L3_3 = A0_3.destroy
      L3_3(L4_3)
    end
    L1_3 = L5_2
    if L1_3 then
      L1_3 = IsDisabledControlJustPressed
      L2_3 = 0
      L3_3 = 23
      L1_3 = L1_3(L2_3, L3_3)
      if L1_3 then
        L1_3 = sellHousePhoto
        L1_3 = L1_3.isInside
        if not L1_3 then
          L1_3 = L3_2
          if L1_3 then
            L1_3 = L1_1
            L2_3 = L2_2
            L3_3 = A0_3
            L1_3(L2_3, L3_3)
          else
            L1_3 = L4_2
            if L1_3 then
              L1_3 = L3_1
              L2_3 = L2_2
              L3_3 = A0_3
              L1_3(L2_3, L3_3)
            end
          end
        else
          L1_3 = L3_2
          if L1_3 then
            L1_3 = L2_1
            L2_3 = A0_3
            L1_3(L2_3)
          else
            L1_3 = L4_2
            if L1_3 then
              L1_3 = L4_1
              L2_3 = A0_3
              L1_3(L2_3)
            end
          end
        end
      end
    end
    L1_3 = IsDisabledControlJustPressed
    L2_3 = 0
    L3_3 = 322
    L1_3 = L1_3(L2_3, L3_3)
    if L1_3 then
      L2_3 = A0_3
      L1_3 = A0_3.destroy
      L1_3(L2_3)
    end
  end
  L10_2 = nil
  L11_2 = {}
  L11_2.line = false
  L11_2.scaleform = false
  L7_2(L8_2, L9_2, L10_2, L11_2)
  L7_2 = L5_1
  L7_2()
  L7_2 = Wait
  L8_2 = 100
  L7_2(L8_2)
  L7_2 = lib
  L7_2 = L7_2.callback
  L7_2 = L7_2.await
  L8_2 = "housing:getManagementData"
  L9_2 = false
  L10_2 = CurrentHouse
  L7_2 = L7_2(L8_2, L9_2, L10_2)
  if L7_2 then
    L7_2.openSellHouseModal = true
    L8_2 = management
    L9_2 = L8_2
    L8_2 = L8_2.open
    L10_2 = L7_2
    L8_2(L9_2, L10_2)
  end
  L8_2 = A1_2
  L9_2 = L6_2
  L8_2(L9_2)
end
L6_1(L7_1, L8_1)
L6_1 = {}
L6_1.wardrobe = "setoutfit"
L6_1.stash = "setstash"
L6_1.charge = "setCharge"
L6_1.tablet = "setTablet"
L7_1 = i18n
L7_1 = L7_1.t
L8_1 = "drawtext.set_location"
L7_1 = L7_1(L8_1)
function L8_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = CreateThread
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
    while true do
      L0_3 = L0_1
      if not L0_3 then
        break
      end
      L0_3 = Wait
      L1_3 = 0
      L0_3(L1_3)
    end
    L0_3 = A1_2
    if L0_3 then
      L0_3 = TriggerEvent
      L1_3 = "qb-houses:client:setLocation"
      L2_3 = {}
      L4_3 = A0_2
      L3_3 = L6_1
      L3_3 = L3_3[L4_3]
      L2_3.id = L3_3
      L0_3(L1_3, L2_3)
      return
    end
    while true do
      L0_3 = CurrentHouse
      if not L0_3 then
        break
      end
      L0_3 = L0_1
      if L0_3 then
        break
      end
      L0_3 = Wait
      L1_3 = 0
      L0_3(L1_3)
      L0_3 = GetEntityCoords
      L1_3 = cache
      L1_3 = L1_3.ped
      L0_3 = L0_3(L1_3)
      L1_3 = DrawGenericText
      L2_3 = L7_1
      L1_3(L2_3)
      L1_3 = IsControlJustPressed
      L2_3 = 0
      L3_3 = 47
      L1_3 = L1_3(L2_3, L3_3)
      if L1_3 then
        L1_3 = TriggerEvent
        L2_3 = "qb-houses:client:setLocation"
        L3_3 = {}
        L5_3 = A0_2
        L4_3 = L6_1
        L4_3 = L4_3[L5_3]
        L3_3.id = L4_3
        L1_3(L2_3, L3_3)
        break
      end
    end
  end
  L2_2(L3_2)
end
SetLocation = L8_1
function L8_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = CurrentHouse
  if not L0_2 then
    L0_2 = false
    return L0_2
  end
  L0_2 = Config
  L0_2 = L0_2.Houses
  L1_2 = CurrentHouse
  L0_2 = L0_2[L1_2]
  if not L0_2 then
    L1_2 = false
    return L1_2
  end
  L1_2 = table
  L1_2 = L1_2.includes
  L2_2 = L0_2.upgrades
  if not L2_2 then
    L2_2 = {}
  end
  L3_2 = "camera"
  return L1_2(L2_2, L3_2)
end
function L9_1()
  local L0_2, L1_2, L2_2
  L0_2 = CurrentApartment
  if L0_2 then
    L0_2 = Notification
    L1_2 = i18n
    L1_2 = L1_2.t
    L2_2 = "creator.polyzone_nearby"
    L1_2 = L1_2(L2_2)
    L2_2 = "error"
    L0_2(L1_2, L2_2)
    L0_2 = false
    return L0_2
  end
  L0_2 = L8_1
  L0_2 = L0_2()
  if not L0_2 then
    L0_2 = Notification
    L1_2 = i18n
    L1_2 = L1_2.t
    L2_2 = "management.camera_upgrade_required"
    L1_2 = L1_2(L2_2)
    L2_2 = "error"
    L0_2(L1_2, L2_2)
    L0_2 = false
    return L0_2
  end
  L0_2 = management
  if L0_2 then
    L0_2 = management
    L0_2 = L0_2.visible
    if L0_2 then
      L0_2 = management
      L1_2 = L0_2
      L0_2 = L0_2.close
      L0_2(L1_2)
      L0_2 = SetNuiFocus
      L1_2 = false
      L2_2 = false
      L0_2(L1_2, L2_2)
      L0_2 = Wait
      L1_2 = 100
      L0_2(L1_2)
    end
  end
  L0_2 = SetLocation
  L1_2 = "tablet"
  L2_2 = true
  L0_2(L1_2, L2_2)
  L0_2 = true
  return L0_2
end
L10_1 = Config
L10_1 = L10_1.Furniture
L10_1 = L10_1.camera
L10_1 = L10_1.items
function L11_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = {}
  L1_2 = pairs
  L2_2 = decorate
  L2_2 = L2_2.objects
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = table
    L7_2 = L7_2.find
    L8_2 = L10_1
    function L9_2(A0_3)
      local L1_3, L2_3
      L1_3 = A0_3.object
      L2_3 = L6_2.modelName
      L1_3 = L1_3 == L2_3
      return L1_3
    end
    L7_2 = L7_2(L8_2, L9_2)
    if L7_2 then
      L7_2 = table
      L7_2 = L7_2.insert
      L8_2 = L0_2
      L9_2 = {}
      L9_2.id = L5_2
      L7_2(L8_2, L9_2)
    end
  end
  return L0_2
end
GetCameras = L11_1
function L11_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = nil
  L2_2 = Config
  L2_2 = L2_2.IplData
  L3_2 = A0_2.houseName
  L2_2 = L2_2[L3_2]
  if not L2_2 then
    L3_2 = nil
    return L3_2
  end
  L3_2 = L2_2.themes
  if not L3_2 then
    L3_2 = nil
    return L3_2
  end
  L3_2 = L2_2.export
  L3_2 = L3_2()
  L4_2 = pairs
  L5_2 = L2_2.themes
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = L3_2.Style
    L10_2 = L10_2.Theme
    L11_2 = L9_2.value
    L10_2 = L10_2[L11_2]
    L10_2 = L10_2.interiorId
    L11_2 = A0_2.theme
    L11_2 = L11_2.interiorId
    if L10_2 == L11_2 then
      L1_2 = L9_2.value
      break
    end
  end
  L4_2 = L2_2.themes
  L5_2 = L1_2
  return L4_2, L5_2
end
function L12_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L0_2 = {}
  L1_2 = pairs
  L2_2 = decorate
  L2_2 = L2_2.objects
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = table
    L7_2 = L7_2.find
    L8_2 = LIGHT_ITEMS
    function L9_2(A0_3)
      local L1_3, L2_3
      L1_3 = A0_3.object
      L2_3 = L6_2.modelName
      L1_3 = L1_3 == L2_3
      return L1_3
    end
    L7_2 = L7_2(L8_2, L9_2)
    if L7_2 then
      L7_2 = L6_2.lightData
      L8_2 = table
      L8_2 = L8_2.insert
      L9_2 = L0_2
      L10_2 = {}
      L10_2.id = L5_2
      L11_2 = L7_2 or L11_2
      if L7_2 then
        L11_2 = L7_2.name
      end
      if not L11_2 then
        L11_2 = i18n
        L11_2 = L11_2.t
        L12_2 = "management.light_name"
        L13_2 = {}
        L13_2.id = L5_2
        L11_2 = L11_2(L12_2, L13_2)
      end
      L10_2.name = L11_2
      L11_2 = L7_2 or L11_2
      if L7_2 then
        L11_2 = L7_2.color
      end
      if not L11_2 then
        L11_2 = "white"
      end
      L10_2.color = L11_2
      L11_2 = L7_2 or L11_2
      if L7_2 then
        L11_2 = L7_2.intensity
      end
      if not L11_2 then
        L11_2 = Config
        L11_2 = L11_2.DefaultLightIntensity
      end
      L10_2.intensity = L11_2
      L11_2 = L7_2 or L11_2
      if L7_2 then
        L11_2 = L7_2.active
      end
      if nil == L11_2 then
        L11_2 = true
      end
      L11_2 = L7_2 or L11_2
      if not L11_2 and L7_2 then
        L11_2 = L7_2.active
      end
      L10_2.active = L11_2
      L8_2(L9_2, L10_2)
    end
  end
  return L0_2
end
L13_1 = management
function L14_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = A0_2.visible
  if not L2_2 then
    return
  end
  L2_2 = A0_2.data
  if not L2_2 then
    return
  end
  if A1_2 then
    L2_2 = A0_2.house
    if L2_2 ~= A1_2 then
      return
    end
  end
  L2_2 = A0_2.data
  L2_2 = L2_2.ipl
  if L2_2 then
    L2_2 = A0_2.data
    L3_2 = A0_2.data
    L4_2 = L11_1
    L5_2 = A0_2.data
    L5_2 = L5_2.ipl
    L4_2, L5_2 = L4_2(L5_2)
    L3_2.currentTheme = L5_2
    L2_2.themes = L4_2
  end
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:getManagementData"
  L4_2 = false
  L5_2 = CurrentHouse
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = Config
  L3_2 = L3_2.Houses
  L4_2 = CurrentHouse
  L3_2 = L3_2[L4_2]
  L4_2 = A0_2.data
  L5_2 = L2_2.keyholders
  L4_2.holders = L5_2
  L4_2 = A0_2.data
  L5_2 = GetCameras
  L5_2 = L5_2()
  L4_2.cameras = L5_2
  L4_2 = A0_2.data
  L5_2 = L2_2.rents
  L4_2.rentals = L5_2
  L4_2 = A0_2.data
  L5_2 = L2_2.bills
  L4_2.bills = L5_2
  L4_2 = A0_2.data
  L5_2 = L2_2.metaKeys
  if not L5_2 then
    L5_2 = {}
  end
  L4_2.metaKeys = L5_2
  L4_2 = A0_2.data
  L5_2 = A0_2.data
  L5_2 = L5_2.upgrades
  if not L5_2 then
    L5_2 = {}
  end
  L4_2.upgrades = L5_2
  L4_2 = A0_2.data
  L5_2 = L12_1
  L5_2 = L5_2()
  L4_2.lights = L5_2
  L4_2 = A0_2.data
  L5_2 = CurrentHouseData
  L5_2 = L5_2.isOfficialOwner
  L4_2.isOfficialOwner = L5_2
  L4_2 = A0_2.data
  L5_2 = CurrentHouseData
  L5_2 = L5_2.purchasable
  L4_2.purchasable = L5_2
  L4_2 = Config
  L4_2 = L4_2.DoorBellSounds
  L4_2 = L4_2[1]
  L4_2 = L4_2.value
  L5_2 = L3_2 or L5_2
  if L3_2 then
    L5_2 = L3_2.doorbellSound
  end
  L6_2 = A0_2.data
  L7_2 = L5_2 or L7_2
  if not L5_2 or "" == L5_2 or not L5_2 then
    L7_2 = L4_2
  end
  L6_2.doorbellSound = L7_2
  L6_2 = A0_2.data
  L7_2 = not L3_2
  L6_2.assistantZoneMessagesEnabled = L7_2
  L6_2 = A0_2.data
  L7_2 = Config
  L7_2 = L7_2.DeliveriesEnabled
  L6_2.deliveriesEnabled = L7_2
  L6_2 = A0_2.data
  L7_2 = Config
  L7_2 = L7_2.DancersEnabled
  L6_2.dancersEnabled = L7_2
  L6_2 = A0_2.data
  L7_2 = Config
  L7_2 = L7_2.DeliveriesEnabled
  if L7_2 then
    L7_2 = common
    L8_2 = L7_2
    L7_2 = L7_2.getDeliveries
    L7_2 = L7_2(L8_2)
    if L7_2 then
      goto lbl_129
    end
  end
  L7_2 = {}
  L8_2 = {}
  L7_2.available = L8_2
  L8_2 = {}
  L7_2.pending = L8_2
  ::lbl_129::
  L6_2.deliveries = L7_2
  L6_2 = A0_2.data
  L7_2 = Config
  L7_2 = L7_2.DancersEnabled
  if L7_2 then
    L7_2 = common
    L8_2 = L7_2
    L7_2 = L7_2.getDancers
    L7_2 = L7_2(L8_2)
    if L7_2 then
      goto lbl_148
    end
  end
  L7_2 = {}
  L8_2 = {}
  L7_2.available = L8_2
  L8_2 = {}
  L7_2.pending = L8_2
  ::lbl_148::
  L6_2.dancers = L7_2
  L6_2 = A0_2.data
  L6_2.visible = true
  L6_2 = L3_2.mlo
  L7_2 = A0_2.data
  L7_2.isMlo = L6_2
  L7_2 = A0_2.data
  L8_2 = L3_2.photos
  if not L8_2 then
    L8_2 = {}
  end
  L7_2.photos = L8_2
  L7_2 = A0_2.data
  L8_2 = L3_2.description
  if not L8_2 then
    L8_2 = ""
  end
  L7_2.description = L8_2
  L7_2 = A0_2.data
  L8_2 = L3_2.defaultPrice
  if not L8_2 then
    L8_2 = 0
  end
  L7_2.defaultPrice = L8_2
  L7_2 = SendReactMessage
  L8_2 = "toggle_management"
  L9_2 = A0_2.data
  L7_2(L8_2, L9_2)
end
L13_1.updateUI = L14_1
L13_1 = management
function L14_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = A0_2.visible
  if L2_2 then
    L2_2 = Debug
    L3_2 = "management:open ::: management is already visible"
    return L2_2(L3_2)
  end
  L2_2 = CurrentHouse
  A0_2.house = L2_2
  L2_2 = A1_2.openSellHouseModal
  A1_2.openSellHouseModal = nil
  A0_2.data = A1_2
  A0_2.visible = true
  L4_2 = A0_2
  L3_2 = A0_2.updateUI
  L3_2(L4_2)
  if L2_2 then
    L3_2 = A0_2.data
    L3_2.openSellHouseModal = true
    L3_2 = SendReactMessage
    L4_2 = "toggle_management"
    L5_2 = A0_2.data
    L3_2(L4_2, L5_2)
    L3_2 = A0_2.data
    L3_2.openSellHouseModal = nil
  end
  L3_2 = SetNuiFocus
  L4_2 = true
  L5_2 = true
  L3_2(L4_2, L5_2)
end
L13_1.open = L14_1
L13_1 = RegisterNUICallback
L14_1 = "watch_camera"
function L15_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = decorate
  L2_2 = L2_2.objects
  L2_2 = L2_2[A0_2]
  if not L2_2 then
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "management.camera_not_found"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
    L3_2 = A1_2
    L4_2 = "error"
    return L3_2(L4_2)
  end
  L3_2 = {}
  L4_2 = L2_2.coords
  L4_2 = L4_2.x
  L3_2.x = L4_2
  L4_2 = L2_2.coords
  L4_2 = L4_2.y
  L3_2.y = L4_2
  L4_2 = L2_2.coords
  L4_2 = L4_2.z
  L3_2.z = L4_2
  L4_2 = L2_2.rotation
  L4_2 = L4_2.z
  L3_2.h = L4_2
  L4_2 = FrontDoorCam
  L5_2 = L3_2
  L6_2 = L2_2.inHouse
  L4_2(L5_2, L6_2)
  L4_2 = A1_2
  L5_2 = "ok"
  L4_2(L5_2)
end
L13_1(L14_1, L15_1)
L13_1 = exports
L14_1 = "GetSecurityCameras"
L15_1 = GetCameras
L13_1(L14_1, L15_1)
L13_1 = exports
L14_1 = "WatchSecurityCamera"
function L15_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = tonumber
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = decorate
  L2_2 = L2_2.objects
  L2_2 = L2_2[L1_2]
  if not L2_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = {}
  L4_2 = L2_2.coords
  L4_2 = L4_2.x
  L3_2.x = L4_2
  L4_2 = L2_2.coords
  L4_2 = L4_2.y
  L3_2.y = L4_2
  L4_2 = L2_2.coords
  L4_2 = L4_2.z
  L3_2.z = L4_2
  L4_2 = L2_2.rotation
  L4_2 = L4_2.z
  L3_2.h = L4_2
  L4_2 = FrontDoorCam
  L5_2 = L3_2
  L6_2 = L2_2.inHouse
  L4_2(L5_2, L6_2)
  L4_2 = true
  return L4_2
end
L13_1(L14_1, L15_1)
L13_1 = RegisterNUICallback
L14_1 = "get_nearby_players"
function L15_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:getNearbyPlayers"
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = A1_2
  L4_2 = L2_2
  L3_2(L4_2)
end
L13_1(L14_1, L15_1)
L13_1 = RegisterNUICallback
L14_1 = "give_keys"
function L15_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:giveKey"
  L4_2 = false
  L5_2 = A0_2
  L6_2 = CurrentHouse
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  if L2_2 then
    L3_2 = management
    L4_2 = L3_2
    L3_2 = L3_2.updateUI
    L3_2(L4_2)
  else
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "keyholders.keys_not_given"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  end
  L3_2 = A1_2
  L4_2 = L2_2
  L3_2(L4_2)
end
L13_1(L14_1, L15_1)
L13_1 = RegisterNUICallback
L14_1 = "give_meta_key"
function L15_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = Config
  L2_2 = L2_2.EnableMetaKey
  if not L2_2 then
    L2_2 = Notification
    L3_2 = i18n
    L3_2 = L3_2.t
    L4_2 = "no_permission"
    L3_2 = L3_2(L4_2)
    L4_2 = "error"
    L2_2(L3_2, L4_2)
    L2_2 = A1_2
    L3_2 = false
    return L2_2(L3_2)
  end
  L2_2 = TriggerServerEvent
  L3_2 = "housing:giveMetaKeyToPlayer"
  L4_2 = A0_2
  L5_2 = CurrentHouse
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L13_1(L14_1, L15_1)
L13_1 = RegisterNUICallback
L14_1 = "transfer_house"
function L15_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = CurrentHouseData
  L2_2 = L2_2.isOfficialOwner
  if not L2_2 then
    L2_2 = Notification
    L3_2 = i18n
    L3_2 = L3_2.t
    L4_2 = "you_are_not_owner"
    L3_2 = L3_2(L4_2)
    L4_2 = "error"
    L2_2(L3_2, L4_2)
    L2_2 = A1_2
    L3_2 = false
    return L2_2(L3_2)
  end
  L2_2 = TriggerServerEvent
  L3_2 = "housing:transferHouse"
  L4_2 = A0_2
  L5_2 = CurrentHouse
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = management
  L3_2 = L2_2
  L2_2 = L2_2.close
  L2_2(L3_2)
  L2_2 = SetNuiFocus
  L3_2 = false
  L4_2 = false
  L2_2(L3_2, L4_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L13_1(L14_1, L15_1)
L13_1 = RegisterNUICallback
L14_1 = "take_keys"
function L15_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:takeKey"
  L4_2 = false
  L5_2 = CurrentHouse
  L6_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  if L2_2 then
    L3_2 = A1_2
    L4_2 = true
    L3_2(L4_2)
  else
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "keyholders.keys_not_removed"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
    L3_2 = A1_2
    L4_2 = false
    L3_2(L4_2)
  end
end
L13_1(L14_1, L15_1)
L13_1 = RegisterNUICallback
L14_1 = "buy_theme"
function L15_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L3_2 = CurrentHouse
  L2_2 = L2_2[L3_2]
  L2_2 = L2_2.ipl
  L3_2 = Config
  L3_2 = L3_2.IplData
  L4_2 = L2_2.houseName
  L3_2 = L3_2[L4_2]
  L4_2 = L3_2.export
  L4_2 = L4_2()
  if not L3_2 then
    L5_2 = Notification
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "management.no_themes"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    return L5_2(L6_2, L7_2)
  end
  L5_2 = L4_2.Style
  L5_2 = L5_2.Theme
  L5_2 = L5_2[A0_2]
  L6_2 = table
  L6_2 = L6_2.find
  L7_2 = L3_2.themes
  function L8_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.value
    L2_3 = A0_2
    L1_3 = L1_3 == L2_3
    return L1_3
  end
  L6_2 = L6_2(L7_2, L8_2)
  if not L6_2 then
    L7_2 = Notification
    L8_2 = i18n
    L8_2 = L8_2.t
    L9_2 = "management.no_themes"
    L8_2 = L8_2(L9_2)
    L9_2 = "error"
    return L7_2(L8_2, L9_2)
  end
  L7_2 = TriggerServerCallback
  L8_2 = "qb-houses:buyDecorationObject"
  function L9_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3
    if not A0_3 then
      L1_3 = Notification
      L2_3 = i18n
      L2_3 = L2_3.t
      L3_3 = "no_money"
      L4_3 = {}
      L5_3 = L6_2.price
      L4_3.price = L5_3
      L2_3 = L2_3(L3_3, L4_3)
      L3_3 = "error"
      return L1_3(L2_3, L3_3)
    end
    L1_3 = TriggerServerEvent
    L2_3 = "qb-houses:UpdateIplTheme"
    L3_3 = L5_2
    L4_3 = CurrentHouse
    L1_3(L2_3, L3_3, L4_3)
  end
  L10_2 = L6_2.price
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = A1_2
  L8_2 = "ok"
  L7_2(L8_2)
end
L13_1(L14_1, L15_1)
L13_1 = RegisterNUICallback
L14_1 = "buy_upgrade"
function L15_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = table
  L2_2 = L2_2.find
  L3_2 = Config
  L3_2 = L3_2.Upgrades
  function L4_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.name
    L2_3 = A0_2
    L1_3 = L1_3 == L2_3
    return L1_3
  end
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L3_2 = A1_2
    L4_2 = false
    L3_2(L4_2)
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "upgrade_not_found"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    return L3_2(L4_2, L5_2)
  end
  L3_2 = TriggerServerCallback
  L4_2 = "housing:buyUpgrade"
  function L5_2(A0_3)
    local L1_3, L2_3
    if not A0_3 then
      L1_3 = A1_2
      L2_3 = false
      L1_3(L2_3)
      return
    end
    L1_3 = management
    L2_3 = L1_3
    L1_3 = L1_3.updateUI
    L1_3(L2_3)
    L1_3 = A0_2
    if "camera" == L1_3 then
      L1_3 = L9_1
      L1_3()
    end
    L1_3 = A1_2
    L2_3 = "ok"
    L1_3(L2_3)
  end
  L6_2 = CurrentHouse
  L7_2 = A0_2
  L3_2(L4_2, L5_2, L6_2, L7_2)
end
L13_1(L14_1, L15_1)
L13_1 = RegisterNUICallback
L14_1 = "set_upgrade_location"
function L15_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  if A0_2 then
    L2_2 = A0_2.upgrade
    if L2_2 then
      goto lbl_7
    end
  end
  L2_2 = nil
  ::lbl_7::
  if "camera" ~= L2_2 then
    L3_2 = A1_2
    L4_2 = false
    L3_2(L4_2)
    return
  end
  L3_2 = A1_2
  L4_2 = L9_1
  L4_2 = L4_2()
  L3_2(L4_2)
end
L13_1(L14_1, L15_1)
L13_1 = nil
L14_1 = RegisterNUICallback
L15_1 = "toggle_light"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = L13_1
  if L2_2 then
    L2_2 = GetGameTimer
    L2_2 = L2_2()
    L3_2 = L13_1
    L2_2 = L2_2 - L3_2
    L3_2 = 1000
    if L2_2 < L3_2 then
      L2_2 = Notification
      L3_2 = i18n
      L3_2 = L3_2.t
      L4_2 = "decorate.light_waiting"
      L3_2 = L3_2(L4_2)
      L4_2 = "error"
      L2_2(L3_2, L4_2)
      L2_2 = A1_2
      L3_2 = false
      return L2_2(L3_2)
    end
  end
  L2_2 = GetGameTimer
  L2_2 = L2_2()
  L13_1 = L2_2
  L2_2 = A0_2.id
  L3_2 = A0_2.status
  L4_2 = decorate
  L4_2 = L4_2.objects
  L4_2 = L4_2[L2_2]
  if not L4_2 then
    L5_2 = Notification
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "decorate.light_not_found"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    return L5_2(L6_2, L7_2)
  end
  L5_2 = decorate
  L5_2 = L5_2.objects
  L5_2 = L5_2[L2_2]
  L6_2 = decorate
  L6_2 = L6_2.objects
  L6_2 = L6_2[L2_2]
  L6_2 = L6_2.lightData
  if not L6_2 then
    L6_2 = {}
  end
  L5_2.lightData = L6_2
  L5_2 = decorate
  L5_2 = L5_2.objects
  L5_2 = L5_2[L2_2]
  L5_2 = L5_2.lightData
  L5_2.active = L3_2
  L5_2 = TriggerServerEvent
  L6_2 = "housing:updateObject"
  L7_2 = CurrentHouse
  L8_2 = decorate
  L8_2 = L8_2.objects
  L8_2 = L8_2[L2_2]
  L8_2 = L8_2.id
  L9_2 = {}
  L10_2 = json
  L10_2 = L10_2.encode
  L11_2 = decorate
  L11_2 = L11_2.objects
  L11_2 = L11_2[L2_2]
  L11_2 = L11_2.lightData
  L10_2 = L10_2(L11_2)
  L9_2.lightData = L10_2
  L5_2(L6_2, L7_2, L8_2, L9_2)
  L5_2 = A1_2
  L6_2 = "ok"
  L5_2(L6_2)
end
L14_1(L15_1, L16_1)
L14_1 = RegisterNUICallback
L15_1 = "save_light"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L2_2 = A0_2.id
  L3_2 = A0_2.name
  L4_2 = A0_2.color
  L5_2 = A0_2.intensity
  L6_2 = A0_2.rgb
  L7_2 = decorate
  L7_2 = L7_2.objects
  L7_2 = L7_2[L2_2]
  if not L7_2 then
    L8_2 = Notification
    L9_2 = i18n
    L9_2 = L9_2.t
    L10_2 = "decorate.light_not_found"
    L9_2 = L9_2(L10_2)
    L10_2 = "error"
    return L8_2(L9_2, L10_2)
  end
  L8_2 = decorate
  L8_2 = L8_2.objects
  L8_2 = L8_2[L2_2]
  L9_2 = {}
  L9_2.name = L3_2
  L9_2.color = L4_2
  L9_2.rgb = L6_2
  L9_2.intensity = L5_2
  L10_2 = L7_2 or L10_2
  if L7_2 then
    L10_2 = L7_2.lightData
    if L10_2 then
      L10_2 = L10_2.active
    end
  end
  if not L10_2 then
    L10_2 = true
  end
  L9_2.active = L10_2
  L8_2.lightData = L9_2
  L8_2 = TriggerServerEvent
  L9_2 = "housing:updateObject"
  L10_2 = CurrentHouse
  L11_2 = decorate
  L11_2 = L11_2.objects
  L11_2 = L11_2[L2_2]
  L11_2 = L11_2.id
  L12_2 = {}
  L13_2 = json
  L13_2 = L13_2.encode
  L14_2 = decorate
  L14_2 = L14_2.objects
  L14_2 = L14_2[L2_2]
  L14_2 = L14_2.lightData
  L13_2 = L13_2(L14_2)
  L12_2.lightData = L13_2
  L8_2(L9_2, L10_2, L11_2, L12_2)
  L8_2 = A1_2
  L9_2 = "ok"
  L8_2(L9_2)
end
L14_1(L15_1, L16_1)
L14_1 = management
function L15_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = A0_2.visible
  if not L1_2 then
    return
  end
  L1_2 = ToggleHud
  L2_2 = true
  L1_2(L2_2)
  A0_2.visible = false
  A0_2.data = nil
  L1_2 = SendReactMessage
  L2_2 = "toggle_management"
  L3_2 = {}
  L3_2.visible = false
  L1_2(L2_2, L3_2)
  L1_2 = nil
  L0_1 = L1_2
  L1_2 = RefreshClosestHouse
  L1_2()
end
L14_1.close = L15_1
L14_1 = RegisterNUICallback
L15_1 = "pay_rent"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:payRent"
  L4_2 = 0
  L5_2 = A0_2
  L6_2 = CurrentHouse
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
  if not L2_2 then
    return
  end
  L3_2 = management
  L4_2 = L3_2
  L3_2 = L3_2.updateUI
  L3_2(L4_2)
end
L14_1(L15_1, L16_1)
L14_1 = RegisterNUICallback
L15_1 = "pay_bill"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:payBill"
  L4_2 = 0
  L5_2 = A0_2
  L6_2 = CurrentHouse
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
  if not L2_2 then
    return
  end
  L3_2 = management
  L4_2 = L3_2
  L3_2 = L3_2.updateUI
  L3_2(L4_2)
end
L14_1(L15_1, L16_1)
L14_1 = RegisterNUICallback
L15_1 = "pay_all_bills"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:payAllBills"
  L4_2 = 0
  L5_2 = CurrentHouse
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
  if not L2_2 then
    return
  end
  L3_2 = management
  L4_2 = L3_2
  L3_2 = L3_2.updateUI
  L3_2(L4_2)
end
L14_1(L15_1, L16_1)
L14_1 = RegisterNUICallback
L15_1 = "update_key_permissions"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = A0_2.permissions
  L3_2 = Config
  L3_2 = L3_2.Houses
  L4_2 = CurrentHouse
  L3_2 = L3_2[L4_2]
  if not L3_2 then
    L4_2 = Notification
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "management.no_house_data"
    L5_2 = L5_2(L6_2)
    L6_2 = "error"
    return L4_2(L5_2, L6_2)
  end
  L3_2.permissions = L2_2
  L4_2 = TriggerServerEvent
  L5_2 = "housing:updatePermissions"
  L6_2 = CurrentHouse
  L7_2 = L2_2
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = A1_2
  L5_2 = "ok"
  L4_2(L5_2)
end
L14_1(L15_1, L16_1)
L14_1 = RegisterNUICallback
L15_1 = "update_doorbell_sound"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = A0_2.doorbellSound
  L3_2 = Config
  L3_2 = L3_2.Houses
  L4_2 = CurrentHouse
  L3_2 = L3_2[L4_2]
  if not L3_2 then
    L4_2 = Notification
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "management.no_house_data"
    L5_2 = L5_2(L6_2)
    L6_2 = "error"
    return L4_2(L5_2, L6_2)
  end
  L4_2 = table
  L4_2 = L4_2.includes
  L5_2 = L3_2.upgrades
  if not L5_2 then
    L5_2 = {}
  end
  L6_2 = "doorbell"
  L4_2 = L4_2(L5_2, L6_2)
  if not L4_2 then
    L5_2 = Notification
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "management.settings.doorbell.upgrade_required"
    L6_2 = L6_2(L7_2)
    if not L6_2 then
      L6_2 = "You need to purchase the Custom Doorbell upgrade to change the doorbell sound."
    end
    L7_2 = "error"
    L5_2(L6_2, L7_2)
    L5_2 = A1_2
    L6_2 = "ok"
    return L5_2(L6_2)
  end
  L3_2.doorbellSound = L2_2
  L5_2 = TriggerServerEvent
  L6_2 = "housing:updateDoorbellSound"
  L7_2 = CurrentHouse
  L8_2 = L2_2
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = A1_2
  L6_2 = "ok"
  L5_2(L6_2)
end
L14_1(L15_1, L16_1)
L14_1 = RegisterNUICallback
L15_1 = "update_assistant_zone_messages"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = A0_2 or nil
  if A0_2 then
    L2_2 = A0_2.enabled
  end
  L3_2 = Config
  L3_2 = L3_2.Houses
  L4_2 = CurrentHouse
  L3_2 = L3_2[L4_2]
  if not L3_2 then
    L4_2 = Notification
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "management.no_house_data"
    L5_2 = L5_2(L6_2)
    L6_2 = "error"
    return L4_2(L5_2, L6_2)
  end
  L4_2 = type
  L5_2 = L2_2
  L4_2 = L4_2(L5_2)
  if "boolean" ~= L4_2 then
    L2_2 = true
  end
  L3_2.assistantZoneMessagesEnabled = L2_2
  L4_2 = TriggerServerEvent
  L5_2 = "housing:updateAssistantZoneMessages"
  L6_2 = CurrentHouse
  L7_2 = L2_2
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = A1_2
  L5_2 = "ok"
  L4_2(L5_2)
end
L14_1(L15_1, L16_1)
L14_1 = RegisterNUICallback
L15_1 = "create_meta_key"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = Config
  L2_2 = L2_2.EnableMetaKey
  if not L2_2 then
    L2_2 = Notification
    L3_2 = i18n
    L3_2 = L3_2.t
    L4_2 = "metakey.system_disabled"
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
  L3_2 = "housing:createMetaKey"
  L4_2 = false
  L5_2 = CurrentHouse
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = management
  L3_2 = L2_2
  L2_2 = L2_2.updateUI
  L2_2(L3_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L14_1(L15_1, L16_1)
L14_1 = RegisterNUICallback
L15_1 = "delete_meta_key"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = Config
  L2_2 = L2_2.EnableMetaKey
  if not L2_2 then
    L2_2 = Notification
    L3_2 = i18n
    L3_2 = L3_2.t
    L4_2 = "metakey.system_disabled"
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
  L3_2 = "housing:deleteMetaKey"
  L4_2 = false
  L5_2 = CurrentHouse
  L6_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2)
  L2_2 = management
  L3_2 = L2_2
  L2_2 = L2_2.updateUI
  L2_2(L3_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L14_1(L15_1, L16_1)
L14_1 = RegisterNUICallback
L15_1 = "play_house_music"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L3_2 = CurrentHouse
  L2_2 = L2_2[L3_2]
  if not L2_2 then
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "management.no_house_data"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    return L3_2(L4_2, L5_2)
  end
  L3_2 = EnteredHouse
  if not L3_2 then
    L3_2 = L2_2.mlo
    if not L3_2 then
      L3_2 = Notification
      L4_2 = i18n
      L4_2 = L4_2.t
      L5_2 = "management.music.not_in_house"
      L4_2 = L4_2(L5_2)
      L5_2 = "error"
      L3_2(L4_2, L5_2)
      L3_2 = A1_2
      L4_2 = "error"
      return L3_2(L4_2)
    end
  end
  L3_2 = A0_2.url
  L4_2 = A0_2.volume
  if not L4_2 then
    L4_2 = 0.5
  end
  if not L3_2 or "" == L3_2 then
    L5_2 = TriggerServerEvent
    L6_2 = "housing:server:houseMusicVolume"
    L7_2 = CurrentHouse
    L8_2 = L4_2
    L5_2(L6_2, L7_2, L8_2)
    HouseSoundVolume = L4_2
  else
    L5_2 = TriggerServerEvent
    L6_2 = "housing:server:houseMusicPlay"
    L7_2 = CurrentHouse
    L8_2 = L3_2
    L9_2 = L4_2
    L5_2(L6_2, L7_2, L8_2, L9_2)
    HouseSoundPlaying = true
    HouseSoundUrl = L3_2
    HouseSoundVolume = L4_2
  end
  L5_2 = A1_2
  L6_2 = "ok"
  L5_2(L6_2)
end
L14_1(L15_1, L16_1)
L14_1 = RegisterNUICallback
L15_1 = "update_house_music_volume"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = EnteredHouse
  if L2_2 then
    L2_2 = EnteredHouse
    L3_2 = CurrentHouse
    if L2_2 == L3_2 then
      goto lbl_12
    end
  end
  L2_2 = A1_2
  L3_2 = "error"
  do return L2_2(L3_2) end
  ::lbl_12::
  L2_2 = A0_2.volume
  if not L2_2 then
    L2_2 = 0.5
  end
  L3_2 = TriggerServerEvent
  L4_2 = "housing:server:houseMusicVolume"
  L5_2 = CurrentHouse
  L6_2 = L2_2
  L3_2(L4_2, L5_2, L6_2)
  HouseSoundVolume = L2_2
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L14_1(L15_1, L16_1)
L14_1 = RegisterNUICallback
L15_1 = "stop_house_music"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = EnteredHouse
  if not L2_2 then
    L2_2 = CurrentHouse
  end
  if L2_2 then
    L3_2 = TriggerServerEvent
    L4_2 = "housing:server:houseMusicStop"
    L5_2 = L2_2
    L3_2(L4_2, L5_2)
  end
  HouseSoundPlaying = false
  HouseSoundUrl = ""
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L14_1(L15_1, L16_1)
L14_1 = RegisterNUICallback
L15_1 = "open_quick_menu"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = management
  L3_2 = L2_2
  L2_2 = L2_2.close
  L2_2(L3_2)
  L2_2 = SetNuiFocus
  L3_2 = false
  L4_2 = false
  L2_2(L3_2, L4_2)
  L2_2 = Wait
  L3_2 = 100
  L2_2(L3_2)
  L2_2 = quickMenu
  L3_2 = L2_2
  L2_2 = L2_2.open
  L2_2(L3_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L14_1(L15_1, L16_1)






