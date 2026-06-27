





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1
L0_1 = {}
HouseZones = L0_1
EnteredHouse = nil
FrontCam = false
EnteringHouse = false
CurrentHouse = nil
L0_1 = {}
L0_1.haskey = false
L0_1.isOwned = false
L0_1.isOfficialOwner = false
L0_1.rentable = false
L0_1.purchasable = false
L0_1.electricityCutOff = false
L0_1.isOwnedByMe = false
L0_1.billsCutOff = false
L0_1.lightsOn = false
CurrentHouseData = L0_1
function L0_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Config
  L0_2 = L0_2.Locale
  L1_2 = {}
  L2_2 = {}
  L1_2[L0_2] = L2_2
  L2_2 = L1_2[L0_2]
  L3_2 = _T
  L2_2.translation = L3_2
  L2_2 = L0_2
  L3_2 = L1_2
  return L2_2, L3_2
end
L1_1 = false
L2_1 = RegisterNUICallback
L3_1 = "initialized"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  while true do
    L2_2 = _T
    if L2_2 then
      break
    end
    L2_2 = Wait
    L3_2 = 200
    L2_2(L3_2)
  end
  L2_2 = L1_1
  if L2_2 then
    L2_2 = Debug
    L3_2 = "Already initialized"
    L2_2(L3_2)
    L2_2 = A1_2
    L3_2 = "ok"
    return L2_2(L3_2)
  end
  L2_2 = L0_1
  L2_2, L3_2 = L2_2()
  L4_2 = Config
  L5_2 = {}
  L6_2 = pairs
  L7_2 = L4_2.ManagementButtons
  if not L7_2 then
    L7_2 = {}
  end
  L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
  for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
    L5_2[L10_2] = L11_2
  end
  L6_2 = SendReactMessage
  L7_2 = "onUiReady"
  L8_2 = {}
  L8_2.languageName = L2_2
  L8_2.resources = L3_2
  L9_2 = {}
  L10_2 = L4_2.Debug
  L9_2.debug = L10_2
  L10_2 = GetResourceMetadata
  L11_2 = GetCurrentResourceName
  L11_2 = L11_2()
  L12_2 = "version"
  L13_2 = 0
  L10_2 = L10_2(L11_2, L12_2, L13_2)
  L9_2.version = L10_2
  L10_2 = L4_2.Intl
  L9_2.intl = L10_2
  L10_2 = L4_2.Upgrades
  L9_2.upgrades = L10_2
  L10_2 = L4_2.EnableRentable
  L9_2.rentable = L10_2
  L10_2 = L4_2.Phone
  L10_2 = "qs-smartphone" == L10_2
  L9_2.hasQsPhone = L10_2
  L10_2 = L4_2.CreditEnable
  L9_2.creditEnable = L10_2
  L10_2 = L4_2.CreditToggleActiveInDefault
  L9_2.creditToggleActiveInDefault = L10_2
  L10_2 = L4_2.Path
  L11_2 = "sounds/"
  L10_2 = L10_2 .. L11_2
  L9_2.soundPath = L10_2
  L10_2 = L4_2.ImagePath
  L9_2.imagePath = L10_2
  L10_2 = {}
  L11_2 = L4_2.EnableBoard
  L10_2.enable = L11_2
  L11_2 = L4_2.BoardObject
  L10_2.object = L11_2
  L9_2.board = L10_2
  L10_2 = L4_2.MaxApartmentCount
  L9_2.maxApartmentCount = L10_2
  L10_2 = L4_2.MoneyTypes
  L9_2.moneyTypes = L10_2
  L10_2 = L4_2.Music
  L9_2.music = L10_2
  L10_2 = L4_2.MusicVolume
  L9_2.musicVolume = L10_2
  L10_2 = L4_2.SellObjectCommision
  L9_2.sellObjectCommision = L10_2
  L9_2.managementButtons = L5_2
  L10_2 = L4_2.DoorBellSounds
  L9_2.doorBellSounds = L10_2
  L10_2 = L4_2.EnableMetaKey
  L9_2.enableMetaKey = L10_2
  L10_2 = L4_2.DecorateKeybinds
  L9_2.decorateKeybinds = L10_2
  L10_2 = L4_2.VoiceAssistant
  L9_2.voiceAssistant = L10_2
  L10_2 = L4_2.IkeaDeliveryEnabled
  L9_2.IkeaDeliveryEnabled = L10_2
  L10_2 = L4_2.IkeaDeliveryBoxModel
  L9_2.IkeaDeliveryBoxModel = L10_2
  L10_2 = L4_2.IkeaDeliveryPedModel
  L9_2.IkeaDeliveryPedModel = L10_2
  L10_2 = L4_2.IkeaDeliveryPedAnim
  L9_2.IkeaDeliveryPedAnim = L10_2
  L10_2 = L4_2.IkeaDeliveryPedAttach
  L9_2.IkeaDeliveryPedAttach = L10_2
  L8_2.config = L9_2
  L6_2(L7_2, L8_2)
  L6_2 = true
  L1_1 = L6_2
  L6_2 = TriggerServerEvent
  L7_2 = "housing:playerConnected"
  L6_2(L7_2)
  L6_2 = A1_2
  L7_2 = "ok"
  L6_2(L7_2)
  L6_2 = GetIdentifier
  L6_2 = L6_2()
  if not L6_2 then
    return
  end
  while true do
    L6_2 = HouseInitialized
    if L6_2 then
      break
    end
    L6_2 = Wait
    L7_2 = 100
    L6_2(L7_2)
  end
  L6_2 = TriggerServerCallback
  L7_2 = "qb-houses:GetInside"
  function L8_2(A0_3)
    local L1_3, L2_3, L3_3
    if A0_3 and "nil" ~= A0_3 and "" ~= A0_3 then
      L1_3 = Wait
      L2_3 = 100
      L1_3(L2_3)
      L1_3 = TriggerEvent
      L2_3 = "qb-houses:client:LastLocationHouse"
      L3_3 = A0_3
      L1_3(L2_3, L3_3)
    end
  end
  L6_2(L7_2, L8_2)
end
L2_1(L3_1, L4_1)
function L2_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = SendNUIMessage
  L3_2 = {}
  L3_2.action = A0_2
  L3_2.data = A1_2
  L2_2(L3_2)
end
SendReactMessage = L2_1
L2_1 = RegisterNUICallback
L3_1 = "notification"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = Notification
  L3_2 = A0_2.message
  L4_2 = A0_2.type
  L2_2(L3_2, L4_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "housing:notification"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = Notification
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
end
L2_1(L3_1, L4_1)
Invited = false
CurrentDoorBell = 0
HouseObj = nil
POIOffsets = nil
SHELL_DATA = nil
L2_1 = {}
L2_1.entity = nil
L2_1.selecting = false
L2_1.spawnHouse = nil
function L3_1(A0_2, ...)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = promise
  L1_2 = L1_2.new
  L1_2 = L1_2()
  if not L1_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = TriggerServerCallback
  L3_2 = A0_2
  function L4_2(...)
    local L0_3, L1_3, L2_3
    L0_3 = L1_2
    L1_3 = L0_3
    L0_3 = L0_3.resolve
    L2_3 = ...
    L0_3(L1_3, L2_3)
  end
  L5_2 = ...
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = Citizen
  L2_2 = L2_2.Await
  L3_2 = L1_2
  return L2_2(L3_2)
end
TriggerServerCallbackSync = L3_1
L3_1 = Config
L4_1 = {}
L3_1.DoorModels = L4_1
L3_1 = RegisterNetEvent
L4_1 = "qb-houses:client:EnterHouse"
L3_1(L4_1)
L3_1 = AddEventHandler
L4_1 = "qb-houses:client:EnterHouse"
function L5_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = cache
  L3_2 = L3_2.ped
  L4_2 = GetEntityCoords
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  if not A1_2 then
    A1_2 = CurrentHouse
  end
  if not A2_2 then
    A2_2 = CurrentHouseData
  end
  if not A1_2 then
    L5_2 = Debug
    L6_2 = "No Current House"
    L5_2(L6_2)
    return
  end
  L5_2 = Config
  L5_2 = L5_2.Houses
  L5_2 = L5_2[A1_2]
  L6_2 = vec3
  L7_2 = L5_2.coords
  L7_2 = L7_2.enter
  L7_2 = L7_2.x
  L8_2 = L5_2.coords
  L8_2 = L8_2.enter
  L8_2 = L8_2.y
  L9_2 = L5_2.coords
  L9_2 = L9_2.enter
  L9_2 = L9_2.z
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L6_2 = L4_2 - L6_2
  L6_2 = #L6_2
  L7_2 = 1.5
  if L6_2 < L7_2 then
    L7_2 = A2_2.haskey
    if L7_2 then
      if A0_2 then
        L7_2 = EnterIplHouse
        L8_2 = A1_2
        L7_2(L8_2)
        return
      end
      L7_2 = EnterHouse
      L8_2 = false
      L9_2 = A1_2
      L7_2(L8_2, L9_2)
    else
      L7_2 = L5_2.locked
      if not L7_2 then
        if A0_2 then
          L7_2 = EnterIplHouse
          L8_2 = A1_2
          L9_2 = true
          L7_2(L8_2, L9_2)
          return
        end
        L7_2 = EnterHouse
        L8_2 = true
        L9_2 = A1_2
        L7_2(L8_2, L9_2)
      end
    end
  end
end
L3_1(L4_1, L5_1)
L3_1 = RegisterNetEvent
L4_1 = "qb-houses:client:RequestRing"
L3_1(L4_1)
L3_1 = AddEventHandler
L4_1 = "qb-houses:client:RequestRing"
function L5_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = CurrentHouse
  if L0_2 then
    L0_2 = lib
    L0_2 = L0_2.playAnim
    L1_2 = cache
    L1_2 = L1_2.ped
    L2_2 = "gestures@f@standing@casual"
    L3_2 = "gesture_point"
    L0_2(L1_2, L2_2, L3_2)
    L0_2 = TriggerServerEvent
    L1_2 = "qb-houses:server:RingDoor"
    L2_2 = CurrentHouse
    L0_2(L1_2, L2_2)
  else
    L0_2 = Notification
    L1_2 = i18n
    L1_2 = L1_2.t
    L2_2 = "house_not_found"
    L1_2 = L1_2(L2_2)
    L2_2 = "error"
    L0_2(L1_2, L2_2)
  end
end
L3_1(L4_1, L5_1)
HouseInitialized = false
L3_1 = RegisterNetEvent
L4_1 = "housing:initHouses"
function L5_1(A0_2)
  local L1_2, L2_2
  L1_2 = Config
  L1_2.Houses = A0_2
  while true do
    L1_2 = GetIdentifier
    L1_2 = L1_2()
    if L1_2 then
      break
    end
    L1_2 = Wait
    L2_2 = 100
    L1_2(L2_2)
  end
  HouseInitialized = true
  L1_2 = CreateBlips
  L1_2()
  L1_2 = RefreshPolyZones
  L1_2()
  L1_2 = BuildDoorLocks
  L1_2()
  L1_2 = GetHouseObjects
  L1_2()
  L1_2 = Debug
  L2_2 = "Initialized House Config"
  L1_2(L2_2)
end
L3_1(L4_1, L5_1)
L3_1 = RegisterNetEvent
L4_1 = "housing:setHouse"
function L5_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  if not A0_2 then
    L2_2 = Debug
    L3_2 = "setHouse ::: No House"
    return L2_2(L3_2)
  end
  if A1_2 then
    L2_2 = type
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    if "table" == L2_2 then
      L2_2 = true
      if L2_2 then
        goto lbl_18
      end
    end
  end
  L2_2 = nil
  ::lbl_18::
  L3_2 = type
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if "table" ~= L3_2 or not A0_2 then
    L3_2 = {}
    L4_2 = A0_2
    L3_2[1] = L4_2
    A0_2 = L3_2
  end
  L3_2 = pairs
  L4_2 = A0_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    if L2_2 then
      L9_2 = table
      L9_2 = L9_2.clone
      L10_2 = A1_2
      L9_2 = L9_2(L10_2)
      if L9_2 then
        goto lbl_43
      end
    end
    L9_2 = A1_2
    ::lbl_43::
    if L9_2 then
      L10_2 = L9_2.apartmentNumber
      if L10_2 then
        L11_2 = L8_2
        L10_2 = L8_2.match
        L12_2 = "apt%-%d+"
        L10_2 = L10_2(L11_2, L12_2)
      end
      L9_2.apartmentNumber = L10_2
    else
      L10_2 = DeleteMloDoors
      L11_2 = L8_2
      L10_2(L11_2)
    end
    L10_2 = Config
    L10_2 = L10_2.Houses
    L10_2[L8_2] = L9_2
    L10_2 = CreateBlips
    L11_2 = L8_2
    L10_2(L11_2)
  end
  L3_2 = creator
  L4_2 = L3_2
  L3_2 = L3_2.updateUI
  L3_2(L4_2)
  L3_2 = RefreshPolyZones
  L3_2()
  L3_2 = BuildDoorLocks
  L3_2()
  L3_2 = Debug
  L4_2 = "Set House"
  L5_2 = "House"
  L6_2 = A0_2
  L7_2 = "Data"
  L8_2 = A1_2
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
end
L3_1(L4_1, L5_1)
L3_1 = RegisterNetEvent
L4_1 = "housing:updateHouseData"
function L5_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  if not A0_2 then
    L3_2 = Debug
    L4_2 = "updateHouseData ::: No House"
    return L3_2(L4_2)
  end
  L3_2 = Config
  L3_2 = L3_2.Houses
  L3_2 = L3_2[A0_2]
  if not L3_2 then
    L3_2 = Debug
    L4_2 = "updateHouseData ::: No Config House"
    return L3_2(L4_2)
  end
  L3_2 = true
  L4_2 = type
  L5_2 = A1_2
  L4_2 = L4_2(L5_2)
  if "table" ~= L4_2 then
    L4_2 = {}
    L5_2 = A1_2
    L4_2[1] = L5_2
    A1_2 = L4_2
    L3_2 = false
  end
  L4_2 = pairs
  L5_2 = A1_2
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    if L3_2 then
      L10_2 = Config
      L10_2 = L10_2.Houses
      L10_2 = L10_2[A0_2]
      L11_2 = A2_2[L8_2]
      L10_2[L9_2] = L11_2
    else
      L10_2 = Config
      L10_2 = L10_2.Houses
      L10_2 = L10_2[A0_2]
      L10_2[L9_2] = A2_2
    end
    L10_2 = table
    L10_2 = L10_2.includes
    L11_2 = A1_2
    L12_2 = "mlo"
    L10_2 = L10_2(L11_2, L12_2)
    if L10_2 then
      L10_2 = MLODoorsData
      L10_2[A0_2] = nil
      L10_2 = Debug
      L11_2 = "updateHouseData ::: MLO Doors Data Cleared"
      L12_2 = "House"
      L13_2 = A0_2
      L10_2(L11_2, L12_2, L13_2)
    end
  end
  L4_2 = Debug
  L5_2 = "Updated House Data"
  L6_2 = "House"
  L7_2 = A0_2
  L8_2 = "Keys"
  L9_2 = A1_2
  L10_2 = "Values"
  L11_2 = A2_2
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L4_2 = InitHouseBoards
  L4_2()
  L4_2 = EnteredHouse
  if L4_2 then
    L4_2 = RefreshClosestHouse
    L4_2()
  end
  L4_2 = table
  L4_2 = L4_2.includes
  L5_2 = A1_2
  L6_2 = "mlo"
  L4_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L4_2 = BuildDoorLocks
    L4_2()
  end
  L4_2 = table
  L4_2 = L4_2.includes
  L5_2 = A1_2
  L6_2 = "blip"
  L4_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L4_2 = CreateBlips
    L5_2 = A0_2
    L4_2(L5_2)
  end
end
L3_1(L4_1, L5_1)
L3_1 = RegisterNetEvent
L4_1 = "housing:syncLightsStatus"
function L5_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  if not A0_2 then
    return
  end
  L2_2 = CurrentHouse
  if L2_2 ~= A0_2 then
    L2_2 = EnteredHouse
    if L2_2 ~= A0_2 then
      goto lbl_46
    end
  end
  L2_2 = CurrentHouseData
  L2_2.lightsOn = A1_2
  L2_2 = Debug
  L3_2 = "Synced lights status"
  L4_2 = "House"
  L5_2 = A0_2
  L6_2 = "LightsOn"
  L7_2 = A1_2
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = EnteredHouse
  if L2_2 == A0_2 then
    L2_2 = Config
    L2_2 = L2_2.Houses
    L2_2 = L2_2[A0_2]
    if L2_2 then
      L3_2 = L2_2.mlo
      if not L3_2 then
        if A1_2 then
          L3_2 = CurrentHouseData
          L3_2 = L3_2.billsCutOff
          if not L3_2 then
            goto lbl_43
          end
        end
        L3_2 = SetArtificialLightsState
        L4_2 = true
        L3_2(L4_2)
        L3_2 = SetArtificialLightsStateAffectsVehicles
        L4_2 = false
        L3_2(L4_2)
        goto lbl_46
        ::lbl_43::
        L3_2 = SetArtificialLightsState
        L4_2 = false
        L3_2(L4_2)
      end
    end
  end
  ::lbl_46::
end
L3_1(L4_1, L5_1)
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = {}
  CurrentHouseData = L1_2
  if A0_2 then
    L1_2 = EnteredHouse
    if not L1_2 then
      CurrentHouse = A0_2
      L1_2 = Debug
      L2_2 = "RefreshClosestHouse ::: Overwrited CurrentHouse"
      L3_2 = CurrentHouse
      L1_2(L2_2, L3_2)
    end
  end
  L1_2 = EnteredHouse
  if L1_2 then
    L1_2 = EnteredHouse
    CurrentHouse = L1_2
    L1_2 = Debug
    L2_2 = "RefreshClosestHouse ::: Overwrited CurrentHouse to EnteredHouse"
    L3_2 = CurrentHouse
    L1_2(L2_2, L3_2)
  end
  L1_2 = CurrentHouse
  if not L1_2 then
    L1_2 = Debug
    L2_2 = "RefreshClosestHouse ::: No Current House"
    return L1_2(L2_2)
  end
  L1_2 = Config
  L1_2 = L1_2.Houses
  L2_2 = CurrentHouse
  L1_2 = L1_2[L2_2]
  if not L1_2 then
    L1_2 = Debug
    L2_2 = "RefreshClosestHouse ::: No Config House"
    return L1_2(L2_2)
  end
  L1_2 = TriggerServerCallbackSync
  L2_2 = "houses:getHouseData"
  L3_2 = CurrentHouse
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = L1_2 or L2_2
  if not L1_2 then
    L2_2 = {}
  end
  CurrentHouseData = L2_2
  L2_2 = CurrentHouseData
  L2_2 = L2_2.billsCutOff
  if L2_2 then
    L2_2 = CurrentHouseData
    L2_2 = L2_2.haskey
    if L2_2 then
      L2_2 = Notification
      L3_2 = i18n
      L3_2 = L3_2.t
      L4_2 = "house_not_payed_bills"
      L3_2 = L3_2(L4_2)
      L4_2 = "error"
      L2_2(L3_2, L4_2)
    end
  end
  L2_2 = TriggerHouseUpdateGarage
  L2_2()
  L2_2 = InitHouseInteractions
  L2_2()
  L2_2 = TriggerEvent
  L3_2 = "housing:handleEnterZone"
  L4_2 = CurrentHouse
  L2_2(L3_2, L4_2)
  L2_2 = TriggerServerEvent
  L3_2 = "housing:enterHouseZone"
  L4_2 = CurrentHouse
  L2_2(L3_2, L4_2)
  L2_2 = Debug
  L3_2 = "Refreshed Closest House"
  L4_2 = "CurrentHouse"
  L5_2 = CurrentHouse
  L6_2 = "CurrentHouseData"
  L7_2 = CurrentHouseData
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
end
RefreshClosestHouse = L3_1
L3_1 = exports
L4_1 = "GetCurrentHouseData"
function L5_1()
  local L0_2, L1_2
  L0_2 = CurrentHouseData
  return L0_2
end
L3_1(L4_1, L5_1)
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = CurrentApartment
  if L1_2 then
    L1_2 = L1_2.house
  end
  if not L1_2 then
    L1_2 = A0_2
  end
  CurrentHouse = L1_2
  L1_2 = Debug
  L2_2 = "HandleEnterPoly"
  L3_2 = "House"
  L4_2 = CurrentHouse
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = decorate
  L2_2 = L1_2
  L1_2 = L1_2.close
  L1_2(L2_2)
  L1_2 = TriggerEvent
  L2_2 = "weed:handleEnterZone"
  L3_2 = CurrentHouse
  L1_2(L2_2, L3_2)
  L1_2 = RefreshClosestHouse
  L1_2()
  L1_2 = common
  L2_2 = L1_2
  L1_2 = L1_2.dancersTick
  L1_2(L2_2)
  L1_2 = assistant
  L1_2 = L1_2.tick
  L1_2()
  L1_2 = decorate
  L2_2 = L1_2
  L1_2 = L1_2.getObjects
  L3_2 = CurrentHouse
  L1_2(L2_2, L3_2)
end
HandleEnterPoly = L3_1
function L3_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = sellHousePhoto
  L1_2 = L1_2.active
  if L1_2 then
    return
  end
  L1_2 = EnteredHouse
  if L1_2 then
    L1_2 = Debug
    L2_2 = "handleExitPoly blocked, cause EnteredHouse"
    return L1_2(L2_2)
  end
  L1_2 = decorate
  L1_2 = L1_2.active
  if L1_2 then
    L1_2 = Notification
    L2_2 = i18n
    L2_2 = L2_2.t
    L3_2 = "decorate.too_far"
    L2_2 = L2_2(L3_2)
    L3_2 = "error"
    L1_2(L2_2, L3_2)
    L1_2 = decorate
    L2_2 = L1_2
    L1_2 = L1_2.close
    L1_2(L2_2)
    L1_2 = Debug
    L2_2 = "handleExitPoly ::: decorate"
    L3_2 = "decorate"
    L1_2(L2_2, L3_2)
  end
  CurrentHouse = nil
  L1_2 = {}
  CurrentHouseData = L1_2
  CurrentApartment = nil
  L1_2 = TriggerHouseUpdateGarage
  L1_2()
  L1_2 = decorate
  L2_2 = L1_2
  L1_2 = L1_2.destroyObjects
  L1_2(L2_2)
  L1_2 = TriggerEvent
  L2_2 = "weed:handleExitZone"
  L1_2(L2_2)
  L1_2 = TriggerEvent
  L2_2 = "housing:handleExitZone"
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
  L1_2 = TriggerServerEvent
  L2_2 = "housing:exitHouseZone"
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = next
  L2_2 = HouseZones
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = pairs
    L2_2 = HouseZones
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L8_2 = L6_2
      L7_2 = L6_2.remove
      L7_2(L8_2)
    end
    L1_2 = {}
    HouseZones = L1_2
  end
  L1_2 = pairs
  L2_2 = Config
  L2_2 = L2_2.Houses
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = L6_2.coords
    L7_2 = L7_2.PolyZone
    if L7_2 then
      L7_2 = L6_2.apartmentNumber
      if L7_2 then
        L7_2 = L6_2.apartmentNumber
        if "apt-0" ~= L7_2 then
          goto lbl_62
        end
      end
      L7_2 = lib
      L7_2 = L7_2.zones
      L7_2 = L7_2.poly
      L8_2 = {}
      L9_2 = "setup_entry_poly"
      L10_2 = L5_2
      L9_2 = L9_2 .. L10_2
      L8_2.name = L9_2
      L9_2 = L6_2.coords
      L9_2 = L9_2.PolyZone
      L9_2 = L9_2.points
      L8_2.points = L9_2
      L9_2 = L6_2.coords
      L9_2 = L9_2.PolyZone
      L9_2 = L9_2.thickness
      L8_2.thickness = L9_2
      L9_2 = A0_2 or L9_2
      if not A0_2 then
        L9_2 = Config
        L9_2 = L9_2.ZoneDebug
      end
      L8_2.debug = L9_2
      function L9_2(A0_3)
        local L1_3, L2_3, L3_3
        L1_3 = Debug
        L2_3 = "Entered PolyZone"
        L3_3 = L5_2
        L1_3(L2_3, L3_3)
        L1_3 = HandleEnterPoly
        L2_3 = L5_2
        L1_3(L2_3)
      end
      L8_2.onEnter = L9_2
      function L9_2(A0_3)
        local L1_3, L2_3, L3_3
        L1_3 = Debug
        L2_3 = "Exited PolyZone"
        L3_3 = L5_2
        L1_3(L2_3, L3_3)
        L1_3 = L3_1
        L2_3 = L5_2
        L1_3(L2_3)
      end
      L8_2.onExit = L9_2
      L7_2 = L7_2(L8_2)
      L8_2 = HouseZones
      L8_2[L5_2] = L7_2
    end
    ::lbl_62::
  end
  L1_2 = InitHouseBoards
  L1_2()
  L1_2 = Target
  if L1_2 then
    L1_2 = Target
    L2_2 = Config
    L2_2 = L2_2.Houses
    L1_2.houses = L2_2
    L1_2 = Target
    L2_2 = L1_2
    L1_2 = L1_2.formatHouses
    L1_2(L2_2)
    L1_2 = Target
    L2_2 = L1_2
    L1_2 = L1_2.init
    L1_2(L2_2)
    L1_2 = Target
    L1_2 = L1_2.initObjectInteractions
    if L1_2 then
      L1_2 = Target
      L2_2 = L1_2
      L1_2 = L1_2.initObjectInteractions
      L1_2(L2_2)
    end
  end
end
RefreshPolyZones = L4_1
L4_1 = RegisterNetEvent
L5_1 = "qb-houses:client:lockHouse"
L4_1(L5_1)
L4_1 = AddEventHandler
L5_1 = "qb-houses:client:lockHouse"
function L6_1(A0_2, A1_2)
  local L2_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A1_2]
  L2_2.locked = A0_2
end
L4_1(L5_1, L6_1)
function L4_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L0_2 = type
  L1_2 = Config
  L1_2 = L1_2.Houses
  L0_2 = L0_2(L1_2)
  if "table" == L0_2 then
    L0_2 = pairs
    L1_2 = Config
    L1_2 = L1_2.Houses
    L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
    for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
      L6_2 = L5_2.mlo
      if L6_2 then
        L6_2 = pairs
        L7_2 = L5_2.mlo
        L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
        for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
          L12_2 = L4_2
          L13_2 = L10_2
          L12_2 = L12_2 .. L13_2
          L13_2 = Debug
          L14_2 = "BuildDoorLocks"
          L15_2 = "House"
          L16_2 = L4_2
          L17_2 = "Door"
          L18_2 = L11_2
          L13_2(L14_2, L15_2, L16_2, L17_2, L18_2)
          L13_2 = AddDoorToSystem
          L14_2 = L12_2
          L15_2 = L11_2.hash
          L16_2 = L11_2.coords
          L16_2 = L16_2.x
          L17_2 = L11_2.coords
          L17_2 = L17_2.y
          L18_2 = L11_2.coords
          L18_2 = L18_2.z
          L19_2 = false
          L20_2 = false
          L21_2 = false
          L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
          L13_2 = DoorSystemSetDoorState
          L14_2 = L12_2
          L15_2 = L11_2.locked
          if L15_2 then
            L15_2 = 1
            if L15_2 then
              goto lbl_51
            end
          end
          L15_2 = 0
          ::lbl_51::
          L16_2 = false
          L17_2 = false
          L13_2(L14_2, L15_2, L16_2, L17_2)
          L13_2 = SetStateOfClosestDoorOfType
          L14_2 = L12_2
          L15_2 = L11_2.coords
          L15_2 = L15_2.x
          L16_2 = L11_2.coords
          L16_2 = L16_2.y
          L17_2 = L11_2.coords
          L17_2 = L17_2.z
          L18_2 = L11_2.locked
          L19_2 = 0.0
          L20_2 = true
          L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
        end
      end
    end
  end
end
BuildDoorLocks = L4_1
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = Config
  L1_2 = L1_2.Houses
  L1_2 = L1_2[A0_2]
  if not L1_2 then
    L1_2 = Debug
    L2_2 = "DeleteMloDoors ::: No Config House"
    return L1_2(L2_2)
  end
  L1_2 = Config
  L1_2 = L1_2.Houses
  L1_2 = L1_2[A0_2]
  L1_2 = L1_2.mlo
  if not L1_2 then
    L1_2 = Debug
    L2_2 = "DeleteMloDoors ::: No MLO Doors"
    return L1_2(L2_2)
  end
  L1_2 = pairs
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A0_2]
  L2_2 = L2_2.mlo
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2 in L1_2, L2_2, L3_2, L4_2 do
    L6_2 = A0_2
    L7_2 = L5_2
    L6_2 = L6_2 .. L7_2
    L7_2 = RemoveDoorFromSystem
    L8_2 = L6_2
    L7_2(L8_2)
  end
end
DeleteMloDoors = L4_1
L4_1 = exports
L5_1 = "getHouseList"
function L6_1()
  local L0_2, L1_2
  while true do
    L0_2 = HouseInitialized
    if L0_2 then
      break
    end
    L0_2 = Wait
    L1_2 = 500
    L0_2(L1_2)
  end
  L0_2 = Config
  L0_2 = L0_2.Houses
  return L0_2
end
L4_1(L5_1, L6_1)
L4_1 = RegisterNetEvent
L5_1 = "qb-houses:client:toggleDoorlock"
L4_1(L5_1)
L4_1 = AddEventHandler
L5_1 = "qb-houses:client:toggleDoorlock"
function L6_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = cache
  L0_2 = L0_2.ped
  L1_2 = GetEntityCoords
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  L2_2 = Config
  L2_2 = L2_2.Houses
  L3_2 = CurrentHouse
  L2_2 = L2_2[L3_2]
  L3_2 = L2_2.mlo
  if L3_2 then
    L3_2 = L2_2.mlo
    L3_2 = L3_2[1]
    L3_2 = L3_2.locked
    L3_2 = not L3_2
    L4_2 = TriggerServerEvent
    L5_2 = "qb-houses:mloToggleAllDoors"
    L6_2 = CurrentHouse
    L7_2 = L3_2
    L4_2(L5_2, L6_2, L7_2)
    return
  end
  L3_2 = vec3
  L4_2 = L2_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.x
  L5_2 = L2_2.coords
  L5_2 = L5_2.enter
  L5_2 = L5_2.y
  L6_2 = L2_2.coords
  L6_2 = L6_2.enter
  L6_2 = L6_2.z
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L3_2 = L1_2 - L3_2
  L3_2 = #L3_2
  if L3_2 then
    L3_2 = CurrentHouseData
    L3_2 = L3_2.haskey
    if L3_2 then
      L3_2 = L2_2.locked
      if L3_2 then
        L3_2 = TriggerServerEvent
        L4_2 = "qb-houses:server:lockHouse"
        L5_2 = false
        L6_2 = CurrentHouse
        L3_2(L4_2, L5_2, L6_2)
        L3_2 = Notification
        L4_2 = i18n
        L4_2 = L4_2.t
        L5_2 = "door_unlocked"
        L4_2 = L4_2(L5_2)
        L5_2 = "info"
        L3_2(L4_2, L5_2)
      else
        L3_2 = TriggerServerEvent
        L4_2 = "qb-houses:server:lockHouse"
        L5_2 = true
        L6_2 = CurrentHouse
        L3_2(L4_2, L5_2, L6_2)
        L3_2 = Notification
        L4_2 = i18n
        L4_2 = L4_2.t
        L5_2 = "door_locked"
        L4_2 = L4_2(L5_2)
        L5_2 = "info"
        L3_2(L4_2, L5_2)
      end
    else
      L3_2 = Notification
      L4_2 = i18n
      L4_2 = L4_2.t
      L5_2 = "not_have_keys"
      L4_2 = L4_2(L5_2)
      L5_2 = "error"
      L3_2(L4_2, L5_2)
    end
  else
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "house_not_found"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  end
end
L4_1(L5_1, L6_1)
L4_1 = RegisterNetEvent
L5_1 = "qb-houses:requiredLeaveHouse"
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = type
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if "table" ~= L1_2 or not A0_2 then
    L1_2 = {}
    L2_2 = A0_2
    L1_2[1] = L2_2
    A0_2 = L1_2
  end
  L1_2 = pairs
  L2_2 = A0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = EnteredHouse
    if L7_2 == L6_2 then
      L7_2 = Config
      L7_2 = L7_2.Houses
      L8_2 = EnteredHouse
      L7_2 = L7_2[L8_2]
      L8_2 = L7_2.ipl
      if L8_2 then
        L8_2 = LeaveIplHouse
        L9_2 = EnteredHouse
        L10_2 = true
        L8_2(L9_2, L10_2)
      else
        L8_2 = LeaveHouse
        L8_2()
      end
      L8_2 = Notification
      L9_2 = i18n
      L9_2 = L9_2.t
      L10_2 = "kick_house"
      L9_2 = L9_2(L10_2)
      L10_2 = "info"
      L8_2(L9_2, L10_2)
    end
  end
end
L4_1(L5_1, L6_1)
function L4_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = PlayAnimation
  L1_2 = cache
  L1_2 = L1_2.ped
  L2_2 = "anim@heists@keycard@"
  L3_2 = "exit"
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = Wait
  L1_2 = 400
  L0_2(L1_2)
  L0_2 = ClearPedTasks
  L1_2 = cache
  L1_2 = L1_2.ped
  L0_2(L1_2)
end
DoorAnim = L4_1
L4_1 = RegisterNetEvent
L5_1 = "qb-houses:client:RingDoor"
L4_1(L5_1)
L4_1 = AddEventHandler
L5_1 = "qb-houses:client:RingDoor"
function L6_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = EnteredHouse
  if L2_2 == A1_2 then
    CurrentDoorBell = A0_2
    L2_2 = PlayDoorbell
    L3_2 = A1_2
    L2_2(L3_2)
  end
end
L4_1(L5_1, L6_1)
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = EnteredHouse
  if L1_2 ~= A0_2 then
    L1_2 = Debug
    L2_2 = "PlayDoorbell ::: Not Entered House"
    L3_2 = "EnteredHouse"
    L4_2 = EnteredHouse
    L5_2 = "House"
    L6_2 = A0_2
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
    return
  end
  L1_2 = Config
  L1_2 = L1_2.DisableInteractSound
  if not L1_2 then
    L1_2 = EnteredHouse
    if L1_2 then
      L1_2 = Config
      L1_2 = L1_2.Houses
      L2_2 = EnteredHouse
      L1_2 = L1_2[L2_2]
      if L1_2 then
        L2_2 = L1_2.doorbellSound
        if not L2_2 then
          L2_2 = Config
          L2_2 = L2_2.DoorBellSounds
          L2_2 = L2_2[1]
          L2_2 = L2_2.value
        end
        L3_2 = SendReactMessage
        L4_2 = "play_sound"
        L5_2 = {}
        L5_2.sound = L2_2
        L3_2(L4_2, L5_2)
        L3_2 = Notification
        L4_2 = i18n
        L4_2 = L4_2.t
        L5_2 = "ring_door"
        L4_2 = L4_2(L5_2)
        L5_2 = "info"
        L3_2(L4_2, L5_2)
      end
    end
  end
end
PlayDoorbell = L4_1
L4_1 = RegisterNetEvent
L5_1 = "housing:playDoorbell"
L6_1 = PlayDoorbell
L4_1(L5_1, L6_1)
L4_1 = RegisterNetEvent
L5_1 = "qb-houses:client:SpawnInApartment"
L4_1(L5_1)
L4_1 = AddEventHandler
L5_1 = "qb-houses:client:SpawnInApartment"
function L6_1(A0_2)
  local L1_2, L2_2, L3_2
  CurrentHouse = A0_2
  Invited = true
  L1_2 = Config
  L1_2 = L1_2.Houses
  L1_2 = L1_2[A0_2]
  L1_2 = L1_2.ipl
  if not L1_2 then
    L1_2 = EnterHouse
    L2_2 = true
    L3_2 = A0_2
    L1_2(L2_2, L3_2)
  else
    L1_2 = EnterIplHouse
    L2_2 = A0_2
    L3_2 = true
    L1_2(L2_2, L3_2)
  end
end
L4_1(L5_1, L6_1)
L4_1 = exports
L5_1 = "getHouseData"
function L6_1(A0_2)
  local L1_2
  L1_2 = Config
  L1_2 = L1_2.Houses
  L1_2 = L1_2[A0_2]
  return L1_2
end
L4_1(L5_1, L6_1)
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  if not A1_2 then
    A1_2 = CurrentHouse
    L2_2 = Debug
    L3_2 = "No House Passed, Using Current House"
    L4_2 = "CurrentHouse"
    L5_2 = CurrentHouse
    L2_2(L3_2, L4_2, L5_2)
  end
  if not A1_2 then
    L2_2 = Notification
    L3_2 = i18n
    L3_2 = L3_2.t
    L4_2 = "house_not_found"
    L3_2 = L3_2(L4_2)
    L4_2 = "error"
    return L2_2(L3_2, L4_2)
  end
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
  L3_2 = L2_2.tier
  L4_2 = Config
  L4_2 = L4_2.Shells
  L4_2 = L4_2[L3_2]
  if not L4_2 then
    L5_2 = print
    L6_2 = "Tier is not valid"
    L5_2(L6_2)
    return
  end
  L5_2 = L2_2.coords
  L5_2 = L5_2.exit
  if not L5_2 then
    L5_2 = DoScreenFadeIn
    L6_2 = 0
    L5_2(L6_2)
    L5_2 = Notification
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "we_cant_find_exit_zone"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    L5_2(L6_2, L7_2)
    L5_2 = RayCastSelector
    L6_2 = "exit"
    L7_2 = {}
    L8_2 = L2_2.tier
    L7_2.tier = L8_2
    L8_2 = vec4
    L9_2 = L2_2.coords
    L9_2 = L9_2.shellCoords
    L9_2 = L9_2.x
    L10_2 = L2_2.coords
    L10_2 = L10_2.shellCoords
    L10_2 = L10_2.y
    L11_2 = L2_2.coords
    L11_2 = L11_2.shellCoords
    L11_2 = L11_2.z
    L12_2 = L2_2.coords
    L12_2 = L12_2.shellCoords
    L12_2 = L12_2.h
    L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
    L7_2.coords = L8_2
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = TriggerServerEvent
    L7_2 = "housing:updateExitCoords"
    L8_2 = A1_2
    L9_2 = L5_2
    L6_2(L7_2, L8_2, L9_2)
    return
  end
  EnteredHouse = A1_2
  L5_2 = CurrentHouse
  if not L5_2 then
    L5_2 = Debug
    L6_2 = "EnterHouse ::: Forcing to set current house"
    L5_2(L6_2)
    L5_2 = HandleEnterPoly
    L6_2 = A1_2
    L5_2(L6_2)
  end
  L5_2 = Wait
  L6_2 = 300
  L5_2(L6_2)
  L5_2 = Config
  L5_2 = L5_2.DisableInteractSound
  if not L5_2 then
    L5_2 = TriggerServerEvent
    L6_2 = "InteractSound_SV:PlayOnSource"
    L7_2 = "houses_door_open"
    L8_2 = 0.25
    L5_2(L6_2, L7_2, L8_2)
  end
  L5_2 = TriggerServerEvent
  L6_2 = "qs-housing:enableAntiTeleport"
  L5_2(L6_2)
  L5_2 = DoorAnim
  L5_2()
  L5_2 = Citizen
  L5_2 = L5_2.Wait
  L6_2 = 250
  L5_2(L6_2)
  L5_2 = lib
  L5_2 = L5_2.callback
  L5_2 = L5_2.await
  L6_2 = "housing:routePlayer"
  L7_2 = false
  L8_2 = A1_2
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = CurrentHouseData
  L5_2 = L5_2.haskey
  L5_2 = Invited
  L5_2 = not L5_2 and L5_2
  L6_2 = table
  L6_2 = L6_2.includes
  L7_2 = L2_2.upgrades
  L8_2 = "sensor"
  L6_2 = L6_2(L7_2, L8_2)
  if L6_2 and L5_2 then
    L6_2 = SensorDispatch
    L6_2()
  end
  L6_2 = CreateShell
  L7_2 = L2_2.coords
  L7_2 = L7_2.shellCoords
  L8_2 = L2_2.coords
  L8_2 = L8_2.exit
  L9_2 = L4_2.model
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  SHELL_DATA = L6_2
  L6_2 = Citizen
  L6_2 = L6_2.Wait
  L7_2 = 100
  L6_2(L7_2)
  L6_2 = SHELL_DATA
  L6_2 = L6_2[1]
  HouseObj = L6_2
  L6_2 = SHELL_DATA
  L6_2 = L6_2[2]
  POIOffsets = L6_2
  L6_2 = Target
  if L6_2 then
    L6_2 = Target
    L7_2 = L6_2
    L6_2 = L6_2.initExit
    L6_2(L7_2)
  end
  EnteringHouse = true
  L6_2 = TriggerServerEvent
  L7_2 = "housing:setInside"
  L8_2 = A1_2
  L9_2 = true
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = Wait
  L7_2 = 500
  L6_2(L7_2)
  L6_2 = SetRainFxIntensity
  L7_2 = 0.0
  L6_2(L7_2)
  L6_2 = WeatherSyncEvent
  L7_2 = true
  L6_2(L7_2)
  L6_2 = decorate
  L7_2 = L6_2
  L6_2 = L6_2.getObjects
  L8_2 = A1_2
  L6_2(L7_2, L8_2)
  L6_2 = InitHouseInteractions
  L7_2 = A1_2
  L6_2(L7_2)
  L6_2 = TriggerEvent
  L7_2 = "qb-weed:client:getHousePlants"
  L8_2 = A1_2
  L6_2(L7_2, L8_2)
  L6_2 = Citizen
  L6_2 = L6_2.Wait
  L7_2 = 100
  L6_2(L7_2)
  L6_2 = SetWeatherTypePersist
  L7_2 = "EXTRASUNNY"
  L6_2(L7_2)
  L6_2 = SetWeatherTypeNow
  L7_2 = "EXTRASUNNY"
  L6_2(L7_2)
  L6_2 = SetWeatherTypeNowPersist
  L7_2 = "EXTRASUNNY"
  L6_2(L7_2)
  L6_2 = NetworkOverrideClockTime
  L7_2 = Config
  L7_2 = L7_2.TimeInterior
  L8_2 = 0
  L9_2 = 0
  L6_2(L7_2, L8_2, L9_2)
  EnteringHouse = false
  if A0_2 then
    inOwned = true
  end
  L6_2 = CurrentHouseData
  L6_2 = L6_2.billsCutOff
  if not L6_2 then
    L6_2 = CurrentHouseData
    L6_2 = L6_2.lightsOn
    if L6_2 then
      goto lbl_229
    end
  end
  L6_2 = SetArtificialLightsState
  L7_2 = true
  L6_2(L7_2)
  L6_2 = SetArtificialLightsStateAffectsVehicles
  L7_2 = false
  L6_2(L7_2)
  ::lbl_229::
  L6_2 = TriggerEvent
  L7_2 = "housing:onEnterHouse"
  L8_2 = A1_2
  L6_2(L7_2, L8_2)
end
EnterHouse = L4_1
L4_1 = RegisterNetEvent
L5_1 = "qb-houses:client:enterOwnedHouse"
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = Config
  L1_2 = L1_2.Houses
  L1_2 = L1_2[A0_2]
  if not L1_2 then
    L2_2 = Notification
    L3_2 = i18n
    L3_2 = L3_2.t
    L4_2 = "house_not_found"
    L3_2 = L3_2(L4_2)
    L4_2 = "error"
    return L2_2(L3_2, L4_2)
  end
  L2_2 = L1_2.ipl
  if L2_2 then
    L2_2 = EnterIplHouse
    L3_2 = A0_2
    L2_2(L3_2)
  else
    L2_2 = L1_2.coords
    L2_2 = L2_2.test
    if L2_2 then
      L2_2 = SetEntityCoords
      L3_2 = cache
      L3_2 = L3_2.ped
      L4_2 = L1_2.coords
      L4_2 = L4_2.test
      L4_2 = L4_2.x
      L5_2 = L1_2.coords
      L5_2 = L5_2.test
      L5_2 = L5_2.y
      L6_2 = L1_2.coords
      L6_2 = L6_2.test
      L6_2 = L6_2.z
      L2_2(L3_2, L4_2, L5_2, L6_2)
    else
      L2_2 = EnterHouse
      L3_2 = false
      L4_2 = A0_2
      L2_2(L3_2, L4_2)
    end
  end
end
L4_1(L5_1, L6_1)
L4_1 = RegisterNetEvent
L5_1 = "qb-houses:client:LastLocationHouse"
L4_1(L5_1)
L4_1 = AddEventHandler
L5_1 = "qb-houses:client:LastLocationHouse"
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  if not A0_2 then
    L1_2 = Notification
    L2_2 = i18n
    L2_2 = L2_2.t
    L3_2 = "house_not_found"
    L2_2 = L2_2(L3_2)
    L3_2 = "error"
    return L1_2(L2_2, L3_2)
  end
  L1_2 = Config
  L1_2 = L1_2.Houses
  L1_2 = L1_2[A0_2]
  if not L1_2 then
    L1_2 = Notification
    L2_2 = i18n
    L2_2 = L2_2.t
    L3_2 = "house_not_found"
    L2_2 = L2_2(L3_2)
    L3_2 = "error"
    return L1_2(L2_2, L3_2)
  end
  L1_2 = Config
  L1_2 = L1_2.Houses
  L1_2 = L1_2[A0_2]
  L1_2 = L1_2.ipl
  if not L1_2 then
    L1_2 = EnterHouse
    L2_2 = false
    L3_2 = A0_2
    L1_2(L2_2, L3_2)
  else
    L1_2 = EnterIplHouse
    L2_2 = A0_2
    L1_2(L2_2)
  end
  L1_2 = Debug
  L2_2 = "Last Location House"
  L3_2 = "House"
  L4_2 = A0_2
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = RefreshClosestHouse
  L2_2 = A0_2
  L1_2(L2_2)
end
L4_1(L5_1, L6_1)
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = Debug
  L2_2 = "LeaveHouse"
  L3_2 = "House"
  L4_2 = A0_2
  L1_2(L2_2, L3_2, L4_2)
  if not A0_2 then
    A0_2 = EnteredHouse
    L1_2 = Debug
    L2_2 = "No House Passed, Using Current House"
    L3_2 = "EnteredHouse"
    L4_2 = EnteredHouse
    L1_2(L2_2, L3_2, L4_2)
  end
  if not A0_2 then
    L1_2 = Notification
    L2_2 = i18n
    L2_2 = L2_2.t
    L3_2 = "house_not_found"
    L2_2 = L2_2(L3_2)
    L3_2 = "error"
    return L1_2(L2_2, L3_2)
  end
  L1_2 = Config
  L1_2 = L1_2.Houses
  L1_2 = L1_2[A0_2]
  if not L1_2 then
    L1_2 = Notification
    L2_2 = i18n
    L2_2 = L2_2.t
    L3_2 = "house_not_found"
    L2_2 = L2_2(L3_2)
    L3_2 = "error"
    return L1_2(L2_2, L3_2)
  end
  L1_2 = Config
  L1_2 = L1_2.Houses
  L1_2 = L1_2[A0_2]
  L2_2 = Config
  L2_2 = L2_2.DisableInteractSound
  if not L2_2 then
    L2_2 = TriggerServerEvent
    L3_2 = "InteractSound_SV:PlayOnSource"
    L4_2 = "houses_door_open"
    L5_2 = 0.25
    L2_2(L3_2, L4_2, L5_2)
  end
  L2_2 = DoorAnim
  L2_2()
  L2_2 = Citizen
  L2_2 = L2_2.Wait
  L3_2 = 250
  L2_2(L3_2)
  L2_2 = DoScreenFadeOut
  L3_2 = 250
  L2_2(L3_2)
  L2_2 = Citizen
  L2_2 = L2_2.Wait
  L3_2 = 500
  L2_2(L3_2)
  L2_2 = DespawnInterior
  L3_2 = HouseObj
  function L4_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = WeatherSyncEvent
    L1_3 = false
    L0_3(L1_3)
    L0_3 = Citizen
    L0_3 = L0_3.Wait
    L1_3 = 250
    L0_3(L1_3)
    L0_3 = DoScreenFadeIn
    L1_3 = 250
    L0_3(L1_3)
    L0_3 = SetEntityCoords
    L1_3 = cache
    L1_3 = L1_3.ped
    L2_3 = L1_2.coords
    L2_3 = L2_3.enter
    L2_3 = L2_3.x
    L3_3 = L1_2.coords
    L3_3 = L3_3.enter
    L3_3 = L3_3.y
    L4_3 = L1_2.coords
    L4_3 = L4_3.enter
    L4_3 = L4_3.z
    L4_3 = L4_3 + 0.2
    L0_3(L1_3, L2_3, L3_3, L4_3)
    L0_3 = SetEntityHeading
    L1_3 = cache
    L1_3 = L1_3.ped
    L2_3 = L1_2.coords
    L2_3 = L2_3.enter
    L2_3 = L2_3.h
    L0_3(L1_3, L2_3)
    L0_3 = TriggerServerEvent
    L1_3 = "housing:routePlayerToDefault"
    L2_3 = A0_2
    L0_3(L1_3, L2_3)
    inOwned = false
    L0_3 = TriggerServerEvent
    L1_3 = "housing:setInside"
    L2_3 = A0_2
    L3_3 = false
    L0_3(L1_3, L2_3, L3_3)
    L0_3 = TriggerEvent
    L1_3 = "housing:onExitHouse"
    L2_3 = A0_2
    L0_3(L1_3, L2_3)
    EnteredHouse = nil
    L0_3 = Target
    if L0_3 then
      L0_3 = Target
      L1_3 = L0_3
      L0_3 = L0_3.destroyExit
      L0_3(L1_3)
    end
    Invited = false
    ShowingHouse = false
    L0_3 = CurrentApartment
    if L0_3 then
      L0_3 = CurrentApartment
      L0_3 = L0_3.house
      CurrentHouse = L0_3
      L0_3 = CurrentApartment
      L0_3 = L0_3.currentHouseData
      CurrentHouseData = L0_3
      CurrentApartment = nil
    end
    L0_3 = TriggerServerEvent
    L1_3 = "qs-housing:disableAntiTeleport"
    L0_3(L1_3)
    L0_3 = Wait
    L1_3 = 300
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2)
  L2_2 = SetArtificialLightsState
  L3_2 = false
  L2_2(L3_2)
end
LeaveHouse = L4_1
L4_1 = exports
L5_1 = "getCurrentHouse"
function L6_1()
  local L0_2, L1_2
  L0_2 = CurrentHouse
  return L0_2
end
L4_1(L5_1, L6_1)
L4_1 = exports
L5_1 = "getEnteredHouse"
function L6_1()
  local L0_2, L1_2
  L0_2 = EnteredHouse
  return L0_2
end
L4_1(L5_1, L6_1)
L4_1 = RegisterNetEvent
L5_1 = "housing:refreshHouse"
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = CreateBlips
  L2_2 = A0_2
  L1_2(L2_2)
  L1_2 = Debug
  L2_2 = "Refreshed House"
  L3_2 = "House"
  L4_2 = A0_2
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = CurrentHouse
  if L1_2 == A0_2 then
    L1_2 = RefreshClosestHouse
    L2_2 = A0_2
    L1_2(L2_2)
  end
  L1_2 = management
  L2_2 = L1_2
  L1_2 = L1_2.updateUI
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L4_1(L5_1, L6_1)
L4_1 = {}
L5_1 = RegisterNetEvent
L6_1 = "housing:toggleInSecurityCam"
function L7_1(A0_2, A1_2)
  local L2_2
  L2_2 = L4_1
  L2_2[A0_2] = A1_2
end
L5_1(L6_1, L7_1)
L5_1 = CreateThread
function L6_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  while true do
    L0_2 = pairs
    L1_2 = L4_1
    L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
    for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
      L6_2 = GetPlayerFromServerId
      L7_2 = L4_2
      L6_2 = L6_2(L7_2)
      if L6_2 and -1 ~= L6_2 then
        L7_2 = PlayerId
        L7_2 = L7_2()
        if L6_2 ~= L7_2 then
          L7_2 = GetPlayerPed
          L8_2 = L6_2
          L7_2 = L7_2(L8_2)
          L8_2 = GetEntityAlpha
          L9_2 = L7_2
          L8_2 = L8_2(L9_2)
          if "deleted" == L5_2 then
            L9_2 = SetEntityAlpha
            L10_2 = L7_2
            L11_2 = 255
            L12_2 = false
            L9_2(L10_2, L11_2, L12_2)
            L9_2 = SetEntityVisible
            L10_2 = L7_2
            L11_2 = true
            L12_2 = false
            L9_2(L10_2, L11_2, L12_2)
            L9_2 = L4_1
            L9_2[L4_2] = nil
            L9_2 = Debug
            L10_2 = "housing:toggleInSecurityCam deleted"
            L11_2 = L4_2
            L9_2(L10_2, L11_2)
          elseif 0 ~= L8_2 then
            L9_2 = SetEntityAlpha
            L10_2 = L7_2
            L11_2 = 0
            L12_2 = false
            L9_2(L10_2, L11_2, L12_2)
            L9_2 = SetEntityVisible
            L10_2 = L7_2
            L11_2 = false
            L12_2 = false
            L9_2(L10_2, L11_2, L12_2)
            L9_2 = Debug
            L10_2 = "housing:toggleInSecurityCam alpha setted to 0"
            L11_2 = L4_2
            L9_2(L10_2, L11_2)
          end
        end
      end
    end
    L0_2 = Wait
    L1_2 = 500
    L0_2(L1_2)
  end
end
L5_1(L6_1)
L5_1 = exports
L6_1 = "enterHouse"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A0_2]
  if not L2_2 then
    L2_2 = Error
    L3_2 = "enterHouse ::: No Config House"
    L4_2 = "House"
    L5_2 = A0_2
    return L2_2(L3_2, L4_2, L5_2)
  end
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A0_2]
  L2_2 = L2_2.ipl
  if L2_2 then
    L2_2 = EnterIplHouse
    L3_2 = A0_2
    L4_2 = A1_2
    L2_2(L3_2, L4_2)
    L2_2 = Debug
    L3_2 = "enterHouse ::: Entering IPL House"
    L4_2 = "House"
    L5_2 = A0_2
    L2_2(L3_2, L4_2, L5_2)
  else
    L2_2 = EnterHouse
    L3_2 = A1_2
    L4_2 = A0_2
    L2_2(L3_2, L4_2)
    L2_2 = Debug
    L3_2 = "enterHouse ::: Entering House"
    L4_2 = "House"
    L5_2 = A0_2
    L2_2(L3_2, L4_2, L5_2)
  end
end
L5_1(L6_1, L7_1)
L5_1 = AddEventHandler
L6_1 = "housing:radial:enterHouse"
function L7_1()
  local L0_2, L1_2
  L0_2 = EnterHouse
  L0_2()
end
L5_1(L6_1, L7_1)
L5_1 = AddEventHandler
L6_1 = "housing:radial:exitHouse"
function L7_1()
  local L0_2, L1_2
  L0_2 = LeaveHouse
  L0_2()
end
L5_1(L6_1, L7_1)
function L5_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = SendReactMessage
  L4_2 = "toggle_camera"
  L5_2 = {}
  L5_2.visible = A0_2
  L5_2.label = A1_2
  L5_2.type = A2_2
  L3_2(L4_2, L5_2)
end
ToggleCameraUI = L5_1
function L5_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L3_2 = CurrentHouse
  L2_2 = L2_2[L3_2]
  L3_2 = vec4
  L4_2 = A0_2.x
  L5_2 = A0_2.y
  L6_2 = A0_2.z
  L7_2 = A0_2.h
  if not L7_2 then
    L7_2 = 0.0
  end
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  A0_2 = L3_2
  L3_2 = DoScreenFadeOut
  L4_2 = 150
  L3_2(L4_2)
  L3_2 = Wait
  L4_2 = 500
  L3_2(L4_2)
  L3_2 = Debug
  L4_2 = "FrontDoorCam"
  L5_2 = "coords"
  L6_2 = A0_2
  L7_2 = "cameraInHouse"
  L8_2 = A1_2
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = GetCoordsWithOffset
  L4_2 = A0_2
  L5_2 = vec3
  L6_2 = -0.4
  L7_2 = 0.0
  L8_2 = 0.0
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L5_2(L6_2, L7_2, L8_2)
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L4_2 = Utils
  L4_2 = L4_2.CreateCamera
  L5_2 = "DEFAULT_SCRIPTED_CAMERA"
  L6_2 = L3_2
  L7_2 = vec3
  L8_2 = 0.0
  L9_2 = 0.0
  L10_2 = A0_2.w
  L10_2 = L10_2 - 180.0
  L7_2 = L7_2(L8_2, L9_2, L10_2)
  L8_2 = true
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  FrontCam = true
  L5_2 = SetEntityAlpha
  L6_2 = cache
  L6_2 = L6_2.ped
  L7_2 = 0
  L8_2 = false
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = SetEntityVisible
  L6_2 = cache
  L6_2 = L6_2.ped
  L7_2 = false
  L8_2 = false
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = FreezeEntityPosition
  L6_2 = cache
  L6_2 = L6_2.ped
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = TriggerServerEvent
  L6_2 = "housing:toggleInSecurityCam"
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = A1_2 or L5_2
  if A1_2 then
    L5_2 = EnteredHouse
    L5_2 = not L5_2
  end
  L6_2 = not A1_2 and L6_2
  L7_2 = L2_2.upgrades
  if L7_2 then
    L7_2 = table
    L7_2 = L7_2.includes
    L8_2 = L2_2.upgrades
    L9_2 = "camera"
    L7_2 = L7_2(L8_2, L9_2)
  end
  if L5_2 then
    L8_2 = SetEntityAlpha
    L9_2 = cache
    L9_2 = L9_2.ped
    L10_2 = 0
    L11_2 = false
    L8_2(L9_2, L10_2, L11_2)
    L8_2 = SetEntityVisible
    L9_2 = cache
    L9_2 = L9_2.ped
    L10_2 = false
    L11_2 = false
    L8_2(L9_2, L10_2, L11_2)
    L8_2 = L2_2.ipl
    if L8_2 then
      L8_2 = EnterIplHouse
      L9_2 = CurrentHouse
      L8_2(L9_2)
    else
      L8_2 = EnterHouse
      L8_2()
    end
  elseif L6_2 then
    L8_2 = L2_2.ipl
    if L8_2 then
      L8_2 = LeaveIplHouse
      L9_2 = CurrentHouse
      L8_2(L9_2)
    else
      L8_2 = LeaveHouse
      L8_2()
    end
  end
  L8_2 = Wait
  L9_2 = 500
  L8_2(L9_2)
  L8_2 = DoScreenFadeIn
  L9_2 = 150
  L8_2(L9_2)
  L8_2 = ToggleCameraUI
  L9_2 = true
  L10_2 = L2_2.address
  if L7_2 then
    L11_2 = "modern"
    if L11_2 then
      goto lbl_139
    end
  end
  L11_2 = "peephole"
  ::lbl_139::
  L8_2(L9_2, L10_2, L11_2)
  L8_2 = Utils
  L8_2 = L8_2.DrawInstructional
  L9_2 = {}
  L10_2 = {}
  L10_2.key = "cancel"
  L10_2.label = "Exit"
  L9_2[1] = L10_2
  L8_2(L9_2)
  L8_2 = CreateThread
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    while true do
      L0_3 = FrontCam
      if not L0_3 then
        break
      end
      L0_3 = Wait
      L1_3 = 0
      L0_3(L1_3)
      L0_3 = Utils
      L0_3 = L0_3.HandleFlyCam
      L1_3 = L4_2
      L2_3 = {}
      L2_3.mouse = true
      L2_3.keyboard = false
      L0_3(L1_3, L2_3)
      L0_3 = SetTimecycleModifier
      L1_3 = "scanline_cam_cheap"
      L0_3(L1_3)
      L0_3 = SetTimecycleModifierStrength
      L1_3 = 1.0
      L0_3(L1_3)
      L0_3 = SetEntityInvincible
      L1_3 = cache
      L1_3 = L1_3.ped
      L2_3 = true
      L0_3(L1_3, L2_3)
      L0_3 = IsControlJustPressed
      L1_3 = 1
      L2_3 = Keys
      L2_3 = L2_3.BACKSPACE
      L0_3 = L0_3(L1_3, L2_3)
      if L0_3 then
        L0_3 = DoScreenFadeOut
        L1_3 = 150
        L0_3(L1_3)
        L0_3 = ToggleCameraUI
        L1_3 = false
        L0_3(L1_3)
        L0_3 = Citizen
        L0_3 = L0_3.Wait
        L1_3 = 500
        L0_3(L1_3)
        L0_3 = Utils
        L0_3 = L0_3.DestroyFlyCam
        L1_3 = L4_2
        L0_3(L1_3)
        L0_3 = ClearTimecycleModifier
        L0_3()
        FrontCam = false
        L0_3 = SetEntityAlpha
        L1_3 = cache
        L1_3 = L1_3.ped
        L2_3 = 255
        L3_3 = false
        L0_3(L1_3, L2_3, L3_3)
        L0_3 = SetEntityVisible
        L1_3 = cache
        L1_3 = L1_3.ped
        L2_3 = true
        L3_3 = false
        L0_3(L1_3, L2_3, L3_3)
        L0_3 = L5_2
        if L0_3 then
          L0_3 = L2_2.ipl
          if L0_3 then
            L0_3 = LeaveIplHouse
            L1_3 = CurrentHouse
            L0_3(L1_3)
          else
            L0_3 = LeaveHouse
            L0_3()
          end
        else
          L0_3 = L6_2
          if L0_3 then
            L0_3 = L2_2.ipl
            if L0_3 then
              L0_3 = EnterIplHouse
              L1_3 = CurrentHouse
              L0_3(L1_3)
            else
              L0_3 = EnterHouse
              L0_3()
            end
          end
        end
        L0_3 = FreezeEntityPosition
        L1_3 = cache
        L1_3 = L1_3.ped
        L2_3 = false
        L0_3(L1_3, L2_3)
        L0_3 = TriggerServerEvent
        L1_3 = "housing:toggleInSecurityCam"
        L2_3 = false
        L0_3(L1_3, L2_3)
        L0_3 = Citizen
        L0_3 = L0_3.Wait
        L1_3 = 500
        L0_3(L1_3)
        L0_3 = DoScreenFadeIn
        L1_3 = 150
        L0_3(L1_3)
      end
    end
    L0_3 = Utils
    L0_3 = L0_3.RemoveInstructional
    L0_3()
    L0_3 = SetEntityInvincible
    L1_3 = cache
    L1_3 = L1_3.ped
    L2_3 = false
    L0_3(L1_3, L2_3)
  end
  L8_2(L9_2)
end
FrontDoorCam = L5_1
L5_1 = RegisterNetEvent
L6_1 = "qb-houses:client:viewHouse"
L5_1(L6_1)
L5_1 = AddEventHandler
L6_1 = "qb-houses:client:viewHouse"
function L7_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2, A6_2)
  local L7_2, L8_2, L9_2, L10_2, L11_2
  L7_2 = contract
  L8_2 = L7_2
  L7_2 = L7_2.open
  L9_2 = {}
  L9_2.firstname = A4_2
  L9_2.lastname = A5_2
  L10_2 = Config
  L10_2 = L10_2.Houses
  L11_2 = CurrentHouse
  L10_2 = L10_2[L11_2]
  L10_2 = L10_2.address
  L9_2.street = L10_2
  L9_2.houseprice = A0_2
  L9_2.brokerfee = A1_2
  L9_2.bankfee = A2_2
  L9_2.taxes = A3_2
  L10_2 = A0_2 + A1_2
  L10_2 = L10_2 + A2_2
  L10_2 = L10_2 + A3_2
  L9_2.totalprice = L10_2
  L10_2 = Config
  L10_2 = L10_2.CreditEq
  L10_2 = A0_2 * L10_2
  L9_2.credit = L10_2
  L9_2.rent = A6_2
  L7_2(L8_2, L9_2)
end
L5_1(L6_1, L7_1)
L5_1 = {}
HouseObjects = L5_1
function L5_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = pairs
  L1_2 = HouseObjects
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = RemoveSpawnedHouseObject
    L7_2 = L5_2
    L6_2(L7_2)
  end
  L0_2 = Debug
  L1_2 = "RemoveSpawnedHouseObjects"
  L0_2(L1_2)
end
RemoveSpawnedHouseObjects = L5_1
function L5_1()
  local L0_2, L1_2
  L0_2 = RemoveSpawnedHouseObjects
  L0_2()
  L0_2 = {}
  HouseObjects = L0_2
end
function L6_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L3_2 = joaat
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = lib
  L4_2 = L4_2.requestModel
  L5_2 = L3_2
  L6_2 = Config
  L6_2 = L6_2.DefaultRequestModelTimeout
  L4_2(L5_2, L6_2)
  L4_2 = CreatePed
  L5_2 = 4
  L6_2 = L3_2
  L7_2 = A1_2.x
  L8_2 = A1_2.y
  L9_2 = A1_2.z
  L9_2 = L9_2 - 1.0
  L10_2 = A2_2
  L11_2 = false
  L12_2 = false
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L5_2 = SetEntityAsMissionEntity
  L6_2 = L4_2
  L7_2 = true
  L8_2 = true
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = SetBlockingOfNonTemporaryEvents
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = SetModelAsNoLongerNeeded
  L6_2 = L3_2
  L5_2(L6_2)
  L5_2 = FreezeEntityPosition
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = SetEntityCoords
  L6_2 = L4_2
  L7_2 = A1_2.x
  L8_2 = A1_2.y
  L9_2 = A1_2.z
  L10_2 = false
  L11_2 = false
  L12_2 = false
  L13_2 = false
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L5_2 = SetEntityInvincible
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = SetPedCanRagdoll
  L6_2 = L4_2
  L7_2 = false
  L5_2(L6_2, L7_2)
  L5_2 = Debug
  L6_2 = "Spawned ped"
  L7_2 = "ped"
  L8_2 = L4_2
  L5_2(L6_2, L7_2, L8_2)
  return L4_2
end
SpawnPed = L6_1
function L6_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  if not A3_2 then
    A3_2 = 1.0
  end
  L4_2 = lib
  L4_2 = L4_2.requestAnimDict
  L5_2 = A1_2
  L4_2(L5_2)
  L4_2 = TaskPlayAnim
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = A2_2
  L8_2 = 8.0
  L9_2 = 1.0
  L10_2 = -1
  L11_2 = 1
  L12_2 = 1.0
  L13_2 = true
  L14_2 = true
  L15_2 = true
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L4_2 = RemoveAnimDict
  L5_2 = A1_2
  L4_2(L5_2)
  L4_2 = Debug
  L5_2 = "PlayAnimation"
  L6_2 = "ped"
  L7_2 = A0_2
  L8_2 = "dict"
  L9_2 = A1_2
  L10_2 = "anim"
  L11_2 = A2_2
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
end
PlayAnimation = L6_1
function L6_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L3_2 = joaat
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = lib
  L4_2 = L4_2.requestModel
  L5_2 = L3_2
  L6_2 = Config
  L6_2 = L6_2.DefaultRequestModelTimeout
  L4_2(L5_2, L6_2)
  L4_2 = CreateObject
  L5_2 = L3_2
  L6_2 = A1_2.x
  L7_2 = A1_2.y
  L8_2 = A1_2.z
  L9_2 = false
  L10_2 = false
  L11_2 = false
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = SetEntityHeading
  L6_2 = L4_2
  L7_2 = A2_2
  L5_2(L6_2, L7_2)
  L5_2 = SetEntityCompletelyDisableCollision
  L6_2 = L4_2
  L7_2 = true
  L8_2 = false
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = FreezeEntityPosition
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = SetEntityInvincible
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = SetEntityAsMissionEntity
  L6_2 = L4_2
  L7_2 = true
  L8_2 = true
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = SetModelAsNoLongerNeeded
  L6_2 = L3_2
  L5_2(L6_2)
  L5_2 = SetEntityCoords
  L6_2 = L4_2
  L7_2 = A1_2.x
  L8_2 = A1_2.y
  L9_2 = A1_2.z
  L10_2 = false
  L11_2 = false
  L12_2 = false
  L13_2 = false
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L5_2 = Debug
  L6_2 = "Spawned object"
  L7_2 = "object"
  L8_2 = L4_2
  L5_2(L6_2, L7_2, L8_2)
  return L4_2
end
SpawnHouseObject = L6_1
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = A0_2.construction
  if not L1_2 then
    L2_2 = Error
    L3_2 = "InitConstruction :: Construction data is nil"
    L4_2 = "data"
    L5_2 = A0_2
    L2_2(L3_2, L4_2, L5_2)
    return
  end
  L2_2 = Debug
  L3_2 = "construction model"
  L4_2 = L1_2.model
  L2_2(L3_2, L4_2)
  L2_2 = SpawnHouseObject
  L3_2 = L1_2.model
  L4_2 = A0_2.coords
  L5_2 = A0_2.coords
  L5_2 = L5_2.w
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  if not L2_2 then
    L3_2 = Error
    L4_2 = "InitConstruction :: Failed to spawn object"
    L5_2 = "construction"
    L6_2 = L1_2
    L3_2(L4_2, L5_2, L6_2)
    return
  end
  A0_2.handle = L2_2
  L3_2 = {}
  A0_2.constructionPeds = L3_2
  L3_2 = pairs
  L4_2 = L1_2.peds
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = Debug
    L10_2 = "construction ped"
    L11_2 = L8_2.model
    L9_2(L10_2, L11_2)
    L9_2 = GetOffsetFromEntityInWorldCoords
    L10_2 = L2_2
    L11_2 = L8_2.offsets
    L11_2 = L11_2.x
    L12_2 = L8_2.offsets
    L12_2 = L12_2.y
    L13_2 = L8_2.offsets
    L13_2 = L13_2.z
    L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
    L10_2 = SpawnPed
    L11_2 = L8_2.model
    L12_2 = L9_2
    L13_2 = L8_2.heading
    L10_2 = L10_2(L11_2, L12_2, L13_2)
    L11_2 = PlayAnimation
    L12_2 = L10_2
    L13_2 = L8_2.dict
    L14_2 = L8_2.anim
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = table
    L11_2 = L11_2.insert
    L12_2 = A0_2.constructionPeds
    L13_2 = L10_2
    L11_2(L12_2, L13_2)
  end
  L3_2 = Debug
  L4_2 = "InitConstruction"
  L5_2 = "object"
  L6_2 = L2_2
  L3_2(L4_2, L5_2, L6_2)
end
InitConstruction = L6_1
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = A0_2.handle
  if not L1_2 then
    L1_2 = Debug
    L2_2 = "RemoveSpawnedHouseObject :: Object is not spawned"
    L3_2 = "data"
    L4_2 = A0_2
    L1_2(L2_2, L3_2, L4_2)
    L1_2 = false
    return L1_2
  end
  L1_2 = A0_2.construction
  if L1_2 then
    L1_2 = creator
    L1_2 = L1_2.visible
    if not L1_2 then
      L1_2 = RemoveConstruction
      L2_2 = A0_2
      return L1_2(L2_2)
    end
  end
  L1_2 = DeleteObject
  L2_2 = A0_2.handle
  L1_2(L2_2)
  A0_2.handle = nil
  L1_2 = Debug
  L2_2 = "RemoveSpawnedHouseObject"
  L3_2 = "object"
  L4_2 = A0_2.handle
  L1_2(L2_2, L3_2, L4_2)
end
RemoveSpawnedHouseObject = L6_1
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = A0_2.construction
  if not L1_2 then
    L2_2 = Error
    L3_2 = "RemoveConstruction :: Construction data is nil"
    L4_2 = "data"
    L5_2 = A0_2
    L2_2(L3_2, L4_2, L5_2)
    return
  end
  L2_2 = A0_2.constructionPeds
  if L2_2 then
    L2_2 = pairs
    L3_2 = A0_2.constructionPeds
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = DeleteEntity
      L9_2 = L7_2
      L8_2(L9_2)
    end
  end
  A0_2.constructionPeds = nil
  L2_2 = DeleteObject
  L3_2 = A0_2.handle
  L2_2(L3_2)
  A0_2.handle = nil
  L2_2 = Debug
  L3_2 = "RemoveConstruction"
  L4_2 = "object"
  L5_2 = A0_2.handle
  L2_2(L3_2, L4_2, L5_2)
end
RemoveConstruction = L6_1
L6_1 = CreateThread
function L7_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  while true do
    L0_2 = cache
    L0_2 = L0_2.ped
    L1_2 = GetEntityCoords
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    L2_2 = pairs
    L3_2 = HouseObjects
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = vec3
      L9_2 = L7_2.coords
      L9_2 = L9_2.x
      L10_2 = L7_2.coords
      L10_2 = L10_2.y
      L11_2 = L7_2.coords
      L11_2 = L11_2.z
      L8_2 = L8_2(L9_2, L10_2, L11_2)
      L9_2 = L1_2 - L8_2
      L9_2 = #L9_2
      L10_2 = 250
      if L9_2 >= L10_2 then
        L10_2 = L7_2.handle
        if L10_2 then
          L10_2 = L7_2.isIsland
          if not L10_2 then
            L10_2 = RemoveSpawnedHouseObject
            L11_2 = L7_2
            L10_2(L11_2)
          end
        end
      end
      L10_2 = 250
      if L9_2 < L10_2 then
        L10_2 = L7_2.handle
        if not L10_2 then
          L10_2 = L7_2.construction
          if L10_2 then
            L10_2 = creator
            L10_2 = L10_2.visible
            if not L10_2 then
              L10_2 = InitConstruction
              L11_2 = L7_2
              L10_2(L11_2)
          end
          else
            L10_2 = SpawnHouseObject
            L11_2 = L7_2.model
            L12_2 = L8_2
            L13_2 = L7_2.coords
            L13_2 = L13_2.w
            L10_2 = L10_2(L11_2, L12_2, L13_2)
            if not L10_2 then
            else
              L11_2 = HouseObjects
              L11_2 = L11_2[L6_2]
              L11_2.handle = L10_2
            end
          end
        end
      end
    end
    L2_2 = Wait
    L3_2 = 400
    L2_2(L3_2)
  end
end
L6_1(L7_1)
function L6_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L0_2 = pairs
  L1_2 = HouseObjects
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = pairs
    L7_2 = Config
    L7_2 = L7_2.Islands
    L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
    for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
      L12_2 = L5_2.model
      L13_2 = L11_2.model
      if L12_2 == L13_2 then
        L12_2 = HouseObjects
        L12_2 = L12_2[L4_2]
        L12_2.isIsland = true
        break
      end
    end
  end
end
function L7_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = pairs
  L1_2 = Config
  L1_2 = L1_2.Houses
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = table
    L6_2 = L6_2.find
    L7_2 = HouseObjects
    function L8_2(A0_3)
      local L1_3, L2_3
      L1_3 = A0_3.house
      L2_3 = L4_2
      L1_3 = L1_3 == L2_3 and L1_3
      return L1_3
    end
    L6_2 = L6_2(L7_2, L8_2)
    if L6_2 then
      L7_2 = L6_2.construction
      L5_2.construction = L7_2
      L7_2 = Debug
      L8_2 = "initConstructions"
      L9_2 = "House"
      L10_2 = L4_2
      L11_2 = "Construction"
      L12_2 = L5_2.construction
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
    else
      L5_2.construction = nil
    end
  end
end
InitConstructions = L7_1
function L7_1()
  local L0_2, L1_2
  L0_2 = HouseObjects
  L0_2 = #L0_2
  if L0_2 > 0 then
    L0_2 = L5_1
    L0_2()
  end
  L0_2 = TriggerServerCallbackSync
  L1_2 = "qb-houses:server:GetHouseObjects"
  L0_2 = L0_2(L1_2)
  L1_2 = L0_2 or L1_2
  if not L0_2 then
    L1_2 = {}
  end
  HouseObjects = L1_2
  L1_2 = L6_1
  L1_2()
  L1_2 = InitConstructions
  L1_2()
end
GetHouseObjects = L7_1
L7_1 = RegisterNetEvent
L8_1 = "housing:updateHouseObject"
function L9_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = table
  L2_2 = L2_2.find
  L3_2 = HouseObjects
  function L4_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.id
    L2_3 = A0_2
    L1_3 = L1_3 == L2_3
    return L1_3
  end
  L2_2, L3_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L4_2 = Error
    L5_2 = "housing:updateHouseObject"
    L6_2 = "Object not found"
    L7_2 = L3_2
    L4_2(L5_2, L6_2, L7_2)
    return
  end
  L4_2 = HouseObjects
  L4_2 = #L4_2
  if L4_2 > 0 then
    L4_2 = RemoveSpawnedHouseObjects
    L4_2()
  end
  L4_2 = HouseObjects
  L4_2[L3_2] = A1_2
  L4_2 = L6_1
  L4_2()
  L4_2 = InitConstructions
  L4_2()
  L4_2 = Debug
  L5_2 = "Updated House Object"
  L6_2 = "ID"
  L7_2 = L3_2
  L8_2 = "Data"
  L9_2 = A1_2
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
end
L7_1(L8_1, L9_1)
L7_1 = RegisterNetEvent
L8_1 = "qb-houses:client:createHouseObject"
function L9_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = table
  L1_2 = L1_2.insert
  L2_2 = HouseObjects
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
  L1_2 = L6_1
  L1_2()
  L1_2 = InitConstructions
  L1_2()
end
L7_1(L8_1, L9_1)
L7_1 = RegisterNetEvent
L8_1 = "housing:deleteHouseObject"
function L9_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = RemoveSpawnedHouseObjects
  L1_2()
  L1_2 = table
  L1_2 = L1_2.filter
  L2_2 = HouseObjects
  function L3_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.house
    L2_3 = A0_2
    L1_3 = L1_3 ~= L2_3
    return L1_3
  end
  L1_2 = L1_2(L2_2, L3_2)
  HouseObjects = L1_2
  L1_2 = L6_1
  L1_2()
end
L7_1(L8_1, L9_1)
function L7_1()
  local L0_2, L1_2
  L0_2 = L2_1.entity
  if L0_2 then
    L0_2 = DoesEntityExist
    L1_2 = L2_1.entity
    L0_2 = L0_2(L1_2)
    if L0_2 then
      L0_2 = DeleteObject
      L1_2 = L2_1.entity
      L0_2(L1_2)
    end
  end
  L2_1.entity = nil
  L2_1.spawnHouse = nil
end
function L8_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  A0_2 = true == A0_2
  L1_2 = cache
  L1_2 = L1_2.ped
  if not L1_2 then
    L1_2 = PlayerPedId
    L1_2 = L1_2()
  end
  L2_2 = EnteredHouse
  L3_2 = L2_2 or L3_2
  if not L2_2 then
    L3_2 = CurrentHouse
  end
  FrontCam = false
  L4_2 = ToggleCameraUI
  L5_2 = false
  L4_2(L5_2)
  L4_2 = ClearTimecycleModifier
  L4_2()
  L4_2 = SetEntityInvincible
  L5_2 = L1_2
  L6_2 = false
  L4_2(L5_2, L6_2)
  L4_2 = SetEntityAlpha
  L5_2 = L1_2
  L6_2 = 255
  L7_2 = false
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = SetEntityVisible
  L5_2 = L1_2
  L6_2 = true
  L7_2 = false
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = FreezeEntityPosition
  L5_2 = L1_2
  L6_2 = false
  L4_2(L5_2, L6_2)
  L4_2 = SetArtificialLightsState
  L5_2 = false
  L4_2(L5_2)
  if L3_2 then
    L4_2 = TriggerEvent
    L5_2 = "housing:onExitHouse"
    L6_2 = L3_2
    L4_2(L5_2, L6_2)
    L4_2 = TriggerEvent
    L5_2 = "housing:handleExitZone"
    L6_2 = L3_2
    L4_2(L5_2, L6_2)
    if not A0_2 then
      L4_2 = Config
      L4_2 = L4_2.Houses
      L4_2 = L4_2[L3_2]
      if L4_2 then
        L5_2 = L4_2.ipl
        if L5_2 then
          L5_2 = TriggerServerEvent
          L6_2 = "qb-houses:leaveIplHouse"
          L7_2 = L3_2
          L5_2(L6_2, L7_2)
        end
      end
      L5_2 = TriggerServerEvent
      L6_2 = "housing:routePlayerToDefault"
      L7_2 = L3_2
      L5_2(L6_2, L7_2)
      L5_2 = TriggerServerEvent
      L6_2 = "housing:setInside"
      L7_2 = L3_2
      L8_2 = false
      L5_2(L6_2, L7_2, L8_2)
      L5_2 = TriggerServerEvent
      L6_2 = "qs-housing:disableAntiTeleport"
      L5_2(L6_2)
    end
  end
  L4_2 = HouseObj
  if L4_2 then
    L4_2 = HouseObj
    HouseObj = nil
    L5_2 = DespawnInterior
    L6_2 = L4_2
    function L7_2()
      local L0_3, L1_3
    end
    L5_2(L6_2, L7_2)
  end
  L4_2 = L7_1
  L4_2()
  L4_2 = L5_1
  L4_2()
  L4_2 = cleanerRobot
  if L4_2 then
    L4_2 = cleanerRobot
    L4_2 = L4_2.cleanAll
    if L4_2 then
      L4_2 = cleanerRobot
      L5_2 = L4_2
      L4_2 = L4_2.cleanAll
      L4_2(L5_2)
    end
  end
  L4_2 = junk
  if L4_2 then
    L4_2 = junk
    L4_2 = L4_2.cleanAll
    if L4_2 then
      L4_2 = junk
      L5_2 = L4_2
      L4_2 = L4_2.stopInteractionLoop
      L4_2(L5_2)
      L4_2 = junk
      L5_2 = L4_2
      L4_2 = L4_2.cleanAll
      L4_2(L5_2)
    end
  end
  L4_2 = Target
  if L4_2 then
    L4_2 = Target
    L5_2 = L4_2
    L4_2 = L4_2.destroyExit
    L4_2(L5_2)
  end
  L4_2 = {}
  L4_1 = L4_2
  CurrentDoorBell = 0
  EnteredHouse = nil
  CurrentHouse = nil
  L4_2 = {}
  CurrentHouseData = L4_2
  CurrentApartment = nil
  EnteringHouse = false
  Invited = false
  ShowingHouse = false
  HouseObj = nil
  POIOffsets = nil
  SHELL_DATA = nil
  L4_2 = DeleteBlips
  if L4_2 then
    L4_2 = DeleteBlips
    L4_2()
  end
end
CleanupPlayerHousingState = L8_1
L8_1 = RegisterNetEvent
L9_1 = "housing:client:PlayerUnloadCleanup"
function L10_1()
  local L0_2, L1_2
  L0_2 = CleanupPlayerHousingState
  L1_2 = false
  L0_2(L1_2)
end
L8_1(L9_1, L10_1)
L8_1 = exports
L9_1 = "CleanupPlayerHousingState"
L10_1 = CleanupPlayerHousingState
L8_1(L9_1, L10_1)
L8_1 = AddEventHandler
L9_1 = "onResourceStop"
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if L1_2 ~= A0_2 then
    return
  end
  L1_2 = CleanupPlayerHousingState
  L2_2 = true
  L1_2(L2_2)
end
L8_1(L9_1, L10_1)
function L8_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = vec3
  L2_2 = A0_2.x
  L3_2 = A0_2.y
  L4_2 = A0_2.z
  return L1_2(L2_2, L3_2, L4_2)
end
function L9_1()
  local L0_2, L1_2
  L0_2 = CurrentHouseData
  if L0_2 then
    L0_2 = CurrentHouseData
    L0_2 = L0_2.haskey
    if not L0_2 then
      L0_2 = CurrentHouseData
      L0_2 = L0_2.isOfficialOwner
    end
  end
  return L0_2
end
function L10_1()
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
  if L0_2 then
    L1_2 = type
    L2_2 = L0_2.upgrades
    L1_2 = L1_2(L2_2)
    if "table" == L1_2 then
      goto lbl_19
    end
  end
  L1_2 = false
  do return L1_2 end
  ::lbl_19::
  L1_2 = table
  L1_2 = L1_2.includes
  L2_2 = L0_2.upgrades
  L3_2 = "camera"
  return L1_2(L2_2, L3_2)
end
function L11_1()
  local L0_2, L1_2, L2_2
  L0_2 = CurrentHouseData
  if L0_2 then
    L0_2 = CurrentHouseData
    L0_2 = L0_2.tablet
  end
  if not L0_2 then
    L1_2 = nil
    return L1_2
  end
  L1_2 = type
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if "string" == L1_2 then
    L1_2 = json
    L1_2 = L1_2.decode
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    L0_2 = L1_2
  end
  if L0_2 then
    L1_2 = L0_2.x
    if L1_2 then
      L1_2 = L0_2.y
      if L1_2 then
        L1_2 = L0_2.z
        if L1_2 then
          goto lbl_33
        end
      end
    end
  end
  L1_2 = nil
  do return L1_2 end
  ::lbl_33::
  return L0_2
end
function L12_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = CurrentHouse
  if not L0_2 then
    return
  end
  L0_2 = L10_1
  L0_2 = L0_2()
  if not L0_2 then
    L0_2 = L7_1
    L0_2()
    return
  end
  L0_2 = L11_1
  L0_2 = L0_2()
  if not L0_2 then
    L1_2 = Debug
    L2_2 = "spawnTabletEntity ::: Tablet not found"
    L1_2(L2_2)
    L1_2 = L7_1
    L1_2()
    return
  end
  L1_2 = L2_1.entity
  if L1_2 then
    L1_2 = DoesEntityExist
    L2_2 = L2_1.entity
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = L2_1.spawnHouse
      L2_2 = CurrentHouse
      if L1_2 == L2_2 then
        L1_2 = L7_1
        L1_2()
      end
    end
  end
  L1_2 = joaat
  L2_2 = Config
  L2_2 = L2_2.TabletModel
  L1_2 = L1_2(L2_2)
  L2_2 = lib
  L2_2 = L2_2.requestModel
  L3_2 = L1_2
  L4_2 = Config
  L4_2 = L4_2.DefaultRequestModelTimeout
  L2_2(L3_2, L4_2)
  L2_2 = CreateObject
  L3_2 = L1_2
  L4_2 = L0_2.x
  L5_2 = L0_2.y
  L6_2 = L0_2.z
  L7_2 = false
  L8_2 = false
  L9_2 = false
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L3_2 = SetEntityHeading
  L4_2 = L2_2
  L5_2 = L0_2.w
  if not L5_2 then
    L5_2 = L0_2.h
    if not L5_2 then
      L5_2 = 0.0
    end
  end
  L3_2(L4_2, L5_2)
  L3_2 = FreezeEntityPosition
  L4_2 = L2_2
  L5_2 = true
  L3_2(L4_2, L5_2)
  L3_2 = SetEntityAsMissionEntity
  L4_2 = L2_2
  L5_2 = true
  L6_2 = true
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = SetEntityInvincible
  L4_2 = L2_2
  L5_2 = true
  L3_2(L4_2, L5_2)
  L3_2 = SetModelAsNoLongerNeeded
  L4_2 = L1_2
  L3_2(L4_2)
  L2_1.entity = L2_2
  L3_2 = CurrentHouse
  L2_1.spawnHouse = L3_2
end
function L13_1()
  local L0_2, L1_2
  L0_2 = L2_1.selecting
  if L0_2 then
    return
  end
  L0_2 = CurrentApartment
  if L0_2 then
    return
  end
  L0_2 = CurrentHouse
  if not L0_2 then
    return
  end
  L0_2 = L9_1
  L0_2 = L0_2()
  if not L0_2 then
    return
  end
  L2_1.selecting = true
  L0_2 = CreateThread
  function L1_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3
    L0_3 = CurrentHouse
    L1_3 = creator
    L2_3 = L1_3
    L1_3 = L1_3.selectPoint
    L3_3 = "object"
    L4_3 = 1
    L5_3 = {}
    L6_3 = Config
    L6_3 = L6_3.TabletModel
    L5_3.model = L6_3
    L5_3.externalUsage = true
    function L6_3(A0_4)
      local L1_4, L2_4, L3_4
      L1_4 = EnteredHouse
      if not L1_4 then
        L1_4 = HouseZones
        L2_4 = L0_3
        L1_4 = L1_4[L2_4]
        L2_4 = L1_4
        L1_4 = L1_4.contains
        L3_4 = A0_4
        L1_4 = L1_4(L2_4, L3_4)
      end
      return L1_4
    end
    L5_3.checkInside = L6_3
    L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
    if L1_3 then
      L2_3 = L1_3[1]
      if L2_3 then
        L2_3 = CurrentHouse
        if L2_3 then
          L2_3 = L1_3[1]
          L3_3 = {}
          L4_3 = L2_3.x
          L3_3.x = L4_3
          L4_3 = L2_3.y
          L3_3.y = L4_3
          L4_3 = L2_3.z
          L3_3.z = L4_3
          L4_3 = L2_3.w
          L3_3.w = L4_3
          L4_3 = TriggerServerEvent
          L5_3 = "qb-houses:server:setLocation"
          L6_3 = L3_3
          L7_3 = CurrentHouse
          L8_3 = 9
          L4_3(L5_3, L6_3, L7_3, L8_3)
          L4_3 = CurrentHouseData
          L4_3.tablet = L3_3
          L4_3 = Notification
          L5_3 = i18n
          L5_3 = L5_3.t
          L6_3 = "management.tablet_location_saved"
          L5_3 = L5_3(L6_3)
          L6_3 = "success"
          L4_3(L5_3, L6_3)
      end
    end
    else
      L2_3 = Notification
      L3_3 = i18n
      L3_3 = L3_3.t
      L4_3 = "management.tablet_placement_cancelled"
      L3_3 = L3_3(L4_3)
      L4_3 = "info"
      L2_3(L3_3, L4_3)
    end
    L2_1.selecting = false
  end
  L0_2(L1_2)
end
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  if not A0_2 then
    A0_2 = CurrentHouse
  end
  L1_2 = CurrentHouse
  if not L1_2 then
    L1_2 = Debug
    L2_2 = "InitHouseInteractions ::: No Current House"
    return L1_2(L2_2)
  end
  L1_2 = lib
  L1_2 = L1_2.callback
  L1_2 = L1_2.await
  L2_2 = "housing:getLocations"
  L3_2 = 0
  L4_2 = A0_2
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  if L1_2 then
    L2_2 = L1_2.stash
    if nil ~= L2_2 then
      L2_2 = L8_1
      L3_2 = json
      L3_2 = L3_2.decode
      L4_2 = L1_2.stash
      L3_2, L4_2, L5_2 = L3_2(L4_2)
      L2_2 = L2_2(L3_2, L4_2, L5_2)
      L3_2 = CurrentHouseData
      L3_2 = L3_2.stash
      if L3_2 ~= L2_2 then
        L3_2 = CurrentHouseData
        L3_2.stash = L2_2
      end
    end
    L2_2 = L1_2.outfit
    if nil ~= L2_2 then
      L2_2 = L8_1
      L3_2 = json
      L3_2 = L3_2.decode
      L4_2 = L1_2.outfit
      L3_2, L4_2, L5_2 = L3_2(L4_2)
      L2_2 = L2_2(L3_2, L4_2, L5_2)
      L3_2 = CurrentHouseData
      L3_2 = L3_2.wardrobe
      if L3_2 ~= L2_2 then
        L3_2 = CurrentHouseData
        L3_2.wardrobe = L2_2
      end
    end
    L2_2 = L1_2.logout
    if nil ~= L2_2 then
      L2_2 = L8_1
      L3_2 = json
      L3_2 = L3_2.decode
      L4_2 = L1_2.logout
      L3_2, L4_2, L5_2 = L3_2(L4_2)
      L2_2 = L2_2(L3_2, L4_2, L5_2)
      L3_2 = CurrentHouseData
      L3_2 = L3_2.logout
      if L3_2 ~= L2_2 then
        L3_2 = CurrentHouseData
        L3_2.logout = L2_2
      end
    end
    L2_2 = L1_2.charge
    if nil ~= L2_2 then
      L2_2 = L8_1
      L3_2 = json
      L3_2 = L3_2.decode
      L4_2 = L1_2.charge
      L3_2, L4_2, L5_2 = L3_2(L4_2)
      L2_2 = L2_2(L3_2, L4_2, L5_2)
      L3_2 = CurrentHouseData
      L3_2 = L3_2.charge
      if L3_2 ~= L2_2 then
        L3_2 = CurrentHouseData
        L3_2.charge = L2_2
      end
    else
      L2_2 = CurrentHouseData
      L2_2.charge = nil
    end
    L2_2 = L1_2.delivery
    if nil ~= L2_2 then
      L2_2 = L8_1
      L3_2 = json
      L3_2 = L3_2.decode
      L4_2 = L1_2.delivery
      L3_2, L4_2, L5_2 = L3_2(L4_2)
      L2_2 = L2_2(L3_2, L4_2, L5_2)
      L3_2 = CurrentHouseData
      L3_2 = L3_2.delivery
      if L3_2 ~= L2_2 then
        L3_2 = CurrentHouseData
        L3_2.delivery = L2_2
      end
    end
    L2_2 = L1_2.tablet
    if nil ~= L2_2 then
      L2_2 = json
      L2_2 = L2_2.decode
      L3_2 = L1_2.tablet
      L2_2 = L2_2(L3_2)
      if L2_2 then
        L3_2 = L2_2.x
        if L3_2 then
          L3_2 = L2_2.y
          if L3_2 then
            L3_2 = L2_2.z
            if L3_2 then
              L3_2 = CurrentHouseData
              L4_2 = {}
              L5_2 = L2_2.x
              L4_2.x = L5_2
              L5_2 = L2_2.y
              L4_2.y = L5_2
              L5_2 = L2_2.z
              L4_2.z = L5_2
              L5_2 = L2_2.w
              if not L5_2 then
                L5_2 = L2_2.h
                if not L5_2 then
                  L5_2 = 0.0
                end
              end
              L4_2.w = L5_2
              L3_2.tablet = L4_2
            end
          end
        end
      end
    else
      L2_2 = CurrentHouseData
      L2_2.tablet = nil
    end
  end
  L2_2 = L12_1
  L2_2()
  L2_2 = Target
  if L2_2 then
    L2_2 = Target
    L3_2 = L2_2
    L2_2 = L2_2.initInsideInteractions
    L2_2(L3_2)
  end
end
InitHouseInteractions = L14_1
L14_1 = AddEventHandler
L15_1 = "housing:handleEnterZone"
function L16_1(A0_2)
  local L1_2
  if A0_2 then
    L1_2 = CurrentHouse
    if L1_2 == A0_2 then
      goto lbl_7
    end
  end
  do return end
  ::lbl_7::
  L1_2 = L12_1
  L1_2()
end
L14_1(L15_1, L16_1)
L14_1 = AddEventHandler
L15_1 = "housing:handleExitZone"
function L16_1()
  local L0_2, L1_2
  L0_2 = L7_1
  L0_2()
end
L14_1(L15_1, L16_1)
L14_1 = AddEventHandler
L15_1 = "housing:onEnterHouse"
function L16_1(A0_2)
  local L1_2, L2_2
  L1_2 = Config
  L1_2 = L1_2.Houses
  L1_2 = L1_2[A0_2]
  if not L1_2 then
    return
  end
  L2_2 = L12_1
  L2_2()
end
L14_1(L15_1, L16_1)
L14_1 = AddEventHandler
L15_1 = "housing:onExitHouse"
function L16_1()
  local L0_2, L1_2
  L0_2 = L7_1
  L0_2()
end
L14_1(L15_1, L16_1)
L14_1 = RegisterNetEvent
L15_1 = "qb-houses:client:setLocation"
L14_1(L15_1)
L14_1 = AddEventHandler
L15_1 = "qb-houses:client:setLocation"
function L16_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = cache
  L1_2 = L1_2.ped
  L2_2 = GetEntityCoords
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = {}
  L4_2 = L2_2.x
  L3_2.x = L4_2
  L4_2 = L2_2.y
  L3_2.y = L4_2
  L4_2 = L2_2.z
  L3_2.z = L4_2
  L4_2 = CurrentHouse
  if L4_2 then
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = CurrentHouse
    L4_2 = L4_2[L5_2]
    if L4_2 then
      L4_2 = CurrentHouseData
      L4_2 = L4_2.haskey
      if not L4_2 then
        L4_2 = Notification
        L5_2 = i18n
        L5_2 = L5_2.t
        L6_2 = "not_have_keys"
        L5_2 = L5_2(L6_2)
        L6_2 = "error"
        return L4_2(L5_2, L6_2)
      end
      L4_2 = A0_2.id
      if "setstash" == L4_2 then
        L4_2 = TriggerServerEvent
        L5_2 = "qb-houses:server:setLocation"
        L6_2 = L3_2
        L7_2 = CurrentHouse
        L8_2 = 1
        L4_2(L5_2, L6_2, L7_2, L8_2)
      else
        L4_2 = A0_2.id
        if "setoutfit" == L4_2 then
          L4_2 = TriggerServerEvent
          L5_2 = "qb-houses:server:setLocation"
          L6_2 = L3_2
          L7_2 = CurrentHouse
          L8_2 = 2
          L4_2(L5_2, L6_2, L7_2, L8_2)
        else
          L4_2 = A0_2.id
          if "setlogout" == L4_2 then
            L4_2 = TriggerServerEvent
            L5_2 = "qb-houses:server:setLocation"
            L6_2 = L3_2
            L7_2 = CurrentHouse
            L8_2 = 3
            L4_2(L5_2, L6_2, L7_2, L8_2)
          else
            L4_2 = A0_2.id
            if "setCharge" == L4_2 then
              L4_2 = vec3
              L5_2 = L2_2.x
              L6_2 = L2_2.y
              L7_2 = L2_2.z
              L4_2 = L4_2(L5_2, L6_2, L7_2)
              L3_2 = L4_2
              L4_2 = TriggerServerEvent
              L5_2 = "qb-houses:server:setLocation"
              L6_2 = L3_2
              L7_2 = CurrentHouse
              L8_2 = 4
              L4_2(L5_2, L6_2, L7_2, L8_2)
            else
              L4_2 = A0_2.id
              if "setDecorate" == L4_2 then
                L4_2 = vec3
                L5_2 = L2_2.x
                L6_2 = L2_2.y
                L7_2 = L2_2.z
                L4_2 = L4_2(L5_2, L6_2, L7_2)
                L3_2 = L4_2
                L4_2 = TriggerServerEvent
                L5_2 = "qb-houses:server:setLocation"
                L6_2 = L3_2
                L7_2 = CurrentHouse
                L8_2 = 5
                L4_2(L5_2, L6_2, L7_2, L8_2)
              else
                L4_2 = A0_2.id
                if "setTv" == L4_2 then
                  L4_2 = vec3
                  L5_2 = L2_2.x
                  L6_2 = L2_2.y
                  L7_2 = L2_2.z
                  L4_2 = L4_2(L5_2, L6_2, L7_2)
                  L3_2 = L4_2
                  L4_2 = TriggerServerEvent
                  L5_2 = "qb-houses:server:setLocation"
                  L6_2 = L3_2
                  L7_2 = CurrentHouse
                  L8_2 = 6
                  L4_2(L5_2, L6_2, L7_2, L8_2)
                else
                  L4_2 = A0_2.id
                  if "setSit" == L4_2 then
                    L4_2 = vec3
                    L5_2 = L2_2.x
                    L6_2 = L2_2.y
                    L7_2 = L2_2.z
                    L4_2 = L4_2(L5_2, L6_2, L7_2)
                    L3_2 = L4_2
                    L4_2 = TriggerServerEvent
                    L5_2 = "qb-houses:server:setLocation"
                    L6_2 = L3_2
                    L7_2 = CurrentHouse
                    L8_2 = 7
                    L4_2(L5_2, L6_2, L7_2, L8_2)
                  else
                    L4_2 = A0_2.id
                    if "setTablet" == L4_2 then
                      L4_2 = CurrentHouse
                      L5_2 = creator
                      L6_2 = L5_2
                      L5_2 = L5_2.selectPoint
                      L7_2 = "object"
                      L8_2 = 1
                      L9_2 = {}
                      L10_2 = Config
                      L10_2 = L10_2.TabletModel
                      L9_2.model = L10_2
                      L9_2.externalUsage = true
                      function L10_2(A0_3)
                        local L1_3, L2_3, L3_3
                        L1_3 = EnteredHouse
                        if not L1_3 then
                          L1_3 = HouseZones
                          L2_3 = L4_2
                          L1_3 = L1_3[L2_3]
                          L2_3 = L1_3
                          L1_3 = L1_3.contains
                          L3_3 = A0_3
                          L1_3 = L1_3(L2_3, L3_3)
                        end
                        return L1_3
                      end
                      L9_2.checkInside = L10_2
                      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
                      if L5_2 then
                        L6_2 = L5_2[1]
                        if L6_2 then
                          goto lbl_152
                        end
                      end
                      do return end
                      ::lbl_152::
                      L6_2 = TriggerServerEvent
                      L7_2 = "qb-houses:server:setLocation"
                      L8_2 = L5_2[1]
                      L9_2 = CurrentHouse
                      L10_2 = 9
                      L6_2(L7_2, L8_2, L9_2, L10_2)
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
L14_1(L15_1, L16_1)
L14_1 = RegisterNetEvent
L15_1 = "qb-houses:client:refreshLocations"
L14_1(L15_1)
L14_1 = AddEventHandler
L15_1 = "qb-houses:client:refreshLocations"
function L16_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L3_2 = nil
  L4_2 = Debug
  L5_2 = "RefreshLocations ::: House"
  L6_2 = A0_2
  L7_2 = "Location"
  L8_2 = A1_2
  L9_2 = "Type"
  L10_2 = A2_2
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = CurrentHouse
  if L4_2 == A0_2 then
    L4_2 = L8_1
    L5_2 = json
    L5_2 = L5_2.decode
    L6_2 = A1_2
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L5_2(L6_2)
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    if 1 == A2_2 then
      L5_2 = CurrentHouseData
      L5_2 = L5_2.stash
      if L5_2 ~= L4_2 then
        L5_2 = CurrentHouseData
        L5_2.stash = L4_2
        L3_2 = true
      end
    elseif 2 == A2_2 then
      L5_2 = CurrentHouseData
      L5_2 = L5_2.wardrobe
      if L5_2 ~= L4_2 then
        L5_2 = CurrentHouseData
        L5_2.wardrobe = L4_2
        L3_2 = true
      end
    elseif 3 == A2_2 then
      L5_2 = CurrentHouseData
      L5_2 = L5_2.logout
      if L5_2 ~= L4_2 then
        L5_2 = CurrentHouseData
        L5_2.logout = L4_2
        L3_2 = true
      end
    elseif 4 == A2_2 then
      L5_2 = CurrentHouseData
      L5_2 = L5_2.charge
      if L5_2 ~= L4_2 then
        L5_2 = CurrentHouseData
        L5_2.charge = L4_2
        L3_2 = true
      end
    elseif 8 == A2_2 then
      L5_2 = CurrentHouseData
      L5_2 = L5_2.delivery
      if L5_2 ~= L4_2 then
        L5_2 = CurrentHouseData
        L5_2.delivery = L4_2
        L3_2 = true
      end
    elseif 9 == A2_2 then
      L5_2 = json
      L5_2 = L5_2.decode
      L6_2 = A1_2
      L5_2 = L5_2(L6_2)
      L6_2 = Debug
      L7_2 = "RefreshLocations ::: Tablet"
      L8_2 = L5_2
      L6_2(L7_2, L8_2)
      if L5_2 then
        L6_2 = L5_2.x
        if L6_2 then
          L6_2 = L5_2.y
          if L6_2 then
            L6_2 = L5_2.z
            if L6_2 then
              L6_2 = CurrentHouseData
              L7_2 = {}
              L8_2 = L5_2.x
              L7_2.x = L8_2
              L8_2 = L5_2.y
              L7_2.y = L8_2
              L8_2 = L5_2.z
              L7_2.z = L8_2
              L8_2 = L5_2.w
              if not L8_2 then
                L8_2 = L5_2.h
                if not L8_2 then
                  L8_2 = 0.0
                end
              end
              L7_2.w = L8_2
              L6_2.tablet = L7_2
              L3_2 = true
              L6_2 = L12_1
              L6_2()
            end
          end
        end
      end
    end
    L5_2 = Target
    if L5_2 and L3_2 then
      L5_2 = Target
      L6_2 = L5_2
      L5_2 = L5_2.initInsideInteractions
      L5_2(L6_2)
    end
  end
end
L14_1(L15_1, L16_1)
L14_1 = exports
L15_1 = "GetClosestHouse"
function L16_1()
  local L0_2, L1_2
  L0_2 = CurrentHouse
  return L0_2
end
L14_1(L15_1, L16_1)
L14_1 = exports
L15_1 = "GetCurrentHouseUpgrades"
function L16_1()
  local L0_2, L1_2
  L0_2 = Config
  L0_2 = L0_2.Houses
  L1_2 = CurrentHouse
  L0_2 = L0_2[L1_2]
  L0_2 = L0_2.upgrades
  if not L0_2 then
    L0_2 = {}
  end
  return L0_2
end
L14_1(L15_1, L16_1)
L14_1 = RegisterCommand
L15_1 = Config
L15_1 = L15_1.HireRenterCommand
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:isAdmin"
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "no_permission"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    return L3_2(L4_2, L5_2)
  end
  L3_2 = CurrentHouse
  if not L3_2 then
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "house_not_found"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    return L3_2(L4_2, L5_2)
  end
  L3_2 = Config
  L3_2 = L3_2.Houses
  L4_2 = CurrentHouse
  L3_2 = L3_2[L4_2]
  L4_2 = L3_2.apartmentNumber
  if L4_2 then
    L4_2 = OpenHireApartments
    L4_2()
    return
  end
  L4_2 = TriggerServerEvent
  L5_2 = "housing:hireRenter"
  L6_2 = CurrentHouse
  L4_2(L5_2, L6_2)
end
L14_1(L15_1, L16_1)
function L14_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = A0_2.coords
  L2_2 = L2_2.test
  if not A1_2 then
    A1_2 = CurrentHouse
  end
  L3_2 = not L2_2
  TestNotMLO = L3_2
  L3_2 = DoScreenFadeOut
  L4_2 = 500
  L3_2(L4_2)
  if L2_2 then
    L3_2 = GetEntityCoords
    L4_2 = cache
    L4_2 = L4_2.ped
    L3_2 = L3_2(L4_2)
    ShowRoomDefaultCoords = L3_2
  end
  L3_2 = Wait
  L4_2 = 1000
  L3_2(L4_2)
  if L2_2 then
    L3_2 = SetEntityCoords
    L4_2 = cache
    L4_2 = L4_2.ped
    L5_2 = vec3
    L6_2 = A0_2.coords
    L6_2 = L6_2.test
    L6_2 = L6_2.x
    L7_2 = A0_2.coords
    L7_2 = L7_2.test
    L7_2 = L7_2.y
    L8_2 = A0_2.coords
    L8_2 = L8_2.test
    L8_2 = L8_2.z
    L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2, L7_2, L8_2)
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  else
    L3_2 = A0_2.ipl
    if not L3_2 then
      L3_2 = EnterHouse
      L4_2 = true
      L3_2(L4_2)
    else
      L3_2 = EnterIplHouse
      L4_2 = A1_2
      L5_2 = true
      L3_2(L4_2, L5_2)
    end
  end
  L3_2 = SetArtificialLightsState
  L4_2 = false
  L3_2(L4_2)
  L3_2 = ShowRoomLoop
  L3_2()
  L3_2 = DoScreenFadeIn
  L4_2 = 500
  L3_2(L4_2)
end
InspectHouse = L14_1
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  if not A0_2 then
    L1_2 = nil
    return L1_2
  end
  L1_2 = "furn_%s"
  L2_2 = L1_2
  L1_2 = L1_2.format
  L3_2 = tostring
  L4_2 = A0_2
  L3_2, L4_2 = L3_2(L4_2)
  return L1_2(L2_2, L3_2, L4_2)
end
GetFurnitureStorageId = L14_1
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  if not A0_2 then
    A0_2 = CurrentHouse
  end
  L1_2 = TriggerServerCallbackSync
  L2_2 = "housing:getVaultCodes"
  L3_2 = CurrentHouse
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L2_2 = pairs
    L3_2 = L1_2
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = tostring
      L9_2 = L7_2.id
      L8_2 = L8_2(L9_2)
      L9_2 = tostring
      L10_2 = A0_2
      L9_2 = L9_2(L10_2)
      if L8_2 == L9_2 then
        L8_2 = L7_2.code
        return L8_2
      end
    end
  end
  L2_2 = false
  return L2_2
end
GetVaultCode = L14_1
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = keypad
  L2_2 = L1_2
  L1_2 = L1_2.open
  L3_2 = i18n
  L3_2 = L3_2.t
  L4_2 = "vault_code.title"
  L3_2, L4_2, L5_2 = L3_2(L4_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
  if not L1_2 then
    return
  end
  L2_2 = TriggerServerEvent
  L3_2 = "housing:setVaultCode"
  L4_2 = {}
  L4_2.code = L1_2
  L5_2 = A0_2 or L5_2
  if not A0_2 then
    L5_2 = CurrentHouse
  end
  L4_2.id = L5_2
  L5_2 = CurrentHouse
  L4_2.house = L5_2
  L2_2(L3_2, L4_2)
end
ChangeVaultCode = L14_1
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = GetVaultCode
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = lib
  L2_2 = L2_2.registerContext
  L3_2 = {}
  L3_2.id = "vault_code_menu"
  L4_2 = i18n
  L4_2 = L4_2.t
  L5_2 = "vault_code.management_title"
  L4_2 = L4_2(L5_2)
  L3_2.title = L4_2
  L4_2 = {}
  L5_2 = {}
  L6_2 = i18n
  L6_2 = L6_2.t
  L7_2 = "vault_code.set_code"
  L6_2 = L6_2(L7_2)
  L5_2.title = L6_2
  L5_2.icon = "fas fa-key"
  function L6_2()
    local L0_3, L1_3
    L0_3 = ChangeVaultCode
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2.onSelect = L6_2
  L6_2 = {}
  L7_2 = i18n
  L7_2 = L7_2.t
  L8_2 = "vault_code.remove_code"
  L7_2 = L7_2(L8_2)
  L6_2.title = L7_2
  L6_2.icon = "fas fa-key"
  L7_2 = not L1_2
  L6_2.disabled = L7_2
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = TriggerServerEvent
    L1_3 = "housing:removeVaultCode"
    L2_3 = {}
    L3_3 = A0_2
    if not L3_3 then
      L3_3 = CurrentHouse
    end
    L2_3.id = L3_3
    L3_3 = CurrentHouse
    L2_3.house = L3_3
    L0_3(L1_3, L2_3)
  end
  L6_2.onSelect = L7_2
  L4_2[1] = L5_2
  L4_2[2] = L6_2
  L3_2.options = L4_2
  L2_2(L3_2)
  L2_2 = lib
  L2_2 = L2_2.showContext
  L3_2 = "vault_code_menu"
  L2_2(L3_2)
end
OpenVaultCodeMenu = L14_1
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = CurrentHouseData
  if not L1_2 then
    L1_2 = false
    return L1_2
  end
  L1_2 = Config
  L1_2 = L1_2.StashNeedsKey
  if L1_2 then
    L1_2 = CurrentHouseData
    L1_2 = L1_2.haskey
    if not L1_2 then
      L1_2 = Notification
      L2_2 = i18n
      L2_2 = L2_2.t
      L3_2 = "not_have_keys"
      L2_2 = L2_2(L3_2)
      L3_2 = "error"
      L1_2(L2_2, L3_2)
      L1_2 = false
      return L1_2
    end
  end
  L1_2 = GetVaultCode
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L2_2 = true
    return L2_2
  end
  L2_2 = keypad
  L3_2 = L2_2
  L2_2 = L2_2.open
  L4_2 = i18n
  L4_2 = L4_2.t
  L5_2 = "vault_code.access_title"
  L4_2, L5_2 = L4_2(L5_2)
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  if not L2_2 then
    L3_2 = false
    return L3_2
  end
  if L2_2 ~= L1_2 then
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "vault_code.invalid_code"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
    L3_2 = false
    return L3_2
  end
  L3_2 = true
  return L3_2
end
CanAccessStash = L14_1
L14_1 = RegisterNUICallback
L15_1 = "play_sound"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = Config
  L2_2 = L2_2.DisableSounds
  if L2_2 then
    L2_2 = A1_2
    L3_2 = "ok"
    return L2_2(L3_2)
  end
  if "category_down" == A0_2 then
    L2_2 = PlaySoundFrontend
    L3_2 = -1
    L4_2 = "NAV_UP_DOWN"
    L5_2 = "HUD_FRONTEND_DEFAULT_SOUNDSET"
    L6_2 = 0
    L7_2 = 0
    L8_2 = 1
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  elseif "item_down" == A0_2 then
    L2_2 = PlaySoundFrontend
    L3_2 = -1
    L4_2 = "Object_Collect_Remote"
    L5_2 = "GTAO_FM_Events_Soundset"
    L6_2 = 0
    L7_2 = 0
    L8_2 = 1
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  elseif "finish" == A0_2 then
    L2_2 = PlaySoundFrontend
    L3_2 = -1
    L4_2 = "Menu_Accept"
    L5_2 = "Phone_SoundSet_Default"
    L6_2 = 0
    L7_2 = 0
    L8_2 = 1
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  elseif "cancel" == A0_2 then
    L2_2 = PlaySoundFrontend
    L3_2 = -1
    L4_2 = "MP_IDLE_KICK"
    L5_2 = "HUD_FRONTEND_DEFAULT_SOUNDSET"
    L6_2 = 0
    L7_2 = 0
    L8_2 = 1
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  elseif "admin_active" == A0_2 then
    L2_2 = PlaySoundFrontend
    L3_2 = -1
    L4_2 = "Hack_Success"
    L5_2 = "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"
    L6_2 = 0
    L7_2 = 0
    L8_2 = 1
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  elseif "admin_disable" == A0_2 then
    L2_2 = PlaySoundFrontend
    L3_2 = -1
    L4_2 = "Hack_Failed"
    L5_2 = "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"
    L6_2 = 0
    L7_2 = 0
    L8_2 = 1
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  elseif "hover_down" == A0_2 then
    L2_2 = PlaySoundFrontend
    L3_2 = -1
    L4_2 = "Highlight_Accept"
    L5_2 = "DLC_HEIST_PLANNING_BOARD_SOUNDS"
    L6_2 = 0
    L7_2 = 0
    L8_2 = 1
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  elseif "hover_up" == A0_2 then
    L2_2 = PlaySoundFrontend
    L3_2 = -1
    L4_2 = "Highlight_Error"
    L5_2 = "DLC_HEIST_PLANNING_BOARD_SOUNDS"
    L6_2 = 0
    L7_2 = 0
    L8_2 = 1
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  else
    L2_2 = Error
    L3_2 = "Unknown sound:"
    L4_2 = A0_2
    L2_2(L3_2, L4_2)
  end
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L14_1(L15_1, L16_1)
L14_1 = RegisterNUICallback
L15_1 = "close"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = SetNuiFocus
  L3_2 = false
  L4_2 = false
  L2_2(L3_2, L4_2)
  L2_2 = decorate
  L3_2 = L2_2
  L2_2 = L2_2.close
  L2_2(L3_2)
  L2_2 = creator
  L3_2 = L2_2
  L2_2 = L2_2.close
  L2_2(L3_2)
  L2_2 = furnitureCreator
  L3_2 = L2_2
  L2_2 = L2_2.close
  L2_2(L3_2)
  L2_2 = management
  L3_2 = L2_2
  L2_2 = L2_2.close
  L2_2(L3_2)
  L2_2 = contract
  L3_2 = L2_2
  L2_2 = L2_2.close
  L2_2(L3_2)
  L2_2 = quickMenu
  L3_2 = L2_2
  L2_2 = L2_2.close
  L2_2(L3_2)
  L2_2 = keypad
  L2_2.response = false
  L2_2 = keypad
  L3_2 = L2_2
  L2_2 = L2_2.close
  L2_2(L3_2)
  L2_2 = housebrowser
  L3_2 = L2_2
  L2_2 = L2_2.close
  L2_2(L3_2)
  L2_2 = SendReactMessage
  L3_2 = "toggle_info_card"
  L4_2 = {}
  L4_2.visible = false
  L2_2(L3_2, L4_2)
  L2_2 = A1_2
  L3_2 = true
  L2_2(L3_2)
end
L14_1(L15_1, L16_1)
L14_1 = RegisterNetEvent
L15_1 = "housing:showMetaKeyInfo"
function L16_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  if A0_2 then
    L1_2 = A0_2.houseId
    if L1_2 then
      goto lbl_7
    end
  end
  do return end
  ::lbl_7::
  L1_2 = Config
  L1_2 = L1_2.Houses
  L2_2 = A0_2.houseId
  L1_2 = L1_2[L2_2]
  if not L1_2 then
    L2_2 = Notification
    L3_2 = i18n
    L3_2 = L3_2.t
    L4_2 = "metakey.house_not_exists"
    L3_2 = L3_2(L4_2)
    L4_2 = "error"
    L2_2(L3_2, L4_2)
    return
  end
  L2_2 = Notification
  L3_2 = i18n
  L3_2 = L3_2.t
  L4_2 = "metakey.key_info"
  L5_2 = {}
  L6_2 = A0_2.houseName
  if not L6_2 then
    L6_2 = A0_2.address
  end
  L5_2.house = L6_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = "info"
  L2_2(L3_2, L4_2)
  L2_2 = GetEntityCoords
  L3_2 = cache
  L3_2 = L3_2.ped
  L2_2 = L2_2(L3_2)
  L3_2 = vec3
  L4_2 = L1_2.coords
  L4_2 = L4_2.enter
  L4_2 = L4_2.x
  L5_2 = L1_2.coords
  L5_2 = L5_2.enter
  L5_2 = L5_2.y
  L6_2 = L1_2.coords
  L6_2 = L6_2.enter
  L6_2 = L6_2.z
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = L2_2 - L3_2
  L4_2 = #L4_2
  if L4_2 < 100.0 then
    L5_2 = SetNewWaypoint
    L6_2 = L1_2.coords
    L6_2 = L6_2.enter
    L6_2 = L6_2.x
    L7_2 = L1_2.coords
    L7_2 = L7_2.enter
    L7_2 = L7_2.y
    L5_2(L6_2, L7_2)
    L5_2 = Notification
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "metakey.key_info"
    L8_2 = {}
    L9_2 = A0_2.houseName
    L8_2.house = L9_2
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = " - GPS updated"
    L6_2 = L6_2 .. L7_2
    L7_2 = "info"
    L5_2(L6_2, L7_2)
  end
end
L14_1(L15_1, L16_1)






