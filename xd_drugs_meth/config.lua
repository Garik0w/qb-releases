------CODERC-SLO----------
----DRUG METH------------


Config = {}

Config.Locale = 'en'

Config.Delays = {
	WeedProcessing = 1000 * 1
}

Config.Pricesell = 5000

Config.MinPiecesWed = 1



Config.DrugDealerItems = {
	empty_weed_bag = 91
}

Config.LicenseEnable = false -- enable processing licenses? The player will be required to buy a license in order to process drugs. 



Config.GiveBlack = false -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	WeedField = {coords = vector3(2416.42, 3142.55, 48.15), name = 'blip_weedfield', color = 25, sprite = 496, radius = 30.0},
	WeedField2 = {coords = vector3(2663.97, 1590.81, 24.5), name = 'blip_weedfield', color = 25, sprite = 496, radius = 30.0},
	WeedProcessing = {coords = vector3(604.0, -3057.04, 6.17), name = 'blip_weedprocessing', color = 25, sprite = 496, radius = 100.0},
	DrugDealer = {coords = vector3(213.86, -148.74, 58.81), name = 'blip_drugdealer', color = 6, sprite = 378, radius = 25.0},
}

----------the sodium coordinates are in the client file COORD CRAFT SODIUM