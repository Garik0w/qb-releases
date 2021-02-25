-----CODERC-SLO----------
------truckRobbery------

CashoutCore = nil
TriggerEvent('CashoutCore:GetObject', function(obj) CashoutCore = obj end)

local moneytruck = false



function CountCops()
    local _source = source
    local xPlayers = CashoutCore.Functions.GetPlayer(_source)
	
    
	CopsConnected = 0
    for k, v in pairs(CashoutCore.Functions.GetPlayers()) do
        local Player = CashoutCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                CopsConnected = CopsConnected + 1
            end
        end
    end
   
    SetTimeout(120 * 1000 , CountCops)
end



CountCops()

RegisterNetEvent('RS7x:Itemcheck')
AddEventHandler('RS7x:Itemcheck', function(amount)


    local xPlayer = CashoutCore.Functions.GetPlayer(source)
    local isRobbing = true
    local item = xPlayer.Functions.GetItemByName(Config.Item)


if not moneytruck then
    if isRobbing and item.amount > 0 and amount > 0 then
        CountCops()
        if CopsConnected >= Config.Copsneeded then
            moneytruck = true
            --xPlayer.removeInventoryItem("Config.Item", 1)  // uncomment if you want to remove the item on start //
            TriggerClientEvent('RS7x:startHacking',source,true)
            TriggerClientEvent('animation:hack', source)
        else
            isRobbing = false
            
            TriggerClientEvent('CashoutCore:Notify', source, 'Not Enough Police: ', "success")  
            
         end
    else
        isRobbing = false
       
        TriggerClientEvent('CashoutCore:Notify', source, 'You dont have the right tools for this', "success")  
    end
else
    
    TriggerClientEvent('CashoutCore:Notify', source, 'Someone is robbing moneytruck', "success")  
end    
end)

CashoutCore.Functions.CreateUseableItem("hak_kit", function(source, item)
    local Player = CashoutCore.Functions.GetPlayer(source)
	--if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('np-truckrobbery:rob', source)
   -- end
end)


RegisterNetEvent('RS7x:NotifyPolice')
AddEventHandler('RS7x:NotifyPolice', function(street1, street2, pos)
    local xPlayers = CashoutCore.Functions.GetPlayer(source)
    local isRobbing = true

    if isRobbing == true then
		for i=1, #xPlayers, 1 do
			local xPlayer = GetPlayerFromId(xPlayers[i])
            if xPlayer.job.name == 'police' then
                TriggerClientEvent('RS7x:Blip', xPlayers[i], pos.x, pos.y, pos.z)
                TriggerClientEvent('RS7x:NotifyPolice', xPlayers[i], 'Robbery In Progress : Security Truck | ' .. street1 .. " | " .. street2 .. ' ')
			end
		end
	end
end)

RobbedPlates = {}

RegisterNetEvent('RS7x:UpdatePlates')
AddEventHandler('RS7x:UpdatePlates', function(UpdatedTable, Plate)
    local xPlayers = CashoutCore.Functions.GetPlayer(source)
    RobbedPlates = UpdatedTable
    for i=1, #xPlayers, 1 do
        local xPlayer = CashoutCore.Functions.GetPlayer(xPlayers[i])
        if xPlayer ~= nil then
            UpdatedTable[Plate] = true
            TriggerClientEvent('RS7x:newTable', xPlayers[i], UpdatedTable)
        end
    end
    print('Updated Plates To server')
end)

------------------------NOT USE----------------------
--[[
function RandomItem()
	return Config.Items[math.random(#Config.Items)]
end

function RandomNumber()
	return math.random(1,10)
end
]]--
-----------------------------------------------------

---------------------------------------------------PAGAMENTO RAPINA FURGONE------------------------------------------------------------------------------------------
RegisterNetEvent('RS7x:Payout')
AddEventHandler('RS7x:Payout', function()
    local src = source
    local xPlayer = CashoutCore.Functions.GetPlayer(src)
    local Robbing = false
    local timer = 0
    local itemrob = Config.Items
    local blakmo = Config.ItemBlak
    Robbing = true

    while Robbing == true do
        timer = timer + 3.5
        Citizen.Wait(3500)  --// Delay between receiving Items/Cash might need to play around with this if you decide to change the default timer (Config.Timer)
        if math.random(1,100) <= 50 then
            local mon = math.random(300,2500)
           
            if Config.BlackMoney == false then
            xPlayer.Functions.AddMoney("cash", mon, "sold-pawn-items")
            TriggerClientEvent('CashoutCore:Notify', src, 'You found money: '..mon..'', "success")  
            else
            xPlayer.Functions.AddItem(blakmo, mon)
            TriggerClientEvent("inventory:client:ItemBox", src, CashoutCore.Shared.Items[blakmo], "add")
            TriggerClientEvent('CashoutCore:Notify', src, 'You found dirty money: '..mon..'', "success")  
            end

        else
            local ilosc = math.random(1,10)
            xPlayer.Functions.AddItem(itemrob, ilosc)
          ----------------------------------------

          TriggerClientEvent("inventory:client:ItemBox", src, CashoutCore.Shared.Items[itemrob], "add")
          TriggerClientEvent('CashoutCore:Notify', src, 'you found some gold bars: '..ilosc..'', "success")  
        end
        if timer >= Config.Timer then
            Robbing = false
            break
            TriggerClientEvent('np-truckrobbery:unfreeze', src)
        end
    end
end)
--------------------------------------------------------------------END PAGAMENTO RAPINA FURGONE----------------------------------------------------------------------------


RegisterNetEvent('RS7x:moneytruck_false')
AddEventHandler('RS7x:moneytruck_false', function()
    if moneytruck then
        moneytruck = false
    end
end)


-----RITIRA CAMMION LAVORO----------------------------------------

---------PARKING CAR--------------------------------------
RegisterServerEvent('cash-trukrob:server:truck')
AddEventHandler('cash-trukrob:server:truck', function(boatModel, BerthId)
    local src = source
    local Player = CashoutCore.Functions.GetPlayer(src)
    local plate = "BANK"..math.random(1111, 9999)
    
	TriggerClientEvent('cash-trurob:Auto', src, boatModel, plate)
end)



---------------------------CONSEGNA AUTO------------------------------------------------------