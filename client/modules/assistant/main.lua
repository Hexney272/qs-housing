





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1
L0_1 = _G
L1_1 = {}
L0_1.assistant = L1_1
L0_1 = Config
L0_1 = L0_1.VoiceAssistant
if not L0_1 then
  L0_1 = {}
end
L1_1 = false
L2_1 = 0
L3_1 = nil
L4_1 = string
L4_1 = L4_1.upper
L5_1 = L0_1.cancelWaitKey
if not L5_1 then
  L5_1 = "BACK"
end
L4_1 = L4_1(L5_1)
L5_1 = {}
L5_1.active = false
L5_1.context = nil
L5_1.choices = nil
L5_1.prompt = nil
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = Notification
  L3_2 = A0_2
  L4_2 = A1_2 or L4_2
  if not A1_2 then
    L4_2 = "info"
  end
  L2_2(L3_2, L4_2)
end
function L7_1()
  local L0_2, L1_2
  L0_2 = L0_1.tts
  if not L0_2 then
    L0_2 = {}
  end
  L1_2 = L0_1.enabled
  if L1_2 then
    L1_2 = L0_2.enabled
  end
  return L1_2
end
function L8_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = Debug
  L2_2 = "speak"
  L3_2 = "text"
  L4_2 = A0_2
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = L7_1
  L1_2 = L1_2()
  if not L1_2 then
    return
  end
  L1_2 = type
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if "string" ~= L1_2 then
    return
  end
  L2_2 = A0_2
  L1_2 = A0_2.match
  L3_2 = "^%s*(.-)%s*$"
  L1_2 = L1_2(L2_2, L3_2)
  if not L1_2 then
    L1_2 = ""
  end
  if "" == L1_2 then
    return
  end
  L2_2 = SendReactMessage
  L3_2 = "assistant:speak"
  L4_2 = {}
  L4_2.text = L1_2
  L2_2(L3_2, L4_2)
end
function L9_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = L6_1
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2(L4_2, L5_2)
  L3_2 = L8_1
  L4_2 = A2_2 or L4_2
  if not A2_2 then
    L4_2 = A0_2
  end
  L3_2(L4_2)
end
function L10_1()
  local L0_2, L1_2
  L0_2 = L0_1.assistantName
  if not L0_2 then
    L0_2 = "assistant"
  end
  return L0_2
end
function L11_1(A0_2)
  local L1_2, L2_2
  if not A0_2 then
    L1_2 = false
    return L1_2
  end
  L1_2 = Config
  L1_2 = L1_2.Houses
  if L1_2 then
    L1_2 = Config
    L1_2 = L1_2.Houses
    L1_2 = L1_2[A0_2]
  end
  if not L1_2 then
    L2_2 = true
    return L2_2
  end
  L2_2 = L1_2.assistantZoneMessagesEnabled
  L2_2 = false ~= L2_2
  return L2_2
end
function L12_1(A0_2)
  local L1_2
  if not A0_2 then
    L1_2 = false
    return L1_2
  end
  L1_2 = CurrentHouse
  if L1_2 ~= A0_2 then
    L1_2 = false
    return L1_2
  end
  L1_2 = CurrentHouseData
  if L1_2 then
    L1_2 = CurrentHouseData
    L1_2 = L1_2.haskey
    L1_2 = true == L1_2
  end
  return L1_2
end
function L13_1()
  local L0_2, L1_2, L2_2
  L0_2 = GetEntityModel
  L1_2 = cache
  L1_2 = L1_2.ped
  L0_2 = L0_2(L1_2)
  L1_2 = joaat
  L2_2 = "mp_f_freemode_01"
  L1_2 = L1_2(L2_2)
  L1_2 = L0_2 == L1_2
  return L1_2
end
function L14_1()
  local L0_2, L1_2
  L0_2 = L13_1
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = i18n
    L0_2 = L0_2.t
    L1_2 = "assistant_zone_welcome_female"
    return L0_2(L1_2)
  end
  L0_2 = i18n
  L0_2 = L0_2.t
  L1_2 = "assistant_zone_welcome_male"
  return L0_2(L1_2)
end
function L15_1()
  local L0_2, L1_2
  L0_2 = L13_1
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = i18n
    L0_2 = L0_2.t
    L1_2 = "assistant_zone_goodbye_female"
    return L0_2(L1_2)
  end
  L0_2 = i18n
  L0_2 = L0_2.t
  L1_2 = "assistant_zone_goodbye_male"
  return L0_2(L1_2)
end
function L16_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = L0_1.enabled
  if not L1_2 then
    return
  end
  if not A0_2 then
    return
  end
  L1_2 = L12_1
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    return
  end
  L1_2 = L11_1
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    return
  end
  L1_2 = L3_1
  if L1_2 == A0_2 then
    return
  end
  L1_2 = L9_1
  L2_2 = L14_1
  L2_2 = L2_2()
  L3_2 = "info"
  L1_2(L2_2, L3_2)
  L3_1 = A0_2
end
function L17_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Config
  L0_2 = L0_2.Houses
  L1_2 = CurrentHouse
  L0_2 = L0_2[L1_2]
  L0_2 = L0_2.upgrades
  L1_2 = table
  L1_2 = L1_2.includes
  L2_2 = L0_2
  L3_2 = "assistant"
  return L1_2(L2_2, L3_2)
end
function L18_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L5_1.active = true
  L5_1.context = A0_2
  L5_1.choices = A2_2
  L3_2 = A1_2 or L3_2
  if not A1_2 then
    L3_2 = ""
  end
  L5_1.prompt = L3_2
  L3_2 = SendReactMessage
  L4_2 = "assistant:awaitResponseStart"
  L5_2 = {}
  L6_2 = L5_1.prompt
  L5_2.prompt = L6_2
  L6_2 = L4_1
  L5_2.cancelKey = L6_2
  L6_2 = L5_1.context
  L5_2.context = L6_2
  L6_2 = L5_1.choices
  L5_2.choices = L6_2
  L3_2(L4_2, L5_2)
end
function L19_1()
  local L0_2, L1_2, L2_2
  L0_2 = L5_1.active
  if not L0_2 then
    return
  end
  L5_1.active = false
  L5_1.context = nil
  L5_1.choices = nil
  L5_1.prompt = nil
  L0_2 = SendReactMessage
  L1_2 = "assistant:awaitResponseStop"
  L2_2 = {}
  L0_2(L1_2, L2_2)
end
function L20_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  if not A0_2 then
    L1_2 = nil
    return L1_2
  end
  L1_2 = 1
  L2_2 = Config
  L2_2 = L2_2.Deliveries
  if not L2_2 then
    L2_2 = {}
  end
  L2_2 = #L2_2
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = Config
    L5_2 = L5_2.Deliveries
    L5_2 = L5_2[L4_2]
    L6_2 = L5_2.title
    if L6_2 == A0_2 then
      return L5_2
    end
  end
  L1_2 = nil
  return L1_2
end
function L21_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  if not A0_2 then
    L1_2 = nil
    return L1_2
  end
  L1_2 = 1
  L2_2 = Config
  L2_2 = L2_2.Dancers
  if not L2_2 then
    L2_2 = {}
  end
  L2_2 = #L2_2
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = Config
    L5_2 = L5_2.Dancers
    L5_2 = L5_2[L4_2]
    L6_2 = L5_2.title
    if L6_2 == A0_2 then
      return L5_2
    end
  end
  L1_2 = nil
  return L1_2
end
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = Config
  L0_2 = L0_2.Deliveries
  if not L0_2 then
    L0_2 = {}
  end
  L1_2 = #L0_2
  if 0 == L1_2 then
    L1_2 = nil
    return L1_2
  end
  L1_2 = {}
  L2_2 = 1
  L3_2 = #L0_2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = #L1_2
    L6_2 = L6_2 + 1
    L7_2 = tostring
    L8_2 = L0_2[L5_2]
    L8_2 = L8_2.title
    if not L8_2 then
      L8_2 = ""
    end
    L7_2 = L7_2(L8_2)
    L1_2[L6_2] = L7_2
  end
  L2_2 = table
  L2_2 = L2_2.concat
  L3_2 = L1_2
  L4_2 = ", "
  return L2_2(L3_2, L4_2)
end
function L23_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = Config
  L0_2 = L0_2.Dancers
  if not L0_2 then
    L0_2 = {}
  end
  L1_2 = #L0_2
  if 0 == L1_2 then
    L1_2 = nil
    return L1_2
  end
  L1_2 = {}
  L2_2 = 1
  L3_2 = #L0_2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = #L1_2
    L6_2 = L6_2 + 1
    L7_2 = tostring
    L8_2 = L0_2[L5_2]
    L8_2 = L8_2.title
    if not L8_2 then
      L8_2 = ""
    end
    L7_2 = L7_2(L8_2)
    L1_2[L6_2] = L7_2
  end
  L2_2 = table
  L2_2 = L2_2.concat
  L3_2 = L1_2
  L4_2 = ", "
  return L2_2(L3_2, L4_2)
end
function L24_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = {}
  L2_2 = 1
  L3_2 = #A0_2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = tostring
    L7_2 = A0_2[L5_2]
    L7_2 = L7_2.title
    if not L7_2 then
      L7_2 = ""
    end
    L6_2 = L6_2(L7_2)
    if "" ~= L6_2 then
      L7_2 = #L1_2
      L7_2 = L7_2 + 1
      L1_2[L7_2] = L6_2
    end
  end
  return L1_2
end
function L25_1()
  local L0_2, L1_2, L2_2
  L0_2 = CurrentHouse
  if not L0_2 then
    L0_2 = L9_1
    L1_2 = i18n
    L1_2 = L1_2.t
    L2_2 = "assistant.not_in_house"
    L1_2 = L1_2(L2_2)
    L2_2 = "error"
    L0_2(L1_2, L2_2)
    L0_2 = false
    return L0_2
  end
  L0_2 = true
  return L0_2
end
function L26_1()
  local L0_2, L1_2
  L0_2 = L25_1
  L0_2 = L0_2()
  if not L0_2 then
    L0_2 = false
    return L0_2
  end
  L0_2 = L17_1
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = true
    return L0_2
  end
  L0_2 = Debug
  L1_2 = "ensureAssistantUpgrade ::: Missing assistant upgrade"
  L0_2(L1_2)
  L0_2 = false
  return L0_2
end
function L27_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = L26_1
  L0_2 = L0_2()
  if not L0_2 then
    return
  end
  L0_2 = Config
  L0_2 = L0_2.DeliveriesEnabled
  if not L0_2 then
    L0_2 = L19_1
    L0_2()
    L0_2 = L9_1
    L1_2 = i18n
    L1_2 = L1_2.t
    L2_2 = "assistant.delivery_disabled"
    L1_2 = L1_2(L2_2)
    L2_2 = "error"
    L0_2(L1_2, L2_2)
    return
  end
  L0_2 = L22_1
  L0_2 = L0_2()
  if not L0_2 then
    L1_2 = L19_1
    L1_2()
    L1_2 = L9_1
    L2_2 = i18n
    L2_2 = L2_2.t
    L3_2 = "assistant.delivery_not_found"
    L2_2 = L2_2(L3_2)
    L3_2 = "error"
    L1_2(L2_2, L3_2)
    return
  end
  L1_2 = i18n
  L1_2 = L1_2.t
  L2_2 = "assistant.delivery_prompt"
  L3_2 = {}
  L3_2.options = L0_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = L18_1
  L3_2 = "delivery"
  L4_2 = L1_2
  L5_2 = L24_1
  L6_2 = Config
  L6_2 = L6_2.Deliveries
  if not L6_2 then
    L6_2 = {}
  end
  L5_2, L6_2 = L5_2(L6_2)
  L2_2(L3_2, L4_2, L5_2, L6_2)
  L2_2 = L9_1
  L3_2 = L1_2
  L4_2 = "info"
  L5_2 = L1_2
  L2_2(L3_2, L4_2, L5_2)
end
function L28_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = L26_1
  L0_2 = L0_2()
  if not L0_2 then
    return
  end
  L0_2 = Config
  L0_2 = L0_2.DancersEnabled
  if not L0_2 then
    L0_2 = L19_1
    L0_2()
    L0_2 = L9_1
    L1_2 = i18n
    L1_2 = L1_2.t
    L2_2 = "assistant.dancer_disabled"
    L1_2 = L1_2(L2_2)
    L2_2 = "error"
    L0_2(L1_2, L2_2)
    return
  end
  L0_2 = L23_1
  L0_2 = L0_2()
  if not L0_2 then
    L1_2 = L19_1
    L1_2()
    L1_2 = L9_1
    L2_2 = i18n
    L2_2 = L2_2.t
    L3_2 = "assistant.dancer_not_found"
    L2_2 = L2_2(L3_2)
    L3_2 = "error"
    L1_2(L2_2, L3_2)
    return
  end
  L1_2 = i18n
  L1_2 = L1_2.t
  L2_2 = "assistant.dancer_prompt"
  L3_2 = {}
  L3_2.options = L0_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = L18_1
  L3_2 = "dancer"
  L4_2 = L1_2
  L5_2 = L24_1
  L6_2 = Config
  L6_2 = L6_2.Dancers
  if not L6_2 then
    L6_2 = {}
  end
  L5_2, L6_2 = L5_2(L6_2)
  L2_2(L3_2, L4_2, L5_2, L6_2)
  L2_2 = L9_1
  L3_2 = L1_2
  L4_2 = "info"
  L5_2 = L1_2
  L2_2(L3_2, L4_2, L5_2)
end
function L29_1()
  local L0_2, L1_2, L2_2
  L0_2 = tonumber
  L1_2 = L0_1.cooldownMs
  L0_2 = L0_2(L1_2)
  if not L0_2 then
    L0_2 = 1500
  end
  L1_2 = GetGameTimer
  L1_2 = L1_2()
  L2_2 = L2_1
  L2_2 = L1_2 - L2_2
  if L0_2 > L2_2 then
    L2_2 = false
    return L2_2
  end
  L2_1 = L1_2
  L2_2 = true
  return L2_2
end
function L30_1()
  local L0_2, L1_2, L2_2
  L0_2 = management
  if L0_2 then
    L0_2 = management
    L0_2 = L0_2.visible
    if L0_2 then
      L0_2 = management
      L0_2 = L0_2.updateUI
      if L0_2 then
        L0_2 = management
        L1_2 = L0_2
        L0_2 = L0_2.updateUI
        L2_2 = CurrentHouse
        L0_2(L1_2, L2_2)
      end
    end
  end
end
function L31_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = L25_1
  L1_2 = L1_2()
  if not L1_2 then
    return
  end
  L1_2 = CurrentHouseData
  if L1_2 then
    L1_2 = CurrentHouseData
    L1_2 = L1_2.lightsOn
  end
  if nil == L1_2 then
    L2_2 = lib
    L2_2 = L2_2.callback
    L2_2 = L2_2.await
    L3_2 = "housing:getLightsStatus"
    L4_2 = false
    L5_2 = CurrentHouse
    L2_2 = L2_2(L3_2, L4_2, L5_2)
    L1_2 = L2_2
  end
  if L1_2 then
    L2_2 = true
    if L2_2 then
      goto lbl_27
      L1_2 = L2_2 or L1_2
    end
  end
  L1_2 = false
  ::lbl_27::
  if L1_2 == A0_2 then
    L2_2 = L9_1
    L3_2 = i18n
    L3_2 = L3_2.t
    if A0_2 then
      L4_2 = "assistant.light_already_on"
      if L4_2 then
        goto lbl_38
      end
    end
    L4_2 = "assistant.light_already_off"
    ::lbl_38::
    L3_2 = L3_2(L4_2)
    L4_2 = "info"
    L2_2(L3_2, L4_2)
    return
  end
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:toggleLights"
  L4_2 = false
  L5_2 = CurrentHouse
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  if nil == L2_2 then
    L3_2 = L9_1
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "assistant.no_permission"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
    return
  end
  L3_2 = CurrentHouseData
  if L3_2 then
    L3_2 = CurrentHouseData
    L3_2.lightsOn = L2_2
  end
  L3_2 = L9_1
  L4_2 = i18n
  L4_2 = L4_2.t
  if L2_2 then
    L5_2 = "assistant.light_on"
    if L5_2 then
      goto lbl_73
    end
  end
  L5_2 = "assistant.light_off"
  ::lbl_73::
  L4_2 = L4_2(L5_2)
  L5_2 = "success"
  L3_2(L4_2, L5_2)
  L3_2 = L30_1
  L3_2()
end
function L32_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = L25_1
  L1_2 = L1_2()
  if not L1_2 then
    return
  end
  L1_2 = Config
  L1_2 = L1_2.DeliveriesEnabled
  if not L1_2 then
    L1_2 = L9_1
    L2_2 = i18n
    L2_2 = L2_2.t
    L3_2 = "assistant.delivery_disabled"
    L2_2 = L2_2(L3_2)
    L3_2 = "error"
    L1_2(L2_2, L3_2)
    return
  end
  if not A0_2 then
    L1_2 = L9_1
    L2_2 = i18n
    L2_2 = L2_2.t
    L3_2 = "assistant.delivery_not_found"
    L2_2 = L2_2(L3_2)
    L3_2 = "error"
    L1_2(L2_2, L3_2)
    return
  end
  L1_2 = L20_1
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L2_2 = L9_1
    L3_2 = i18n
    L3_2 = L3_2.t
    L4_2 = "assistant.delivery_not_found"
    L3_2 = L3_2(L4_2)
    L4_2 = "error"
    L2_2(L3_2, L4_2)
    return
  end
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:orderDelivery"
  L4_2 = false
  L5_2 = CurrentHouse
  L6_2 = L1_2.title
  L7_2 = L1_2.price
  L8_2 = L1_2.items
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  if not L2_2 then
    L3_2 = L9_1
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "no_money"
    L6_2 = {}
    L7_2 = L1_2.price
    L6_2.price = L7_2
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
    return
  end
  L3_2 = L9_1
  L4_2 = i18n
  L4_2 = L4_2.t
  L5_2 = "assistant.delivery_ordered"
  L6_2 = {}
  L7_2 = L1_2.title
  L6_2.title = L7_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = "success"
  L3_2(L4_2, L5_2)
  L3_2 = L30_1
  L3_2()
end
function L33_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = L25_1
  L1_2 = L1_2()
  if not L1_2 then
    return
  end
  L1_2 = Config
  L1_2 = L1_2.DancersEnabled
  if not L1_2 then
    L1_2 = L9_1
    L2_2 = i18n
    L2_2 = L2_2.t
    L3_2 = "assistant.dancer_disabled"
    L2_2 = L2_2(L3_2)
    L3_2 = "error"
    L1_2(L2_2, L3_2)
    return
  end
  if not A0_2 then
    L1_2 = L9_1
    L2_2 = i18n
    L2_2 = L2_2.t
    L3_2 = "assistant.dancer_not_found"
    L2_2 = L2_2(L3_2)
    L3_2 = "error"
    L1_2(L2_2, L3_2)
    return
  end
  L1_2 = L21_1
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L2_2 = L9_1
    L3_2 = i18n
    L3_2 = L3_2.t
    L4_2 = "assistant.dancer_not_found"
    L3_2 = L3_2(L4_2)
    L4_2 = "error"
    L2_2(L3_2, L4_2)
    return
  end
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "housing:orderDancer"
  L4_2 = false
  L5_2 = CurrentHouse
  L6_2 = L1_2.title
  L7_2 = L1_2.price
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  if not L2_2 then
    L3_2 = L9_1
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "no_money"
    L6_2 = {}
    L7_2 = L1_2.price
    L6_2.price = L7_2
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
    return
  end
  L3_2 = L9_1
  L4_2 = i18n
  L4_2 = L4_2.t
  L5_2 = "assistant.dancer_ordered"
  L6_2 = {}
  L7_2 = L1_2.title
  L6_2.title = L7_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = "success"
  L3_2(L4_2, L5_2)
  L3_2 = L30_1
  L3_2()
end
function L34_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = L25_1
  L0_2 = L0_2()
  if not L0_2 then
    return
  end
  L0_2 = management
  if L0_2 then
    L0_2 = management
    L0_2 = L0_2.visible
    if L0_2 then
      L0_2 = management
      L0_2 = L0_2.close
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
  end
  L0_2 = quickMenu
  if L0_2 then
    L0_2 = quickMenu
    L0_2 = L0_2.open
    if L0_2 then
      goto lbl_47
    end
  end
  L0_2 = L9_1
  L1_2 = i18n
  L1_2 = L1_2.t
  L2_2 = "assistant.command_not_found"
  L3_2 = {}
  L4_2 = L10_1
  L4_2 = L4_2()
  L3_2.name = L4_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = "error"
  L0_2(L1_2, L2_2)
  do return end
  ::lbl_47::
  L0_2 = quickMenu
  L1_2 = L0_2
  L0_2 = L0_2.open
  L0_2(L1_2)
  L0_2 = L9_1
  L1_2 = i18n
  L1_2 = L1_2.t
  L2_2 = "assistant.quick_menu_opened"
  L1_2 = L1_2(L2_2)
  L2_2 = "success"
  L0_2(L1_2, L2_2)
end
function L35_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = L25_1
  L0_2 = L0_2()
  if not L0_2 then
    return
  end
  L0_2 = Config
  L0_2 = L0_2.Houses
  if L0_2 then
    L0_2 = Config
    L0_2 = L0_2.Houses
    L1_2 = CurrentHouse
    L0_2 = L0_2[L1_2]
  end
  if L0_2 then
    L1_2 = L0_2.mlo
    if not L1_2 then
      L1_2 = CurrentHouseData
      if L1_2 then
        L1_2 = CurrentHouseData
        L1_2 = L1_2.haskey
        if L1_2 then
          goto lbl_34
        end
      end
      L1_2 = L9_1
      L2_2 = i18n
      L2_2 = L2_2.t
      L3_2 = "not_have_keys"
      L2_2 = L2_2(L3_2)
      L3_2 = "error"
      L1_2(L2_2, L3_2)
      return
    end
  end
  ::lbl_34::
  L1_2 = TriggerEvent
  L2_2 = "qb-houses:client:toggleDoorlock"
  L1_2(L2_2)
  L1_2 = L9_1
  L2_2 = i18n
  L2_2 = L2_2.t
  L3_2 = "assistant.door_toggle_requested"
  L2_2 = L2_2(L3_2)
  L3_2 = "info"
  L1_2(L2_2, L3_2)
end
function L36_1()
  local L0_2, L1_2, L2_2
  L0_2 = L25_1
  L0_2 = L0_2()
  if not L0_2 then
    return
  end
  L0_2 = CurrentApartment
  if L0_2 then
    L0_2 = L9_1
    L1_2 = i18n
    L1_2 = L1_2.t
    L2_2 = "creator.polyzone_nearby"
    L1_2 = L1_2(L2_2)
    L2_2 = "error"
    L0_2(L1_2, L2_2)
    return
  end
  L0_2 = management
  if L0_2 then
    L0_2 = management
    L0_2 = L0_2.visible
    if L0_2 then
      L0_2 = management
      L0_2 = L0_2.close
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
  end
  L0_2 = TriggerEvent
  L1_2 = "housing:decorate:open"
  L0_2(L1_2)
  L0_2 = L9_1
  L1_2 = i18n
  L1_2 = L1_2.t
  L2_2 = "assistant.decorate_opened"
  L1_2 = L1_2(L2_2)
  L2_2 = "success"
  L0_2(L1_2, L2_2)
end
function L37_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = L25_1
  L2_2 = L2_2()
  if not L2_2 then
    return
  end
  L2_2 = CurrentApartment
  if L2_2 then
    L2_2 = L9_1
    L3_2 = i18n
    L3_2 = L3_2.t
    L4_2 = "creator.polyzone_nearby"
    L3_2 = L3_2(L4_2)
    L4_2 = "error"
    L2_2(L3_2, L4_2)
    return
  end
  if "charge" == A0_2 then
    L2_2 = GetResourceState
    L3_2 = "qs-smartphone"
    L2_2 = L2_2(L3_2)
    if "started" ~= L2_2 then
      L2_2 = GetResourceState
      L3_2 = "qs-smartphone-pro"
      L2_2 = L2_2(L3_2)
      if "started" ~= L2_2 then
        L2_2 = L9_1
        L3_2 = i18n
        L3_2 = L3_2.t
        L4_2 = "management.missing_best_phone"
        L3_2 = L3_2(L4_2)
        L4_2 = "error"
        L2_2(L3_2, L4_2)
        return
      end
    end
  end
  L2_2 = type
  L3_2 = SetLocation
  L2_2 = L2_2(L3_2)
  if "function" ~= L2_2 then
    L2_2 = L9_1
    L3_2 = i18n
    L3_2 = L3_2.t
    L4_2 = "assistant.command_not_found"
    L5_2 = {}
    L6_2 = L10_1
    L6_2 = L6_2()
    L5_2.name = L6_2
    L3_2 = L3_2(L4_2, L5_2)
    L4_2 = "error"
    L2_2(L3_2, L4_2)
    return
  end
  L2_2 = SetLocation
  L3_2 = A0_2
  L2_2(L3_2)
  L2_2 = L9_1
  L3_2 = i18n
  L3_2 = L3_2.t
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  L4_2 = "success"
  L2_2(L3_2, L4_2)
end
function L38_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = cleanerRobot
  if L0_2 then
    L0_2 = type
    L1_2 = cleanerRobot
    L1_2 = L1_2.getAll
    L0_2 = L0_2(L1_2)
    if "function" == L0_2 then
      goto lbl_13
    end
  end
  L0_2 = {}
  do return L0_2 end
  ::lbl_13::
  L0_2 = {}
  L1_2 = cleanerRobot
  L2_2 = L1_2
  L1_2 = L1_2.getAll
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = {}
  end
  L2_2 = pairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    if L7_2 then
      L8_2 = L7_2.house
      L9_2 = CurrentHouse
      if L8_2 == L9_2 then
        L8_2 = #L0_2
        L8_2 = L8_2 + 1
        L9_2 = {}
        L9_2.id = L6_2
        L10_2 = L7_2.state
        L9_2.state = L10_2
        L0_2[L8_2] = L9_2
      end
    end
  end
  return L0_2
end
function L39_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = L25_1
  L0_2 = L0_2()
  if not L0_2 then
    return
  end
  L0_2 = cleanerRobot
  if L0_2 then
    L0_2 = type
    L1_2 = cleanerRobot
    L1_2 = L1_2.startCleaning
    L0_2 = L0_2(L1_2)
    if "function" == L0_2 then
      goto lbl_28
    end
  end
  L0_2 = L9_1
  L1_2 = i18n
  L1_2 = L1_2.t
  L2_2 = "assistant.command_not_found"
  L3_2 = {}
  L4_2 = L10_1
  L4_2 = L4_2()
  L3_2.name = L4_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = "error"
  L0_2(L1_2, L2_2)
  do return end
  ::lbl_28::
  L0_2 = CurrentHouseData
  if L0_2 then
    L0_2 = CurrentHouseData
    L0_2 = L0_2.haskey
    if L0_2 then
      goto lbl_43
    end
  end
  L0_2 = L9_1
  L1_2 = i18n
  L1_2 = L1_2.t
  L2_2 = "not_have_keys"
  L1_2 = L1_2(L2_2)
  L2_2 = "error"
  L0_2(L1_2, L2_2)
  do return end
  ::lbl_43::
  L0_2 = L38_1
  L0_2 = L0_2()
  L1_2 = #L0_2
  if 0 == L1_2 then
    L1_2 = L9_1
    L2_2 = i18n
    L2_2 = L2_2.t
    L3_2 = "assistant.cleaner_not_found"
    L2_2 = L2_2(L3_2)
    L3_2 = "error"
    L1_2(L2_2, L3_2)
    return
  end
  L1_2 = nil
  L2_2 = false
  L3_2 = false
  L4_2 = 1
  L5_2 = #L0_2
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = L0_2[L7_2]
    L8_2 = L8_2.state
    if "docked" == L8_2 or "idle" == L8_2 then
      if not L1_2 then
        L9_2 = L0_2[L7_2]
        L1_2 = L9_2.id
      end
    elseif "cleaning" == L8_2 then
      L2_2 = true
    elseif "returning" == L8_2 then
      L3_2 = true
    end
  end
  if not L1_2 then
    if L2_2 then
      L4_2 = L9_1
      L5_2 = i18n
      L5_2 = L5_2.t
      L6_2 = "assistant.cleaner_already_cleaning"
      L5_2 = L5_2(L6_2)
      L6_2 = "info"
      L4_2(L5_2, L6_2)
      return
    end
    if L3_2 then
      L4_2 = L9_1
      L5_2 = i18n
      L5_2 = L5_2.t
      L6_2 = "assistant.cleaner_already_returning"
      L5_2 = L5_2(L6_2)
      L6_2 = "info"
      L4_2(L5_2, L6_2)
      return
    end
    L4_2 = L9_1
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "assistant.cleaner_not_ready"
    L5_2 = L5_2(L6_2)
    L6_2 = "error"
    L4_2(L5_2, L6_2)
    return
  end
  L4_2 = cleanerRobot
  L5_2 = L4_2
  L4_2 = L4_2.startCleaning
  L6_2 = L1_2
  L4_2(L5_2, L6_2)
  L4_2 = cleanerRobot
  L5_2 = L4_2
  L4_2 = L4_2.getState
  L6_2 = L1_2
  L4_2 = L4_2(L5_2, L6_2)
  if "cleaning" == L4_2 then
    L5_2 = L9_1
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "assistant.cleaner_started"
    L6_2 = L6_2(L7_2)
    L7_2 = "success"
    L5_2(L6_2, L7_2)
  else
    L5_2 = L9_1
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "assistant.cleaner_start_failed"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    L5_2(L6_2, L7_2)
  end
end
function L40_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = L25_1
  L0_2 = L0_2()
  if not L0_2 then
    return
  end
  L0_2 = cleanerRobot
  if L0_2 then
    L0_2 = type
    L1_2 = cleanerRobot
    L1_2 = L1_2.stopCleaning
    L0_2 = L0_2(L1_2)
    if "function" == L0_2 then
      goto lbl_28
    end
  end
  L0_2 = L9_1
  L1_2 = i18n
  L1_2 = L1_2.t
  L2_2 = "assistant.command_not_found"
  L3_2 = {}
  L4_2 = L10_1
  L4_2 = L4_2()
  L3_2.name = L4_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = "error"
  L0_2(L1_2, L2_2)
  do return end
  ::lbl_28::
  L0_2 = CurrentHouseData
  if L0_2 then
    L0_2 = CurrentHouseData
    L0_2 = L0_2.haskey
    if L0_2 then
      goto lbl_43
    end
  end
  L0_2 = L9_1
  L1_2 = i18n
  L1_2 = L1_2.t
  L2_2 = "not_have_keys"
  L1_2 = L1_2(L2_2)
  L2_2 = "error"
  L0_2(L1_2, L2_2)
  do return end
  ::lbl_43::
  L0_2 = L38_1
  L0_2 = L0_2()
  L1_2 = #L0_2
  if 0 == L1_2 then
    L1_2 = L9_1
    L2_2 = i18n
    L2_2 = L2_2.t
    L3_2 = "assistant.cleaner_not_found"
    L2_2 = L2_2(L3_2)
    L3_2 = "error"
    L1_2(L2_2, L3_2)
    return
  end
  L1_2 = nil
  L2_2 = false
  L3_2 = false
  L4_2 = 1
  L5_2 = #L0_2
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = L0_2[L7_2]
    L8_2 = L8_2.state
    if "cleaning" == L8_2 and not L1_2 then
      L9_2 = L0_2[L7_2]
      L1_2 = L9_2.id
    elseif "returning" == L8_2 then
      L2_2 = true
    elseif "docked" == L8_2 or "idle" == L8_2 then
      L3_2 = true
    end
  end
  if not L1_2 then
    if L2_2 then
      L4_2 = L9_1
      L5_2 = i18n
      L5_2 = L5_2.t
      L6_2 = "assistant.cleaner_already_returning"
      L5_2 = L5_2(L6_2)
      L6_2 = "info"
      L4_2(L5_2, L6_2)
      return
    end
    if L3_2 then
      L4_2 = L9_1
      L5_2 = i18n
      L5_2 = L5_2.t
      L6_2 = "assistant.cleaner_already_stopped"
      L5_2 = L5_2(L6_2)
      L6_2 = "info"
      L4_2(L5_2, L6_2)
      return
    end
    L4_2 = L9_1
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "assistant.cleaner_not_ready"
    L5_2 = L5_2(L6_2)
    L6_2 = "error"
    L4_2(L5_2, L6_2)
    return
  end
  L4_2 = cleanerRobot
  L5_2 = L4_2
  L4_2 = L4_2.stopCleaning
  L6_2 = L1_2
  L4_2(L5_2, L6_2)
  L4_2 = cleanerRobot
  L5_2 = L4_2
  L4_2 = L4_2.getState
  L6_2 = L1_2
  L4_2 = L4_2(L5_2, L6_2)
  if "returning" == L4_2 then
    L5_2 = L9_1
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "assistant.cleaner_stopped"
    L6_2 = L6_2(L7_2)
    L7_2 = "success"
    L5_2(L6_2, L7_2)
  else
    L5_2 = L9_1
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "assistant.cleaner_stop_failed"
    L6_2 = L6_2(L7_2)
    L7_2 = "error"
    L5_2(L6_2, L7_2)
  end
end
function L41_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = L26_1
  L2_2 = L2_2()
  if not L2_2 then
    L2_2 = L19_1
    L2_2()
    L2_2 = true
    return L2_2
  end
  L2_2 = L29_1
  L2_2 = L2_2()
  if not L2_2 then
    L2_2 = true
    return L2_2
  end
  L2_2 = type
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if "string" ~= L2_2 or "" == A0_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = type
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  L2_2 = A1_2 or L2_2
  if "table" ~= L2_2 or not A1_2 then
    L2_2 = {}
  end
  L3_2 = L2_2.deliveryTitle
  L4_2 = L2_2.dancerTitle
  if "lightOn" == A0_2 then
    L5_2 = L19_1
    L5_2()
    L5_2 = L31_1
    L6_2 = true
    L5_2(L6_2)
    L5_2 = true
    return L5_2
  elseif "lightOff" == A0_2 then
    L5_2 = L19_1
    L5_2()
    L5_2 = L31_1
    L6_2 = false
    L5_2(L6_2)
    L5_2 = true
    return L5_2
  elseif "orderDelivery" == A0_2 then
    if not L3_2 then
      L5_2 = L27_1
      L5_2()
      L5_2 = true
      return L5_2
    end
    L5_2 = L19_1
    L5_2()
    L5_2 = L32_1
    L6_2 = L3_2
    L5_2(L6_2)
    L5_2 = true
    return L5_2
  elseif "deliveryInquiry" == A0_2 then
    L5_2 = L27_1
    L5_2()
    L5_2 = true
    return L5_2
  elseif "orderDancer" == A0_2 then
    if not L4_2 then
      L5_2 = L28_1
      L5_2()
      L5_2 = true
      return L5_2
    end
    L5_2 = L19_1
    L5_2()
    L5_2 = L33_1
    L6_2 = L4_2
    L5_2(L6_2)
    L5_2 = true
    return L5_2
  elseif "dancerInquiry" == A0_2 then
    L5_2 = L28_1
    L5_2()
    L5_2 = true
    return L5_2
  elseif "cleanerStart" == A0_2 then
    L5_2 = L19_1
    L5_2()
    L5_2 = L39_1
    L5_2()
    L5_2 = true
    return L5_2
  elseif "cleanerStop" == A0_2 then
    L5_2 = L19_1
    L5_2()
    L5_2 = L40_1
    L5_2()
    L5_2 = true
    return L5_2
  elseif "toggleDoor" == A0_2 then
    L5_2 = L19_1
    L5_2()
    L5_2 = L35_1
    L5_2()
    L5_2 = true
    return L5_2
  elseif "openQuickMenu" == A0_2 then
    L5_2 = L19_1
    L5_2()
    L5_2 = L34_1
    L5_2()
    L5_2 = true
    return L5_2
  elseif "openDecorate" == A0_2 then
    L5_2 = L19_1
    L5_2()
    L5_2 = L36_1
    L5_2()
    L5_2 = true
    return L5_2
  elseif "locateWardrobe" == A0_2 then
    L5_2 = L19_1
    L5_2()
    L5_2 = L37_1
    L6_2 = "wardrobe"
    L7_2 = "assistant.wardrobe_location_mode"
    L5_2(L6_2, L7_2)
    L5_2 = true
    return L5_2
  elseif "locateStorage" == A0_2 then
    L5_2 = L19_1
    L5_2()
    L5_2 = L37_1
    L6_2 = "stash"
    L7_2 = "assistant.storage_location_mode"
    L5_2(L6_2, L7_2)
    L5_2 = true
    return L5_2
  elseif "locateCharge" == A0_2 then
    L5_2 = L19_1
    L5_2()
    L5_2 = L37_1
    L6_2 = "charge"
    L7_2 = "assistant.charge_location_mode"
    L5_2(L6_2, L7_2)
    L5_2 = true
    return L5_2
  end
  L5_2 = false
  return L5_2
end
L42_1 = RegisterNUICallback
L43_1 = "assistant:intent"
function L44_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = L0_1.enabled
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = {}
    L3_2.handled = false
    L2_2(L3_2)
    return
  end
  if A0_2 then
    L2_2 = A0_2.intent
    if L2_2 then
      goto lbl_16
    end
  end
  L2_2 = nil
  ::lbl_16::
  if A0_2 then
    L3_2 = A0_2.entities
    if L3_2 then
      goto lbl_23
    end
  end
  L3_2 = {}
  ::lbl_23::
  L4_2 = L41_1
  L5_2 = L2_2
  L6_2 = L3_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = A1_2
  L6_2 = {}
  L6_2.handled = L4_2
  L5_2(L6_2)
end
L42_1(L43_1, L44_1)
L42_1 = RegisterNUICallback
L43_1 = "assistant:error"
function L44_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = L0_1.enabled
  if not L2_2 then
    L2_2 = A1_2
    L3_2 = "ok"
    return L2_2(L3_2)
  end
  if A0_2 then
    L2_2 = A0_2.type
    if L2_2 then
      goto lbl_14
    end
  end
  L2_2 = "unknown"
  ::lbl_14::
  if "not-supported" == L2_2 then
    L3_2 = L9_1
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "assistant.not_supported"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  elseif "not-allowed" == L2_2 then
    L3_2 = L9_1
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "assistant.mic_denied"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  elseif "no-speech" == L2_2 then
    L3_2 = A1_2
    L4_2 = "ok"
    L3_2(L4_2)
    return
  elseif "audio-capture" == L2_2 then
    L3_2 = L9_1
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "assistant.audio_capture_failed"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  elseif "start-failed" == L2_2 then
    L3_2 = L9_1
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "assistant.not_supported"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  elseif "stt-config" == L2_2 then
    L3_2 = L9_1
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "assistant.stt_config_missing"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  elseif "stt-timeout" == L2_2 then
    L3_2 = L9_1
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "assistant.stt_timeout"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  elseif "stt-network" == L2_2 then
    L3_2 = L9_1
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "assistant.stt_network_error"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  elseif "stt-http" == L2_2 then
    L3_2 = L9_1
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "assistant.stt_http_error"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  elseif "stt-too-long" == L2_2 then
    L3_2 = L9_1
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "assistant.too_long"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  elseif "intent-unhandled" == L2_2 then
    L3_2 = type
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    if "table" == L3_2 then
      L3_2 = type
      L4_2 = A0_2.message
      L3_2 = L3_2(L4_2)
      if "string" == L3_2 then
        L3_2 = A0_2.message
        if L3_2 then
          goto lbl_130
        end
      end
    end
    L3_2 = i18n
    L3_2 = L3_2.t
    L4_2 = "assistant.ambiguous_command"
    L3_2 = L3_2(L4_2)
    ::lbl_130::
    L4_2 = L9_1
    L5_2 = L3_2
    L6_2 = "info"
    L7_2 = L3_2
    L4_2(L5_2, L6_2, L7_2)
  elseif "tts-config" == L2_2 then
    L3_2 = L6_1
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "assistant.tts_config_missing"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  elseif "tts-timeout" == L2_2 then
    L3_2 = L6_1
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "assistant.tts_timeout"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  elseif "tts-network" == L2_2 then
    L3_2 = L6_1
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "assistant.tts_network_error"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  elseif "tts-http" == L2_2 then
    L3_2 = L6_1
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "assistant.tts_http_error"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  elseif "tts-playback" == L2_2 then
    L3_2 = L6_1
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "assistant.tts_playback_failed"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  end
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L42_1(L43_1, L44_1)
L42_1 = Keys
L43_1 = L0_1.pushToTalkKey
L42_1 = L42_1[L43_1]
L43_1 = Keys
L44_1 = L0_1.cancelWaitKey
L43_1 = L43_1[L44_1]
L44_1 = false
L45_1 = assistant
function L46_1()
  local L0_2, L1_2
  L0_2 = L44_1
  if L0_2 then
    return
  end
  L0_2 = true
  L44_1 = L0_2
  L0_2 = L0_1.enabled
  if not L0_2 then
    return
  end
  L0_2 = CreateThread
  function L1_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    while true do
      L0_3 = CurrentHouse
      if not L0_3 then
        break
      end
      L0_3 = Wait
      L1_3 = 0
      L0_3(L1_3)
      L0_3 = IsPauseMenuActive
      L0_3 = L0_3()
      if not L0_3 then
        L0_3 = IsNuiFocused
        L0_3 = L0_3()
        if not L0_3 then
          goto lbl_26
        end
      end
      L0_3 = L1_1
      if L0_3 then
        L0_3 = false
        L1_1 = L0_3
        L0_3 = SendReactMessage
        L1_3 = "assistant:pttStop"
        L2_3 = {}
        L0_3(L1_3, L2_3)
        goto lbl_91
        ::lbl_26::
        L0_3 = IsControlJustPressed
        L1_3 = 0
        L2_3 = L42_1
        L0_3 = L0_3(L1_3, L2_3)
        if L0_3 then
          L0_3 = L1_1
          if not L0_3 then
            L0_3 = L26_1
            L0_3 = L0_3()
            if not L0_3 then
            else
              L0_3 = true
              L1_1 = L0_3
              L0_3 = tostring
              L1_3 = L0_1.language
              if not L1_3 then
                L1_3 = Config
                L1_3 = L1_3.Locale
                if not L1_3 then
                  L1_3 = "en-US"
                end
              end
              L0_3 = L0_3(L1_3)
              L1_3 = SendReactMessage
              L2_3 = "assistant:pttStart"
              L3_3 = {}
              L4_3 = L10_1
              L4_3 = L4_3()
              L3_3.assistantName = L4_3
              L3_3.language = L0_3
              L1_3(L2_3, L3_3)
              L0_3 = IsControlJustReleased
              L1_3 = 0
              L2_3 = L42_1
              L0_3 = L0_3(L1_3, L2_3)
              if L0_3 then
                L0_3 = L1_1
                if L0_3 then
                  L0_3 = false
                  L1_1 = L0_3
                  L0_3 = SendReactMessage
                  L1_3 = "assistant:pttStop"
                  L2_3 = {}
                  L0_3(L1_3, L2_3)
                end
              end
              L0_3 = L5_1.active
              if L0_3 then
                L0_3 = L43_1
                if L0_3 then
                  L0_3 = IsControlJustPressed
                  L1_3 = 0
                  L2_3 = L43_1
                  L0_3 = L0_3(L1_3, L2_3)
                  if L0_3 then
                    L0_3 = L19_1
                    L0_3()
                  end
                end
              end
            end
          end
        end
      end
      ::lbl_91::
    end
    L0_3 = false
    L44_1 = L0_3
  end
  L0_2(L1_2)
end
L45_1.tick = L46_1
L45_1 = AddEventHandler
L46_1 = "housing:onEnterHouse"
function L47_1()
  local L0_2, L1_2
  L0_2 = assistant
  L0_2 = L0_2.tick
  L0_2()
end
L45_1(L46_1, L47_1)
L45_1 = AddEventHandler
L46_1 = "housing:handleEnterZone"
function L47_1(A0_2)
  local L1_2, L2_2
  L1_2 = L16_1
  L2_2 = A0_2
  L1_2(L2_2)
end
L45_1(L46_1, L47_1)
L45_1 = AddEventHandler
L46_1 = "housing:handleExitZone"
function L47_1(A0_2)
  local L1_2, L2_2, L3_2
  if not A0_2 then
    L1_2 = nil
    L3_1 = L1_2
    return
  end
  L1_2 = L3_1
  if L1_2 == A0_2 then
    L1_2 = L0_1.enabled
    if L1_2 then
      L1_2 = L11_1
      L2_2 = A0_2
      L1_2 = L1_2(L2_2)
      if L1_2 then
        L1_2 = L9_1
        L2_2 = L15_1
        L2_2 = L2_2()
        L3_2 = "info"
        L1_2(L2_2, L3_2)
      end
    end
    L1_2 = nil
    L3_1 = L1_2
  end
end
L45_1(L46_1, L47_1)
L45_1 = AddEventHandler
L46_1 = "onResourceStop"
function L47_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 ~= L1_2 then
    return
  end
  L1_2 = L19_1
  L1_2()
  L1_2 = nil
  L3_1 = L1_2
  L1_2 = L1_1
  if L1_2 then
    L1_2 = SendReactMessage
    L2_2 = "assistant:pttStop"
    L3_2 = {}
    L1_2(L2_2, L3_2)
  end
end
L45_1(L46_1, L47_1)






