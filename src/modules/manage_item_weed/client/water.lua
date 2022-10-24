---@author Dezel

LaboratoryUtils.Events:register("useWeedWater", function()
	if (not LaboratoryModules.IsInLabs) then
		return
	end
	local coords = GetEntityCoords(PlayerPedId())
	for _, v in pairs(objects_pot) do
		local dst = #(v.position.coords - coords)
		if (dst <= 1.0) then
			v.metadata.plant.ressources.water.state = true
			ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_WEED_WATER)
			LaboratoryUtils.Events:toServer("removeWeedWater")
			return
		end
	end
end)

Citizen.CreateThread(function()
	while (true) do
		for k, v in pairs(objects_pot) do
			if (v.metadata.plant.ressources.water.state) then
				v.metadata.plant.ressources.water.timer = v.metadata.plant.ressources.water.timer - 1
				if (v.metadata.plant.ressources.water.timer == 0) then
					v.metadata.plant.ressources.water.timer = LaboratoryConfig.Labs.Weed.WaterTime
					v.metadata.plant.ressources.water.state = false
				end
			end
		end

		Citizen.Wait(1000)
	end
end)