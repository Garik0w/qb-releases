local blips = {
 
  -- coke
   {title="coca collection", colour=4, id=501, x=1037.06, y=4271.65, z=35.65},
   {title="coca process", colour=4, id=501, x=1392.02, y=3605.74, z=38.68},
   {title="coca sale", colour=4, id=501, x=-1666.07, y=-1084.29, z=13.15},
   --weed
   {title="weed collection", colour=25, id=496, x=275.56, y=4379.27, z=47.73},
   {title="weed process", colour=25, id=496, x=2329.69, y=2572.4, z=46.68},
   {title="weed sale", colour=25, id=496, x=-1061.75, y=-1663.49, z=4.57},
   -- chimical
   {title="Chimical collection", colour=67, id=51, x=22.76, y=3655.01, z=39.82},  
   {title="Chimical process", colour=67, id=51, x=3726.97, y=4539.28, z=22.25},
   {title="Chimical sale", colour=67, id=51, x=-106.5, y=-8.35, z=66.80},
   -- meth
   {title="hydrochloric acid", colour=46, id=84, x=2416.42, y= 3142.55, z=48.15},  
   {title="Sulfuric acid", colour=46, id=84, x=2663.97, y=1590.81, z=24.5},
   {title="Sodium hydroxide", colour=46, id=84, x=182.5, y=2776.1, z=45.66},
   {title="Meth Process", colour=46, id=84, x=604.75, y=-3056.83, z=6.17},
   {title="Meth Sell", colour=46, id=84, x=214.56, y=-147.48, z=58.81},
}

Citizen.CreateThread(function()

  for _, info in pairs(blips) do
    info.blip = AddBlipForCoord(info.x, info.y, info.z)
	
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip, 0.6)
    SetBlipColour(info.blip, info.colour)
	
    SetBlipAsShortRange(info.blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
	-------------------------------------------------------------
	RadiusBlip = AddBlipForRadius(info.x, info.y, info.z, 100.0)
    SetBlipRotation(RadiusBlip, 0)
	SetBlipAlpha(RadiusBlip, 100)
    SetBlipColour(RadiusBlip, 1)
	--------------------------------------------------------------
  	
  end
end)

