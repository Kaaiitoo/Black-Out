Config = {}

Config.UseOldESX = true
Config.UsevSync = true --- SI VOUS UTILISEZ VSYNC SINON FALSE
Config.BlackoutDuration = 60
Config.HackingTime = 15
Config.SendNotification = true
Config.Soundeffect = true
Config.ShowVehicleLights = true

-- HEURES
Config.UtiliserlesHeures = true
Config.HeureDispoBlackout		= 0 -- En gros la le black-out est dispo de 00h00 à 05h00 du matin
Config.HeureFermerBlackout		= 5

--- LES NOTIFS DU SCRIPT
Config.NotifyImageBlackoutON = 'CHAR_LESTER_DEATHWISH'
Config.NotifyImageBlackoutOFF = 'CHAR_CALL911'
Config.BlackoutOnNotifyTitle = 'HACKED'
Config.BlackoutOnNotifyText = '~r~Le courant de la ville a été coupé~w~'
Config.BlackoutOffNotifyTitle = 'GOUVERNEMENT'
Config.BlackoutOffNotifyText = '~g~Le courant a été rétabli~w~'

Config.pos = {
    BlackoutPos = {
		position = {x =651.3, y = 101.23, z = 80.74}
	},
    BlackoutPed = {
		position = {x = 52.38, y = -1028.6, z = 38.28}
	},
}