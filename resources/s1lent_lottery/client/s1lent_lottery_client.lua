local isNear = false
local isInMenu = false
local lotteryList = nil

function enableUI()
	local uiReady = false

	if lotteryList == nil then
		ESX.TriggerServerCallback('s1lent_lottery:getLotteryList', function(data)
			lotteryList = data
			uiReady = true
		end)
	else
		uiReady = true
	end

	while not uiReady do
		Citizen.Wait(1)
	end

	SendNUIMessage({
		type = "toggleui",
		enable = true,
		lotteries = lotteryList
	})
	SetNuiFocus(true, true)
	isInMenu = true
end

function disableUI()
	SendNUIMessage({
		type = "toggleui",
		enable = false
	})
	SetNuiFocus(false, false)
	isInMenu = false
end

--ESX
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--Create Blips
Citizen.CreateThread(function()
	for _, info in pairs(Config.Blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipColour(info.blip, info.color)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)

--Draw Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		local canSleep = true
		
		for k, v in pairs(Config.MarkerZones) do
			local playerCoords = GetEntityCoords(GetPlayerPed(-1))
			local distance = Vdist2(playerCoords.x, playerCoords.y, playerCoords.z, v.x, v.y, v.z)
			if distance < Config.DrawDistance then 
				canSleep = false
				if distance < 4.0 then
					isNear = true
				else
					isNear = false
					if isInMenu then
						disableUI()
					end
				end
				DrawMarker(v.markerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.zoneSize.x, v.zoneSize.y, v.zoneSize.z, v.color.r, v.color.g, v.color.b, 100.0, false, true, 2, false ,false, false, false)
			end
		end
		if canSleep then --Delay next check since player is far enough away, saves resources
			Citizen.Wait(500)
		end
	end
end)

--Menu when in marker
Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(0)
		if isNear and not isInMenu then
			BeginTextCommandDisplayHelp("STRING")
			AddTextComponentSubstringPlayerName("Press ~INPUT_PICKUP~ to open lottery store")
			EndTextCommandDisplayHelp(0, false, true, 1000)
			
			if IsControlJustReleased(0, 38) then --38 = INPUT_PICKUP (default is 'E')
				enableUI() --Create Menu
			end
		elseif isInMenu then
			if IsControlJustReleased(0, 177) then --177 = INPUT_CELLPHONE_CANCEL ('BACKSPACE / ESC / RIGHT MOUSE BUTTON')
				disableUI()
			end
		end
	end
end)

RegisterNUICallback("s1lent_lottery:buy", function(data)
	disableUI()
	local uniqueID = data.uniqueID
	local id = data.id
	local price = tonumber(data.price)
	local nums = table.concat(data.pickedNums, "-")
	print("Ticket Info: uniqueID: " .. uniqueID .. ", id: " .. id .. ", price: " .. price .. ", nums : " .. nums)
	TriggerServerEvent("s1lent_lottery:purchaseTicket", uniqueID, id, price, nums)
	
	ESX.ShowNotification("~g~Good luck!")
end)

RegisterNUICallback("s1lent_lottery:redeem", function(data)
	TriggerServerEvent("s1lent_lottery:redeemTickets")
end)

RegisterNUICallback("s1lent_lottery:close", function(data)
    disableUI()
end)

RegisterNetEvent("s1lent_lottery:ticketsRedeemed")
AddEventHandler("s1lent_lottery:ticketsRedeemed", function(amt)
	if amt > 0 then
		ESX.ShowNotification("~w~You won ~g~ $" .. amt .. " ~w~ from your lottery tickets!")
	else
		ESX.ShowNotification("~w~You did not win any money this time. Better luck next time!")
	end
end)

RegisterNetEvent("s1lent_lottery:notEnoughMoney")
AddEventHandler("s1lent_lottery:notEnoughMoney", function()
	ESX.ShowNotification("~r~You do not have enough money in your bank to purchase this ticket")
end)

RegisterNetEvent("s1lent_lottery:notEnoughCash")
AddEventHandler("s1lent_lottery:notEnoughCash", function()
	ESX.ShowNotification("~r~You do not have enough cash to purchase this ticket")
end)