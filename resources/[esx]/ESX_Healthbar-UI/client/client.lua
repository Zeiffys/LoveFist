local status = nil
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        
        SendNUIMessage({
            show = IsPauseMenuActive(),
            health = GetEntityHealth(GetPlayerPed(-1))/2,
            armor = GetPedArmour(GetPlayerPed(-1)),
            stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
            st = status,
            healthtext = cfg.healthtext,
            armortext = cfg.armortext,
            deadtext = cfg.deadtext
        })
    end
end)

RegisterNetEvent('ESX_HealthBAR-UI:updateStatus')
AddEventHandler('ESX_HealthBAR-UI:updateStatus', function(Status)
    status = Status
    SendNUIMessage({
        action = "updateStatus",
        st = Status,
    })
end)
