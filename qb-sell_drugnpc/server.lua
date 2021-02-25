----------CODERC-SLO----------
--#######SELL-DRUG-NPC######--

CashoutCore = nil
TriggerEvent('CashoutCore:GetObject', function(obj) CashoutCore = obj end)
---######################################################---
	local _source = source
	local xPlayer = CashoutCore.Functions.GetPlayer(source)
	local selling = false
	local success = false
	local copscalled = false
	local notintrested = false

  RegisterNetEvent('drugs:trigger')
  AddEventHandler('drugs:trigger', function()
	selling = true
	    if selling == true then
			TriggerEvent('pass_or_fail')
  			
			TriggerClientEvent('CashoutCore:Notify', source, 'trying to get the person to buy the product', "error",2000)  
 	end
end)

RegisterNetEvent('drugs:sell')
AddEventHandler('drugs:sell', function()
  local xPlayer = CashoutCore.Functions.GetPlayer(source)

	if xPlayer ~= nil then
	
		local lsd = xPlayer.Functions.GetItemByName('lsd')
		local coke = xPlayer.Functions.GetItemByName('bag_cocke')
		local weed = xPlayer.Functions.GetItemByName('weed_bag')
     	

	local paymentm = math.random (Config.LsdSellPrice, Config.LsdSellPrice)
	local paymentc = math.random (Config.CokeSellPrice, Config.CokeSellPrice)
	local paymentw = math.random (Config.WeedSellPrice, Config.WeedSellPrice)


	if coke == nil then
		
	else
		if coke.amount >= 1 and success == true then
				local sellamount = math.random(1,1)
				local bags = ""
				paymentc = paymentc * sellamount

				if(sellamount > 1) then
					bags = sellamount.." bag_cocke"
				else
					bags = "bag_cocke"
				end
			
				
				TriggerClientEvent("animation", source)
				
				xPlayer.Functions.RemoveItem('bag_cocke', sellamount)
			    TriggerClientEvent("inventory:client:ItemBox", source, CashoutCore.Shared.Items['bag_cocke'], "remove")
				
				  xPlayer.Functions.AddMoney("cash", paymentc, "sold-pawn-items")
			      TriggerClientEvent('CashoutCore:Notify', source, 'you sold', "success")  
  					selling = false
		
		elseif selling == true and success == false and notintrested == true then
					
					TriggerClientEvent('CashoutCore:Notify', source, 'I\'m not interested', "success", 5000)  
  				selling = false
  		
		elseif copscalled == true and success == false then
				TriggerClientEvent("outlawNotifyc", source)
				TriggerClientEvent("outlawNotify2", -1, "Drug deal suspect in the city, Alert Police")
				
  			selling = false
		end
		return
	end
	  
              ----------------------------------------
			if lsd == nil then
				
			else
				if lsd.amount >= 1 and success == true then
						local sellamount = math.random(1,1)
						local bags2 = ""
						paymentm = paymentm * sellamount
		
						if(sellamount > 1) then
							bags2 = sellamount.." lsd"
						else
							bags2 = "lsd"
						end
						
						
						TriggerClientEvent("animation", source)
						
						xPlayer.Functions.RemoveItem('lsd', sellamount)
						TriggerClientEvent("inventory:client:ItemBox", source, CashoutCore.Shared.Items['lsd'], "remove")
						
						  xPlayer.Functions.AddMoney("cash", paymentm, "sold-pawn-items")
						  TriggerClientEvent('CashoutCore:Notify', source, 'you sold', "success")  
							  selling = false
				
				elseif selling == true and success == false and notintrested == true then
							
							TriggerClientEvent('CashoutCore:Notify', source, 'I\'m not interested', "success", 5000)  
						  selling = false
				  
				elseif copscalled == true and success == false then
						TriggerClientEvent("outlawNotifyc", source)
						TriggerClientEvent("outlawNotify2", -1, "Drug deal suspect in the city, Alert Police")
						
					  selling = false
				end
				  ---------------
		
				  return  
			end
			-----------------------
			if weed == nil then
				
			else
				if weed.amount >= 1 and success == true then
						local sellamount = math.random(1,1)
						local bags3 = ""
						paymentw = paymentw * sellamount
		
						if(sellamount > 1) then
							bags3 = sellamount.." weed_bag"
						else
							bags3 = "weed_bag"
						end
						
						
						TriggerClientEvent("animation", source)
						
						xPlayer.Functions.RemoveItem('weed_bag', sellamount)
						TriggerClientEvent("inventory:client:ItemBox", source, CashoutCore.Shared.Items['weed_bag'], "remove")
						
						  xPlayer.Functions.AddMoney("cash", paymentw, "sold-pawn-items")
						  TriggerClientEvent('CashoutCore:Notify', source, 'you sold', "success")  
							  selling = false
				
				elseif selling == true and success == false and notintrested == true then
							
							TriggerClientEvent('CashoutCore:Notify', source, 'I\'m not interested', "success", 5000)  
						  selling = false
				  
				elseif copscalled == true and success == false then
						TriggerClientEvent("outlawNotifyc", source)
						TriggerClientEvent("outlawNotify2", -1, "Drug deal suspect in the city, Alert Police")
						
					  selling = false
				end
				  ---------------
				  return
				  
			end





    end
end)

RegisterNetEvent('pass_or_fail')
AddEventHandler('pass_or_fail', function()
	local percent = math.random(1, 11)
	if percent == 7 or percent == 8 or percent == 9 then
		success = false
		notintrested = true
	elseif percent ~= 8 and percent ~= 9 and percent ~= 10 and percent ~= 7 and percent ~= 3 then -- 6 , 5 , 4 , 2 , 1
		success = true
		notintrested = false
	else -- 10, 3
		notintrested = false
		success = false
		copscalled = true
	end
end)

RegisterNetEvent('sell_dis')
AddEventHandler('sell_dis', function()
	TriggerClientEvent('CashoutCore:Notify', source, 'You walked away', "error",2000)  
end)
--controllo se ho la droga da vendere
RegisterNetEvent('checkD')
AddEventHandler('checkD', function()
	local xPlayer = CashoutCore.Functions.GetPlayer(source)
	if xPlayer ~= nil then
		local lsd = xPlayer.Functions.GetItemByName('lsd')
		local coke = xPlayer.Functions.GetItemByName('bag_cocke')
		local weed = xPlayer.Functions.GetItemByName('weed_bag')
		
		if coke == nil then
		
			
		else
			
			if  coke.amount >= 1 then
			TriggerClientEvent("checkR", source, true)
			else
			TriggerClientEvent("checkR", source, false)
			end

		


		end

		if lsd == nil then
		
			
		else
			
			if  lsd.amount >= 1 then
			TriggerClientEvent("checkR", source, true)
			else
			TriggerClientEvent("checkR", source, false)
			end
		end

		if weed == nil then
		
			
		else
			
			if  weed.amount >= 1 then
			TriggerClientEvent("checkR", source, true)
			else
			TriggerClientEvent("checkR", source, false)
			end
		end
		------se non ho nessuna droga disattivo la vendita/scritta
		if lsd == nil and coke == nil and weed == nil then
			TriggerClientEvent("checkR", source, false)
		end
		
	end
end)

RegisterServerEvent('drugInProgressPos')
AddEventHandler('drugInProgressPos', function(tx, ty, tz)
	TriggerClientEvent('drugPlace', -1, tx, ty, tz)
end)
