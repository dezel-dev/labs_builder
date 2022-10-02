---@author Dezel

objects_fan = {}

LaboratoryUtils.Events:register("useWeedFan", function()
	if (not LaboratoryModules.IsInLabs) then
		--return
	end
	local coords = vector3(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z - .97)
	ESX.Game.SpawnObject("bkr_prop_weed_fan_floor_01a", coords, function(objId)
		local object_metadata = {
			position = { coords = GetEntityCoords(PlayerPedId()), heading = -GetEntityHeading(PlayerPedId())},
			id = objId
		}
		SetEntityHeading(object_metadata.id, object_metadata.position.heading)
		FreezeEntityPosition(object_metadata.id, true)
		table.insert(objects_fan, object_metadata)
		LaboratoryUtils.Events:toServer("removeWeedFan")
	end)
end)

Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		if (LaboratoryModules.IsInLabs) then
			interval = 0
			for k, v in pairs(objects_fan) do
				local dst = #(v.position.coords - GetEntityCoords(PlayerPedId()))
				if (dst <= 1.0) then
					ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ranger le ventilateur")
					if (IsControlJustPressed(0,51)) then
						ESX.Game.DeleteObject(v.id)
						table.remove(objects_fan, k)
						LaboratoryUtils.Events:toServer("giveWeedFan")
					end
				end
			end
		end

		Citizen.Wait(interval)
	end
end)