local ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)

		Citizen.Wait(0)
	end

	if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()

		ESX.TriggerServerCallback('esx_doorlock:getDoorInfo', function(doorInfo, count)
			for localID = 1, count do
				if doorInfo[localID] ~= nil then
					Config.DoorList[doorInfo[localID].doorID].locked = doorInfo[localID].state
				end
			end
		end)
	end

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
	ESX.PlayerData = playerData

	ESX.TriggerServerCallback('esx_doorlock:getDoorInfo', function(doorInfo, count)
		for localID = 1, count do
			if doorInfo[localID] ~= nil then
				Config.DoorList[doorInfo[localID].doorID].locked = doorInfo[localID].state
			end
		end
	end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
	Citizen.Wait(100)

	while true do
		local sleepThread = 500

		local playerCoords = GetEntityCoords(PlayerPedId())

		for i=1, #Config.DoorList do
			local doorID   = Config.DoorList[i]
			local distance = GetDistanceBetweenCoords(playerCoords, doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z, true)

			local maxDistance = 1.25
			if doorID.distance then
				maxDistance = doorID.distance
			end

			if distance < maxDistance then
				sleepThread = 5

				ApplyDoorState(doorID)

				local size = 1
				if doorID.size then
					size = doorID.size
				end

				local displayText = _U('unlocked')

				if doorID.locked then
					displayText = _U('locked')
				end

				ESX.Game.Utils.DrawText3D(doorID.textCoords, displayText, size)
				
				if IsControlJustReleased(0, 38) then
					local isAuthorized = IsAuthorizedKey(doorID)
					
					if isAuthorized then
						doorID.locked = not doorID.locked

						TriggerServerEvent('esx_doorlock:updateState', i, doorID.locked) -- Broadcast new state of the door to everyone
					end
				end
			end
		end

		Citizen.Wait(sleepThread)
	end
end)

function ApplyDoorState(doorID)
	local closeDoor = GetClosestObjectOfType(doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z, 1.0, GetHashKey(doorID.objName), false, false, false)
	FreezeEntityPosition(closeDoor, doorID.locked)
end


function IsAuthorizedKey(doorID)
	local Inventory = ESX.GetPlayerData()["inventory"]

	for i = 1, #doorID.authorizedJobs, 1 do
		for invId = 1, #Inventory do
			if Inventory[invId]["count"] > 0 then
				if doorID.authorizedJobs[i] == Inventory[invId]["name"] then
					return true
				end
			end
		end
	end

		if ESX.PlayerData.job == nil then
		return false
	end

	for i=1, #doorID.authorizedJobs, 1 do
		if doorID.authorizedJobs[i] == ESX.PlayerData.job.name then
			return true
		end
	end

	return false
end





RegisterNetEvent('esx_doorlock:setState')
AddEventHandler('esx_doorlock:setState', function(doorID, state)
	Config.DoorList[doorID].locked = state
end)