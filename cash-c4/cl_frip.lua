print ('All good CoderC-slo')
--ESX = nil
CashoutCore = nil
local timer = 0
------------
--Citizen.CreateThread(function()
--	while true do
--        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--		Citizen.Wait(0)

--    end
--end)
Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if CashoutCore == nil then
            TriggerEvent("CashoutCore:GetObject", function(obj) CashoutCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

RegisterNetEvent('FripeX:CheckIfRequirementsAreMet')
AddEventHandler('FripeX:CheckIfRequirementsAreMet', function()
    local ped = GetPlayerPed(-1)
    local coords = GetEntityCoords(ped)
    local veh = GetClosestVehicle(coords.x, coords.y, coords.z, 3.000, 0, 70)
    local vCoords = GetEntityCoords(veh)
    local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, vCoords.x, vCoords.y, vCoords.z, false)
    local animDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@"
    local anim = "weed_spraybottle_crouch_base_inspector"

    if not IsPedInAnyVehicle(ped, false) then
        if veh and (dist < 3.0) then
            loadAnimDict(animDict)
            Citizen.Wait(1000)
            print ('CoderC-slo')
            TaskPlayAnim(ped, animDict, anim, 3.0, 1.0, -1, 0, 1, 0, 0, 0)
			CashoutCore.Functions.Notify("I'm placing the bomb 10 seconds and it explodes.", "success")
			
			--TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'I'm placing the bomb 10 seconds and it explodes'})
			--ESX.ShowNotification("placing the bomb 10 seconds and it explodes")
            --if Config.UsingProgressBars then
                --exports['progressBars']:startUI(Config.TimeTakenToArm * 1000, "Armement en cours ...")
           -- end
            Citizen.Wait(Config.TimeTakenToArm * 1000)
            ClearPedTasksImmediately(PlayerPedId())
            TriggerServerEvent('FripeX:RemoveBombFromInv')
            RunTimer(veh)
        else
            if Config.UsingMythicNotifications then
			CashoutCore.Functions.Notify("No vehicles nearby")
                --TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'No vehicles nearby'})
				--ESX.ShowNotification("No vehicles nearby")
            end
        end
    else
        if Config.UsingMythicNotifications then
		CashoutCore.Functions.Notify("impossible to place the bomb inside the vehicle")
            --TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'impossible to place the bomb inside the vehicle'})
			--ESX.ShowNotification("impossible to place the bomb inside the vehicle")
        end
    end
end)

function RunTimer(veh)
    timer = Config.TimeUntilDetonation
    while timer > 0 do
        timer = timer - 1
        Citizen.Wait(1000)
        if timer == 0 then
            DetonateVehicle(veh)
        end
    end
end

function DetonateVehicle(veh)
    local vCoords = GetEntityCoords(veh)
    if DoesEntityExist(veh) then
        AddExplosion(vCoords.x, vCoords.y, vCoords.z, 5, 50.0, true, false, true)
    end
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(20)
    end
end