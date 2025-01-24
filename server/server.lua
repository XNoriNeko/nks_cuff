local translations = {
    fr = {
        youHandcuffed = '👮 | Vous avez menotté un joueur',
        youUnhandcuffed = '👮 | Vous avez démenotté un joueur'
    },
    en = {
        youHandcuffed = '👮 | You have handcuffed a player',
        youUnhandcuffed = '👮 | You have unhandcuffed a player'
    }
}

RegisterServerEvent('nkscuff:handcuff')
AddEventHandler('nkscuff:handcuff', function(target, language)
    local source = source
    TriggerClientEvent('nkscuff:handcuff', target, source)
end)

RegisterServerEvent('nkscuff:notifyHandcuffer')
AddEventHandler('nkscuff:notifyHandcuffer', function(handcuffer, isHandcuffed, language)
    local xPlayer = ESX.GetPlayerFromId(handcuffer)
    if isHandcuffed then
        xPlayer.showNotification(translations[language].youHandcuffed)
    else
        xPlayer.showNotification(translations[language].youUnhandcuffed)
    end
end)