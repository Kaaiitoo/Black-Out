ESX = ESX

local GUI = {}
local TempsRestants				  = 0
GUI.Time = 0

if Config.UseOldESX then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj)
        ESX = obj
    end)
end

RegisterNetEvent("mt:missiontext")
AddEventHandler("mt:missiontext", function(text, time)
        ClearPrints()
        SetTextEntry_2("STRING")
        AddTextComponentString(text)
        DrawSubtitleTimed(time, 1)
end)

RegisterNetEvent('kaito:triggerblackout')
AddEventHandler('kaito:triggerblackout', function()
    BlackoutOn()
    Wait(Config.BlackoutDuration *1000)
    BlackoutOff()
end)


local Menu3 = {



    action = {



        'Oui',

        'Non',


    },





    list = 1

}

RegisterNetEvent('kaito:triggeranim')
AddEventHandler('kaito:triggeranim', function(source)
    local playerPed = PlayerPedId()
    local pedCoords = GetEntityCoords(playerPed)
    local tabletProp = GetHashKey('prop_cs_tablet')
    local animdict = 'amb@code_human_in_bus_passenger_idles@female@tablet@idle_a'
    local anim = 'idle_a'
    local pedX, pedY, pedZ = table.unpack(pedCoords)
    prop = CreateObject(tabletProp, pedX, pedY, pedZ + 0.2, true, true, true)
    AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 28422), -0.05, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    RequestAnimDict(animdict)
    while not HasAnimDictLoaded(animdict) do
        Wait(0)
    end
    TaskPlayAnim(playerPed, animdict, anim, 8.0, -8, -1, 49, 0, 0, 0, 0)
	TempsRestants = Config.HackingTime
	repeat
	TriggerEvent("mt:missiontext", '~w~Procédure en cours , temps restants : ~b~' .. TempsRestants .. ' ~w~secondes', 1000)
	TempsRestants = TempsRestants - 1
	Citizen.Wait(1000)
	until(TempsRestants == 0)
    ClearPedSecondaryTask(playerPed)
    DeleteObject(prop)
    FreezeEntityPosition(PlayerPedId(), false)
end)

function BlackoutOn()
    if not Config.UsevSync then
        SetArtificialLightsState(true)
    end
    if Config.Soundeffect then
        PlaySoundFrontend(-1, "Power_Down", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
    end
    if Config.ShowVehicleLights then
        SetArtificialLightsStateAffectsVehicles(false)
    end
    if Config.SendNotification then
        ESX.ShowAdvancedNotification(Config.BlackoutOnNotifyTitle, '', Config.BlackoutOnNotifyText, Config.NotifyImageBlackoutON, 5, false)
    end
end

function BlackoutOff()
    if not Config.UsevSync then
        SetArtificialLightsState(false)
    end
    if Config.Soundeffect then
        PlaySoundFrontend(-1, "police_notification", "DLC_AS_VNT_Sounds", 1)
    end
    if Config.ShowVehicleLights then
        SetArtificialLightsStateAffectsVehicles(true)
    end
    if Config.SendNotification then
        ESX.ShowAdvancedNotification(Config.BlackoutOffNotifyTitle, '', Config.BlackoutOffNotifyText, Config.NotifyImageBlackoutOFF, 5, false)
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        BlackoutOff()
    end
end)


function choix()
    local choix = RageUI.CreateMenu("Choix", "Menu Intéraction..")
    choix:SetRectangleBanner(0, 0, 0)
        RageUI.Visible(choix, not RageUI.Visible(choix))
            while choix do
            Citizen.Wait(0)
            RageUI.IsVisible(choix, true, true, true, function()
    
                RageUI.List('~h~ → Faites votre choix', Menu3.action, Menu3.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                    if (Selected) then 

                        if Index == 1 then
                            local prix = 50000
                            TriggerServerEvent('achetertijean', prix)
                            RageUI.CloseAll()

                            elseif Index == 2 then

                            RageUI.Popup({
                            message = "Dégages alors !"})
                            RageUI.CloseAll()
                            
                    end

                end

                   Menu3.list = Index;              

                end)


            end, function()
            end, 1)

            if not RageUI.Visible(choix) then
            choix = RMenu:DeleteType("choix", true)
        end
    end
end


---- PED MENU 

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.BlackoutPed.position.x, Config.pos.BlackoutPed.position.y, Config.pos.BlackoutPed.position.z)
        if dist3 <= 1.2 then
            Timer = 0

            end
            if dist3 <= 1.2 then
                FreezeEntityPosition(PlayerPedId(), false)
                Timer = 0   
                    RageUI.Text({  message = "Appuyez sur [~b~E~w~] pour parler avec Tijean", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            RageUI.Text({  message = "[~y~Vous~w~] Yo tu as des infos pour moi ?", time_display = 2000 })
                            Citizen.Wait(2000)
                            RageUI.Text({  message = "[~r~Tijean~w~] Tu crois c'est gratuit ?", time_display = 2000 })
                            Citizen.Wait(2000)
                            RageUI.Text({  message = "[~y~Vous~w~] c'est combien ?", time_display = 2000 })
                            Citizen.Wait(2000)
                            RageUI.Text({  message = "[~r~Tijean~w~] 50000$ , tu es intéressé ?", time_display = 2000 })
                            Citizen.Wait(2000)
                            RageUI.CloseAll()
                            choix()
            end
            end 
        Citizen.Wait(Timer)
    end
end)

----------- COUPER LE COURANT ----------------

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.BlackoutPos.position.x, Config.pos.BlackoutPos.position.y, Config.pos.BlackoutPos.position.z)
        if dist3 <= 1.2 then
            Timer = 0
            if dist3 <= 1.2 then
                FreezeEntityPosition(PlayerPedId(), false)
                Timer = 0   
                    RageUI.Text({  message = "Appuyez sur [~r~E~w~] pour commencer la manoeuvre", time_display = 1 })
                        if IsControlJustPressed(1,51) and (GetGameTimer() - GUI.Time) > 1000 then
                            heure		= tonumber(GetClockHours())
                            GUI.Time 	= GetGameTimer()
                            if Config.UtiliserlesHeures then
                                if heure > Config.HeureDispoBlackout and heure < Config.HeureFermerBlackout then
                            TriggerEvent('kaito:triggeranim')
                            FreezeEntityPosition(PlayerPedId(), true)
                            Wait(Config.HackingTime *1000)
                            TriggerServerEvent('kaito:server:triggerblackout', source)
                                else
                                    RageUI.Popup({
                                    message = "La procédure n'est disponible qu'entre ~y~00h00 et 05h00~w~ du matin!"})
                                end
                            end
                        end  
                end
            end 
        Citizen.Wait(Timer)
    end
end)


---------- PED 

local npc2 = {
	{hash="csb_talcc", x = 52.38, y = -1028.6, z = 38.28, a=167.29}, 
}

Citizen.CreateThread(function()
	for _, item2 in pairs(npc2) do
		local hash = GetHashKey(item2.hash)
		while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
		end
		ped2 = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
        TaskStartScenarioInPlace(ped2, 'WORLD_HUMAN_CLIPBOARD_FACILITY', 0, true)
		SetBlockingOfNonTemporaryEvents(ped2, true)
		FreezeEntityPosition(ped2, true)
		SetEntityInvincible(ped2, true)
	end
end)


RegisterNetEvent('PERIOD')
AddEventHandler('PERIOD', function(_source)
local playerPed = PlayerPedId()
local pedCoords = GetEntityCoords(playerPed)
SetNewWaypoint(651.3, 101.23, 80.74)
end)

