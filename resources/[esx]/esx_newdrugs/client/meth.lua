local spawnedEphedra = 1
local ephedraPlants = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.FieldZones.EphedrineField.coords, true) < 50 then
			local roll = math.random(50)
			TriggerEvent('esx:showNotification', _U('ephedrine_field_close'))
			if roll == 8 then
				TriggerEvent('esx_jk_drugs:restricted')
			end
			SpawnEphedraPlants()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.ProcessZones.EphedrineProcessing.coords, true) < 15 and GetDistanceBetweenCoords(coords, Config.ProcessZones.EphedrineProcessing.coords, true) > 10 then
			ESX.ShowNotification(_U('ephedrine_process_close'))
		end
		if GetDistanceBetweenCoords(coords, Config.ProcessZones.EphedrineProcessing.coords, true) < 1.5 and not isProcessing then
			ProcessEphedra()
			Citizen.Wait(500)
		end
	end
end)

function ProcessEphedra()
	isProcessing = true

	TriggerServerEvent('esx_jk_drugs:processEphedra')
	local timeLeft = Config.Delays.EphedrineProcessing / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.ProcessZones.EphedrineProcessing.coords, false) > 4 then
			TriggerServerEvent('esx_jk_drugs:cancelProcessing')
			break
		end
	end
	isProcessing = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #ephedraPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(ephedraPlants[i]), false) < 1 then
				nearbyObject, nearbyID = ephedraPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) and not IsPedUsingAnyScenario(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('ephedrine_pickupprompt'))
			end

			if not isPickingUp and IsControlJustReleased(0, 38) then
				isPickingUp = true

				ESX.TriggerServerCallback('esx_jk_drugs:canPickUp', function(canPickUp)

					if canPickUp then
						TriggerEvent('ragdollset', false)
						TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

						table.remove(ephedraPlants, nearbyID)
						spawnedEphedra = spawnedEphedra - 1

						Citizen.Wait(1000)
						ClearPedTasks(playerPed)
						Citizen.Wait(1000)
						ESX.Game.DeleteObject(nearbyObject)

						TriggerServerEvent('esx_jk_drugs:pickedUpEphedra')
						TriggerEvent('ragdollset', true)
					else
						ESX.ShowNotification(_U('ephedrine_inventoryfull'))
					end
				end, 'ephedrine')
				isPickingUp = false

			end
		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(ephedraPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnEphedraPlants()
	while spawnedEphedra < 10 do
		Citizen.Wait(0)
		local ephedraCoords = GenerateEphedraCoords()

		ESX.Game.SpawnLocalObject('prop_plant_cane_01b', ephedraCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(ephedraPlants, obj)
			spawnedEphedra = spawnedEphedra + 1
		end)
	end
end

function ValidateEphedraCoord(plantCoord)
	if spawnedEphedra > 0 then
		local validate = true

		for k, v in pairs(ephedraPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.FieldZones.EphedrineField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateEphedraCoords()
	while true do
		Citizen.Wait(1)

		local ephedraCoordX, ephedraCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-90, 90)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-90, 90)

		ephedraCoordX = Config.FieldZones.EphedrineField.coords.x + modX
		ephedraCoordY = Config.FieldZones.EphedrineField.coords.y + modY

		local coordZ = GetCoordZ(ephedraCoordX, ephedraCoordY)
		local coord = vector3(ephedraCoordX, ephedraCoordY, coordZ)

		if ValidateEphedraCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 70.0, 71.0, 72.0, 73.0, 74.0, 75.0, 76.0, 77.0, 78.0, 79.0, 80.0, 81.0, 82.0, 83.0, 84.0, 85.0, 86.0, 87.0, 88.0, 89.0, 90.0, 91.0, 92.0, 93.0, 94.0, 95.0, 96.0, 97.0, 98.0, 99.0, 100.0, 101.0, 102.0, 103.0, 104.0, 105.0, 106.0, 107.0, 108.0, 109.0, 110.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end
	return 95.0
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.ProcessZones.MethProcessing.coords, true) < 15 and GetDistanceBetweenCoords(coords, Config.ProcessZones.MethProcessing.coords, true) > 10 then
			ESX.ShowNotification(_U('meth_process_close'))
		end
		if GetDistanceBetweenCoords(coords, Config.ProcessZones.MethProcessing.coords, true) < 1.5 and not isProcessing then
			ProcessEphedrine()
			Citizen.Wait(500)
		end
	end
end)

function ProcessEphedrine()
	isProcessing = true

	TriggerServerEvent('esx_jk_drugs:processEphedrine')
	local timeLeft = Config.Delays.MethProcessing / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.ProcessZones.MethProcessing.coords, false) > 4 then
			TriggerServerEvent('esx_jk_drugs:cancelProcessing')
			break
		end
	end
	isProcessing = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.DumpZones.MethDump.coords, true) < 1 then
			if not menuOpen2 then
				ESX.ShowHelpNotification(_U('meth_sell'))

				if IsControlJustReleased(0, 38) then
					wasOpen2 = true
					OpenMethDump()
					if Config.EnableCops then
						local percent = math.random(11)

						if percent <= 2 or percent >= 10 then
						TriggerEvent('esx_jk_drugs:selling', source)
						end
					end
				end
			else
				Citizen.Wait(500)
			end
		else
			if wasOpen2 then
				wasOpen2 = false
				ESX.UI.Menu.CloseAll()
			end

			Citizen.Wait(500)
		end
	end
end)

function OpenMethDump()
	ESX.UI.Menu.CloseAll()
	local elements = {}
	menuOpen2 = true

	for k, v in pairs(ESX.GetPlayerData().inventory) do
		local price = Config.MethDumpItems[v.name]

		if price and v.count > 0 then
			table.insert(elements, {
				label = ('%s - <span style="color:green;">%s</span>'):format(v.label, _U('dealer_item', ESX.Math.GroupDigits(price))),
				name = v.name,
				price = price,

				-- menu properties
				type = 'slider',
				value = 1,
				min = 1,
				max = 10
			})
		end
	end

	if Config.ForceMulti then
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'drug_shop', {
			title    = _U('dealer_title'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			TriggerServerEvent('esx_jk_drugs:sellMeth', data.current.name, data.current.value)
			menu.close()
			menuOpen2 = false
			end, function(data, menu)
		end)

		menuOpen2 = false
	else
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'drug_shop', {
			title    = _U('dealer_title'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			TriggerServerEvent('esx_jk_drugs:sellMeth', data.current.name, data.current.value)
		end, function(data, menu)
			menu.close()
			menuOpen2 = false
		end)

		menuOpen2 = false
	end
end
