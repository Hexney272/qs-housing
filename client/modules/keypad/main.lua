_G.keypad = {}

function keypad.open(self, title, maxLength)
    self.title = title or "Enter PIN Code"
    self.maxLength = maxLength or 4
    self.response = nil

    SendReactMessage("toggle_keypad", {
        visible = true,
        title = self.title,
        maxLength = self.maxLength,
    })
    SetNuiFocus(true, true)

    while nil == self.response do
        Wait(50)
    end

    return self.response
end

function keypad.close(self)
    SendReactMessage("toggle_keypad", { visible = false })
    SetNuiFocus(false, false)
end

RegisterNUICallback("keypad:submit", function(data, cb)
    local pin = data.pin
    if not pin or #pin < keypad.maxLength then
        cb("error")
        return
    end

    keypad:close()
    keypad.response = pin
    cb("ok")
end)
