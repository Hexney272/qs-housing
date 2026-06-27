_G.assistant = {}

local voiceConfig = Config.VoiceAssistant
if not voiceConfig then
  voiceConfig = {}
end

local pttActive = false
local lastCommandTime = 0
local lastWelcomedHouse = nil

local cancelWaitKeyName = string.upper(voiceConfig.cancelWaitKey or "BACK")

local awaitState = {
  active = false,
  context = nil,
  choices = nil,
  prompt = nil,
}

local function notify(message, notifType)
  Notification(message, notifType or "info")
end

local function isTTSEnabled()
  local ttsConfig = voiceConfig.tts or {}
  return voiceConfig.enabled and ttsConfig.enabled
end

local function speak(text)
  Debug("speak", "text", text)
  if not isTTSEnabled() then
    return
  end
  if type(text) ~= "string" then
    return
  end
  local trimmed = text:match("^%s*(.-)%s*$") or ""
  if trimmed == "" then
    return
  end
  SendReactMessage("assistant:speak", { text = trimmed })
end

local function notifyAndSpeak(message, notifType, speakText)
  notify(message, notifType)
  speak(speakText or message)
end

local function getAssistantName()
  return voiceConfig.assistantName or "assistant"
end

local function isZoneMessagesEnabled(houseId)
  if not houseId then
    return false
  end
  local houseConfig = Config.Houses and Config.Houses[houseId]
  if not houseConfig then
    return true
  end
  return false ~= houseConfig.assistantZoneMessagesEnabled
end

local function hasHouseKey(houseId)
  if not houseId then
    return false
  end
  if CurrentHouse ~= houseId then
    return false
  end
  if CurrentHouseData then
    return true == CurrentHouseData.haskey
  end
  return CurrentHouseData
end

local function isFemaleModel()
  local model = GetEntityModel(cache.ped)
  return model == joaat("mp_f_freemode_01")
end

local function getWelcomeMessage()
  if isFemaleModel() then
    return i18n.t("assistant_zone_welcome_female")
  end
  return i18n.t("assistant_zone_welcome_male")
end

local function getGoodbyeMessage()
  if isFemaleModel() then
    return i18n.t("assistant_zone_goodbye_female")
  end
  return i18n.t("assistant_zone_goodbye_male")
end

local function onEnterZone(houseId)
  if not voiceConfig.enabled then
    return
  end
  if not houseId then
    return
  end
  if not hasHouseKey(houseId) then
    return
  end
  if not isZoneMessagesEnabled(houseId) then
    return
  end
  if lastWelcomedHouse == houseId then
    return
  end
  notifyAndSpeak(getWelcomeMessage(), "info")
  lastWelcomedHouse = houseId
end

local function hasAssistantUpgrade()
  local houseConfig = Config.Houses[CurrentHouse]
  return table.includes(houseConfig.upgrades, "assistant")
end

local function startAwaitResponse(context, prompt, choices)
  awaitState.active = true
  awaitState.context = context
  awaitState.choices = choices
  awaitState.prompt = prompt or ""
  SendReactMessage("assistant:awaitResponseStart", {
    prompt = awaitState.prompt,
    cancelKey = cancelWaitKeyName,
    context = awaitState.context,
    choices = awaitState.choices,
  })
end

local function stopAwaitResponse()
  if not awaitState.active then
    return
  end
  awaitState.active = false
  awaitState.context = nil
  awaitState.choices = nil
  awaitState.prompt = nil
  SendReactMessage("assistant:awaitResponseStop", {})
end

local function findDeliveryByTitle(title)
  if not title then
    return nil
  end
  local deliveries = Config.Deliveries or {}
  for i = 1, #deliveries do
    local delivery = deliveries[i]
    if delivery.title == title then
      return delivery
    end
  end
  return nil
end

local function findDancerByTitle(title)
  if not title then
    return nil
  end
  local dancers = Config.Dancers or {}
  for i = 1, #dancers do
    local dancer = dancers[i]
    if dancer.title == title then
      return dancer
    end
  end
  return nil
end

local function getDeliveryTitlesString()
  local deliveries = Config.Deliveries or {}
  if #deliveries == 0 then
    return nil
  end
  local titles = {}
  for i = 1, #deliveries do
    titles[#titles + 1] = tostring(deliveries[i].title or "")
  end
  return table.concat(titles, ", ")
end

local function getDancerTitlesString()
  local dancers = Config.Dancers or {}
  if #dancers == 0 then
    return nil
  end
  local titles = {}
  for i = 1, #dancers do
    titles[#titles + 1] = tostring(dancers[i].title or "")
  end
  return table.concat(titles, ", ")
end

local function extractTitlesFromList(list)
  local titles = {}
  for i = 1, #list do
    local title = tostring(list[i].title or "")
    if title ~= "" then
      titles[#titles + 1] = title
    end
  end
  return titles
end

local function ensureInHouse()
  if not CurrentHouse then
    notifyAndSpeak(i18n.t("assistant.not_in_house"), "error")
    return false
  end
  return true
end

local function ensureAssistantUpgrade()
  if not ensureInHouse() then
    return false
  end
  if hasAssistantUpgrade() then
    return true
  end
  Debug("ensureAssistantUpgrade ::: Missing assistant upgrade")
  return false
end

local function promptDeliveryChoice()
  if not ensureAssistantUpgrade() then
    return
  end
  if not Config.DeliveriesEnabled then
    stopAwaitResponse()
    notifyAndSpeak(i18n.t("assistant.delivery_disabled"), "error")
    return
  end
  local optionsStr = getDeliveryTitlesString()
  if not optionsStr then
    stopAwaitResponse()
    notifyAndSpeak(i18n.t("assistant.delivery_not_found"), "error")
    return
  end
  local promptText = i18n.t("assistant.delivery_prompt", { options = optionsStr })
  startAwaitResponse("delivery", promptText, extractTitlesFromList(Config.Deliveries or {}))
  notifyAndSpeak(promptText, "info", promptText)
end

local function promptDancerChoice()
  if not ensureAssistantUpgrade() then
    return
  end
  if not Config.DancersEnabled then
    stopAwaitResponse()
    notifyAndSpeak(i18n.t("assistant.dancer_disabled"), "error")
    return
  end
  local optionsStr = getDancerTitlesString()
  if not optionsStr then
    stopAwaitResponse()
    notifyAndSpeak(i18n.t("assistant.dancer_not_found"), "error")
    return
  end
  local promptText = i18n.t("assistant.dancer_prompt", { options = optionsStr })
  startAwaitResponse("dancer", promptText, extractTitlesFromList(Config.Dancers or {}))
  notifyAndSpeak(promptText, "info", promptText)
end

local function checkCooldown()
  local cooldown = tonumber(voiceConfig.cooldownMs) or 1500
  local now = GetGameTimer()
  local elapsed = now - lastCommandTime
  if cooldown > elapsed then
    return false
  end
  lastCommandTime = now
  return true
end

local function refreshManagementUI()
  if management and management.visible and management.updateUI then
    management:updateUI(CurrentHouse)
  end
end

local function toggleLights(turnOn)
  if not ensureInHouse() then
    return
  end
  local lightsOn = CurrentHouseData and CurrentHouseData.lightsOn
  if lightsOn == nil then
    lightsOn = lib.callback.await("housing:getLightsStatus", false, CurrentHouse)
  end
  if lightsOn then
    lightsOn = true
  else
    lightsOn = false
  end
  if lightsOn == turnOn then
    local key = turnOn and "assistant.light_already_on" or "assistant.light_already_off"
    notifyAndSpeak(i18n.t(key), "info")
    return
  end
  local result = lib.callback.await("housing:toggleLights", false, CurrentHouse)
  if result == nil then
    notifyAndSpeak(i18n.t("assistant.no_permission"), "error")
    return
  end
  if CurrentHouseData then
    CurrentHouseData.lightsOn = result
  end
  local key = result and "assistant.light_on" or "assistant.light_off"
  notifyAndSpeak(i18n.t(key), "success")
  refreshManagementUI()
end

local function orderDelivery(deliveryTitle)
  if not ensureInHouse() then
    return
  end
  if not Config.DeliveriesEnabled then
    notifyAndSpeak(i18n.t("assistant.delivery_disabled"), "error")
    return
  end
  if not deliveryTitle then
    notifyAndSpeak(i18n.t("assistant.delivery_not_found"), "error")
    return
  end
  local delivery = findDeliveryByTitle(deliveryTitle)
  if not delivery then
    notifyAndSpeak(i18n.t("assistant.delivery_not_found"), "error")
    return
  end
  local success = lib.callback.await("housing:orderDelivery", false, CurrentHouse, delivery.title, delivery.price, delivery.items)
  if not success then
    notifyAndSpeak(i18n.t("no_money", { price = delivery.price }), "error")
    return
  end
  notifyAndSpeak(i18n.t("assistant.delivery_ordered", { title = delivery.title }), "success")
  refreshManagementUI()
end

local function orderDancer(dancerTitle)
  if not ensureInHouse() then
    return
  end
  if not Config.DancersEnabled then
    notifyAndSpeak(i18n.t("assistant.dancer_disabled"), "error")
    return
  end
  if not dancerTitle then
    notifyAndSpeak(i18n.t("assistant.dancer_not_found"), "error")
    return
  end
  local dancer = findDancerByTitle(dancerTitle)
  if not dancer then
    notifyAndSpeak(i18n.t("assistant.dancer_not_found"), "error")
    return
  end
  local success = lib.callback.await("housing:orderDancer", false, CurrentHouse, dancer.title, dancer.price)
  if not success then
    notifyAndSpeak(i18n.t("no_money", { price = dancer.price }), "error")
    return
  end
  notifyAndSpeak(i18n.t("assistant.dancer_ordered", { title = dancer.title }), "success")
  refreshManagementUI()
end

local function openQuickMenu()
  if not ensureInHouse() then
    return
  end
  if management and management.visible and management.close then
    management:close()
    SetNuiFocus(false, false)
    Wait(100)
  end
  if not (quickMenu and quickMenu.open) then
    notifyAndSpeak(i18n.t("assistant.command_not_found", { name = getAssistantName() }), "error")
    return
  end
  quickMenu:open()
  notifyAndSpeak(i18n.t("assistant.quick_menu_opened"), "success")
end

local function toggleDoor()
  if not ensureInHouse() then
    return
  end
  local houseConfig = Config.Houses and Config.Houses[CurrentHouse]
  if houseConfig then
    if not houseConfig.mlo then
      if not (CurrentHouseData and CurrentHouseData.haskey) then
        notifyAndSpeak(i18n.t("not_have_keys"), "error")
        return
      end
    end
  end
  TriggerEvent("qb-houses:client:toggleDoorlock")
  notifyAndSpeak(i18n.t("assistant.door_toggle_requested"), "info")
end

local function openDecorate()
  if not ensureInHouse() then
    return
  end
  if CurrentApartment then
    notifyAndSpeak(i18n.t("creator.polyzone_nearby"), "error")
    return
  end
  if management and management.visible and management.close then
    management:close()
    SetNuiFocus(false, false)
    Wait(100)
  end
  TriggerEvent("housing:decorate:open")
  notifyAndSpeak(i18n.t("assistant.decorate_opened"), "success")
end

local function setLocationMode(location, successKey)
  if not ensureInHouse() then
    return
  end
  if CurrentApartment then
    notifyAndSpeak(i18n.t("creator.polyzone_nearby"), "error")
    return
  end
  if location == "charge" then
    local state = GetResourceState("qs-smartphone")
    if state ~= "started" then
      state = GetResourceState("qs-smartphone-pro")
      if state ~= "started" then
        notifyAndSpeak(i18n.t("management.missing_best_phone"), "error")
        return
      end
    end
  end
  if type(SetLocation) ~= "function" then
    notifyAndSpeak(i18n.t("assistant.command_not_found", { name = getAssistantName() }), "error")
    return
  end
  SetLocation(location)
  notifyAndSpeak(i18n.t(successKey), "success")
end

local function getCleanerRobotsInHouse()
  if not (cleanerRobot and type(cleanerRobot.getAll) == "function") then
    return {}
  end
  local results = {}
  local allRobots = cleanerRobot:getAll() or {}
  for id, robot in pairs(allRobots) do
    if robot and robot.house == CurrentHouse then
      results[#results + 1] = { id = id, state = robot.state }
    end
  end
  return results
end

local function startCleaner()
  if not ensureInHouse() then
    return
  end
  if not (cleanerRobot and type(cleanerRobot.startCleaning) == "function") then
    notifyAndSpeak(i18n.t("assistant.command_not_found", { name = getAssistantName() }), "error")
    return
  end
  if not (CurrentHouseData and CurrentHouseData.haskey) then
    notifyAndSpeak(i18n.t("not_have_keys"), "error")
    return
  end
  local robots = getCleanerRobotsInHouse()
  if #robots == 0 then
    notifyAndSpeak(i18n.t("assistant.cleaner_not_found"), "error")
    return
  end
  local availableId = nil
  local anyCleaning = false
  local anyReturning = false
  for i = 1, #robots do
    local state = robots[i].state
    if state == "docked" or state == "idle" then
      if not availableId then
        availableId = robots[i].id
      end
    elseif state == "cleaning" then
      anyCleaning = true
    elseif state == "returning" then
      anyReturning = true
    end
  end
  if not availableId then
    if anyCleaning then
      notifyAndSpeak(i18n.t("assistant.cleaner_already_cleaning"), "info")
      return
    end
    if anyReturning then
      notifyAndSpeak(i18n.t("assistant.cleaner_already_returning"), "info")
      return
    end
    notifyAndSpeak(i18n.t("assistant.cleaner_not_ready"), "error")
    return
  end
  cleanerRobot:startCleaning(availableId)
  local newState = cleanerRobot:getState(availableId)
  if newState == "cleaning" then
    notifyAndSpeak(i18n.t("assistant.cleaner_started"), "success")
  else
    notifyAndSpeak(i18n.t("assistant.cleaner_start_failed"), "error")
  end
end

local function stopCleaner()
  if not ensureInHouse() then
    return
  end
  if not (cleanerRobot and type(cleanerRobot.stopCleaning) == "function") then
    notifyAndSpeak(i18n.t("assistant.command_not_found", { name = getAssistantName() }), "error")
    return
  end
  if not (CurrentHouseData and CurrentHouseData.haskey) then
    notifyAndSpeak(i18n.t("not_have_keys"), "error")
    return
  end
  local robots = getCleanerRobotsInHouse()
  if #robots == 0 then
    notifyAndSpeak(i18n.t("assistant.cleaner_not_found"), "error")
    return
  end
  local cleaningId = nil
  local anyReturning = false
  local anyStopped = false
  for i = 1, #robots do
    local state = robots[i].state
    if state == "cleaning" and not cleaningId then
      cleaningId = robots[i].id
    elseif state == "returning" then
      anyReturning = true
    elseif state == "docked" or state == "idle" then
      anyStopped = true
    end
  end
  if not cleaningId then
    if anyReturning then
      notifyAndSpeak(i18n.t("assistant.cleaner_already_returning"), "info")
      return
    end
    if anyStopped then
      notifyAndSpeak(i18n.t("assistant.cleaner_already_stopped"), "info")
      return
    end
    notifyAndSpeak(i18n.t("assistant.cleaner_not_ready"), "error")
    return
  end
  cleanerRobot:stopCleaning(cleaningId)
  local newState = cleanerRobot:getState(cleaningId)
  if newState == "returning" then
    notifyAndSpeak(i18n.t("assistant.cleaner_stopped"), "success")
  else
    notifyAndSpeak(i18n.t("assistant.cleaner_stop_failed"), "error")
  end
end

local function handleIntent(intent, entities)
  if not ensureAssistantUpgrade() then
    stopAwaitResponse()
    return true
  end
  if not checkCooldown() then
    return true
  end
  if type(intent) ~= "string" or intent == "" then
    return false
  end
  local params = entities
  if type(entities) ~= "table" or not entities then
    params = {}
  end
  local deliveryTitle = params.deliveryTitle
  local dancerTitle = params.dancerTitle

  if intent == "lightOn" then
    stopAwaitResponse()
    toggleLights(true)
    return true
  elseif intent == "lightOff" then
    stopAwaitResponse()
    toggleLights(false)
    return true
  elseif intent == "orderDelivery" then
    if not deliveryTitle then
      promptDeliveryChoice()
      return true
    end
    stopAwaitResponse()
    orderDelivery(deliveryTitle)
    return true
  elseif intent == "deliveryInquiry" then
    promptDeliveryChoice()
    return true
  elseif intent == "orderDancer" then
    if not dancerTitle then
      promptDancerChoice()
      return true
    end
    stopAwaitResponse()
    orderDancer(dancerTitle)
    return true
  elseif intent == "dancerInquiry" then
    promptDancerChoice()
    return true
  elseif intent == "cleanerStart" then
    stopAwaitResponse()
    startCleaner()
    return true
  elseif intent == "cleanerStop" then
    stopAwaitResponse()
    stopCleaner()
    return true
  elseif intent == "toggleDoor" then
    stopAwaitResponse()
    toggleDoor()
    return true
  elseif intent == "openQuickMenu" then
    stopAwaitResponse()
    openQuickMenu()
    return true
  elseif intent == "openDecorate" then
    stopAwaitResponse()
    openDecorate()
    return true
  elseif intent == "locateWardrobe" then
    stopAwaitResponse()
    setLocationMode("wardrobe", "assistant.wardrobe_location_mode")
    return true
  elseif intent == "locateStorage" then
    stopAwaitResponse()
    setLocationMode("stash", "assistant.storage_location_mode")
    return true
  elseif intent == "locateCharge" then
    stopAwaitResponse()
    setLocationMode("charge", "assistant.charge_location_mode")
    return true
  end

  return false
end

RegisterNUICallback("assistant:intent", function(data, cb)
  if not voiceConfig.enabled then
    cb({ handled = false })
    return
  end
  local intent = data and data.intent or nil
  local entities = data and data.entities or {}
  local handled = handleIntent(intent, entities)
  cb({ handled = handled })
end)

RegisterNUICallback("assistant:error", function(data, cb)
  if not voiceConfig.enabled then
    return cb("ok")
  end
  local errorType = (data and data.type) or "unknown"

  if errorType == "not-supported" then
    notifyAndSpeak(i18n.t("assistant.not_supported"), "error")
  elseif errorType == "not-allowed" then
    notifyAndSpeak(i18n.t("assistant.mic_denied"), "error")
  elseif errorType == "no-speech" then
    cb("ok")
    return
  elseif errorType == "audio-capture" then
    notifyAndSpeak(i18n.t("assistant.audio_capture_failed"), "error")
  elseif errorType == "start-failed" then
    notifyAndSpeak(i18n.t("assistant.not_supported"), "error")
  elseif errorType == "stt-config" then
    notifyAndSpeak(i18n.t("assistant.stt_config_missing"), "error")
  elseif errorType == "stt-timeout" then
    notifyAndSpeak(i18n.t("assistant.stt_timeout"), "error")
  elseif errorType == "stt-network" then
    notifyAndSpeak(i18n.t("assistant.stt_network_error"), "error")
  elseif errorType == "stt-http" then
    notifyAndSpeak(i18n.t("assistant.stt_http_error"), "error")
  elseif errorType == "stt-too-long" then
    notifyAndSpeak(i18n.t("assistant.too_long"), "error")
  elseif errorType == "intent-unhandled" then
    local message
    if type(data) == "table" and type(data.message) == "string" and data.message then
      message = data.message
    else
      message = i18n.t("assistant.ambiguous_command")
    end
    notifyAndSpeak(message, "info", message)
  elseif errorType == "tts-config" then
    notify(i18n.t("assistant.tts_config_missing"), "error")
  elseif errorType == "tts-timeout" then
    notify(i18n.t("assistant.tts_timeout"), "error")
  elseif errorType == "tts-network" then
    notify(i18n.t("assistant.tts_network_error"), "error")
  elseif errorType == "tts-http" then
    notify(i18n.t("assistant.tts_http_error"), "error")
  elseif errorType == "tts-playback" then
    notify(i18n.t("assistant.tts_playback_failed"), "error")
  end

  cb("ok")
end)

local pushToTalkControl = Keys[voiceConfig.pushToTalkKey]
local cancelWaitControl = Keys[voiceConfig.cancelWaitKey]
local tickRunning = false

assistant.tick = function()
  if tickRunning then
    return
  end
  tickRunning = true

  if not voiceConfig.enabled then
    return
  end

  CreateThread(function()
    while true do
      if not CurrentHouse then
        break
      end
      Wait(0)

      if IsPauseMenuActive() or IsNuiFocused() then
        if pttActive then
          pttActive = false
          SendReactMessage("assistant:pttStop", {})
        end
      else
        if IsControlJustPressed(0, pushToTalkControl) then
          if not pttActive then
            if not ensureAssistantUpgrade() then
              -- do nothing
            else
              pttActive = true
              local language = tostring(voiceConfig.language or Config.Locale or "en-US")
              SendReactMessage("assistant:pttStart", {
                assistantName = getAssistantName(),
                language = language,
              })
            end
          end
        end

        if IsControlJustReleased(0, pushToTalkControl) then
          if pttActive then
            pttActive = false
            SendReactMessage("assistant:pttStop", {})
          end
        end

        if awaitState.active and cancelWaitControl then
          if IsControlJustPressed(0, cancelWaitControl) then
            stopAwaitResponse()
          end
        end
      end
    end
    tickRunning = false
  end)
end

AddEventHandler("housing:onEnterHouse", function()
  assistant.tick()
end)

AddEventHandler("housing:handleEnterZone", function(houseId)
  onEnterZone(houseId)
end)

AddEventHandler("housing:handleExitZone", function(houseId)
  if not houseId then
    lastWelcomedHouse = nil
    return
  end
  if lastWelcomedHouse == houseId then
    if voiceConfig.enabled then
      if isZoneMessagesEnabled(houseId) then
        notifyAndSpeak(getGoodbyeMessage(), "info")
      end
    end
    lastWelcomedHouse = nil
  end
end)

AddEventHandler("onResourceStop", function(resourceName)
  if resourceName ~= GetCurrentResourceName() then
    return
  end
  stopAwaitResponse()
  lastWelcomedHouse = nil
  if pttActive then
    SendReactMessage("assistant:pttStop", {})
  end
end)
