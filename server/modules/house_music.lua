





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1
L0_1 = 50.0
L1_1 = {}
HousingHouseMusic = L1_1
L1_1 = {}
function L2_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = "housing_music_%s"
  L2_2 = L1_2
  L1_2 = L1_2.format
  L3_2 = A0_2
  return L1_2(L2_2, L3_2)
end
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = Config
  L1_2 = L1_2.Houses
  L1_2 = L1_2[A0_2]
  if not L1_2 then
    L2_2 = nil
    return L2_2
  end
  L2_2 = L1_2.coords
  if L2_2 then
    L2_2 = L1_2.coords
    L2_2 = L2_2.shellCoords
    if L2_2 then
      L2_2 = L1_2.coords
      L2_2 = L2_2.shellCoords
      if L2_2 then
        L3_2 = L2_2.x
        if nil ~= L3_2 then
          L3_2 = L2_2.y
          if nil ~= L3_2 then
            L3_2 = L2_2.z
            if nil ~= L3_2 then
              L3_2 = vector3
              L4_2 = L2_2.x
              L5_2 = L2_2.y
              L6_2 = L2_2.z
              return L3_2(L4_2, L5_2, L6_2)
            end
          end
        end
      end
    end
  end
  L2_2 = L1_2.ipl
  if L2_2 then
    L2_2 = L1_2.ipl
    L2_2 = L2_2.houseName
    if L2_2 then
      L2_2 = Config
      L2_2 = L2_2.IplData
      if L2_2 then
        L2_2 = Config
        L2_2 = L2_2.IplData
        L3_2 = L1_2.ipl
        L3_2 = L3_2.houseName
        L2_2 = L2_2[L3_2]
      end
      if L2_2 then
        L3_2 = L2_2.iplCoords
        if L3_2 then
          L3_2 = L2_2.iplCoords
          if L3_2 then
            L4_2 = L3_2.x
            if nil ~= L4_2 then
              L4_2 = L3_2.y
              if nil ~= L4_2 then
                L4_2 = L3_2.z
                if nil ~= L4_2 then
                  L4_2 = vector3
                  L5_2 = L3_2.x
                  L6_2 = L3_2.y
                  L7_2 = L3_2.z
                  return L4_2(L5_2, L6_2, L7_2)
                end
              end
            end
          end
        end
      end
    end
  end
  L2_2 = L1_2.coords
  if L2_2 then
    L2_2 = L1_2.coords
    L2_2 = L2_2.test
    if L2_2 then
      L2_2 = L1_2.coords
      L2_2 = L2_2.test
      if L2_2 then
        L3_2 = L2_2.x
        if nil ~= L3_2 then
          L3_2 = L2_2.y
          if nil ~= L3_2 then
            L3_2 = L2_2.z
            if nil ~= L3_2 then
              L3_2 = vector3
              L4_2 = L2_2.x
              L5_2 = L2_2.y
              L6_2 = L2_2.z
              return L3_2(L4_2, L5_2, L6_2)
            end
          end
        end
      end
    end
  end
  L2_2 = nil
  return L2_2
end
function L4_1()
  local L0_2, L1_2
  L0_2 = GetResourceState
  L1_2 = "mx-surround"
  L0_2 = L0_2(L1_2)
  if "started" == L0_2 then
    L0_2 = "mx-surround"
    return L0_2
  end
  L0_2 = GetResourceState
  L1_2 = "qs-3dsound"
  L0_2 = L0_2(L1_2)
  if "started" == L0_2 then
    L0_2 = "qs-3dsound"
    return L0_2
  end
  L0_2 = GetResourceState
  L1_2 = "xsound"
  L0_2 = L0_2(L1_2)
  if "started" == L0_2 then
    L0_2 = "xsound"
    return L0_2
  end
  L0_2 = nil
  return L0_2
end
function L5_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = ipairs
  L2_2 = {}
  L3_2 = "mx-surround"
  L4_2 = "qs-3dsound"
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = GetResourceState
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    if "started" == L7_2 then
      L7_2 = pcall
      function L8_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = exports
        L1_3 = L6_2
        L0_3 = L0_3[L1_3]
        L1_3 = L0_3
        L0_3 = L0_3.Destroy
        L2_3 = -1
        L3_3 = A0_2
        L0_3(L1_3, L2_3, L3_3)
      end
      L7_2(L8_2)
    end
  end
  L1_2 = GetResourceState
  L2_2 = "xsound"
  L1_2 = L1_2(L2_2)
  if "started" == L1_2 then
    L1_2 = pcall
    function L2_2()
      local L0_3, L1_3, L2_3, L3_3
      L0_3 = exports
      L0_3 = L0_3.xsound
      L1_3 = L0_3
      L0_3 = L0_3.Destroy
      L2_3 = -1
      L3_3 = A0_2
      L0_3(L1_3, L2_3, L3_3)
    end
    L1_2(L2_2)
  end
end
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = HousingHouseMusic
  L1_2 = L1_2[A0_2]
  if L1_2 then
    L2_2 = L1_2.soundId
    if L2_2 then
      goto lbl_11
    end
  end
  L2_2 = L2_1
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  ::lbl_11::
  L3_2 = L5_1
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = HousingHouseMusic
  L3_2[A0_2] = nil
end
HousingHouseMusicDestroyHouse = L6_1
function L6_1(A0_2)
  local L1_2, L2_2
  L1_2 = type
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if "number" ~= L1_2 or A0_2 ~= A0_2 then
    L1_2 = 0.5
    return L1_2
  end
  if A0_2 < 0 then
    L1_2 = 0.0
    return L1_2
  end
  L1_2 = 1.5
  if A0_2 > L1_2 then
    L1_2 = 1.0
    return L1_2
  end
  if A0_2 > 1.0 then
    L1_2 = A0_2 / 100.0
    return L1_2
  end
  return A0_2
end
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = Config
  L2_2 = L2_2.Houses
  L2_2 = L2_2[A1_2]
  if not L2_2 then
    L3_2 = false
    return L3_2
  end
  L3_2 = GetIdentifier
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L4_2 = false
    return L4_2
  end
  L4_2 = CheckHasKey
  L5_2 = L3_2
  L6_2 = L3_2
  L7_2 = A1_2
  L8_2 = A0_2
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  if not L4_2 then
    L4_2 = false
    return L4_2
  end
  L4_2 = L2_2.mlo
  if L4_2 then
    L4_2 = true
    return L4_2
  end
  L4_2 = true
  return L4_2
end
L8_1 = RegisterNetEvent
L9_1 = "housing:server:houseMusicPlay"
function L10_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L3_2 = source
  L4_2 = type
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  if "string" == L4_2 then
    L4_2 = type
    L5_2 = A1_2
    L4_2 = L4_2(L5_2)
    if "string" == L4_2 and "" ~= A1_2 then
      L4_2 = #A1_2
      L5_2 = 2048
      if not (L4_2 > L5_2) then
        goto lbl_19
      end
    end
  end
  do return end
  ::lbl_19::
  L4_2 = L7_1
  L5_2 = L3_2
  L6_2 = A0_2
  L4_2 = L4_2(L5_2, L6_2)
  if not L4_2 then
    return
  end
  L4_2 = L3_1
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  if not L4_2 then
    return
  end
  L5_2 = L4_1
  L5_2 = L5_2()
  if not L5_2 then
    return
  end
  L6_2 = L2_1
  L7_2 = A0_2
  L6_2 = L6_2(L7_2)
  L7_2 = L6_1
  L8_2 = A2_2
  L7_2 = L7_2(L8_2)
  L8_2 = HousingHouseMusicDestroyHouse
  L9_2 = A0_2
  L8_2(L9_2)
  if "xsound" == L5_2 then
    L8_2 = pcall
    function L9_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
      L0_3 = exports
      L0_3 = L0_3.xsound
      L1_3 = L0_3
      L0_3 = L0_3.PlayUrlPos
      L2_3 = -1
      L3_3 = L6_2
      L4_3 = A1_2
      L5_3 = L7_2
      L6_3 = L4_2
      L7_3 = true
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
      L0_3 = exports
      L0_3 = L0_3.xsound
      L1_3 = L0_3
      L0_3 = L0_3.Distance
      L2_3 = -1
      L3_3 = L6_2
      L4_3 = L0_1
      L0_3(L1_3, L2_3, L3_3, L4_3)
    end
    L8_2 = L8_2(L9_2)
    if not L8_2 then
      return
    end
    L9_2 = HousingHouseMusic
    L10_2 = {}
    L10_2.provider = "xsound"
    L10_2.soundId = L6_2
    L9_2[A0_2] = L10_2
    return
  end
  L8_2 = exports
  L8_2 = L8_2[L5_2]
  L9_2 = L8_2
  L8_2 = L8_2.Play
  L10_2 = -1
  L11_2 = L6_2
  L12_2 = A1_2
  L13_2 = L4_2
  L14_2 = true
  L15_2 = L7_2
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  if not L8_2 then
    return
  end
  L9_2 = pcall
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = exports
    L1_3 = L5_2
    L0_3 = L0_3[L1_3]
    L1_3 = L0_3
    L0_3 = L0_3.setVolumeMax
    L2_3 = -1
    L3_3 = L6_2
    L4_3 = L7_2
    L0_3(L1_3, L2_3, L3_3, L4_3)
    L0_3 = exports
    L1_3 = L5_2
    L0_3 = L0_3[L1_3]
    L1_3 = L0_3
    L0_3 = L0_3.setMaxDistance
    L2_3 = -1
    L3_3 = L6_2
    L4_3 = L0_1
    L0_3(L1_3, L2_3, L3_3, L4_3)
  end
  L9_2(L10_2)
  L9_2 = HousingHouseMusic
  L10_2 = {}
  L10_2.provider = L5_2
  L10_2.soundId = L6_2
  L9_2[A0_2] = L10_2
end
L8_1(L9_1, L10_1)
L8_1 = RegisterNetEvent
L9_1 = "housing:server:houseMusicVolume"
function L10_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = source
  L3_2 = type
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if "string" ~= L3_2 then
    return
  end
  L3_2 = L7_1
  L4_2 = L2_2
  L5_2 = A0_2
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    return
  end
  L3_2 = HousingHouseMusic
  L3_2 = L3_2[A0_2]
  if not L3_2 then
    return
  end
  L4_2 = L6_1
  L5_2 = A1_2
  L4_2 = L4_2(L5_2)
  L5_2 = L3_2.provider
  if "xsound" == L5_2 then
    L5_2 = pcall
    function L6_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3
      L0_3 = exports
      L0_3 = L0_3.xsound
      L1_3 = L0_3
      L0_3 = L0_3.setVolume
      L2_3 = -1
      L3_3 = L3_2.soundId
      L4_3 = L4_2
      L0_3(L1_3, L2_3, L3_3, L4_3)
    end
    L5_2(L6_2)
  else
    L5_2 = pcall
    function L6_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3
      L0_3 = exports
      L1_3 = L3_2.provider
      L0_3 = L0_3[L1_3]
      L1_3 = L0_3
      L0_3 = L0_3.setVolumeMax
      L2_3 = -1
      L3_3 = L3_2.soundId
      L4_3 = L4_2
      L0_3(L1_3, L2_3, L3_3, L4_3)
    end
    L5_2(L6_2)
  end
end
L8_1(L9_1, L10_1)
L8_1 = RegisterNetEvent
L9_1 = "housing:server:houseMusicStop"
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = source
  L2_2 = type
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if "string" ~= L2_2 then
    return
  end
  L2_2 = L7_1
  L3_2 = L1_2
  L4_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    return
  end
  L2_2 = HousingHouseMusicDestroyHouse
  L3_2 = A0_2
  L2_2(L3_2)
end
L8_1(L9_1, L10_1)
L8_1 = AddEventHandler
L9_1 = "housing:setInside"
function L10_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = type
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if "string" ~= L2_2 or "" == A0_2 then
    return
  end
  L2_2 = source
  if A1_2 then
    L3_2 = L1_1
    L4_2 = L1_1
    L4_2 = L4_2[A0_2]
    if not L4_2 then
      L4_2 = {}
    end
    L3_2[A0_2] = L4_2
    L3_2 = L1_1
    L3_2 = L3_2[A0_2]
    L3_2[L2_2] = true
    return
  end
  L3_2 = L1_1
  L3_2 = L3_2[A0_2]
  L4_2 = L3_2 or L4_2
  if L3_2 then
    L4_2 = L3_2[L2_2]
    L4_2 = true == L4_2
  end
  if L3_2 then
    L3_2[L2_2] = nil
    L5_2 = next
    L6_2 = L3_2
    L5_2 = L5_2(L6_2)
    if not L5_2 then
      L5_2 = L1_1
      L5_2[A0_2] = nil
    end
  end
  if L4_2 then
    L5_2 = L1_1
    L5_2 = L5_2[A0_2]
    if L5_2 then
      L5_2 = next
      L6_2 = L1_1
      L6_2 = L6_2[A0_2]
      L5_2 = L5_2(L6_2)
      if L5_2 then
        goto lbl_62
      end
    end
    L5_2 = HousingHouseMusic
    L5_2 = L5_2[A0_2]
    if L5_2 then
      L5_2 = HousingHouseMusicDestroyHouse
      L6_2 = A0_2
      L5_2(L6_2)
    end
  end
  ::lbl_62::
end
L8_1(L9_1, L10_1)
L8_1 = AddEventHandler
L9_1 = "playerDropped"
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = source
  L1_2 = pairs
  L2_2 = L1_1
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = L6_2[L0_2]
    if L7_2 then
      L6_2[L0_2] = nil
      L7_2 = next
      L8_2 = L6_2
      L7_2 = L7_2(L8_2)
      if not L7_2 then
        L8_2 = L1_1
        L8_2[L5_2] = nil
        L8_2 = HousingHouseMusic
        L8_2 = L8_2[L5_2]
        if L8_2 then
          L8_2 = HousingHouseMusicDestroyHouse
          L9_2 = L5_2
          L8_2(L9_2)
        end
      end
    end
  end
end
L8_1(L9_1, L10_1)






