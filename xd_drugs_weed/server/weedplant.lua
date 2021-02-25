CashoutCore = nil
local itemcraft = 'black_money'
TriggerEvent('CashoutCore:GetObject', function(obj) CashoutCore = obj end)

RegisterServerEvent('xd_drugs_weed:pickedUpCannabis') --hero
AddEventHandler('xd_drugs_weed:pickedUpCannabis', function()
	local src = source
	local Player = CashoutCore.Functions.GetPlayer(src)

	    if 	TriggerClientEvent("CashoutCore:Notify", src, "Picked up some Cannabis!!", "Success", 8000) then
		  Player.Functions.AddItem('cannabis', 1) ---- change this shit 
		  TriggerClientEvent("inventory:client:ItemBox", source, CashoutCore.Shared.Items['cannabis'], "add")
	    end
end)

RegisterServerEvent('xd_drugs_weed:processweed')
AddEventHandler('xd_drugs_weed:processweed', function()
	local src = source
	local Player = CashoutCore.Functions.GetPlayer(src)

	if Player.Functions.GetItemByName('cannabis') and Player.Functions.GetItemByName('empty_weed_bag') then
		local chance = math.random(1, 10)
		if chance == 1 or chance == 2 or chance == 9 or chance == 4 or chance == 10 or chance == 6 or chance == 7 or chance == 8 then
			Player.Functions.RemoveItem('cannabis', 1)----change this
			Player.Functions.RemoveItem('empty_weed_bag', 1)----change this
			Player.Functions.AddItem('weed_bag', 1)-----change this
			TriggerClientEvent("inventory:client:ItemBox", source, CashoutCore.Shared.Items['cannabis'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, CashoutCore.Shared.Items['empty_weed_bag'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, CashoutCore.Shared.Items['weed_bag'], "add")
			TriggerClientEvent('CashoutCore:Notify', src, 'Cannabis Processed successfully', "success")  
		else
			Player.Functions.RemoveItem('cannabis', 1)----change this
			Player.Functions.RemoveItem('empty_weed_bag', 1)----change this
			TriggerClientEvent("inventory:client:ItemBox", source, CashoutCore.Shared.Items['cannabis'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, CashoutCore.Shared.Items['empty_weed_bag'], "remove")
			TriggerClientEvent('CashoutCore:Notify', src, 'You messed up and got nothing', "error") 
		end 
	else
		TriggerClientEvent('CashoutCore:Notify', src, 'You don\'t have the right items', "error") 
	end
end)

--selldrug ok

RegisterServerEvent('xd_drugs_weed:selld')
AddEventHandler('xd_drugs_weed:selld', function()
	local src = source
	local Player = CashoutCore.Functions.GetPlayer(src)
	local Item = Player.Functions.GetItemByName('weed_bag')
   
	
      
	
	if Item.amount >= 1 then
	if Player.Functions.GetItemByName('weed_bag') then
		local chance2 = math.random(1, 8)
		if chance2 == 1 or chance2 == 2 or chance2 == 9 or chance2 == 4 or chance2 == 10 or chance2 == 6 or chance2 == 7 or chance2 == 8 then
			Player.Functions.RemoveItem('weed_bag', 1)----change this
			TriggerClientEvent("inventory:client:ItemBox", source, CashoutCore.Shared.Items['weed_bag'], "remove")
			Player.Functions.AddMoney("cash", Config.Pricesell, "sold-pawn-items")
			TriggerClientEvent('CashoutCore:Notify', src, 'you sold to the pusher', "success")  
			--Player.Functions.AddItem(itemcraft, Config.Pricesell)
			--TriggerClientEvent("inventory:client:ItemBox", src, CashoutCore.Shared.Items[itemcraft], "add")

		else
			--Player.Functions.RemoveItem('cannabis', 1)----change this
			--Player.Functions.RemoveItem('empty_weed_bag', 1)----change this
			--TriggerClientEvent("inventory:client:ItemBox", source, CashoutCore.Shared.Items['cannabis'], "remove")
			--TriggerClientEvent("inventory:client:ItemBox", source, CashoutCore.Shared.Items['empty_weed_bag'], "remove")
			--TriggerClientEvent('CashoutCore:Notify', src, 'You messed up and got nothing', "error") 
		end 
	else
		TriggerClientEvent('CashoutCore:Notify', src, 'You don\'t have the right items', "error") 
	end
else
	TriggerClientEvent('CashoutCore:Notify', src, 'You don\'t have the right items', "error") 
	
end
end)



function CancelProcessing(playerId)
	if playersProcessingCannabis[playerId] then
		ClearTimeout(playersProcessingCannabis[playerId])
		playersProcessingCannabis[playerId] = nil
	end
end

RegisterServerEvent('xd_drugs_weed:cancelProcessing')
AddEventHandler('xd_drugs_weed:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('CashoutCore_:playerDropped', function(playerId, reason)
	CancelProcessing(playerId)
end)

RegisterServerEvent('xd_drugs_weed:onPlayerDeath')
AddEventHandler('xd_drugs_weed:onPlayerDeath', function(data)
	local src = source
	CancelProcessing(src)
end)

CashoutCore.Functions.CreateCallback('poppy:process', function(source, cb)
	local src = source
	local Player = CashoutCore.Functions.GetPlayer(src)
	 
	if Player.PlayerData.item ~= nil and next(Player.PlayerData.items) ~= nil then
		for k, v in pairs(Player.PlayerData.items) do
		    if Player.Playerdata.items[k] ~= nil then
				if Player.Playerdata.items[k].name == "cannabis" then
					cb(true)
			    else
					TriggerClientEvent("CashoutCore:Notify", src, "You do not have any Cannabis", "error", 10000)
					cb(false)
				end
	        end
		end	
	end
end)
