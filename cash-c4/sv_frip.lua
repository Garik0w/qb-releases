--ESX = nil

--TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
CashoutCore = nil

TriggerEvent('CashoutCore:GetObject', function(obj) CashoutCore = obj end)


CashoutCore.Functions.CreateUseableItem("c4", function(source, item)
    local Player = CashoutCore.Functions.GetPlayer(source)
    TriggerClientEvent('FripeX:CheckIfRequirementsAreMet', source)
end)

RegisterServerEvent('FripeX:RemoveBombFromInv')
AddEventHandler('FripeX:RemoveBombFromInv', function()
    local xPlayer = CashoutCore.Functions.GetPlayer(source)
    local Item = xPlayer.Functions.GetItemByName('c4')
   
	if Item.amount > 1 then
       xPlayer.Functions.RemoveItem("c4", 1)
    end
	--if xPlayer.Functions.RemoveItem(Item.name, 1, Item.slot) then
      --  xPlayer.Functions.RemoveItem("c4", 1)
    --end
	
end)