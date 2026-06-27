





--[[
    Configurable company system, you can create multiple files
    and adapt them to your company system, these are the ones we recommend
    that we bring by default, but you can integrate others.

    Enable Config.Debug to be able to see the log inside Debug.
]]

if Config.Society ~= 'esx_society' then
    return
end

for _, v in pairs(Config.CreatorJobs) do
    local societyName = 'society_' .. v.job
    TriggerEvent('esx_society:registerSociety', v.job, v.label or v.job, societyName, societyName, societyName, { type = 'public' })
end

-- Function to add money directly to the society account
function AddMoneyToSociety(_src, societyName, amount)
    if not societyName or not amount or amount <= 0 then
        Debug('esx_society', 'AddMoneyToSociety', 'Invalid data. societyName: ' .. tostring(societyName) .. ' amount: ' .. tostring(amount))
        return
    end

    local accountName = 'society_' .. societyName
    Debug('esx_society', 'AddMoneyToSociety', 'src: ' .. _src .. ' society: ' .. accountName .. ' amount: ' .. amount)

    TriggerEvent('esx_addonaccount:getSharedAccount', accountName, function(account)
        if account then
            account.addMoney(amount)
            Debug('esx_society', 'AddMoneyToSociety', 'Money successfully added to society account: ' .. accountName)
        else
            Debug('esx_society', 'AddMoneyToSociety', 'Error: Society account not found for ' .. accountName)
        end
    end)
end






