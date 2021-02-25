--------------------CODERC-SLO------------------------------
--------------######WOODCUTTER########----------------------
CashoutCore = nil
TriggerEvent('CashoutCore:GetObject', function(obj) CashoutCore = obj end)

--give wood cut
RegisterServerEvent('wood:getItem')
AddEventHandler('wood:getItem', function()
	local xPlayer, randomItem = CashoutCore.Functions.GetPlayer(source), Config.Items[math.random(1, #Config.Items)]
	
	if math.random(0, 100) <= Config.ChanceToGetItem then
		local Item = xPlayer.Functions.GetItemByName('wood_cut')
		if Item == nil then
			xPlayer.Functions.AddItem(randomItem, 1)
			TriggerClientEvent("inventory:client:ItemBox", source, CashoutCore.Shared.Items[randomItem], "add")
		else	
		if Item.amount < 20 then
        --xPlayer.addInventoryItem(randomItem, 1)
		xPlayer.Functions.AddItem(randomItem, 1)
		TriggerClientEvent("inventory:client:ItemBox", source, CashoutCore.Shared.Items[randomItem], "add")
		else
			TriggerClientEvent('CashoutCore:Notify', source, 'full inventory loaded into the truck', "error")  
		end
	    end
    end
end)
--------------------process
RegisterServerEvent('wood_weed:processweed2')
AddEventHandler('wood_weed:processweed2', function()
	local src = source
	local Player = CashoutCore.Functions.GetPlayer(src)

	if Player.Functions.GetItemByName('wood_cut') then
		local chance = math.random(1, 8)
		if chance == 1 or chance == 2 or chance == 3 or chance == 4 or chance == 5 or chance == 6 or chance == 7 or chance == 8 then
			Player.Functions.RemoveItem('wood_cut', 1)----change this
			Player.Functions.AddItem('wood_proc', 1)-----change this
			TriggerClientEvent("inventory:client:ItemBox", source, CashoutCore.Shared.Items['wood_cut'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, CashoutCore.Shared.Items['wood_proc'], "add")
			TriggerClientEvent('CashoutCore:Notify', src, 'Wood cut Processed successfully', "success")  
		else
			
		end 
	else
		TriggerClientEvent('CashoutCore:Notify', src, 'You don\'t have the right items wood_cut', "error") 
	end
end)


--------------sell wood process
RegisterServerEvent('wood:sell')
AddEventHandler('wood:sell', function()

    local xPlayer = CashoutCore.Functions.GetPlayer(source)
	local Item = xPlayer.Functions.GetItemByName('wood_proc')
   
	
	if Item == nil then
       TriggerClientEvent('CashoutCore:Notify', source, 'wood_proc', "error")  
	else
	 for k, v in pairs(Config.Prices) do
        
		
		if Item.amount > 0 then
			--for i = 1, Item.amount do
            local reward = 0
            for i = 1, Item.amount do
                reward = reward + math.random(v[1], v[2])
            end
			xPlayer.Functions.RemoveItem('wood_proc', 1)----change this
			TriggerClientEvent("inventory:client:ItemBox", source, CashoutCore.Shared.Items['wood_proc'], "remove")
			xPlayer.Functions.AddMoney("cash", reward, "sold-pawn-items")
			TriggerClientEvent('CashoutCore:Notify', source, 'you sold', "success")  
			--end
        end
		
		
     end
	end
	
		
	
end)

-----RITIRA CAMMION LAVORO----------------------------------------
local prezzo = 10
---------PARKING CAR--------------------------------------
RegisterServerEvent('cash-jobwood:server:truck')
AddEventHandler('cash-jobwood:server:truck', function(boatModel, BerthId)
    local src = source
    local Player = CashoutCore.Functions.GetPlayer(src)
    local plate = "WOOD"..math.random(1111, 9999)
    
	TriggerClientEvent('cash-jobwood:Auto', src, boatModel, plate)
end)

--[[
--------------scrivo punti
RegisterServerEvent('setpoint:server:point')
AddEventHandler('setpoint:server:point', function(xpointt)
    local src = source
	local Player = CashoutCore.Functions.GetPlayer(src)
	    
     CashoutCore.Functions.ExecuteSql(false, "UPDATE `players` SET `xpoint` = '"..xpointt.."' WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'")
        
end)

-----leggo punti
CashoutCore.Functions.CreateCallback('leggo:server:xpoi', function(source, cb, dock)
    local src = source
    local Player = CashoutCore.Functions.GetPlayer(src)

    CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(result)
        if result[1] ~= nil then
            cb(result)
        else
            cb(nil)
        end
    end)
end)
]]--
