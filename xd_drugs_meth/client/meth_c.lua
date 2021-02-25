------CODERC-SLO----------
----DRUG METH------------


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
isLoggedIn = true

local menuOpen = false
local wasOpen = false

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if CashoutCore == nil then
            TriggerEvent("CashoutCore:GetObject", function(obj) CashoutCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

local spawnedWeed = 0
local weedPlants = {}
local spawnedWeed2 = 0
local weedPlants2 = {}

-------------------------COORD CRAFT SODIUM
local sellX4 = 181.27  
local sellY4 = 2778.28
local sellZ4 = 45.66
-------------------------------

local isPickingUp, isProcessing, isProcessing2 = false, false, false

RegisterNetEvent("CashoutCore:Client:OnPlayerLoaded")
AddEventHandler("CashoutCore:Client:OnPlayerLoaded", function()
	CheckCoords2()
	CheckCoords2m()
	Citizen.Wait(1000)
	local coords = GetEntityCoords(PlayerPedId())
	if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedField.coords, true) < 1000 then
		SpawnWeedPlants2d()
	end
	--second spown
	if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedField2.coords, true) < 1000 then
		SpawnWeedPlants2dm()
	end
end)

function CheckCoords2()
	Citizen.CreateThread(function()
		while true do
			local coords = GetEntityCoords(PlayerPedId())
			if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedField.coords, true) < 1000 then
				SpawnWeedPlants2d()
			end
			Citizen.Wait(1 * 60000)
		end
	end)
end
-------second spown
function CheckCoords2m()
	Citizen.CreateThread(function()
		while true do
			local coords = GetEntityCoords(PlayerPedId())
			if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedField2.coords, true) < 1000 then
				SpawnWeedPlants2dm()
			end
			Citizen.Wait(1 * 60000)
		end
	end)
end

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		CheckCoords2()
		CheckCoords2m()
	end
end)
Citizen.CreateThread(function()--weed
	while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID
		
		
		for i=1, #weedPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(weedPlants[i]), false) < 1 then
				nearbyObject, nearbyID = weedPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				CashoutCore.Functions.Draw2DText(0.5, 0.88, 'Press ~g~[E]~w~ to pickup Hydrocloric acid', 0.5)
			end
			local hasBagd = false
			local s1d = false
			if IsControlJustReleased(0, 38) and not isPickingUp then

				CashoutCore.Functions.TriggerCallback('CashoutCore:HasItem', function(result)
					hasBagd = result
					s1d = true
				end, 'hydrochloric_bottle')
				while(not s1d) do
					Citizen.Wait(100)
				end
				if (hasBagd) then
				isPickingUp = true
				TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, false)
				--PROP_HUMAN_BUM_BIN animazione
				--prop_cs_cardbox_01 oggetto di spawn  prop_plant_01a
				CashoutCore.Functions.Progressbar("search_register", "Picking up Acid..", 7500, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				}, {}, {}, {}, function() -- Done
					ClearPedTasks(GetPlayerPed(-1))
					CashoutCore.Functions.DeleteObject(nearbyObject)

					table.remove(weedPlants, nearbyID)
					spawnedWeed = spawnedWeed - 1

					TriggerServerEvent('xd_drugs:metacid')
				end, function()
					ClearPedTasks(GetPlayerPed(-1))
				end) -- Cancel

				isPickingUp = false
			else
				CashoutCore.Functions.Notify('You dont have enough empity Bottle .', 'error')
			end	
			end
		else
			Citizen.Wait(500)
		end
	end
end)
Citizen.CreateThread(function()--weed
	while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID
		
		
		for i=1, #weedPlants2, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(weedPlants2[i]), false) < 1 then
				nearbyObject, nearbyID = weedPlants2[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				CashoutCore.Functions.Draw2DText(0.5, 0.88, 'Press ~g~[E]~w~ to pickup Sulfuric', 0.5)
			end
			local hasBagd = false
			local s1d = false
			if IsControlJustReleased(0, 38) and not isPickingUp then

				CashoutCore.Functions.TriggerCallback('CashoutCore:HasItem', function(result)
					hasBagd = result
					s1d = true
				end, 'sulfuricacid_bottle')
				while(not s1d) do
					Citizen.Wait(100)
				end
				if (hasBagd) then
				isPickingUp = true
				TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, false)
				--PROP_HUMAN_BUM_BIN animazione
				--prop_cs_cardbox_01 oggetto di spawn  prop_plant_01a
				CashoutCore.Functions.Progressbar("search_register", "Picking Sulfuric..", 7500, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					disableInventory = true,
				}, {}, {}, {}, function() -- Done
					ClearPedTasks(GetPlayerPed(-1))
					CashoutCore.Functions.DeleteObject(nearbyObject)

					table.remove(weedPlants2, nearbyID)
					spawnedWeed2 = spawnedWeed2 - 1

					TriggerServerEvent('xd_drugs:metasodium')
				end, function()
					ClearPedTasks(GetPlayerPed(-1))
				end) -- Cancel

				isPickingUp = false
			else
				CashoutCore.Functions.Notify('You dont have enough empity Bottle .', 'error')
			end	
			end
		else
			Citizen.Wait(500)
		end
	end
end)


AddEventHandler('onResourceStop', function(resource) --weedPlants
	if resource == GetCurrentResourceName() then
		for k, v in pairs(weedPlants) do
			CashoutCore.Functions.DeleteObject(v)
		end
		for k, v in pairs(weedPlants2) do
			CashoutCore.Functions.DeleteObject(v)
		end
	end
end)
function SpawnWeedPlants2d() --This spawns in the Weed plants, 
	while spawnedWeed < 25 do
		Citizen.Wait(1)
		local weedCoords = GenerateWeedCoords2()
--prop_barrel_01a  prop_plant_01a
		CashoutCore.Functions.SpawnLocalObject('prop_barrel_02b', weedCoords, function(obj) --- change this prop to whatever plant you are trying to use 
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)
			

			table.insert(weedPlants, obj)
			spawnedWeed = spawnedWeed + 1
		end)
	end
	Citizen.Wait(45 * 60000)
end

--second spown
function SpawnWeedPlants2dm() --This spawns in the Weed plants, 
	while spawnedWeed2 < 25 do
		Citizen.Wait(1)
		local weedCoords = GenerateWeedCoords2m()
--prop_barrel_01a  prop_plant_01a
		CashoutCore.Functions.SpawnLocalObject('prop_barrel_exp_01a', weedCoords, function(obj) --- change this prop to whatever plant you are trying to use 
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)
			

			table.insert(weedPlants2, obj)
			spawnedWeed2 = spawnedWeed2 + 1
		end)
	end
	Citizen.Wait(45 * 60000)
end


function ValidateWeedCoord(plantCoord) --This is a simple validation checker
	if spawnedWeed > 0 then
		local validate = true

		for k, v in pairs(weedPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.WeedField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateWeedCoords2() --This spawns the weed plants at the designated location
	while true do
		Citizen.Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-5, 5)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-5, 5)

		weedCoordX = Config.CircleZones.WeedField.coords.x + modX
		weedCoordY = Config.CircleZones.WeedField.coords.y + modY

		local coordZ = GetCoordZWeed(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateWeedCoord(coord) then
			return coord
		end
	end
end

function GenerateWeedCoords2m() --This spawns the weed plants at the designated location
	while true do
		Citizen.Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-5, 5)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-5, 5)

		weedCoordX = Config.CircleZones.WeedField2.coords.x + modX
		weedCoordY = Config.CircleZones.WeedField2.coords.y + modY

		local coordZ = GetCoordZWeed2(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateWeedCoordm(coord) then
			return coord
		end
	end
end
function ValidateWeedCoordm(plantCoord) --This is a simple validation checker
	if spawnedWeed2 > 0 then
		local validate = true

		for k, v in pairs(weedPlants2) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.WeedField2.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GetCoordZWeed(x, y) ---- Set the coordinates relative to the heights near where you want the circle spawning
	local groundCheckHeights = { 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 31.85
end
function GetCoordZWeed2(x, y) ---- Set the coordinates relative to the heights near where you want the circle spawning
	local groundCheckHeights = { 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 31.85
end

Citizen.CreateThread(function() --- check that makes sure you have the materials needed to process
	while CashoutCore == nil do
		Citizen.Wait(200)
	end
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedProcessing.coords, true) < 1 then
			DrawMarker(20, Config.CircleZones.WeedProcessing.coords.x, Config.CircleZones.WeedProcessing.coords.y, Config.CircleZones.WeedProcessing.coords.z - 0.66 , 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 100, 0, 0, 0, true, 0, 0, 0)

			
			if not isProcessing then
				CashoutCore.Functions.DrawText3D(Config.CircleZones.WeedProcessing.coords.x, Config.CircleZones.WeedProcessing.coords.y, Config.CircleZones.WeedProcessing.coords.z, 'Press ~g~[ E ]~w~ to Process Meth')
			end

			if IsControlJustReleased(0, 38) and not isProcessing then
				local hasBag = false
				local s1 = false
				local hasWeed = false
				local s2 = false
				local hasmet = false 
				local s2m = false

				CashoutCore.Functions.TriggerCallback('CashoutCore:HasItem', function(result)
					hasWeed = result
					s1 = true
				end, 'sulfuricacid')
				
				while(not s1) do
					Citizen.Wait(100)
				end
				Citizen.Wait(100)
				CashoutCore.Functions.TriggerCallback('CashoutCore:HasItem', function(result)
					hasBag = result
					s2 = true
				end, 'hydrochloric')
				
				while(not s2) do
					Citizen.Wait(100)
				end
				CashoutCore.Functions.TriggerCallback('CashoutCore:HasItem', function(result)
					hasmet = result 
					s2m = true
				end, 'sodiumhydroxide')
				
				while(not s2m) do
					Citizen.Wait(100)
				end

				if (hasWeed and hasBag and hasmet) then
					Processweed3d()
				
				else
					CashoutCore.Functions.Notify('you must have these materials.sulfuricacid, hydrochloric, sodiumhydroxide', 'error')
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)



function Processweed3d()  -- simple animations to loop while process is taking place
	isProcessing = true
	local playerPed = PlayerPedId()

	
	--
	--TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
	--SetEntityHeading(PlayerPedId(), 108.06254)
	local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.9, -0.98))
	prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z,  true,  true, true)
	SetEntityHeading(prop, GetEntityHeading(GetPlayerPed(-1)))
	LoadDict('amb@medic@standing@tendtodead@idle_a')
	TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
	
	CashoutCore.Functions.Progressbar("search_register", "Trying to Process..", 12000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                        disableInventory = true,
		
	}, {}, {}, {}, function()
		
	
	Citizen.Wait(1000)
	LoadDict('amb@medic@standing@tendtodead@exit')
	TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
         
	    TriggerServerEvent('xd_drugs_weed:metprocess') -- Done

		local timeLeft = Config.Delays.WeedProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.WeedProcessing.coords, false) > 4 then
				TriggerServerEvent('xd_drugs_weed:cancelProcmet')
				break
			end
		end
		ClearPedTasks(GetPlayerPed(-1))
         DeleteEntity(prop)
		--ClearPedTasks(GetPlayerPed(-1))
	end, function()
		ClearPedTasks(GetPlayerPed(-1))
         DeleteEntity(prop)
		--ClearPedTasks(GetPlayerPed(-1))
	end) -- Cancel
		
	
	isProcessing = false
	
end


Citizen.CreateThread(function() --- check that makes sure you have the materials needed to process
	while CashoutCore == nil do
		Citizen.Wait(200)
	end
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.DrugDealer.coords, true) < 1 then
			DrawMarker(20, Config.CircleZones.DrugDealer.coords.x, Config.CircleZones.DrugDealer.coords.y, Config.CircleZones.DrugDealer.coords.z - 0.66 , 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 100, 0, 0, 0, true, 0, 0, 0)

			
			if not isProcessing2 then
				CashoutCore.Functions.DrawText3D(Config.CircleZones.DrugDealer.coords.x, Config.CircleZones.DrugDealer.coords.y, Config.CircleZones.DrugDealer.coords.z, 'Press ~g~[ E ]~w~ to Sell Meth')
			end

			if IsControlJustReleased(0, 38) and not isProcessing2 then
				--local hasBag = false
				--local s1 = false
				local hasWeed2 = false
				local hasBag2 = false
				local s3 = false
				
				CashoutCore.Functions.TriggerCallback('CashoutCore:HasItem', function(result)
					hasWeed2 = result
					hasBag2 = result
					s3 = true
					
				end, 'blue_meth')
				
				while(not s3) do
					Citizen.Wait(100)
				end
				

				if (hasWeed2) then
					SellDrug3()
				elseif (hasWeed2) then
					CashoutCore.Functions.Notify('You dont have blue_meth.', 'error')
				elseif (hasBag2) then
					CashoutCore.Functions.Notify('You dont have blue_meth.', 'error')
				else
					CashoutCore.Functions.Notify('You dont have blue_meth.', 'error')
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function SellDrug3()  -- simple animations to loop while process is taking place
	isProcessing2 = true
	local playerPed = PlayerPedId()

	--
	local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.9, -0.98))
	prop = CreateObject(GetHashKey('prop_luggage_07a'), x, y, z,  true,  true, true)
	SetEntityHeading(prop, GetEntityHeading(GetPlayerPed(-1)))
	LoadDict('amb@medic@standing@tendtodead@idle_a')
	TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)

	CashoutCore.Functions.Progressbar("search_register", "Trying to Process..", 10000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		disableInventory = true,
	}, {}, {}, {}, function()
	  -- Done
	  --Citizen.Wait(1000)
	  LoadDict('amb@medic@standing@tendtodead@exit')
	  TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)

	  TriggerServerEvent('xd_drugs_weed:sellmeth')
		local timeLeft = Config.Delays.WeedProcessing / 1000

		while timeLeft > 0 do
			Citizen.Wait(500)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.WeedProcessing.coords, false) > 4 then
				--TriggerServerEvent('xd_drugs_weed:cancelProcessing2d')
				ClearPedTasks(GetPlayerPed(-1))
                 DeleteEntity(prop)
				break
			end
		end
		ClearPedTasks(GetPlayerPed(-1))
         DeleteEntity(prop)
		
		
	end, function()
		ClearPedTasks(GetPlayerPed(-1))
         DeleteEntity(prop)
	end) -- Cancel
		
	
	isProcessing2 = false
end


-----------------------------------------------PROCESS CRAFT SODIUM-----------------------------------------------
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

        -------------------------------------------MARKER----------------------------------------

		if dist <= 10.0 then
			DrawMarker(25, sellX4, sellY4, sellZ4-0.96, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 200, 0, 0, 0, 0)
            --DrawMarker(20, sellX4, sellY4, sellZ4 + 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.2, 0.2, 15, 255, 55, 255, true, false, false, true, false, false, false)
        end
            
        -------------------------------------------fine marker pavimento-----------------------------------------
        --####################################################################################################---

        -------------------------------------------ingresso in marker 1--------------------------------------------
        if dist <= 3.0 then

            ---------------------------------------eseguo il controllo se sono in macchina----------------------
		    if GetPedInVehicleSeat(vehicled, -1) == GetPlayerPed(-1) then
              ----se sono in macchina non esegue nessuna funzione
            else
                ----se sono a piedi eseguo il codice---------------------------------------

                -------------creo il testo-------------------------------------------------
                DrawText3D2(sellX4, sellY4, sellZ4+0.1,'~g~[E]~w~ Sodium Hidroxyde')
                ---------------------------------------------------------------------------
                
                -----------pressione tasto E-----------------------------------------------
                if IsControlJustPressed(0, Keys['E']) then 

                -----------locali di controllo xpoint-------------------------------------------------
                local hasBagd7 = false
                local s1d7 = false
                
				---------controllo se ho i punti xp---------------------------------------------------
               
                         --controllo se ho l'item
                                        CashoutCore.Functions.TriggerCallback('CashoutCore:HasItem', function(result2)
                                        hasBagd7 = result2
                                        s1d7 = true
                                        end, 'empty_weed_bag')
                                        while(not s1d7) do
                                        Citizen.Wait(100)
                                        end
                                        
                                                  ----se ho l'item eseguo
                                                    if (hasBagd7) then
                                                          -----------eseguo----
                                                          procOn()
                                  
                                                    else
                                                      CashoutCore.Functions.Notify('you don\'t have empty_weed_bag', 'error')
                                                    end
                      
                        
                   
                    ----------------fine progress Bar-----------------------------------------------------------------------------

                end	
                -----------------------------------------------fine pressione tasto-----------------------------------------------
               
            end
            -----------------------------------------------fine controllo se sono in  macchina---------------------------------------
		
		end	
        ---------------------------------------------------fine ingresso marker 1-------------------------------------------------------

    end
    -------fine while-------------------------------------------------------------------------------------------------
end)



-------------------------------------------animazione più craft-----------------------------------------------------
function procOn()
    -- local
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local inventory = CashoutCore.Functions.GetPlayerData().inventory
    local count = 0
    ----
    if(count == 0) then
    CashoutCore.Functions.Progressbar("search_register", "Pikup sodium hydroxide", 20000, false, true, {disableMovement = true,
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
         Citizen.Wait(20000)
         LoadDict('amb@medic@standing@tendtodead@exit')
         TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
         ClearPedTasks(GetPlayerPed(-1))
         DeleteEntity(prop)
         TriggerServerEvent('craft:sodium')
    else
    
    
    end
end

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end
----------------------------------------------------------------END CRAFT TEST1--------------------------------------------------------------------


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