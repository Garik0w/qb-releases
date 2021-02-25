--------CODERC-SLO WOOD CUTTER-----
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
local mining = false
local textDel = '~g~[E]~w~ Cutt wood'
local canve = '~g~[E]~w~ PArking'
local textgar = '~g~[E]~w~ Get car '
local ClosestBerth = 1
--coord spawn vehicle------------------
local sellX4 = 1205.84  
local sellY4 = -1271.42
local sellZ4 = 35.23
local model1 = 'rumpo' --model
local delX = 1187.84  --del auto 
local delY = -1286.76
local delZ = 34.95

---------------------------------------

--------------------------------------Taglia la legna----------------------------------------------------------------------------
Citizen.CreateThread(function()
     while CashoutCore == nil do
        TriggerEvent('CashoutCore:GetObject', function(obj) CashoutCore = obj end)
        Citizen.Wait(200)
    end
   while CashoutCore.Functions.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
        
	PlayerData = CashoutCore.Functions.GetPlayerData()
    
    while true do
        local closeTo = 0
        local xp 
        local yp
        local zp
        for k, v in pairs(Config.WoodPosition) do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true) <= 2.5 then
                closeTo = v
                xp = v.coords.x
                yp = v.coords.y
                zp = v.coords.z
                break
            end
        end
        if type(closeTo) == 'table' then
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), closeTo.coords, true) <= 2.5 do
                Wait(0)
               
                DrawText3D2(xp, yp, zp+0.97, ''..textDel..'')
               
                if IsControlJustReleased(0, 38) then
                    local player, distance = CashoutCore.Functions.GetClosestPlayer()
                    if distance == -1 or distance >= 4.0 then
                        mining = true
                        SetEntityCoords(PlayerPedId(), closeTo.coords)
                        SetEntityHeading(PlayerPedId(), closeTo.heading)
                        FreezeEntityPosition(PlayerPedId(), true)
						local model = loadModel(GetHashKey(Config.Objects['pickaxe']))
                        local axe = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
                        AttachEntityToEntity(axe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, false, true, true, true, 0, true)

                        while mining do
                            Wait(0)
                            SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'))
                            helpText(Strings['wood_info'])
                            DisableControlAction(0, 24, true)
                            if IsDisabledControlJustReleased(0, 24) then
                                local dict = loadDict('melee@hatchet@streamed_core')
                                TaskPlayAnim(PlayerPedId(), dict, 'plyr_rear_takedown_b', 8.0, -8.0, -1, 2, 0, false, false, false)
                                local timer = GetGameTimer() + 800
                                while GetGameTimer() <= timer do Wait(0) DisableControlAction(0, 24, true) end
                                ClearPedTasks(PlayerPedId())
                                TriggerServerEvent('wood:getItem')
                            elseif IsControlJustReleased(0, 194) then
                                break
                            end
                        end
                        mining = false
                        DeleteObject(axe)
                        FreezeEntityPosition(PlayerPedId(), false)
                    else
                        --ESX.ShowNotification(Strings['someone_close'])
                    end
                end
            end
        end
        Wait(250)
    end
end)
-----------------------------------------------------------fine taglia la legna------------------------------------------------------------


------------------add blips--------------

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            for k, v in pairs(Config.WoodPosition) do
                addBlip(v.coords, 285, 5, Strings['wood'])
                
            end
            addBlip(Config.Sell, 285, 2, Strings['sell_wood'])
            addBlip(Config.Cars, 285, 2, Strings['autotru'])
            addBlip(Config.Process, 285, 2, Strings['process'])
            break
        end
end)

-------------------end blip----------------


-----------------------------------process-------------------------------------
local procesX = -584.66
local procesY = 5285.63
local procesZ = 70.26
------------------------------------
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(7)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, procesX, procesY, procesZ)
	
	if dist <= 20.0 then
	DrawMarker(27, procesX, procesY, procesZ-0.96, 0, 0, 0, 0, 0, 0, 2.20, 2.20, 2.20, 255, 255, 255, 200, 0, 0, 0, 0)
	else
	Citizen.Wait(1000)
	end
	local hasBagd7 = false
	local s1d7 = false
	if dist <= 2.0 then
	DrawText3D2(procesX, procesY, procesZ+0.1, "[E] Process Wood")
		if IsControlJustPressed(0, Keys['E']) then 
		CashoutCore.Functions.TriggerCallback('CashoutCore:HasItem', function(result)
					hasBagd7 = result
					s1d7 = true
			end, 'wood_cut')
			while(not s1d7) do
					Citizen.Wait(100)
				end
			if (hasBagd7) then
		SellKurczaki22()
		else
		CashoutCore.Functions.Notify('You have no more wood_cut .', 'error')
		end
		end	
	end
	
end
end)
function SellKurczaki22()
    -- local
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local inventory = CashoutCore.Functions.GetPlayerData().inventory
    local count = 0
    ----
    
    if(count == 0) then
    CashoutCore.Functions.Progressbar("search_register", "Process..", 5000, false, true, {disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                        disableInventory = true,
                    }, {}, {}, {}, function()end, function()
                        
                    end)
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.9, -0.98))
    prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z,  true,  true, true)
    SetEntityHeading(prop, GetEntityHeading(GetPlayerPed(-1)))
    LoadDict('amb@medic@standing@tendtodead@idle_a')
    TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
    Citizen.Wait(5000)
    LoadDict('amb@medic@standing@tendtodead@exit')
    TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
    ClearPedTasks(GetPlayerPed(-1))
    DeleteEntity(prop)
    TriggerServerEvent('wood_weed:processweed2')
        
    else
    
    
    end
end
--------------------------------end process------------------------------------

------------------------------------------------------SELL----------------------------------------------------
local sellX = 1210.0
local sellY = -1318.51
local sellZ = 35.23
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(7)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, sellX, sellY, sellZ)
	
	if dist <= 20.0 then
	DrawMarker(27, sellX, sellY, sellZ-0.96, 0, 0, 0, 0, 0, 0, 2.20, 2.20, 2.20, 255, 255, 255, 200, 0, 0, 0, 0)
	else
	Citizen.Wait(1000)
	end
	local hasBagd7 = false
	local s1d7 = false
	if dist <= 2.0 then
	DrawText3D2(sellX, sellY, sellZ+0.1, "[E] Sell Wood")
		if IsControlJustPressed(0, Keys['E']) then 
		CashoutCore.Functions.TriggerCallback('CashoutCore:HasItem', function(result)
					hasBagd7 = result
					s1d7 = true
			end, 'wood_proc')
			while(not s1d7) do
					Citizen.Wait(100)
				end
			if (hasBagd7) then
		SellKurczaki()
		else
		CashoutCore.Functions.Notify('You have no more Wood plank .', 'error')
		end
		end	
	end
	
end
end)
function SellKurczaki()
    -- local
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local inventory = CashoutCore.Functions.GetPlayerData().inventory
    local count = 0
    ----
    if(count == 0) then
    CashoutCore.Functions.Progressbar("search_register", "Selling..", 5000, false, true, {disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                        disableInventory = true,
                    }, {}, {}, {}, function()end, function()
                        
                    end)
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.9, -0.98))
    prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z,  true,  true, true)
    SetEntityHeading(prop, GetEntityHeading(GetPlayerPed(-1)))
    LoadDict('amb@medic@standing@tendtodead@idle_a')
    TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
    Citizen.Wait(5000)
    LoadDict('amb@medic@standing@tendtodead@exit')
    TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
    ClearPedTasks(GetPlayerPed(-1))
    DeleteEntity(prop)
    TriggerServerEvent('wood:sell')
    --TriggerServerEvent("tostKurczaki:przerob",3)
    else
    
    
    end
end

----------------------------------------end sell-------------------------------------------------------------

-------------------------------------------animazione-----------------------------------------------------
function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

---load dict and model
loadModel = function(model)
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    return model
end

loadDict = function(dict, anim)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end
----------------------------------------end animazionel--------------------------------------------------------------------
----------------------------------------teext------------------------------------------------------------
helpText = function(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end
-------------------------------------------end text------------------------------------------------------

-------------------------------------------add blip-----------------------------------------------------
addBlip = function(coords, sprite, colour, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipScale  (blip, 0.6)
    SetBlipColour (blip, 23)
    --SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end
------------------------------------------end blip-----------------------------------------

----TEXT 3D
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


-------genera auto
RegisterNetEvent('cash-jobwood:Auto')
AddEventHandler('cash-jobwood:Auto', function(boatModel, plate)
    DoScreenFadeOut(250)
    Citizen.Wait(250)
    CashoutCore.Functions.SpawnVehicle(boatModel, function(veh)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        exports['LegacyFuel']:SetFuel(veh, 100)
        SetVehicleNumberPlateText(veh, plate)
        SetEntityHeading(veh, CashoutPolicega.SpawnVehicle.h)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        SetVehicleEngineOn(veh, true, true)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
       
    end, CashoutPolicega.SpawnVehicle, true)
   SetTimeout(1000, function()
        DoScreenFadeIn(250)
    end)
end)

------------------------------------marker prendi auto ---------------------------------------------------------------
local CurrentDock = nil
local currentFuel
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        -----------------------------------------------LOCAL------------------------------------------------------

        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        ---local distanza marker 1----------------------
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, sellX4, sellY4, sellZ4)
        

        ---end local distanza marker 1------------------
       
        local vehicled = GetVehiclePedIsIn(GetPlayerPed(-1), true)
        local playerPeds = PlayerPedId()

        -------------------------------------------primo marker pavimento----------------------------------------

		if dist <= 20.0 then
			DrawMarker(25, sellX4, sellY4, sellZ4-0.96, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 200, 0, 0, 0, 0)
            DrawMarker(36, sellX4, sellY4, sellZ4 + 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.5, 0.5, 15, 255, 55, 255, true, false, false, true, false, false, false)
        end
                         

       
        -------------------------------------------fine marker pavimento-----------------------------------------
        --####################################################################################################---
        -------------------------------------------ingresso in marker 1--------------------------------------------
        if dist <= 1.0 then

            ---------------------------------------eseguo il controllo se sono in macchina----------------------
		    if GetPedInVehicleSeat(vehicled, -1) == GetPlayerPed(-1) then
              ----se sono in macchina non esegue nessuna funzione
            else
                ----se sono a piedi eseguo il codice---------------------------------------

                -------------creo il testo-------------------------------------------------
                DrawText3D2(sellX4, sellY4, sellZ4+0.1,''..textgar..' Model: '..model1..'')
                ---------------------------------------------------------------------------
                -------------creo il marker------------------------------------------------
                DrawMarker(20, CashoutPolicega.SpawnVehicle.x, CashoutPolicega.SpawnVehicle.y, CashoutPolicega.SpawnVehicle.z + 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.1, 0.2, 15, 255, 55, 255, true, false, false, true, false, false, false)
                ---------------------------------------------------------------------------

                -----------pressione tasto E-----------------------------------------------
                if IsControlJustPressed(0, Keys['E']) then 

                -----------locali di controllo---------------------------------------------
                local hasBag4g = false
				local s1 = false
				-----------eseguo il controllo se ho la carta parking----------------------
				
                
                    ----notifica preparazione auto e benzina-------------------------------------------
                    CashoutCore.Functions.Notify('I\'m preparing your car, 100% fuel.', 'success',7000)
                    -----------------------------------------------------------------------------------

                   
                    ----------------------------------------------------------------------------------

                    ----creo la progress Bar----------------------------------------------------------
                    CashoutCore.Functions.Progressbar("search_register", "Insert code card..", 7000, false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                        disableInventory = true,
                    }, {}, {}, {}, function()
                                    
                        local timeLeft = 1000 * 1 / 1000
                
                        while timeLeft > 0 do
                            Citizen.Wait(1000)
                            timeLeft = timeLeft - 1
                           
                            ----cancello animazione
                         --[[
                            ----scrivo database xpoint TriggerServerEvent('setpoint:server:point', 10)

                            ---leggo database
                            CashoutCore.Functions.TriggerCallback("leggo:server:xpoi", function(result)
                               local ped = GetPlayerPed(-1);
                               
                               for k, v in pairs(result) do
                                currentFuel = v.xpoint
                                
                
                                CashoutCore.Functions.Notify(currentFuel, "error", 5000)
                            end
                                                           
                            end, CurrentDock)]]--


                            -------------------------------terminato il timer creo l'auto------------------------------------------
                          TriggerServerEvent('cash-jobwood:server:truck', model1, ClosestBerth)
                            ------------------------------------------------------------------------------------------------------
                           
                        end
                        ----cancello animazione
                        
                    end, function()
                       
                    end)
                    ----------------fine progress Bar-----------------------------------------------------------------------------

                 
                
                ---------------------------------------------fine controllo card parking-------------------------------------------

                end	
                -----------------------------------------------fine pressione tasto-----------------------------------------------
              
                
            end
            -----------------------------------------------fine controllo se sono in  macchina---------------------------------------
		
		end	
        ---------------------------------------------------fine ingresso marker 1-------------------------------------------------------


    end
    -------fine while-------------------------------------------------------------------------------------------------
end)
-----------------------------------------------------------fine creazione prendi auto-------------------------------------------------

-------cancella auto
----parcheggia auto-------------------------------------------------
Citizen.CreateThread(function()
    while true do
	Citizen.Wait(10)
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, delX, delY, delZ)
        local ped = GetPlayerPed(-1)
        local vehicled = GetVehiclePedIsIn(GetPlayerPed(-1), true)
        local veh2 = GetVehiclePedIsIn(ped)

		if dist <= 25.0 then
        DrawMarker(36, delX, delY, delZ, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.5, 255, 0, 0, 255, false, false, false, true, false, false, false)
        DrawMarker(25, delX, delY, delZ-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 0, 0, 200, 0, 0, 0, 0)
		else
		Citizen.Wait(1500)
		end
		
		if dist <= 2.5 then
				
            if GetPedInVehicleSeat(vehicled, -1) == GetPlayerPed(-1) then
                DrawText3D2(delX, delY, delZ, ''..canve..'')
                           
                if IsControlJustPressed(0, Keys['E']) then 
                     
                    CashoutCore.Functions.DeleteVehicle(veh2)
                  
                end	

            else
        
		    end		
		end
	end
end)