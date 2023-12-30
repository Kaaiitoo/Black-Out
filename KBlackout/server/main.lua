if Config.UseOldESX then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

RegisterServerEvent('kaito:server:triggerblackout')
AddEventHandler('kaito:server:triggerblackout', function(source)
	local source = source
    if Config.UsevSync then
        ExecuteCommand('blackout')
        Wait(200)
        TriggerEvent('vSync:requestSync')
        TriggerClientEvent('kaito:triggerblackout', -1)
        Wait(Config.BlackoutDuration *1000)
        ExecuteCommand('blackout')
        Wait(200)
        TriggerEvent('vSync:requestSync')
    else
        TriggerClientEvent('kaito:triggerblackout', -1)
     end
end)


RegisterNetEvent('achetertijean')
AddEventHandler('achetertijean', function(prix)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local playerMoney = xPlayer.getMoney()


	if playerMoney >= prix then
		xPlayer.removeMoney(prix)
        TriggerClientEvent('PERIOD', _source)
        TriggerClientEvent('esx:showNotification', _source, "Rends toi à cette position !")
    else
        TriggerClientEvent('esx:showNotification', _source, "T'as pas assez connard")
	end
end)