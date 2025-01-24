local isHandcuffed = false
local ANIM_DICT = 'mp_arresting'
local ANIM_NAME = 'idle'
local HANDCUFF_DISTANCE = 3.0
local HANDCUFF_MODEL = 'p_cs_cuffs_02_s'
local handcuffObject = nil

local function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
end

local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(10)
    end
end

RegisterCommand('cuff', function()
    local playerPed = PlayerPedId()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer ~= -1 and closestDistance <= HANDCUFF_DISTANCE then
        TriggerServerEvent('nkscuff:handcuff', GetPlayerServerId(closestPlayer))
    else
        ESX.ShowNotification('❌ | Aucun joueur à proximité')
    end
end, false)

RegisterKeyMapping('cuff', 'Menotter/Démenotter', 'keyboard', '')

RegisterNetEvent('nkscuff:handcuff')
AddEventHandler('nkscuff:handcuff', function()
    local playerPed = PlayerPedId()
    isHandcuffed = not isHandcuffed

    if isHandcuffed then
        loadAnimDict(ANIM_DICT)
        TaskPlayAnim(playerPed, ANIM_DICT, ANIM_NAME, 8.0, -8.0, -1, 49, 0, false, false, false)
        SetEnableHandcuffs(playerPed, true)
        DisablePlayerFiring(playerPed, true)
        SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
        ESX.ShowNotification('👮 | Tu as été menotté')

        loadModel(HANDCUFF_MODEL)
        handcuffObject = CreateObject(GetHashKey(HANDCUFF_MODEL), 0, 0, 0, true, true, true)
        AttachEntityToEntity(handcuffObject, playerPed, GetPedBoneIndex(playerPed, 57005), 0.02, 0.075, 0.0, 90.0, 90.0, 170.0, false, false, false, false, 2, true)
    else
        ClearPedTasks(playerPed)
        SetEnableHandcuffs(playerPed, false)
        DisablePlayerFiring(playerPed, false)
        ESX.ShowNotification('👮 | Tu as été démenotté')

        if DoesEntityExist(handcuffObject) then
            DeleteObject(handcuffObject)
            handcuffObject = nil
        end
    end
end)