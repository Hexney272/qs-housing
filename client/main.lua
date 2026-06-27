HouseZones = {}
EnteredHouse = nil
FrontCam = false
EnteringHouse = false
CurrentHouse = nil
CurrentHouseData = {
  haskey = false,
  isOwned = false,
  isOfficialOwner = false,
  rentable = false,
  purchasable = false,
  electricityCutOff = false,
  isOwnedByMe = false,
  billsCutOff = false,
  lightsOn = false,
}

local function GetLocaleResources()
  local locale = Config.Locale
  local resources = { [locale] = { translation = _T } }
  return locale, resources
end

local uiInitialized = false


RegisterNUICallback("initialized", function(data, cb)
  while not _T do
    Wait(200)
  end

  if uiInitialized then
    Debug("Already initialized")
    return cb("ok")
  end

  local locale, resources = GetLocaleResources()
  local config = Config

  local managementButtons = {}
  for k, v in pairs(config.ManagementButtons or {}) do
    managementButtons[k] = v
  end


  SendReactMessage("onUiReady", {
    languageName = locale,
    resources = resources,
    config = {
      debug = config.Debug,
      version = GetResourceMetadata(GetCurrentResourceName(), "version", 0),
      intl = config.Intl,
      upgrades = config.Upgrades,
      rentable = config.EnableRentable,
      hasQsPhone = "qs-smartphone" == config.Phone,
      creditEnable = config.CreditEnable,
      creditToggleActiveInDefault = config.CreditToggleActiveInDefault,
      soundPath = config.Path .. "sounds/",
      imagePath = config.ImagePath,
      board = {
        enable = config.EnableBoard,
        object = config.BoardObject,
      },
      maxApartmentCount = config.MaxApartmentCount,
      moneyTypes = config.MoneyTypes,
      music = config.Music,
      musicVolume = config.MusicVolume,
      sellObjectCommision = config.SellObjectCommision,
      managementButtons = managementButtons,
      doorBellSounds = config.DoorBellSounds,
      enableMetaKey = config.EnableMetaKey,
      decorateKeybinds = config.DecorateKeybinds,
      voiceAssistant = config.VoiceAssistant,
      IkeaDeliveryEnabled = config.IkeaDeliveryEnabled,
      IkeaDeliveryBoxModel = config.IkeaDeliveryBoxModel,
      IkeaDeliveryPedModel = config.IkeaDeliveryPedModel,
      IkeaDeliveryPedAnim = config.IkeaDeliveryPedAnim,
      IkeaDeliveryPedAttach = config.IkeaDeliveryPedAttach,
    },
  })


  uiInitialized = true
  TriggerServerEvent("housing:playerConnected")
  cb("ok")

  if not GetIdentifier() then
    return
  end

  while not HouseInitialized do
    Wait(100)
  end

  TriggerServerCallback("qb-houses:GetInside", function(house)
    if house and "nil" ~= house and "" ~= house then
      Wait(100)
      TriggerEvent("qb-houses:client:LastLocationHouse", house)
    end
  end)
end)


function SendReactMessage(action, data)
  SendNUIMessage({ action = action, data = data })
end

RegisterNUICallback("notification", function(data, cb)
  Notification(data.message, data.type)
  cb("ok")
end)

RegisterNetEvent("housing:notification", function(message, type)
  Notification(message, type)
end)

Invited = false
CurrentDoorBell = 0
HouseObj = nil
POIOffsets = nil
SHELL_DATA = nil


local tabletState = {
  entity = nil,
  selecting = false,
  spawnHouse = nil,
}

function TriggerServerCallbackSync(eventName, ...)
  local p = promise.new()
  if not p then
    return false
  end
  TriggerServerCallback(eventName, function(...)
    p:resolve(...)
  end, ...)
  return Citizen.Await(p)
end

Config.DoorModels = {}


RegisterNetEvent("qb-houses:client:EnterHouse")
AddEventHandler("qb-houses:client:EnterHouse", function(isIpl, house, houseData)
  local ped = cache.ped
  local pedCoords = GetEntityCoords(ped)

  if not house then
    house = CurrentHouse
  end
  if not houseData then
    houseData = CurrentHouseData
  end
  if not house then
    Debug("No Current House")
    return
  end

  local houseConfig = Config.Houses[house]
  local enterCoords = vec3(houseConfig.coords.enter.x, houseConfig.coords.enter.y, houseConfig.coords.enter.z)
  local distance = #(pedCoords - enterCoords)

  if distance < 1.5 then
    if houseData.haskey then
      if isIpl then
        EnterIplHouse(house)
        return
      end
      EnterHouse(false, house)
    else
      if not houseConfig.locked then
        if isIpl then
          EnterIplHouse(house, true)
          return
        end
        EnterHouse(true, house)
      end
    end
  end
end)


RegisterNetEvent("qb-houses:client:RequestRing")
AddEventHandler("qb-houses:client:RequestRing", function()
  if CurrentHouse then
    lib.playAnim(cache.ped, "gestures@f@standing@casual", "gesture_point")
    TriggerServerEvent("qb-houses:server:RingDoor", CurrentHouse)
  else
    Notification(i18n.t("house_not_found"), "error")
  end
end)

HouseInitialized = false

RegisterNetEvent("housing:initHouses", function(houses)
  Config.Houses = houses

  while not GetIdentifier() do
    Wait(100)
  end

  HouseInitialized = true
  CreateBlips()
  RefreshPolyZones()
  BuildDoorLocks()
  GetHouseObjects()
  Debug("Initialized House Config")
end)


RegisterNetEvent("housing:setHouse", function(houseIds, houseData)
  if not houseIds then
    return Debug("setHouse ::: No House")
  end

  local isMultiWithData = nil
  if houseData then
    if type(houseIds) == "table" then
      isMultiWithData = true
    end
  end

  if type(houseIds) ~= "table" or not houseIds then
    houseIds = { houseIds }
  end

  for _, houseId in pairs(houseIds) do
    local data
    if isMultiWithData then
      data = table.clone(houseData)
    else
      data = houseData
    end

    if data then
      if data.apartmentNumber then
        data.apartmentNumber = houseId:match("apt%-%d+")
      end
    else
      DeleteMloDoors(houseId)
    end

    Config.Houses[houseId] = data
    CreateBlips(houseId)
  end

  creator:updateUI()
  RefreshPolyZones()
  BuildDoorLocks()
  Debug("Set House", "House", houseIds, "Data", houseData)
end)


RegisterNetEvent("housing:updateHouseData", function(houseId, keys, values)
  if not houseId then
    return Debug("updateHouseData ::: No House")
  end

  local houseConfig = Config.Houses[houseId]
  if not houseConfig then
    return Debug("updateHouseData ::: No Config House")
  end

  local isTable = true
  if type(keys) ~= "table" then
    keys = { keys }
    isTable = false
  end

  for i, key in pairs(keys) do
    if isTable then
      Config.Houses[houseId][key] = values[i]
    else
      Config.Houses[houseId][key] = values
    end

    if table.includes(keys, "mlo") then
      MLODoorsData[houseId] = nil
      Debug("updateHouseData ::: MLO Doors Data Cleared", "House", houseId)
    end
  end

  Debug("Updated House Data", "House", houseId, "Keys", keys, "Values", values)
  InitHouseBoards()

  if EnteredHouse then
    RefreshClosestHouse()
  end

  if table.includes(keys, "mlo") then
    BuildDoorLocks()
  end

  if table.includes(keys, "blip") then
    CreateBlips(houseId)
  end
end)


RegisterNetEvent("housing:syncLightsStatus", function(houseId, lightsOn)
  if not houseId then
    return
  end

  if CurrentHouse ~= houseId and EnteredHouse ~= houseId then
    goto done
  end

  CurrentHouseData.lightsOn = lightsOn
  Debug("Synced lights status", "House", houseId, "LightsOn", lightsOn)

  if EnteredHouse == houseId then
    local houseConfig = Config.Houses[houseId]
    if houseConfig then
      if not houseConfig.mlo then
        if lightsOn and not CurrentHouseData.billsCutOff then
          SetArtificialLightsState(false)
        else
          SetArtificialLightsState(true)
          SetArtificialLightsStateAffectsVehicles(false)
        end
      end
    end
  end

  ::done::
end)


function RefreshClosestHouse(overrideHouse)
  CurrentHouseData = {}

  if overrideHouse then
    if not EnteredHouse then
      CurrentHouse = overrideHouse
      Debug("RefreshClosestHouse ::: Overwrited CurrentHouse", CurrentHouse)
    end
  end

  if EnteredHouse then
    CurrentHouse = EnteredHouse
    Debug("RefreshClosestHouse ::: Overwrited CurrentHouse to EnteredHouse", CurrentHouse)
  end

  if not CurrentHouse then
    return Debug("RefreshClosestHouse ::: No Current House")
  end

  local houseConfig = Config.Houses[CurrentHouse]
  if not houseConfig then
    return Debug("RefreshClosestHouse ::: No Config House")
  end

  local data = TriggerServerCallbackSync("houses:getHouseData", CurrentHouse)
  CurrentHouseData = data or {}

  if CurrentHouseData.billsCutOff then
    if CurrentHouseData.haskey then
      Notification(i18n.t("house_not_payed_bills"), "error")
    end
  end

  TriggerHouseUpdateGarage()
  InitHouseInteractions()
  TriggerEvent("housing:handleEnterZone", CurrentHouse)
  TriggerServerEvent("housing:enterHouseZone", CurrentHouse)
  Debug("Refreshed Closest House", "CurrentHouse", CurrentHouse, "CurrentHouseData", CurrentHouseData)
end

exports("GetCurrentHouseData", function()
  return CurrentHouseData
end)


function HandleEnterPoly(houseId)
  local house = CurrentApartment and CurrentApartment.house or houseId
  CurrentHouse = house
  Debug("HandleEnterPoly", "House", CurrentHouse)

  decorate:close()
  TriggerEvent("weed:handleEnterZone", CurrentHouse)
  RefreshClosestHouse()
  common:dancersTick()
  assistant.tick()
  decorate:getObjects(CurrentHouse)
end

local function HandleExitPoly(houseId)
  if sellHousePhoto.active then
    return
  end

  if EnteredHouse then
    return Debug("handleExitPoly blocked, cause EnteredHouse")
  end

  if decorate.active then
    Notification(i18n.t("decorate.too_far"), "error")
    decorate:close()
    Debug("handleExitPoly ::: decorate", "decorate")
  end

  CurrentHouse = nil
  CurrentHouseData = {}
  CurrentApartment = nil
  TriggerHouseUpdateGarage()
  decorate:destroyObjects()
  TriggerEvent("weed:handleExitZone")
  TriggerEvent("housing:handleExitZone", houseId)
  TriggerServerEvent("housing:exitHouseZone", houseId)
end


function RefreshPolyZones(debug)
  if next(HouseZones) then
    for _, zone in pairs(HouseZones) do
      zone:remove()
    end
    HouseZones = {}
  end

  for houseId, houseConfig in pairs(Config.Houses) do
    if houseConfig.coords.PolyZone then
      if houseConfig.apartmentNumber then
        if "apt-0" ~= houseConfig.apartmentNumber then
          goto continue
        end
      end

      local zoneDebug = debug or Config.ZoneDebug
      local zone = lib.zones.poly({
        name = "setup_entry_poly" .. houseId,
        points = houseConfig.coords.PolyZone.points,
        thickness = houseConfig.coords.PolyZone.thickness,
        debug = zoneDebug,
        onEnter = function()
          Debug("Entered PolyZone", houseId)
          HandleEnterPoly(houseId)
        end,
        onExit = function()
          Debug("Exited PolyZone", houseId)
          HandleExitPoly(houseId)
        end,
      })
      HouseZones[houseId] = zone
    end
    ::continue::
  end

  InitHouseBoards()

  if Target then
    Target.houses = Config.Houses
    Target:formatHouses()
    Target:init()
    if Target.initObjectInteractions then
      Target:initObjectInteractions()
    end
  end
end


RegisterNetEvent("qb-houses:client:lockHouse")
AddEventHandler("qb-houses:client:lockHouse", function(locked, houseId)
  Config.Houses[houseId].locked = locked
end)

function BuildDoorLocks()
  if type(Config.Houses) == "table" then
    for houseId, houseConfig in pairs(Config.Houses) do
      if houseConfig.mlo then
        for doorIndex, door in pairs(houseConfig.mlo) do
          local doorId = houseId .. doorIndex
          Debug("BuildDoorLocks", "House", houseId, "Door", door)

          AddDoorToSystem(doorId, door.hash, door.coords.x, door.coords.y, door.coords.z, false, false, false)
          DoorSystemSetDoorState(doorId, door.locked and 1 or 0, false, false)
          SetStateOfClosestDoorOfType(doorId, door.coords.x, door.coords.y, door.coords.z, door.locked, 0.0, true)
        end
      end
    end
  end
end


function DeleteMloDoors(houseId)
  if not Config.Houses[houseId] then
    return Debug("DeleteMloDoors ::: No Config House")
  end

  if not Config.Houses[houseId].mlo then
    return Debug("DeleteMloDoors ::: No MLO Doors")
  end

  for doorIndex in pairs(Config.Houses[houseId].mlo) do
    local doorId = houseId .. doorIndex
    RemoveDoorFromSystem(doorId)
  end
end

exports("getHouseList", function()
  while not HouseInitialized do
    Wait(500)
  end
  return Config.Houses
end)


RegisterNetEvent("qb-houses:client:toggleDoorlock")
AddEventHandler("qb-houses:client:toggleDoorlock", function()
  local ped = cache.ped
  local pedCoords = GetEntityCoords(ped)
  local houseConfig = Config.Houses[CurrentHouse]

  if houseConfig.mlo then
    local newLocked = not houseConfig.mlo[1].locked
    TriggerServerEvent("qb-houses:mloToggleAllDoors", CurrentHouse, newLocked)
    return
  end

  local enterCoords = vec3(houseConfig.coords.enter.x, houseConfig.coords.enter.y, houseConfig.coords.enter.z)
  local distance = #(pedCoords - enterCoords)

  if distance then
    if CurrentHouseData.haskey then
      if houseConfig.locked then
        TriggerServerEvent("qb-houses:server:lockHouse", false, CurrentHouse)
        Notification(i18n.t("door_unlocked"), "info")
      else
        TriggerServerEvent("qb-houses:server:lockHouse", true, CurrentHouse)
        Notification(i18n.t("door_locked"), "info")
      end
    else
      Notification(i18n.t("not_have_keys"), "error")
    end
  else
    Notification(i18n.t("house_not_found"), "error")
  end
end)


RegisterNetEvent("qb-houses:requiredLeaveHouse", function(houseIds)
  if type(houseIds) ~= "table" or not houseIds then
    houseIds = { houseIds }
  end

  for _, houseId in pairs(houseIds) do
    if EnteredHouse == houseId then
      local houseConfig = Config.Houses[EnteredHouse]
      if houseConfig.ipl then
        LeaveIplHouse(EnteredHouse, true)
      else
        LeaveHouse()
      end
      Notification(i18n.t("kick_house"), "info")
    end
  end
end)

function DoorAnim()
  PlayAnimation(cache.ped, "anim@heists@keycard@", "exit")
  Wait(400)
  ClearPedTasks(cache.ped)
end


RegisterNetEvent("qb-houses:client:RingDoor")
AddEventHandler("qb-houses:client:RingDoor", function(playerId, houseId)
  if EnteredHouse == houseId then
    CurrentDoorBell = playerId
    PlayDoorbell(houseId)
  end
end)

function PlayDoorbell(houseId)
  if EnteredHouse ~= houseId then
    Debug("PlayDoorbell ::: Not Entered House", "EnteredHouse", EnteredHouse, "House", houseId)
    return
  end

  if not Config.DisableInteractSound then
    if EnteredHouse then
      local houseConfig = Config.Houses[EnteredHouse]
      if houseConfig then
        local sound = houseConfig.doorbellSound
        if not sound then
          sound = Config.DoorBellSounds[1].value
        end
        SendReactMessage("play_sound", { sound = sound })
        Notification(i18n.t("ring_door"), "info")
      end
    end
  end
end

RegisterNetEvent("housing:playDoorbell", PlayDoorbell)


RegisterNetEvent("qb-houses:client:SpawnInApartment")
AddEventHandler("qb-houses:client:SpawnInApartment", function(houseId)
  CurrentHouse = houseId
  Invited = true

  if not Config.Houses[houseId].ipl then
    EnterHouse(true, houseId)
  else
    EnterIplHouse(houseId, true)
  end
end)

exports("getHouseData", function(houseId)
  return Config.Houses[houseId]
end)


function EnterHouse(inOwnerless, houseId)
  if not houseId then
    houseId = CurrentHouse
    Debug("No House Passed, Using Current House", "CurrentHouse", CurrentHouse)
  end

  if not houseId then
    return Notification(i18n.t("house_not_found"), "error")
  end

  local houseConfig = Config.Houses[houseId]
  if not houseConfig then
    return Notification(i18n.t("house_not_found"), "error")
  end

  local tier = houseConfig.tier
  local shellConfig = Config.Shells[tier]
  if not shellConfig then
    print("Tier is not valid")
    return
  end


  if not houseConfig.coords.exit then
    DoScreenFadeIn(0)
    Notification(i18n.t("we_cant_find_exit_zone"), "error")

    local exitCoords = RayCastSelector("exit", {
      tier = houseConfig.tier,
      coords = vec4(houseConfig.coords.shellCoords.x, houseConfig.coords.shellCoords.y, houseConfig.coords.shellCoords.z, houseConfig.coords.shellCoords.h),
    })

    TriggerServerEvent("housing:updateExitCoords", houseId, exitCoords)
    return
  end

  EnteredHouse = houseId
  if not CurrentHouse then
    Debug("EnterHouse ::: Forcing to set current house")
    HandleEnterPoly(houseId)
  end

  Wait(300)

  if not Config.DisableInteractSound then
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
  end

  TriggerServerEvent("qs-housing:enableAntiTeleport")
  DoorAnim()
  Citizen.Wait(250)


  lib.callback.await("housing:routePlayer", false, houseId)

  local isNotInvited = not Invited
  local hasSensor = table.includes(houseConfig.upgrades, "sensor")

  if hasSensor and isNotInvited then
    SensorDispatch()
  end

  SHELL_DATA = CreateShell(houseConfig.coords.shellCoords, houseConfig.coords.exit, shellConfig.model)
  Citizen.Wait(100)

  HouseObj = SHELL_DATA[1]
  POIOffsets = SHELL_DATA[2]

  if Target then
    Target:initExit()
  end

  EnteringHouse = true
  TriggerServerEvent("housing:setInside", houseId, true)
  Wait(500)

  SetRainFxIntensity(0.0)
  WeatherSyncEvent(true)
  decorate:getObjects(houseId)
  InitHouseInteractions(houseId)
  TriggerEvent("qb-weed:client:getHousePlants", houseId)
  Citizen.Wait(100)


  SetWeatherTypePersist("EXTRASUNNY")
  SetWeatherTypeNow("EXTRASUNNY")
  SetWeatherTypeNowPersist("EXTRASUNNY")
  NetworkOverrideClockTime(Config.TimeInterior, 0, 0)
  EnteringHouse = false

  if inOwnerless then
    inOwned = true
  end

  if CurrentHouseData.billsCutOff or CurrentHouseData.lightsOn then
    SetArtificialLightsState(true)
    SetArtificialLightsStateAffectsVehicles(false)
  end

  TriggerEvent("housing:onEnterHouse", houseId)
end


RegisterNetEvent("qb-houses:client:enterOwnedHouse", function(houseId)
  local houseConfig = Config.Houses[houseId]
  if not houseConfig then
    return Notification(i18n.t("house_not_found"), "error")
  end

  if houseConfig.ipl then
    EnterIplHouse(houseId)
  else
    if houseConfig.coords.test then
      SetEntityCoords(cache.ped, houseConfig.coords.test.x, houseConfig.coords.test.y, houseConfig.coords.test.z)
    else
      EnterHouse(false, houseId)
    end
  end
end)


RegisterNetEvent("qb-houses:client:LastLocationHouse")
AddEventHandler("qb-houses:client:LastLocationHouse", function(houseId)
  if not houseId then
    return Notification(i18n.t("house_not_found"), "error")
  end

  if not Config.Houses[houseId] then
    return Notification(i18n.t("house_not_found"), "error")
  end

  if not Config.Houses[houseId].ipl then
    EnterHouse(false, houseId)
  else
    EnterIplHouse(houseId)
  end

  Debug("Last Location House", "House", houseId)
  RefreshClosestHouse(houseId)
end)


function LeaveHouse(houseId)
  Debug("LeaveHouse", "House", houseId)

  if not houseId then
    houseId = EnteredHouse
    Debug("No House Passed, Using Current House", "EnteredHouse", EnteredHouse)
  end

  if not houseId then
    return Notification(i18n.t("house_not_found"), "error")
  end

  if not Config.Houses[houseId] then
    return Notification(i18n.t("house_not_found"), "error")
  end

  local houseConfig = Config.Houses[houseId]

  if not Config.DisableInteractSound then
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
  end

  DoorAnim()
  Citizen.Wait(250)
  DoScreenFadeOut(250)
  Citizen.Wait(500)


  DespawnInterior(HouseObj, function()
    WeatherSyncEvent(false)
    Citizen.Wait(250)
    DoScreenFadeIn(250)

    SetEntityCoords(cache.ped, houseConfig.coords.enter.x, houseConfig.coords.enter.y, houseConfig.coords.enter.z + 0.2)
    SetEntityHeading(cache.ped, houseConfig.coords.enter.h)

    TriggerServerEvent("housing:routePlayerToDefault", houseId)
    inOwned = false
    TriggerServerEvent("housing:setInside", houseId, false)
    TriggerEvent("housing:onExitHouse", houseId)

    EnteredHouse = nil

    if Target then
      Target:destroyExit()
    end

    Invited = false
    ShowingHouse = false

    if CurrentApartment then
      CurrentHouse = CurrentApartment.house
      CurrentHouseData = CurrentApartment.currentHouseData
      CurrentApartment = nil
    end

    TriggerServerEvent("qs-housing:disableAntiTeleport")
    Wait(300)
  end)

  SetArtificialLightsState(false)
end


exports("getCurrentHouse", function()
  return CurrentHouse
end)

exports("getEnteredHouse", function()
  return EnteredHouse
end)

RegisterNetEvent("housing:refreshHouse", function(houseId)
  CreateBlips(houseId)
  Debug("Refreshed House", "House", houseId)

  if CurrentHouse == houseId then
    RefreshClosestHouse(houseId)
  end

  management:updateUI(houseId)
end)


local securityCamPlayers = {}

RegisterNetEvent("housing:toggleInSecurityCam", function(playerId, status)
  securityCamPlayers[playerId] = status
end)

CreateThread(function()
  while true do
    for serverId, status in pairs(securityCamPlayers) do
      local player = GetPlayerFromServerId(serverId)
      if player and -1 ~= player then
        if player ~= PlayerId() then
          local playerPed = GetPlayerPed(player)
          local alpha = GetEntityAlpha(playerPed)

          if "deleted" == status then
            SetEntityAlpha(playerPed, 255, false)
            SetEntityVisible(playerPed, true, false)
            securityCamPlayers[serverId] = nil
            Debug("housing:toggleInSecurityCam deleted", serverId)
          elseif 0 ~= alpha then
            SetEntityAlpha(playerPed, 0, false)
            SetEntityVisible(playerPed, false, false)
            Debug("housing:toggleInSecurityCam alpha setted to 0", serverId)
          end
        end
      end
    end
    Wait(500)
  end
end)


exports("enterHouse", function(houseId, isGuest)
  if not Config.Houses[houseId] then
    return Error("enterHouse ::: No Config House", "House", houseId)
  end

  if Config.Houses[houseId].ipl then
    EnterIplHouse(houseId, isGuest)
    Debug("enterHouse ::: Entering IPL House", "House", houseId)
  else
    EnterHouse(isGuest, houseId)
    Debug("enterHouse ::: Entering House", "House", houseId)
  end
end)

AddEventHandler("housing:radial:enterHouse", function()
  EnterHouse()
end)

AddEventHandler("housing:radial:exitHouse", function()
  LeaveHouse()
end)


function ToggleCameraUI(visible, label, camType)
  SendReactMessage("toggle_camera", {
    visible = visible,
    label = label,
    type = camType,
  })
end

function FrontDoorCam(coords, cameraInHouse)
  local houseConfig = Config.Houses[CurrentHouse]
  local camCoords = vec4(coords.x, coords.y, coords.z, coords.h or 0.0)
  coords = camCoords

  DoScreenFadeOut(150)
  Wait(500)
  Debug("FrontDoorCam", "coords", coords, "cameraInHouse", cameraInHouse)

  local offsetCoords = GetCoordsWithOffset(coords, vec3(-0.4, 0.0, 0.0))

  local cam = Utils.CreateCamera("DEFAULT_SCRIPTED_CAMERA", offsetCoords, vec3(0.0, 0.0, coords.w - 180.0), true)
  FrontCam = true

  SetEntityAlpha(cache.ped, 0, false)
  SetEntityVisible(cache.ped, false, false)
  FreezeEntityPosition(cache.ped, true)
  TriggerServerEvent("housing:toggleInSecurityCam", true)


  local shouldEnterAfter = cameraInHouse and not EnteredHouse
  local shouldExitAfter = not cameraInHouse
  local hasCamera = houseConfig.upgrades and table.includes(houseConfig.upgrades, "camera")

  if shouldEnterAfter then
    SetEntityAlpha(cache.ped, 0, false)
    SetEntityVisible(cache.ped, false, false)
    if houseConfig.ipl then
      EnterIplHouse(CurrentHouse)
    else
      EnterHouse()
    end
  elseif shouldExitAfter then
    if houseConfig.ipl then
      LeaveIplHouse(CurrentHouse)
    else
      LeaveHouse()
    end
  end

  Wait(500)
  DoScreenFadeIn(150)

  ToggleCameraUI(true, houseConfig.address, hasCamera and "modern" or "peephole")

  Utils.DrawInstructional({ { key = "cancel", label = "Exit" } })


  CreateThread(function()
    while FrontCam do
      Wait(0)
      Utils.HandleFlyCam(cam, { mouse = true, keyboard = false })
      SetTimecycleModifier("scanline_cam_cheap")
      SetTimecycleModifierStrength(1.0)
      SetEntityInvincible(cache.ped, true)

      if IsControlJustPressed(1, Keys.BACKSPACE) then
        DoScreenFadeOut(150)
        ToggleCameraUI(false)
        Citizen.Wait(500)
        Utils.DestroyFlyCam(cam)
        ClearTimecycleModifier()
        FrontCam = false

        SetEntityAlpha(cache.ped, 255, false)
        SetEntityVisible(cache.ped, true, false)

        if shouldEnterAfter then
          if houseConfig.ipl then
            LeaveIplHouse(CurrentHouse)
          else
            LeaveHouse()
          end
        else
          if shouldExitAfter then
            if houseConfig.ipl then
              EnterIplHouse(CurrentHouse)
            else
              EnterHouse()
            end
          end
        end

        FreezeEntityPosition(cache.ped, false)
        TriggerServerEvent("housing:toggleInSecurityCam", false)
        Citizen.Wait(500)
        DoScreenFadeIn(150)
      end
    end

    Utils.RemoveInstructional()
    SetEntityInvincible(cache.ped, false)
  end)
end


RegisterNetEvent("qb-houses:client:viewHouse")
AddEventHandler("qb-houses:client:viewHouse", function(housePrice, brokerFee, bankFee, taxes, firstname, lastname, rent)
  contract:open({
    firstname = firstname,
    lastname = lastname,
    street = Config.Houses[CurrentHouse].address,
    houseprice = housePrice,
    brokerfee = brokerFee,
    bankfee = bankFee,
    taxes = taxes,
    totalprice = housePrice + brokerFee + bankFee + taxes,
    credit = housePrice * Config.CreditEq,
    rent = rent,
  })
end)


HouseObjects = {}

function RemoveSpawnedHouseObjects()
  for _, obj in pairs(HouseObjects) do
    RemoveSpawnedHouseObject(obj)
  end
  Debug("RemoveSpawnedHouseObjects")
end

local function ClearHouseObjects()
  RemoveSpawnedHouseObjects()
  HouseObjects = {}
end

function SpawnPed(model, coords, heading)
  local hash = joaat(model)
  lib.requestModel(hash, Config.DefaultRequestModelTimeout)

  local ped = CreatePed(4, hash, coords.x, coords.y, coords.z - 1.0, heading, false, false)
  SetEntityAsMissionEntity(ped, true, true)
  SetBlockingOfNonTemporaryEvents(ped, true)
  SetModelAsNoLongerNeeded(hash)
  FreezeEntityPosition(ped, true)
  SetEntityCoords(ped, coords.x, coords.y, coords.z, false, false, false, false)
  SetEntityInvincible(ped, true)
  SetPedCanRagdoll(ped, false)
  Debug("Spawned ped", "ped", ped)
  return ped
end


function PlayAnimation(ped, dict, anim, speed)
  if not speed then
    speed = 1.0
  end
  lib.requestAnimDict(dict)
  TaskPlayAnim(ped, dict, anim, 8.0, 1.0, -1, 1, 1.0, true, true, true)
  RemoveAnimDict(dict)
  Debug("PlayAnimation", "ped", ped, "dict", dict, "anim", anim)
end

function SpawnHouseObject(model, coords, heading)
  local hash = joaat(model)
  lib.requestModel(hash, Config.DefaultRequestModelTimeout)

  local obj = CreateObject(hash, coords.x, coords.y, coords.z, false, false, false)
  SetEntityHeading(obj, heading)
  SetEntityCompletelyDisableCollision(obj, true, false)
  FreezeEntityPosition(obj, true)
  SetEntityInvincible(obj, true)
  SetEntityAsMissionEntity(obj, true, true)
  SetModelAsNoLongerNeeded(hash)
  SetEntityCoords(obj, coords.x, coords.y, coords.z, false, false, false, false)
  Debug("Spawned object", "object", obj)
  return obj
end


function InitConstruction(data)
  local construction = data.construction
  if not construction then
    Error("InitConstruction :: Construction data is nil", "data", data)
    return
  end

  Debug("construction model", construction.model)
  local obj = SpawnHouseObject(construction.model, data.coords, data.coords.w)
  if not obj then
    Error("InitConstruction :: Failed to spawn object", "construction", construction)
    return
  end

  data.handle = obj
  data.constructionPeds = {}

  for _, pedData in pairs(construction.peds) do
    Debug("construction ped", pedData.model)
    local pedCoords = GetOffsetFromEntityInWorldCoords(obj, pedData.offsets.x, pedData.offsets.y, pedData.offsets.z)
    local ped = SpawnPed(pedData.model, pedCoords, pedData.heading)
    PlayAnimation(ped, pedData.dict, pedData.anim)
    table.insert(data.constructionPeds, ped)
  end

  Debug("InitConstruction", "object", obj)
end


function RemoveSpawnedHouseObject(data)
  if not data.handle then
    Debug("RemoveSpawnedHouseObject :: Object is not spawned", "data", data)
    return false
  end

  if data.construction then
    if not creator.visible then
      return RemoveConstruction(data)
    end
  end

  DeleteObject(data.handle)
  data.handle = nil
  Debug("RemoveSpawnedHouseObject", "object", data.handle)
end

function RemoveConstruction(data)
  if not data.construction then
    Error("RemoveConstruction :: Construction data is nil", "data", data)
    return
  end

  if data.constructionPeds then
    for _, ped in pairs(data.constructionPeds) do
      DeleteEntity(ped)
    end
  end

  data.constructionPeds = nil
  DeleteObject(data.handle)
  data.handle = nil
  Debug("RemoveConstruction", "object", data.handle)
end


CreateThread(function()
  while true do
    local ped = cache.ped
    local pedCoords = GetEntityCoords(ped)

    for index, obj in pairs(HouseObjects) do
      local objPos = vec3(obj.coords.x, obj.coords.y, obj.coords.z)
      local distance = #(pedCoords - objPos)

      if distance >= 250 then
        if obj.handle then
          if not obj.isIsland then
            RemoveSpawnedHouseObject(obj)
          end
        end
      end

      if distance < 250 then
        if not obj.handle then
          if obj.construction then
            if not creator.visible then
              InitConstruction(obj)
            end
          else
            local handle = SpawnHouseObject(obj.model, objPos, obj.coords.w)
            if handle then
              HouseObjects[index].handle = handle
            end
          end
        end
      end
    end

    Wait(400)
  end
end)


local function MarkIslandObjects()
  for index, obj in pairs(HouseObjects) do
    for _, island in pairs(Config.Islands) do
      if obj.model == island.model then
        HouseObjects[index].isIsland = true
        break
      end
    end
  end
end

function InitConstructions()
  for houseId, houseConfig in pairs(Config.Houses) do
    local found = table.find(HouseObjects, function(obj)
      return obj.house == houseId
    end)

    if found then
      houseConfig.construction = found.construction
      Debug("initConstructions", "House", houseId, "Construction", houseConfig.construction)
    else
      houseConfig.construction = nil
    end
  end
end


function GetHouseObjects()
  if #HouseObjects > 0 then
    ClearHouseObjects()
  end

  local objects = TriggerServerCallbackSync("qb-houses:server:GetHouseObjects")
  HouseObjects = objects or {}
  MarkIslandObjects()
  InitConstructions()
end

RegisterNetEvent("housing:updateHouseObject", function(objectId, newData)
  local found, foundIndex = table.find(HouseObjects, function(obj)
    return obj.id == objectId
  end)

  if not found then
    Error("housing:updateHouseObject", "Object not found", foundIndex)
    return
  end

  if #HouseObjects > 0 then
    RemoveSpawnedHouseObjects()
  end

  HouseObjects[foundIndex] = newData
  MarkIslandObjects()
  InitConstructions()
  Debug("Updated House Object", "ID", foundIndex, "Data", newData)
end)


RegisterNetEvent("qb-houses:client:createHouseObject", function(objectData)
  table.insert(HouseObjects, objectData)
  MarkIslandObjects()
  InitConstructions()
end)

RegisterNetEvent("housing:deleteHouseObject", function(houseId)
  RemoveSpawnedHouseObjects()
  HouseObjects = table.filter(HouseObjects, function(obj)
    return obj.house ~= houseId
  end)
  MarkIslandObjects()
end)


local function DestroyTabletEntity()
  if tabletState.entity then
    if DoesEntityExist(tabletState.entity) then
      DeleteObject(tabletState.entity)
    end
  end
  tabletState.entity = nil
  tabletState.spawnHouse = nil
end


function CleanupPlayerHousingState(isResourceStop)
  isResourceStop = true == isResourceStop
  local ped = cache.ped
  if not ped then
    ped = PlayerPedId()
  end

  local house = EnteredHouse or CurrentHouse

  FrontCam = false
  ToggleCameraUI(false)
  ClearTimecycleModifier()
  SetEntityInvincible(ped, false)
  SetEntityAlpha(ped, 255, false)
  SetEntityVisible(ped, true, false)
  FreezeEntityPosition(ped, false)
  SetArtificialLightsState(false)

  if house then
    TriggerEvent("housing:onExitHouse", house)
    TriggerEvent("housing:handleExitZone", house)

    if not isResourceStop then
      local houseConfig = Config.Houses[house]
      if houseConfig then
        if houseConfig.ipl then
          TriggerServerEvent("qb-houses:leaveIplHouse", house)
        end
      end
      TriggerServerEvent("housing:routePlayerToDefault", house)
      TriggerServerEvent("housing:setInside", house, false)
      TriggerServerEvent("qs-housing:disableAntiTeleport")
    end
  end


  if HouseObj then
    local oldObj = HouseObj
    HouseObj = nil
    DespawnInterior(oldObj, function() end)
  end

  DestroyTabletEntity()
  ClearHouseObjects()

  if cleanerRobot then
    if cleanerRobot.cleanAll then
      cleanerRobot:cleanAll()
    end
  end

  if junk then
    if junk.cleanAll then
      junk:stopInteractionLoop()
      junk:cleanAll()
    end
  end

  if Target then
    Target:destroyExit()
  end

  securityCamPlayers = {}
  CurrentDoorBell = 0
  EnteredHouse = nil
  CurrentHouse = nil
  CurrentHouseData = {}
  CurrentApartment = nil
  EnteringHouse = false
  Invited = false
  ShowingHouse = false
  HouseObj = nil
  POIOffsets = nil
  SHELL_DATA = nil

  if DeleteBlips then
    DeleteBlips()
  end
end


RegisterNetEvent("housing:client:PlayerUnloadCleanup", function()
  CleanupPlayerHousingState(false)
end)

exports("CleanupPlayerHousingState", CleanupPlayerHousingState)

AddEventHandler("onResourceStop", function(resourceName)
  if GetCurrentResourceName() ~= resourceName then
    return
  end
  CleanupPlayerHousingState(true)
end)


local function CoordsToVec3(coords)
  return vec3(coords.x, coords.y, coords.z)
end

local function HasHouseKey()
  if CurrentHouseData then
    return CurrentHouseData.haskey or CurrentHouseData.isOfficialOwner
  end
  return CurrentHouseData
end

local function HasCameraUpgrade()
  if not CurrentHouse then
    return false
  end

  local houseConfig = Config.Houses[CurrentHouse]
  if houseConfig then
    if type(houseConfig.upgrades) == "table" then
      return table.includes(houseConfig.upgrades, "camera")
    end
  end
  return false
end


local function GetTabletCoords()
  local tabletData
  if CurrentHouseData then
    tabletData = CurrentHouseData.tablet
  end

  if not tabletData then
    return nil
  end

  if type(tabletData) == "string" then
    tabletData = json.decode(tabletData)
  end

  if tabletData and tabletData.x and tabletData.y and tabletData.z then
    return tabletData
  end
  return nil
end


local function SpawnTabletEntity()
  if not CurrentHouse then
    return
  end

  if not HasCameraUpgrade() then
    DestroyTabletEntity()
    return
  end

  local tabletCoords = GetTabletCoords()
  if not tabletCoords then
    Debug("spawnTabletEntity ::: Tablet not found")
    DestroyTabletEntity()
    return
  end

  if tabletState.entity then
    if DoesEntityExist(tabletState.entity) then
      if tabletState.spawnHouse == CurrentHouse then
        DestroyTabletEntity()
      end
    end
  end

  local hash = joaat(Config.TabletModel)
  lib.requestModel(hash, Config.DefaultRequestModelTimeout)

  local obj = CreateObject(hash, tabletCoords.x, tabletCoords.y, tabletCoords.z, false, false, false)
  SetEntityHeading(obj, tabletCoords.w or tabletCoords.h or 0.0)
  FreezeEntityPosition(obj, true)
  SetEntityAsMissionEntity(obj, true, true)
  SetEntityInvincible(obj, true)
  SetModelAsNoLongerNeeded(hash)

  tabletState.entity = obj
  tabletState.spawnHouse = CurrentHouse
end


local function SelectTabletPlacement()
  if tabletState.selecting then
    return
  end
  if CurrentApartment then
    return
  end
  if not CurrentHouse then
    return
  end
  if not HasHouseKey() then
    return
  end

  tabletState.selecting = true

  CreateThread(function()
    local house = CurrentHouse
    local points = creator:selectPoint("object", 1, {
      model = Config.TabletModel,
      externalUsage = true,
      checkInside = function(coords)
        if not EnteredHouse then
          return HouseZones[house]:contains(coords)
        end
        return EnteredHouse
      end,
    })

    if points then
      local point = points[1]
      if point and CurrentHouse then
        local location = { x = point.x, y = point.y, z = point.z, w = point.w }
        TriggerServerEvent("qb-houses:server:setLocation", location, CurrentHouse, 9)
        CurrentHouseData.tablet = location
        Notification(i18n.t("management.tablet_location_saved"), "success")
      end
    else
      Notification(i18n.t("management.tablet_placement_cancelled"), "info")
    end

    tabletState.selecting = false
  end)
end


function InitHouseInteractions(houseId)
  if not houseId then
    houseId = CurrentHouse
  end

  if not CurrentHouse then
    return Debug("InitHouseInteractions ::: No Current House")
  end

  local locations = lib.callback.await("housing:getLocations", 0, houseId)

  if locations then
    if nil ~= locations.stash then
      local stashCoords = CoordsToVec3(json.decode(locations.stash))
      if CurrentHouseData.stash ~= stashCoords then
        CurrentHouseData.stash = stashCoords
      end
    end

    if nil ~= locations.outfit then
      local outfitCoords = CoordsToVec3(json.decode(locations.outfit))
      if CurrentHouseData.wardrobe ~= outfitCoords then
        CurrentHouseData.wardrobe = outfitCoords
      end
    end

    if nil ~= locations.logout then
      local logoutCoords = CoordsToVec3(json.decode(locations.logout))
      if CurrentHouseData.logout ~= logoutCoords then
        CurrentHouseData.logout = logoutCoords
      end
    end

    if nil ~= locations.charge then
      local chargeCoords = CoordsToVec3(json.decode(locations.charge))
      if CurrentHouseData.charge ~= chargeCoords then
        CurrentHouseData.charge = chargeCoords
      end
    else
      CurrentHouseData.charge = nil
    end


    if nil ~= locations.delivery then
      local deliveryCoords = CoordsToVec3(json.decode(locations.delivery))
      if CurrentHouseData.delivery ~= deliveryCoords then
        CurrentHouseData.delivery = deliveryCoords
      end
    end

    if nil ~= locations.tablet then
      local tabletData = json.decode(locations.tablet)
      if tabletData and tabletData.x and tabletData.y and tabletData.z then
        CurrentHouseData.tablet = {
          x = tabletData.x,
          y = tabletData.y,
          z = tabletData.z,
          w = tabletData.w or tabletData.h or 0.0,
        }
      end
    else
      CurrentHouseData.tablet = nil
    end
  end

  SpawnTabletEntity()

  if Target then
    Target:initInsideInteractions()
  end
end


AddEventHandler("housing:handleEnterZone", function(houseId)
  if houseId and CurrentHouse == houseId then
    SpawnTabletEntity()
  end
end)

AddEventHandler("housing:handleExitZone", function()
  DestroyTabletEntity()
end)

AddEventHandler("housing:onEnterHouse", function(houseId)
  if not Config.Houses[houseId] then
    return
  end
  SpawnTabletEntity()
end)

AddEventHandler("housing:onExitHouse", function()
  DestroyTabletEntity()
end)


RegisterNetEvent("qb-houses:client:setLocation")
AddEventHandler("qb-houses:client:setLocation", function(data)
  local ped = cache.ped
  local pedCoords = GetEntityCoords(ped)
  local location = { x = pedCoords.x, y = pedCoords.y, z = pedCoords.z }

  if CurrentHouse then
    local houseConfig = Config.Houses[CurrentHouse]
    if houseConfig then
      if not CurrentHouseData.haskey then
        return Notification(i18n.t("not_have_keys"), "error")
      end

      local id = data.id
      if "setstash" == id then
        TriggerServerEvent("qb-houses:server:setLocation", location, CurrentHouse, 1)
      elseif "setoutfit" == id then
        TriggerServerEvent("qb-houses:server:setLocation", location, CurrentHouse, 2)
      elseif "setlogout" == id then
        TriggerServerEvent("qb-houses:server:setLocation", location, CurrentHouse, 3)
      elseif "setCharge" == id then
        location = vec3(pedCoords.x, pedCoords.y, pedCoords.z)
        TriggerServerEvent("qb-houses:server:setLocation", location, CurrentHouse, 4)
      elseif "setDecorate" == id then
        location = vec3(pedCoords.x, pedCoords.y, pedCoords.z)
        TriggerServerEvent("qb-houses:server:setLocation", location, CurrentHouse, 5)
      elseif "setTv" == id then
        location = vec3(pedCoords.x, pedCoords.y, pedCoords.z)
        TriggerServerEvent("qb-houses:server:setLocation", location, CurrentHouse, 6)
      elseif "setSit" == id then
        location = vec3(pedCoords.x, pedCoords.y, pedCoords.z)
        TriggerServerEvent("qb-houses:server:setLocation", location, CurrentHouse, 7)


      elseif "setTablet" == id then
        local house = CurrentHouse
        local points = creator:selectPoint("object", 1, {
          model = Config.TabletModel,
          externalUsage = true,
          checkInside = function(coords)
            if not EnteredHouse then
              return HouseZones[house]:contains(coords)
            end
            return EnteredHouse
          end,
        })

        if not points or not points[1] then
          return
        end

        TriggerServerEvent("qb-houses:server:setLocation", points[1], CurrentHouse, 9)
      end
    end
  end
end)


RegisterNetEvent("qb-houses:client:refreshLocations")
AddEventHandler("qb-houses:client:refreshLocations", function(houseId, locationData, locationType)
  local updated = nil
  Debug("RefreshLocations ::: House", houseId, "Location", locationData, "Type", locationType)

  if CurrentHouse == houseId then
    local coords = CoordsToVec3(json.decode(locationData))

    if 1 == locationType then
      if CurrentHouseData.stash ~= coords then
        CurrentHouseData.stash = coords
        updated = true
      end
    elseif 2 == locationType then
      if CurrentHouseData.wardrobe ~= coords then
        CurrentHouseData.wardrobe = coords
        updated = true
      end
    elseif 3 == locationType then
      if CurrentHouseData.logout ~= coords then
        CurrentHouseData.logout = coords
        updated = true
      end
    elseif 4 == locationType then
      if CurrentHouseData.charge ~= coords then
        CurrentHouseData.charge = coords
        updated = true
      end
    elseif 8 == locationType then
      if CurrentHouseData.delivery ~= coords then
        CurrentHouseData.delivery = coords
        updated = true
      end


    elseif 9 == locationType then
      local tabletData = json.decode(locationData)
      Debug("RefreshLocations ::: Tablet", tabletData)

      if tabletData and tabletData.x and tabletData.y and tabletData.z then
        CurrentHouseData.tablet = {
          x = tabletData.x,
          y = tabletData.y,
          z = tabletData.z,
          w = tabletData.w or tabletData.h or 0.0,
        }
        updated = true
        SpawnTabletEntity()
      end
    end

    if Target and updated then
      Target:initInsideInteractions()
    end
  end
end)


exports("GetClosestHouse", function()
  return CurrentHouse
end)

exports("GetCurrentHouseUpgrades", function()
  local houseConfig = Config.Houses[CurrentHouse]
  return houseConfig.upgrades or {}
end)

RegisterCommand(Config.HireRenterCommand, function(source, args)
  local isAdmin = lib.callback.await("housing:isAdmin")
  if not isAdmin then
    return Notification(i18n.t("no_permission"), "error")
  end

  if not CurrentHouse then
    return Notification(i18n.t("house_not_found"), "error")
  end

  local houseConfig = Config.Houses[CurrentHouse]
  if houseConfig.apartmentNumber then
    OpenHireApartments()
    return
  end

  TriggerServerEvent("housing:hireRenter", CurrentHouse)
end)


function InspectHouse(houseConfig, houseId)
  local hasTestCoords = houseConfig.coords.test
  if not houseId then
    houseId = CurrentHouse
  end

  TestNotMLO = not hasTestCoords
  DoScreenFadeOut(500)

  if hasTestCoords then
    ShowRoomDefaultCoords = GetEntityCoords(cache.ped)
  end

  Wait(1000)

  if hasTestCoords then
    SetEntityCoords(cache.ped, vec3(houseConfig.coords.test.x, houseConfig.coords.test.y, houseConfig.coords.test.z))
  else
    if not houseConfig.ipl then
      EnterHouse(true)
    else
      EnterIplHouse(houseId, true)
    end
  end

  SetArtificialLightsState(false)
  ShowRoomLoop()
  DoScreenFadeIn(500)
end


function GetFurnitureStorageId(houseId)
  if not houseId then
    return nil
  end
  return ("furn_%s"):format(tostring(houseId))
end

function GetVaultCode(houseId)
  if not houseId then
    houseId = CurrentHouse
  end

  local codes = TriggerServerCallbackSync("housing:getVaultCodes", CurrentHouse)
  if codes then
    for _, entry in pairs(codes) do
      if tostring(entry.id) == tostring(houseId) then
        return entry.code
      end
    end
  end
  return false
end


function ChangeVaultCode(houseId)
  local code = keypad:open(i18n.t("vault_code.title"))
  if not code then
    return
  end

  TriggerServerEvent("housing:setVaultCode", {
    code = code,
    id = houseId or CurrentHouse,
    house = CurrentHouse,
  })
end

function OpenVaultCodeMenu(houseId)
  local currentCode = GetVaultCode(houseId)

  lib.registerContext({
    id = "vault_code_menu",
    title = i18n.t("vault_code.management_title"),
    options = {
      {
        title = i18n.t("vault_code.set_code"),
        icon = "fas fa-key",
        onSelect = function()
          ChangeVaultCode(houseId)
        end,
      },
      {
        title = i18n.t("vault_code.remove_code"),
        icon = "fas fa-key",
        disabled = not currentCode,
        onSelect = function()
          TriggerServerEvent("housing:removeVaultCode", {
            id = houseId or CurrentHouse,
            house = CurrentHouse,
          })
        end,
      },
    },
  })

  lib.showContext("vault_code_menu")
end


function CanAccessStash(houseId)
  if not CurrentHouseData then
    return false
  end

  if Config.StashNeedsKey then
    if not CurrentHouseData.haskey then
      Notification(i18n.t("not_have_keys"), "error")
      return false
    end
  end

  local code = GetVaultCode(houseId)
  if not code then
    return true
  end

  local input = keypad:open(i18n.t("vault_code.access_title"))
  if not input then
    return false
  end

  if input ~= code then
    Notification(i18n.t("vault_code.invalid_code"), "error")
    return false
  end

  return true
end


RegisterNUICallback("play_sound", function(sound, cb)
  if Config.DisableSounds then
    return cb("ok")
  end

  if "category_down" == sound then
    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
  elseif "item_down" == sound then
    PlaySoundFrontend(-1, "Object_Collect_Remote", "GTAO_FM_Events_Soundset", 0, 0, 1)
  elseif "finish" == sound then
    PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
  elseif "cancel" == sound then
    PlaySoundFrontend(-1, "MP_IDLE_KICK", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
  elseif "admin_active" == sound then
    PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 0, 0, 1)
  elseif "admin_disable" == sound then
    PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 0, 0, 1)
  elseif "hover_down" == sound then
    PlaySoundFrontend(-1, "Highlight_Accept", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 0, 0, 1)
  elseif "hover_up" == sound then
    PlaySoundFrontend(-1, "Highlight_Error", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 0, 0, 1)
  else
    Error("Unknown sound:", sound)
  end

  cb("ok")
end)


RegisterNUICallback("close", function(data, cb)
  SetNuiFocus(false, false)
  decorate:close()
  creator:close()
  furnitureCreator:close()
  management:close()
  contract:close()
  quickMenu:close()
  keypad.response = false
  keypad:close()
  housebrowser:close()
  SendReactMessage("toggle_info_card", { visible = false })
  cb(true)
end)


RegisterNetEvent("housing:showMetaKeyInfo", function(metadata)
  if not metadata or not metadata.houseId then
    return
  end

  local houseConfig = Config.Houses[metadata.houseId]
  if not houseConfig then
    Notification(i18n.t("metakey.house_not_exists"), "error")
    return
  end

  local houseName = metadata.houseName or metadata.address
  Notification(i18n.t("metakey.key_info", { house = houseName }), "info")

  local pedCoords = GetEntityCoords(cache.ped)
  local enterCoords = vec3(houseConfig.coords.enter.x, houseConfig.coords.enter.y, houseConfig.coords.enter.z)
  local distance = #(pedCoords - enterCoords)

  if distance < 100.0 then
    SetNewWaypoint(houseConfig.coords.enter.x, houseConfig.coords.enter.y)
    Notification(i18n.t("metakey.key_info", { house = metadata.houseName }) .. " - GPS updated", "info")
  end
end)
