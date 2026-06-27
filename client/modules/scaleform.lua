





local L0_1, L1_1, L2_1
L0_1 = {}
Scaleforms = L0_1
L0_1 = Scaleforms
function L1_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = RequestScaleformMovie
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  while true do
    L2_2 = HasScaleformMovieLoaded
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    if L2_2 then
      break
    end
    L2_2 = Wait
    L3_2 = 0
    L2_2(L3_2)
  end
  return L1_2
end
L0_1.LoadMovie = L1_1
L0_1 = Scaleforms
function L1_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = RequestScaleformMovieInteractive
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  while true do
    L2_2 = HasScaleformMovieLoaded
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    if L2_2 then
      break
    end
    L2_2 = Wait
    L3_2 = 0
    L2_2(L3_2)
  end
  return L1_2
end
L0_1.LoadInteractive = L1_1
L0_1 = Scaleforms
function L1_1(A0_2)
  local L1_2, L2_2
  L1_2 = SetScaleformMovieAsNoLongerNeeded
  L2_2 = A0_2
  L1_2(L2_2)
end
L0_1.UnloadMovie = L1_1
L0_1 = Scaleforms
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = 0
  L3_2 = A1_2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = HasThisAdditionalTextLoaded
    L7_2 = A0_2
    L8_2 = L5_2
    L6_2 = L6_2(L7_2, L8_2)
    if not L6_2 then
      L6_2 = ClearAdditionalText
      L7_2 = L5_2
      L8_2 = true
      L6_2(L7_2, L8_2)
      L6_2 = RequestAdditionalText
      L7_2 = A0_2
      L8_2 = L5_2
      L6_2(L7_2, L8_2)
      while true do
        L6_2 = HasThisAdditionalTextLoaded
        L7_2 = A0_2
        L8_2 = L5_2
        L6_2 = L6_2(L7_2, L8_2)
        if L6_2 then
          break
        end
        L6_2 = Wait
        L7_2 = 0
        L6_2(L7_2)
      end
    end
  end
end
L0_1.LoadAdditionalText = L1_1
L0_1 = Scaleforms
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = PushScaleformMovieFunction
  L3_2 = A0_2
  L4_2 = "SET_LABELS"
  L2_2(L3_2, L4_2)
  L2_2 = 1
  L3_2 = #A1_2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = A1_2[L5_2]
    L7_2 = BeginTextCommandScaleformString
    L8_2 = L6_2
    L7_2(L8_2)
    L7_2 = EndTextCommandScaleformString
    L7_2()
  end
  L2_2 = PopScaleformMovieFunctionVoid
  L2_2()
end
L0_1.SetLabels = L1_1
L0_1 = Scaleforms
function L1_1(A0_2, A1_2, ...)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = PushScaleformMovieFunction
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
  L2_2 = pairs
  L3_2 = {}
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = ...
  L3_2[1] = L4_2
  L3_2[2] = L5_2
  L3_2[3] = L6_2
  L3_2[4] = L7_2
  L3_2[5] = L8_2
  L3_2[6] = L9_2
  L3_2[7] = L10_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = Scaleforms
    L8_2 = L8_2.TrueType
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    if "string" == L8_2 then
      L9_2 = _ENV
      L10_2 = "PushScaleformMovieFunctionParameterString"
      L9_2 = L9_2[L10_2]
      L10_2 = L7_2
      L9_2(L10_2)
    elseif "boolean" == L8_2 then
      L9_2 = PushScaleformMovieFunctionParameterBool
      L10_2 = L7_2
      L9_2(L10_2)
    elseif "int" == L8_2 then
      L9_2 = PushScaleformMovieFunctionParameterInt
      L10_2 = L7_2
      L9_2(L10_2)
    elseif "float" == L8_2 then
      L9_2 = PushScaleformMovieFunctionParameterFloat
      L10_2 = L7_2
      L9_2(L10_2)
    end
  end
  L2_2 = PopScaleformMovieFunctionVoid
  L2_2()
end
L0_1.PopMulti = L1_1
L0_1 = Scaleforms
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = PushScaleformMovieFunction
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2(L4_2, L5_2)
  L3_2 = PushScaleformMovieFunctionParameterFloat
  L4_2 = A2_2
  L3_2(L4_2)
  L3_2 = PopScaleformMovieFunctionVoid
  L3_2()
end
L0_1.PopFloat = L1_1
L0_1 = Scaleforms
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = PushScaleformMovieFunction
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2(L4_2, L5_2)
  L3_2 = PushScaleformMovieFunctionParameterInt
  L4_2 = A2_2
  L3_2(L4_2)
  L3_2 = PopScaleformMovieFunctionVoid
  L3_2()
end
L0_1.PopInt = L1_1
L0_1 = Scaleforms
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = PushScaleformMovieFunction
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2(L4_2, L5_2)
  L3_2 = PushScaleformMovieFunctionParameterBool
  L4_2 = A2_2
  L3_2(L4_2)
  L3_2 = PopScaleformMovieFunctionVoid
  L3_2()
end
L0_1.PopBool = L1_1
L0_1 = Scaleforms
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = PushScaleformMovieFunction
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
  L2_2 = PopScaleformMovieFunction
  return L2_2()
end
L0_1.PopRet = L1_1
L0_1 = Scaleforms
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = PushScaleformMovieFunction
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
  L2_2 = PopScaleformMovieFunctionVoid
  L2_2()
end
L0_1.PopVoid = L1_1
L0_1 = Scaleforms
function L1_1(A0_2)
  local L1_2, L2_2
  L1_2 = GetScaleformMovieFunctionReturnBool
  L2_2 = A0_2
  return L1_2(L2_2)
end
L0_1.RetBool = L1_1
L0_1 = Scaleforms
function L1_1(A0_2)
  local L1_2, L2_2
  L1_2 = GetScaleformMovieFunctionReturnInt
  L2_2 = A0_2
  return L1_2(L2_2)
end
L0_1.RetInt = L1_1
L0_1 = Scaleforms
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = type
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if "number" ~= L1_2 then
    L1_2 = type
    L2_2 = A0_2
    return L1_2(L2_2)
  end
  L1_2 = tostring
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = string
  L2_2 = L2_2.find
  L3_2 = L1_2
  L4_2 = "."
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = "float"
    return L2_2
  else
    L2_2 = "int"
    return L2_2
  end
end
L0_1.TrueType = L1_1
L0_1 = exports
L1_1 = "Scaleforms"
function L2_1()
  local L0_2, L1_2
  L0_2 = Scaleforms
  return L0_2
end
L0_1(L1_1, L2_1)






