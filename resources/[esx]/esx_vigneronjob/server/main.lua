-----------------------------------------
-- Created and modify by L'ile Légale RP
-- SenSi and Kaminosekai
-----------------------------------------

ESX = nil
local PlayersTransforming  = {}
local PlayersSelling       = {}
local PlayersHarvesting = {}
local vine = 1
local jus = 1
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'vigne', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'vigne', _U('vigneron_client'), true, true)
TriggerEvent('esx_society:registerSociety', 'vigne', 'Vigneron', 'society_vigne', 'society_vigne', 'society_vigne', {type = 'private'})
local function Harvest(source, zone)
	if PlayersHarvesting[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "RaisinFarm" then
			local itemQuantity = xPlayer.getInventoryItem('raisin').count
			if itemQuantity >= 100 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
				return
			else
				SetTimeout(1800, function()
					xPlayer.addInventoryItem('raisin', 1)
					Harvest(source, zone)
				end)
			end
		end
	end
end

RegisterServerEvent('esx_vigneronjob:startHarvest')
AddEventHandler('esx_vigneronjob:startHarvest', function(zone)
	local _source = source
  	
	if PlayersHarvesting[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~Glitching is bad ~w~')
		PlayersHarvesting[_source]=false
	else
		PlayersHarvesting[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('raisin_taken'))  
		Harvest(_source,zone)
	end
end)


RegisterServerEvent('esx_vigneronjob:stopHarvest')
AddEventHandler('esx_vigneronjob:stopHarvest', function()
	local _source = source
	
	if PlayersHarvesting[_source] == true then
		PlayersHarvesting[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'You have exited the ~r~zone')
	else
		TriggerClientEvent('esx:showNotification', _source, 'You can ~g~harvest')
		PlayersHarvesting[_source]=true
	end
end)


local function Transform(source, zone)

	if PlayersTransforming[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "TraitementVin" then
			local itemQuantity = xPlayer.getInventoryItem('raisin').count
			
			if itemQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_raisin'))
				return
			else
				local rand = math.random(0,100)
				if (rand >= 98) then
					SetTimeout(1800, function()
						xPlayer.removeInventoryItem('raisin', 1)
						xPlayer.addInventoryItem('grand_cru', 1)
						TriggerClientEvent('esx:showNotification', source, _U('grand_cru'))
						Transform(source, zone)
					end)
				else
					SetTimeout(1800, function()
						xPlayer.removeInventoryItem('raisin', 1)
						xPlayer.addInventoryItem('vine', 1)
				
						Transform(source, zone)
					end)
				end
			end
		elseif zone == "TraitementJus" then
			local itemQuantity = xPlayer.getInventoryItem('raisin').count
			if itemQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_raisin'))
				return
			else
				SetTimeout(1800, function()
					xPlayer.removeInventoryItem('raisin', 1)
					xPlayer.addInventoryItem('jus_raisin', 1)
		  
					Transform(source, zone)	  
				end)
			end
		end
	end	
end

RegisterServerEvent('esx_vigneronjob:startTransform')
AddEventHandler('esx_vigneronjob:startTransform', function(zone)
	local _source = source
  	
	if PlayersTransforming[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~Glitching is bad ~w~')
		PlayersTransforming[_source]=false
	else
		PlayersTransforming[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('transforming_in_progress')) 
		Transform(_source,zone)
	end
end)

RegisterServerEvent('esx_vigneronjob:stopTransform')
AddEventHandler('esx_vigneronjob:stopTransform', function()

	local _source = source
	
	if PlayersTransforming[_source] == true then
		PlayersTransforming[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'You exited the ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~transformer votre raisin')
		PlayersTransforming[_source]=true
		
	end
end)

local function Sell(source, zone)


	if PlayersSelling[source] == true then
		local xPlayer  = ESX.GetPlayerFromId(source)
		local PlayerData = ESX.GetPlayerFromId(source)
		
		if zone == 'SellFarm' then
			if xPlayer.getInventoryItem('vine').count <= 0 then
				vine = 0
			else
				vine = 1
			end
			
			if xPlayer.getInventoryItem('jus_raisin').count <= 0 then
				jus = 0
			else
				jus = 1
			end
		
			if vine == 0 and jus == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_product_sale'))
				return
			elseif xPlayer.getInventoryItem('vine').count <= 0 and jus == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_vin_sale'))
				vine = 0
				return
			elseif xPlayer.getInventoryItem('jus_raisin').count <= 0 and vine == 0then
				TriggerClientEvent('esx:showNotification', source, _U('no_jus_sale'))
				jus = 0
				return
			else
				if (jus == 1) and (PlayerData.job.grade_name == 'boss') then
					SetTimeout(1000, function()
						local money = math.random(10,15)
						xPlayer.removeInventoryItem('jus_raisin', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addAccountMoney('bank', money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (jus == 1) and (PlayerData.job.grade_name == 'bosstwo') then
					SetTimeout(1000, function()
						local money = math.random(7,12)
						xPlayer.removeInventoryItem('jus_raisin', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addAccountMoney('bank', money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (jus == 1) and (PlayerData.job.grade_name == 'bossthree') then
					SetTimeout(1000, function()
						local money = math.random(6,11)
						xPlayer.removeInventoryItem('jus_raisin', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addAccountMoney('bank', money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (jus == 1) and (PlayerData.job.grade_name == 'cdisenior') then
					SetTimeout(1000, function()
						local money = math.random(5,10)
						xPlayer.removeInventoryItem('jus_raisin', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addAccountMoney('bank', money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (jus == 1) and (PlayerData.job.grade_name == 'novice') then
					SetTimeout(1000, function()
						local money = math.random(5,9)
						xPlayer.removeInventoryItem('jus_raisin', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addAccountMoney('bank', money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (jus == 1) and (PlayerData.job.grade_name == 'manager') then
					SetTimeout(1000, function()
						local money = math.random(3,6)
						xPlayer.removeInventoryItem('jus_raisin', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addAccountMoney('bank', money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (jus == 1) and (PlayerData.job.grade_name == 'recrue') then
					SetTimeout(1000, function()
						local money = math.random(3,5)
						xPlayer.removeInventoryItem('jus_raisin', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addAccountMoney('bank', money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (vine == 1) and (PlayerData.job.grade_name == 'boss') then
					SetTimeout(1000, function()
						local money = math.random(10,15)-- 5.5 3100
						xPlayer.removeInventoryItem('vine', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addAccountMoney('bank', money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (vine == 1) and (PlayerData.job.grade_name == 'bosstwo') then
					SetTimeout(1000, function()
						local money = math.random(7,12) -- 4.5 2500
						xPlayer.removeInventoryItem('vine', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addAccountMoney('bank', money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (vine == 1) and (PlayerData.job.grade_name == 'bossthree') then
					SetTimeout(1000, function()
						local money = math.random(6,11) -- 4.0 2200
						xPlayer.removeInventoryItem('vine', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addAccountMoney('bank', money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (vine == 1) and (PlayerData.job.grade_name == 'cdisenior') then
					SetTimeout(1000, function()
						local money = math.random(5,10) -- 3.5 1900
						xPlayer.removeInventoryItem('vine', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addAccountMoney('bank', money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (vine == 1) and (PlayerData.job.grade_name == 'novice') then
					SetTimeout(1000, function()
						local money = math.random(5,9) --3  1600
						xPlayer.removeInventoryItem('vine', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addAccountMoney('bank', money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (vine == 1) and (PlayerData.job.grade_name == 'manager') then
					SetTimeout(1000, function()
						local money = math.random(3,6) --2.5 1300
						xPlayer.removeInventoryItem('vine', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addAccountMoney('bank', money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (vine == 1) and (PlayerData.job.grade_name == 'recrue') then
					SetTimeout(1000, function()
						local money = math.random(3,5) -- 2.5 -  1300
						xPlayer.removeInventoryItem('vine', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigne', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							xPlayer.addAccountMoney('bank', money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				end
				
			end
		end
	end
end

RegisterServerEvent('esx_vigneronjob:startSell')
AddEventHandler('esx_vigneronjob:startSell', function(zone)

	local _source = source
	
	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~Glitching is bad ~w~')
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		Sell(_source, zone)
	end

end)

RegisterServerEvent('esx_vigneronjob:stopSell')
AddEventHandler('esx_vigneronjob:stopSell', function()

	local _source = source
	
	if PlayersSelling[_source] == true then
		PlayersSelling[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'You exited the ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'You can ~g~sell')
		PlayersSelling[_source]=true
	end

end)

RegisterServerEvent('esx_vigneronjob:getStockItem')
AddEventHandler('esx_vigneronjob:getStockItem', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigne', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= count then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn') .. count .. ' ' .. item.label)

	end)

end)

ESX.RegisterServerCallback('esx_vigneronjob:getStockItems', function(source, cb)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigne', function(inventory)
		cb(inventory.items)
	end)

end)

RegisterServerEvent('esx_vigneronjob:putStockItems')
AddEventHandler('esx_vigneronjob:putStockItems', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigne', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('added') .. count .. ' ' .. item.label)

	end)
end)

ESX.RegisterServerCallback('esx_vigneronjob:getPlayerInventory', function(source, cb)

	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({
		items      = items
	})

end)


ESX.RegisterUsableItem('jus_raisin', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('jus_raisin', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 0)
	TriggerClientEvent('esx_status:add', source, 'thirst', 500000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_jus'))

end)

ESX.RegisterUsableItem('grand_cru', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('grand_cru', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 400000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_grand_cru'))

end)
