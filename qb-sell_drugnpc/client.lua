----------CODERC-SLO----------
--#######SELL-DRUG-NPC######--

CashoutCore = nil 
local myJob      = nil
local selling    = false
local has        = false
local copsc      = false
local showOutlaw = true 
local timer      = 30 
local DrugAlert  = true 
local blipDrugTime = 30 
local timer = 1 
local timing = timer * 60000 
local PlayerData = {}

Citizen.CreateThread(function()
  while CashoutCore == nil do
      TriggerEvent('CashoutCore:GetObject', function(obj) CashoutCore = obj end)
      Citizen.Wait(200)
  end

while CashoutCore.Functions.GetPlayerData().job == nil do
  Citizen.Wait(10)
end
  PlayerData = CashoutCore.Functions.GetPlayerData()
  --startpoint()
end)

--------------------------------------------onload player----------------------------
RegisterNetEvent('CashoutCore:Client:OnPlayerLoaded')
AddEventHandler('CashoutCore:Client:OnPlayerLoaded', function()
  CashoutCore.Functions.GetPlayerData(function(PlayerData)
      PlayerJob = PlayerData.job
      PlayerData = CashoutCore.Functions.GetPlayerData()
  end)
 -- startpoint()
end)
-------------------------------------------setjob-------------------------------------
RegisterNetEvent('CashoutCore:Client:OnJobUpdate')
AddEventHandler('CashoutCore:Client:OnJobUpdate', function(JobInfo)

  PlayerData.job = JobInfo
 
end)
--------------------------------------------------------------------------------------

GetPlayerName()
RegisterNetEvent('outlawNotify2')
AddEventHandler('outlawNotify2', function(alert)
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
      Notify2(alert)
    end
end)

function Notify2(text)
  --ESX.ShowAdvancedNotification("911 Dispatch", "Alert", text, "CHAR_CALL911", 2)
  CashoutCore.Functions.Notify('911 Dispatch '..text..'', "error", 7000)
end

RegisterNetEvent('outlawNotifyc')
AddEventHandler('outlawNotifyc', function(dodrugs)
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
	local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
	
	
	--activate this function if you want a text message to the police
	--enter the function to send the message to the police
	--********************************************************
	
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		TriggerServerEvent('drugInProgressPos', plyPos.x, plyPos.y, plyPos.z)
	end
end)

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(1)
        if DecorGetInt(GetPlayerPed(-1), "IsOutlaw") == 2 then
            Wait( math.ceil(timing) )
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 1)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if NetworkIsSessionStarted() then
            DecorRegister("IsOutlaw",  3)
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 1)
            return
        end
    end
end)

RegisterNetEvent('drugPlace')
AddEventHandler('drugPlace', function(tx, ty, tz)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		if DrugAlert then
			local transT = 250
			local drugBlip = AddBlipForCoord(tx, ty, tz)
			SetBlipSprite(drugBlip,  10)
			SetBlipColour(drugBlip,  1)
			SetBlipAlpha(drugBlip,  transT)
			SetBlipAsShortRange(drugBlip,  1)
			while transT ~= 0 do
				Wait(blipDrugTime * 4)
				transT = transT - 1
				SetBlipAlpha(drugBlip,  transT)
				if transT == 0 then
					SetBlipSprite(drugBlip,  2)
					return
				end
			end
		end
	end
end)


currentped = nil
Citizen.CreateThread(function()

while true do
  Citizen.Wait(1)
  local player = GetPlayerPed(-1)
  local playerloc = GetEntityCoords(player, 0)
  local handle, ped = FindFirstPed()
  repeat
    success, ped = FindNextPed(handle)
    local pos = GetEntityCoords(ped)
    local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
    if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
      if DoesEntityExist(ped)then
        if IsPedDeadOrDying(ped) == false then
          if IsPedInAnyVehicle(ped) == false then
            local pedType = GetPedType(ped)
            if pedType ~= 28 and IsPedAPlayer(ped) == false then
              currentped = pos
              if distance <= 2 and ped  ~= GetPlayerPed(-1) and ped ~= oldped then
                --controllo
                TriggerServerEvent('checkD')
                if has == true then
                  drawTxt(0.90, 1.40, 1.0,1.0,0.4, "Pres ~g~E ~w~to sell drugs", 255, 255, 255, 255)
                  if IsControlJustPressed(1, 86) then
		                  oldped = ped
		                  SetEntityAsMissionEntity(ped)
		                  TaskStandStill(ped, 9.0)
		                  pos1 = GetEntityCoords(ped)
		                  TriggerServerEvent('drugs:trigger')
		                  Citizen.Wait(2850)
		                  TriggerEvent('sell')
		                 
                  end
                end
              end
            end
          end
        end
      end
    end
  until not success
  EndFindPed(handle)
end
end)

RegisterNetEvent('sell')
AddEventHandler('sell', function()
    local player = GetPlayerPed(-1)
    local playerloc = GetEntityCoords(player, 0)
    local distance = GetDistanceBetweenCoords(pos1.x, pos1.y, pos1.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    if distance <= 2 then
      TriggerServerEvent('drugs:sell')
    elseif distance > 2 then
      TriggerServerEvent('sell_dis')
    end
end)


RegisterNetEvent('checkR')
AddEventHandler('checkR', function(test)
  has = test
end)


RegisterNetEvent('animation')
AddEventHandler('animation', function()
  local pid = PlayerPedId()
  RequestAnimDict("amb@prop_human_bum_bin@idle_b")
  while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end
    TaskPlayAnim(pid,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    Wait(750)
    StopAnimTask(pid, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
      SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
