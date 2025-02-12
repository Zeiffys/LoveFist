ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_billing:sendBill')
AddEventHandler('esx_billing:sendBill', function(playerId, sharedAccountName, label, amount)

	local xPlayer  = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	TriggerEvent('esx_addonaccount:getSharedAccount', sharedAccountName, function(account)

		if account == nil then

			for i=1, #xPlayers, 1 do

				local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])

				if xPlayer2.source == playerId then

						MySQL.Async.execute(
							'INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
							{
								['@identifier']  = xPlayer2.identifier,
								['@sender']      = xPlayer.identifier,
								['@target_type'] = 'player',
								['@target']      = xPlayer.identifier,
								['@label']       = label,
								['@amount']      = amount
							},
							function(rowsChanged)
								TriggerClientEvent('esx:showNotification', xPlayer2.source, _U('received_invoice'))
							end
						)

					break
				end
			end

		else

			for i=1, #xPlayers, 1 do

				local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])

				if xPlayer2.source == playerId then

						MySQL.Async.execute(
							'INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
							{
								['@identifier']  = xPlayer2.identifier,
								['@sender']      = xPlayer.identifier,
								['@target_type'] = 'player',
								['@target']      = sharedAccountName,
								['@label']       = label,
								['@amount']      = amount
							},
							function(rowsChanged)
								TriggerClientEvent('esx:showNotification', xPlayer2.source, _U('received_invoice'))
							end
						)

					break
				end
			end

		end

	end)

end)

ESX.RegisterServerCallback('esx_billing:getBills', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll(
		'SELECT * FROM billing WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local bills = {}

			for i=1, #result, 1 do
				table.insert(bills, {
					id         = result[i].id,
					identifier = result[i].identifier,
					sender     = result[i].sender,
					targetType = result[i].target_type,
					target     = result[i].target,
					label      = result[i].label,
					amount     = result[i].amount
				})
			end

			cb(bills)

		end
	)

end)


ESX.RegisterServerCallback('esx_billing:payBill', function(source, cb, id)

	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll(
		'SELECT * FROM billing WHERE id = @id',
		{
			['@id'] = id
		},
		function(result)

			local sender      = result[1].sender
			local targetType  = result[1].target_type
			local target      = result[1].target
			local amount      = result[1].amount
			local xPlayers    = ESX.GetPlayers()
			local foundPlayer = nil

			for i=1, #xPlayers, 1 do

				local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])
				
				if xPlayer2.identifier == sender then
					foundPlayer = xPlayer2
					break
				end
			end

			if targetType == 'player' then

				if foundPlayer ~= nil then

						MySQL.Async.execute(
							'DELETE from billing WHERE id = @id',
							{
								['@id'] = id
							},
							function(rowsChanged)

								xPlayer.removeAccountMoney("bank", amount)
								foundPlayer.addMoney(amount)

								TriggerClientEvent('esx:showNotification', xPlayer.source, _U('paid_invoice') .. amount)
								TriggerClientEvent('esx:showNotification', foundPlayer.source, _U('received_payment') .. amount)

								cb()

							end
						)

					else
						TriggerClientEvent('esx:showNotification', _source, _U('player_not_logged'))
						cb()
					end


			else

				TriggerEvent('esx_addonaccount:getSharedAccount', target, function(account)

					MySQL.Async.execute(
						'DELETE from billing WHERE id = @id',
						{
							['@id'] = id
						},
						function(rowsChanged)

							xPlayer.removeMoney(amount)
							account.addMoney(amount)

							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('paid_invoice') .. amount)

							if foundPlayer ~= nil then
								TriggerClientEvent('esx:showNotification', foundPlayer.source, _U('received_payment') .. amount)
							end

							cb()

						end
					)

				end)

			end

		end
	)

end)
