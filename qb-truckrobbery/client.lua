local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }


CashoutCore = nil 

local pos = GetEntityCoords(GetPlayerPed(-1),  true)
local s1, s2 = GetStreetNameAtCoord( pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
local street1 = GetStreetNameFromHashKey(s1)
local street2 = GetStreetNameFromHashKey(s2)
local isRobbing = false
local hasRobbed = false
local looting = false
local haker = true
local ClosestBerth = 1
local model1 = 'stockade'


------------------------------------------------CORE----------------------------

Citizen.CreateThread(function()
    while CashoutCore == nil do
        TriggerEvent('CashoutCore:GetObject', function(obj) CashoutCore = obj end)
        Citizen.Wait(200)
    end
	
	while CashoutCore.Functions.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = CashoutCore.Functions.GetPlayerData()
end)

--onload player
RegisterNetEvent('CashoutCore:Client:OnPlayerLoaded')
AddEventHandler('CashoutCore:Client:OnPlayerLoaded', function()
    CashoutCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        PlayerData = CashoutCore.Functions.GetPlayerData()
    end)
end)

--setjob
RegisterNetEvent('CashoutCore:Client:OnJobUpdate')
AddEventHandler('CashoutCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)
--------------------------------------------------------------------------------




RegisterNetEvent('RS7x:Blip')
AddEventHandler('RS7x:Blip', function(x,y,z)
  Blip = AddBlipForCoord(x,y,z)
    SetBlipSprite(Blip,  477)
    SetBlipColour(Blip,  1)
    SetBlipAlpha(Blip,  250)
    SetBlipDisplay(Blip, 4)
    SetBlipScale(Blip, 1.2)
    SetBlipFlashes(Blip, true)
    SetBlipAsShortRange(Blip,  true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Robbery In Progress | Money Truck')
    EndTextCommandSetBlipName(Blip)
    Wait(Config.BlipTimer * 1000)
    RemoveBlip(Blip)
end)

function DrawText3Ds(x,y,z,text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent('animation:rob')
AddEventHandler('animation:rob', function()
    local Ped = GetPlayerPed(-1)
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end

    while isRobbing == true do
        if not IsEntityPlayingAnim(Ped, "mini@repair", "fixing_a_player", 3) then
            CashoutCore.Functions.Progressbar("search_register", "Taking Cash/Gold", 10000, false, true, {disableMovement = true,
       disableCarMovement = true,
       disableMouse = false,
       disableCombat = true,
       disableInventory = true,
   }, {}, {}, {}, function()end, function()
       
   end)
            ClearPedSecondaryTask(Ped)
            TaskPlayAnim(Ped, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    ClearPedTasksImmediately(Ped)
end)

RegisterNetEvent('animation:hack')
AddEventHandler('animation:hack', function()
    local Ped = GetPlayerPed(-1)
    RequestAnimDict("anim@heists@humane_labs@emp@hack_door")
    while not HasAnimDictLoaded("anim@heists@humane_labs@emp@hack_door") do
        Citizen.Wait(0)
    end

    while Hacking == true do
        if not IsEntityPlayingAnim(Ped, "anim@heists@humane_labs@emp@hack_door", "hack_loop", 3) then
            ClearPedSecondaryTask(Ped)
            TaskPlayAnim(Ped, "anim@heists@humane_labs@emp@hack_door", "hack_loop", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    ClearPedTasksImmediately(Ped)
end)

RegisterNetEvent('RS7x:getReward')
AddEventHandler('RS7x:getReward', function()
  local pos = GetEntityCoords(GetPlayerPed(-1))
  local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.001, 0, 70)

    if vehicle == GetHashKey('stockade') or GetEntityModel(vehicle) then
      createped()
      SetVehicleDoorOpen(vehicle,2,0,0)
      SetVehicleDoorOpen(vehicle,3,0,0)
      pedSpawned = true
      TriggerServerEvent('RS7x:NotifyPolice', street1, street2, pos)
    end
    Citizen.Wait(0)
end)

function Timeout(hasRobbed)
    local timer = Config.Timeout
    while hasRobbed == true do
        Citizen.Wait(1000)

        if timer > 0 then
            timer = timer -1
        end

        if timer == 1 then
            hasRobbed = false
            finished = false
            break
        end
    end
end

RegisterNetEvent('RS7x:robbingtimer')
AddEventHandler('RS7x:robbingtimer', function ()

    if isRobbing == true then
        local timer = Config.Timer

        Citizen.CreateThread(function()
            while timer > 0 and isRobbing do
                Citizen.Wait (1000)

                if  timer > 0 then
                    timer = timer -1
                end

                if timer == 1 then
                    RemoveBlip(Blipe)
                   
                    finished = true
                    Citizen.Wait(40000)
                    --CashoutCore.Functions.Notify('Rimuovi veicolo 3', 'error')
                    delvehic()
                    break
                end
            end
        end)
    end
end)

function PlateCheck(CurPlate, CurrentPlate)
    if CurrentPlate ~= CurPlate then
        return
    else
        playAnim("random@mugging4", "struggle_loop_b_thief", 3500)
        
        -------------------------------------------ex progress bar
        CashoutCore.Functions.Progressbar("search_register", "I open the safety deposit boxes", 3500, false, true, {disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()end, function()
        
    end)
        Citizen.Wait(3500)
        looting = true
        isRobbing = true
        TriggerEvent('animation:rob')
       ---------------------------------------ex progress bar     
        TriggerServerEvent('RS7x:Payout')
        TriggerEvent('RS7x:robbingtimer')
    end
end

RobbedPlates = {}

Citizen.CreateThread(function()
  while true do

    Citizen.Wait(0)

    local pos = GetEntityCoords(GetPlayerPed(-1))
    local stockade = GetHashKey('stockade')
    local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.001, stockade, 70)
    local text = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -4.25, 0.0)
    local dstCheck = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, GetEntityCoords(vehicle), true)
    local Plate = GetVehicleNumberPlateText(vehicle)

    if DoesEntityExist(vehicle) then

        if not IsEntityDead(GetPlayerPed(-1)) then

            if pedSpawned == true and vehicle then

                --DrawMarker(27, text.x, text.y, text.z, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 255, 0, 0, 100, 0, 0, 0, 0)
                
                if dstCheck < 5.0 then
                    DrawText3Ds(text.x, text.y, text.z, "~r~[E]~w~ To Rob")
                    if IsControlJustReleased(0,38) and not looting then
                        CurrentPlate = GetVehicleNumberPlateText(vehicle)
                        PlateCheck(CurPlate, CurrentPlate)
                        isRobbing = true
                        SetVehicleDoorOpen(vehicle,2,0,0)
			            SetVehicleDoorOpen(vehicle,3,0,0)
                    end
                end
                if finished then
                    SetPedAsNoLongerNeeded(guard)
                    SetPedAsNoLongerNeeded(guard2)
                    SetPedAsNoLongerNeeded(guard3)
                    pedSpawned = false
                    isRobbing = false
                    looting = false
                    haker = true
                    RemoveBlip(Blipe)
                    delvehic()
                   -- CashoutCore.Functions.Notify('Rimuovi veicolo 1', 'error')
                    Timeout(true)
                    RobbedPlates[Plate] = true
                    TriggerServerEvent('RS7x:UpdatePlates', RobbedPlates, Plate)
                    TriggerServerEvent('RS7x:moneytruck_false')
                end
            end
        else
            TriggerServerEvent('RS7x:moneytruck_false')
            Citizen.Wait(Config.Timeout * 1000)
            finished = false
            isRobbing = false
            pedSpawned = false
            looting = false
            haker = true
            RemoveBlip(Blipe)
           -- CashoutCore.Functions.Notify('Rimuovi veicolo 2', 'error')
            delvehic()
        end
    else
        Citizen.Wait(500)
    end
    end
end)

RegisterNetEvent('np-truckrobbery:rob')
AddEventHandler('np-truckrobbery:rob', function()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local stockade = GetHashKey('stockade')
    local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.001, stockade, 70)
    local text = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -4.25, 0.0)
    local dstCheck = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, GetEntityCoords(vehicle), true)
    local Plate = GetVehicleNumberPlateText(vehicle)

    if DoesEntityExist(vehicle) then

        if not isRobbing then
            if dstCheck < 5.0 then
                if not hasRobbed then
                    if not RobbedPlates[Plate] then

                        ---------------------------------insert notify police-------------------
                        ---- NOTIFY
                        -----------------------------------------------------------------------

                       CurPlate = GetVehicleNumberPlateText(vehicle)
                       -----------------------------------anim
                       CashoutCore.Functions.Progressbar("search_register", "You are opening the door", 3500, false, true, {disableMovement = true,
                       disableCarMovement = true,
                       disableMouse = false,
                       disableCombat = true,
                       disableInventory = true,
                        }, {}, {}, {}, function()end, function()
                        end)
                        --------------------------------------------------------------------
                        playAnim('mp_common', 'givetake1_a', 3500)
                        Citizen.Wait(3500)
                        TriggerServerEvent('RS7x:Itemcheck', 1)
                    else
                      
                       CashoutCore.Functions.Notify('This truck appears to be empty (already hit)', 'error')
                    end
                end
            end
        end

    end
end)

RegisterNetEvent('RS7x:newTable')
AddEventHandler('RS7x:newTable', function(UpdatedTable)
    RobbedPlates = UpdatedTable
end)

RegisterNetEvent('RS7x:startHacking')
AddEventHandler('RS7x:startHacking', function(cb)
    TriggerEvent('RS7x:getReward')
    Hacking = false
end)

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end

RegisterNetEvent('RS7x:NotifyPolice')
AddEventHandler('RS7x:NotifyPolice', function(msg)
    
    CashoutCore.Functions.Notify(msg, 'error')
end)

function cb1(success, timeremaining)
    if success then
        TriggerEvent('RS7x:getReward')
        Hacking = false
    else
      
        CashoutCore.Functions.Notify('You failed to hack you need to wait 30 seconds', 'error')
        TriggerEvent('mhacking:hide')
        TriggerServerEvent('RS7x:NotifyPolice', street1, street2, pos)
        Hacking = false
        Wait(30 * 1000) -- add a time penalty if failed, so it gives police more time to arrive // feel free to remove
        isRobbing = false
       
        CashoutCore.Functions.Notify('you can now hit the truck again', 'success')
        TriggerServerEvent('RS7x:moneytruck_false')
    end
end

function createped()

    local pos = GetEntityCoords(GetPlayerPed(-1))
    local hashKey = GetHashKey("ig_casey")
    local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.001, 0, 70)
    local pedType = 5

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(500)
    end

    print('Spawning Peds?')

    guard = CreatePedInsideVehicle(vehicle, pedType, hashKey, 0, 1, 1)
    guard2 = CreatePedInsideVehicle(vehicle, pedType, hashKey, 1, 1, 1)
    guard3 =  CreatePedInsideVehicle(vehicle, pedType, hashKey, 2, 1, 1)

  --////////////
  --  Guard 1
  --///////////

    SetPedShootRate(guard,  750)
    SetPedCombatAttributes(guard, 46, true)
    SetPedFleeAttributes(guard, 0, 0)
    SetPedAsEnemy(guard,true)
    SetPedMaxHealth(guard, 900)
    SetPedAlertness(guard, 3)
    SetPedCombatRange(guard, 0)
    SetPedCombatMovement(guard, 3)
    TaskCombatPed(guard, GetPlayerPed(-1), 0,16)
    TaskLeaveVehicle(guard, vehicle, 0)
    GiveWeaponToPed(guard, GetHashKey("WEAPON_SMG"), 5000, true, true)
    SetPedRelationshipGroupHash( guard, GetHashKey("HATES_PLAYER"))

    --////////////
    --  Guard 2
    --///////////
    SetPedShootRate(guard2,  750)
    SetPedCombatAttributes(guard2, 46, true)
    SetPedFleeAttributes(guard2, 0, 0)
    SetPedAsEnemy(guard2,true)
    SetPedMaxHealth(guard2, 900)
    SetPedAlertness(guard2, 3)
    SetPedCombatRange(guard2, 0)
    SetPedCombatMovement(guard2, 3)
    TaskCombatPed(guard2, GetPlayerPed(-1), 0,16)
    TaskLeaveVehicle(guard2, vehicle, 0)
    GiveWeaponToPed(guard2, GetHashKey("WEAPON_SMG"), 5000, true, true)
    SetPedRelationshipGroupHash( guard2, GetHashKey("HATES_PLAYER"))
  
    --////////////
    --  Guard3
    --///////////
    SetPedShootRate(guard3,  750)
    SetPedCombatAttributes(guard3, 46, true)
    SetPedFleeAttributes(guard3, 0, 0)
    SetPedAsEnemy(guard3,true)
    SetPedMaxHealth(guard3, 900)
    SetPedAlertness(guard3, 3)
    SetPedCombatRange(guard3, 0)
    SetPedCombatMovement(guard3, 3)
    TaskCombatPed(guard3, GetPlayerPed(-1), 0,16)
    TaskLeaveVehicle(guard3, vehicle, 0)
    GiveWeaponToPed(guard3, GetHashKey("WEAPON_SMG"), 5000, true, true)
    SetPedRelationshipGroupHash( guard3, GetHashKey("HATES_PLAYER"))
end


-------------------------------------------CREO IL MARKER PER GENERARE IL FURGONE-------------------------------------------

-----------------------------------------------PROCESS----------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        -----------------------------------------------LOCAL------------------------------------------------------

        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        ---local distanza marker 1----------------------
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.sellX4f, Config.sellY4f, Config.sellZ4f)
      
        ---end local distanza marker 1------------------
       
        local vehicled = GetVehiclePedIsIn(GetPlayerPed(-1), true)
        local playerPeds = PlayerPedId()

        -------------------------------------------MARKER----------------------------------------

		if dist <= 5.0 then
			DrawMarker(25, Config.sellX4f, Config.sellY4f, Config.sellZ4f-0.96, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 200, 0, 0, 0, 0)
            DrawMarker(20, Config.sellX4f, Config.sellY4f, Config.sellZ4f + 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.2, 0.2, 15, 255, 55, 255, true, false, false, true, false, false, false)
        end
                   
        --####################################################################################################---

        -------------------------------------------ingresso in marker 1--------------------------------------------
        if dist <= 3.0 then

            ---------------------------------------eseguo il controllo se sono in macchina----------------------
		    if GetPedInVehicleSeat(vehicled, -1) == GetPlayerPed(-1) then
              ----se sono in macchina non esegue nessuna funzione
            else
                ----se sono a piedi eseguo il codice---------------------------------------

                -------------creo il testo-------------------------------------------------
                DrawText3D2(Config.sellX4f, Config.sellY4f, Config.sellZ4f+0.1,'~g~[E]~r~ Hackera~w~ Find the coordinates of the security van')
                ---------------------------------------------------------------------------
                
                -----------pressione tasto E-----------------------------------------------
                    if IsControlJustPressed(0, Keys['E']) then 

                            
                                        local hasBagd7 = false
                                        local s1d7 = false
                                
                                        --controllo se ho l'item
                                        CashoutCore.Functions.TriggerCallback('CashoutCore:HasItem', function(result2)
                                        hasBagd7 = result2
                                        s1d7 = true
                                        end, Config.Item)
                                        while(not s1d7) do
                                        Citizen.Wait(100)
                                        end
                                         ----se ho l'item eseguo
                                                    if (hasBagd7) then
                                                          -----------eseguo----
                                                          if haker == true then
                                                            haker = false
                                                          Hakera()
                                                          else
                                                            CashoutCore.Functions.Notify('Robbery in progress you have to wait', 'error', 5000)
                                                          end
                                                    else
                                                      CashoutCore.Functions.Notify('you don\'t have a Hack Kit', 'error', 5000)
                                                    end
                    

                    end	

                -----------------------------------------------fine pressione tasto-----------------------------------------------
               
            end
            -----------------------------------------------fine controllo se sono in  macchina---------------------------------------
		
		end	
        ---------------------------------------------------fine ingresso marker 1-------------------------------------------------------

    end
    -------fine while-------------------------------------------------------------------------------------------------
end)

-------------------------------------anim hakera-------------------
function Hakera()
    -- local
    FreezeEntityPosition(player,true)
	local player = PlayerPedId()
	local playerPos = GetEntityCoords(player)
								
	-- animation 1:
	local animDict = "random@atmrobberygen@male"
	local animName = "idle_a"
							
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(0)
	end
    CashoutCore.Functions.Progressbar("search_register", "CONNECTING DEVICE", 12000, false, true, {disableMovement = true,
    disableCarMovement = true,
    disableMouse = false,
    disableCombat = true,
    disableInventory = true,
    }, {}, {}, {}, function()end, function()
    
    end)
        
        TaskPlayAnim(player,animDict,animName,3.0,0.5,-1,31,1.0,0,0)
        Citizen.Wait(7500)
        TaskStartScenarioInPlace(player, 'WORLD_HUMAN_STAND_MOBILE', 0, true)
        Citizen.Wait(4500)
        TriggerEvent("mhacking:show")
        TriggerEvent("mhacking:start",4,30,hackingEvent)
        --HackingATM = true


end
---------------------------------------------------------------- Hacking Event:-------------------
function hackingEvent(success)
	local player = PlayerPedId()
    FreezeEntityPosition(player,false)
    TriggerEvent('mhacking:hide')
    if success then
        
        ----FUNZIONE CHE SPAWNA IL FURGONE DA SCASSINARE RemoveBlip(Blipe)

        CashoutCore.Functions.Notify('You successfully hacked', "success", 4000)
        
        CashoutCore.Functions.Notify('The van is indicated on the map', 'success', 15000)
                Blipe = AddBlipForCoord(-95.32, 6478.97, 31.16)
                SetBlipColour(Blipe, 3)
                SetBlipRoute(Blipe, true)
                SetBlipRouteColour(Blipe, 3)

        --------------GENERO IL FURGONE
        TriggerServerEvent('cash-trukrob:server:truck', model1, ClosestBerth)
        
    else
        haker = true
		CashoutCore.Functions.Notify('You failed to hack!', "error", 5000)
	end
	ClearPedTasks(player)
	ClearPedSecondaryTask(player)	
	RobbingATM = false
	HackingATM = false
end
-------------------------------------------------------------------end hakera-----------------------

---------------------------------------------------END MARKER PER GENERARE IL FURGONE----------------------------------------------------------------------

-----------------------------------------------GENERA AUTO----------------------------------------------
RegisterNetEvent('cash-trurob:Auto')
AddEventHandler('cash-trurob:Auto', function(boatModel, plate)
   
    CashoutCore.Functions.SpawnVehicle(boatModel, function(veh)
        --TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        exports['LegacyFuel']:SetFuel(veh, 100)
        SetVehicleNumberPlateText(veh, plate)
        SetEntityHeading(veh, CashoutPolicega.SpawnVehicle.h)
       -- TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        SetVehicleEngineOn(veh, true, true)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
       
    end, CashoutPolicega.SpawnVehicle, true)
 
end)


------------------------------------------END GENERA AUTO--------------------------------------------


------------------------------------TEXT DRAW3D-----------------------------------
function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D2(x, y, z, text)
  
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end
----------------------------------------------------------------------------------

---------------------------------DELETE VEHICLE--------------------------------
function delvehic()
    Citizen.Wait(65000)
    local vehicle = CashoutCore.Functions.GetClosestVehicle()
    if IsPedInAnyVehicle(GetPlayerPed(-1)) then 
    vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false) 
    else 
    vehicle = CashoutCore.Functions.GetClosestVehicle() 
    end	
    CashoutCore.Functions.DeleteVehicle(vehicle)
end
-------------------------------------------------------------------------------