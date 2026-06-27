





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1
L0_1 = {}
L1_1 = {}
function L2_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Config
  L0_2 = L0_2.JunkObjects
  L1_2 = math
  L1_2 = L1_2.random
  L2_2 = 1
  L3_2 = #L0_2
  L1_2 = L1_2(L2_2, L3_2)
  L1_2 = L0_2[L1_2]
  return L1_2
end
function L3_1(A0_2)
  local L1_2
  L1_2 = L1_1
  L1_2 = L1_2[A0_2]
  if L1_2 then
    L1_2 = L1_1
    L1_2 = L1_2[A0_2]
    L1_2 = #L1_2
    L1_2 = L1_2 > 0
  end
  return L1_2
end
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = L2_1
  L1_2 = L1_2()
  L2_2 = MySQL
  L2_2 = L2_2.insert
  L2_2 = L2_2.await
  L3_2 = "INSERT INTO house_junk (house, model, coords) VALUES (?, ?, NULL)"
  L4_2 = {}
  L5_2 = A0_2
  L6_2 = L1_2
  L4_2[1] = L5_2
  L4_2[2] = L6_2
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    return L2_2
  end
  L3_2 = nil
  return L3_2
end
function L5_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = MySQL
  L1_2 = L1_2.update
  L1_2 = L1_2.await
  L2_2 = "DELETE FROM house_junk WHERE id = ?"
  L3_2 = {}
  L4_2 = A0_2
  L3_2[1] = L4_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = L1_2 > 0
  return L2_2
end
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  if A1_2 then
    L2_2 = A1_2.x
    if L2_2 then
      L2_2 = A1_2.y
      if L2_2 then
        L2_2 = A1_2.z
        if L2_2 then
          goto lbl_14
        end
      end
    end
  end
  L2_2 = false
  do return L2_2 end
  ::lbl_14::
  L2_2 = json
  L2_2 = L2_2.encode
  L3_2 = {}
  L4_2 = A1_2.x
  L3_2.x = L4_2
  L4_2 = A1_2.y
  L3_2.y = L4_2
  L4_2 = A1_2.z
  L3_2.z = L4_2
  L2_2 = L2_2(L3_2)
  L3_2 = MySQL
  L3_2 = L3_2.update
  L3_2 = L3_2.await
  L4_2 = "UPDATE house_junk SET coords = ? WHERE id = ?"
  L5_2 = {}
  L6_2 = L2_2
  L7_2 = A0_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = L3_2 > 0
  return L4_2
end
function L7_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = MySQL
  L1_2 = L1_2.query
  L1_2 = L1_2.await
  L2_2 = "SELECT * FROM house_junk WHERE house = ?"
  L3_2 = {}
  L4_2 = A0_2
  L3_2[1] = L4_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = {}
  L3_2 = ipairs
  L4_2 = L1_2 or L4_2
  if not L1_2 then
    L4_2 = {}
  end
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = L8_2.coords
    if L9_2 then
      L9_2 = json
      L9_2 = L9_2.decode
      L10_2 = L8_2.coords
      L9_2 = L9_2(L10_2)
      if L9_2 then
        goto lbl_29
      end
    end
    L9_2 = nil
    ::lbl_29::
    L10_2 = table
    L10_2 = L10_2.insert
    L11_2 = L2_2
    L12_2 = {}
    L13_2 = L8_2.id
    L12_2.id = L13_2
    L13_2 = L8_2.house
    L12_2.house = L13_2
    L13_2 = L8_2.model
    L12_2.model = L13_2
    L12_2.coords = L9_2
    L13_2 = L8_2.created_at
    L12_2.created_at = L13_2
    L10_2(L11_2, L12_2)
  end
  return L2_2
end
function L8_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = MySQL
  L1_2 = L1_2.scalar
  L1_2 = L1_2.await
  L2_2 = "SELECT COUNT(*) FROM house_junk WHERE house = ?"
  L3_2 = {}
  L4_2 = A0_2
  L3_2[1] = L4_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = L1_2 or L2_2
  if not L1_2 then
    L2_2 = 0
  end
  return L2_2
end
function L9_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L1_2 = Config
  L1_2 = L1_2.Cleaning
  if not L1_2 then
    return
  end
  L1_2 = Config
  L1_2 = L1_2.Houses
  L1_2 = L1_2[A0_2]
  if not L1_2 then
    L2_2 = Debug
    L3_2 = "spawnJunkForHouse - No house data for:"
    L4_2 = A0_2
    L2_2(L3_2, L4_2)
    return
  end
  L2_2 = Config
  L2_2 = L2_2.MaxJunkPerHouse
  if not L2_2 then
    L2_2 = 10
  end
  L3_2 = L8_1
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if L2_2 <= L3_2 then
    L4_2 = Debug
    L5_2 = "spawnJunkForHouse - Max junk reached for:"
    L6_2 = A0_2
    L7_2 = L3_2
    L8_2 = "/"
    L9_2 = L2_2
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
    return
  end
  L4_2 = L4_1
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L5_2 = L2_1
    L5_2 = L5_2()
    L6_2 = {}
    L6_2.id = L4_2
    L6_2.house = A0_2
    L6_2.model = L5_2
    L6_2.coords = nil
    L7_2 = L3_1
    L8_2 = A0_2
    L7_2 = L7_2(L8_2)
    if L7_2 then
      L8_2 = ipairs
      L9_2 = L1_1
      L9_2 = L9_2[A0_2]
      L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
      for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
        L14_2 = TriggerClientEvent
        L15_2 = "housing:junk:spawn"
        L16_2 = L13_2
        L17_2 = L6_2
        L14_2(L15_2, L16_2, L17_2)
      end
    end
  end
end
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = L0_1
  L1_2 = L1_2[A0_2]
  if L1_2 then
    return
  end
  L1_2 = Config
  L1_2 = L1_2.Cleaning
  if not L1_2 then
    return
  end
  L1_2 = Config
  L1_2 = L1_2.JunkObjectTime
  L2_2 = L0_1
  L3_2 = SetTimeout
  L4_2 = L1_2
  function L5_2()
    local L0_3, L1_3
    L1_3 = A0_2
    L0_3 = L0_1
    L0_3 = L0_3[L1_3]
    if not L0_3 then
      return
    end
    L1_3 = A0_2
    L0_3 = L0_1
    L0_3[L1_3] = nil
    L0_3 = L9_1
    L1_3 = A0_2
    L0_3(L1_3)
    L0_3 = L10_1
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L3_2 = L3_2(L4_2, L5_2)
  L2_2[A0_2] = L3_2
end
function L11_1(A0_2)
  local L1_2
  L1_2 = L0_1
  L1_2 = L1_2[A0_2]
  if L1_2 then
    L1_2 = L0_1
    L1_2[A0_2] = nil
  end
end
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = L1_1
  L2_2 = L2_2[A1_2]
  if not L2_2 then
    L2_2 = L1_1
    L3_2 = {}
    L2_2[A1_2] = L3_2
  end
  L2_2 = ipairs
  L3_2 = L1_1
  L3_2 = L3_2[A1_2]
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    if L7_2 == A0_2 then
      return
    end
  end
  L2_2 = table
  L2_2 = L2_2.insert
  L3_2 = L1_1
  L3_2 = L3_2[A1_2]
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
  L2_2 = L1_1
  L2_2 = L2_2[A1_2]
  L2_2 = #L2_2
  if 1 == L2_2 then
    L2_2 = L10_1
    L3_2 = A1_2
    L2_2(L3_2)
  end
  L2_2 = Debug
  L3_2 = "Player"
  L4_2 = A0_2
  L5_2 = "entered house:"
  L6_2 = A1_2
  L7_2 = "total players:"
  L8_2 = L1_1
  L8_2 = L8_2[A1_2]
  L8_2 = #L8_2
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
end
function L13_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = L1_1
  L2_2 = L2_2[A1_2]
  if not L2_2 then
    return
  end
  L2_2 = ipairs
  L3_2 = L1_1
  L3_2 = L3_2[A1_2]
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    if L7_2 == A0_2 then
      L8_2 = table
      L8_2 = L8_2.remove
      L9_2 = L1_1
      L9_2 = L9_2[A1_2]
      L10_2 = L6_2
      L8_2(L9_2, L10_2)
      break
    end
  end
  L2_2 = L1_1
  L2_2 = L2_2[A1_2]
  L2_2 = #L2_2
  if 0 == L2_2 then
    L2_2 = L11_1
    L3_2 = A1_2
    L2_2(L3_2)
    L2_2 = L1_1
    L2_2[A1_2] = nil
  end
  L2_2 = Debug
  L3_2 = "Player"
  L4_2 = A0_2
  L5_2 = "left house:"
  L6_2 = A1_2
  L7_2 = "remaining:"
  L8_2 = L1_1
  L8_2 = L8_2[A1_2]
  if L8_2 then
    L8_2 = L1_1
    L8_2 = L8_2[A1_2]
    L8_2 = #L8_2
    if L8_2 then
      goto lbl_49
    end
  end
  L8_2 = 0
  ::lbl_49::
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
end
L14_1 = lib
L14_1 = L14_1.callback
L14_1 = L14_1.register
L15_1 = "housing:junk:getForHouse"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = L7_1
  L3_2 = A1_2
  return L2_2(L3_2)
end
L14_1(L15_1, L16_1)
L14_1 = lib
L14_1 = L14_1.callback
L14_1 = L14_1.register
L15_1 = "housing:junk:updateCoords"
function L16_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  if not A1_2 or not A2_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = type
  L4_2 = A2_2
  L3_2 = L3_2(L4_2)
  if "table" == L3_2 then
    L3_2 = A2_2.x
    if L3_2 then
      L3_2 = A2_2.y
      if L3_2 then
        L3_2 = A2_2.z
        if L3_2 then
          goto lbl_27
        end
      end
    end
  end
  L3_2 = Debug
  L4_2 = "housing:junk:updateCoords - Invalid coords structure:"
  L5_2 = A2_2
  L3_2(L4_2, L5_2)
  L3_2 = false
  do return L3_2 end
  ::lbl_27::
  L3_2 = L6_1
  L4_2 = A1_2
  L5_2 = A2_2
  return L3_2(L4_2, L5_2)
end
L14_1(L15_1, L16_1)
L14_1 = lib
L14_1 = L14_1.callback
L14_1 = L14_1.register
L15_1 = "housing:junk:remove"
function L16_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  if not A1_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = L5_1
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L4_2 = L1_1
    L4_2 = L4_2[A2_2]
    if L4_2 then
      L4_2 = ipairs
      L5_2 = L1_1
      L5_2 = L5_2[A2_2]
      L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
      for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
        if L9_2 ~= A0_2 then
          L10_2 = TriggerClientEvent
          L11_2 = "housing:junk:remove"
          L12_2 = L9_2
          L13_2 = A1_2
          L10_2(L11_2, L12_2, L13_2)
        end
      end
    end
    L4_2 = SendLog
    L5_2 = DiscordWebhook
    L6_2 = {}
    L6_2.title = "Housing - Junk"
    L6_2.description = "Player cleaned junk"
    L7_2 = {}
    L8_2 = {}
    L8_2.name = "Player"
    L9_2 = GetPlayerName
    L10_2 = A0_2
    L9_2 = L9_2(L10_2)
    L8_2.value = L9_2
    L8_2.inline = true
    L9_2 = {}
    L9_2.name = "House"
    L10_2 = A2_2 or L10_2
    if not A2_2 then
      L10_2 = "Unknown"
    end
    L9_2.value = L10_2
    L9_2.inline = true
    L10_2 = {}
    L10_2.name = "Junk ID"
    L11_2 = tostring
    L12_2 = A1_2
    L11_2 = L11_2(L12_2)
    L10_2.value = L11_2
    L10_2.inline = true
    L7_2[1] = L8_2
    L7_2[2] = L9_2
    L7_2[3] = L10_2
    L6_2.fields = L7_2
    L7_2 = WebhookColor
    L6_2.color = L7_2
    L4_2(L5_2, L6_2)
  end
  return L3_2
end
L14_1(L15_1, L16_1)
L14_1 = AddEventHandler
L15_1 = "housing:setInside"
function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = source
  L3_2 = Config
  L3_2 = L3_2.Cleaning
  if not L3_2 then
    return
  end
  L3_2 = type
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if "table" == L3_2 then
    L3_2 = A0_2.house
    A0_2 = L3_2 or A0_2
    if not L3_2 then
      A0_2 = A0_2.name
    end
  end
  if not A0_2 then
    return
  end
  if A1_2 then
    L3_2 = L12_1
    L4_2 = L2_2
    L5_2 = A0_2
    L3_2(L4_2, L5_2)
  else
    L3_2 = L13_1
    L4_2 = L2_2
    L5_2 = A0_2
    L3_2(L4_2, L5_2)
  end
end
L14_1(L15_1, L16_1)
L14_1 = AddEventHandler
L15_1 = "playerDropped"
function L16_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = source
  L2_2 = pairs
  L3_2 = L1_1
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = ipairs
    L9_2 = L7_2
    L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
    for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
      if L13_2 == L1_2 then
        L14_2 = table
        L14_2 = L14_2.remove
        L15_2 = L7_2
        L16_2 = L12_2
        L14_2(L15_2, L16_2)
        L14_2 = #L7_2
        if 0 == L14_2 then
          L14_2 = L11_1
          L15_2 = L6_2
          L14_2(L15_2)
          L14_2 = L1_1
          L14_2[L6_2] = nil
        end
        break
      end
    end
  end
end
L14_1(L15_1, L16_1)
L14_1 = Config
L14_1 = L14_1.Cleaning
if L14_1 then
  L14_1 = CreateThread
  function L15_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2
    while true do
      L0_2 = MySQL
      L0_2 = L0_2.update
      L0_2 = L0_2.await
      L1_2 = "DELETE FROM house_junk WHERE created_at < DATE_SUB(NOW(), INTERVAL 7 DAY)"
      L0_2 = L0_2(L1_2)
      if L0_2 and L0_2 > 0 then
        L1_2 = Debug
        L2_2 = "Cleaned up"
        L3_2 = L0_2
        L4_2 = "old junk entries"
        L1_2(L2_2, L3_2, L4_2)
      end
      L1_2 = Wait
      L2_2 = 86400000
      L1_2(L2_2)
    end
  end
  L14_1(L15_1)
end






