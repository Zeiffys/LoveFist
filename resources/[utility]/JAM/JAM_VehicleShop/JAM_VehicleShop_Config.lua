JAM.VehicleShop = {}
local JVS = JAM.VehicleShop
JVS.ESX = JAM.ESX

JVS.DrawTextDist = 4.0
JVS.MenuUseDist = 3.0
JVS.SpawnVehDist = 5000.0
JVS.VehRetDist = 5.0

JVS.CarDealerJobLabel = "cardealer"
JVS.DealerMarkerPos = vector3(-35.58, -1107.64, 25.42)

-- Why vector4's, you ask?
-- X, Y, Z, Heading.

JVS.PurchasedCarPos = vector4(-31.06, -1090.79, 26.42, 340.0)
JVS.PurchasedUtilPos = vector4(-17.88, -1113.94, 26.67, 158.04)

JVS.SmallSpawnVeh = 'asea'
JVS.SmallSpawnPos = vector4(-52.08, -1095.08, 24.95, 203.66)

JVS.LargeSpawnVeh = 'police7'
JVS.LargeSpawnPos = vector4(384.48, -1617.37, 29.49, 148.35)

JVS.DisplayPositions = {
	[1] = vector4(-49.05, -1100.63, 24.95, 40.00),
	[2] = vector4(-43.58, -1098.32, 24.95, 237.50),
	[3] = vector4(-46.05, -1093.03, 24.95, 82.80),
	[4] = vector4(-40.04, -1094.94, 24.95, 187.00),
	[5] = vector4(-44.65, -1103.22, 24.95, 346.12),
	[6] = vector4(-42.27, -1103.48, 24.95, 295.83),
}

JVS.Blips = {
	CityShop = {
		Zone = "Vehicle Shop",
		Sprite = 225,
		Scale = 1.0,
		Display = 4,
		Color = 4,
		Pos = { x = -54.02, y = -1110.43, z = 28.00 },
	},
}
