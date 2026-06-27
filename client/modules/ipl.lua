





local L0_1, L1_1, L2_1
CreatorStartedPosition = nil
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L1_2 = A0_2 or nil
  if not A0_2 then
    L1_2 = 1
  end
  L2_2 = Config
  L2_2 = L2_2.IplData
  L2_2 = L2_2[L1_2]
  if L2_2 then
    L2_2 = L2_2.export
  end
  L3_2 = Config
  L3_2 = L3_2.IplData
  L3_2 = L3_2[L1_2]
  L4_2 = L3_2.defaultTheme
  if L4_2 then
    L4_2 = L2_2
    L4_2 = L4_2()
    L2_2 = L4_2
    L4_2 = L2_2.Style
    L4_2 = L4_2.Set
    L5_2 = L2_2.Style
    L5_2 = L5_2.Theme
    L6_2 = L3_2.defaultTheme
    L5_2 = L5_2[L6_2]
    L6_2 = true
    L4_2(L5_2, L6_2)
  end
  L4_2 = DoScreenFadeOut
  L5_2 = 300
  L4_2(L5_2)
  L4_2 = cache
  L4_2 = L4_2.ped
  L5_2 = Wait
  L6_2 = 500
  L5_2(L6_2)
  L5_2 = Config
  L5_2 = L5_2.IplData
  L5_2 = L5_2[L1_2]
  L5_2 = L5_2.iplCoords
  if not L5_2 then
    return
  end
  L6_2 = Wait
  L7_2 = 300
  L6_2(L7_2)
  L6_2 = SetEntityVisible
  L7_2 = L4_2
  L8_2 = false
  L6_2(L7_2, L8_2)
  L6_2 = SetEntityCoords
  L7_2 = L4_2
  L8_2 = vec3
  L9_2 = L5_2.x
  L10_2 = L5_2.y
  L11_2 = L5_2.z
  L11_2 = L11_2 + 1.0
  L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L8_2(L9_2, L10_2, L11_2)
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L6_2 = ClearFocus
  L6_2()
  L6_2 = vector3
  L7_2 = 0.0
  L8_2 = 0.0
  L9_2 = 0.0
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L7_2 = Utils
  L7_2 = L7_2.CreateCamera
  L8_2 = "DEFAULT_SCRIPTED_CAMERA"
  L9_2 = vec3
  L10_2 = L5_2.x
  L11_2 = L5_2.y
  L12_2 = L5_2.z
  L12_2 = L12_2 + 1.0
  L9_2 = L9_2(L10_2, L11_2, L12_2)
  L10_2 = L6_2
  L11_2 = true
  L12_2 = false
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
  L8_2 = DoScreenFadeIn
  L9_2 = 200
  L8_2(L9_2)
  function L8_2()
    local L0_3, L1_3, L2_3
    L0_3 = DoScreenFadeOut
    L1_3 = 300
    L0_3(L1_3)
    L0_3 = Wait
    L1_3 = 500
    L0_3(L1_3)
    L0_3 = SetEntityCoords
    L1_3 = L4_2
    L2_3 = CreatorStartedPosition
    L0_3(L1_3, L2_3)
    L0_3 = SetEntityVisible
    L1_3 = L4_2
    L2_3 = true
    L0_3(L1_3, L2_3)
    L0_3 = EnableAllControlActions
    L1_3 = 0
    L0_3(L1_3)
    L0_3 = Utils
    L0_3 = L0_3.DestroyFlyCam
    L1_3 = L7_2
    L0_3(L1_3)
    L0_3 = Wait
    L1_3 = 1000
    L0_3(L1_3)
    L0_3 = DoScreenFadeIn
    L1_3 = 300
    L0_3(L1_3)
    L0_3 = L1_2
    return L0_3
  end
  L9_2 = Utils
  L9_2 = L9_2.GetControls
  L10_2 = {}
  L11_2 = "rightApt"
  L12_2 = "done"
  L13_2 = "cancel"
  L14_2 = "leftApt"
  L10_2[1] = L11_2
  L10_2[2] = L12_2
  L10_2[3] = L13_2
  L10_2[4] = L14_2
  L9_2 = L9_2(L10_2)
  L10_2 = Utils
  L10_2 = L10_2.CreateInstructional
  L11_2 = L9_2
  L10_2 = L10_2(L11_2)
  L11_2 = L1_2 + 1
  L12_2 = Config
  L12_2 = L12_2.IplData
  L12_2 = #L12_2
  if L11_2 > L12_2 then
    L11_2 = 1
    if L11_2 then
      goto lbl_110
    end
  end
  L11_2 = L1_2 + 1
  ::lbl_110::
  L12_2 = L1_2 - 1
  if L12_2 < 1 then
    L12_2 = Config
    L12_2 = L12_2.IplData
    L12_2 = #L12_2
    if L12_2 then
      goto lbl_121
    end
  end
  L12_2 = L1_2 - 1
  ::lbl_121::
  EnabledMouseMovement = true
  while L7_2 do
    L13_2 = Utils
    L13_2 = L13_2.HandleFlyCam
    L14_2 = L7_2
    L15_2 = {}
    L15_2.mouse = true
    L15_2.keyboard = false
    L13_2(L14_2, L15_2)
    L13_2 = IsDisabledControlJustPressed
    L14_2 = 0
    L15_2 = ActionControls
    L15_2 = L15_2.done
    L15_2 = L15_2.codes
    L15_2 = L15_2[1]
    L13_2 = L13_2(L14_2, L15_2)
    if L13_2 then
      L13_2 = L8_2
      return L13_2()
    end
    L13_2 = IsDisabledControlPressed
    L14_2 = 0
    L15_2 = ActionControls
    L15_2 = L15_2.cancel
    L15_2 = L15_2.codes
    L15_2 = L15_2[1]
    L13_2 = L13_2(L14_2, L15_2)
    if not L13_2 then
      L13_2 = IsDisabledControlJustPressed
      L14_2 = 0
      L15_2 = 322
      L13_2 = L13_2(L14_2, L15_2)
      if not L13_2 then
        goto lbl_185
      end
    end
    L13_2 = DoScreenFadeOut
    L14_2 = 300
    L13_2(L14_2)
    L13_2 = Wait
    L14_2 = 1000
    L13_2(L14_2)
    L13_2 = Utils
    L13_2 = L13_2.DestroyFlyCam
    L14_2 = L7_2
    L13_2(L14_2)
    L13_2 = SetEntityCoords
    L14_2 = L4_2
    L15_2 = CreatorStartedPosition
    L13_2(L14_2, L15_2)
    L13_2 = SetEntityVisible
    L14_2 = L4_2
    L15_2 = true
    L13_2(L14_2, L15_2)
    L13_2 = Wait
    L14_2 = 500
    L13_2(L14_2)
    L13_2 = DoScreenFadeIn
    L14_2 = 300
    L13_2(L14_2)
    L13_2 = nil
    do return L13_2 end
    ::lbl_185::
    L13_2 = IsDisabledControlPressed
    L14_2 = 0
    L15_2 = Keys
    L15_2 = L15_2.LEFT
    L13_2 = L13_2(L14_2, L15_2)
    if L13_2 then
      L13_2 = DoScreenFadeOut
      L14_2 = 300
      L13_2(L14_2)
      L13_2 = Wait
      L14_2 = 500
      L13_2(L14_2)
      L13_2 = Utils
      L13_2 = L13_2.DestroyFlyCam
      L14_2 = L7_2
      L13_2(L14_2)
      L13_2 = showCaseOfIplHouse
      L14_2 = L12_2
      return L13_2(L14_2)
    end
    L13_2 = IsDisabledControlPressed
    L14_2 = 0
    L15_2 = Keys
    L15_2 = L15_2.RIGHT
    L13_2 = L13_2(L14_2, L15_2)
    if L13_2 then
      L13_2 = DoScreenFadeOut
      L14_2 = 300
      L13_2(L14_2)
      L13_2 = Wait
      L14_2 = 500
      L13_2(L14_2)
      L13_2 = Utils
      L13_2 = L13_2.DestroyFlyCam
      L14_2 = L7_2
      L13_2(L14_2)
      L13_2 = showCaseOfIplHouse
      L14_2 = L11_2
      return L13_2(L14_2)
    end
    L13_2 = Utils
    L13_2 = L13_2.DrawScaleform
    L14_2 = L10_2
    L13_2(L14_2)
    L13_2 = Wait
    L14_2 = 0
    L13_2(L14_2)
  end
end
showCaseOfIplHouse = L0_1
L0_1 = RegisterNetEvent
L1_1 = "qb-houses:UpdateTheme"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = DoScreenFadeOut
  L3_2 = 300
  L2_2(L3_2)
  L2_2 = Wait
  L3_2 = 500
  L2_2(L3_2)
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A1_2]
  L2_2 = L2_2.ipl
  L3_2 = Config
  L3_2 = L3_2.IplData
  L4_2 = L2_2.houseName
  L3_2 = L3_2[L4_2]
  if L3_2 then
    L3_2 = L3_2.export
  end
  if L3_2 then
    L4_2 = L3_2
    L4_2 = L4_2()
    L3_2 = L4_2
    L4_2 = L3_2.Style
    L4_2 = L4_2.Set
    L5_2 = A0_2
    L6_2 = true
    L4_2(L5_2, L6_2)
  end
  L4_2 = SetEntityCoords
  L5_2 = cache
  L5_2 = L5_2.ped
  L6_2 = GetEntityCoords
  L7_2 = cache
  L7_2 = L7_2.ped
  L6_2, L7_2 = L6_2(L7_2)
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = Wait
  L5_2 = 1000
  L4_2(L5_2)
  L4_2 = DoScreenFadeIn
  L5_2 = 400
  L4_2(L5_2)
end
L0_1(L1_1, L2_1)
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = FrontCam
  if not L2_2 then
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
    L2_2 = Wait
    L3_2 = 250
    L2_2(L3_2)
    L2_2 = DoScreenFadeOut
    L3_2 = 250
    L2_2(L3_2)
    L2_2 = Wait
    L3_2 = 500
    L2_2(L3_2)
    if A1_2 then
      inOwned = false
      ShowingHouse = false
    end
    L2_2 = TriggerServerEvent
    L3_2 = "qb-houses:leaveIplHouse"
    L4_2 = EnteredHouse
    L2_2(L3_2, L4_2)
    L2_2 = Wait
    L3_2 = 250
    L2_2(L3_2)
    L2_2 = Target
    if L2_2 then
      L2_2 = Target
      L3_2 = L2_2
      L2_2 = L2_2.destroyExit
      L2_2(L3_2)
    end
    L2_2 = DoScreenFadeIn
    L3_2 = 250
    L2_2(L3_2)
    L2_2 = SetEntityCoords
    L3_2 = cache
    L3_2 = L3_2.ped
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = EnteredHouse
    L4_2 = L4_2[L5_2]
    L4_2 = L4_2.coords
    L4_2 = L4_2.enter
    L4_2 = L4_2.x
    L5_2 = Config
    L5_2 = L5_2.Houses
    L6_2 = EnteredHouse
    L5_2 = L5_2[L6_2]
    L5_2 = L5_2.coords
    L5_2 = L5_2.enter
    L5_2 = L5_2.y
    L6_2 = Config
    L6_2 = L6_2.Houses
    L7_2 = EnteredHouse
    L6_2 = L6_2[L7_2]
    L6_2 = L6_2.coords
    L6_2 = L6_2.enter
    L6_2 = L6_2.z
    L6_2 = L6_2 + 0.2
    L2_2(L3_2, L4_2, L5_2, L6_2)
    L2_2 = SetEntityHeading
    L3_2 = cache
    L3_2 = L3_2.ped
    L4_2 = Config
    L4_2 = L4_2.Houses
    L5_2 = EnteredHouse
    L4_2 = L4_2[L5_2]
    L4_2 = L4_2.coords
    L4_2 = L4_2.enter
    L4_2 = L4_2.h
    L2_2(L3_2, L4_2)
    L2_2 = TriggerServerEvent
    L3_2 = "housing:routePlayerToDefault"
    L4_2 = A0_2
    L2_2(L3_2, L4_2)
    L2_2 = TriggerServerEvent
    L3_2 = "housing:setInside"
    L4_2 = A0_2
    L5_2 = false
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = TriggerEvent
    L3_2 = "housing:onExitHouse"
    L4_2 = A0_2
    L2_2(L3_2, L4_2)
    EnteredHouse = nil
    Invited = false
    L2_2 = TriggerServerEvent
    L3_2 = "qs-housing:disableAntiTeleport"
    L2_2(L3_2)
    L2_2 = SetArtificialLightsState
    L3_2 = false
    L2_2(L3_2)
  end
end
LeaveIplHouse = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A0_2]
  if not L2_2 then
    L3_2 = print
    L4_2 = "House not found"
    L3_2(L4_2)
    return
  end
  L3_2 = L2_2.ipl
  EnteredHouse = A0_2
  L4_2 = CurrentHouse
  if not L4_2 then
    L4_2 = Debug
    L5_2 = "enterIplHouse ::: Forcing to set current house"
    L4_2(L5_2)
    L4_2 = HandleEnterPoly
    L5_2 = A0_2
    L4_2(L5_2)
  end
  L4_2 = Config
  L4_2 = L4_2.DisableInteractSound
  if not L4_2 then
    L4_2 = TriggerServerEvent
    L5_2 = "InteractSound_SV:PlayOnSource"
    L6_2 = "houses_door_open"
    L7_2 = 0.25
    L4_2(L5_2, L6_2, L7_2)
  end
  L4_2 = TriggerServerEvent
  L5_2 = "qs-housing:enableAntiTeleport"
  L4_2(L5_2)
  L4_2 = DoorAnim
  L4_2()
  L4_2 = DoScreenFadeOut
  L5_2 = 250
  L4_2(L5_2)
  L4_2 = Wait
  L5_2 = 400
  L4_2(L5_2)
  L4_2 = decorate
  L5_2 = L4_2
  L4_2 = L4_2.getObjects
  L6_2 = A0_2
  L4_2(L5_2, L6_2)
  L4_2 = CurrentHouseData
  L4_2 = L4_2.haskey
  L4_2 = Invited
  L4_2 = not L4_2 and L4_2
  L5_2 = table
  L5_2 = L5_2.includes
  L6_2 = L2_2.upgrades
  L7_2 = "sensor"
  L5_2 = L5_2(L6_2, L7_2)
  if L5_2 and L4_2 then
    L5_2 = SensorDispatch
    L5_2()
  end
  L5_2 = Config
  L5_2 = L5_2.IplData
  L6_2 = L3_2.houseName
  L5_2 = L5_2[L6_2]
  if L5_2 then
    L5_2 = L5_2.export
  end
  if L5_2 then
    L6_2 = L5_2
    L6_2 = L6_2()
    L5_2 = L6_2
    L6_2 = L5_2.Style
    L6_2 = L6_2.Set
    L7_2 = L3_2.theme
    L8_2 = true
    L6_2(L7_2, L8_2)
  end
  L6_2 = Target
  if L6_2 then
    L6_2 = Target
    L7_2 = L6_2
    L6_2 = L6_2.initExit
    L6_2(L7_2)
  end
  L6_2 = TriggerServerEvent
  L7_2 = "qb-houses:enterIplHouse"
  L8_2 = A0_2
  L6_2(L7_2, L8_2)
  L6_2 = Wait
  L7_2 = 100
  L6_2(L7_2)
  EnteringHouse = true
  L6_2 = lib
  L6_2 = L6_2.callback
  L6_2 = L6_2.await
  L7_2 = "housing:routePlayer"
  L8_2 = false
  L9_2 = A0_2
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = TriggerServerEvent
  L7_2 = "housing:setInside"
  L8_2 = A0_2
  L9_2 = true
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = Wait
  L7_2 = 100
  L6_2(L7_2)
  EnteringHouse = false
  if A1_2 then
    inOwned = true
  end
  L6_2 = SetEntityCoords
  L7_2 = cache
  L7_2 = L7_2.ped
  L8_2 = L3_2.exit
  L8_2 = L8_2.x
  L9_2 = L3_2.exit
  L9_2 = L9_2.y
  L10_2 = L3_2.exit
  L10_2 = L10_2.z
  L6_2(L7_2, L8_2, L9_2, L10_2)
  L6_2 = DoScreenFadeIn
  L7_2 = 500
  L6_2(L7_2)
  L6_2 = Wait
  L7_2 = 100
  L6_2(L7_2)
  L6_2 = decorate
  L7_2 = L6_2
  L6_2 = L6_2.getObjects
  L8_2 = A0_2
  L6_2(L7_2, L8_2)
  L6_2 = InitHouseInteractions
  L7_2 = A0_2
  L6_2(L7_2)
  L6_2 = TriggerEvent
  L7_2 = "qb-weed:client:getHousePlants"
  L8_2 = A0_2
  L6_2(L7_2, L8_2)
  L6_2 = CurrentHouseData
  L6_2 = L6_2.billsCutOff
  if not L6_2 then
    L6_2 = CurrentHouseData
    L6_2 = L6_2.lightsOn
    if L6_2 then
      goto lbl_156
    end
  end
  L6_2 = SetArtificialLightsState
  L7_2 = true
  L6_2(L7_2)
  L6_2 = SetArtificialLightsStateAffectsVehicles
  L7_2 = false
  L6_2(L7_2)
  ::lbl_156::
  L6_2 = TriggerEvent
  L7_2 = "housing:onEnterHouse"
  L8_2 = A0_2
  L6_2(L7_2, L8_2)
  L6_2 = CreateThread
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = Config
    L0_3 = L0_3.IplData
    L1_3 = L3_2.houseName
    L0_3 = L0_3[L1_3]
    L0_3 = L0_3.zone
    if not L0_3 then
      return
    end
    L1_3 = lib
    L1_3 = L1_3.zones
    L1_3 = L1_3.poly
    L2_3 = {}
    L3_3 = "ipl_zone_"
    L4_3 = A0_2
    L3_3 = L3_3 .. L4_3
    L2_3.name = L3_3
    L3_3 = L0_3.points
    L2_3.points = L3_3
    L2_3.thickness = 600.0
    L3_3 = Config
    L3_3 = L3_3.ZonesDebug
    L2_3.debug = L3_3
    function L3_3(A0_4)
      local L1_4, L2_4, L3_4, L4_4, L5_4
      L1_4 = SetEntityCoords
      L2_4 = cache
      L2_4 = L2_4.ped
      L3_4 = L3_2.exit
      L3_4 = L3_4.x
      L4_4 = L3_2.exit
      L4_4 = L4_4.y
      L5_4 = L3_2.exit
      L5_4 = L5_4.z
      L1_4(L2_4, L3_4, L4_4, L5_4)
      L1_4 = Notification
      L2_4 = i18n
      L2_4 = L2_4.t
      L3_4 = "do_not_leave_the_zone"
      L2_4 = L2_4(L3_4)
      L3_4 = "error"
      L1_4(L2_4, L3_4)
      L1_4 = Wait
      L2_4 = 100
      L1_4(L2_4)
    end
    L2_3.onExit = L3_3
    L1_3 = L1_3(L2_3)
    while true do
      L2_3 = EnteredHouse
      L3_3 = A0_2
      if L2_3 ~= L3_3 then
        break
      end
      L2_3 = Wait
      L3_3 = 0
      L2_3(L3_3)
    end
    L3_3 = L1_3
    L2_3 = L1_3.remove
    L2_3(L3_3)
  end
  L6_2(L7_2)
end
EnterIplHouse = L0_1






