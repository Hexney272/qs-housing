





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1
L0_1 = {}
SpawnedBoards = L0_1
L0_1 = Config
L0_1 = L0_1.UseDrawTextOnBoard
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = L0_1
  if L3_2 then
    L3_2 = DrawTextBoard
    L4_2 = A1_2.x
    L5_2 = A1_2.y
    L5_2 = L5_2 - 0.1
    L6_2 = A1_2.z
    L6_2 = L6_2 + 1.36
    L7_2 = i18n
    L7_2 = L7_2.t
    L8_2 = "drawtext.board_agent"
    L7_2 = L7_2(L8_2)
    L8_2 = A0_2.name
    L7_2 = L7_2 .. L8_2
    L3_2(L4_2, L5_2, L6_2, L7_2)
    L3_2 = DrawTextBoard
    L4_2 = A1_2.x
    L5_2 = A1_2.y
    L5_2 = L5_2 - 0.1
    L6_2 = A1_2.z
    L6_2 = L6_2 + 1.14
    L7_2 = i18n
    L7_2 = L7_2.t
    L8_2 = "drawtext.board_phone"
    L7_2 = L7_2(L8_2)
    L8_2 = A0_2.phone
    if not L8_2 then
      L8_2 = "Unknown"
    end
    L7_2 = L7_2 .. L8_2
    L3_2(L4_2, L5_2, L6_2, L7_2)
    L3_2 = DrawTextBoard
    L4_2 = A1_2.x
    L5_2 = A1_2.y
    L5_2 = L5_2 - 0.1
    L6_2 = A1_2.z
    L6_2 = L6_2 + 0.92
    L7_2 = i18n
    L7_2 = L7_2.t
    L8_2 = "drawtext.board_money"
    L7_2 = L7_2(L8_2)
    L8_2 = A0_2.price
    L7_2 = L7_2 .. L8_2
    L3_2(L4_2, L5_2, L6_2, L7_2)
    return
  end
  L3_2 = AddTextEntry
  L4_2 = "HOUSE_AGENT"
  L5_2 = i18n
  L5_2 = L5_2.t
  L6_2 = "drawtext.board_agent"
  L5_2, L6_2, L7_2, L8_2, L9_2 = L5_2(L6_2)
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L3_2 = Utils
  L3_2 = L3_2.BreakString
  L4_2 = A0_2.name
  L5_2 = 15
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = FloatyDraw
  L5_2 = vec3
  L6_2 = A1_2.x
  L7_2 = A1_2.y
  L8_2 = A1_2.z
  L8_2 = L8_2 + 1
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L6_2 = A2_2
  function L7_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3
    L1_3 = BeginTextCommandDisplayText
    L2_3 = "HOUSE_AGENT"
    L1_3(L2_3)
    L1_3 = SetTextFont
    L2_3 = 1
    L1_3(L2_3)
    L1_3 = SetTextCentre
    L2_3 = false
    L1_3(L2_3)
    L1_3 = SetTextOutline
    L1_3()
    L1_3 = SetTextJustification
    L2_3 = 0
    L1_3(L2_3)
    L1_3 = SetTextScale
    L2_3 = Config
    L2_3 = L2_3.SignTextScale
    L3_3 = Config
    L3_3 = L3_3.SignTextScale
    L1_3(L2_3, L3_3)
    L1_3 = AddTextComponentSubstringPlayerName
    L2_3 = L3_2
    L1_3(L2_3)
    L1_3 = SetTextColour
    L2_3 = 100
    L3_3 = 100
    L4_3 = 255
    L5_3 = 255
    L1_3(L2_3, L3_3, L4_3, L5_3)
    L1_3 = EndTextCommandDisplayText
    L2_3 = 0.46
    L3_3 = 0.62
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = A0_2.phone
  if L4_2 then
    L4_2 = AddTextEntry
    L5_2 = "HOUSE_PHONE"
    L6_2 = i18n
    L6_2 = L6_2.t
    L7_2 = "drawtext.board_phone"
    L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
    L4_2 = FloatyDraw
    L5_2 = vec3
    L6_2 = A1_2.x
    L7_2 = A1_2.y
    L8_2 = A1_2.z
    L8_2 = L8_2 + 0.7
    L5_2 = L5_2(L6_2, L7_2, L8_2)
    L6_2 = A2_2
    function L7_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3, L5_3
      L1_3 = BeginTextCommandDisplayText
      L2_3 = "HOUSE_PHONE"
      L1_3(L2_3)
      L1_3 = SetTextFont
      L2_3 = 1
      L1_3(L2_3)
      L1_3 = SetTextCentre
      L2_3 = false
      L1_3(L2_3)
      L1_3 = SetTextOutline
      L1_3()
      L1_3 = SetTextJustification
      L2_3 = 0
      L1_3(L2_3)
      L1_3 = SetTextScale
      L2_3 = Config
      L2_3 = L2_3.SignTextScale
      L3_3 = Config
      L3_3 = L3_3.SignTextScale
      L1_3(L2_3, L3_3)
      L1_3 = AddTextComponentSubstringPlayerName
      L2_3 = A0_2.phone
      if not L2_3 then
        L2_3 = "Unknown"
      end
      L1_3(L2_3)
      L1_3 = SetTextColour
      L2_3 = 255
      L3_3 = 255
      L4_3 = 255
      L5_3 = 255
      L1_3(L2_3, L3_3, L4_3, L5_3)
      L1_3 = EndTextCommandDisplayText
      L2_3 = 0.46
      L3_3 = 0.52
      L1_3(L2_3, L3_3)
    end
    L4_2(L5_2, L6_2, L7_2)
  end
  L4_2 = A0_2.phone
  if L4_2 then
    L4_2 = 0.4
    if L4_2 then
      goto lbl_104
    end
  end
  L4_2 = 0.7
  ::lbl_104::
  L5_2 = AddTextEntry
  L6_2 = "HOUSE_PRICE"
  L7_2 = i18n
  L7_2 = L7_2.t
  L8_2 = "drawtext.board_money"
  L7_2, L8_2, L9_2 = L7_2(L8_2)
  L5_2(L6_2, L7_2, L8_2, L9_2)
  L5_2 = FloatyDraw
  L6_2 = vec3
  L7_2 = A1_2.x
  L8_2 = A1_2.y
  L9_2 = A1_2.z
  L9_2 = L9_2 + L4_2
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L7_2 = A2_2
  function L8_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3
    L1_3 = BeginTextCommandDisplayText
    L2_3 = "HOUSE_PRICE"
    L1_3(L2_3)
    L1_3 = SetTextFont
    L2_3 = 1
    L1_3(L2_3)
    L1_3 = SetTextCentre
    L2_3 = false
    L1_3(L2_3)
    L1_3 = SetTextOutline
    L1_3()
    L1_3 = SetTextJustification
    L2_3 = 0
    L1_3(L2_3)
    L1_3 = SetTextScale
    L2_3 = Config
    L2_3 = L2_3.SignTextScale
    L3_3 = Config
    L3_3 = L3_3.SignTextScale
    L1_3(L2_3, L3_3)
    L1_3 = AddTextComponentSubstringPlayerName
    L2_3 = A0_2.price
    L1_3(L2_3)
    L1_3 = SetTextColour
    L2_3 = 0
    L3_3 = 255
    L4_3 = 0
    L5_3 = 255
    L1_3(L2_3, L3_3, L4_3, L5_3)
    L1_3 = EndTextCommandDisplayText
    L2_3 = 0.46
    L3_3 = 0.42
    L1_3(L2_3, L3_3)
  end
  L5_2(L6_2, L7_2, L8_2)
end
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = A0_2.spawned
  if not L1_2 then
    L1_2 = Error
    L2_2 = "removeBoardSpawnedObject :: Object is not spawned"
    L3_2 = "data"
    L4_2 = A0_2
    L1_2(L2_2, L3_2, L4_2)
    L1_2 = false
    return L1_2
  end
  L1_2 = DeleteObject
  L2_2 = A0_2.handle
  L1_2(L2_2)
  A0_2.spawned = false
  L1_2 = Debug
  L2_2 = "removeBoardSpawnedObject"
  L3_2 = "object"
  L4_2 = A0_2.handle
  L1_2(L2_2, L3_2, L4_2)
end
L3_1 = CreateThread
function L4_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  while true do
    L0_2 = GetEntityCoords
    L1_2 = cache
    L1_2 = L1_2.ped
    L0_2 = L0_2(L1_2)
    L1_2 = pairs
    L2_2 = SpawnedBoards
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = vec3
      L8_2 = L6_2.coords
      L8_2 = L8_2.x
      L9_2 = L6_2.coords
      L9_2 = L9_2.y
      L10_2 = L6_2.coords
      L10_2 = L10_2.z
      L7_2 = L7_2(L8_2, L9_2, L10_2)
      L7_2 = L0_2 - L7_2
      L7_2 = #L7_2
      L8_2 = Config
      L8_2 = L8_2.BoardSpawnDistance
      if L7_2 <= L8_2 then
        L8_2 = L6_2.spawned
        if not L8_2 then
          L8_2 = joaat
          L9_2 = L6_2.object
          L8_2 = L8_2(L9_2)
          L9_2 = lib
          L9_2 = L9_2.requestModel
          L10_2 = L8_2
          L11_2 = Config
          L11_2 = L11_2.DefaultRequestModelTimeout
          L9_2(L10_2, L11_2)
          L9_2 = CreateObject
          L10_2 = L8_2
          L11_2 = L6_2.coords
          L11_2 = L11_2.x
          L12_2 = L6_2.coords
          L12_2 = L12_2.y
          L13_2 = L6_2.coords
          L13_2 = L13_2.z
          L14_2 = false
          L15_2 = true
          L16_2 = false
          L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
          L10_2 = SetEntityHeading
          L11_2 = L9_2
          L12_2 = L6_2.coords
          L12_2 = L12_2.w
          L10_2(L11_2, L12_2)
          L10_2 = PlaceObjectOnGroundProperly
          L11_2 = L9_2
          L10_2(L11_2)
          L10_2 = FreezeEntityPosition
          L11_2 = L9_2
          L12_2 = true
          L10_2(L11_2, L12_2)
          L10_2 = SetEntityCollision
          L11_2 = L9_2
          L12_2 = true
          L13_2 = true
          L10_2(L11_2, L12_2, L13_2)
          L10_2 = SetModelAsNoLongerNeeded
          L11_2 = L8_2
          L10_2(L11_2)
          if L9_2 then
            L6_2.handle = L9_2
            L6_2.spawned = true
          end
      end
      else
        L8_2 = Config
        L8_2 = L8_2.BoardSpawnDistance
        if L7_2 > L8_2 then
          L8_2 = L6_2.spawned
          if L8_2 then
            L8_2 = L2_1
            L9_2 = L6_2
            L8_2(L9_2)
          end
        end
      end
    end
    L1_2 = Wait
    L2_2 = 1250
    L1_2(L2_2)
  end
end
L3_1(L4_1)
L3_1 = CreateThread
function L4_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  while true do
    L0_2 = 1250
    L1_2 = pairs
    L2_2 = SpawnedBoards
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = L6_2.coords
      L8_2 = L6_2.coords
      L8_2 = L8_2.w
      L9_2 = GetEntityCoords
      L10_2 = cache
      L10_2 = L10_2.ped
      L9_2 = L9_2(L10_2)
      L10_2 = vec3
      L11_2 = L7_2.x
      L12_2 = L7_2.y
      L13_2 = L7_2.z
      L10_2 = L10_2(L11_2, L12_2, L13_2)
      L9_2 = L9_2 - L10_2
      L9_2 = #L9_2
      if L9_2 < 30.0 then
        L0_2 = 0
        L10_2 = GetOffsetFromEntityInWorldCoords
        L11_2 = L6_2.handle
        L12_2 = -0.2
        L13_2 = 0.0
        L14_2 = 0.0
        L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
        L11_2 = L1_1
        L12_2 = L6_2
        L13_2 = L10_2
        L14_2 = L8_2
        L11_2(L12_2, L13_2, L14_2)
      end
    end
    L1_2 = Wait
    L2_2 = L0_2
    L1_2(L2_2)
  end
end
L3_1(L4_1)
function L3_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = Config
  L0_2 = L0_2.EnableBoard
  if not L0_2 then
    return
  end
  L0_2 = SpawnedBoards
  L0_2 = #L0_2
  if L0_2 > 0 then
    L0_2 = table
    L0_2 = L0_2.deepclone
    L1_2 = SpawnedBoards
    L0_2 = L0_2(L1_2)
    L1_2 = {}
    SpawnedBoards = L1_2
    L1_2 = pairs
    L2_2 = L0_2
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = DeleteEntity
      L8_2 = L6_2.handle
      L7_2(L8_2)
    end
  end
  L0_2 = pairs
  L1_2 = Config
  L1_2 = L1_2.Houses
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = L5_2.apartmentNumber
    if L6_2 then
      L6_2 = L5_2.apartmentNumber
      if "apt-0" ~= L6_2 then
        goto lbl_56
      end
    end
    L6_2 = L5_2.owned
    if not L6_2 then
      L6_2 = L5_2.board
      if L6_2 then
        L6_2 = L5_2.board
        L6_2 = L6_2.coords
        if L6_2 then
          L6_2 = L5_2.board
          L7_2 = L5_2.price
          L6_2.price = L7_2
          L7_2 = table
          L7_2 = L7_2.insert
          L8_2 = SpawnedBoards
          L9_2 = L6_2
          L7_2(L8_2, L9_2)
        end
      end
    end
    ::lbl_56::
  end
  L0_2 = Debug
  L1_2 = "Boards initialized"
  L2_2 = SpawnedBoards
  L0_2(L1_2, L2_2)
end
InitHouseBoards = L3_1
L3_1 = AddEventHandler
L4_1 = "onResourceStop"
function L5_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if L1_2 ~= A0_2 then
    return
  end
  L1_2 = pairs
  L2_2 = SpawnedBoards
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = DeleteEntity
    L8_2 = L6_2.handle
    L7_2(L8_2)
  end
  L1_2 = {}
  SpawnedBoards = L1_2
end
L3_1(L4_1, L5_1)






