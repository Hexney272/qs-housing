





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1
L0_1 = _G
L1_1 = {}
L0_1.ikeaDelivery = L1_1
L0_1 = {}
L0_1.entity = nil
L0_1.ped = nil
L0_1.house = nil
L0_1.coords = nil
L0_1.readyCount = 0
L0_1.collecting = false
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = Config
  L3_2 = L3_2.PedStreaming
  if not L3_2 then
    L3_2 = {}
  end
  L4_2 = L3_2.default
  if not L4_2 then
    L4_2 = {}
  end
  L5_2 = L3_2[A0_2]
  if not L5_2 then
    L5_2 = {}
  end
  L6_2 = L5_2.spawnDistance
  if not L6_2 then
    L6_2 = L4_2.spawnDistance
    if not L6_2 then
      L6_2 = A1_2
    end
  end
  L7_2 = L5_2.despawnDistance
  if not L7_2 then
    L7_2 = L4_2.despawnDistance
    if not L7_2 then
      L7_2 = A2_2
    end
  end
  if L6_2 >= L7_2 then
    L7_2 = L6_2 + 5.0
  end
  L8_2 = L6_2
  L9_2 = L7_2
  return L8_2, L9_2
end
L2_1 = {}
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = lib
  L1_2 = L1_2.callback
  L1_2 = L1_2.await
  L2_2 = "housing:getIkeaDeliveryState"
  L3_2 = false
  L4_2 = A0_2
  return L1_2(L2_2, L3_2, L4_2)
end
L2_1.getState = L3_1
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = lib
  L2_2 = L2_2.callback
  L3_2 = "housing:collectIkeaFurnitureOrders"
  L4_2 = false
  L5_2 = A1_2
  L6_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2)
end
L2_1.collect = L3_1
L3_1 = {}
function L4_1()
  local L0_2, L1_2
  L0_2 = L0_1.entity
  if L0_2 then
    L0_2 = DoesEntityExist
    L1_2 = L0_1.entity
    L0_2 = L0_2(L1_2)
    if L0_2 then
      L0_2 = DeleteEntity
      L1_2 = L0_1.entity
      L0_2(L1_2)
    end
  end
  L0_2 = L0_1.ped
  if L0_2 then
    L0_2 = DoesEntityExist
    L1_2 = L0_1.ped
    L0_2 = L0_2(L1_2)
    if L0_2 then
      L0_2 = DeleteEntity
      L1_2 = L0_1.ped
      L0_2(L1_2)
    end
  end
  L0_1.entity = nil
  L0_1.ped = nil
  L0_1.house = nil
  L0_1.coords = nil
  L0_1.readyCount = 0
  L0_1.collecting = false
end
L3_1.clearEntity = L4_1
function L4_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2
  L3_2 = Config
  L3_2 = L3_2.IkeaDeliveryBoxModel
  if not L3_2 then
    L3_2 = "v_ind_meatboxsml_02"
  end
  L4_2 = Config
  L4_2 = L4_2.IkeaDeliveryPedModel
  if not L4_2 then
    L4_2 = "s_m_m_dockwork_01"
  end
  L5_2 = Config
  L5_2 = L5_2.IkeaDeliveryPedAnim
  if not L5_2 then
    L5_2 = {}
    L5_2.dict = "anim@heists@box_carry@"
    L5_2.name = "idle"
  end
  L6_2 = Config
  L6_2 = L6_2.IkeaDeliveryPedAttach
  if not L6_2 then
    L6_2 = {}
  end
  L7_2 = vec3
  L8_2 = A1_2.x
  L9_2 = A1_2.y
  L10_2 = A1_2.z
  L7_2 = L7_2(L8_2, L9_2, L10_2)
  L8_2 = A1_2.w
  if not L8_2 then
    L8_2 = 0.0
  end
  L9_2 = L0_1.entity
  if L9_2 then
    L9_2 = DoesEntityExist
    L10_2 = L0_1.entity
    L9_2 = L9_2(L10_2)
    if L9_2 then
      L9_2 = L0_1.ped
      if L9_2 then
        L9_2 = DoesEntityExist
        L10_2 = L0_1.ped
        L9_2 = L9_2(L10_2)
        if L9_2 then
          L9_2 = L0_1.house
          if L9_2 == A0_2 then
            L9_2 = L0_1.coords
            if L9_2 then
              L9_2 = L0_1.coords
              L9_2 = L9_2 - L7_2
              L9_2 = #L9_2
              L10_2 = 0.05
              if L9_2 < L10_2 then
                L0_1.readyCount = A2_2
                return
              end
            end
          end
          L9_2 = L3_1.clearEntity
          L9_2()
        end
      end
    end
  end
  L9_2 = joaat
  L10_2 = L3_2
  L9_2 = L9_2(L10_2)
  L10_2 = joaat
  L11_2 = L4_2
  L10_2 = L10_2(L11_2)
  L11_2 = lib
  L11_2 = L11_2.requestModel
  L12_2 = L9_2
  L13_2 = Config
  L13_2 = L13_2.DefaultRequestModelTimeout
  L11_2(L12_2, L13_2)
  L11_2 = lib
  L11_2 = L11_2.requestModel
  L12_2 = L10_2
  L13_2 = Config
  L13_2 = L13_2.DefaultRequestModelTimeout
  L11_2(L12_2, L13_2)
  L11_2 = CreatePed
  L12_2 = 4
  L13_2 = L10_2
  L14_2 = L7_2.x
  L15_2 = L7_2.y
  L16_2 = L7_2.z
  L16_2 = L16_2 - 1.0
  L17_2 = L8_2
  L18_2 = false
  L19_2 = false
  L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  L12_2 = SetEntityAsMissionEntity
  L13_2 = L11_2
  L14_2 = true
  L15_2 = true
  L12_2(L13_2, L14_2, L15_2)
  L12_2 = SetBlockingOfNonTemporaryEvents
  L13_2 = L11_2
  L14_2 = true
  L12_2(L13_2, L14_2)
  L12_2 = FreezeEntityPosition
  L13_2 = L11_2
  L14_2 = true
  L12_2(L13_2, L14_2)
  L12_2 = SetEntityInvincible
  L13_2 = L11_2
  L14_2 = true
  L12_2(L13_2, L14_2)
  L12_2 = SetPedCanRagdoll
  L13_2 = L11_2
  L14_2 = false
  L12_2(L13_2, L14_2)
  L12_2 = SetEntityHeading
  L13_2 = L11_2
  L14_2 = L8_2
  L12_2(L13_2, L14_2)
  L12_2 = L5_2.dict
  if L12_2 then
    L12_2 = L5_2.name
    if L12_2 then
      L12_2 = lib
      L12_2 = L12_2.requestAnimDict
      L13_2 = L5_2.dict
      L12_2(L13_2)
      L12_2 = TaskPlayAnim
      L13_2 = L11_2
      L14_2 = L5_2.dict
      L15_2 = L5_2.name
      L16_2 = 8.0
      L17_2 = -8.0
      L18_2 = -1
      L19_2 = 1
      L20_2 = 0
      L21_2 = false
      L22_2 = false
      L23_2 = false
      L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
    end
  end
  L12_2 = CreateObject
  L13_2 = L9_2
  L14_2 = L7_2.x
  L15_2 = L7_2.y
  L16_2 = L7_2.z
  L17_2 = false
  L18_2 = false
  L19_2 = false
  L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  L13_2 = SetEntityAsMissionEntity
  L14_2 = L12_2
  L15_2 = true
  L16_2 = true
  L13_2(L14_2, L15_2, L16_2)
  L13_2 = SetEntityInvincible
  L14_2 = L12_2
  L15_2 = true
  L13_2(L14_2, L15_2)
  L13_2 = SetEntityCompletelyDisableCollision
  L14_2 = L12_2
  L15_2 = true
  L16_2 = false
  L13_2(L14_2, L15_2, L16_2)
  L13_2 = tonumber
  L14_2 = L6_2.bone
  L13_2 = L13_2(L14_2)
  if not L13_2 then
    L13_2 = 18905
  end
  L14_2 = L6_2.pos
  if not L14_2 then
    L14_2 = vec3
    L15_2 = 0.11
    L16_2 = -0.02
    L17_2 = -0.02
    L14_2 = L14_2(L15_2, L16_2, L17_2)
  end
  L15_2 = L6_2.rot
  if not L15_2 then
    L15_2 = vec3
    L16_2 = -35.0
    L17_2 = 0.0
    L18_2 = 20.0
    L15_2 = L15_2(L16_2, L17_2, L18_2)
  end
  L16_2 = AttachEntityToEntity
  L17_2 = L12_2
  L18_2 = L11_2
  L19_2 = GetPedBoneIndex
  L20_2 = L11_2
  L21_2 = L13_2
  L19_2 = L19_2(L20_2, L21_2)
  L20_2 = L14_2.x
  if not L20_2 then
    L20_2 = 0.11
  end
  L21_2 = L14_2.y
  if not L21_2 then
    L21_2 = -0.02
  end
  L22_2 = L14_2.z
  if not L22_2 then
    L22_2 = -0.02
  end
  L23_2 = L15_2.x
  if not L23_2 then
    L23_2 = -35.0
  end
  L24_2 = L15_2.y
  if not L24_2 then
    L24_2 = 0.0
  end
  L25_2 = L15_2.z
  if not L25_2 then
    L25_2 = 20.0
  end
  L26_2 = false
  L27_2 = false
  L28_2 = false
  L29_2 = false
  L30_2 = 2
  L31_2 = true
  L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2)
  L16_2 = SetModelAsNoLongerNeeded
  L17_2 = L9_2
  L16_2(L17_2)
  L16_2 = SetModelAsNoLongerNeeded
  L17_2 = L10_2
  L16_2(L17_2)
  L0_1.entity = L12_2
  L0_1.ped = L11_2
  L0_1.house = A0_2
  L0_1.coords = L7_2
  L0_1.readyCount = A2_2
end
L3_1.spawnOrUpdate = L4_1
L4_1 = ikeaDelivery
function L5_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = Config
  L1_2 = L1_2.IkeaDeliveryEnabled
  if false == L1_2 then
    L1_2 = L3_1.clearEntity
    L1_2()
    return
  end
  L1_2 = A0_2 or L1_2
  if not A0_2 then
    L1_2 = CurrentHouse
  end
  if L1_2 then
    L2_2 = CurrentHouseData
    L2_2 = L2_2.haskey
    if L2_2 then
      goto lbl_20
    end
  end
  L2_2 = L3_1.clearEntity
  L2_2()
  do return end
  ::lbl_20::
  L2_2 = L2_1.getState
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L3_2 = L2_2.enabled
    if L3_2 then
      L3_2 = L2_2.hasPoint
      if L3_2 then
        L3_2 = L2_2.readyCount
        if not L3_2 then
          L3_2 = 0
        end
        if not (L3_2 <= 0) then
          L3_2 = L2_2.point
          if L3_2 then
            goto lbl_64
          end
        end
      end
    end
  end
  if L2_2 then
    L3_2 = L2_2.enabled
    if L3_2 then
      L3_2 = L2_2.hasPoint
      if false == L3_2 then
        L3_2 = L2_2.readyCount
        if not L3_2 then
          L3_2 = 0
        end
        if L3_2 > 0 then
          L3_2 = Notification
          L4_2 = i18n
          L4_2 = L4_2.t
          L5_2 = "delivery.ikea_point_missing"
          L4_2 = L4_2(L5_2)
          L5_2 = "info"
          L3_2(L4_2, L5_2)
        end
      end
    end
  end
  L3_2 = L3_1.clearEntity
  L3_2()
  do return end
  ::lbl_64::
  L3_2 = L1_1
  L4_2 = "ikeaDelivery"
  L5_2 = 55.0
  L6_2 = 65.0
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = GetEntityCoords
  L5_2 = cache
  L5_2 = L5_2.ped
  L4_2 = L4_2(L5_2)
  L5_2 = vec3
  L6_2 = L2_2.point
  L6_2 = L6_2.x
  L7_2 = L2_2.point
  L7_2 = L7_2.y
  L8_2 = L2_2.point
  L8_2 = L8_2.z
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L6_2 = L4_2 - L5_2
  L6_2 = #L6_2
  if L3_2 < L6_2 then
    L7_2 = L0_1.entity
    if not L7_2 then
      L7_2 = L0_1.ped
      if not L7_2 then
        goto lbl_94
      end
    end
    L7_2 = L3_1.clearEntity
    L7_2()
    ::lbl_94::
    return
  end
  L7_2 = L3_1.spawnOrUpdate
  L8_2 = L1_2
  L9_2 = L2_2.point
  L10_2 = L2_2.readyCount
  L7_2(L8_2, L9_2, L10_2)
end
L4_1.sync = L5_1
L4_1 = {}
function L5_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2
  L3_2 = Config
  L3_2 = L3_2.IkeaDeliveryEnabled
  if false == L3_2 then
    return
  end
  L3_2 = CurrentHouse
  if L3_2 ~= A0_2 then
    return
  end
  if A2_2 then
    L3_2 = A1_2 or L3_2
    if not A1_2 then
      L3_2 = 0
    end
    if not (L3_2 <= 0) then
      goto lbl_20
    end
  end
  L3_2 = L3_1.clearEntity
  L3_2()
  do return end
  ::lbl_20::
  L3_2 = ikeaDelivery
  L3_2 = L3_2.sync
  L4_2 = A0_2
  L3_2(L4_2)
end
L4_1.onReady = L5_1
function L5_1(A0_2)
  local L1_2
  if A0_2 then
    L1_2 = CurrentHouse
    if L1_2 == A0_2 then
      goto lbl_7
    end
  end
  do return end
  ::lbl_7::
  L1_2 = L3_1.clearEntity
  L1_2()
end
L4_1.onCollected = L5_1
function L5_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2
  if 8 ~= A2_2 then
    return
  end
  if A0_2 then
    L3_2 = CurrentHouse
    if L3_2 == A0_2 then
      goto lbl_10
    end
  end
  do return end
  ::lbl_10::
  L3_2 = CreateThread
  function L4_2()
    local L0_3, L1_3
    L0_3 = Wait
    L1_3 = 200
    L0_3(L1_3)
    L0_3 = ikeaDelivery
    L0_3 = L0_3.sync
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L3_2(L4_2)
end
L4_1.onLocationRefresh = L5_1
L5_1 = RegisterNetEvent
L6_1 = "housing:ikeaDeliveryReady"
L7_1 = L4_1.onReady
L5_1(L6_1, L7_1)
L5_1 = RegisterNetEvent
L6_1 = "housing:ikeaDeliveryCollected"
L7_1 = L4_1.onCollected
L5_1(L6_1, L7_1)
L5_1 = RegisterNetEvent
L6_1 = "qb-houses:client:refreshLocations"
L7_1 = L4_1.onLocationRefresh
L5_1(L6_1, L7_1)
L5_1 = AddEventHandler
L6_1 = "housing:onEnterHouse"
function L7_1(A0_2)
  local L1_2, L2_2
  L1_2 = ikeaDelivery
  L1_2 = L1_2.sync
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1)
L5_1 = AddEventHandler
L6_1 = "housing:onExitHouse"
function L7_1()
  local L0_2, L1_2
  L0_2 = L3_1.clearEntity
  L0_2()
end
L5_1(L6_1, L7_1)
L5_1 = AddEventHandler
L6_1 = "housing:handleEnterZone"
function L7_1(A0_2)
  local L1_2, L2_2
  L1_2 = ikeaDelivery
  L1_2 = L1_2.sync
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1)
L5_1 = AddEventHandler
L6_1 = "housing:handleExitZone"
function L7_1()
  local L0_2, L1_2
  L0_2 = L3_1.clearEntity
  L0_2()
end
L5_1(L6_1, L7_1)
L5_1 = CreateThread
function L6_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L0_2 = 0
  while true do
    L1_2 = 1000
    L2_2 = L0_1.entity
    if L2_2 then
      L2_2 = L0_1.ped
      if L2_2 then
        L2_2 = DoesEntityExist
        L3_2 = L0_1.entity
        L2_2 = L2_2(L3_2)
        if L2_2 then
          L2_2 = DoesEntityExist
          L3_2 = L0_1.ped
          L2_2 = L2_2(L3_2)
          if L2_2 then
            goto lbl_38
          end
        end
      end
    end
    L2_2 = CurrentHouse
    if L2_2 then
      L2_2 = CurrentHouseData
      L2_2 = L2_2.haskey
      if L2_2 then
        L2_2 = GetGameTimer
        L2_2 = L2_2()
        L3_2 = L2_2 - L0_2
        L4_2 = 3000
        if L3_2 >= L4_2 then
          L3_2 = ikeaDelivery
          L3_2 = L3_2.sync
          L4_2 = CurrentHouse
          L3_2(L4_2)
          L0_2 = L2_2
        end
      end
    end
    ::lbl_38::
    L2_2 = L0_1.entity
    if L2_2 then
      L2_2 = DoesEntityExist
      L3_2 = L0_1.entity
      L2_2 = L2_2(L3_2)
      if L2_2 then
        L2_2 = L0_1.ped
        if L2_2 then
          L2_2 = DoesEntityExist
          L3_2 = L0_1.ped
          L2_2 = L2_2(L3_2)
          if L2_2 then
            L2_2 = L0_1.coords
            if L2_2 then
              L2_2 = CurrentHouse
              L3_2 = L0_1.house
              if L2_2 == L3_2 then
                L2_2 = Config
                L2_2 = L2_2.IkeaDeliveryPedAnim
                if not L2_2 then
                  L2_2 = {}
                  L2_2.dict = "anim@heists@box_carry@"
                  L2_2.name = "idle"
                end
                L3_2 = GetEntityCoords
                L4_2 = cache
                L4_2 = L4_2.ped
                L3_2 = L3_2(L4_2)
                L4_2 = L0_1.coords
                L4_2 = L3_2 - L4_2
                L4_2 = #L4_2
                L5_2 = L1_1
                L6_2 = "ikeaDelivery"
                L7_2 = 55.0
                L8_2 = 65.0
                L5_2, L6_2 = L5_2(L6_2, L7_2, L8_2)
                if L4_2 >= L6_2 then
                  L7_2 = L3_1.clearEntity
                  L7_2()
                else
                  L7_2 = L2_2.dict
                  if L7_2 then
                    L7_2 = L2_2.name
                    if L7_2 then
                      L7_2 = IsEntityPlayingAnim
                      L8_2 = L0_1.ped
                      L9_2 = L2_2.dict
                      L10_2 = L2_2.name
                      L11_2 = 3
                      L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
                      if not L7_2 then
                        L7_2 = lib
                        L7_2 = L7_2.requestAnimDict
                        L8_2 = L2_2.dict
                        L7_2(L8_2)
                        L7_2 = TaskPlayAnim
                        L8_2 = L0_1.ped
                        L9_2 = L2_2.dict
                        L10_2 = L2_2.name
                        L11_2 = 8.0
                        L12_2 = -8.0
                        L13_2 = -1
                        L14_2 = 1
                        L15_2 = 0
                        L16_2 = false
                        L17_2 = false
                        L18_2 = false
                        L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
                      end
                    end
                  end
                  if L4_2 < 2.0 then
                    L1_2 = 0
                    L7_2 = DrawText3D
                    L8_2 = L0_1.coords
                    L8_2 = L8_2.x
                    L9_2 = L0_1.coords
                    L9_2 = L9_2.y
                    L10_2 = L0_1.coords
                    L10_2 = L10_2.z
                    L10_2 = L10_2 + 0.35
                    L11_2 = i18n
                    L11_2 = L11_2.t
                    L12_2 = "drawtext.collect_ikea_delivery"
                    L11_2 = L11_2(L12_2)
                    L12_2 = "collect_ikea_delivery"
                    L13_2 = "E"
                    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
                    L7_2 = IsControlJustPressed
                    L8_2 = 0
                    L9_2 = Keys
                    L9_2 = L9_2.E
                    L7_2 = L7_2(L8_2, L9_2)
                    if L7_2 then
                      L7_2 = L0_1.collecting
                      if not L7_2 then
                        L0_1.collecting = true
                        L7_2 = CurrentHouse
                        if not L7_2 then
                          L0_1.collecting = false
                        else
                          L8_2 = L2_1.collect
                          L9_2 = L7_2
                          function L10_2(A0_3)
                            local L1_3, L2_3, L3_3
                            if A0_3 then
                              L1_3 = Notification
                              L2_3 = i18n
                              L2_3 = L2_3.t
                              L3_3 = "delivery.collected"
                              L2_3 = L2_3(L3_3)
                              L3_3 = "success"
                              L1_3(L2_3, L3_3)
                              L1_3 = L3_1.clearEntity
                              L1_3()
                            else
                              L1_3 = Notification
                              L2_3 = i18n
                              L2_3 = L2_3.t
                              L3_3 = "delivery.no_delivered_orders"
                              L2_3 = L2_3(L3_3)
                              L3_3 = "info"
                              L1_3(L2_3, L3_3)
                            end
                            L0_1.collecting = false
                          end
                          L8_2(L9_2, L10_2)
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
    L2_2 = Wait
    L3_2 = L1_2
    L2_2(L3_2)
  end
end
L5_1(L6_1)
L5_1 = AddEventHandler
L6_1 = "onResourceStop"
function L7_1(A0_2)
  local L1_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 ~= L1_2 then
    return
  end
  L1_2 = L3_1.clearEntity
  L1_2()
end
L5_1(L6_1, L7_1)






