
CashoutCore = nil
local PlayerGang = {}
IsLoggedIn = false
local count = 0
local dude = false

Keys = {
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

Citizen.CreateThread(function()
   -- while true do
   --     Citizen.Wait(10)
   --     if CashoutCore == nil then
    --        TriggerEvent('CashoutCore:GetObject', function(obj) CashoutCore = obj end)
    --        Citizen.Wait(200)
    --    end
    --end
    while CashoutCore == nil do
        TriggerEvent('CashoutCore:GetObject', function(obj) CashoutCore = obj end)
        Citizen.Wait(200)
    end
	
	while CashoutCore.Functions.GetPlayerData().gang == nil do
		Citizen.Wait(10)
    end
    PlayerGang = CashoutCore.Functions.GetPlayerData().gang
end)

local isInMenu = false

Citizen.CreateThread(function()
    while true do
    if dude then
    --QBCore.Functions.Notify('OK', 'success', 35000)
    Citizen.Wait(30000)

        count = "false"
        dude = false
    --QBCore.Functions.Notify('synchronization Character', 'success', 5000)

    end
    Citizen.Wait(1000)

    end


end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
        IsLoggedIn = true
        Citizen.Wait(1000)
        PlayerGang = CashoutCore.Functions.GetPlayerData().gang
	end
end)

RegisterNetEvent("coderc:reload")
AddEventHandler("coderc:reload", function()
    count = "true"
    dude = true
    loadt()
end)

RegisterNetEvent('CashoutCore:Client:OnPlayerLoaded')
AddEventHandler('CashoutCore:Client:OnPlayerLoaded', function()
    IsLoggedIn = true
   -- PlayerGang = CashoutCore.Functions.GetPlayerData().gang
   PlayerGang = PlayerGang.gang
   PlayerGang = CashoutCore.Functions.GetPlayerData().gang
end)
--RegisterNetEvent('CashoutCore:Client:OnJobUpdate')
--AddEventHandler('CashoutCore:Client:OnJobUpdate', function(GangInfo)
--    PlayerGang = GangInfo
--end)
RegisterNetEvent('CashoutCore:Client:OnGangUpdate')
AddEventHandler('CashoutCore:Client:OnGangUpdate', function(GangInfo)
    PlayerGang = GangInfo
end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 20, 0, 0, 75)
    ClearDrawOrigin()
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsLoggedIn then
            if PlayerGang.name ~= nil then
                local pos = GetEntityCoords(GetPlayerPed(-1))
                for k, v in pairs(CashoutCore.Shared.Gangs[PlayerGang.name]["boss"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                        if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.0) then
                            DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Gang Menu")
                            DrawMarker(25, v.x, v.y, v.z-0.96, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 200, 0, 0, 0, 0)
                            if IsControlJustReleased(0, Keys["E"]) then
                                TriggerServerEvent("cash_gangmenu:server:openMenu")
                                
                            end
                        elseif (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                            DrawText3D(v.x, v.y, v.z, "Gang Menu")
                            DrawMarker(25, v.x, v.y, v.z-0.96, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 200, 0, 0, 0, 0)
                             end
                         end
                    end
             else
            Citizen.Wait(7500)
            end
        end
    end
end)




RegisterNetEvent('cash_gangmenu:client:openMenu')
AddEventHandler('cash_gangmenu:client:openMenu', function(employees, gangdata)
    local employeesHTML, gradesHTML, recruitHTML = '', '', ''
    local PlayerGang = CashoutCore.Functions.GetPlayerData().gang

    for _, player in pairs(employees) do
        if player.name then
            if player.grade ~= nil and player.grade.name then
                if player.isboss == true then
                    employeesHTML = employeesHTML .. [[<div class='player-box box-shadow option-enabled' id="player-]] .. player.source  .. [["><span id='option-text'>]] .. player.name .. ' [' .. player.grade.name .. [[]</span></div>]]
                else
                    employeesHTML = employeesHTML .. [[<div class='player-box box-shadow' id="player-]] .. player.source  .. [["><span class='hoster-options' id="playeroptions-]] .. player.source  .. [["><span style="position: relative; top: 15%; margin-left: 27%;"><i id="player-]] .. player.source  .. [[" class="fas fa-angle-double-up gradeschange"></i>  <i id="player-]] .. player.source  .. [[" class="fas fa-user-slash fireemployee"></i></span></span><span id='option-text'>]] .. player.name .. ' [' .. player.grade.name .. [[]</span></div>]]
                end
            end
        end
    end

    local max = 0
    for k, v in pairs(gangdata.grades) do
        if tonumber(k) then
            if tonumber(k) > max then
                max = tonumber(k)
            end
        end
    end

    for level = 0, max do
        local grade = gangdata.grades[tostring(level)]
        if grade.isboss then
            gradesHTML = gradesHTML .. [[<div class='grade-box box-shadow option-enabled' id="grade-]] .. tostring(level) .. [["><span id='option-text'>]] .. grade.name .. [[</span></div>]]
        else
            gradesHTML = gradesHTML .. [[<div class='grade-box box-shadow' id="grade-]] .. tostring(level) .. [["><span id='option-text'>]] .. grade.name .. [[</span></div>]]
        end
    end

    isInMenu = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        open = true,
        class = 'open',
        employees = employeesHTML,
        grades = gradesHTML,
    })
end)

RegisterNetEvent('cash_gangmenu:client:refreshPage')
AddEventHandler('cash_gangmenu:client:refreshPage', function(data, list)
    if data == 'employee' then
        local employeesHTML = ''
        for _, player in pairs(list) do
            if player.name and player.grade ~= nil and player.grade.name then
                if player.isboss == true then
                    employeesHTML = employeesHTML .. [[<div class='player-box box-shadow option-enabled' id="player-]] .. player.source  .. [["><span id='option-text'>]] .. player.name .. ' [' .. player.grade.name .. [[]</span></div>]]
                else
                    employeesHTML = employeesHTML .. [[<div class='player-box box-shadow' id="player-]] .. player.source  .. [["><span class='hoster-options' id="playeroptions-]] .. player.source  .. [["><span style="position: relative; top: 15%; margin-left: 27%;"><i id="player-]] .. player.source  .. [[" class="fas fa-angle-double-up gradeschange"></i>  <i id="player-]] .. player.source  .. [[" class="fas fa-user-slash fireemployee"></i></span></span><span id='option-text'>]] .. player.name .. ' [' .. player.grade.name .. [[]</span></div>]]
                end
            end
        end
        
        isInMenu = true
        SendNUIMessage({
            open = true,
            class = 'refresh-players',
            employees = employeesHTML,
        })
    elseif data == 'recruits' then
        local recruitsHTML = ''

        if #list > 0 then
            for _, player in pairs(list) do
                recruitsHTML = recruitsHTML .. [[<div class='player-box box-shadow' id="player-]] .. player.source  .. [["><span class='hoster-options' id="playeroptions-]] .. player.source  .. [["><span style="position: relative; top: 15%; margin-left: 27%;"><i id="player-]] .. player.source  .. [[" class="fas fa-user-tag givejob"></i></span></span><span id='option-text'>]] .. player.name .. '</span></div>'
            end
        else
            recruitsHTML = [[<div class='player-box box-shadow option-enabled'><span class='hoster-options'"><span style="position: relative; top: 15%; margin-left: 27%;"></span></span><span id='option-text'>There is no players nearby.</span></div>]]
        end
        
        isInMenu = true
        SendNUIMessage({
            open = true,
            class = 'refresh-recruits',
            recruits = recruitsHTML,
        })
    end
end)

RegisterNetEvent('cash_gangmenu:client:refreshSociety')
AddEventHandler('cash_gangmenu:client:refreshSociety', function(gang, data)
    if CashoutCore and CashoutCore.Functions.GetPlayerData().gang.name == gang then
        SendNUIMessage({
            open = true,
            class = 'refresh-society',
            amount = data,
         })
    end
end)

RegisterNUICallback('openStash', function(data)
    isInMenu = false
    SendNUIMessage({open = false})
    SetNuiFocus(false, false)
    
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss_" .. CashoutCore.Functions.GetPlayerData().gang.name, {
        maxweight = 4000000,
        slots = 500,
    })

    TriggerEvent("inventory:client:SetCurrentStash", "boss_" .. CashoutCore.Functions.GetPlayerData().gang.name)
end)

RegisterNUICallback('outfitg', function(data)
    isInMenu = false
    SendNUIMessage({open = false})
    SetNuiFocus(false, false)
   
    TriggerEvent('cash-clothes:client:openOutfitMenu')
    
end)

RegisterNUICallback('giveJob', function(data)
    TriggerServerEvent('cash_gangmenu:server:giveJob', data)
end)

RegisterNUICallback('openRecruit', function(data)
    CreateThread(function()
        local playerPed = PlayerPedId()
        local players = { GetPlayerServerId(PlayerId()) }
        for k,v in pairs(CashoutCore.Functions.GetPlayersFromCoords(GetEntityCoords(playerPed), 10.0)) do
            if v and v ~= PlayerId() then
                table.insert(players, GetPlayerServerId(v))
            end
        end

        TriggerServerEvent("cash_gangmenu:server:updateNearbys", players)
    end)
end)

RegisterNUICallback('changeGrade', function(data)
    TriggerServerEvent('cash_gangmenu:server:updateGrade', data)
end)

RegisterNUICallback('fireEmployee', function(data)
    TriggerServerEvent('cash_gangmenu:server:fireEmployee', data)
end)

RegisterNUICallback('closeNUI', function()
    isInMenu = false
    SetNuiFocus(false, false)
end)

RegisterNUICallback('withdraw', function(data)
    local amount = tonumber(data.amount)
    TriggerServerEvent("cash_gangmenu:server:withdrawMoney", amount)
end)

RegisterNUICallback('deposit', function(data)
    local amount = tonumber(data.amount)
    TriggerServerEvent("cash_gangmenu:server:depositMoney", amount)
end)

RegisterCommand('closeboss', function()
    isInMenu = false
    SendNUIMessage({
        open = false,
    })
    SetNuiFocus(false, false)
end)

function tprint (t, s)
    for k, v in pairs(t) do
        local kfmt = '["' .. tostring(k) ..'"]'
        if type(k) ~= 'string' then
            kfmt = '[' .. k .. ']'
        end
        local vfmt = '"'.. tostring(v) ..'"'
        if type(v) == 'table' then
            tprint(v, (s or '')..kfmt)
        else
            if type(v) ~= 'string' then
                vfmt = tostring(v)
            end
            print(type(t)..(s or '')..kfmt..' = '..vfmt)
        end
    end
end 

