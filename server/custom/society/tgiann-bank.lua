





if Config.Society ~= 'tgiann-bank' then
    return
end

function AddMoneyToSociety(src, societyName, societyPaid)
    Debug('Society system, id: ' .. src .. ', society name: ' .. societyName .. ', Paid: ' .. societyPaid)

    exports['tgiann-bank']:AddJobMoney(societyName, societyPaid)
end






