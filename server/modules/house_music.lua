local MAX_DISTANCE = 50.0
local playersInHouse = {}

HousingHouseMusic = {}

local function getSoundId(houseName)
  return ("housing_music_%s"):format(houseName)
end

local function getHouseInteriorCoords(houseName)
  local houseConfig = Config.Houses[houseName]
  if not houseConfig then
    return nil
  end

  -- Try shell coords first
  if houseConfig.coords and houseConfig.coords.shellCoords then
    local shellCoords = houseConfig.coords.shellCoords
    if shellCoords and nil ~= shellCoords.x and nil ~= shellCoords.y and nil ~= shellCoords.z then
      return vector3(shellCoords.x, shellCoords.y, shellCoords.z)
    end
  end

  -- Try IPL coords
  if houseConfig.ipl and houseConfig.ipl.houseName then
    local iplData = Config.IplData and Config.IplData[houseConfig.ipl.houseName]
    if iplData and iplData.iplCoords then
      local coords = iplData.iplCoords
      if coords and nil ~= coords.x and nil ~= coords.y and nil ~= coords.z then
        return vector3(coords.x, coords.y, coords.z)
      end
    end
  end

  -- Try test coords as fallback
  if houseConfig.coords and houseConfig.coords.test then
    local testCoords = houseConfig.coords.test
    if testCoords and nil ~= testCoords.x and nil ~= testCoords.y and nil ~= testCoords.z then
      return vector3(testCoords.x, testCoords.y, testCoords.z)
    end
  end

  return nil
end

local function detectSoundProvider()
  if GetResourceState("mx-surround") == "started" then
    return "mx-surround"
  end
  if GetResourceState("qs-3dsound") == "started" then
    return "qs-3dsound"
  end
  if GetResourceState("xsound") == "started" then
    return "xsound"
  end
  return nil
end

local function destroySound(soundId)
  for _, resource in ipairs({ "mx-surround", "qs-3dsound" }) do
    if GetResourceState(resource) == "started" then
      pcall(function()
        exports[resource]:Destroy(-1, soundId)
      end)
    end
  end

  if GetResourceState("xsound") == "started" then
    pcall(function()
      exports.xsound:Destroy(-1, soundId)
    end)
  end
end

function HousingHouseMusicDestroyHouse(houseName)
  local musicData = HousingHouseMusic[houseName]
  local soundId
  if musicData and musicData.soundId then
    soundId = musicData.soundId
  else
    soundId = getSoundId(houseName)
  end

  destroySound(soundId)
  HousingHouseMusic[houseName] = nil
end

local function normalizeVolume(volume)
  if type(volume) ~= "number" or volume ~= volume then
    return 0.5
  end
  if volume < 0 then
    return 0.0
  end
  if volume > 1.5 then
    return 1.0
  end
  if volume > 1.0 then
    return volume / 100.0
  end
  return volume
end

local function canAccessMusic(source, houseName)
  local houseConfig = Config.Houses[houseName]
  if not houseConfig then
    return false
  end

  local identifier = GetIdentifier(source)
  if not identifier then
    return false
  end

  local hasKey = CheckHasKey(identifier, identifier, houseName, source)
  if not hasKey then
    return false
  end

  if houseConfig.mlo then
    return true
  end

  return true
end

RegisterNetEvent("housing:server:houseMusicPlay", function(houseName, url, volume)
  local src = source

  if type(houseName) ~= "string" then return end
  if type(url) ~= "string" or "" == url or #url > 2048 then return end

  if not canAccessMusic(src, houseName) then
    return
  end

  local coords = getHouseInteriorCoords(houseName)
  if not coords then
    return
  end

  local provider = detectSoundProvider()
  if not provider then
    return
  end

  local soundId = getSoundId(houseName)
  local normalizedVolume = normalizeVolume(volume)

  HousingHouseMusicDestroyHouse(houseName)

  if "xsound" == provider then
    local success = pcall(function()
      exports.xsound:PlayUrlPos(-1, soundId, url, normalizedVolume, coords, true)
      exports.xsound:Distance(-1, soundId, MAX_DISTANCE)
    end)
    if not success then
      return
    end

    HousingHouseMusic[houseName] = {
      provider = "xsound",
      soundId = soundId,
    }
    return
  end

  -- mx-surround or qs-3dsound
  local playResult = exports[provider]:Play(-1, soundId, url, coords, true, normalizedVolume)
  if not playResult then
    return
  end

  pcall(function()
    exports[provider]:setVolumeMax(-1, soundId, normalizedVolume)
    exports[provider]:setMaxDistance(-1, soundId, MAX_DISTANCE)
  end)

  HousingHouseMusic[houseName] = {
    provider = provider,
    soundId = soundId,
  }
end)

RegisterNetEvent("housing:server:houseMusicVolume", function(houseName, volume)
  local src = source

  if type(houseName) ~= "string" then
    return
  end

  if not canAccessMusic(src, houseName) then
    return
  end

  local musicData = HousingHouseMusic[houseName]
  if not musicData then
    return
  end

  local normalizedVolume = normalizeVolume(volume)
  local provider = musicData.provider

  if "xsound" == provider then
    pcall(function()
      exports.xsound:setVolume(-1, musicData.soundId, normalizedVolume)
    end)
  else
    pcall(function()
      exports[musicData.provider]:setVolumeMax(-1, musicData.soundId, normalizedVolume)
    end)
  end
end)

RegisterNetEvent("housing:server:houseMusicStop", function(houseName)
  local src = source

  if type(houseName) ~= "string" then
    return
  end

  if not canAccessMusic(src, houseName) then
    return
  end

  HousingHouseMusicDestroyHouse(houseName)
end)

AddEventHandler("housing:setInside", function(houseName, isInside)
  if type(houseName) ~= "string" or "" == houseName then
    return
  end

  local src = source

  if isInside then
    if not playersInHouse[houseName] then
      playersInHouse[houseName] = {}
    end
    playersInHouse[houseName][src] = true
    return
  end

  local housePlayers = playersInHouse[houseName]
  local wasInside = false
  if housePlayers then
    wasInside = true == housePlayers[src]
  end

  if housePlayers then
    housePlayers[src] = nil
    if not next(housePlayers) then
      playersInHouse[houseName] = nil
    end
  end

  if wasInside then
    local remaining = playersInHouse[houseName]
    if not remaining or not next(remaining) then
      if HousingHouseMusic[houseName] then
        HousingHouseMusicDestroyHouse(houseName)
      end
    end
  end
end)

AddEventHandler("playerDropped", function()
  local src = source

  for houseName, housePlayers in pairs(playersInHouse) do
    if housePlayers[src] then
      housePlayers[src] = nil
      if not next(housePlayers) then
        playersInHouse[houseName] = nil
        if HousingHouseMusic[houseName] then
          HousingHouseMusicDestroyHouse(houseName)
        end
      end
    end
  end
end)
