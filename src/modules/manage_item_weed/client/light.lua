---@author Dezel

objects_light = {}

LaboratoryUtils.Events:register("useWeedLight", function()
	if (not LaboratoryModules.IsInLabs) then
		--return
	end
	local coords = vector3(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z - .97)
	ESX.Game.SpawnObject("prop_worklight_01a", coords, function(objId)
		local object_metadata = {
			position = { coords = GetEntityCoords(PlayerPedId()), heading = -GetEntityHeading(PlayerPedId())},
			id = objId
		}
		SetEntityHeading(object_metadata.id, object_metadata.position.heading)
		FreezeEntityPosition(object_metadata.id, true)
		table.insert(objects_light, object_metadata)
		LaboratoryUtils.Events:toServer("removeWeedLight")
	end)
end)

Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		if (LaboratoryModules.IsInLabs) then
			interval = 0
			for k, v in pairs(objects_light) do
				local dst = #(v.position.coords - GetEntityCoords(PlayerPedId()))
				if (dst <= 1.0) then
					ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ranger la lampe")
					if (IsControlJustPressed(0,51)) then
						ESX.Game.DeleteObject(v.id)
						table.remove(objects_light, k)
						LaboratoryUtils.Events:toServer("giveWeedLight")
					end
				end
			end
		end

		Citizen.Wait(interval)
	end
end)