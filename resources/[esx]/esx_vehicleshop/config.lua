Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 0, g = 0, b = 0 }
Config.EnablePlayerManagement     = true -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = true -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 50
Config.RepaymentMaxTime           = 12 -- hours of gameplay before the user must make a repayment on a loaned vehicle.
Config.AmountOfRepayments         = 20 -- number of repayments needed to finalize the ownership. (maximum)

Config.TowDriverJob = "mechanic"
Config.TowDropOff = vector3(-16.73, -1101.97, 25.50)

Config.Locale = 'en'

Config.LicenseEnable = true -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 4
Config.PlateNumbers  = 4
Config.PlateUseSpace = false

Config.Zones = {
---[[
	 ShopEntering = {
	 	Pos   = { x = -33.777, y = -1102.021, z = -1125.422 },
	 	Size  = { x = 1.5, y = 1.5, z = 1.0 },
	 	Type  = 1
	 },

	 ShopInside = {
	 	Pos     = { x = -47.570, y = -1097.221, z = -1125.422 },
	 	Size    = { x = 1.5, y = 1.5, z = 1.0 },
	 	Heading = -20.0,
	 	Type    = -1
	 },

	 ShopOutside = {
	 	Pos     = { x = -28.637, y = -1085.691, z = -1125.565 },
	 	Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 330.0,
	 	Type    = -1
	 },

	 BossActions = {
		Pos   = { x = -33.6, y = -1102.07, z = 25.42 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
 }
---]]
}
