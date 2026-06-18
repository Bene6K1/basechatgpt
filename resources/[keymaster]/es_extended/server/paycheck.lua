ESX.StartPayCheck = function()
	function payCheck()
		local xPlayers = ESX.GetPlayers()

		for i = 1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer then
				local society = exports['core']:getSociety(xPlayer.job.name)
				if society then
					if society.coffre['accounts'].society < xPlayer.job.grade_salary then
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Banque', '', 'Votre société n\'a plus d\'argent pour vous payer!', 'CHAR_BANK_MAZE', 1, "~r~")
					else
						society.removeSocietyMoney(xPlayer.job.grade_salary)
						xPlayer.addAccountMoney('bank', xPlayer.job.grade_salary)
						ESX.SavePlayer(xPlayer)

						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Banque', 'Salaire', 'Vous avez reçu votre salaire: ~g~$' ..xPlayer.job.grade_salary, 'CHAR_BANK_MAZE', 1)
					end
				else
					xPlayer.addAccountMoney('bank', 150)
					ESX.SavePlayer(xPlayer)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Banque', 'Salaire', 'Vous avez reçu une aide sociale: ~g~$150', 'CHAR_BANK_MAZE', 1)
				end
			end
		end

		SetTimeout(Config.PaycheckInterval, payCheck)
	end

	SetTimeout(Config.PaycheckInterval, payCheck)
end

CreateThread(function()
	ESX.StartPayCheck()
end)