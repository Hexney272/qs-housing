





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1
L0_1 = {}
Utils = L0_1
L0_1 = Utils
L1_1 = {}
L0_1.RenderList = L1_1
L0_1 = Utils
L1_1 = {}
L0_1.Characters = L1_1
L0_1 = Utils
L1_1 = {}
L0_1.Numbers = L1_1
L0_1 = 48
L1_1 = 57
L2_1 = 1
for L3_1 = L0_1, L1_1, L2_1 do
  L4_1 = table
  L4_1 = L4_1.insert
  L5_1 = Utils
  L5_1 = L5_1.Numbers
  L6_1 = string
  L6_1 = L6_1.char
  L7_1 = L3_1
  L6_1 = L6_1(L7_1)
  L4_1(L5_1, L6_1)
end
L0_1 = 65
L1_1 = 90
L2_1 = 1
for L3_1 = L0_1, L1_1, L2_1 do
  L4_1 = table
  L4_1 = L4_1.insert
  L5_1 = Utils
  L5_1 = L5_1.Characters
  L6_1 = string
  L6_1 = L6_1.char
  L7_1 = L3_1
  L6_1 = L6_1(L7_1)
  L4_1(L5_1, L6_1)
end
L0_1 = 97
L1_1 = 122
L2_1 = 1
for L3_1 = L0_1, L1_1, L2_1 do
  L4_1 = table
  L4_1 = L4_1.insert
  L5_1 = Utils
  L5_1 = L5_1.Characters
  L6_1 = string
  L6_1 = L6_1.char
  L7_1 = L3_1
  L6_1 = L6_1(L7_1)
  L4_1(L5_1, L6_1)
end
L0_1 = Utils
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = math
  L2_2 = L2_2.randomseed
  L3_2 = GetGameTimer
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L3_2()
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L2_2 = ""
  L3_2 = 1
  L4_2 = A0_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = L2_2
    L8_2 = Utils
    L8_2 = L8_2.Characters
    L9_2 = math
    L9_2 = L9_2.random
    L10_2 = Utils
    L10_2 = L10_2.Characters
    L10_2 = #L10_2
    L9_2 = L9_2(L10_2)
    L8_2 = L8_2[L9_2]
    L7_2 = L7_2 .. L8_2
    L2_2 = L7_2
  end
  L3_2 = 1
  L4_2 = A1_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = L2_2
    L8_2 = Utils
    L8_2 = L8_2.Numbers
    L9_2 = math
    L9_2 = L9_2.random
    L10_2 = Utils
    L10_2 = L10_2.Numbers
    L10_2 = #L10_2
    L9_2 = L9_2(L10_2)
    L8_2 = L8_2[L9_2]
    L7_2 = L7_2 .. L8_2
    L2_2 = L7_2
  end
  return L2_2
end
L0_1.GenerateRandomUid = L1_1
L0_1 = Utils
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = Utils
  L3_2 = L3_2.GenerateRandomUid
  L4_2 = A1_2
  L5_2 = A2_2
  L3_2 = L3_2(L4_2, L5_2)
  while true do
    L4_2 = A0_2[L3_2]
    if not L4_2 then
      break
    end
    L4_2 = Utils
    L4_2 = L4_2.GenerateRandomUid
    L5_2 = A1_2
    L6_2 = A2_2
    L4_2 = L4_2(L5_2, L6_2)
    L3_2 = L4_2
  end
  return L3_2
end
L0_1.GenerateUniqueId = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = math
  L1_2 = L1_2.pi
  L1_2 = A0_2 * L1_2
  A0_2 = L1_2 / 180.0
  L1_2 = math
  L1_2 = L1_2.abs
  L2_2 = math
  L2_2 = L2_2.cos
  L3_2 = A0_2.x
  L2_2, L3_2, L4_2, L5_2, L6_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  L2_2 = vec3
  L3_2 = math
  L3_2 = L3_2.sin
  L4_2 = A0_2.z
  L3_2 = L3_2(L4_2)
  L3_2 = -L3_2
  L3_2 = L3_2 * L1_2
  L4_2 = math
  L4_2 = L4_2.cos
  L5_2 = A0_2.z
  L4_2 = L4_2(L5_2)
  L4_2 = L4_2 * L1_2
  L5_2 = math
  L5_2 = L5_2.sin
  L6_2 = A0_2.x
  L5_2, L6_2 = L5_2(L6_2)
  return L2_2(L3_2, L4_2, L5_2, L6_2)
end
L0_1.GetForwardVector = L1_1
L0_1 = Utils
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = A1_2 or nil
  if not A1_2 then
    L2_2 = ":"
  end
  L3_2 = {}
  L4_2 = string
  L4_2 = L4_2.format
  L5_2 = "([^%s]+)"
  L6_2 = L2_2
  L4_2 = L4_2(L5_2, L6_2)
  L6_2 = A0_2
  L5_2 = A0_2.gsub
  L7_2 = L4_2
  function L8_2(A0_3)
    local L1_3, L2_3
    L1_3 = L3_2
    L1_3 = #L1_3
    L2_3 = L1_3 + 1
    L1_3 = L3_2
    L1_3[L2_3] = A0_3
  end
  L5_2(L6_2, L7_2, L8_2)
  return L3_2
end
L0_1.SplitString = L1_1
L0_1 = Utils
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  if not A0_2 then
    L2_2 = ""
    return L2_2
  end
  L2_2 = #A0_2
  if A1_2 >= L2_2 then
    return A0_2
  end
  L2_2 = string
  L2_2 = L2_2.sub
  L3_2 = A0_2
  L4_2 = 1
  L5_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = string
  L3_2 = L3_2.find
  L4_2 = L2_2
  L5_2 = " "
  L6_2 = #L2_2
  L6_2 = L6_2 - 5
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  if L3_2 then
    L4_2 = string
    L4_2 = L4_2.sub
    L5_2 = L2_2
    L6_2 = 1
    L7_2 = L3_2 - 1
    L4_2 = L4_2(L5_2, L6_2, L7_2)
    L2_2 = L4_2
  end
  L4_2 = L2_2
  L5_2 = "..."
  L4_2 = L4_2 .. L5_2
  return L4_2
end
L0_1.BreakString = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2
  function L1_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    L1_3 = {}
    L2_3 = pairs
    L3_3 = A0_3
    L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3)
    for L6_3, L7_3 in L2_3, L3_3, L4_3, L5_3 do
      L8_3 = type
      L9_3 = L7_3
      L8_3 = L8_3(L9_3)
      if "vector4" == L8_3 then
        L8_3 = {}
        L9_3 = L7_3.x
        L8_3.x = L9_3
        L9_3 = L7_3.y
        L8_3.y = L9_3
        L9_3 = L7_3.z
        L8_3.z = L9_3
        L9_3 = L7_3.w
        L8_3.w = L9_3
        L1_3[L6_3] = L8_3
      else
        L8_3 = type
        L9_3 = L7_3
        L8_3 = L8_3(L9_3)
        if "vector3" == L8_3 then
          L8_3 = {}
          L9_3 = L7_3.x
          L8_3.x = L9_3
          L9_3 = L7_3.y
          L8_3.y = L9_3
          L9_3 = L7_3.z
          L8_3.z = L9_3
          L1_3[L6_3] = L8_3
        else
          L8_3 = type
          L9_3 = L7_3
          L8_3 = L8_3(L9_3)
          if "vector2" == L8_3 then
            L8_3 = {}
            L9_3 = L7_3.x
            L8_3.x = L9_3
            L9_3 = L7_3.y
            L8_3.y = L9_3
            L1_3[L6_3] = L8_3
          else
            L8_3 = type
            L9_3 = L7_3
            L8_3 = L8_3(L9_3)
            if "table" == L8_3 then
              L8_3 = __utilsJsonEncodeInternalDecode
              L9_3 = L7_3
              L8_3 = L8_3(L9_3)
              L1_3[L6_3] = L8_3
            else
              L1_3[L6_3] = L7_3
            end
          end
        end
      end
    end
    return L1_3
  end
  __utilsJsonEncodeInternalDecode = L1_2
  L1_2 = json
  L1_2 = L1_2.encode
  L2_2 = __utilsJsonEncodeInternalDecode
  L3_2 = A0_2
  L2_2, L3_2 = L2_2(L3_2)
  return L1_2(L2_2, L3_2)
end
L0_1.JsonEncode = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2
  function L1_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3
    L1_3 = {}
    L2_3 = pairs
    L3_3 = A0_3
    L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3)
    for L6_3, L7_3 in L2_3, L3_3, L4_3, L5_3 do
      L8_3 = type
      L9_3 = L7_3
      L8_3 = L8_3(L9_3)
      if "table" == L8_3 then
        L8_3 = L7_3.x
        if L8_3 then
          L8_3 = L7_3.y
          if L8_3 then
            L8_3 = L7_3.z
            if L8_3 then
              L8_3 = L7_3.w
              if L8_3 then
                L8_3 = Utils
                L8_3 = L8_3.TableCount
                L9_3 = L7_3
                L8_3 = L8_3(L9_3)
                if 4 == L8_3 then
                  L8_3 = vector4
                  L9_3 = L7_3.x
                  L10_3 = L7_3.y
                  L11_3 = L7_3.z
                  L12_3 = L7_3.w
                  L8_3 = L8_3(L9_3, L10_3, L11_3, L12_3)
                  L1_3[L6_3] = L8_3
              end
            end
          end
        end
        else
          L8_3 = L7_3.x
          if L8_3 then
            L8_3 = L7_3.x
            if L8_3 then
              L8_3 = L7_3.z
              if L8_3 then
                L8_3 = Utils
                L8_3 = L8_3.TableCount
                L9_3 = L7_3
                L8_3 = L8_3(L9_3)
                if 3 == L8_3 then
                  L8_3 = vector3
                  L9_3 = L7_3.x
                  L10_3 = L7_3.y
                  L11_3 = L7_3.z
                  L8_3 = L8_3(L9_3, L10_3, L11_3)
                  L1_3[L6_3] = L8_3
              end
            end
          end
          else
            L8_3 = L7_3.x
            if L8_3 then
              L8_3 = L7_3.y
              if L8_3 then
                L8_3 = Utils
                L8_3 = L8_3.TableCount
                L9_3 = L7_3
                L8_3 = L8_3(L9_3)
                if 2 == L8_3 then
                  L8_3 = vector2
                  L9_3 = L7_3.x
                  L10_3 = L7_3.y
                  L8_3 = L8_3(L9_3, L10_3)
                  L1_3[L6_3] = L8_3
              end
            end
            else
              L8_3 = __utilsJsonDecodeInternalDecode
              L9_3 = L7_3
              L8_3 = L8_3(L9_3)
              L1_3[L6_3] = L8_3
            end
          end
        end
      else
        L1_3[L6_3] = L7_3
      end
    end
    return L1_3
  end
  __utilsJsonDecodeInternalDecode = L1_2
  L1_2 = __utilsJsonDecodeInternalDecode
  L2_2 = json
  L2_2 = L2_2.decode
  L3_2 = A0_2
  L2_2, L3_2 = L2_2(L3_2)
  return L1_2(L2_2, L3_2)
end
L0_1.JsonDecode = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = {}
  L2_2 = pairs
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = type
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    if "table" == L8_2 then
      L8_2 = Utils
      L8_2 = L8_2.TableCopy
      L9_2 = L7_2
      L8_2 = L8_2(L9_2)
      L1_2[L6_2] = L8_2
    else
      L1_2[L6_2] = L7_2
    end
  end
  return L1_2
end
L0_1.TableCopy = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = 0
  L2_2 = pairs
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L1_2 = L1_2 + 1
  end
  return L1_2
end
L0_1.TableCount = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = {}
  function L2_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3
    L2_3 = tostring
    L3_3 = A0_3
    L2_3 = L2_3(L3_3)
    L3_3 = L1_2
    L2_3 = L3_3[L2_3]
    if L2_3 then
      L2_3 = print
      L3_3 = A1_3
      L4_3 = "*"
      L5_3 = tostring
      L6_3 = A0_3
      L5_3 = L5_3(L6_3)
      L3_3 = L3_3 .. L4_3 .. L5_3
      L2_3(L3_3)
    else
      L2_3 = tostring
      L3_3 = A0_3
      L2_3 = L2_3(L3_3)
      L3_3 = L1_2
      L3_3[L2_3] = true
      L2_3 = type
      L3_3 = A0_3
      L2_3 = L2_3(L3_3)
      if "table" == L2_3 then
        L2_3 = pairs
        L3_3 = A0_3
        L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3)
        for L6_3, L7_3 in L2_3, L3_3, L4_3, L5_3 do
          L8_3 = type
          L9_3 = L7_3
          L8_3 = L8_3(L9_3)
          if "table" == L8_3 then
            L8_3 = print
            L9_3 = A1_3
            L10_3 = "["
            L11_3 = L6_3
            L12_3 = "] => "
            L13_3 = tostring
            L14_3 = A0_3
            L13_3 = L13_3(L14_3)
            L14_3 = " {"
            L9_3 = L9_3 .. L10_3 .. L11_3 .. L12_3 .. L13_3 .. L14_3
            L8_3(L9_3)
            L8_3 = L2_2
            L9_3 = L7_3
            L10_3 = A1_3
            L11_3 = string
            L11_3 = L11_3.rep
            L12_3 = " "
            L13_3 = string
            L13_3 = L13_3.len
            L14_3 = L6_3
            L13_3 = L13_3(L14_3)
            L13_3 = L13_3 + 8
            L11_3 = L11_3(L12_3, L13_3)
            L10_3 = L10_3 .. L11_3
            L8_3(L9_3, L10_3)
            L8_3 = print
            L9_3 = A1_3
            L10_3 = string
            L10_3 = L10_3.rep
            L11_3 = " "
            L12_3 = string
            L12_3 = L12_3.len
            L13_3 = L6_3
            L12_3 = L12_3(L13_3)
            L12_3 = L12_3 + 6
            L10_3 = L10_3(L11_3, L12_3)
            L11_3 = "}"
            L9_3 = L9_3 .. L10_3 .. L11_3
            L8_3(L9_3)
          else
            L8_3 = print
            L9_3 = A1_3
            L10_3 = "["
            L11_3 = L6_3
            L12_3 = "] => "
            L13_3 = tostring
            L14_3 = L7_3
            L13_3 = L13_3(L14_3)
            L9_3 = L9_3 .. L10_3 .. L11_3 .. L12_3 .. L13_3
            L8_3(L9_3)
          end
        end
      else
        L2_3 = print
        L3_3 = A1_3
        L4_3 = tostring
        L5_3 = A0_3
        L4_3 = L4_3(L5_3)
        L3_3 = L3_3 .. L4_3
        L2_3(L3_3)
      end
    end
  end
  L3_2 = L2_2
  L4_2 = A0_2
  L5_2 = "  "
  L3_2(L4_2, L5_2)
end
L0_1.PrintT = L1_1
L0_1 = Utils
function L1_1(...)
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = print
  L1_2 = string
  L1_2 = L1_2.format
  L2_2 = "[%s]"
  L3_2 = Protected
  L3_2 = L3_2.ResourceName
  L1_2 = L1_2(L2_2, L3_2)
  L2_2, L3_2 = ...
  L0_2(L1_2, L2_2, L3_2)
end
L0_1.Log = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = AddBlipForCoord
  L2_2 = A0_2.location
  L2_2 = L2_2.x
  L3_2 = A0_2.location
  L3_2 = L3_2.y
  L4_2 = A0_2.location
  L4_2 = L4_2.z
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  L2_2 = false
  L3_2 = A0_2.shortRange
  if L3_2 then
    L2_2 = A0_2.shortRange
  end
  L3_2 = SetBlipSprite
  L4_2 = L1_2
  L5_2 = A0_2.sprite
  if not L5_2 then
    L5_2 = 1
  end
  L3_2(L4_2, L5_2)
  L3_2 = SetBlipColour
  L4_2 = L1_2
  L5_2 = A0_2.color
  if not L5_2 then
    L5_2 = 4
  end
  L3_2(L4_2, L5_2)
  L3_2 = SetBlipScale
  L4_2 = L1_2
  L5_2 = A0_2.scale
  if not L5_2 then
    L5_2 = 1.0
  end
  L3_2(L4_2, L5_2)
  L3_2 = SetBlipDisplay
  L4_2 = L1_2
  L5_2 = A0_2.display
  if not L5_2 then
    L5_2 = 4
  end
  L3_2(L4_2, L5_2)
  L3_2 = SetBlipAsShortRange
  L4_2 = L1_2
  L5_2 = L2_2
  L3_2(L4_2, L5_2)
  L3_2 = SetBlipHighDetail
  L4_2 = L1_2
  L5_2 = A0_2.highDetail
  if not L5_2 then
    L5_2 = true
  end
  L3_2(L4_2, L5_2)
  L3_2 = BeginTextCommandSetBlipName
  L4_2 = "STRING"
  L3_2(L4_2)
  L3_2 = AddTextComponentString
  L4_2 = A0_2.text
  L3_2(L4_2)
  L3_2 = EndTextCommandSetBlipName
  L4_2 = L1_2
  L3_2(L4_2)
  return L1_2
end
L0_1.CreateBlip = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2
  L1_2 = RemoveBlip
  L2_2 = A0_2
  L1_2(L2_2)
end
L0_1.RemoveBlip = L1_1
L0_1 = Utils
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  if not A0_2 or A1_2 then
    return
  end
  L2_2 = {}
  L2_2.name = A0_2
  L2_2.type = "marker"
  L2_2.opts = A1_2
  L3_2 = table
  L3_2 = L3_2.insert
  L4_2 = Utils
  L4_2 = L4_2.RenderList
  L5_2 = L2_2
  L3_2(L4_2, L5_2)
  return L2_2
end
L0_1.AddMarkerToRenderList = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = ipairs
  L2_2 = Utils
  L2_2 = L2_2.RenderList
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    if L6_2 == A0_2 then
      L7_2 = table
      L7_2 = L7_2.remove
      L8_2 = Utils
      L8_2 = L8_2.RenderList
      L9_2 = L5_2
      L7_2(L8_2, L9_2)
      return
    end
  end
end
L0_1.RemoveMarkerFromRenderList = L1_1
L0_1 = Utils
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  if not A0_2 or not A1_2 then
    return
  end
  L2_2 = {}
  L2_2.name = A0_2
  L2_2.type = "drawText"
  L2_2.opts = A1_2
  L3_2 = table
  L3_2 = L3_2.insert
  L4_2 = Utils
  L4_2 = L4_2.RenderList
  L5_2 = L2_2
  L3_2(L4_2, L5_2)
  return L2_2
end
L0_1.AddDrawTextToRenderList = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = ipairs
  L2_2 = Utils
  L2_2 = L2_2.RenderList
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    if L6_2 == A0_2 then
      L7_2 = table
      L7_2 = L7_2.remove
      L8_2 = Utils
      L8_2 = L8_2.RenderList
      L9_2 = L5_2
      L7_2(L8_2, L9_2)
      return
    end
  end
end
L0_1.RemoveDrawTextFromRenderList = L1_1
L0_1 = Utils
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  A1_2 = A1_2 / 57.2958
  L2_2 = math
  L2_2 = L2_2.cos
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  L3_2 = math
  L3_2 = L3_2.sin
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  L4_2 = type
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  if "vector4" == L4_2 then
    L4_2 = vector4
    L5_2 = A0_2.x
    L5_2 = L2_2 * L5_2
    L6_2 = A0_2.y
    L6_2 = L3_2 * L6_2
    L5_2 = L5_2 - L6_2
    L6_2 = A0_2.x
    L6_2 = L3_2 * L6_2
    L7_2 = A0_2.y
    L7_2 = L2_2 * L7_2
    L6_2 = L6_2 + L7_2
    L7_2 = A0_2.z
    L8_2 = A0_2.w
    return L4_2(L5_2, L6_2, L7_2, L8_2)
  else
    L4_2 = type
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    if "vector3" == L4_2 then
      L4_2 = vector3
      L5_2 = A0_2.x
      L5_2 = L2_2 * L5_2
      L6_2 = A0_2.y
      L6_2 = L3_2 * L6_2
      L5_2 = L5_2 - L6_2
      L6_2 = A0_2.x
      L6_2 = L3_2 * L6_2
      L7_2 = A0_2.y
      L7_2 = L2_2 * L7_2
      L6_2 = L6_2 + L7_2
      L7_2 = A0_2.z
      return L4_2(L5_2, L6_2, L7_2)
    else
      L4_2 = type
      L5_2 = A0_2
      L4_2 = L4_2(L5_2)
      if "vector2" == L4_2 then
        L4_2 = vector2
        L5_2 = A0_2.x
        L5_2 = L2_2 * L5_2
        L6_2 = A0_2.y
        L6_2 = L3_2 * L6_2
        L5_2 = L5_2 - L6_2
        L6_2 = A0_2.x
        L6_2 = L3_2 * L6_2
        L7_2 = A0_2.y
        L7_2 = L2_2 * L7_2
        L6_2 = L6_2 + L7_2
        return L4_2(L5_2, L6_2)
      end
    end
  end
end
L0_1.RotateVectorFlat = L1_1
L0_1 = Utils
function L1_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2)
  local L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L6_2 = CreateCamWithParams
  L7_2 = A0_2
  L8_2 = A1_2.x
  L9_2 = A1_2.y
  L10_2 = A1_2.z
  L11_2 = 0
  L12_2 = 0
  L13_2 = 0
  L14_2 = 50.0
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L7_2 = SetCamCoord
  L8_2 = L6_2
  L9_2 = A1_2.x
  L10_2 = A1_2.y
  L11_2 = A1_2.z
  L7_2(L8_2, L9_2, L10_2, L11_2)
  L7_2 = SetCamRot
  L8_2 = L6_2
  L9_2 = A2_2.x
  L10_2 = A2_2.y
  L11_2 = A2_2.z
  L12_2 = 2
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
  if A3_2 then
    L7_2 = SetCamActive
    L8_2 = L6_2
    L9_2 = true
    L7_2(L8_2, L9_2)
    L7_2 = RenderScriptCams
    L8_2 = true
    L9_2 = true
    L10_2 = A5_2 or L10_2
    if not A5_2 then
      L10_2 = 0
    end
    L11_2 = true
    L12_2 = true
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
  end
  if A4_2 then
    L7_2 = PointCamAtEntity
    L8_2 = L6_2
    L9_2 = A4_2
    L7_2(L8_2, L9_2)
  end
  return L6_2
end
L0_1.CreateCamera = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L1_2 = A0_2.location
  if L1_2 then
    L1_2 = A0_2.location
    L1_2 = L1_2.x
    if L1_2 then
      L1_2 = A0_2.location
      L1_2 = L1_2.y
      if L1_2 then
        L1_2 = A0_2.location
        L1_2 = L1_2.z
        if L1_2 then
          goto lbl_17
        end
      end
    end
  end
  do return end
  ::lbl_17::
  L1_2 = DrawMarker
  L2_2 = A0_2.type
  if not L2_2 then
    L2_2 = 0
  end
  L3_2 = A0_2.location
  L3_2 = L3_2.x
  L4_2 = A0_2.location
  L4_2 = L4_2.y
  L5_2 = A0_2.location
  L5_2 = L5_2.z
  L6_2 = A0_2.direction
  if L6_2 then
    L6_2 = A0_2.direction
    L6_2 = L6_2.x
    if L6_2 then
      goto lbl_36
    end
  end
  L6_2 = 1.0
  ::lbl_36::
  L7_2 = A0_2.direction
  if L7_2 then
    L7_2 = A0_2.direction
    L7_2 = L7_2.y
    if L7_2 then
      goto lbl_44
    end
  end
  L7_2 = 0.0
  ::lbl_44::
  L8_2 = A0_2.direction
  if L8_2 then
    L8_2 = A0_2.direction
    L8_2 = L8_2.z
    if L8_2 then
      goto lbl_52
    end
  end
  L8_2 = 0.0
  ::lbl_52::
  L9_2 = A0_2.rotation
  if L9_2 then
    L9_2 = A0_2.rotation
    L9_2 = L9_2.x
    if L9_2 then
      goto lbl_60
    end
  end
  L9_2 = 1.0
  ::lbl_60::
  L10_2 = A0_2.rotation
  if L10_2 then
    L10_2 = A0_2.rotation
    L10_2 = L10_2.y
    if L10_2 then
      goto lbl_68
    end
  end
  L10_2 = 0.0
  ::lbl_68::
  L11_2 = A0_2.rotation
  if L11_2 then
    L11_2 = A0_2.rotation
    L11_2 = L11_2.z
    if L11_2 then
      goto lbl_76
    end
  end
  L11_2 = 0.0
  ::lbl_76::
  L12_2 = A0_2.scale
  if L12_2 then
    L12_2 = A0_2.scale
    L12_2 = L12_2.x
    if L12_2 then
      goto lbl_84
    end
  end
  L12_2 = 1.0
  ::lbl_84::
  L13_2 = A0_2.scale
  if L13_2 then
    L13_2 = A0_2.scale
    L13_2 = L13_2.y
    if L13_2 then
      goto lbl_92
    end
  end
  L13_2 = 1.0
  ::lbl_92::
  L14_2 = A0_2.scale
  if L14_2 then
    L14_2 = A0_2.scale
    L14_2 = L14_2.z
    if L14_2 then
      goto lbl_100
    end
  end
  L14_2 = 1.0
  ::lbl_100::
  L15_2 = A0_2.red
  if not L15_2 then
    L15_2 = 255
  end
  L16_2 = A0_2.green
  if not L16_2 then
    L16_2 = 255
  end
  L17_2 = A0_2.blue
  if not L17_2 then
    L17_2 = 255
  end
  L18_2 = A0_2.alpha
  if not L18_2 then
    L18_2 = 255
  end
  L19_2 = A0_2.bobUpAndDown
  if not L19_2 then
    L19_2 = false
  end
  L20_2 = A0_2.faceCamera
  L20_2 = nil == L20_2 or L20_2
  L21_2 = A0_2.p19
  if not L21_2 then
    L21_2 = 2
  end
  L22_2 = A0_2.rotate
  if not L22_2 then
    L22_2 = false
  end
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
end
L0_1.DrawMarker = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SetNotificationTextEntry
  L2_2 = "STRING"
  L1_2(L2_2)
  L1_2 = AddTextComponentSubstringPlayerName
  L2_2 = A0_2
  L1_2(L2_2)
  L1_2 = DrawNotification
  L2_2 = false
  L3_2 = true
  L1_2(L2_2, L3_2)
end
L0_1.ShowNotification = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = AddTextEntry
  L2_2 = "housingHelp"
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
  L1_2 = DisplayHelpTextThisFrame
  L2_2 = "housingHelp"
  L3_2 = false
  L1_2(L2_2, L3_2)
end
L0_1.ShowHelpNotification = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = vector3
  L2_2 = A0_2.location
  L2_2 = L2_2.x
  L3_2 = A0_2.location
  L3_2 = L3_2.y
  L4_2 = A0_2.location
  L4_2 = L4_2.z
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  L2_2 = World3dToScreen2d
  L3_2 = L1_2.x
  L4_2 = L1_2.y
  L5_2 = L1_2.z
  L2_2, L3_2, L4_2 = L2_2(L3_2, L4_2, L5_2)
  L5_2 = GetGameplayCamCoords
  L5_2 = L5_2()
  L6_2 = GetDistanceBetweenCoords
  L7_2 = L5_2
  L8_2 = L1_2.x
  L9_2 = L1_2.y
  L10_2 = L1_2.z
  L11_2 = true
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  L7_2 = size
  L8_2 = A0_2.size
  if not L8_2 then
    L8_2 = 1
  end
  L9_2 = L8_2 / L6_2
  L9_2 = L9_2 * 2
  L10_2 = GetGameplayCamFov
  L10_2 = L10_2()
  L11_2 = 1
  L10_2 = L11_2 / L10_2
  L10_2 = L10_2 * 100
  L9_2 = L9_2 * L10_2
  if L2_2 then
    L11_2 = SetTextScale
    L12_2 = 0.0 * L9_2
    L13_2 = 0.55 * L9_2
    L11_2(L12_2, L13_2)
    L11_2 = SetTextFont
    L12_2 = A0_2.font
    if not L12_2 then
      L12_2 = 1
    end
    L11_2(L12_2)
    L11_2 = SetTextColour
    L12_2 = A0_2.red
    if not L12_2 then
      L12_2 = 255
    end
    L13_2 = A0_2.green
    if not L13_2 then
      L13_2 = 255
    end
    L14_2 = A0_2.blue
    if not L14_2 then
      L14_2 = 255
    end
    L15_2 = A0_2.alpha
    if not L15_2 then
      L15_2 = 255
    end
    L11_2(L12_2, L13_2, L14_2, L15_2)
    L11_2 = SetTextDropshadow
    L12_2 = 0
    L13_2 = 0
    L14_2 = 0
    L15_2 = 0
    L16_2 = 255
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
    L11_2 = SetTextDropShadow
    L11_2()
    L11_2 = SetTextOutline
    L11_2()
    L11_2 = SetTextEntry
    L12_2 = "STRING"
    L11_2(L12_2)
    L11_2 = SetTextCentre
    L12_2 = 1
    L11_2(L12_2)
    L11_2 = AddTextComponentString
    L12_2 = A0_2.text
    L11_2(L12_2)
    L11_2 = DrawText
    L12_2 = L3_2
    L13_2 = L4_2
    L11_2(L12_2, L13_2)
  end
end
L0_1.DrawText3D = L1_1
L0_1 = IsDuplicityVersion
L0_1 = L0_1()
if L0_1 then
  L0_1 = Utils
  function L1_1(A0_2, A1_2, ...)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    L2_2 = string
    L2_2 = L2_2.format
    L3_2 = "%s:%s"
    L4_2 = Protected
    L4_2 = L4_2.ResourceName
    L5_2 = A0_2
    L2_2 = L2_2(L3_2, L4_2, L5_2)
    L3_2 = TriggerClientEvent
    L4_2 = L2_2
    L5_2 = A1_2
    L6_2, L7_2 = ...
    L3_2(L4_2, L5_2, L6_2, L7_2)
    L3_2 = Config
    L3_2 = L3_2.Debug
    if L3_2 then
      L3_2 = Utils
      L3_2 = L3_2.Log
      L4_2 = string
      L4_2 = L4_2.format
      L5_2 = "Triggering client event: %s (%i)."
      L6_2 = L2_2
      L7_2 = A1_2
      L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2, L6_2, L7_2)
      L3_2(L4_2, L5_2, L6_2, L7_2)
    end
  end
  L0_1.TriggerClientEvent = L1_1
  L0_1 = Utils
  function L1_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
    L0_2 = GetConvar
    L1_2 = "mysql_connection_string"
    L2_2 = "Empty"
    L0_2 = L0_2(L1_2, L2_2)
    if not L0_2 or "Empty" == L0_2 then
      L1_2 = false
      return L1_2
    else
      L1_2 = string
      L1_2 = L1_2.find
      L2_2 = L0_2
      L3_2 = "database="
      L1_2, L2_2 = L1_2(L2_2, L3_2)
      if not L1_2 or not L2_2 then
        L3_2 = string
        L3_2 = L3_2.find
        L4_2 = L0_2
        L5_2 = "mysql://"
        L3_2, L4_2 = L3_2(L4_2, L5_2)
        if not L3_2 or not L4_2 then
          L5_2 = false
          return L5_2
        else
          L5_2 = string
          L5_2 = L5_2.find
          L6_2 = L0_2
          L7_2 = "@"
          L8_2 = L4_2
          L5_2, L6_2 = L5_2(L6_2, L7_2, L8_2)
          L7_2 = string
          L7_2 = L7_2.find
          L8_2 = L0_2
          L9_2 = "/"
          L10_2 = L6_2 + 1
          L7_2, L8_2 = L7_2(L8_2, L9_2, L10_2)
          L9_2 = string
          L9_2 = L9_2.find
          L10_2 = L0_2
          L11_2 = "?"
          L9_2, L10_2 = L9_2(L10_2, L11_2)
          if L10_2 then
            L11_2 = L10_2 - 1
            if L11_2 then
              goto lbl_59
            end
          end
          L12_2 = L0_2
          L11_2 = L0_2.len
          L11_2 = L11_2(L12_2)
          ::lbl_59::
          L12_2 = string
          L12_2 = L12_2.sub
          L13_2 = L0_2
          L14_2 = L8_2 + 1
          L15_2 = L11_2
          L12_2 = L12_2(L13_2, L14_2, L15_2)
          return L12_2
        end
      else
        L3_2 = string
        L3_2 = L3_2.find
        L4_2 = L0_2
        L5_2 = ";"
        L6_2 = L2_2
        L3_2, L4_2 = L3_2(L4_2, L5_2, L6_2)
        L5_2 = string
        L5_2 = L5_2.sub
        L6_2 = L0_2
        L7_2 = L2_2 + 1
        if L4_2 then
          L8_2 = L4_2 - 1
          if L8_2 then
            goto lbl_87
          end
        end
        L9_2 = L0_2
        L8_2 = L0_2.len
        L8_2 = L8_2(L9_2)
        ::lbl_87::
        L5_2 = L5_2(L6_2, L7_2, L8_2)
        return L5_2
      end
    end
  end
  L0_1.GetDatabaseName = L1_1
else
  L0_1 = Utils
  function L1_1(A0_2, ...)
    local L1_2, L2_2, L3_2, L4_2, L5_2
    L1_2 = string
    L1_2 = L1_2.format
    L2_2 = "%s:%s"
    L3_2 = Protected
    L3_2 = L3_2.ResourceName
    L4_2 = A0_2
    L1_2 = L1_2(L2_2, L3_2, L4_2)
    L2_2 = TriggerServerEvent
    L3_2 = L1_2
    L4_2, L5_2 = ...
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = Config
    L2_2 = L2_2.Debug
    if L2_2 then
      L2_2 = Utils
      L2_2 = L2_2.Log
      L3_2 = string
      L3_2 = L3_2.format
      L4_2 = "Triggering server event: %s."
      L5_2 = L1_2
      L3_2, L4_2, L5_2 = L3_2(L4_2, L5_2)
      L2_2(L3_2, L4_2, L5_2)
    end
  end
  L0_1.TriggerServerEvent = L1_1
end
L0_1 = Utils
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = string
  L2_2 = L2_2.format
  L3_2 = "%s:%s"
  L4_2 = Protected
  L4_2 = L4_2.ResourceName
  L5_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = RegisterNetEvent
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = Config
  L3_2 = L3_2.Debug
  if L3_2 then
    L3_2 = Utils
    L3_2 = L3_2.Log
    L4_2 = string
    L4_2 = L4_2.format
    L5_2 = "Net event %s registered."
    L6_2 = L2_2
    L4_2, L5_2, L6_2 = L4_2(L5_2, L6_2)
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = AddEventHandler
    L4_2 = L2_2
    function L5_2(...)
      local L0_3, L1_3, L2_3, L3_3
      L0_3 = Utils
      L0_3 = L0_3.Log
      L1_3 = string
      L1_3 = L1_3.format
      L2_3 = "Net event %s triggered."
      L3_3 = L2_2
      L1_3, L2_3, L3_3 = L1_3(L2_3, L3_3)
      L0_3(L1_3, L2_3, L3_3)
      L0_3 = A1_2
      L1_3, L2_3, L3_3 = ...
      L0_3(L1_3, L2_3, L3_3)
    end
    L3_2(L4_2, L5_2)
  else
    L3_2 = AddEventHandler
    L4_2 = L2_2
    L5_2 = A1_2
    L3_2(L4_2, L5_2)
  end
end
L0_1.RegisterNetEvent = L1_1
L0_1 = Utils
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = string
  L2_2 = L2_2.format
  L3_2 = "%s:%s"
  L4_2 = Protected
  L4_2 = L4_2.ResourceName
  L5_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = AddEventHandler
  L4_2 = L2_2
  L5_2 = A1_2
  L3_2(L4_2, L5_2)
end
L0_1.RegisterEvent = L1_1
L0_1 = Utils
function L1_1(...)
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = select
  L1_2 = "#"
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = ...
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L1_2 = 1
  L2_2 = L0_2
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = select
    L6_2 = L4_2
    L7_2, L8_2, L9_2 = ...
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
    L6_2 = DisableControlAction
    L7_2 = 0
    L8_2 = L5_2
    L9_2 = true
    L6_2(L7_2, L8_2, L9_2)
  end
end
L0_1.DisableControlActions = L1_1
L0_1 = Utils
function L1_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L5_2 = Utils
  L5_2 = L5_2.GetEntityBoundingBox
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  L6_2 = Utils
  L6_2 = L6_2.DrawBoundingBox
  L7_2 = L5_2
  L8_2 = A1_2
  L9_2 = A2_2
  L10_2 = A3_2
  L11_2 = A4_2
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
end
L0_1.DrawEntityBoundingBox = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = GetModelDimensions
  L2_2 = GetEntityModel
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2(L3_2)
  L1_2, L2_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L3_2 = 0.001
  L4_2 = {}
  L5_2 = GetOffsetFromEntityInWorldCoords
  L6_2 = A0_2
  L7_2 = L1_2.x
  L7_2 = L7_2 - L3_2
  L8_2 = L1_2.y
  L8_2 = L8_2 - L3_2
  L9_2 = L1_2.z
  L9_2 = L9_2 - L3_2
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L4_2[1] = L5_2
  L5_2 = GetOffsetFromEntityInWorldCoords
  L6_2 = A0_2
  L7_2 = L2_2.x
  L7_2 = L7_2 + L3_2
  L8_2 = L1_2.y
  L8_2 = L8_2 - L3_2
  L9_2 = L1_2.z
  L9_2 = L9_2 - L3_2
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L4_2[2] = L5_2
  L5_2 = GetOffsetFromEntityInWorldCoords
  L6_2 = A0_2
  L7_2 = L2_2.x
  L7_2 = L7_2 + L3_2
  L8_2 = L2_2.y
  L8_2 = L8_2 + L3_2
  L9_2 = L1_2.z
  L9_2 = L9_2 - L3_2
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L4_2[3] = L5_2
  L5_2 = GetOffsetFromEntityInWorldCoords
  L6_2 = A0_2
  L7_2 = L1_2.x
  L7_2 = L7_2 - L3_2
  L8_2 = L2_2.y
  L8_2 = L8_2 + L3_2
  L9_2 = L1_2.z
  L9_2 = L9_2 - L3_2
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L4_2[4] = L5_2
  L5_2 = GetOffsetFromEntityInWorldCoords
  L6_2 = A0_2
  L7_2 = L1_2.x
  L7_2 = L7_2 - L3_2
  L8_2 = L1_2.y
  L8_2 = L8_2 - L3_2
  L9_2 = L2_2.z
  L9_2 = L9_2 + L3_2
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L4_2[5] = L5_2
  L5_2 = GetOffsetFromEntityInWorldCoords
  L6_2 = A0_2
  L7_2 = L2_2.x
  L7_2 = L7_2 + L3_2
  L8_2 = L1_2.y
  L8_2 = L8_2 - L3_2
  L9_2 = L2_2.z
  L9_2 = L9_2 + L3_2
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L4_2[6] = L5_2
  L5_2 = GetOffsetFromEntityInWorldCoords
  L6_2 = A0_2
  L7_2 = L2_2.x
  L7_2 = L7_2 + L3_2
  L8_2 = L2_2.y
  L8_2 = L8_2 + L3_2
  L9_2 = L2_2.z
  L9_2 = L9_2 + L3_2
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L4_2[7] = L5_2
  L5_2 = GetOffsetFromEntityInWorldCoords
  L6_2 = A0_2
  L7_2 = L1_2.x
  L7_2 = L7_2 - L3_2
  L8_2 = L2_2.y
  L8_2 = L8_2 + L3_2
  L9_2 = L2_2.z
  L9_2 = L9_2 + L3_2
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L4_2[8] = L5_2
  return L4_2
end
L0_1.GetEntityBoundingBox = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = GetModelDimensions
  L2_2 = GetEntityModel
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2(L3_2)
  L1_2, L2_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L3_2 = 0.001
  L4_2 = {}
  L5_2 = GetOffsetFromEntityInWorldCoords
  L6_2 = A0_2
  L7_2 = L1_2.x
  L7_2 = L7_2 - L3_2
  L8_2 = L1_2.y
  L8_2 = L8_2 - L3_2
  L9_2 = L1_2.z
  L9_2 = L9_2 - L3_2
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L4_2[1] = L5_2
  L5_2 = GetOffsetFromEntityInWorldCoords
  L6_2 = A0_2
  L7_2 = L2_2.x
  L7_2 = L7_2 + L3_2
  L8_2 = L1_2.y
  L8_2 = L8_2 - L3_2
  L9_2 = L1_2.z
  L9_2 = L9_2 - L3_2
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L4_2[2] = L5_2
  L5_2 = GetOffsetFromEntityInWorldCoords
  L6_2 = A0_2
  L7_2 = L2_2.x
  L7_2 = L7_2 + L3_2
  L8_2 = L2_2.y
  L8_2 = L8_2 + L3_2
  L9_2 = L1_2.z
  L9_2 = L9_2 - L3_2
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L4_2[3] = L5_2
  L5_2 = GetOffsetFromEntityInWorldCoords
  L6_2 = A0_2
  L7_2 = L1_2.x
  L7_2 = L7_2 - L3_2
  L8_2 = L2_2.y
  L8_2 = L8_2 + L3_2
  L9_2 = L1_2.z
  L9_2 = L9_2 - L3_2
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L4_2[4] = L5_2
  return L4_2
end
L0_1.Get2DEntityBoundingBox = L1_1
L0_1 = Utils
function L1_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L5_2 = Utils
  L5_2 = L5_2.GetBoundingBoxPolyMatrix
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  L6_2 = Utils
  L6_2 = L6_2.GetBoundingBoxEdgeMatrix
  L7_2 = A0_2
  L6_2 = L6_2(L7_2)
  L7_2 = Utils
  L7_2 = L7_2.DrawPolyMatrix
  L8_2 = L5_2
  L9_2 = A1_2
  L10_2 = A2_2
  L11_2 = A3_2
  L12_2 = A4_2
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
  L7_2 = Utils
  L7_2 = L7_2.DrawEdgeMatrix
  L8_2 = L6_2
  L9_2 = 255
  L10_2 = 255
  L11_2 = 255
  L12_2 = 255
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
end
L0_1.DrawBoundingBox = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = {}
  L2_2 = {}
  L3_2 = A0_2[3]
  L2_2[1] = L3_2
  L3_2 = A0_2[2]
  L2_2[2] = L3_2
  L3_2 = A0_2[1]
  L2_2[3] = L3_2
  L1_2[1] = L2_2
  L2_2 = {}
  L3_2 = A0_2[4]
  L2_2[1] = L3_2
  L3_2 = A0_2[3]
  L2_2[2] = L3_2
  L3_2 = A0_2[1]
  L2_2[3] = L3_2
  L1_2[2] = L2_2
  L2_2 = {}
  L3_2 = A0_2[5]
  L2_2[1] = L3_2
  L3_2 = A0_2[6]
  L2_2[2] = L3_2
  L3_2 = A0_2[7]
  L2_2[3] = L3_2
  L1_2[3] = L2_2
  L2_2 = {}
  L3_2 = A0_2[5]
  L2_2[1] = L3_2
  L3_2 = A0_2[7]
  L2_2[2] = L3_2
  L3_2 = A0_2[8]
  L2_2[3] = L3_2
  L1_2[4] = L2_2
  L2_2 = {}
  L3_2 = A0_2[3]
  L2_2[1] = L3_2
  L3_2 = A0_2[4]
  L2_2[2] = L3_2
  L3_2 = A0_2[7]
  L2_2[3] = L3_2
  L1_2[5] = L2_2
  L2_2 = {}
  L3_2 = A0_2[8]
  L2_2[1] = L3_2
  L3_2 = A0_2[7]
  L2_2[2] = L3_2
  L3_2 = A0_2[4]
  L2_2[3] = L3_2
  L1_2[6] = L2_2
  L2_2 = {}
  L3_2 = A0_2[1]
  L2_2[1] = L3_2
  L3_2 = A0_2[2]
  L2_2[2] = L3_2
  L3_2 = A0_2[5]
  L2_2[3] = L3_2
  L1_2[7] = L2_2
  L2_2 = {}
  L3_2 = A0_2[6]
  L2_2[1] = L3_2
  L3_2 = A0_2[5]
  L2_2[2] = L3_2
  L3_2 = A0_2[2]
  L2_2[3] = L3_2
  L1_2[8] = L2_2
  L2_2 = {}
  L3_2 = A0_2[2]
  L2_2[1] = L3_2
  L3_2 = A0_2[3]
  L2_2[2] = L3_2
  L3_2 = A0_2[6]
  L2_2[3] = L3_2
  L1_2[9] = L2_2
  L2_2 = {}
  L3_2 = A0_2[3]
  L2_2[1] = L3_2
  L3_2 = A0_2[7]
  L2_2[2] = L3_2
  L3_2 = A0_2[6]
  L2_2[3] = L3_2
  L1_2[10] = L2_2
  L2_2 = {}
  L3_2 = A0_2[5]
  L2_2[1] = L3_2
  L3_2 = A0_2[8]
  L2_2[2] = L3_2
  L3_2 = A0_2[4]
  L2_2[3] = L3_2
  L1_2[11] = L2_2
  L2_2 = {}
  L3_2 = A0_2[5]
  L2_2[1] = L3_2
  L3_2 = A0_2[4]
  L2_2[2] = L3_2
  L3_2 = A0_2[1]
  L2_2[3] = L3_2
  L1_2[12] = L2_2
  return L1_2
end
L0_1.GetBoundingBoxPolyMatrix = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = {}
  L2_2 = {}
  L3_2 = A0_2[1]
  L2_2[1] = L3_2
  L3_2 = A0_2[2]
  L2_2[2] = L3_2
  L1_2[1] = L2_2
  L2_2 = {}
  L3_2 = A0_2[2]
  L2_2[1] = L3_2
  L3_2 = A0_2[3]
  L2_2[2] = L3_2
  L1_2[2] = L2_2
  L2_2 = {}
  L3_2 = A0_2[3]
  L2_2[1] = L3_2
  L3_2 = A0_2[4]
  L2_2[2] = L3_2
  L1_2[3] = L2_2
  L2_2 = {}
  L3_2 = A0_2[4]
  L2_2[1] = L3_2
  L3_2 = A0_2[1]
  L2_2[2] = L3_2
  L1_2[4] = L2_2
  L2_2 = {}
  L3_2 = A0_2[5]
  L2_2[1] = L3_2
  L3_2 = A0_2[6]
  L2_2[2] = L3_2
  L1_2[5] = L2_2
  L2_2 = {}
  L3_2 = A0_2[6]
  L2_2[1] = L3_2
  L3_2 = A0_2[7]
  L2_2[2] = L3_2
  L1_2[6] = L2_2
  L2_2 = {}
  L3_2 = A0_2[7]
  L2_2[1] = L3_2
  L3_2 = A0_2[8]
  L2_2[2] = L3_2
  L1_2[7] = L2_2
  L2_2 = {}
  L3_2 = A0_2[8]
  L2_2[1] = L3_2
  L3_2 = A0_2[5]
  L2_2[2] = L3_2
  L1_2[8] = L2_2
  L2_2 = {}
  L3_2 = A0_2[1]
  L2_2[1] = L3_2
  L3_2 = A0_2[5]
  L2_2[2] = L3_2
  L1_2[9] = L2_2
  L2_2 = {}
  L3_2 = A0_2[2]
  L2_2[1] = L3_2
  L3_2 = A0_2[6]
  L2_2[2] = L3_2
  L1_2[10] = L2_2
  L2_2 = {}
  L3_2 = A0_2[3]
  L2_2[1] = L3_2
  L3_2 = A0_2[7]
  L2_2[2] = L3_2
  L1_2[11] = L2_2
  L2_2 = {}
  L3_2 = A0_2[4]
  L2_2[1] = L3_2
  L3_2 = A0_2[8]
  L2_2[2] = L3_2
  L1_2[12] = L2_2
  return L1_2
end
L0_1.GetBoundingBoxEdgeMatrix = L1_1
L0_1 = Utils
function L1_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  L5_2 = 1
  L6_2 = #A0_2
  L7_2 = 1
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = A0_2[L8_2]
    L10_2 = DrawPoly
    L11_2 = L9_2[1]
    L11_2 = L11_2.x
    L12_2 = L9_2[1]
    L12_2 = L12_2.y
    L13_2 = L9_2[1]
    L13_2 = L13_2.z
    L14_2 = L9_2[2]
    L14_2 = L14_2.x
    L15_2 = L9_2[2]
    L15_2 = L15_2.y
    L16_2 = L9_2[2]
    L16_2 = L16_2.z
    L17_2 = L9_2[3]
    L17_2 = L17_2.x
    L18_2 = L9_2[3]
    L18_2 = L18_2.y
    L19_2 = L9_2[3]
    L19_2 = L19_2.z
    L20_2 = A1_2
    L21_2 = A2_2
    L22_2 = A3_2
    L23_2 = A4_2
    L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
  end
end
L0_1.DrawPolyMatrix = L1_1
L0_1 = Utils
function L1_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L5_2 = 1
  L6_2 = #A0_2
  L7_2 = 1
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = A0_2[L8_2]
    L10_2 = DrawLine
    L11_2 = L9_2[1]
    L11_2 = L11_2.x
    L12_2 = L9_2[1]
    L12_2 = L12_2.y
    L13_2 = L9_2[1]
    L13_2 = L13_2.z
    L14_2 = L9_2[2]
    L14_2 = L14_2.x
    L15_2 = L9_2[2]
    L15_2 = L15_2.y
    L16_2 = L9_2[2]
    L16_2 = L16_2.z
    L17_2 = A1_2
    L18_2 = A2_2
    L19_2 = A3_2
    L20_2 = A4_2
    L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  end
end
L0_1.DrawEdgeMatrix = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = DrawScaleformMovieFullscreen
  L2_2 = A0_2
  L3_2 = 255
  L4_2 = 255
  L5_2 = 255
  L6_2 = 255
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
end
L0_1.DrawScaleform = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = DisableControlAction
  L2_2 = 0
  L3_2 = A0_2
  L4_2 = true
  L1_2(L2_2, L3_2, L4_2)
end
L0_1.DisableControlAction = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = Scaleforms
  L1_2 = L1_2.LoadMovie
  L2_2 = "INSTRUCTIONAL_BUTTONS"
  L1_2 = L1_2(L2_2)
  L2_2 = Scaleforms
  L2_2 = L2_2.PopVoid
  L3_2 = L1_2
  L4_2 = "CLEAR_ALL"
  L2_2(L3_2, L4_2)
  L2_2 = Scaleforms
  L2_2 = L2_2.PopInt
  L3_2 = L1_2
  L4_2 = "SET_CLEAR_SPACE"
  L5_2 = 200
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = 1
  L3_2 = #A0_2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = PushScaleformMovieFunction
    L7_2 = L1_2
    L8_2 = "SET_DATA_SLOT"
    L6_2(L7_2, L8_2)
    L6_2 = PushScaleformMovieFunctionParameterInt
    L7_2 = L5_2 - 1
    L6_2(L7_2)
    L6_2 = 1
    L7_2 = A0_2[L5_2]
    L7_2 = L7_2.codes
    L7_2 = #L7_2
    L8_2 = 1
    for L9_2 = L6_2, L7_2, L8_2 do
      L10_2 = _ENV
      L11_2 = "ScaleformMovieMethodAddParamPlayerNameString"
      L10_2 = L10_2[L11_2]
      L11_2 = GetControlInstructionalButton
      L12_2 = 0
      L13_2 = A0_2[L5_2]
      L13_2 = L13_2.codes
      L13_2 = L13_2[L9_2]
      L14_2 = true
      L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2, L13_2, L14_2)
      L10_2(L11_2, L12_2, L13_2, L14_2)
    end
    L6_2 = BeginTextCommandScaleformString
    L7_2 = "STRING"
    L6_2(L7_2)
    L6_2 = AddTextComponentScaleform
    L7_2 = A0_2[L5_2]
    L7_2 = L7_2.label
    L6_2(L7_2)
    L6_2 = EndTextCommandScaleformString
    L6_2()
    L6_2 = PopScaleformMovieFunctionVoid
    L6_2()
  end
  L2_2 = Scaleforms
  L2_2 = L2_2.PopVoid
  L3_2 = L1_2
  L4_2 = "DRAW_INSTRUCTIONAL_BUTTONS"
  L2_2(L3_2, L4_2)
  return L1_2
end
L0_1.CreateInstructional = L1_1
L0_1 = Utils
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = {}
  L2_2 = #A0_2
  L3_2 = 1
  L4_2 = L2_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = A0_2[L6_2]
    L8_2 = nil
    L9_2 = type
    L10_2 = L7_2
    L9_2 = L9_2(L10_2)
    if "table" == L9_2 then
      L9_2 = ActionControls
      L10_2 = L7_2.key
      L8_2 = L9_2[L10_2]
      if not L8_2 then
        L9_2 = Error
        L10_2 = "Utils.GetControls ::: "
        L11_2 = L7_2.key
        L12_2 = " not found"
        L10_2 = L10_2 .. L11_2 .. L12_2
        L9_2(L10_2)
        return
      end
      L9_2 = L7_2.label
      L8_2.label = L9_2
    else
      L9_2 = ActionControls
      L8_2 = L9_2[L7_2]
    end
    L9_2 = #L1_2
    L9_2 = L9_2 + 1
    L1_2[L9_2] = L8_2
  end
  return L1_2
end
L0_1.GetControls = L1_1
L0_1 = false
L1_1 = false
L2_1 = Utils
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  if not A1_2 then
    L2_2 = {}
    A1_2 = L2_2
  end
  L2_2 = A1_2.boundPos
  L3_2 = A1_2.boundDist
  L4_2 = A1_2.mouse
  if nil == L4_2 then
    L4_2 = true
    if L4_2 then
      goto lbl_15
    end
  end
  L4_2 = A1_2.mouse
  ::lbl_15::
  A1_2.mouse = L4_2
  L4_2 = A1_2.keyboard
  if nil == L4_2 then
    L4_2 = true
    if L4_2 then
      goto lbl_23
    end
  end
  L4_2 = A1_2.keyboard
  ::lbl_23::
  A1_2.keyboard = L4_2
  L4_2 = GetCamCoord
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L5_2 = GetCamRot
  L6_2 = A0_2
  L7_2 = 2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = ActionControls
  L7_2 = CameraOptions
  L8_2 = GetDisabledControlNormal
  L9_2 = 0
  L10_2 = 1
  L8_2 = L8_2(L9_2, L10_2)
  L9_2 = GetDisabledControlNormal
  L10_2 = 0
  L11_2 = 2
  L9_2 = L9_2(L10_2, L11_2)
  L10_2 = GetCamMatrix
  L11_2 = A0_2
  L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
  L14_2 = vector3
  L15_2 = 0.0
  L16_2 = 0.0
  L17_2 = 1.0
  L14_2 = L14_2(L15_2, L16_2, L17_2)
  L15_2 = norm
  L16_2 = vector3
  L17_2 = L10_2.x
  L18_2 = L10_2.y
  L19_2 = 0.0
  L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L16_2(L17_2, L18_2, L19_2)
  L15_2 = L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
  L16_2 = norm
  L17_2 = vector3
  L18_2 = L11_2.x
  L19_2 = L11_2.y
  L20_2 = 0.0
  L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L17_2(L18_2, L19_2, L20_2)
  L16_2 = L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
  L17_2 = GetFrameTime
  L17_2 = L17_2()
  L18_2 = A1_2.keyboard
  if L18_2 then
    L18_2 = IsDisabledControlPressed
    L19_2 = 0
    L20_2 = L6_2.up
    L20_2 = L20_2.codes
    L20_2 = L20_2[2]
    L18_2 = L18_2(L19_2, L20_2)
    if L18_2 then
      L18_2 = L7_2.climbSpeed
      L18_2 = L18_2 * L17_2
      L18_2 = L14_2 * L18_2
      L4_2 = L4_2 + L18_2
      L18_2 = true
      L0_1 = L18_2
    else
      L18_2 = IsDisabledControlPressed
      L19_2 = 0
      L20_2 = L6_2.up
      L20_2 = L20_2.codes
      L20_2 = L20_2[1]
      L18_2 = L18_2(L19_2, L20_2)
      if L18_2 then
        L18_2 = L7_2.climbSpeed
        L18_2 = L18_2 * L17_2
        L18_2 = L14_2 * L18_2
        L4_2 = L4_2 - L18_2
        L18_2 = true
        L0_1 = L18_2
      end
    end
    L18_2 = IsDisabledControlPressed
    L19_2 = 0
    L20_2 = L6_2.forward
    L20_2 = L20_2.codes
    L20_2 = L20_2[2]
    L18_2 = L18_2(L19_2, L20_2)
    if L18_2 then
      L18_2 = L7_2.moveSpeed
      L18_2 = L18_2 * L17_2
      L18_2 = L16_2 * L18_2
      L4_2 = L4_2 + L18_2
      L18_2 = true
      L0_1 = L18_2
    else
      L18_2 = IsDisabledControlPressed
      L19_2 = 0
      L20_2 = L6_2.forward
      L20_2 = L20_2.codes
      L20_2 = L20_2[1]
      L18_2 = L18_2(L19_2, L20_2)
      if L18_2 then
        L18_2 = L7_2.moveSpeed
        L18_2 = L18_2 * L17_2
        L18_2 = L16_2 * L18_2
        L4_2 = L4_2 - L18_2
        L18_2 = true
        L0_1 = L18_2
      end
    end
    L18_2 = IsDisabledControlPressed
    L19_2 = 0
    L20_2 = L6_2.right
    L20_2 = L20_2.codes
    L20_2 = L20_2[1]
    L18_2 = L18_2(L19_2, L20_2)
    if L18_2 then
      L18_2 = L7_2.moveSpeed
      L18_2 = L18_2 * L17_2
      L18_2 = L15_2 * L18_2
      L4_2 = L4_2 + L18_2
      L18_2 = true
      L0_1 = L18_2
    else
      L18_2 = IsDisabledControlPressed
      L19_2 = 0
      L20_2 = L6_2.right
      L20_2 = L20_2.codes
      L20_2 = L20_2[2]
      L18_2 = L18_2(L19_2, L20_2)
      if L18_2 then
        L18_2 = L7_2.moveSpeed
        L18_2 = L18_2 * L17_2
        L18_2 = L15_2 * L18_2
        L4_2 = L4_2 - L18_2
        L18_2 = true
        L0_1 = L18_2
      end
    end
  end
  L18_2 = A1_2.mouse
  if L18_2 then
    if 0.0 ~= L9_2 then
      L18_2 = math
      L18_2 = L18_2.max
      L19_2 = -80.0
      L20_2 = math
      L20_2 = L20_2.min
      L21_2 = 80.0
      L22_2 = L5_2.x
      L23_2 = L7_2.lookSpeedX
      L23_2 = L9_2 * L23_2
      L23_2 = L23_2 * L17_2
      L22_2 = L22_2 - L23_2
      L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L20_2(L21_2, L22_2)
      L18_2 = L18_2(L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
      L19_2 = vector3
      L20_2 = L18_2
      L21_2 = L5_2.y
      L22_2 = L5_2.z
      L19_2 = L19_2(L20_2, L21_2, L22_2)
      L5_2 = L19_2
      L19_2 = true
      L1_1 = L19_2
    end
    if 0.0 ~= L8_2 then
      L18_2 = vector3
      L19_2 = L5_2.x
      L20_2 = L5_2.y
      L21_2 = L5_2.z
      L22_2 = L7_2.lookSpeedY
      L22_2 = L8_2 * L22_2
      L22_2 = L22_2 * L17_2
      L21_2 = L21_2 - L22_2
      L18_2 = L18_2(L19_2, L20_2, L21_2)
      L5_2 = L18_2
      L18_2 = true
      L1_1 = L18_2
    end
  end
  L18_2 = L0_1
  if L18_2 then
    L18_2 = SetCamCoord
    L19_2 = A0_2
    L20_2 = L4_2
    L18_2(L19_2, L20_2)
  end
  L18_2 = L1_1
  if L18_2 then
    L18_2 = SetCamRot
    L19_2 = A0_2
    L20_2 = L5_2
    L21_2 = 2
    L18_2(L19_2, L20_2, L21_2)
  end
  if L2_2 and L3_2 then
    L18_2 = L4_2 - L2_2
    L18_2 = #L18_2
    if L3_2 < L18_2 then
      L19_2 = norm
      L20_2 = L4_2 - L2_2
      L19_2 = L19_2(L20_2)
      L20_2 = L19_2 * L3_2
      L4_2 = L2_2 + L20_2
      L20_2 = SetCamCoord
      L21_2 = A0_2
      L22_2 = L4_2
      L20_2(L21_2, L22_2)
    end
  end
  L18_2 = A1_2.updatePlayerCoords
  if L18_2 then
    L18_2 = SetEntityCoords
    L19_2 = cache
    L19_2 = L19_2.ped
    L20_2 = L4_2.x
    L21_2 = L4_2.y
    L22_2 = L4_2.z
    L23_2 = false
    L24_2 = false
    L25_2 = false
    L26_2 = false
    L18_2(L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
    L18_2 = SetEntityHeading
    L19_2 = cache
    L19_2 = L19_2.ped
    L20_2 = L5_2.z
    L18_2(L19_2, L20_2)
  end
  L18_2 = L4_2
  L19_2 = L5_2
  return L18_2, L19_2
end
L2_1.HandleFlyCam = L3_1
L2_1 = Utils
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  if not A1_2 then
    A1_2 = 0
  end
  L2_2 = SetCamActive
  L3_2 = A0_2
  L4_2 = false
  L2_2(L3_2, L4_2)
  L2_2 = RenderScriptCams
  L3_2 = false
  L4_2 = true
  L5_2 = A1_2
  L6_2 = true
  L7_2 = true
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = DestroyCam
  L3_2 = A0_2
  L4_2 = false
  L2_2(L3_2, L4_2)
  L2_2 = SetFocusEntity
  L3_2 = cache
  L3_2 = L3_2.ped
  L2_2(L3_2)
end
L2_1.DestroyFlyCam = L3_1
L2_1 = Utils
function L3_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L0_2 = GetGameplayCamRot
  L1_2 = 0
  L0_2 = L0_2(L1_2)
  L1_2 = GetGameplayCamCoord
  L1_2 = L1_2()
  L2_2 = GetControlNormal
  L3_2 = 0
  L4_2 = 239
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = GetControlNormal
  L4_2 = 0
  L5_2 = 240
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = vector2
  L5_2 = L2_2
  L6_2 = L3_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = Utils
  L5_2 = L5_2.ScreenRelToWorld
  L6_2 = L1_2
  L7_2 = L0_2
  L8_2 = L4_2
  L5_2, L6_2 = L5_2(L6_2, L7_2, L8_2)
  L7_2 = L6_2 * 50.0
  L7_2 = L1_2 + L7_2
  L8_2 = StartShapeTestRay
  L9_2 = L5_2.x
  L10_2 = L5_2.y
  L11_2 = L5_2.z
  L12_2 = L7_2.x
  L13_2 = L7_2.y
  L14_2 = L7_2.z
  L15_2 = -1
  L16_2 = 0
  L17_2 = 4
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L9_2 = GetShapeTestResult
  L10_2 = L8_2
  L9_2, L10_2, L11_2, L12_2, L13_2 = L9_2(L10_2)
  L14_2 = L10_2
  L15_2 = L11_2
  L16_2 = L13_2
  return L14_2, L15_2, L16_2
end
L2_1.ScreenToWorld = L3_1
L2_1 = Utils
function L3_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L3_2 = Utils
  L3_2 = L3_2.RotationToDirection
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  L4_2 = vector3
  L5_2 = A1_2.x
  L5_2 = L5_2 + 1.0
  L6_2 = A1_2.y
  L7_2 = A1_2.z
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = vector3
  L6_2 = A1_2.x
  L6_2 = L6_2 - 1.0
  L7_2 = A1_2.y
  L8_2 = A1_2.z
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L6_2 = vector3
  L7_2 = A1_2.x
  L8_2 = A1_2.y
  L9_2 = A1_2.z
  L9_2 = L9_2 - 1.0
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L7_2 = vector3
  L8_2 = A1_2.x
  L9_2 = A1_2.y
  L10_2 = A1_2.z
  L10_2 = L10_2 + 1.0
  L7_2 = L7_2(L8_2, L9_2, L10_2)
  L8_2 = Utils
  L8_2 = L8_2.RotationToDirection
  L9_2 = L7_2
  L8_2 = L8_2(L9_2)
  L9_2 = Utils
  L9_2 = L9_2.RotationToDirection
  L10_2 = L6_2
  L9_2 = L9_2(L10_2)
  L8_2 = L8_2 - L9_2
  L9_2 = Utils
  L9_2 = L9_2.RotationToDirection
  L10_2 = L4_2
  L9_2 = L9_2(L10_2)
  L10_2 = Utils
  L10_2 = L10_2.RotationToDirection
  L11_2 = L5_2
  L10_2 = L10_2(L11_2)
  L9_2 = L9_2 - L10_2
  L10_2 = A1_2.y
  L11_2 = math
  L11_2 = L11_2.pi
  L10_2 = L10_2 * L11_2
  L10_2 = L10_2 / 180.0
  L10_2 = -L10_2
  L11_2 = math
  L11_2 = L11_2.cos
  L12_2 = L10_2
  L11_2 = L11_2(L12_2)
  L11_2 = L8_2 * L11_2
  L12_2 = math
  L12_2 = L12_2.sin
  L13_2 = L10_2
  L12_2 = L12_2(L13_2)
  L12_2 = L9_2 * L12_2
  L11_2 = L11_2 - L12_2
  L12_2 = math
  L12_2 = L12_2.sin
  L13_2 = L10_2
  L12_2 = L12_2(L13_2)
  L12_2 = L8_2 * L12_2
  L13_2 = math
  L13_2 = L13_2.cos
  L14_2 = L10_2
  L13_2 = L13_2(L14_2)
  L13_2 = L9_2 * L13_2
  L12_2 = L12_2 + L13_2
  L13_2 = L3_2 * 1.0
  L13_2 = A0_2 + L13_2
  L14_2 = L13_2 + L11_2
  L14_2 = L14_2 + L12_2
  L15_2 = Utils
  L15_2 = L15_2.World3DToScreen2D
  L16_2 = L14_2
  L15_2 = L15_2(L16_2)
  L16_2 = Utils
  L16_2 = L16_2.World3DToScreen2D
  L17_2 = L13_2
  L16_2 = L16_2(L17_2)
  L17_2 = A2_2.x
  L18_2 = L16_2.x
  L17_2 = L17_2 - L18_2
  L18_2 = L15_2.x
  L19_2 = L16_2.x
  L18_2 = L18_2 - L19_2
  L17_2 = L17_2 / L18_2
  L18_2 = A2_2.y
  L19_2 = L16_2.y
  L18_2 = L18_2 - L19_2
  L19_2 = L15_2.y
  L20_2 = L16_2.y
  L19_2 = L19_2 - L20_2
  L18_2 = L18_2 / L19_2
  L19_2 = L11_2 * L17_2
  L19_2 = L13_2 + L19_2
  L20_2 = L12_2 * L18_2
  L19_2 = L19_2 + L20_2
  L20_2 = L11_2 * L17_2
  L20_2 = L3_2 + L20_2
  L21_2 = L12_2 * L18_2
  L20_2 = L20_2 + L21_2
  L21_2 = L19_2
  L22_2 = L20_2
  return L21_2, L22_2
end
L2_1.ScreenRelToWorld = L3_1
L2_1 = Utils
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = A0_2.x
  L2_2 = math
  L2_2 = L2_2.pi
  L1_2 = L1_2 * L2_2
  L1_2 = L1_2 / 180.0
  L2_2 = A0_2.z
  L3_2 = math
  L3_2 = L3_2.pi
  L2_2 = L2_2 * L3_2
  L2_2 = L2_2 / 180.0
  L3_2 = math
  L3_2 = L3_2.abs
  L4_2 = math
  L4_2 = L4_2.cos
  L5_2 = L1_2
  L4_2, L5_2, L6_2, L7_2, L8_2 = L4_2(L5_2)
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L4_2 = vector3
  L5_2 = math
  L5_2 = L5_2.sin
  L6_2 = L2_2
  L5_2 = L5_2(L6_2)
  L5_2 = -L5_2
  L5_2 = L5_2 * L3_2
  L6_2 = math
  L6_2 = L6_2.cos
  L7_2 = L2_2
  L6_2 = L6_2(L7_2)
  L6_2 = L6_2 * L3_2
  L7_2 = math
  L7_2 = L7_2.sin
  L8_2 = L1_2
  L7_2, L8_2 = L7_2(L8_2)
  return L4_2(L5_2, L6_2, L7_2, L8_2)
end
L2_1.RotationToDirection = L3_1
L2_1 = Utils
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = GetScreenCoordFromWorldCoord
  L2_2 = A0_2.x
  L3_2 = A0_2.y
  L4_2 = A0_2.z
  L1_2, L2_2, L3_2 = L1_2(L2_2, L3_2, L4_2)
  L4_2 = vector2
  L5_2 = L2_2
  L6_2 = L3_2
  return L4_2(L5_2, L6_2)
end
L2_1.World3DToScreen2D = L3_1
L2_1 = Utils
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = type
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if "string" == L2_2 then
    L2_2 = joaat
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    A0_2 = L2_2 or A0_2
    if not L2_2 then
    end
  end
  L2_2 = lib
  L2_2 = L2_2.requestModel
  L3_2 = A0_2
  L4_2 = Config
  L4_2 = L4_2.DefaultRequestModelTimeout
  L2_2(L3_2, L4_2)
  L2_2 = RequestModel
  L3_2 = model
  L2_2(L3_2)
  while true do
    L2_2 = HasModelLoaded
    L3_2 = model
    L2_2 = L2_2(L3_2)
    if L2_2 then
      break
    end
    L2_2 = Wait
    L3_2 = 0
    L2_2(L3_2)
  end
  L2_2 = CreateObject
  L3_2 = model
  L4_2 = A1_2.x
  L5_2 = A1_2.y
  L6_2 = A1_2.z
  L7_2 = false
  L8_2 = false
  L9_2 = false
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L3_2 = SetModelAsNoLongerNeeded
  L4_2 = model
  L3_2(L4_2)
  return L2_2
end
L2_1.CreateObject = L3_1
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = {}
  L4_2 = A0_2
  L4_2, L5_2 = L4_2()
  while L5_2 do
    L6_2 = #L3_2
    L6_2 = L6_2 + 1
    L3_2[L6_2] = L5_2
    L6_2 = A1_2
    L7_2 = L4_2
    L6_2 = L6_2(L7_2)
    L5_2 = L6_2
  end
  L6_2 = A2_2
  L7_2 = L4_2
  L6_2(L7_2)
  return L3_2
end
L3_1 = Utils
function L4_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = L2_1
  L1_2 = FindFirstPed
  L2_2 = FindNextPed
  L3_2 = EndFindPed
  return L0_2(L1_2, L2_2, L3_2)
end
L3_1.GetAllPeds = L4_1
L3_1 = Utils
function L4_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = L2_1
  L1_2 = FindFirstObject
  L2_2 = FindNextObject
  L3_2 = EndFindObject
  return L0_2(L1_2, L2_2, L3_2)
end
L3_1.GetAllObjects = L4_1
L3_1 = Utils
function L4_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = L2_1
  L1_2 = FindFirstVehicle
  L2_2 = FindNextVehicle
  L3_2 = EndFindVehicle
  return L0_2(L1_2, L2_2, L3_2)
end
L3_1.GetAllVehicles = L4_1
L3_1 = Utils
function L4_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  function L3_2(A0_3, A1_3, A2_3)
    local L3_3, L4_3, L5_3, L6_3
    L4_3 = A0_3
    L3_3 = A0_3.find
    L5_3 = A1_3
    L6_3 = A2_3
    return L3_3(L4_3, L5_3, L6_3)
  end
  find = L3_2
  L3_2 = nil
  L4_2 = nil
  L5_2 = 1
  L6_2 = A2_2
  L7_2 = 1
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = find
    L10_2 = A0_2
    L11_2 = A1_2
    if L4_2 then
      L12_2 = L4_2 + 1
      if L12_2 then
        goto lbl_18
      end
    end
    L12_2 = 0
    ::lbl_18::
    L9_2, L10_2 = L9_2(L10_2, L11_2, L12_2)
    L4_2 = L10_2
    L3_2 = L9_2
  end
  L5_2 = L3_2
  L6_2 = L4_2
  return L5_2, L6_2
end
L3_1.FindNthInString = L4_1
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = math
  L1_2 = L1_2.rad
  L2_2 = A0_2.z
  L1_2 = L1_2(L2_2)
  L2_2 = math
  L2_2 = L2_2.rad
  L3_2 = A0_2.x
  L2_2 = L2_2(L3_2)
  L3_2 = math
  L3_2 = L3_2.abs
  L4_2 = math
  L4_2 = L4_2.cos
  L5_2 = L2_2
  L4_2, L5_2, L6_2, L7_2, L8_2 = L4_2(L5_2)
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L4_2 = vector3
  L5_2 = math
  L5_2 = L5_2.sin
  L6_2 = L1_2
  L5_2 = L5_2(L6_2)
  L5_2 = -L5_2
  L5_2 = L5_2 * L3_2
  L6_2 = math
  L6_2 = L6_2.cos
  L7_2 = L1_2
  L6_2 = L6_2(L7_2)
  L6_2 = L6_2 * L3_2
  L7_2 = math
  L7_2 = L7_2.sin
  L8_2 = L2_2
  L7_2, L8_2 = L7_2(L8_2)
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  return L4_2
end
RotationToDirection = L3_1
L3_1 = Utils
function L4_1()
  local L0_2, L1_2, L2_2
  L0_2 = {}
  L1_2 = GetFinalRenderedCamCoord
  L1_2 = L1_2()
  L0_2.coords = L1_2
  L1_2 = GetFinalRenderedCamRot
  L2_2 = 2
  L1_2 = L1_2(L2_2)
  L0_2.rotation = L1_2
  return L0_2
end
L3_1.GetCamera = L4_1
function L3_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2
  L3_2 = 1000.0
  L4_2 = RotationToDirection
  L5_2 = A1_2
  L4_2 = L4_2(L5_2)
  L5_2 = vector3
  L6_2 = L3_2
  L7_2 = 0
  L8_2 = 0
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L5_2 = A1_2 + L5_2
  L6_2 = vector3
  L7_2 = -L3_2
  L8_2 = 0
  L9_2 = 0
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L6_2 = A1_2 + L6_2
  L7_2 = vector3
  L8_2 = 0
  L9_2 = 0
  L10_2 = -L3_2
  L7_2 = L7_2(L8_2, L9_2, L10_2)
  L7_2 = A1_2 + L7_2
  L8_2 = vector3
  L9_2 = 0
  L10_2 = 0
  L11_2 = L3_2
  L8_2 = L8_2(L9_2, L10_2, L11_2)
  L8_2 = A1_2 + L8_2
  L9_2 = RotationToDirection
  L10_2 = L8_2
  L9_2 = L9_2(L10_2)
  L10_2 = RotationToDirection
  L11_2 = L7_2
  L10_2 = L10_2(L11_2)
  L9_2 = L9_2 - L10_2
  L10_2 = RotationToDirection
  L11_2 = L5_2
  L10_2 = L10_2(L11_2)
  L11_2 = RotationToDirection
  L12_2 = L6_2
  L11_2 = L11_2(L12_2)
  L10_2 = L10_2 - L11_2
  L11_2 = math
  L11_2 = L11_2.rad
  L12_2 = A1_2.y
  L11_2 = L11_2(L12_2)
  L11_2 = -L11_2
  L12_2 = math
  L12_2 = L12_2.cos
  L13_2 = L11_2
  L12_2 = L12_2(L13_2)
  L12_2 = L9_2 * L12_2
  L13_2 = math
  L13_2 = L13_2.sin
  L14_2 = L11_2
  L13_2 = L13_2(L14_2)
  L13_2 = L10_2 * L13_2
  L12_2 = L12_2 - L13_2
  L13_2 = math
  L13_2 = L13_2.sin
  L14_2 = L11_2
  L13_2 = L13_2(L14_2)
  L13_2 = L9_2 * L13_2
  L14_2 = math
  L14_2 = L14_2.cos
  L15_2 = L11_2
  L14_2 = L14_2(L15_2)
  L14_2 = L10_2 * L14_2
  L13_2 = L13_2 + L14_2
  L14_2 = L4_2 * L3_2
  L14_2 = A0_2 + L14_2
  L14_2 = L14_2 + L12_2
  L14_2 = L14_2 + L13_2
  L15_2 = nil
  L16_2 = GetScreenCoordFromWorldCoord
  L17_2 = L14_2.x
  L18_2 = L14_2.y
  L19_2 = L14_2.z
  L16_2, L17_2, L18_2 = L16_2(L17_2, L18_2, L19_2)
  L19_2 = {}
  L19_2.X = L17_2
  L19_2.Y = L18_2
  if not (L19_2 and L17_2) or not L18_2 then
    L20_2 = L4_2 * L3_2
    L20_2 = A0_2 + L20_2
    return L20_2
  end
  L20_2 = L4_2 * L3_2
  L20_2 = A0_2 + L20_2
  L21_2 = GetScreenCoordFromWorldCoord
  L22_2 = L20_2.x
  L23_2 = L20_2.y
  L24_2 = L20_2.z
  L21_2, L22_2, L23_2 = L21_2(L22_2, L23_2, L24_2)
  L24_2 = {}
  L24_2.X = L22_2
  L24_2.Y = L23_2
  if not (L24_2 and L22_2) or not L23_2 then
    L25_2 = L4_2 * L3_2
    L25_2 = A0_2 + L25_2
    return L25_2
  end
  L25_2 = 1.0E-5
  L26_2 = math
  L26_2 = L26_2.abs
  L27_2 = L19_2.X
  L28_2 = L24_2.X
  L27_2 = L27_2 - L28_2
  L26_2 = L26_2(L27_2)
  if not (L25_2 > L26_2) then
    L26_2 = math
    L26_2 = L26_2.abs
    L27_2 = L19_2.Y
    L28_2 = L24_2.Y
    L27_2 = L27_2 - L28_2
    L26_2 = L26_2(L27_2)
    if not (L25_2 > L26_2) then
      goto lbl_159
    end
  end
  L26_2 = L4_2 * L3_2
  L26_2 = A0_2 + L26_2
  do return L26_2 end
  ::lbl_159::
  L26_2 = A2_2.x
  L27_2 = L24_2.X
  L26_2 = L26_2 - L27_2
  L27_2 = L19_2.X
  L28_2 = L24_2.X
  L27_2 = L27_2 - L28_2
  L26_2 = L26_2 / L27_2
  L27_2 = A2_2.y
  L28_2 = L24_2.Y
  L27_2 = L27_2 - L28_2
  L28_2 = L19_2.Y
  L29_2 = L24_2.Y
  L28_2 = L28_2 - L29_2
  L27_2 = L27_2 / L28_2
  L28_2 = L4_2 * L3_2
  L28_2 = A0_2 + L28_2
  L29_2 = L12_2 * L26_2
  L28_2 = L28_2 + L29_2
  L29_2 = L13_2 * L27_2
  L28_2 = L28_2 + L29_2
  return L28_2
end
ScreenRelToWorld = L3_1
function L3_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L3_2 = GetCamCoord
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  L4_2 = cache
  L4_2 = L4_2.ped
  L5_2 = StartShapeTestRay
  L6_2 = L3_2.x
  L7_2 = L3_2.y
  L8_2 = L3_2.z
  L9_2 = A0_2.x
  L10_2 = A0_2.y
  L11_2 = A0_2.z
  L12_2 = A2_2
  L13_2 = L4_2
  L14_2 = 0
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L6_2 = GetShapeTestResult
  L7_2 = L5_2
  L6_2, L7_2, L8_2, L9_2, L10_2 = L6_2(L7_2)
  currentCoords = L8_2
  L11_2 = L7_2
  L12_2 = L8_2
  L13_2 = L10_2
  return L11_2, L12_2, L13_2
end
LocationInWorld = L3_1
L3_1 = Utils
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L1_2 = GetDisabledControlNormal
  L2_2 = 0
  L3_2 = 239
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = GetDisabledControlNormal
  L3_2 = 0
  L4_2 = 240
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = GetWorldCoordFromScreenCoord
  L4_2 = L1_2
  L5_2 = L2_2
  L3_2, L4_2 = L3_2(L4_2, L5_2)
  L5_2 = L3_2
  L6_2 = L4_2 * 120
  L6_2 = L3_2 + L6_2
  L7_2 = StartShapeTestSweptSphere
  L8_2 = L5_2.x
  L9_2 = L5_2.y
  L10_2 = L5_2.z
  L11_2 = L6_2.x
  L12_2 = L6_2.y
  L13_2 = L6_2.z
  L14_2 = 0.01
  L15_2 = 17
  L16_2 = A0_2 or L16_2
  if not A0_2 then
    L16_2 = cache
    L16_2 = L16_2.ped
  end
  L17_2 = 4
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L8_2 = GetShapeTestResult
  L9_2 = L7_2
  L8_2, L9_2, L10_2, L11_2, L12_2 = L8_2(L9_2)
  if not L8_2 then
    L13_2 = nil
    L14_2 = nil
    return L13_2, L14_2
  end
  L13_2 = L10_2
  L14_2 = L12_2
  return L13_2, L14_2
end
L3_1.getCursorHitCoords = L4_1
L3_1 = string
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = type
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  if "string" == L2_2 then
    L2_2 = A0_2 == A1_2
    return L2_2
  else
    L2_2 = type
    L3_2 = A1_2
    L2_2 = L2_2(L3_2)
    if "table" == L2_2 then
      L2_2 = ipairs
      L3_2 = A1_2
      L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
      for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
        if A0_2 == L7_2 then
          L8_2 = true
          return L8_2
        end
      end
      L2_2 = false
      return L2_2
    end
  end
end
L3_1.includes = L4_1
L3_1 = {}
L3_1.ESC = 322
L3_1.F1 = 288
L3_1.F2 = 289
L3_1.F3 = 170
L3_1.F5 = 166
L3_1.F6 = 167
L3_1.F7 = 168
L3_1.F8 = 169
L3_1.F9 = 56
L3_1.F10 = 57
L3_1["~"] = 243
L3_1["1"] = 157
L3_1["2"] = 158
L3_1["3"] = 160
L3_1["4"] = 164
L3_1["5"] = 165
L3_1["6"] = 159
L3_1["7"] = 161
L3_1["8"] = 162
L3_1["9"] = 163
L3_1["-"] = 84
L3_1["="] = 83
L3_1.BACKSPACE = 177
L3_1.TAB = 37
L3_1.Q = 44
L3_1.W = 32
L3_1.E = 38
L3_1.R = 45
L3_1.T = 245
L3_1.Y = 246
L3_1.U = 303
L3_1.P = 199
L3_1["["] = 39
L3_1["]"] = 40
L3_1.ENTER = 18
L3_1.CAPS = 137
L3_1.A = 34
L3_1.S = 8
L3_1.D = 9
L3_1.F = 23
L3_1.G = 47
L3_1.H = 74
L3_1.K = 311
L3_1.L = 182
L3_1.LEFTSHIFT = 21
L3_1.Z = 20
L3_1.X = 73
L3_1.C = 26
L3_1.V = 0
L3_1.B = 29
L3_1.N = 249
L3_1.M = 244
L3_1[","] = 82
L3_1["."] = 81
L3_1.LEFTCTRL = 36
L3_1.LEFTALT = 19
L3_1.SPACE = 22
L3_1.RIGHTCTRL = 70
L3_1.HOME = 213
L3_1.PAGEUP = 10
L3_1.PAGEDOWN = 11
L3_1.DELETE = 178
L3_1.LEFT = 174
L3_1.RIGHT = 175
L3_1.TOP = 27
L3_1.DOWN = 173
L3_1.NENTER = 201
L3_1.N4 = 108
L3_1.N5 = 60
L3_1.N6 = 107
L3_1["N+"] = 96
L3_1["N-"] = 97
L3_1.N7 = 117
L3_1.N8 = 61
L3_1.N9 = 118
Keys = L3_1
DrawingInstructional = false
L3_1 = Utils
function L4_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = DrawingInstructional
  if L1_2 then
    L1_2 = Debug
    L2_2 = "Instructional"
    L3_2 = "Instructional already being drawn, updating keys."
    L1_2(L2_2, L3_2)
    return
  end
  L1_2 = CreateThread
  function L2_2()
    local L0_3, L1_3, L2_3, L3_3
    DrawingInstructional = true
    while true do
      L0_3 = DrawingInstructional
      if not L0_3 then
        break
      end
      L0_3 = Wait
      L1_3 = 0
      L0_3(L1_3)
      L0_3 = Utils
      L0_3 = L0_3.GetControls
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = Utils
      L1_3 = L1_3.CreateInstructional
      L2_3 = L0_3
      L1_3 = L1_3(L2_3)
      L2_3 = Utils
      L2_3 = L2_3.DrawScaleform
      L3_3 = L1_3
      L2_3(L3_3)
    end
  end
  L1_2(L2_2)
end
L3_1.DrawInstructional = L4_1
L3_1 = Utils
function L4_1()
  local L0_2, L1_2
  DrawingInstructional = false
end
L3_1.RemoveInstructional = L4_1
L3_1 = {}
L4_1 = Utils
function L5_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = cache
  L0_2 = L0_2.ped
  L1_2 = ToggleInventoryClothing
  L2_2 = true
  L1_2(L2_2)
  L1_2 = {}
  L2_2 = {}
  L3_2 = GetPedDrawableVariation
  L4_2 = L0_2
  L5_2 = 8
  L3_2 = L3_2(L4_2, L5_2)
  L2_2.item = L3_2
  L3_2 = GetPedTextureVariation
  L4_2 = L0_2
  L5_2 = 8
  L3_2 = L3_2(L4_2, L5_2)
  L2_2.texture = L3_2
  L1_2["t-shirt"] = L2_2
  L2_2 = {}
  L3_2 = GetPedDrawableVariation
  L4_2 = L0_2
  L5_2 = 11
  L3_2 = L3_2(L4_2, L5_2)
  L2_2.item = L3_2
  L3_2 = GetPedTextureVariation
  L4_2 = L0_2
  L5_2 = 11
  L3_2 = L3_2(L4_2, L5_2)
  L2_2.texture = L3_2
  L1_2.torso2 = L2_2
  L2_2 = {}
  L3_2 = GetPedDrawableVariation
  L4_2 = L0_2
  L5_2 = 3
  L3_2 = L3_2(L4_2, L5_2)
  L2_2.item = L3_2
  L3_2 = GetPedTextureVariation
  L4_2 = L0_2
  L5_2 = 3
  L3_2 = L3_2(L4_2, L5_2)
  L2_2.texture = L3_2
  L1_2.arms = L2_2
  L2_2 = {}
  L3_2 = GetPedDrawableVariation
  L4_2 = L0_2
  L5_2 = 4
  L3_2 = L3_2(L4_2, L5_2)
  L2_2.item = L3_2
  L3_2 = GetPedTextureVariation
  L4_2 = L0_2
  L5_2 = 4
  L3_2 = L3_2(L4_2, L5_2)
  L2_2.texture = L3_2
  L1_2.pants = L2_2
  L2_2 = {}
  L3_2 = GetPedDrawableVariation
  L4_2 = L0_2
  L5_2 = 6
  L3_2 = L3_2(L4_2, L5_2)
  L2_2.item = L3_2
  L3_2 = GetPedTextureVariation
  L4_2 = L0_2
  L5_2 = 6
  L3_2 = L3_2(L4_2, L5_2)
  L2_2.texture = L3_2
  L1_2.shoes = L2_2
  L3_1 = L1_2
  L1_2 = Config
  L1_2 = L1_2.NakedPlayerClothes
  L2_2 = GetEntityModel
  L3_2 = L0_2
  L2_2 = L2_2(L3_2)
  L3_2 = joaat
  L4_2 = "mp_m_freemode_01"
  L3_2 = L3_2(L4_2)
  if L2_2 == L3_2 then
    L2_2 = "Male"
    if L2_2 then
      goto lbl_88
    end
  end
  L2_2 = "Female"
  ::lbl_88::
  L1_2 = L1_2[L2_2]
  L2_2 = Utils
  L2_2 = L2_2.wearClothes
  L3_2 = L1_2
  L2_2(L3_2)
end
L4_1.stripPlayer = L5_1
L4_1 = Utils
function L5_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = cache
  L1_2 = L1_2.ped
  L2_2 = SetPedComponentVariation
  L3_2 = L1_2
  L4_2 = 8
  L5_2 = A0_2["t-shirt"]
  L5_2 = L5_2.item
  L6_2 = A0_2["t-shirt"]
  L6_2 = L6_2.texture
  L7_2 = 0
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = SetPedComponentVariation
  L3_2 = L1_2
  L4_2 = 11
  L5_2 = A0_2.torso2
  L5_2 = L5_2.item
  L6_2 = A0_2.torso2
  L6_2 = L6_2.texture
  L7_2 = 0
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = SetPedComponentVariation
  L3_2 = L1_2
  L4_2 = 3
  L5_2 = A0_2.arms
  L5_2 = L5_2.item
  L6_2 = A0_2.arms
  L6_2 = L6_2.texture
  L7_2 = 0
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = SetPedComponentVariation
  L3_2 = L1_2
  L4_2 = 4
  L5_2 = A0_2.pants
  L5_2 = L5_2.item
  L6_2 = A0_2.pants
  L6_2 = L6_2.texture
  L7_2 = 0
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = SetPedComponentVariation
  L3_2 = L1_2
  L4_2 = 6
  L5_2 = A0_2.shoes
  L5_2 = L5_2.item
  L6_2 = A0_2.shoes
  L6_2 = L6_2.texture
  L7_2 = 0
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
end
L4_1.wearClothes = L5_1
L4_1 = Utils
function L5_1()
  local L0_2, L1_2
  L0_2 = ToggleInventoryClothing
  L1_2 = true
  L0_2(L1_2)
  L0_2 = Utils
  L0_2 = L0_2.wearClothes
  L1_2 = L3_1
  L0_2(L1_2)
  L0_2 = {}
  L3_1 = L0_2
  L0_2 = ToggleInventoryClothing
  L1_2 = false
  L0_2(L1_2)
end
L4_1.restorePlayerClothes = L5_1






