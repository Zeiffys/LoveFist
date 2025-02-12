local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, [","] = 243,
}
local idVisable = nil
local jobVisable = nil
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(2000)
	ESX.TriggerServerCallback('esx_scoreboard:getConnectedPlayers', function(connectedPlayers)
		UpdatePlayerTable(connectedPlayers)
	end)
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	SendNUIMessage({
		action = 'updateServerInfo',
		maxPlayers = Config.MaxPlayers
	})
end)

local drifting = false
AddEventHandler('drifting', function(isDrifting)
  drifting = isDrifting
end)

RegisterNetEvent('esx_scoreboard:updateConnectedPlayers')
AddEventHandler('esx_scoreboard:updateConnectedPlayers', function(connectedPlayers)
	UpdatePlayerTable(connectedPlayers)
end)

RegisterNetEvent('esx_scoreboard:updatePing')
AddEventHandler('esx_scoreboard:updatePing', function(connectedPlayers)
	SendNUIMessage({
		action  = 'updatePing',
		players = connectedPlayers
	})
end)

RegisterNetEvent('esx_scoreboard:toggleID')
AddEventHandler('esx_scoreboard:toggleID', function(state)
	if state == 'true' then
		idVisable = true
	elseif state == 'false' then
		idVisable = false
	else
		idVisable = false
	end
	SendNUIMessage({
		action = 'toggleID',
		state = idVisable
	})
end)

RegisterNetEvent('esx_scoreboard:toggleJob')
AddEventHandler('esx_scoreboard:toggleJob', function(state)
	if state == 'true' then
		jobVisable = true
	elseif state == 'false' then
		jobVisable = false
	else
		jobVisable = false
	end
	SendNUIMessage({
		action = 'toggleJob',
		state = jobVisable
	})
end)

function UpdatePlayerTable(connectedPlayers)
	local formattedPlayerList = {}
	local ems, police, sheriff, taxi, mechanic, cardealer, estate, players = 0, 0, 0, 0, 0, 0, 0, 0

	for k,v in pairs(connectedPlayers) do
		table.insert(formattedPlayerList, ('<tr><td>%s</td><td class="pid">%s</td><td class="sjob">%s</td><td class="ping">%s</td></tr>'):format(v.name, v.id, v.jobLabel, v.ping))
		players = players + 1

		if v.job == 'ambulance' then
			ems = ems + 1
		elseif v.job == 'police' or v.job == 'fib' then
			police = police + 1
		elseif v.job == 'sheriff' then
			sheriff = sheriff + 1
		elseif v.job == 'taxi' then
			taxi = taxi + 1
		elseif v.job == 'mechanic' or v.job == 'mechanic2' or v.job == 'marducas' then
			mechanic = mechanic + 1
		elseif v.job == 'cardealer' then
			cardealer = cardealer + 1
		elseif v.job == 'realestateagent' then
			estate = estate + 1
		end
	end

	SendNUIMessage({
		action  = 'updatePlayerList',
		players = table.concat(formattedPlayerList)
	})

	SendNUIMessage({
		action = 'updatePlayerJobs',
		jobs   = {ems = ems, police = police, sheriff = sheriff, taxi = taxi, mechanic = mechanic, cardealer = cardealer, estate = estate, player_count = players}
	})

	SendNUIMessage({
		action = 'toggleID',
		state = idVisable
	})

	SendNUIMessage({
		action  = 'toggleJob',
		state = jobVisable
	})
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if drifting then
			SendNUIMessage({
				action  = 'close'
			})
		end

		if IsControlJustReleased(0, Keys['PAGEDOWN']) and IsInputDisabled(0) and not drifting then
			ToggleScoreBoard()
			Citizen.Wait(200)
		elseif IsControlJustReleased(0, Keys['PAGEDOWN']) and IsInputDisabled(0) and not drifting then
			SendNUIMessage({
				action  = 'close'
			})
		end
	    if IsControlPressed(0, 37) and IsControlPressed(0, 45) and not IsInputDisabled(0) and not drifting then
			ToggleScoreBoard()
			Citizen.Wait(200)
		elseif IsControlPressed(0, 37) and IsControlPressed(0, 45) and not IsInputDisabled(0) and not drifting then
			SendNUIMessage({
				action  = 'close'
			})
		end

		if IsControlJustPressed(0, 172) and not drifting then
			SendNUIMessage({
				action  = 'scroll',
				scroll = "up"
			})
		elseif IsControlJustPressed(0, 173) and not drifting then
			SendNUIMessage({
				action  = 'scroll',
				scroll = "down"
			})
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)

		if IsPauseMenuActive() and not IsPaused then
			IsPaused = true
			SendNUIMessage({
				action  = 'close'
			})
		elseif not IsPauseMenuActive() and IsPaused then
			IsPaused = false
		end
	end
end)

function ToggleScoreBoard()
	SendNUIMessage({
		action = 'toggle'
	})
end
