





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1
L0_1 = GetResourceMetadata
L1_1 = GetCurrentResourceName
L1_1 = L1_1()
L2_1 = "version"
L3_1 = 0
L0_1 = L0_1(L1_1, L2_1, L3_1)
L1_1 = GetCurrentResourceName
L1_1 = L1_1()
L2_1 = string
function L3_1(A0_2, A1_2)
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
L2_1.split = L3_1
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = A0_2
  L1_2 = A0_2.split
  L3_2 = "."
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = ""
  L3_2 = 1
  L4_2 = #L1_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = L2_2
    L8_2 = L1_2[L6_2]
    L7_2 = L7_2 .. L8_2
    L2_2 = L7_2
  end
  L3_2 = tonumber
  L4_2 = L2_2
  return L3_2(L4_2)
end
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = L2_1
  L3_2 = L0_1
  L2_2 = L2_2(L3_2)
  L3_2 = L2_1
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = L3_2 - L2_2
  L5_2 = A1_2
  return L4_2, L5_2
end
if L0_1 then
  L4_1 = "https://raw.githubusercontent.com/quasar-scripts/version/main/"
  L5_1 = L1_1
  L6_1 = ".json"
  L4_1 = L4_1 .. L5_1 .. L6_1
  L5_1 = PerformHttpRequest
  L6_1 = L4_1
  function L7_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
    if 404 == A0_2 then
      L3_2 = print
      L4_2 = "^1API is not available. Unable to check the version.^0"
      L3_2(L4_2)
      return
    end
    if 200 == A0_2 then
      L3_2 = json
      L3_2 = L3_2.decode
      L4_2 = A1_2
      L3_2 = L3_2(L4_2)
      L4_2 = L3_2.version
      L5_2 = L3_2.descriptions
      L6_2 = L3_1
      L7_2 = L4_2
      L8_2 = L5_2
      L6_2, L7_2 = L6_2(L7_2, L8_2)
      if 0 == L6_2 then
        L8_2 = print
        L9_2 = "^2You are using the latest version of "
        L10_2 = L1_1
        L11_2 = "!^0"
        L9_2 = L9_2 .. L10_2 .. L11_2
        L8_2(L9_2)
      elseif L6_2 > 0 then
        L8_2 = print
        L9_2 = "^3New version available for "
        L10_2 = L1_1
        L11_2 = "!^0"
        L9_2 = L9_2 .. L10_2 .. L11_2
        L8_2(L9_2)
        L8_2 = pairs
        L9_2 = L7_2
        L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
        for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
          L14_2 = print
          L15_2 = "^3- "
          L16_2 = L13_2
          L17_2 = "^0"
          L15_2 = L15_2 .. L16_2 .. L17_2
          L14_2(L15_2)
        end
        L8_2 = print
        L9_2 = "^3You have version "
        L10_2 = L0_1
        L11_2 = ", upgrade to version "
        L12_2 = L4_2
        L13_2 = "!^0"
        L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2 .. L13_2
        L8_2(L9_2)
      else
        L8_2 = print
        L9_2 = "^1You are using a newer version of "
        L10_2 = L1_1
        L11_2 = " than the one available on GitHub.^0"
        L9_2 = L9_2 .. L10_2 .. L11_2
        L8_2(L9_2)
      end
    end
  end
  L8_1 = "GET"
  L9_1 = ""
  L10_1 = {}
  L11_1 = {}
  L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1)
else
  L4_1 = print
  L5_1 = "Unable to obtain the version of "
  L6_1 = L1_1
  L7_1 = ". Make sure it is defined in your fxmanifest.lua."
  L5_1 = L5_1 .. L6_1 .. L7_1
  L4_1(L5_1)
end






