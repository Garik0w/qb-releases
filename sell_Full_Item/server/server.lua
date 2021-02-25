------------------------------CODERC-SLO-----------------------------------
-----------------------------SELL SYSTEM-----------------------------------

-------------------------CORE----------------------------------------------
CashoutCore = nil
TriggerEvent('CashoutCore:GetObject', function(obj) CashoutCore = obj end)
---------------------------------------------------------------------------

-------------------------------------------------------------------------------SELL--------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('sell:tiemall')
AddEventHandler('sell:tiemall', function()
   
    local _source = source
    local xPlayer = CashoutCore.Functions.GetPlayer(_source)
    local Item1 = xPlayer.Functions.GetItemByName(Config.Item1)
    local Item2 = xPlayer.Functions.GetItemByName(Config.Item2)
    local Item3 = xPlayer.Functions.GetItemByName(Config.Item3)
    local Item4 = xPlayer.Functions.GetItemByName(Config.Item4)
	local Item5 = xPlayer.Functions.GetItemByName(Config.Item5)
    local Item6 = xPlayer.Functions.GetItemByName(Config.Item6)
    local Item7 = xPlayer.Functions.GetItemByName(Config.Item7)
    local Item8 = xPlayer.Functions.GetItemByName(Config.Item8)
	local Item9 = xPlayer.Functions.GetItemByName(Config.Item9)
    local Item10 = xPlayer.Functions.GetItemByName(Config.Item10)
    local Item11 = xPlayer.Functions.GetItemByName(Config.Item11)
	local Item12 = xPlayer.Functions.GetItemByName(Config.Item12)
    local Item13 = xPlayer.Functions.GetItemByName(Config.Item13)
    local Item14 = xPlayer.Functions.GetItemByName(Config.Item14)
    local Item15 = xPlayer.Functions.GetItemByName(Config.Item15)

   -------------------------------------------SELL1-----------------------------------------------------------------
    if Item1 == nil and Item2 == nil and Item3 == nil and Item4 == nil and Item5 == nil and Item6 == nil and Item7 == nil and Item8 == nil and Item9 == nil and Item10 == nil and Item11 == nil and Item12 == nil and Item13 == nil and Item14 == nil and Item15 == nil then
        TriggerClientEvent('CashoutCore:Notify', _source, 'No material to sell', "error", 10000)
    else

        if Item1 == nil then
	
        else
	
		-------------------------------------------SELL1-----------------------------------------------------------------
		   
            if Item1.amount >= 1 then
	
		        local price1 = tonumber(Config.Price1) * Item1.amount
		   
                 -----------------------elimino dal mio inventario---------------------------------------------------------
		   
                xPlayer.Functions.RemoveItem(Config.Item1, Item1.amount)
                TriggerClientEvent("inventory:client:ItemBox", _source, CashoutCore.Shared.Items[Config.Item1], "remove")
		   
                ----------------------------------------------------------------------------------------------------------
		   
		        -----------------------------------------------ADD MONEY--------------------------------------------------
           
		        xPlayer.Functions.AddMoney("cash", price1, "sold-pawn-items")
		        TriggerClientEvent('CashoutCore:Notify', _source, 'You have sold '..Item1.amount..' pieces '..Config.Item1..'', "success", 5000)  
			
		        ---------------------------------------------------------------------------------------------------------
		   
            else
		
            TriggerClientEvent('CashoutCore:Notify', _source, 'No material to sell', "error", 10000)  
           
            end
        
        
		
        end
        ------------------------------------------------------------------------------------------------------------------

        -------------------------------------------SELL2-----------------------------------------------------------------
        if Item2 == nil then
	
        else
	
		        -------------------------------------------SELL2-----------------------------------------------------------------
		   
            if Item2.amount >= 1 then
	
		        local price2 = tonumber(Config.Price2) * Item2.amount
		   
                -----------------------elimino dal mio inventario---------------------------------------------------------
		   
                xPlayer.Functions.RemoveItem(Config.Item2, Item2.amount)
                TriggerClientEvent("inventory:client:ItemBox", _source, CashoutCore.Shared.Items[Config.Item2], "remove")
		   
                ----------------------------------------------------------------------------------------------------------
		   
		        -----------------------------------------------ADD MONEY--------------------------------------------------
           
		        xPlayer.Functions.AddMoney("cash", price2, "sold-pawn-items")
		        TriggerClientEvent('CashoutCore:Notify', _source, 'You have sold '..Item2.amount..' pieces '..Config.Item2..'', "success", 5000)  
			
		        ---------------------------------------------------------------------------------------------------------
		   
            else
		
            TriggerClientEvent('CashoutCore:Notify', _source, 'No material to sell', "error", 10000)  
           
            end
        
        
		
        end
        ------------------------------------------------------------------------------------------------------------------

        -------------------------------------------SELL2-----------------------------------------------------------------
        if Item3 == nil then
	
        else
	
		        -------------------------------------------SELL2-----------------------------------------------------------------
		   
            if Item3.amount >= 1 then
	
		        local price3 = tonumber(Config.Price3) * Item3.amount
		   
                -----------------------elimino dal mio inventario---------------------------------------------------------
		   
                xPlayer.Functions.RemoveItem(Config.Item3, Item3.amount)
                TriggerClientEvent("inventory:client:ItemBox", _source, CashoutCore.Shared.Items[Config.Item3], "remove")
		   
                ----------------------------------------------------------------------------------------------------------
		   
		        -----------------------------------------------ADD MONEY--------------------------------------------------
           
		        xPlayer.Functions.AddMoney("cash", price3, "sold-pawn-items")
		        TriggerClientEvent('CashoutCore:Notify', _source, 'You have sold '..Item3.amount..' pieces '..Config.Item3..'', "success", 5000)  
			
		        ---------------------------------------------------------------------------------------------------------
		   
            else
		
            TriggerClientEvent('CashoutCore:Notify', _source, 'No material to sell', "error", 10000)  
           
            end
        
        
		
        end
        ------------------------------------------------------------------------------------------------------------------

        -------------------------------------------SELL4-----------------------------------------------------------------
        if Item4 == nil then
	
        else
	
		        -------------------------------------------SELL-----------------------------------------------------------------
		   
            if Item4.amount >= 1 then
	
		        local price4 = tonumber(Config.Price4) * Item4.amount
		   
                -----------------------elimino dal mio inventario---------------------------------------------------------
		   
                xPlayer.Functions.RemoveItem(Config.Item4, Item4.amount)
                TriggerClientEvent("inventory:client:ItemBox", _source, CashoutCore.Shared.Items[Config.Item4], "remove")
		   
                ----------------------------------------------------------------------------------------------------------
		   
		        -----------------------------------------------ADD MONEY--------------------------------------------------
           
		        xPlayer.Functions.AddMoney("cash", price4, "sold-pawn-items")
		        TriggerClientEvent('CashoutCore:Notify', _source, 'You have sold '..Item4.amount..' pieces '..Config.Item4..'', "success", 5000)  
			
		        ---------------------------------------------------------------------------------------------------------
		   
            else
		
            TriggerClientEvent('CashoutCore:Notify', _source, 'No material to sell', "error", 10000)  
           
            end
        
        
		
        end
        ------------------------------------------------------------------------------------------------------------------

        -------------------------------------------SELL5-----------------------------------------------------------------
        if Item5 == nil then
	
        else
	
		        -------------------------------------------SELL-----------------------------------------------------------------
		   
            if Item5.amount >= 1 then
	
		        local price5 = tonumber(Config.Price5) * Item5.amount
		   
                -----------------------elimino dal mio inventario---------------------------------------------------------
		   
                xPlayer.Functions.RemoveItem(Config.Item5, Item5.amount)
                TriggerClientEvent("inventory:client:ItemBox", _source, CashoutCore.Shared.Items[Config.Item5], "remove")
		   
                ----------------------------------------------------------------------------------------------------------
		   
		        -----------------------------------------------ADD MONEY--------------------------------------------------
           
		        xPlayer.Functions.AddMoney("cash", price5, "sold-pawn-items")
		        TriggerClientEvent('CashoutCore:Notify', _source, 'You have sold '..Item5.amount..' pieces '..Config.Item5..'', "success", 5000)  
			
		        ---------------------------------------------------------------------------------------------------------
		   
            else
		
            TriggerClientEvent('CashoutCore:Notify', _source, 'No material to sell', "error", 10000)  
           
            end
        
        
		
        end
        ------------------------------------------------------------------------------------------------------------------

        -------------------------------------------SELL6-----------------------------------------------------------------
        if Item6 == nil then
	
        else
	
		        -------------------------------------------SELL-----------------------------------------------------------------
		   
            if Item6.amount >= 1 then
	
		        local price6 = tonumber(Config.Price6) * Item6.amount
		   
                -----------------------elimino dal mio inventario---------------------------------------------------------
		   
                xPlayer.Functions.RemoveItem(Config.Item6, Item6.amount)
                TriggerClientEvent("inventory:client:ItemBox", _source, CashoutCore.Shared.Items[Config.Item6], "remove")
		   
                ----------------------------------------------------------------------------------------------------------
		   
		        -----------------------------------------------ADD MONEY--------------------------------------------------
           
		        xPlayer.Functions.AddMoney("cash", price6, "sold-pawn-items")
		        TriggerClientEvent('CashoutCore:Notify', _source, 'You have sold '..Item6.amount..' pieces '..Config.Item6..'', "success", 5000)  
			
		        ---------------------------------------------------------------------------------------------------------
		   
            else
		
            TriggerClientEvent('CashoutCore:Notify', _source, 'No material to sell', "error", 10000)  
           
            end
        
        
		
        end
        ------------------------------------------------------------------------------------------------------------------

        -------------------------------------------SELL7-----------------------------------------------------------------
        if Item7 == nil then
	
        else
	
		        -------------------------------------------SELL-----------------------------------------------------------------
		   
            if Item7.amount >= 1 then
	
		        local price7 = tonumber(Config.Price7) * Item7.amount
		   
                -----------------------elimino dal mio inventario---------------------------------------------------------
		   
                xPlayer.Functions.RemoveItem(Config.Item7, Item7.amount)
                TriggerClientEvent("inventory:client:ItemBox", _source, CashoutCore.Shared.Items[Config.Item7], "remove")
		   
                ----------------------------------------------------------------------------------------------------------
		   
		        -----------------------------------------------ADD MONEY--------------------------------------------------
           
		        xPlayer.Functions.AddMoney("cash", price7, "sold-pawn-items")
		        TriggerClientEvent('CashoutCore:Notify', _source, 'You have sold '..Item7.amount..' pieces '..Config.Item7..'', "success", 5000)  
			
		        ---------------------------------------------------------------------------------------------------------
		   
            else
		
            TriggerClientEvent('CashoutCore:Notify', _source, 'No material to sell', "error", 10000)  
           
            end
        
        
		
        end
        ------------------------------------------------------------------------------------------------------------------

        -------------------------------------------SELL8-----------------------------------------------------------------
        if Item8 == nil then
	
        else
	
		        -------------------------------------------SELL-----------------------------------------------------------------
		   
            if Item8.amount >= 1 then
	
		        local price8 = tonumber(Config.Price8) * Item8.amount
		   
                -----------------------elimino dal mio inventario---------------------------------------------------------
		   
                xPlayer.Functions.RemoveItem(Config.Item8, Item8.amount)
                TriggerClientEvent("inventory:client:ItemBox", _source, CashoutCore.Shared.Items[Config.Item8], "remove")
		   
                ----------------------------------------------------------------------------------------------------------
		   
		        -----------------------------------------------ADD MONEY--------------------------------------------------
           
		        xPlayer.Functions.AddMoney("cash", price8, "sold-pawn-items")
		        TriggerClientEvent('CashoutCore:Notify', _source, 'You have sold '..Item8.amount..' pieces '..Config.Item8..'', "success", 5000)  
			
		        ---------------------------------------------------------------------------------------------------------
		   
            else
		
            TriggerClientEvent('CashoutCore:Notify', _source, 'No material to sell', "error", 10000)  
           
            end
        
        
		
        end
        ------------------------------------------------------------------------------------------------------------------

        -------------------------------------------SELL9-----------------------------------------------------------------
        if Item9 == nil then
	
        else
	
		        -------------------------------------------SELL-----------------------------------------------------------------
		   
            if Item9.amount >= 1 then
	
		        local price9 = tonumber(Config.Price9) * Item9.amount
		   
                -----------------------elimino dal mio inventario---------------------------------------------------------
		   
                xPlayer.Functions.RemoveItem(Config.Item9, Item9.amount)
                TriggerClientEvent("inventory:client:ItemBox", _source, CashoutCore.Shared.Items[Config.Item9], "remove")
		   
                ----------------------------------------------------------------------------------------------------------
		   
		        -----------------------------------------------ADD MONEY--------------------------------------------------
           
		        xPlayer.Functions.AddMoney("cash", price9, "sold-pawn-items")
		        TriggerClientEvent('CashoutCore:Notify', _source, 'You have sold '..Item9.amount..' pieces '..Config.Item9..'', "success", 5000)  
			
		        ---------------------------------------------------------------------------------------------------------
		   
            else
		
            TriggerClientEvent('CashoutCore:Notify', _source, 'No material to sell', "error", 10000)  
           
            end
        
        
		
        end
        ------------------------------------------------------------------------------------------------------------------

        -------------------------------------------SELL10-----------------------------------------------------------------
        if Item10 == nil then
	
        else
	
		        -------------------------------------------SELL-----------------------------------------------------------------
		   
            if Item10.amount >= 1 then
	
		        local price10 = tonumber(Config.Price10) * Item10.amount
		   
                -----------------------elimino dal mio inventario---------------------------------------------------------
		   
                xPlayer.Functions.RemoveItem(Config.Item10, Item10.amount)
                TriggerClientEvent("inventory:client:ItemBox", _source, CashoutCore.Shared.Items[Config.Item10], "remove")
		   
                ----------------------------------------------------------------------------------------------------------
		   
		        -----------------------------------------------ADD MONEY--------------------------------------------------
           
		        xPlayer.Functions.AddMoney("cash", price10, "sold-pawn-items")
		        TriggerClientEvent('CashoutCore:Notify', _source, 'You have sold '..Item10.amount..' pieces '..Config.Item10..'', "success", 5000)  
			
		        ---------------------------------------------------------------------------------------------------------
		   
            else
		
            TriggerClientEvent('CashoutCore:Notify', _source, 'No material to sell', "error", 10000)  
           
            end
        
        
		
        end
        ------------------------------------------------------------------------------------------------------------------

        -------------------------------------------SELL11-----------------------------------------------------------------
        if Item11 == nil then
	
        else
	
		        -------------------------------------------SELL-----------------------------------------------------------------
		   
            if Item11.amount >= 1 then
	
		        local price11 = tonumber(Config.Price11) * Item11.amount
		   
                -----------------------elimino dal mio inventario---------------------------------------------------------
		   
                xPlayer.Functions.RemoveItem(Config.Item11, Item11.amount)
                TriggerClientEvent("inventory:client:ItemBox", _source, CashoutCore.Shared.Items[Config.Item11], "remove")
		   
                ----------------------------------------------------------------------------------------------------------
		   
		        -----------------------------------------------ADD MONEY--------------------------------------------------
           
		        xPlayer.Functions.AddMoney("cash", price11, "sold-pawn-items")
		        TriggerClientEvent('CashoutCore:Notify', _source, 'You have sold '..Item11.amount..' pieces '..Config.Item11..'', "success", 5000)  
			
		        ---------------------------------------------------------------------------------------------------------
		   
            else
		
            TriggerClientEvent('CashoutCore:Notify', _source, 'No material to sell', "error", 10000)  
           
            end
        
        
		
        end
        ------------------------------------------------------------------------------------------------------------------

        -------------------------------------------SELL12-----------------------------------------------------------------
         if Item12 == nil then
	
         else
     
                 -------------------------------------------SELL-----------------------------------------------------------------
            
             if Item12.amount >= 1 then
     
                 local price12 = tonumber(Config.Price12) * Item12.amount
            
                 -----------------------elimino dal mio inventario---------------------------------------------------------
            
                 xPlayer.Functions.RemoveItem(Config.Item12, Item12.amount)
                 TriggerClientEvent("inventory:client:ItemBox", _source, CashoutCore.Shared.Items[Config.Item12], "remove")
            
                 ----------------------------------------------------------------------------------------------------------
            
                 -----------------------------------------------ADD MONEY--------------------------------------------------
            
                 xPlayer.Functions.AddMoney("cash", price12, "sold-pawn-items")
                 TriggerClientEvent('CashoutCore:Notify', _source, 'You have sold '..Item12.amount..' pieces '..Config.Item12..'', "success", 5000)  
             
                 ---------------------------------------------------------------------------------------------------------
            
             else
         
             TriggerClientEvent('CashoutCore:Notify', _source, 'No material to sell', "error", 10000)  
            
             end
         
         
         
         end
         ------------------------------------------------------------------------------------------------------------------

         -------------------------------------------SELL13-----------------------------------------------------------------
         if Item13 == nil then
	
         else
     
                 -------------------------------------------SELL-----------------------------------------------------------------
            
             if Item13.amount >= 1 then
     
                 local price13 = tonumber(Config.Price13) * Item13.amount
            
                 -----------------------elimino dal mio inventario---------------------------------------------------------
            
                 xPlayer.Functions.RemoveItem(Config.Item13, Item13.amount)
                 TriggerClientEvent("inventory:client:ItemBox", _source, CashoutCore.Shared.Items[Config.Item13], "remove")
            
                 ----------------------------------------------------------------------------------------------------------
            
                 -----------------------------------------------ADD MONEY--------------------------------------------------
            
                 xPlayer.Functions.AddMoney("cash", price13, "sold-pawn-items")
                 TriggerClientEvent('CashoutCore:Notify', _source, 'You have sold '..Item13.amount..' pieces '..Config.Item13..'', "success", 5000)  
             
                 ---------------------------------------------------------------------------------------------------------
            
             else
         
             TriggerClientEvent('CashoutCore:Notify', _source, 'No material to sell', "error", 10000)  
            
             end
         
         
         
         end
         ------------------------------------------------------------------------------------------------------------------

         -------------------------------------------SELL14-----------------------------------------------------------------
         if Item14 == nil then
	
         else
     
                 -------------------------------------------SELL-----------------------------------------------------------------
            
             if Item14.amount >= 1 then
     
                 local price14 = tonumber(Config.Price14) * Item14.amount
            
                 -----------------------elimino dal mio inventario---------------------------------------------------------
            
                 xPlayer.Functions.RemoveItem(Config.Item14, Item14.amount)
                 TriggerClientEvent("inventory:client:ItemBox", _source, CashoutCore.Shared.Items[Config.Item14], "remove")
            
                 ----------------------------------------------------------------------------------------------------------
            
                 -----------------------------------------------ADD MONEY--------------------------------------------------
            
                 xPlayer.Functions.AddMoney("cash", price14, "sold-pawn-items")
                 TriggerClientEvent('CashoutCore:Notify', _source, 'You have sold '..Item14.amount..' pieces '..Config.Item14..'', "success", 5000)  
             
                 ---------------------------------------------------------------------------------------------------------
            
             else
         
             TriggerClientEvent('CashoutCore:Notify', _source, 'No material to sell', "error", 10000)  
            
             end
         
         
         
         end
         ------------------------------------------------------------------------------------------------------------------

         -------------------------------------------SELL15-----------------------------------------------------------------
         if Item15 == nil then
	
         else
     
                 -------------------------------------------SELL-----------------------------------------------------------------
            
             if Item15.amount >= 1 then
     
                 local price15 = tonumber(Config.Price15) * Item15.amount
            
                 -----------------------elimino dal mio inventario---------------------------------------------------------
            
                 xPlayer.Functions.RemoveItem(Config.Item15, Item15.amount)
                 TriggerClientEvent("inventory:client:ItemBox", _source, CashoutCore.Shared.Items[Config.Item15], "remove")
            
                 ----------------------------------------------------------------------------------------------------------
            
                 -----------------------------------------------ADD MONEY--------------------------------------------------
            
                 xPlayer.Functions.AddMoney("cash", price15, "sold-pawn-items")
                 TriggerClientEvent('CashoutCore:Notify', _source, 'You have sold '..Item15.amount..' pieces '..Config.Item15..'', "success", 5000)  
             
                 ---------------------------------------------------------------------------------------------------------
            
             else
         
             TriggerClientEvent('CashoutCore:Notify', _source, 'No material to sell', "error", 10000)  
            
             end
         
         
         
         end
         ------------------------------------------------------------------------------------------------------------------


    end


    

end)
-------------------------------------------------------------------------------------------------END SELL--------------------------------------------------------------------------------------------------