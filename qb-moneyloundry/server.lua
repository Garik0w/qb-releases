-------------------------------------
------- Created by CODERC-SLO -------
-----------Money Loundry---------------
------------------------------------- 
local CoolDownTimerATM = {}
CashoutCore = nil
TriggerEvent('CashoutCore:GetObject', function(obj) CashoutCore = obj end)
---######################################################---


---------------------------------------------PROCESS MONEY CLEANING-----------------------
local itname1 = 'black_money'
RegisterServerEvent('pulisci:moneblak')
AddEventHandler('pulisci:moneblak', function()
   
    local _source = source
    local xPlayer = CashoutCore.Functions.GetPlayer(_source)
    local Item = xPlayer.Functions.GetItemByName(itname1)
    
   
    if Item == nil then
        TriggerClientEvent('CashoutCore:Notify', source, 'You have no dirty money!', "error", 8000)  
    else
        if Item.amount >= Item.amount then

           ----------------elimino dal mio inventario---------------------------------------------------------
           xPlayer.Functions.RemoveItem(itname1, Item.amount)
           TriggerClientEvent("inventory:client:ItemBox", source, CashoutCore.Shared.Items[itname1], "remove")
		   xPlayer.Functions.AddMoney("cash", Item.amount, "sold-pawn-items")
       
           
        else
            TriggerClientEvent('CashoutCore:Notify', _source, 'You have no dirty money!', "error", 10000)  
           
        end
    end

end)
---------------------------------clean end---------------------------------------------------------------