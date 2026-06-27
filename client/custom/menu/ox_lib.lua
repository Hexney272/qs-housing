





---@param _type? 'lockpick' | 'police'
function OpenApartmentMenu(_type)
    local apartmentDatas = TriggerServerCallbackSync('housing:getApartmentsData', CurrentHouse)
    if not apartmentDatas or not next(apartmentDatas) then return Notification(i18n.t('apartment.no_apartments'), 'error') end
    local data = {}
    for _, v in pairs(apartmentDatas) do
        local description = i18n.t('apartment.sales')
        local houseData = Config.Houses[v.house]
        if v.isOwnedByMe and v.haskey then
            description = i18n.t('apartment.own')
        elseif v.haskey then
            description = i18n.t('apartment.no_key')
        elseif v.purchasable then
            description = i18n.t('apartment.sales')
        elseif v.rentable then
            description = i18n.t('apartment.rent')
        elseif not houseData.locked then
            description = i18n.t('apartment.not_locked', { ownerName = v.ownerName })
        elseif v.isOwned then
            description = i18n.t('apartment.owned', { ownerName = v.ownerName })
        end
        table.insert(data, {
            title = v.isOwnedByMe and i18n.t('apartment.your', { id = v.id }) or i18n.t('apartment.select', { id = v.id }),
            description = description,
            onSelect = function(args)
                if _type == 'lockpick' then
                    LockPick(v.house)
                    return
                elseif _type == 'police' then
                    RamDoor(v.house)
                    return
                end
                if not v.isOwned or v.rentable or v.purchasable then
                    OpenApartmentBuyMenu(v)
                    return
                elseif v.haskey or not houseData.locked then
                    CurrentHouseData = v
                    CurrentHouse = v.house
                    TriggerEvent('qb-houses:client:EnterHouse', houseData.ipl, v.house, v)
                    return
                end
                lib.playAnim(cache.ped, 'gestures@f@standing@casual', 'gesture_point')
                Notification(i18n.t('you_ring_door'), 'info')
                TriggerServerEvent('qb-houses:server:RingDoor', v.house)
            end,
            disabled = (_type == 'lockpick' or _type == 'police') and (not v.isOwned or not houseData.locked)
        })
    end
    lib.registerContext({
        id = 'apartment_menu',
        title = i18n.t('apartment.title'),
        options = data
    })
    lib.showContext('apartment_menu')
end

function OpenApartmentBuyMenu(apartment)
    local data = {}
    if apartment.rentable then
        table.insert(data, {
            title = i18n.t('apartment.rent_title'),
            -- description = 'Rent',
            onSelect = function(args)
                CurrentApartment = apartment
                TriggerServerEvent('qb-houses:server:viewHouse', apartment.house, true)
            end
        })
    else
        table.insert(data, {
            title = i18n.t('apartment.buy_title'),
            -- description = 'Buy',
            onSelect = function(args)
                CurrentApartment = apartment
                TriggerServerEvent('qb-houses:server:viewHouse', apartment.house)
            end
        })
    end
    local houseData = Config.Houses[apartment.house]
    table.insert(data, {
        title = i18n.t('apartment.inspect_title'),
        -- description = 'Inspect',
        onSelect = function(args)
            InspectHouse(houseData, apartment.house)
        end
    })
    lib.registerContext({
        id = 'apartment_buy_interactions',
        title = i18n.t('apartment.interactions_title'),
        options = data
    })
    lib.showContext('apartment_buy_interactions')
end

function OpenMyApartments()
    local apartmentDatas = TriggerServerCallbackSync('housing:getApartmentsData', CurrentHouse)
    if not apartmentDatas or not next(apartmentDatas) then return Notification(i18n.t('apartment.no_apartments'), 'error') end
    local data = {}
    for k, v in pairs(apartmentDatas) do
        if not v.isOwnedByMe then goto continue end
        local houseData = Config.Houses[v.house]
        table.insert(data, {
            title = i18n.t('apartment.your', { id = k }),
            --- description = 'Your Apartment',
            onSelect = function(args)
                v.currentHouse = CurrentHouse
                v.currentHouseData = CurrentHouseData
                CurrentApartment = v
                CurrentHouse = v.house
                CurrentHouseData = v
                houseData.name = i18n.t('apartment.your', { id = k })
                decorate:getObjects(CurrentHouse)
                management:open(houseData)
            end,
        })
        ::continue::
    end
    if #data == 0 then return end
    lib.registerContext({
        id = 'my_apartment_menu',
        title = i18n.t('apartment.my_apartments'),
        options = data
    })
    lib.showContext('my_apartment_menu')
end

function OpenHireApartments()
    local apartmentDatas = TriggerServerCallbackSync('housing:getApartmentsData', CurrentHouse, true)
    if not apartmentDatas or not next(apartmentDatas) then return Notification(i18n.t('apartment.no_apartments'), 'error') end
    apartmentDatas = table.filter(apartmentDatas, function(v)
        return v.rented
    end)
    if #apartmentDatas == 0 then return Notification(i18n.t('apartment.no_rented_apartments'), 'error') end
    local data = {}
    for k, v in pairs(apartmentDatas) do
        table.insert(data, {
            title = i18n.t('apartment.apartment_number', { number = k }),
            onSelect = function(args)
                TriggerServerEvent('housing:hireRenter', v.house)
            end,
        })
    end
    if #data == 0 then return Notification(i18n.t('apartment.no_rented_apartments'), 'error') end
    lib.registerContext({
        id = 'hire_apartment_menu',
        title = i18n.t('apartment.hire_apartment'),
        options = data
    })
    lib.showContext('hire_apartment_menu')
end






