





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1
L0_1 = 0
L1_1 = nil
function L2_1(A0_2)
  local L1_2, L2_2, L3_2
  if not A0_2 then
    return
  end
  L1_2 = AlarmDispatch
  L2_2 = A0_2
  L1_2(L2_2)
  L1_2 = TriggerServerEvent
  L2_2 = "housing:server:houseAlarmSound"
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L3_1 = RegisterNetEvent
L4_1 = "housing:client:houseAlarmSound"
function L5_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  if not A1_2 then
    L3_2 = Config
    A1_2 = L3_2.HouseAlarmDurationMs
  end
  if not A2_2 then
    L3_2 = Config
    A2_2 = L3_2.HouseAlarmHearRange
  end
  L3_2 = GetEntityCoords
  L4_2 = cache
  L4_2 = L4_2.ped
  L3_2 = L3_2(L4_2)
  L3_2 = L3_2 - A0_2
  L3_2 = #L3_2
  if A2_2 < L3_2 then
    return
  end
  L3_2 = L1_1
  if L3_2 then
    L3_2 = StopSound
    L4_2 = L1_1
    L3_2(L4_2)
    L3_2 = ReleaseSoundId
    L4_2 = L1_1
    L3_2(L4_2)
    L3_2 = nil
    L1_1 = L3_2
  end
  L3_2 = L0_1
  L3_2 = L3_2 + 1
  L0_1 = L3_2
  L3_2 = L0_1
  L4_2 = GetSoundId
  L4_2 = L4_2()
  L1_1 = L4_2
  L5_2 = Config
  L5_2 = L5_2.HouseAlarmSoundName
  if not L5_2 then
    L5_2 = "VEHICLES_HORNS_AMBULANCE_WARNING"
  end
  L6_2 = math
  L6_2 = L6_2.max
  L7_2 = 1
  L8_2 = math
  L8_2 = L8_2.floor
  L9_2 = A2_2
  L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L8_2(L9_2)
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  L7_2 = PlaySoundFromCoord
  L8_2 = L4_2
  L9_2 = L5_2
  L10_2 = A0_2.x
  L11_2 = A0_2.y
  L12_2 = A0_2.z
  L13_2 = nil
  L14_2 = false
  L15_2 = L6_2
  L16_2 = false
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  L7_2 = CreateThread
  function L8_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = L4_2
    L1_3 = GetGameTimer
    L1_3 = L1_3()
    while true do
      L2_3 = GetGameTimer
      L2_3 = L2_3()
      L2_3 = L2_3 - L1_3
      L3_3 = A1_2
      if not (L2_3 < L3_3) then
        break
      end
      L2_3 = L3_2
      L3_3 = L0_1
      if L2_3 ~= L3_3 then
        L2_3 = L1_1
        if L2_3 ~= L0_3 then
          return
        end
        L2_3 = StopSound
        L3_3 = L0_3
        L2_3(L3_3)
        L2_3 = ReleaseSoundId
        L3_3 = L0_3
        L2_3(L3_3)
        L2_3 = L1_1
        if L2_3 == L0_3 then
          L2_3 = nil
          L1_1 = L2_3
        end
        return
      end
      L2_3 = Wait
      L3_3 = 200
      L2_3(L3_3)
    end
    L2_3 = L3_2
    L3_3 = L0_1
    if L2_3 == L3_3 then
      L2_3 = StopSound
      L3_3 = L0_3
      L2_3(L3_3)
      L2_3 = ReleaseSoundId
      L3_3 = L0_3
      L2_3(L3_3)
      L2_3 = L1_1
      if L2_3 == L0_3 then
        L2_3 = nil
        L1_1 = L2_3
      end
    end
  end
  L7_2(L8_2)
end
L3_1(L4_1, L5_1)
L3_1 = AddEventHandler
L4_1 = "onResourceStop"
function L5_1(A0_2)
  local L1_2, L2_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 ~= L1_2 then
    return
  end
  L1_2 = L1_1
  if L1_2 then
    L1_2 = StopSound
    L2_2 = L1_1
    L1_2(L2_2)
    L1_2 = ReleaseSoundId
    L2_2 = L1_1
    L1_2(L2_2)
    L1_2 = nil
    L1_1 = L1_2
  end
  L1_2 = L0_1
  L1_2 = L1_2 + 1
  L0_1 = L1_2
end
L3_1(L4_1, L5_1)
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A0_2]
  if not L2_2 then
    L3_2 = print
    L4_2 = "houseData not found"
    return L3_2(L4_2)
  end
  L3_2 = table
  L3_2 = L3_2.includes
  L4_2 = L2_2.upgrades
  L5_2 = "alarm"
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L4_2 = L2_1
    L5_2 = A0_2
    L4_2(L5_2)
  end
  if A1_2 then
    L4_2 = L2_2.mlo
    if L4_2 then
      L4_2 = DoLockpickAnimation
      L5_2 = A0_2
      L6_2 = false
      L4_2(L5_2, L6_2)
      L4_2 = table
      L4_2 = L4_2.find
      L5_2 = L2_2.mlo
      function L6_2(A0_3)
        local L1_3, L2_3, L3_3, L4_3
        L1_3 = vec3
        L2_3 = A0_3.coords
        L2_3 = L2_3.x
        L3_3 = A0_3.coords
        L3_3 = L3_3.y
        L4_3 = A0_3.coords
        L4_3 = L4_3.z
        L1_3 = L1_3(L2_3, L3_3, L4_3)
        L2_3 = GetEntityCoords
        L3_3 = cache
        L3_3 = L3_3.ped
        L2_3 = L2_3(L3_3)
        L2_3 = L2_3 - L1_3
        L2_3 = #L2_3
        L3_3 = Config
        L3_3 = L3_3.DoorDistance
        L3_3 = L2_3 < L3_3
        return L3_3
      end
      L4_2, L5_2 = L4_2(L5_2, L6_2)
      if not L4_2 then
        L6_2 = Notification
        L7_2 = i18n
        L7_2 = L7_2.t
        L8_2 = "no_doors"
        L7_2 = L7_2(L8_2)
        L8_2 = "error"
        return L6_2(L7_2, L8_2)
      end
      L6_2 = TriggerServerEvent
      L7_2 = "qb-houses:SyncDoor"
      L8_2 = A0_2
      L9_2 = {}
      L10_2 = L4_2
      L9_2[1] = L10_2
      L10_2 = false
      L6_2(L7_2, L8_2, L9_2, L10_2)
    else
      L4_2 = TriggerServerEvent
      L5_2 = "qb-houses:server:lockHouse"
      L6_2 = false
      L7_2 = A0_2
      L4_2(L5_2, L6_2, L7_2)
    end
    L4_2 = TriggerServerEvent
    L5_2 = "qb-houses:server:SetHouseRammed"
    L6_2 = true
    L7_2 = A0_2
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = DoRamAnimation
    L5_2 = false
    L4_2(L5_2)
    L4_2 = Notification
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "success_ram"
    L5_2 = L5_2(L6_2)
    L6_2 = "success"
    L4_2(L5_2, L6_2)
  else
    L4_2 = TriggerServerEvent
    L5_2 = "qb-houses:server:SetRamState"
    L6_2 = false
    L7_2 = A0_2
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = DoRamAnimation
    L5_2 = false
    L4_2(L5_2)
    L4_2 = Notification
    L5_2 = i18n
    L5_2 = L5_2.t
    L6_2 = "fail_ram"
    L5_2 = L5_2(L6_2)
    L6_2 = "error"
    L4_2(L5_2, L6_2)
  end
end
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = lib
  L1_2 = L1_2.skillCheck
  L2_2 = {}
  L3_2 = "easy"
  L4_2 = "easy"
  L5_2 = {}
  L5_2.areaSize = 70
  L5_2.speedMultiplier = 1
  L6_2 = "easy"
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L2_2[4] = L6_2
  L3_2 = {}
  L4_2 = "z"
  L5_2 = "q"
  L6_2 = "s"
  L7_2 = "d"
  L3_2[1] = L4_2
  L3_2[2] = L5_2
  L3_2[3] = L6_2
  L3_2[4] = L7_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = L3_1
  L3_2 = A0_2
  L4_2 = L1_2
  L2_2(L3_2, L4_2)
end
function L5_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = GetEntityCoords
  L2_2 = cache
  L2_2 = L2_2.ped
  L1_2 = L1_2(L2_2)
  if not A0_2 then
    A0_2 = CurrentHouse
  end
  if not A0_2 then
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
  L2_2 = L2_2[A0_2]
  if not L2_2 then
    L3_2 = print
    L4_2 = "houseData not found"
    return L3_2(L4_2)
  end
  L3_2 = Config
  L3_2 = L3_2.RequireOwnerOnline
  if L3_2 then
    L3_2 = lib
    L3_2 = L3_2.callback
    L3_2 = L3_2.await
    L4_2 = "housing:isOwnerOnline"
    L5_2 = false
    L6_2 = A0_2
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    if not L3_2 then
      L4_2 = Notification
      L5_2 = i18n
      L5_2 = L5_2.t
      L6_2 = "robbery.owner_not_online"
      L5_2 = L5_2(L6_2)
      L6_2 = "error"
      return L4_2(L5_2, L6_2)
    end
  end
  L3_2 = L2_2.mlo
  if L3_2 then
    L3_2 = GetMLONearbyDoor
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    if not L3_2 then
      L3_2 = Notification
      L4_2 = i18n
      L4_2 = L4_2.t
      L5_2 = "no_doors"
      L4_2 = L4_2(L5_2)
      L5_2 = "error"
      return L3_2(L4_2, L5_2)
    end
  else
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
    if L3_2 > 1 then
      L4_2 = Notification
      L5_2 = i18n
      L5_2 = L5_2.t
      L6_2 = "house_not_found"
      L5_2 = L5_2(L6_2)
      L6_2 = "error"
      return L4_2(L5_2, L6_2)
    end
  end
  L3_2 = L2_2.IsRaming
  if nil == L3_2 then
    L3_2 = Config
    L3_2 = L3_2.Houses
    L3_2 = L3_2[A0_2]
    L3_2.IsRaming = false
  end
  L3_2 = L2_2.mlo
  if not L3_2 then
    L3_2 = L2_2.locked
    if not L3_2 then
      goto lbl_125
    end
  end
  L3_2 = L2_2.IsRaming
  if not L3_2 then
    L3_2 = DoRamAnimation
    L4_2 = true
    L3_2(L4_2)
    L3_2 = L4_1
    L4_2 = A0_2
    L3_2(L4_2)
    L3_2 = TriggerServerEvent
    L4_2 = "qb-houses:server:SetRamState"
    L5_2 = true
    L6_2 = A0_2
    L3_2(L4_2, L5_2, L6_2)
  else
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "force_door"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
    goto lbl_132
    ::lbl_125::
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "already_open"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  end
  ::lbl_132::
end
RamDoor = L5_1
L5_1 = RegisterNetEvent
L6_1 = "qb-houses:client:HomeInvasion"
L5_1(L6_1)
L5_1 = AddEventHandler
L6_1 = "qb-houses:client:HomeInvasion"
function L7_1()
  local L0_2, L1_2, L2_2
  L0_2 = CurrentHouse
  if not L0_2 then
    L0_2 = Notification
    L1_2 = i18n
    L1_2 = L1_2.t
    L2_2 = "house_not_found"
    L1_2 = L1_2(L2_2)
    L2_2 = "error"
    return L0_2(L1_2, L2_2)
  end
  L0_2 = Config
  L0_2 = L0_2.Houses
  L1_2 = CurrentHouse
  L0_2 = L0_2[L1_2]
  if not L0_2 then
    L1_2 = print
    L2_2 = "houseData not found"
    return L1_2(L2_2)
  end
  L1_2 = L0_2.apartmentNumber
  if L1_2 then
    L1_2 = OpenApartmentMenu
    L2_2 = "police"
    L1_2(L2_2)
  else
    L1_2 = RamDoor
    L1_2()
  end
end
L5_1(L6_1, L7_1)
function L5_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L2_2 = cache
  L2_2 = L2_2.ped
  L3_2 = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
  L4_2 = "machinic_loop_mechandplayer"
  L5_2 = Config
  L5_2 = L5_2.Houses
  L5_2 = L5_2[A0_2]
  if not L5_2 then
    L6_2 = print
    L7_2 = "houseData not found"
    return L6_2(L7_2)
  end
  L6_2 = table
  L6_2 = L6_2.includes
  L7_2 = L5_2.upgrades
  L8_2 = "alarm"
  L6_2 = L6_2(L7_2, L8_2)
  if L6_2 then
    L7_2 = L2_1
    L8_2 = A0_2
    L7_2(L8_2)
  end
  if A1_2 then
    L7_2 = RequestAnimDict
    L8_2 = L3_2
    L7_2(L8_2)
    while true do
      L7_2 = HasAnimDictLoaded
      L8_2 = L3_2
      L7_2 = L7_2(L8_2)
      if L7_2 then
        break
      end
      L7_2 = Citizen
      L7_2 = L7_2.Wait
      L8_2 = 1
      L7_2(L8_2)
    end
    L7_2 = TaskPlayAnim
    L8_2 = L2_2
    L9_2 = L3_2
    L10_2 = L4_2
    L11_2 = 8.0
    L12_2 = 8.0
    L13_2 = -1
    L14_2 = 1
    L15_2 = -1
    L16_2 = false
    L17_2 = false
    L18_2 = false
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  else
    L7_2 = ClearPedTasksImmediately
    L8_2 = L2_2
    L7_2(L8_2)
  end
end
DoLockpickAnimation = L5_1
function L5_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = Config
  L1_2 = L1_2.Houses
  L1_2 = L1_2[A0_2]
  L2_2 = L1_2.mlo
  if not L2_2 then
    L2_2 = nil
    return L2_2
  end
  L2_2 = pairs
  L3_2 = L1_2.mlo
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = GetEntityCoords
    L9_2 = cache
    L9_2 = L9_2.ped
    L8_2 = L8_2(L9_2)
    L9_2 = vec3
    L10_2 = L7_2.coords
    L10_2 = L10_2.x
    L11_2 = L7_2.coords
    L11_2 = L11_2.y
    L12_2 = L7_2.coords
    L12_2 = L12_2.z
    L9_2 = L9_2(L10_2, L11_2, L12_2)
    L8_2 = L8_2 - L9_2
    L8_2 = #L8_2
    if L8_2 < 2.0 then
      L9_2 = L7_2.locked
      if L9_2 then
        return L6_2
      end
    end
  end
  L2_2 = nil
  return L2_2
end
GetMLONearbyDoor = L5_1
function L5_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  if A1_2 then
    L2_2 = Config
    L2_2 = L2_2.Houses
    L2_2 = L2_2[A0_2]
    L3_2 = DoLockpickAnimation
    L4_2 = A0_2
    L5_2 = false
    L3_2(L4_2, L5_2)
    L3_2 = L2_2.mlo
    if L3_2 then
      L3_2 = table
      L3_2 = L3_2.find
      L4_2 = L2_2.mlo
      function L5_2(A0_3)
        local L1_3, L2_3, L3_3, L4_3
        L1_3 = vec3
        L2_3 = A0_3.coords
        L2_3 = L2_3.x
        L3_3 = A0_3.coords
        L3_3 = L3_3.y
        L4_3 = A0_3.coords
        L4_3 = L4_3.z
        L1_3 = L1_3(L2_3, L3_3, L4_3)
        L2_3 = GetEntityCoords
        L3_3 = cache
        L3_3 = L3_3.ped
        L2_3 = L2_3(L3_3)
        L2_3 = L2_3 - L1_3
        L2_3 = #L2_3
        L3_3 = Config
        L3_3 = L3_3.DoorDistance
        L3_3 = L2_3 < L3_3
        return L3_3
      end
      L3_2, L4_2 = L3_2(L4_2, L5_2)
      if not L3_2 then
        L5_2 = Notification
        L6_2 = i18n
        L6_2 = L6_2.t
        L7_2 = "no_doors"
        L6_2 = L6_2(L7_2)
        L7_2 = "error"
        return L5_2(L6_2, L7_2)
      end
      L5_2 = TriggerServerEvent
      L6_2 = "qb-houses:SyncDoor"
      L7_2 = A0_2
      L8_2 = {}
      L9_2 = L3_2
      L8_2[1] = L9_2
      L9_2 = false
      L5_2(L6_2, L7_2, L8_2, L9_2)
    else
      L3_2 = TriggerServerEvent
      L4_2 = "qb-houses:server:lockHouse"
      L5_2 = false
      L6_2 = A0_2
      L3_2(L4_2, L5_2, L6_2)
    end
    L3_2 = TriggerServerEvent
    L4_2 = "qb-houses:server:SetHouseRammed"
    L5_2 = true
    L6_2 = A0_2
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "success_lockpick"
    L4_2 = L4_2(L5_2)
    L5_2 = "success"
    L3_2(L4_2, L5_2)
  else
    L2_2 = DoLockpickAnimation
    L3_2 = A0_2
    L4_2 = false
    L2_2(L3_2, L4_2)
    L2_2 = Notification
    L3_2 = i18n
    L3_2 = L3_2.t
    L4_2 = "fail_struggle"
    L3_2 = L3_2(L4_2)
    L4_2 = "error"
    L2_2(L3_2, L4_2)
  end
end
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = lib
  L1_2 = L1_2.skillCheck
  L2_2 = {}
  L3_2 = "easy"
  L4_2 = "easy"
  L5_2 = {}
  L5_2.areaSize = 70
  L5_2.speedMultiplier = 1
  L6_2 = "easy"
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L2_2[4] = L6_2
  L3_2 = {}
  L4_2 = "z"
  L5_2 = "q"
  L6_2 = "s"
  L7_2 = "d"
  L3_2[1] = L4_2
  L3_2[2] = L5_2
  L3_2[3] = L6_2
  L3_2[4] = L7_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = L5_1
  L3_2 = A0_2
  L4_2 = L1_2
  L2_2(L3_2, L4_2)
end
function L7_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = GetEntityCoords
  L2_2 = cache
  L2_2 = L2_2.ped
  L1_2 = L1_2(L2_2)
  if not A0_2 then
    A0_2 = CurrentHouse
  end
  if not A0_2 then
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
  L2_2 = L2_2[A0_2]
  if not L2_2 then
    L3_2 = print
    L4_2 = "houseData not found"
    return L3_2(L4_2)
  end
  L3_2 = Config
  L3_2 = L3_2.RequireOwnerOnline
  if L3_2 then
    L3_2 = lib
    L3_2 = L3_2.callback
    L3_2 = L3_2.await
    L4_2 = "housing:isOwnerOnline"
    L5_2 = false
    L6_2 = A0_2
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    if not L3_2 then
      L4_2 = Notification
      L5_2 = i18n
      L5_2 = L5_2.t
      L6_2 = "robbery.owner_not_online"
      L5_2 = L5_2(L6_2)
      L6_2 = "error"
      return L4_2(L5_2, L6_2)
    end
  end
  L3_2 = L2_2.mlo
  if L3_2 then
    L3_2 = GetMLONearbyDoor
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    if not L3_2 then
      L3_2 = Notification
      L4_2 = i18n
      L4_2 = L4_2.t
      L5_2 = "no_doors"
      L4_2 = L4_2(L5_2)
      L5_2 = "error"
      return L3_2(L4_2, L5_2)
    end
  else
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
    if L3_2 > 1 then
      L4_2 = Notification
      L5_2 = i18n
      L5_2 = L5_2.t
      L6_2 = "house_not_found"
      L5_2 = L5_2(L6_2)
      L6_2 = "error"
      return L4_2(L5_2, L6_2)
    end
  end
  L3_2 = L2_2.IsRaming
  if nil == L3_2 then
    L3_2 = Config
    L3_2 = L3_2.Houses
    L3_2 = L3_2[A0_2]
    L3_2.IsRaming = false
  end
  L3_2 = L2_2.mlo
  if not L3_2 then
    L3_2 = L2_2.locked
    if not L3_2 then
      goto lbl_127
    end
  end
  L3_2 = L2_2.IsRaming
  if not L3_2 then
    L3_2 = TriggerServerEvent
    L4_2 = "housing:removeItem"
    L5_2 = Config
    L5_2 = L5_2.RobberyItem
    L6_2 = 1
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = DoLockpickAnimation
    L4_2 = A0_2
    L5_2 = true
    L3_2(L4_2, L5_2)
    L3_2 = L6_1
    L4_2 = A0_2
    L3_2(L4_2)
  else
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "force_door"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
    goto lbl_134
    ::lbl_127::
    L3_2 = Notification
    L4_2 = i18n
    L4_2 = L4_2.t
    L5_2 = "already_open"
    L4_2 = L4_2(L5_2)
    L5_2 = "error"
    L3_2(L4_2, L5_2)
  end
  ::lbl_134::
end
LockPick = L7_1
L7_1 = RegisterNetEvent
L8_1 = "qb-houses:client:lockpick"
L7_1(L8_1)
L7_1 = AddEventHandler
L8_1 = "qb-houses:client:lockpick"
function L9_1()
  local L0_2, L1_2, L2_2
  L0_2 = CurrentHouse
  if not L0_2 then
    L0_2 = Notification
    L1_2 = i18n
    L1_2 = L1_2.t
    L2_2 = "house_not_found"
    L1_2 = L1_2(L2_2)
    L2_2 = "error"
    return L0_2(L1_2, L2_2)
  end
  L0_2 = Config
  L0_2 = L0_2.Houses
  L1_2 = CurrentHouse
  L0_2 = L0_2[L1_2]
  if not L0_2 then
    L1_2 = print
    L2_2 = "houseData not found"
    return L1_2(L2_2)
  end
  L1_2 = L0_2.apartmentNumber
  if L1_2 then
    L1_2 = OpenApartmentMenu
    L2_2 = "lockpick"
    L1_2(L2_2)
  else
    L1_2 = LockPick
    L1_2()
  end
end
L7_1(L8_1, L9_1)
L7_1 = RegisterNetEvent
L8_1 = "qb-houses:client:SetRamState"
L7_1(L8_1)
L7_1 = AddEventHandler
L8_1 = "qb-houses:client:SetRamState"
function L9_1(A0_2, A1_2)
  local L2_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A1_2]
  L2_2.IsRaming = A0_2
end
L7_1(L8_1, L9_1)
L7_1 = RegisterNetEvent
L8_1 = "qb-houses:client:SetHouseRammed"
L7_1(L8_1)
L7_1 = AddEventHandler
L8_1 = "qb-houses:client:SetHouseRammed"
function L9_1(A0_2, A1_2)
  local L2_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A1_2]
  L2_2.IsRammed = A0_2
end
L7_1(L8_1, L9_1)
L7_1 = RegisterNetEvent
L8_1 = "qb-houses:client:ResetHouse"
L7_1(L8_1)
L7_1 = AddEventHandler
L8_1 = "qb-houses:client:ResetHouse"
function L9_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = cache
  L0_2 = L0_2.ped
  L1_2 = CurrentHouse
  if nil ~= L1_2 then
    L1_2 = Config
    L1_2 = L1_2.Houses
    L2_2 = CurrentHouse
    L1_2 = L1_2[L2_2]
    L1_2 = L1_2.IsRammed
    if nil == L1_2 then
      L1_2 = Config
      L1_2 = L1_2.Houses
      L2_2 = CurrentHouse
      L1_2 = L1_2[L2_2]
      L1_2.IsRammed = false
      L1_2 = TriggerServerEvent
      L2_2 = "qb-houses:server:SetHouseRammed"
      L3_2 = false
      L4_2 = CurrentHouse
      L1_2(L2_2, L3_2, L4_2)
      L1_2 = TriggerServerEvent
      L2_2 = "qb-houses:server:SetRamState"
      L3_2 = false
      L4_2 = CurrentHouse
      L1_2(L2_2, L3_2, L4_2)
    end
    L1_2 = Config
    L1_2 = L1_2.Houses
    L2_2 = CurrentHouse
    L1_2 = L1_2[L2_2]
    L1_2 = L1_2.IsRammed
    if L1_2 then
      L1_2 = DoorAnim
      L1_2()
      L1_2 = TriggerServerEvent
      L2_2 = "qb-houses:server:SetHouseRammed"
      L3_2 = false
      L4_2 = CurrentHouse
      L1_2(L2_2, L3_2, L4_2)
      L1_2 = TriggerServerEvent
      L2_2 = "qb-houses:server:SetRamState"
      L3_2 = false
      L4_2 = CurrentHouse
      L1_2(L2_2, L3_2, L4_2)
      L1_2 = TriggerServerEvent
      L2_2 = "qb-houses:server:lockHouse"
      L3_2 = true
      L4_2 = CurrentHouse
      L1_2(L2_2, L3_2, L4_2)
      RamsDone = 0
      L1_2 = Notification
      L2_2 = i18n
      L2_2 = L2_2.t
      L3_2 = "door_fixed"
      L2_2 = L2_2(L3_2)
      L3_2 = "success"
      L1_2(L2_2, L3_2)
    else
      L1_2 = Notification
      L2_2 = i18n
      L2_2 = L2_2.t
      L3_2 = "door_not_broken"
      L2_2 = L2_2(L3_2)
      L3_2 = "error"
      L1_2(L2_2, L3_2)
    end
  end
end
L7_1(L8_1, L9_1)






