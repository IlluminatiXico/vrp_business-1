local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DrawMarker(21,-1055.5961914063,-242.93690490723,44.021053314209-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,255,255,50,0,0,0,1) -- Cordenanda do marker
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1055.5961914063,-242.93690490723,44.021053314209, true) <= 1.0 then --Colar a mesma cordenada do marker
            DrawText3Ds(-1055.5961914063,-242.93690490723,44.021053314209,'Bolsa de valores',true)
            if IsControlJustPressed(0,38) then
                TriggerServerEvent('business:checkmoney')
            end
        end
    end
end)

Citizen.CreateThread(function ()
	while true do
	local user_id = vRP.getUserId(source)
		Citizen.Wait(6000000) -- A cada 1 hora você recebe o dinheiro da sua empresa.
		TriggerServerEvent('business:salary')
	end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.70, 0.70)
    SetTextFont(6)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

Citizen.CreateThread(function() while true do Citizen.Wait(30000) collectgarbage() end end) -- Corrigir vazamentos de RAM coletando lixo