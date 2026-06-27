





local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1
L0_1 = GetCurrentResourceName
L0_1 = L0_1()
L1_1 = json
L1_1 = L1_1.decode
L2_1 = LoadResourceFile
L3_1 = L0_1
L4_1 = "locales/en.json"
L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1 = L2_1(L3_1, L4_1)
L1_1 = L1_1(L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1)
if not L1_1 then
  L1_1 = {}
end
L2_1 = LoadResourceFile
L3_1 = L0_1
L4_1 = "locales/%s.json"
L5_1 = L4_1
L4_1 = L4_1.format
L6_1 = Config
L6_1 = L6_1.Locale
L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1 = L4_1(L5_1, L6_1)
L2_1 = L2_1(L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1)
if not L2_1 then
  L2_1 = L1_1
  L3_1 = print
  L4_1 = "^3[GARAGES]^1 WARNING: ^7Locale %s does not exist, falling back to default (en)."
  L5_1 = L4_1
  L4_1 = L4_1.format
  L6_1 = Config
  L6_1 = L6_1.Locale
  L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1 = L4_1(L5_1, L6_1)
  L3_1(L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1)
end
if L2_1 then
  L3_1 = json
  L3_1 = L3_1.decode
  L4_1 = L2_1
  L3_1 = L3_1(L4_1)
  if L3_1 then
    goto lbl_42
  end
end
L3_1 = nil
::lbl_42::
_T = L3_1
L3_1 = pairs
L4_1 = L1_1
L3_1, L4_1, L5_1, L6_1 = L3_1(L4_1)
for L7_1, L8_1 in L3_1, L4_1, L5_1, L6_1 do
  L9_1 = _T
  L9_1 = L9_1[L7_1]
  if not L9_1 then
    L9_1 = _T
    L9_1[L7_1] = L8_1
    L9_1 = CreateThread
    function L10_1()
      local L0_2, L1_2, L2_2, L3_2, L4_2
      L0_2 = Wait
      L1_2 = 5000
      L0_2(L1_2)
      L0_2 = print
      L1_2 = "^3[GARAGES]^1 WARNING: ^7Locale %s is missing key `%s`, falling back to default (en). Please add this key to your locale file."
      L2_2 = L1_2
      L1_2 = L1_2.format
      L3_2 = Config
      L3_2 = L3_2.Locale
      L4_2 = L7_1
      L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2)
      L0_2(L1_2, L2_2, L3_2, L4_2)
    end
    L9_1(L10_1)
  end
end
L3_1 = _T
if not L3_1 then
  L3_1 = error
  L4_1 = "^3[GARAGES]^1 ERROR: ^7Failed to load locale file. Please make sure that the file %s exists and is valid JSON."
  L5_1 = L4_1
  L4_1 = L4_1.format
  L6_1 = "locales/%s.json"
  L7_1 = L6_1
  L6_1 = L6_1.format
  L8_1 = Config
  L8_1 = L8_1.Locale
  L6_1, L7_1, L8_1, L9_1, L10_1 = L6_1(L7_1, L8_1)
  L4_1 = L4_1(L5_1, L6_1, L7_1, L8_1, L9_1, L10_1)
  L5_1 = 2
  L3_1(L4_1, L5_1)
end
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = _T
  L4_2 = A0_2
  L3_2 = A0_2.gmatch
  L5_2 = "[^.]+"
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2, L5_2)
  for L7_2 in L3_2, L4_2, L5_2, L6_2 do
    L2_2 = L2_2[L7_2]
    if not L2_2 then
      L8_2 = print
      L9_2 = "Missing locale for: "
      L10_2 = A0_2
      L9_2 = L9_2 .. L10_2
      L8_2(L9_2)
      L8_2 = "missing_"
      L9_2 = A0_2
      L8_2 = L8_2 .. L9_2
      return L8_2
    end
  end
  if A1_2 then
    L3_2 = pairs
    L4_2 = A1_2
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = type
      L10_2 = L8_2
      L9_2 = L9_2(L10_2)
      if "string" ~= L9_2 then
        L9_2 = type
        L10_2 = L8_2
        L9_2 = L9_2(L10_2)
        if "number" ~= L9_2 then
          goto lbl_45
        end
      end
      L10_2 = L2_2
      L9_2 = L2_2.gsub
      L11_2 = "{{"
      L12_2 = L7_2
      L13_2 = "}}"
      L11_2 = L11_2 .. L12_2 .. L13_2
      L12_2 = L8_2
      L9_2 = L9_2(L10_2, L11_2, L12_2)
      L2_2 = L9_2
      ::lbl_45::
    end
  end
  return L2_2
end
_L = L3_1
L3_1 = _G
L4_1 = {}
L5_1 = _L
L4_1.t = L5_1
L3_1.i18n = L4_1






