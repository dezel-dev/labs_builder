---@author Dezel

LaboratoryUtils.Events:register("useWeedPlant", function()
	if (not LaboratoryModules.IsInLabs) then
		return
	end
	local coords = GetEntityCoords(PlayerPedId())
	for _, v in pairs(objects_pot) do
		local dst = #(v.position.coords - coords)
		if (dst <= 1.0) then
			if (not v.metadata.plant.state) then
				ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_WEED_PLANT)
				LaboratoryUtils.Events:toServer("removeWeedPlant")
				v.metadata.plant.state = true
			else
				ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_WEED_PLANT_ALREADY_PUT)
			end
			return
		end
	end
end)