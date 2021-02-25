---------SYSTEM SELL ITEM CODERC-SLO--------------
-----------###---10-12-2020---###-----------------

--------------------------------------LOCAL KEY------------------------------------------------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CashoutCore = nil 

local PlayerData = {}


------------------------------------------------CORE---------------------------------

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

----------------onload player--------------------------------------------------------
RegisterNetEvent('CashoutCore:Client:OnPlayerLoaded')
AddEventHandler('CashoutCore:Client:OnPlayerLoaded', function()
    CashoutCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        PlayerData = CashoutCore.Functions.GetPlayerData()
    end)
end)

-------------------setjob------------------------------------------------------------
RegisterNetEvent('CashoutCore:Client:OnJobUpdate')
AddEventHandler('CashoutCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)
-------------------------------------------------------------------------------------

--------------------------------------------------TEXT DRAW3D-----------------------------------------------------
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
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 10)
end
-----------------------------------------------------------------------------------------------------------------

-----------------------------------------------PROCESS CRAFT TEST1-----------------------------------------------
local conteggio2 = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.sell1X, Config.sell1Y, Config.sell1Z)
             
        local vehicled = GetVehiclePedIsIn(GetPlayerPed(-1), true)
		
        local playerPeds = PlayerPedId()

------------------------------------------------------MARKER------------------------------------------------------

		if dist <= 10.0 then
			DrawMarker(25, Config.sell1X, Config.sell1Y, Config.sell1Z-0.96, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 200, 0, 0, 0, 0)
            DrawMarker(20, Config.sell1X, Config.sell1Y, Config.sell1Z + 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.2, 0.2, 15, 255, 55, 255, true, false, false, true, false, false, false)
        end
        local hasBagd = false
        local s1d = false    
        -------------------#####################################################################################-----

        -------------------------------------------ingresso in marker 1----------------------------------------------
        if dist <= 3.0 then

            ---------------------------------------eseguo il controllo se sono in macchina---------------------------
		    if GetPedInVehicleSeat(vehicled, -1) == GetPlayerPed(-1) then
              
            else
                
                -------------creo il testo-------------------------------------------------
                DrawText3D2(Config.sell1X, Config.sell1Y, Config.sell1Z+0.1, Config.Text)
                ---------------------------------------------------------------------------
                
                if IsControlJustPressed(0, Keys['E']) then 
                    if PlayerData.job ~= nil and (PlayerData.job.name == 'police') then
                        procOn3()
                    else
                        CashoutCore.Functions.Notify('You don\'t have permission to sell', "error", 8000)
                    end
                end
               
            end
            		
		end	
        
    end
   
end)

---------------------------------------------------------FUNCTION-------------------------------------------------------------
function procOn3()
    -------------------local--------------------------------------------------------------------------------------------------
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local inventory = CashoutCore.Functions.GetPlayerData().inventory
    local count = 0
    --------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------
    if(count == 0) then
    CashoutCore.Functions.Progressbar("search_register", "Sell..", 10000, false, true, {disableMovement = true,
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
         Citizen.Wait(10000)
         LoadDict('amb@medic@standing@tendtodead@exit')
         TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
         ClearPedTasks(GetPlayerPed(-1))
         DeleteEntity(prop)
         TriggerServerEvent('sell:tiemall')
         ClearPedTasks(GetPlayerPed(-1))
         DeleteEntity(prop)
         conteggio2 = 0
    else
    -------------------------------------------------------------------------------------------------------------------
    ClearPedTasks(GetPlayerPed(-1))
    DeleteEntity(prop)
    conteggio2 = 0
    end
end
-------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------LOAD ANIM-----------------------------------------------------------
function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end
----------------------------------------------------END ANIM-------------------------------------------------------------

