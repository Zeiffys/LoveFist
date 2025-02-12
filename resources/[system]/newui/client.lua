ESX = nil
local PlayerData    =   {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end

	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

local GPS = {

    Map           = true, -- keep as true

}

local useMph = true
local screenPosX = 0.165                    -- X coordinate (top left corner of HUD)
local screenPosY = 0.882

function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

-- SCREEN POSITION PARAMETERS                 -- Y coordinate (top left corner of HUD)

-- SPEEDOMETER PARAMETERS
local speedLimit = 100.0                    -- Speed limit for changing speed color
local speedColorText = {255, 255, 255}      -- Color used to display speed label text
local speedColorUnder = {160, 255, 160}     -- Color used to display speed when under speedLimit
local speedColorOver = {255, 96, 96}        -- Color used to display speed when over speedLimit

-- FUEL PARAMETERS
local fuelWarnLimit = 25.0                  -- Fuel limit for triggering warning color
local fuelColorText = {255, 255, 255}       -- Color used to display fuel text
local fuelColorOver = {160, 255, 160}       -- Color used to display fuel when good
local fuelColorUnder = {255, 96, 96}        -- Color used to display fuel warning

-- SEATBELT PARAMETERS
local seatbeltInput = 29                  -- Toggle Seatbelt with LShift+S
--local seatbeltInput2 = 8                     -- Toggle Seatbelt with LShift+S
local seatbeltEjectSpeed = 0               -- Speed threshold to eject player (MPH)
local seatbeltEjectAccel = 0             -- Acceleration threshold to eject player (G's)
local seatbeltColorOn = {160, 255, 160}     -- Color used when seatbelt is on
local seatbeltColorOff = {255, 96, 96}      -- Color used when seatbelt is off

-- CRUISE CONTROL PARAMETERS
local cruiseInput = 21                     -- Toggle cruise on/off with CAPSLOCK or A button (controller)
local cruiseColorOn = {160, 255, 160}       -- Color used when seatbelt is on
local cruiseColorOff = {255, 96, 96}        -- Color used when seatbelt is off

-- LOCATION PARAMETERS
local locationColorText = {255, 255, 255}   -- Color used to display location string

-- Lookup tables for direction and zone
local directions = { [0] = 'North', [1] = 'West', [2] = 'South', [3] = 'East', [4] = 'North' }
local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

-- STATE VARIABLES
local currentFuel = 100.0
local cruiseIsOn = false
local seatbeltIsOn = false

-- Main thread
Citizen.CreateThread(function()
    -- Initialize local variable
    local currSpeed = 0.0
    local cruiseSpeed = 999.0
    local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}

    while true do
        -- Loop forever and update HUD every frame
        Citizen.Wait(0)

        -- Get player PED, position and vehicle and save to locals
        local player = GetPlayerPed(-1)
        local position = GetEntityCoords(player)
        local vehicle = GetVehiclePedIsIn(player, false)

        -- Display HUD only when in vehicle
        if (IsPedInAnyVehicle(player, false)) then

            local prevSpeed = currSpeed
            currSpeed = GetEntitySpeed(vehicle)
            local newFuel    = math.ceil(round(GetVehicleFuelLevel(vehicle), 1))
            -- Check if seatbelt button pressed, toggle state and handle seatbelt logic

            -- When player in driver seat, handle cruise control
            if (GetPedInVehicleSeat(vehicle, -1) == player) then
                -- Check if cruise control button pressed, toggle state and set maximum speed appropriately
                if IsControlJustReleased(0, cruiseInput) then
                    if cruiseIsOn then
											cruiseIsOn = not cruiseIsOn
										else
											if (GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1)))*2.236936 >= 25) and IsVehicleOnAllWheels(vehicle) then
	                    	cruiseSpeed = currSpeed
												cruiseIsOn = not cruiseIsOn
											end
										end
                end
                local maxSpeed = cruiseIsOn and cruiseSpeed or GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
                SetEntityMaxSpeed(vehicle, maxSpeed)
            else
                -- Reset cruise control
                cruiseIsOn = false
            end

            -- Get vehicle speed in MPH and draw speedometer
            local speed = currSpeed*2.237
            speedColor = (speed >= speedLimit) and speedColorOver or speedColorUnder
            drawTxt(("%.3d"):format(math.ceil(speed)), 2, speedColor, 0.5, screenPosX + 0.001, screenPosY + 0.017)
            drawTxt("MPH", 2, speedColorText, 0.4, screenPosX + 0.030, screenPosY + 0.020)

            -- Draw fuel gauge; always displays 100 but can be modified by setting currentFuel with an API call
            fuelColor = (newFuel >= fuelWarnLimit) and fuelColorOver or fuelColorUnder
            drawTxt(("%.3d"):format(math.ceil(newFuel)), 2, fuelColor, 0.5, screenPosX + 0.0555, screenPosY + 0.017)
            drawTxt("FUEL", 2, fuelColorText, 0.4, screenPosX + 0.080, screenPosY + 0.020)

            -- Get time and display
            local hour = GetClockHours()
            local minute = GetClockMinutes()
            local timeText = ("%.2d"):format((hour == 0) and 12 or hour) .. ":" .. ("%.2d"):format( minute) .. ((hour < 12) and " AM" or " PM")
            drawTxt(timeText, 4, {255,255,255}, 0.4, screenPosX, screenPosY + 0.048)

            -- Draw cruise control status
            cruiseColor = cruiseIsOn and cruiseColorOn or cruiseColorOff
            drawTxt("CRUISE", 2, cruiseColor, 0.4, screenPosX + 0.040, screenPosY + 0.048)

            -- Draw seatbelt status
            seatbeltColor = seatbeltIsOn and seatbeltColorOn or seatbeltColorOff
            drawTxt("SEATBELT", 2, seatbeltColor, 0.4, screenPosX + 0.080, screenPosY + 0.048)

            -- Get heading and zone from lookup tables and street name from hash
            local heading = directions[math.floor((GetEntityHeading(player) + 45.0) / 90.0)]
            local zoneNameFull = zones[GetNameOfZone(position.x, position.y, position.z)]
            local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))

            -- Display heading, street name and zone when possible
            local locationText = heading
            locationText = (streetName == "" or streetName == nil) and (locationText) or (locationText .. " | " .. streetName)
            locationText = (zoneNameFull == "" or zoneNameFull == nil) and (locationText) or (locationText .. " | " .. zoneNameFull)
            drawTxt(locationText, 4, locationColorText, 0.5, screenPosX, screenPosY + 0.074)
        else
            -- Reset states when not in car
            cruiseIsOn = false
            seatbeltIsOn = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local player = GetPlayerPed(-1)
        local position = GetEntityCoords(player)
        local vehicle = GetVehiclePedIsIn(player, false)
        Citizen.Wait(1)
        if (IsPedInAnyVehicle(player, false)) then
            if IsControlJustReleased(0, seatbeltInput) then seatbeltIsOn = not seatbeltIsOn end
            if seatbeltIsOn then
            end
        end
    end
end)





--[[
    if (IsPedInAnyVehicle(player, false)) then
        if IsControlPressed(0, seatbeltInput) and IsControlJustPressed(0, seatbeltInput2) then seatbeltIsOn = not seatbeltIsOn end
        if not seatbeltIsOn then

        else
        DisableControlAction(0, 75)
        end
    end
]]

-- Helper function to draw text to screen
function drawTxt(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
end
