local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_business")

RegisterServerEvent('business:salary')
AddEventHandler('business:salary', function()
	local user_id = vRP.getUserId(source)
	local vacao = math.random(-5000,7000)
	if vRP.hasGroup(user_id,'Acionista') then
		if vacao >= 0 then
			vRP.giveMoney(user_id,vacao)
			TriggerClientEvent('Notify',source,'sucesso','Você acaba de receber R$'..vacao..' de MagaLu.')
		else
			vRP.tryFullPayment(user_id,vacao)
			TriggerClientEvent('Notify',source,'aviso','Você acaba de perder R$'..vacao..' de MagaLu, infelizmente nossas ações cairam!')

		end
	end																														
end)

RegisterServerEvent('business:checkmoney')
AddEventHandler('business:checkmoney', function()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasGroup(user_id,'Acionista') then
		TriggerClientEvent('Notify',source,'aviso','Você já aplicou nessa bolsa!')
		local ok = vRP.request(source,"Deseja vender sua ação por R$900.000?",60)
			if ok then
				vRP.removeUserGroup(user_id,'Acionista')
				vRP.giveBankMoneyMoney(user_id,900000)
				TriggerClientEvent('Notify',source,'sucesso','Você vendeu sua ação por 900 mil')
			end
	else
		local sim = vRP.request(source,'Deseja comprar ações da MagaLu por R$2.000.000?',60)
		if sim then 
			if vRP.tryFullPayment(user_id,2000000) then
				vRP.addUserGroup(user_id,'Acionista')
				TriggerClientEvent('Notify',source,'sucesso','Você aplicou sua grana na bolsa de valores, parabens!!')
			else
				TriggerClientEvent('Notify',source,'negado','Dinheiro insuficiente')	
			end
		end
	end
end)

		