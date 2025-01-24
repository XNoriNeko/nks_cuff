RegisterServerEvent('nkscuff:handcuff')
AddEventHandler('nkscuff:handcuff', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if xTarget then
        TriggerClientEvent('nkscuff:handcuff', target)
    end
end)