





--──────────────────────────────────────────────────────────────────────────────
-- Voice Assistant                                                    [EDIT]
-- [INFO] Push-to-talk voice commands for in-house actions.
--──────────────────────────────────────────────────────────────────────────────
Config.VoiceAssistant = {
    enabled = true,              -- [EDIT] Master toggle
    assistantName = 'Aura',      -- [EDIT] Wake name used in hints/logs
    language = 'en-US',          -- [EDIT] Preferred JS speech language (en-US | tr-TR | es-ES | de-DE | fr-FR | pt-PT | pt-BR)
    pushToTalkKey = 'N',         -- [EDIT] Uses key name from Keys table (N)
    cancelWaitKey = 'BACKSPACE', -- [EDIT] Cancel key while Aura waits for follow-up
    cooldownMs = 1500,           -- [EDIT] Minimum delay between commands
    stt = {                      -- [EDIT] Stt Settings
        requestTimeoutMs = 65000,
        minRecordMs = 450,
        maxRecordMs = 12000,
        mimeType = 'audio/webm',
    },
    tts = { -- [EDIT] Tts Settings
        enabled = true,
        requestTimeoutMs = 15000,
        speed = 1.0,
        speaker = 0,
        maxChars = 500,
        volume = 1.0,
    }
}






