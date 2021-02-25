CashoutCore = nil

TriggerEvent('CashoutCore:GetObject', function(obj) CashoutCore = obj end)

RegisterServerEvent("KickForAFK")
AddEventHandler("KickForAFK", function()
	DropPlayer(source, "You have been kicked because u were AFK.")
end)

CashoutCore.Functions.CreateCallback('cash-antiafk:server:GetPermissions', function(source, cb)
    local group = CashoutCore.Functions.GetPermission(source)
    cb(group)
end)