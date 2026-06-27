_G.contract = {}

function contract:open(data)
    if self.visible then
        return Debug("contract:open ::: contract is already visible")
    end

    data.visible = true
    self.data = data
    self.visible = true

    SendReactMessage("toggle_contract", self.data)
    SetNuiFocus(true, true)
end

function contract:close()
    self.visible = false
    self.data = nil
    SendReactMessage("toggle_contract", { visible = false })
end

RegisterNUICallback("accept_contract", function(data, cb)
    local house = CurrentApartment and CurrentApartment.house or CurrentHouse

    if data.type == "buy" then
        TriggerServerEvent("qb-houses:server:buyHouse", house)
    elseif data.type == "rent" then
        TriggerServerEvent("qb-houses:rentHouse", house)
    elseif data.type == "credit" then
        TriggerServerEvent("qb-houses:server:buyHouse", house, true)
    else
        Error("buy ::: Invalid data", "data", data)
    end

    CurrentApartment = nil
    cb(true)
end)
