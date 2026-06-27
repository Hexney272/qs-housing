





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1
L0_1 = {}
Blips = L0_1
L0_1 = {}
L1_1 = {}
L2_1 = 70
L3_1 = 11
L4_1 = 10
function L5_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  if A0_2 then
    L1_2 = table
    L1_2 = L1_2.find
    L2_2 = Blips
    function L3_2(A0_3)
      local L1_3, L2_3
      L1_3 = A0_3.house
      L2_3 = A0_2
      L1_3 = L1_3 == L2_3
      return L1_3
    end
    L1_2, L2_2 = L1_2(L2_2, L3_2)
    if L1_2 then
      L3_2 = RemoveBlip
      L4_2 = L1_2.blip
      L3_2(L4_2)
      L3_2 = table
      L3_2 = L3_2.remove
      L4_2 = Blips
      L5_2 = L2_2
      L3_2(L4_2, L5_2)
      L3_2 = Debug
      L4_2 = "Blip"
      L5_2 = "Removed blip for house "
      L6_2 = A0_2
      L5_2 = L5_2 .. L6_2
      L3_2(L4_2, L5_2)
      return
    end
    L3_2 = Debug
    L4_2 = "Blip"
    L5_2 = "Blip for house "
    L6_2 = A0_2
    L7_2 = " not found"
    L5_2 = L5_2 .. L6_2 .. L7_2
    L3_2(L4_2, L5_2)
    return
  end
  L1_2 = pairs
  L2_2 = Blips
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = RemoveBlip
    L8_2 = L6_2.blip
    L7_2(L8_2)
  end
  L1_2 = {}
  Blips = L1_2
end
DeleteBlips = L5_1
function L5_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = vec3
  L3_2 = A0_2.x
  L4_2 = A0_2.y
  L5_2 = A0_2.z
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  A0_2 = L2_2
  L2_2 = vec3
  L3_2 = A1_2.x
  L4_2 = A1_2.y
  L5_2 = A1_2.z
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  A1_2 = L2_2
  L2_2 = A0_2 - A1_2
  L2_2 = #L2_2
  return L2_2
end
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = #A0_2
  L3_2 = #A1_2
  if L2_2 ~= L3_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = {}
  L3_2 = ipairs
  L4_2 = A1_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L2_2[L8_2] = true
  end
  L3_2 = ipairs
  L4_2 = A0_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = L2_2[L8_2]
    if not L9_2 then
      L9_2 = false
      return L9_2
    end
  end
  L3_2 = true
  return L3_2
end
function L7_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = Config
  L0_2 = L0_2.ShowClosestBlips
  if L0_2 then
    L0_2 = Config
    L0_2 = L0_2.DisableAllHouseBlips
    if not L0_2 then
      goto lbl_10
    end
  end
  do return end
  ::lbl_10::
  L0_2 = GetEntityCoords
  L1_2 = cache
  L1_2 = L1_2.ped
  L0_2 = L0_2(L1_2)
  L1_2 = {}
  L2_2 = {}
  L3_2 = pairs
  L4_2 = L0_1
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = L5_1
    L10_2 = L0_2
    L11_2 = L8_2.coords
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = {}
    L10_2.house = L7_2
    L10_2.distance = L9_2
    L10_2.cacheData = L8_2
    L11_2 = L8_2.ownedByMe
    if L11_2 then
      L11_2 = table
      L11_2 = L11_2.insert
      L12_2 = L1_2
      L13_2 = L10_2
      L11_2(L12_2, L13_2)
    else
      L11_2 = table
      L11_2 = L11_2.insert
      L12_2 = L2_2
      L13_2 = L10_2
      L11_2(L12_2, L13_2)
    end
  end
  L3_2 = table
  L3_2 = L3_2.sort
  L4_2 = L1_2
  function L5_2(A0_3, A1_3)
    local L2_3, L3_3
    L2_3 = A0_3.distance
    L3_3 = A1_3.distance
    L2_3 = L2_3 < L3_3
    return L2_3
  end
  L3_2(L4_2, L5_2)
  L3_2 = table
  L3_2 = L3_2.sort
  L4_2 = L2_2
  function L5_2(A0_3, A1_3)
    local L2_3, L3_3
    L2_3 = A0_3.distance
    L3_3 = A1_3.distance
    L2_3 = L2_3 < L3_3
    return L2_3
  end
  L3_2(L4_2, L5_2)
  L3_2 = {}
  L4_2 = ipairs
  L5_2 = L1_2
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = table
    L10_2 = L10_2.insert
    L11_2 = L3_2
    L12_2 = L9_2.house
    L10_2(L11_2, L12_2)
  end
  L4_2 = L2_1
  L5_2 = #L3_2
  L4_2 = L4_2 - L5_2
  L5_2 = 1
  L6_2 = math
  L6_2 = L6_2.min
  L7_2 = L4_2
  L8_2 = #L2_2
  L6_2 = L6_2(L7_2, L8_2)
  L7_2 = 1
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = table
    L9_2 = L9_2.insert
    L10_2 = L3_2
    L11_2 = L2_2[L8_2]
    L11_2 = L11_2.house
    L9_2(L10_2, L11_2)
  end
  L5_2 = L6_1
  L6_2 = L3_2
  L7_2 = L1_1
  L5_2 = L5_2(L6_2, L7_2)
  if L5_2 then
    return
  end
  L5_2 = {}
  L1_1 = L5_2
  L5_2 = ipairs
  L6_2 = L3_2
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = table
    L11_2 = L11_2.insert
    L12_2 = L1_1
    L13_2 = L10_2
    L11_2(L12_2, L13_2)
  end
  L5_2 = DeleteBlips
  L5_2()
  L5_2 = ipairs
  L6_2 = L3_2
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = L0_1
    L11_2 = L11_2[L10_2]
    if L11_2 then
      L12_2 = Utils
      L12_2 = L12_2.CreateBlip
      L13_2 = {}
      L14_2 = L11_2.coords
      L13_2.location = L14_2
      L14_2 = L11_2.sprite
      L13_2.sprite = L14_2
      L14_2 = L11_2.color
      L13_2.color = L14_2
      L14_2 = L11_2.scale
      L13_2.scale = L14_2
      L14_2 = L11_2.text
      L13_2.text = L14_2
      L13_2.shortRange = true
      L12_2 = L12_2(L13_2)
      L13_2 = L11_2.blipColor
      if L13_2 then
        L13_2 = SetBlipColour
        L14_2 = L12_2
        L15_2 = L11_2.blipColor
        L13_2(L14_2, L15_2)
      end
      L13_2 = Config
      L13_2 = L13_2.CategoryBlips
      if L13_2 then
        L13_2 = SetBlipCategory
        L14_2 = L12_2
        L15_2 = L11_2.category
        if not L15_2 then
          L15_2 = L4_1
        end
        L13_2(L14_2, L15_2)
      end
      L13_2 = BeginTextCommandSetBlipName
      L14_2 = "STRING"
      L13_2(L14_2)
      L13_2 = AddTextComponentSubstringPlayerName
      L14_2 = L11_2.blipName
      L13_2(L14_2)
      L13_2 = EndTextCommandSetBlipName
      L14_2 = L12_2
      L13_2(L14_2)
      L13_2 = table
      L13_2 = L13_2.insert
      L14_2 = Blips
      L15_2 = {}
      L15_2.house = L10_2
      L15_2.blip = L12_2
      L13_2(L14_2, L15_2)
    end
  end
end
L8_1 = CreateThread
function L9_1()
  local L0_2, L1_2
  while true do
    L0_2 = Wait
    L1_2 = 500
    L0_2(L1_2)
    L0_2 = Config
    L0_2 = L0_2.ShowClosestBlips
    if L0_2 then
      L0_2 = Config
      L0_2 = L0_2.DisableAllHouseBlips
      if not L0_2 then
        L0_2 = L7_1
        L0_2()
      end
    end
  end
end
L8_1(L9_1)
L8_1 = Config
L8_1 = L8_1.Blip
function L9_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = Config
  L1_2 = L1_2.DisableAllHouseBlips
  if L1_2 then
    L1_2 = {}
    L0_1 = L1_2
    L1_2 = {}
    L1_1 = L1_2
    return
  end
  L1_2 = DeleteBlips
  L2_2 = A0_2
  L1_2(L2_2)
  L1_2 = TriggerServerCallback
  L2_2 = "qb-houses:server:getPlayerHouses"
  function L3_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3
    L1_3 = A0_2
    if L1_3 then
      L1_3 = {}
      L2_3 = A0_2
      L3_3 = Config
      L3_3 = L3_3.Houses
      L4_3 = A0_2
      L3_3 = L3_3[L4_3]
      L1_3[L2_3] = L3_3
      if L1_3 then
        goto lbl_16
      end
    end
    L1_3 = Config
    L1_3 = L1_3.Houses
    ::lbl_16::
    L2_3 = Config
    L2_3 = L2_3.ShowClosestBlips
    if L2_3 then
      L2_3 = A0_2
      if not L2_3 then
        L2_3 = {}
        L0_1 = L2_3
        L2_3 = {}
        L1_1 = L2_3
        L2_3 = pairs
        L3_3 = L1_3
        L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3)
        for L6_3, L7_3 in L2_3, L3_3, L4_3, L5_3 do
          L8_3 = L7_3.apartmentNumber
          if L8_3 then
            L8_3 = L7_3.apartmentNumber
            if "apt-0" ~= L8_3 then
          end
          else
            L8_3 = L7_3.blip
            L9_3 = L7_3.address
            if not L9_3 then
              L7_3.address = "Unknown"
            end
            L9_3 = i18n
            L9_3 = L9_3.t
            L10_3 = "blip.house"
            L9_3 = L9_3(L10_3)
            L10_3 = nil
            L11_3 = L7_3.apartmentNumber
            if L11_3 then
              L11_3 = table
              L11_3 = L11_3.find
              L12_3 = A0_3
              function L13_3(A0_4)
                local L1_4, L2_4, L3_4, L4_4, L5_4
                L1_4 = L7_3.apartmentName
                L2_4 = A0_4.house
                L3_4 = L2_4
                L2_4 = L2_4.gsub
                L4_4 = "-apt%-%d+"
                L5_4 = ""
                L2_4 = L2_4(L3_4, L4_4, L5_4)
                L1_4 = L1_4 == L2_4
                return L1_4
              end
              L11_3 = L11_3(L12_3, L13_3)
              L10_3 = L11_3
            else
              L11_3 = table
              L11_3 = L11_3.find
              L12_3 = A0_3
              function L13_3(A0_4)
                local L1_4, L2_4
                L1_4 = A0_4.house
                L2_4 = L6_3
                L1_4 = L1_4 == L2_4
                return L1_4
              end
              L11_3 = L11_3(L12_3, L13_3)
              L10_3 = L11_3
            end
            if not L8_3 and not L10_3 then
              L11_3 = Debug
              L12_3 = "Blip"
              L13_3 = "No blip data and no owned house"
              L14_3 = "house"
              L15_3 = L6_3
              L11_3(L12_3, L13_3, L14_3, L15_3)
            else
              L11_3 = false
              L12_3 = false
              L13_3 = nil
              L14_3 = false
              L15_3 = L4_1
              if L10_3 then
                L16_3 = L10_3.citizenid
                L17_3 = GetIdentifier
                L17_3 = L17_3()
                L11_3 = L16_3 == L17_3
                L16_3 = L10_3.owner
                L17_3 = GetIdentifier
                L17_3 = L17_3()
                L12_3 = L16_3 == L17_3
                L16_3 = L10_3.rentable
                L17_3 = L10_3.purchasable
                L14_3 = L11_3 or L14_3
                if not L11_3 then
                  L14_3 = L12_3
                end
                if L14_3 then
                  L18_3 = L3_1
                  if L18_3 then
                    goto lbl_109
                    L15_3 = L18_3 or L15_3
                  end
                end
                L15_3 = L4_1
                ::lbl_109::
                if not L14_3 and not L8_3 then
                  L18_3 = Debug
                  L19_3 = "Blip"
                  L20_3 = "No blip data and no owned house"
                  L21_3 = "house"
                  L22_3 = L6_3
                  L18_3(L19_3, L20_3, L21_3, L22_3)
                else
                  if L12_3 then
                    L18_3 = L8_1.officialOwned
                    L18_3 = L18_3.enabled
                    if not L18_3 then
                      L18_3 = Debug
                      L19_3 = "House is official owned but blip is disabled"
                      L20_3 = "house"
                      L21_3 = L6_3
                      L18_3(L19_3, L20_3, L21_3)
                    else
                      L18_3 = L8_1.officialOwned
                      L13_3 = L18_3.color
                      L18_3 = i18n
                      L18_3 = L18_3.t
                      L19_3 = "blip.your_house"
                      L18_3 = L18_3(L19_3)
                      L9_3 = L18_3
                      if L16_3 then
                        L18_3 = i18n
                        L18_3 = L18_3.t
                        L19_3 = "blip.your_house_rentable"
                        L18_3 = L18_3(L19_3)
                        L9_3 = L18_3
                      end
                      else
                        if L11_3 then
                          L18_3 = L8_1.owned
                          L18_3 = L18_3.enabled
                          if not L18_3 then
                            L18_3 = Debug
                            L19_3 = "House is owned but blip is disabled"
                            L20_3 = "house"
                            L21_3 = L6_3
                            L18_3(L19_3, L20_3, L21_3)
                          else
                            L18_3 = L8_1.owned
                            L13_3 = L18_3.color
                            L18_3 = i18n
                            L18_3 = L18_3.t
                            L19_3 = "blip.your_house_rental"
                            L18_3 = L18_3(L19_3)
                            L9_3 = L18_3
                            else
                              if L16_3 then
                                L18_3 = L8_1.rentable
                                L18_3 = L18_3.enabled
                                if not L18_3 then
                                  L18_3 = Debug
                                  L19_3 = "House is rentable but blip is disabled"
                                  L20_3 = "house"
                                  L21_3 = L6_3
                                  L18_3(L19_3, L20_3, L21_3)
                                else
                                  L18_3 = L8_1.rentable
                                  L13_3 = L18_3.color
                                  L18_3 = i18n
                                  L18_3 = L18_3.t
                                  L19_3 = "blip.house_for_rent"
                                  L18_3 = L18_3(L19_3)
                                  L9_3 = L18_3
                                  else
                                    if L17_3 then
                                      L18_3 = L8_1.purchasable
                                      L18_3 = L18_3.enabled
                                      if not L18_3 then
                                        L18_3 = Debug
                                        L19_3 = "House is purchasable but blip is disabled"
                                        L20_3 = "house"
                                        L21_3 = L6_3
                                        L18_3(L19_3, L20_3, L21_3)
                                      else
                                        L18_3 = L8_1.purchasable
                                        L13_3 = L18_3.color
                                        L18_3 = i18n
                                        L18_3 = L18_3.t
                                        L19_3 = "blip.house_available_for_purchase"
                                        L18_3 = L18_3(L19_3)
                                        L9_3 = L18_3
                                        else
                                          L18_3 = L8_1.ownedOther
                                          L18_3 = L18_3.enabled
                                          if not L18_3 then
                                            L18_3 = Debug
                                            L19_3 = "House is owned by other player but blip is disabled"
                                            L20_3 = "house"
                                            L21_3 = L6_3
                                            L18_3(L19_3, L20_3, L21_3)
                                            goto lbl_295
                                          end
                                        end
                                        else
                                          L16_3 = Config
                                          L16_3 = L16_3.Blip
                                          L16_3 = L16_3.forSale
                                          L16_3 = L16_3.enabled
                                          if not L16_3 then
                                            L16_3 = Debug
                                            L17_3 = "House no owner and blip for sale disabled"
                                            L18_3 = "house"
                                            L19_3 = L6_3
                                            L16_3(L17_3, L18_3, L19_3)
                                        end
                                        else
                                          L16_3 = Config
                                          L16_3 = L16_3.GroupBlips
                                          if not L16_3 then
                                            L16_3 = L9_3
                                            L17_3 = " "
                                            L18_3 = L7_3.address
                                            L16_3 = L16_3 .. L17_3 .. L18_3
                                            L9_3 = L16_3
                                          end
                                          L16_3 = L0_1
                                          L17_3 = {}
                                          L18_3 = L7_3.coords
                                          L18_3 = L18_3.enter
                                          L17_3.coords = L18_3
                                          if L8_3 then
                                            L18_3 = L8_3.sprite
                                            if L18_3 then
                                              goto lbl_251
                                            end
                                          end
                                          L18_3 = 40
                                          ::lbl_251::
                                          L17_3.sprite = L18_3
                                          if L8_3 then
                                            L18_3 = L8_3.color
                                            if L18_3 then
                                              goto lbl_258
                                            end
                                          end
                                          L18_3 = 15
                                          ::lbl_258::
                                          L17_3.color = L18_3
                                          if L8_3 then
                                            L18_3 = L8_3.scale
                                            if L18_3 then
                                              L18_3 = L8_3.scale
                                              L18_3 = L18_3 + 0.0
                                              if L18_3 then
                                                goto lbl_270
                                              end
                                            end
                                          end
                                          L18_3 = 0.58
                                          ::lbl_270::
                                          L17_3.scale = L18_3
                                          if L8_3 then
                                            L18_3 = L8_3.name
                                            if L18_3 then
                                              L18_3 = L8_3.name
                                              if "" ~= L18_3 then
                                                L18_3 = L8_3.name
                                                if L18_3 then
                                                  goto lbl_283
                                                end
                                              end
                                            end
                                          end
                                          L18_3 = L9_3
                                          ::lbl_283::
                                          L17_3.text = L18_3
                                          L17_3.blipColor = L13_3
                                          if L8_3 then
                                            L18_3 = L8_3.name
                                            if L18_3 then
                                              goto lbl_291
                                            end
                                          end
                                          L18_3 = L9_3
                                          ::lbl_291::
                                          L17_3.blipName = L18_3
                                          L17_3.ownedByMe = L14_3
                                          L17_3.category = L15_3
                                          L16_3[L6_3] = L17_3
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
          ::lbl_295::
        end
        L2_3 = 0
        L3_3 = pairs
        L4_3 = L0_1
        L3_3, L4_3, L5_3, L6_3 = L3_3(L4_3)
        for L7_3 in L3_3, L4_3, L5_3, L6_3 do
          L2_3 = L2_3 + 1
        end
        L3_3 = Debug
        L4_3 = "Blip"
        L5_3 = "Cached "
        L6_3 = L2_3
        L7_3 = " blips for distance-based display"
        L5_3 = L5_3 .. L6_3 .. L7_3
        L3_3(L4_3, L5_3)
        return
      end
    end
    L2_3 = pairs
    L3_3 = L1_3
    L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3)
    for L6_3, L7_3 in L2_3, L3_3, L4_3, L5_3 do
      L8_3 = L7_3.apartmentNumber
      if L8_3 then
        L8_3 = L7_3.apartmentNumber
        if "apt-0" ~= L8_3 then
      end
      else
        L8_3 = L7_3.blip
        L9_3 = L7_3.address
        if not L9_3 then
          L7_3.address = "Unknown"
        end
        L9_3 = i18n
        L9_3 = L9_3.t
        L10_3 = "blip.house"
        L9_3 = L9_3(L10_3)
        L10_3 = nil
        L11_3 = nil
        L12_3 = L4_1
        L13_3 = L7_3.apartmentNumber
        if L13_3 then
          L13_3 = table
          L13_3 = L13_3.find
          L14_3 = A0_3
          function L15_3(A0_4)
            local L1_4, L2_4, L3_4, L4_4, L5_4
            L1_4 = L7_3.apartmentName
            L2_4 = A0_4.house
            L3_4 = L2_4
            L2_4 = L2_4.gsub
            L4_4 = "-apt%-%d+"
            L5_4 = ""
            L2_4 = L2_4(L3_4, L4_4, L5_4)
            L1_4 = L1_4 == L2_4
            return L1_4
          end
          L13_3 = L13_3(L14_3, L15_3)
          L11_3 = L13_3
        else
          L13_3 = table
          L13_3 = L13_3.find
          L14_3 = A0_3
          function L15_3(A0_4)
            local L1_4, L2_4
            L1_4 = A0_4.house
            L2_4 = L6_3
            L1_4 = L1_4 == L2_4
            return L1_4
          end
          L13_3 = L13_3(L14_3, L15_3)
          L11_3 = L13_3
        end
        if not L8_3 and not L11_3 then
          L13_3 = Debug
          L14_3 = "Blip"
          L15_3 = "No blip data and no owned house"
          L16_3 = "house"
          L17_3 = L6_3
          L13_3(L14_3, L15_3, L16_3, L17_3)
        else
          L13_3 = Utils
          L13_3 = L13_3.CreateBlip
          L14_3 = {}
          L15_3 = L7_3.coords
          L15_3 = L15_3.enter
          L14_3.location = L15_3
          if L8_3 then
            L15_3 = L8_3.sprite
            if L15_3 then
              goto lbl_379
            end
          end
          L15_3 = 40
          ::lbl_379::
          L14_3.sprite = L15_3
          if L8_3 then
            L15_3 = L8_3.color
            if L15_3 then
              goto lbl_386
            end
          end
          L15_3 = 15
          ::lbl_386::
          L14_3.color = L15_3
          if L8_3 then
            L15_3 = L8_3.scale
            if L15_3 then
              L15_3 = L8_3.scale
              L15_3 = L15_3 + 0.0
              if L15_3 then
                goto lbl_398
              end
            end
          end
          L15_3 = 0.58
          ::lbl_398::
          L14_3.scale = L15_3
          if L8_3 then
            L15_3 = L8_3.name
            if L15_3 then
              L15_3 = L8_3.name
              if "" ~= L15_3 then
                L15_3 = L8_3.name
                if L15_3 then
                  goto lbl_411
                end
              end
            end
          end
          L15_3 = L9_3
          ::lbl_411::
          L14_3.text = L15_3
          L14_3.shortRange = true
          L13_3 = L13_3(L14_3)
          L10_3 = L13_3
          if L11_3 then
            L13_3 = L11_3.citizenid
            L14_3 = GetIdentifier
            L14_3 = L14_3()
            L13_3 = L13_3 == L14_3
            L14_3 = L11_3.owner
            L15_3 = GetIdentifier
            L15_3 = L15_3()
            L14_3 = L14_3 == L15_3
            L15_3 = L11_3.rentable
            L16_3 = L11_3.purchasable
            L17_3 = L13_3 or L17_3
            if not L13_3 then
              L17_3 = L14_3
            end
            if L17_3 then
              L18_3 = L3_1
              if L18_3 then
                goto lbl_442
                L12_3 = L18_3 or L12_3
              end
            end
            L12_3 = L4_1
            ::lbl_442::
            if not L17_3 and not L8_3 then
              L18_3 = Debug
              L19_3 = "Blip"
              L20_3 = "No blip data and no owned house"
              L21_3 = "house"
              L22_3 = L6_3
              L18_3(L19_3, L20_3, L21_3, L22_3)
              L18_3 = RemoveBlip
              L19_3 = L10_3
              L18_3(L19_3)
            else
              if L14_3 then
                L18_3 = L8_1.officialOwned
                L18_3 = L18_3.enabled
                if not L18_3 then
                  L18_3 = Debug
                  L19_3 = "House is official owned but blip is disabled"
                  L20_3 = "house"
                  L21_3 = L6_3
                  L18_3(L19_3, L20_3, L21_3)
                  L18_3 = RemoveBlip
                  L19_3 = L10_3
                  L18_3(L19_3)
                else
                  L18_3 = SetBlipColour
                  L19_3 = L10_3
                  L20_3 = L8_1.officialOwned
                  L20_3 = L20_3.color
                  L18_3(L19_3, L20_3)
                  L18_3 = i18n
                  L18_3 = L18_3.t
                  L19_3 = "blip.your_house"
                  L18_3 = L18_3(L19_3)
                  L9_3 = L18_3
                  if L15_3 then
                    L18_3 = i18n
                    L18_3 = L18_3.t
                    L19_3 = "blip.your_house_rentable"
                    L18_3 = L18_3(L19_3)
                    L9_3 = L18_3
                  end
                  else
                    if L13_3 then
                      L18_3 = L8_1.owned
                      L18_3 = L18_3.enabled
                      if not L18_3 then
                        L18_3 = Debug
                        L19_3 = "House is owned but blip is disabled"
                        L20_3 = "house"
                        L21_3 = L6_3
                        L18_3(L19_3, L20_3, L21_3)
                        L18_3 = RemoveBlip
                        L19_3 = L10_3
                        L18_3(L19_3)
                      else
                        L18_3 = SetBlipColour
                        L19_3 = L10_3
                        L20_3 = L8_1.owned
                        L20_3 = L20_3.color
                        L18_3(L19_3, L20_3)
                        L18_3 = i18n
                        L18_3 = L18_3.t
                        L19_3 = "blip.your_house_rental"
                        L18_3 = L18_3(L19_3)
                        L9_3 = L18_3
                        else
                          if L15_3 then
                            L18_3 = L8_1.rentable
                            L18_3 = L18_3.enabled
                            if not L18_3 then
                              L18_3 = Debug
                              L19_3 = "House is rentable but blip is disabled"
                              L20_3 = "house"
                              L21_3 = L6_3
                              L18_3(L19_3, L20_3, L21_3)
                              L18_3 = RemoveBlip
                              L19_3 = L10_3
                              L18_3(L19_3)
                            else
                              L18_3 = SetBlipColour
                              L19_3 = L10_3
                              L20_3 = L8_1.rentable
                              L20_3 = L20_3.color
                              L18_3(L19_3, L20_3)
                              L18_3 = i18n
                              L18_3 = L18_3.t
                              L19_3 = "blip.house_for_rent"
                              L18_3 = L18_3(L19_3)
                              L9_3 = L18_3
                              else
                                if L16_3 then
                                  L18_3 = L8_1.purchasable
                                  L18_3 = L18_3.enabled
                                  if not L18_3 then
                                    L18_3 = Debug
                                    L19_3 = "House is purchasable but blip is disabled"
                                    L20_3 = "house"
                                    L21_3 = L6_3
                                    L18_3(L19_3, L20_3, L21_3)
                                    L18_3 = RemoveBlip
                                    L19_3 = L10_3
                                    L18_3(L19_3)
                                  else
                                    L18_3 = SetBlipColour
                                    L19_3 = L10_3
                                    L20_3 = L8_1.purchasable
                                    L20_3 = L20_3.color
                                    L18_3(L19_3, L20_3)
                                    L18_3 = i18n
                                    L18_3 = L18_3.t
                                    L19_3 = "blip.house_available_for_purchase"
                                    L18_3 = L18_3(L19_3)
                                    L9_3 = L18_3
                                    else
                                      L18_3 = L8_1.ownedOther
                                      L18_3 = L18_3.enabled
                                      if not L18_3 then
                                        L18_3 = Debug
                                        L19_3 = "House is owned by other player but blip is disabled"
                                        L20_3 = "house"
                                        L21_3 = L6_3
                                        L18_3(L19_3, L20_3, L21_3)
                                        L18_3 = RemoveBlip
                                        L19_3 = L10_3
                                        L18_3(L19_3)
                                        goto lbl_635
                                      end
                                    end
                                    else
                                      L13_3 = Config
                                      L13_3 = L13_3.Blip
                                      L13_3 = L13_3.forSale
                                      L13_3 = L13_3.enabled
                                      if not L13_3 then
                                        L13_3 = Debug
                                        L14_3 = "House no owner and blip for sale disabled"
                                        L15_3 = "house"
                                        L16_3 = L6_3
                                        L13_3(L14_3, L15_3, L16_3)
                                        L13_3 = RemoveBlip
                                        L14_3 = L10_3
                                        L13_3(L14_3)
                                    end
                                    else
                                      L13_3 = Config
                                      L13_3 = L13_3.CategoryBlips
                                      if L13_3 then
                                        L13_3 = SetBlipCategory
                                        L14_3 = L10_3
                                        L15_3 = L12_3
                                        L13_3(L14_3, L15_3)
                                      end
                                      L13_3 = Config
                                      L13_3 = L13_3.GroupBlips
                                      if not L13_3 then
                                        L13_3 = L9_3
                                        L14_3 = " "
                                        L15_3 = L7_3.address
                                        L13_3 = L13_3 .. L14_3 .. L15_3
                                        L9_3 = L13_3
                                      end
                                      L13_3 = BeginTextCommandSetBlipName
                                      L14_3 = "STRING"
                                      L13_3(L14_3)
                                      L13_3 = AddTextComponentSubstringPlayerName
                                      if L8_3 then
                                        L14_3 = L8_3.name
                                        if L14_3 then
                                          goto lbl_623
                                        end
                                      end
                                      L14_3 = L9_3
                                      ::lbl_623::
                                      L13_3(L14_3)
                                      L13_3 = EndTextCommandSetBlipName
                                      L14_3 = L10_3
                                      L13_3(L14_3)
                                      L13_3 = table
                                      L13_3 = L13_3.insert
                                      L14_3 = Blips
                                      L15_3 = {}
                                      L15_3.house = L6_3
                                      L15_3.blip = L10_3
                                      L13_3(L14_3, L15_3)
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
      ::lbl_635::
    end
  end
  L4_2 = A0_2
  L1_2(L2_2, L3_2, L4_2)
end
CreateBlips = L9_1






