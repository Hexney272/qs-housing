Scaleforms = {}

function Scaleforms.LoadMovie(movieName)
    local handle = RequestScaleformMovie(movieName)
    while true do
        if HasScaleformMovieLoaded(handle) then
            break
        end
        Wait(0)
    end
    return handle
end

function Scaleforms.LoadInteractive(movieName)
    local handle = RequestScaleformMovieInteractive(movieName)
    while true do
        if HasScaleformMovieLoaded(handle) then
            break
        end
        Wait(0)
    end
    return handle
end

function Scaleforms.UnloadMovie(handle)
    SetScaleformMovieAsNoLongerNeeded(handle)
end

function Scaleforms.LoadAdditionalText(textGxt, count)
    for i = 0, count, 1 do
        if not HasThisAdditionalTextLoaded(textGxt, i) then
            ClearAdditionalText(i, true)
            RequestAdditionalText(textGxt, i)
            while true do
                if HasThisAdditionalTextLoaded(textGxt, i) then
                    break
                end
                Wait(0)
            end
        end
    end
end

function Scaleforms.SetLabels(handle, labels)
    PushScaleformMovieFunction(handle, "SET_LABELS")
    for i = 1, #labels, 1 do
        local label = labels[i]
        BeginTextCommandScaleformString(label)
        EndTextCommandScaleformString()
    end
    PopScaleformMovieFunctionVoid()
end

function Scaleforms.PopMulti(handle, functionName, ...)
    PushScaleformMovieFunction(handle, functionName)
    local args = { ... }
    for _, value in pairs(args) do
        local valueType = Scaleforms.TrueType(value)
        if "string" == valueType then
            _ENV["PushScaleformMovieFunctionParameterString"](value)
        elseif "boolean" == valueType then
            PushScaleformMovieFunctionParameterBool(value)
        elseif "int" == valueType then
            PushScaleformMovieFunctionParameterInt(value)
        elseif "float" == valueType then
            PushScaleformMovieFunctionParameterFloat(value)
        end
    end
    PopScaleformMovieFunctionVoid()
end

function Scaleforms.PopFloat(handle, functionName, value)
    PushScaleformMovieFunction(handle, functionName)
    PushScaleformMovieFunctionParameterFloat(value)
    PopScaleformMovieFunctionVoid()
end

function Scaleforms.PopInt(handle, functionName, value)
    PushScaleformMovieFunction(handle, functionName)
    PushScaleformMovieFunctionParameterInt(value)
    PopScaleformMovieFunctionVoid()
end

function Scaleforms.PopBool(handle, functionName, value)
    PushScaleformMovieFunction(handle, functionName)
    PushScaleformMovieFunctionParameterBool(value)
    PopScaleformMovieFunctionVoid()
end

function Scaleforms.PopRet(handle, functionName)
    PushScaleformMovieFunction(handle, functionName)
    return PopScaleformMovieFunction()
end

function Scaleforms.PopVoid(handle, functionName)
    PushScaleformMovieFunction(handle, functionName)
    PopScaleformMovieFunctionVoid()
end

function Scaleforms.RetBool(returnData)
    return GetScaleformMovieFunctionReturnBool(returnData)
end

function Scaleforms.RetInt(returnData)
    return GetScaleformMovieFunctionReturnInt(returnData)
end

function Scaleforms.TrueType(value)
    local luaType = type(value)
    if "number" ~= luaType then
        return type(value)
    end
    local numStr = tostring(value)
    if string.find(numStr, ".") then
        return "float"
    else
        return "int"
    end
end

exports("Scaleforms", function()
    return Scaleforms
end)
