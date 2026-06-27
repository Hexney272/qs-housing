





-- Function to manage weather synchronization
function WeatherSyncEvent(isSyncEnabled)
    if isSyncEnabled then
        TriggerEvent('Renewed:client:DisableSync')
        TriggerEvent('qb-weathersync:client:DisableSync')
        TriggerEvent('cd_easytime:PauseSync', true)
        -- NetworkOverrideClockTime(23, 0, 0)
        TriggerEvent('vSync:toggle', true)
        TriggerEvent('av_weather:freeze', true, 23, 0, 'CLEAR', false, false, false)
        TriggerEvent('Renewed:client:ForceWeather', {
            weather = 'CLEAR',
            time = { hour = 23, minute = 0 },
            dynamic = false
        })
        Debug('Weather synchronization disabled.')
        SetRainLevel(0.0)
        SetRainFxIntensity(0.0)
        SetVisualSettingFloat('puddles.scale', 0.0)
    else
        TriggerEvent('Renewed:client:EnableSync')
        TriggerEvent('qb-weathersync:client:EnableSync')
        TriggerEvent('cd_easytime:PauseSync', false)
        -- NetworkClearClockTimeOverride()
        TriggerEvent('vSync:toggle', false)
        TriggerEvent('av_weather:freeze', false)
        TriggerEvent('Renewed:client:ForceWeather', false)
        SetVisualSettingFloat('puddles.scale', 0.1)

        Debug('Weather synchronization enabled.')
    end
end






