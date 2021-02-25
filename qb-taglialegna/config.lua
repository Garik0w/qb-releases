Config = {
    Prices = {
        -- ['item'] = {min, max} --
        ['wood_proc'] = {40, 60}
        
       
    },
    ChanceToGetItem = 20, -- if math.random(0, 100) <= ChanceToGetItem then give item
    Items = {'wood_cut','wood_cut','wood_cut','wood_cut','wood_cut'},
    Sell = vector3(1210.0, -1318.51, 35.23),
    Process = vector3(-584.66, 5285.63, 70.26),
    Cars = vector3(1204.48, -1265.63, 35.23),
	--w_me_hatchet
    Objects = {
        ['pickaxe'] = 'w_me_hatchet',
    },
    WoodPosition = {
        {coords = vector3(-493.0, 5395.37, 77.18-0.97), heading = 282.49},
        {coords = vector3(-503.69, 5392.12, 75.98-0.97), heading = 113.62},
        {coords = vector3(-456.85, 5397.37, 79.49-0.97), heading = 29.92}
    },
    
   
}
CashoutPolicega = {}
CashoutPolicega.SpawnVehicle = {
    x = 1205.31, 
    y = -1288.06, 
    z = 35.23, 
    h = 250.0,
}
Strings = {
   
    ['wood_info'] = 'Press ~INPUT_ATTACK~ to chop, ~INPUT_FRONTEND_RRIGHT~ to stop.',
    ['you_sold'] = 'You sold %sx %s for %s',
    ['e_sell'] = 'Press ~INPUT_CONTEXT~ to sell your material.',
    ['someone_close'] = 'There is a player too close to you!',
    ['wood'] = 'Woodcutter',
    ['process'] = 'Process Wood',
    ['autotru'] = 'Woodcutter truck',
    ['sell_wood'] = 'Sell Wood'
}