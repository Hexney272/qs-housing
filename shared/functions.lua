





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1
L0_1 = {}
L1_1 = {}
L2_1 = 48
L3_1 = 57
L4_1 = 1
for L5_1 = L2_1, L3_1, L4_1 do
  L6_1 = table
  L6_1 = L6_1.insert
  L7_1 = L0_1
  L8_1 = string
  L8_1 = L8_1.char
  L9_1 = L5_1
  L8_1 = L8_1(L9_1)
  L6_1(L7_1, L8_1)
end
L2_1 = 65
L3_1 = 90
L4_1 = 1
for L5_1 = L2_1, L3_1, L4_1 do
  L6_1 = table
  L6_1 = L6_1.insert
  L7_1 = L1_1
  L8_1 = string
  L8_1 = L8_1.char
  L9_1 = L5_1
  L8_1 = L8_1(L9_1)
  L6_1(L7_1, L8_1)
end
L2_1 = 97
L3_1 = 122
L4_1 = 1
for L5_1 = L2_1, L3_1, L4_1 do
  L6_1 = table
  L6_1 = L6_1.insert
  L7_1 = L1_1
  L8_1 = string
  L8_1 = L8_1.char
  L9_1 = L5_1
  L8_1 = L8_1(L9_1)
  L6_1(L7_1, L8_1)
end
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = Citizen
  L1_2 = L1_2.Wait
  L2_2 = 0
  L1_2(L2_2)
  if A0_2 > 0 then
    L1_2 = GetRandomNumber
    L2_2 = A0_2 - 1
    L1_2 = L1_2(L2_2)
    L2_2 = math
    L2_2 = L2_2.random
    L3_2 = 1
    L4_2 = L0_1
    L4_2 = #L4_2
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = L0_1
    L2_2 = L3_2[L2_2]
    L1_2 = L1_2 .. L2_2
    return L1_2
  else
    L1_2 = ""
    return L1_2
  end
end
GetRandomNumber = L2_1
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = Citizen
  L1_2 = L1_2.Wait
  L2_2 = 0
  L1_2(L2_2)
  if A0_2 > 0 then
    L1_2 = GetRandomLetter
    L2_2 = A0_2 - 1
    L1_2 = L1_2(L2_2)
    L2_2 = math
    L2_2 = L2_2.random
    L3_2 = 1
    L4_2 = L1_1
    L4_2 = #L4_2
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = L1_1
    L2_2 = L3_2[L2_2]
    L1_2 = L1_2 .. L2_2
    return L1_2
  else
    L1_2 = ""
    return L1_2
  end
end
GetRandomLetter = L2_1
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  if A0_2 then
    L1_2 = string
    L1_2 = L1_2.gsub
    L2_2 = A0_2
    L3_2 = "^%s*(.-)%s*$"
    L4_2 = "%1"
    L1_2 = L1_2(L2_2, L3_2, L4_2)
    return L1_2
  else
    L1_2 = nil
    return L1_2
  end
end
MathTrim = L2_1
L2_1 = GetResourceMetadata
L3_1 = GetCurrentResourceName
L3_1 = L3_1()
L4_1 = "version"
L5_1 = 0
L2_1 = L2_1(L3_1, L4_1, L5_1)
function L3_1(...)
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = Config
  L0_2 = L0_2.Debug
  if L0_2 then
    L0_2 = {}
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = ...
    L0_2[1] = L1_2
    L0_2[2] = L2_2
    L0_2[3] = L3_2
    L0_2[4] = L4_2
    L0_2[5] = L5_2
    L0_2[6] = L6_2
    L0_2[7] = L7_2
    L0_2[8] = L8_2
    L1_2 = ipairs
    L2_2 = L0_2
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = type
      L8_2 = L6_2
      L7_2 = L7_2(L8_2)
      if "table" == L7_2 then
        L7_2 = json
        L7_2 = L7_2.encode
        L8_2 = L6_2
        L7_2 = L7_2(L8_2)
        L0_2[L5_2] = L7_2
      end
    end
    L1_2 = print
    L2_2 = "^5[DEBUG "
    L3_2 = L2_1
    L4_2 = "]^7"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L3_2 = table
    L3_2 = L3_2.unpack
    L4_2 = L0_2
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L3_2(L4_2)
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  end
end
Debug = L3_1
function L3_1(...)
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = "^3HOUSING WARNING:^0 "
  L1_2 = pairs
  L2_2 = {}
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = ...
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L2_2[4] = L6_2
  L2_2[5] = L7_2
  L2_2[6] = L8_2
  L2_2[7] = L9_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = L0_2
    L8_2 = tostring
    L9_2 = L6_2
    L8_2 = L8_2(L9_2)
    L9_2 = "\t"
    L7_2 = L7_2 .. L8_2 .. L9_2
    L0_2 = L7_2
  end
  L1_2 = print
  L2_2 = L0_2
  L1_2(L2_2)
end
Warning = L3_1
function L3_1(...)
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = "^5HOUSING INFO:^0 "
  L1_2 = pairs
  L2_2 = {}
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = ...
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L2_2[4] = L6_2
  L2_2[5] = L7_2
  L2_2[6] = L8_2
  L2_2[7] = L9_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = type
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    if "table" == L7_2 then
      L7_2 = L0_2
      L8_2 = json
      L8_2 = L8_2.encode
      L9_2 = L6_2
      L8_2 = L8_2(L9_2)
      L9_2 = "\t"
      L7_2 = L7_2 .. L8_2 .. L9_2
      L0_2 = L7_2
    else
      L7_2 = L0_2
      L8_2 = tostring
      L9_2 = L6_2
      L8_2 = L8_2(L9_2)
      L9_2 = "\t"
      L7_2 = L7_2 .. L8_2 .. L9_2
      L0_2 = L7_2
    end
  end
  L1_2 = print
  L2_2 = L0_2
  L1_2(L2_2)
end
Info = L3_1
function L3_1(...)
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = "^1HOUSING ERROR:^0 "
  L1_2 = pairs
  L2_2 = {}
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = ...
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L2_2[4] = L6_2
  L2_2[5] = L7_2
  L2_2[6] = L8_2
  L2_2[7] = L9_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = type
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    if "table" == L7_2 then
      L7_2 = L0_2
      L8_2 = json
      L8_2 = L8_2.encode
      L9_2 = L6_2
      L8_2 = L8_2(L9_2)
      L9_2 = "\t"
      L7_2 = L7_2 .. L8_2 .. L9_2
      L0_2 = L7_2
    else
      L7_2 = L0_2
      L8_2 = tostring
      L9_2 = L6_2
      L8_2 = L8_2(L9_2)
      L9_2 = "\t"
      L7_2 = L7_2 .. L8_2 .. L9_2
      L0_2 = L7_2
    end
  end
  L1_2 = print
  L2_2 = L0_2
  L1_2(L2_2)
end
Error = L3_1
function L3_1(...)
  local L0_2, L1_2, L2_2
  L0_2 = table
  L0_2 = L0_2.unpack
  L1_2 = {}
  L2_2 = ...
  L1_2[1] = L2_2
  L0_2 = L0_2(L1_2)
  L1_2 = CreateThread
  function L2_2()
    local L0_3, L1_3, L2_3
    while true do
      L0_3 = print
      L1_3 = "^1[ERROR]^7"
      L2_3 = L0_2
      L0_3(L1_3, L2_3)
      L0_3 = Wait
      L1_3 = 2000
      L0_3(L1_3)
    end
  end
  L1_2(L2_2)
end
LoopError = L3_1
L3_1 = table
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  if not A0_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = pairs
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    if L7_2 == A1_2 then
      L8_2 = true
      return L8_2
    end
  end
  L2_2 = false
  return L2_2
end
L3_1.includes = L4_1
L3_1 = table
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  if not A0_2 then
    L2_2 = false
    L3_2 = false
    return L2_2, L3_2
  end
  L2_2 = pairs
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = type
    L9_2 = A1_2
    L8_2 = L8_2(L9_2)
    if "function" == L8_2 then
      L8_2 = A1_2
      L9_2 = L7_2
      L10_2 = L6_2
      L8_2 = L8_2(L9_2, L10_2)
      if L8_2 then
        L8_2 = L7_2
        L9_2 = L6_2
        return L8_2, L9_2
      end
    elseif L7_2 == A1_2 then
      L8_2 = L7_2
      L9_2 = L6_2
      return L8_2, L9_2
    end
  end
  L2_2 = false
  L3_2 = false
  return L2_2, L3_2
end
L3_1.find = L4_1
L3_1 = string
function L4_1(A0_2, A1_2)
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
L3_1.split = L4_1
L3_1 = table
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L2_2 = {}
  L3_2 = pairs
  L4_2 = A0_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = A1_2
    L10_2 = L8_2
    L11_2 = L7_2
    L12_2 = A0_2
    L9_2 = L9_2(L10_2, L11_2, L12_2)
    if L9_2 then
      L9_2 = #L2_2
      L9_2 = L9_2 + 1
      L2_2[L9_2] = L8_2
    end
  end
  return L2_2
end
L3_1.filter = L4_1
L3_1 = table
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = {}
  L3_2 = pairs
  L4_2 = A0_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = #L2_2
    L9_2 = L9_2 + 1
    L10_2 = A1_2
    L11_2 = L8_2
    L12_2 = L7_2
    L13_2 = A0_2
    L10_2 = L10_2(L11_2, L12_2, L13_2)
    L2_2[L9_2] = L10_2
  end
  return L2_2
end
L3_1.map = L4_1
L3_1 = table
function L4_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L4_2 = {}
  L5_2 = A1_2 or L5_2
  if not A1_2 then
    L5_2 = 1
  end
  L6_2 = A2_2 or L6_2
  if not A2_2 then
    L6_2 = #A0_2
  end
  L7_2 = A3_2 or L7_2
  if not A3_2 then
    L7_2 = 1
  end
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = #L4_2
    L9_2 = L9_2 + 1
    L10_2 = A0_2[L8_2]
    L4_2[L9_2] = L10_2
  end
  return L4_2
end
L3_1.slice = L4_1
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = pairs
  L2_2 = A0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = GetResourceState
    L8_2 = L5_2
    L7_2 = L7_2(L8_2)
    L8_2 = L7_2
    L7_2 = L7_2.find
    L9_2 = "started"
    L7_2 = L7_2(L8_2, L9_2)
    if nil ~= L7_2 then
      return L6_2
    end
  end
  L1_2 = false
  return L1_2
end
DependencyCheck = L3_1
function L3_1(A0_2)
  local L1_2, L2_2
  if A0_2 < 60 then
    L1_2 = A0_2
    L2_2 = " seconds"
    L1_2 = L1_2 .. L2_2
    return L1_2
  else
    L1_2 = 3600
    if A0_2 < L1_2 then
      L1_2 = math
      L1_2 = L1_2.floor
      L2_2 = A0_2 / 60
      L1_2 = L1_2(L2_2)
      L2_2 = " min"
      L1_2 = L1_2 .. L2_2
      return L1_2
    else
      L1_2 = 86400
      if A0_2 < L1_2 then
        L1_2 = math
        L1_2 = L1_2.floor
        L2_2 = A0_2 / 3600
        L1_2 = L1_2(L2_2)
        L2_2 = " hours"
        L1_2 = L1_2 .. L2_2
        return L1_2
      else
        L1_2 = math
        L1_2 = L1_2.floor
        L2_2 = A0_2 / 86400
        L1_2 = L1_2(L2_2)
        L2_2 = " days"
        L1_2 = L1_2 .. L2_2
        return L1_2
      end
    end
  end
end
FormatTime = L3_1
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = A1_2.x
  L3_2 = A1_2.y
  L4_2 = A0_2.x
  L5_2 = math
  L5_2 = L5_2.cos
  L6_2 = math
  L6_2 = L6_2.rad
  L7_2 = A0_2.w
  L7_2 = L7_2 + 90
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L6_2(L7_2)
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = L2_2 * L5_2
  L4_2 = L4_2 + L5_2
  L5_2 = math
  L5_2 = L5_2.sin
  L6_2 = math
  L6_2 = L6_2.rad
  L7_2 = A0_2.w
  L7_2 = L7_2 + 90
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L6_2(L7_2)
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = L3_2 * L5_2
  L4_2 = L4_2 - L5_2
  L5_2 = A0_2.y
  L6_2 = math
  L6_2 = L6_2.sin
  L7_2 = math
  L7_2 = L7_2.rad
  L8_2 = A0_2.w
  L8_2 = L8_2 + 90
  L7_2, L8_2, L9_2, L10_2, L11_2 = L7_2(L8_2)
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  L6_2 = L2_2 * L6_2
  L5_2 = L5_2 + L6_2
  L6_2 = math
  L6_2 = L6_2.cos
  L7_2 = math
  L7_2 = L7_2.rad
  L8_2 = A0_2.w
  L8_2 = L8_2 + 90
  L7_2, L8_2, L9_2, L10_2, L11_2 = L7_2(L8_2)
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  L6_2 = L3_2 * L6_2
  L5_2 = L5_2 + L6_2
  L6_2 = A0_2.z
  L7_2 = A1_2.z
  L6_2 = L6_2 + L7_2
  L7_2 = vec4
  L8_2 = L4_2
  L9_2 = L5_2
  L10_2 = L6_2
  L11_2 = A0_2.w
  return L7_2(L8_2, L9_2, L10_2, L11_2)
end
GetCoordsWithOffset = L3_1
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = {}
  L2_2 = math
  L2_2 = L2_2.pi
  L2_2 = L2_2 / 180
  L3_2 = A0_2.x
  L2_2 = L2_2 * L3_2
  L1_2.x = L2_2
  L2_2 = math
  L2_2 = L2_2.pi
  L2_2 = L2_2 / 180
  L3_2 = A0_2.y
  L2_2 = L2_2 * L3_2
  L1_2.y = L2_2
  L2_2 = math
  L2_2 = L2_2.pi
  L2_2 = L2_2 / 180
  L3_2 = A0_2.z
  L2_2 = L2_2 * L3_2
  L1_2.z = L2_2
  L2_2 = {}
  L3_2 = math
  L3_2 = L3_2.sin
  L4_2 = L1_2.z
  L3_2 = L3_2(L4_2)
  L3_2 = -L3_2
  L4_2 = math
  L4_2 = L4_2.abs
  L5_2 = math
  L5_2 = L5_2.cos
  L6_2 = L1_2.x
  L5_2, L6_2 = L5_2(L6_2)
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 * L4_2
  L2_2.x = L3_2
  L3_2 = math
  L3_2 = L3_2.cos
  L4_2 = L1_2.z
  L3_2 = L3_2(L4_2)
  L4_2 = math
  L4_2 = L4_2.abs
  L5_2 = math
  L5_2 = L5_2.cos
  L6_2 = L1_2.x
  L5_2, L6_2 = L5_2(L6_2)
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 * L4_2
  L2_2.y = L3_2
  L3_2 = math
  L3_2 = L3_2.sin
  L4_2 = L1_2.x
  L3_2 = L3_2(L4_2)
  L2_2.z = L3_2
  return L2_2
end
RotationToDirection = L3_1
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = GetGameplayCamRot
  L1_2 = L1_2()
  L2_2 = GetGameplayCamCoord
  L2_2 = L2_2()
  L3_2 = RotationToDirection
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = {}
  L5_2 = L2_2.x
  L6_2 = L3_2.x
  L6_2 = L6_2 * A0_2
  L5_2 = L5_2 + L6_2
  L4_2.x = L5_2
  L5_2 = L2_2.y
  L6_2 = L3_2.y
  L6_2 = L6_2 * A0_2
  L5_2 = L5_2 + L6_2
  L4_2.y = L5_2
  L5_2 = L2_2.z
  L6_2 = L3_2.z
  L6_2 = L6_2 * A0_2
  L5_2 = L5_2 + L6_2
  L4_2.z = L5_2
  L5_2 = vec3
  L6_2 = L4_2.x
  L7_2 = L4_2.y
  L8_2 = L4_2.z
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L6_2 = L1_2
  return L5_2, L6_2
end
RayCastGamePlayCamera = L3_1
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L2_2 = nil
  L3_2 = A1_2
  L4_2 = pairs
  L5_2 = GetActivePlayers
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L5_2()
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = GetEntityCoords
    L11_2 = GetPlayerPed
    L12_2 = L9_2
    L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2)
    L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
    L11_2 = Debug
    L12_2 = "GetClosestPlayer"
    L13_2 = L10_2
    L14_2 = A0_2
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = L10_2 - A0_2
    L11_2 = #L11_2
    if L3_2 > L11_2 then
      L3_2 = L11_2
      L2_2 = L9_2
    end
  end
  return L2_2
end
GetClosestPlayer = L3_1
function L3_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L3_2 = GetEntityCoords
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = GetEntityForwardVector
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L5_2 = vector3
  L6_2 = 0.0
  L7_2 = 0.0
  L8_2 = 1.0
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L6_2 = vector3
  L7_2 = L4_2.y
  L7_2 = -L7_2
  L8_2 = L4_2.x
  L9_2 = 0.0
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L7_2 = GetModelDimensions
  L8_2 = GetEntityModel
  L9_2 = A0_2
  L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L8_2(L9_2)
  L7_2, L8_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  L9_2 = L8_2.z
  L10_2 = L7_2.z
  L9_2 = L9_2 - L10_2
  L9_2 = L9_2 * 2
  L10_2 = L8_2.x
  L11_2 = L7_2.x
  L10_2 = L10_2 - L11_2
  L10_2 = L10_2 * 2
  L11_2 = L8_2.y
  L12_2 = L7_2.y
  L11_2 = L11_2 - L12_2
  L12_2 = {}
  L13_2 = L4_2 * A2_2
  L14_2 = L10_2 * 0.5
  L15_2 = A2_2 * 0.5
  L14_2 = L14_2 + L15_2
  L14_2 = L6_2 * L14_2
  L13_2 = L13_2 - L14_2
  L12_2["front-left"] = L13_2
  L13_2 = L4_2 * A2_2
  L12_2["front-middle"] = L13_2
  L13_2 = L4_2 * A2_2
  L14_2 = L10_2 * 0.5
  L15_2 = A2_2 * 0.5
  L14_2 = L14_2 + L15_2
  L14_2 = L6_2 * L14_2
  L13_2 = L13_2 + L14_2
  L12_2["front-right"] = L13_2
  L13_2 = -L4_2
  L13_2 = L13_2 * A2_2
  L14_2 = L10_2 * 0.5
  L15_2 = A2_2 * 0.5
  L14_2 = L14_2 + L15_2
  L14_2 = L6_2 * L14_2
  L13_2 = L13_2 - L14_2
  L12_2["back-left"] = L13_2
  L13_2 = -L4_2
  L13_2 = L13_2 * A2_2
  L12_2["back-middle"] = L13_2
  L13_2 = -L4_2
  L13_2 = L13_2 * A2_2
  L14_2 = L10_2 * 0.5
  L15_2 = A2_2 * 0.5
  L14_2 = L14_2 + L15_2
  L14_2 = L6_2 * L14_2
  L13_2 = L13_2 + L14_2
  L12_2["back-right"] = L13_2
  L13_2 = -L6_2
  L14_2 = L10_2 * 0.5
  L14_2 = A2_2 + L14_2
  L13_2 = L13_2 * L14_2
  L12_2.left = L13_2
  L13_2 = L10_2 * 0.5
  L13_2 = A2_2 + L13_2
  L13_2 = L6_2 * L13_2
  L12_2.right = L13_2
  L13_2 = L4_2 * A2_2
  L14_2 = L10_2 * 0.5
  L15_2 = A2_2 * 0.5
  L14_2 = L14_2 + L15_2
  L14_2 = L6_2 * L14_2
  L13_2 = L13_2 - L14_2
  L14_2 = L9_2 + A2_2
  L14_2 = L5_2 * L14_2
  L13_2 = L13_2 + L14_2
  L12_2["top-left"] = L13_2
  L13_2 = L5_2 * A2_2
  L12_2["top-middle"] = L13_2
  L13_2 = L4_2 * A2_2
  L14_2 = L10_2 * 0.5
  L15_2 = A2_2 * 0.5
  L14_2 = L14_2 + L15_2
  L14_2 = L6_2 * L14_2
  L13_2 = L13_2 + L14_2
  L14_2 = L9_2 + A2_2
  L14_2 = L5_2 * L14_2
  L13_2 = L13_2 + L14_2
  L12_2["top-right"] = L13_2
  L13_2 = vector3
  L14_2 = 0.0
  L15_2 = 0.0
  L16_2 = L9_2
  L13_2 = L13_2(L14_2, L15_2, L16_2)
  L12_2.center = L13_2
  L13_2 = L4_2 * A2_2
  L13_2 = L13_2 * 0.7
  L14_2 = L10_2 * 0.5
  L15_2 = A2_2 * 0.7
  L14_2 = L14_2 + L15_2
  L14_2 = L6_2 * L14_2
  L13_2 = L13_2 - L14_2
  L12_2["front-left-diagonal"] = L13_2
  L13_2 = L4_2 * A2_2
  L13_2 = L13_2 * 0.7
  L14_2 = L10_2 * 0.5
  L15_2 = A2_2 * 0.7
  L14_2 = L14_2 + L15_2
  L14_2 = L6_2 * L14_2
  L13_2 = L13_2 + L14_2
  L12_2["front-right-diagonal"] = L13_2
  L13_2 = -L4_2
  L13_2 = L13_2 * A2_2
  L13_2 = L13_2 * 0.7
  L14_2 = L10_2 * 0.5
  L15_2 = A2_2 * 0.7
  L14_2 = L14_2 + L15_2
  L14_2 = L6_2 * L14_2
  L13_2 = L13_2 - L14_2
  L12_2["back-left-diagonal"] = L13_2
  L13_2 = -L4_2
  L13_2 = L13_2 * A2_2
  L13_2 = L13_2 * 0.7
  L14_2 = L10_2 * 0.5
  L15_2 = A2_2 * 0.7
  L14_2 = L14_2 + L15_2
  L14_2 = L6_2 * L14_2
  L13_2 = L13_2 + L14_2
  L12_2["back-right-diagonal"] = L13_2
  L13_2 = L12_2[A1_2]
  L13_2 = L3_2 + L13_2
  return L13_2
end
GetRelativePosition = L3_1






