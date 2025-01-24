local isHandcuffed = false
local ANIM_DICT = 'mp_arresting'
local ANIM_NAME = 'idle'
local HANDCUFF_DISTANCE = 1.5
local HANDCUFF_MODEL = 'p_cs_cuffs_02_s'
local handcuffObject = nil
local config = nil

local translations = {
    fr = {
        noPlayerNearby = '❌ | Aucun joueur à proximité !',
        handcuffed = '👮 | Tu as été menotté !',
        unhandcuffed = '👮 | Tu as été démenotté !',
        youHandcuffed = '👮 | Vous avez menotté un joueur !',
        youUnhandcuffed = '👮 | Vous avez démenotté un joueur !'
    },
    en = {
        noPlayerNearby = '❌ | No player nearby',
        handcuffed = '👮 | You have been handcuffed',
        unhandcuffed = '👮 | You have been unhandcuffed',
        youHandcuffed = '👮 | You have handcuffed a player',
        youUnhandcuffed = '👮 | You have unhandcuffed a player'
    }
}

local function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(50)
    end
end

local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(50)
    end
end

local function getTranslation(key)
    return translations[config.language] and translations[config.language][key] or key
end

Citizen.CreateThread(function()
    local language = LoadResourceFile(GetCurrentResourceName(), 'config.json')
    if language then
        config = json.decode(language)
    end

    if config then
        loadAnimDict(ANIM_DICT)
        loadModel(HANDCUFF_MODEL)
        
        RegisterKeyMapping('cuff', 'Menotter/Démenotter', 'keyboard', config.defaultKey or '')
    end
end)

RegisterCommand('cuff', function()
    local playerPed = PlayerPedId()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer ~= -1 and closestDistance <= HANDCUFF_DISTANCE then
        TriggerServerEvent('nkscuff:handcuff', GetPlayerServerId(closestPlayer), config.language)
    else
        ESX.ShowNotification(getTranslation('noPlayerNearby'))
    end
end, false)

RegisterNetEvent('nkscuff:handcuff')
AddEventHandler('nkscuff:handcuff', function(handcuffer)
    local playerPed = PlayerPedId()
    isHandcuffed = not isHandcuffed

    if isHandcuffed then
        TaskPlayAnim(playerPed, ANIM_DICT, ANIM_NAME, 8.0, -8.0, -1, 49, 0, false, false, false)
        SetEnableHandcuffs(playerPed, true)
        DisablePlayerFiring(playerPed, true)
        SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
        ESX.ShowNotification(getTranslation('handcuffed'))

        handcuffObject = CreateObject(GetHashKey(HANDCUFF_MODEL), 0, 0, 0, true, true, true)
        AttachEntityToEntity(handcuffObject, playerPed, GetPedBoneIndex(playerPed, 57005), 0.02, 0.075, 0.0, 90.0, 90.0, 170.0, false, false, false, false, 2, true)
    else
        ClearPedTasks(playerPed)
        SetEnableHandcuffs(playerPed, false)
        DisablePlayerFiring(playerPed, false)
        ESX.ShowNotification(getTranslation('unhandcuffed'))

        if DoesEntityExist(handcuffObject) then
            DeleteObject(handcuffObject)
            handcuffObject = nil
        end
    end

    TriggerServerEvent('nkscuff:notifyHandcuffer', handcuffer, isHandcuffed, config.language)
end)
