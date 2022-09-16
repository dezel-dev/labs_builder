--[[
    pot.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 09/09/2022 - 11:27:29
]]--
---@author Dezel

local radiusActive = false
objects_pot = {}

RegisterCommand("radius_pot", function()
	radiusActive = not radiusActive
end)

LaboratoryUtils.Events:register("useWeedPot", function()
	if (not LaboratoryModules.IsInLabs) then
		--return
	end
	local coords = vector3(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z - .97)
	ESX.Game.SpawnObject("bkr_prop_weed_01_small_01c", coords, function(objId)
		local object_metadata = {
			position = { coords = GetEntityCoords(PlayerPedId()), heading = -GetEntityHeading(PlayerPedId())},
			id = objId,
			metadata = { plant = { state = false, growing = { state = false, timer = 10, canRecup = false, step = 0}, ressources = { water = { state = false, timer = 300 }, light = false, fan = false, battery = false } } }
		}
		PlaceObjectOnGroundProperly(objId)
		SetEntityHeading(object_metadata.id, object_metadata.position.heading)
		FreezeEntityPosition(object_metadata.id, true)
		table.insert(objects_pot, object_metadata)
		LaboratoryUtils.Events:toServer("removeWeedPot")
	end)
end)

Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		if (LaboratoryModules.IsInLabs) then
			interval = 0
			for k, v in pairs(objects_pot) do
				local dst = #(v.position.coords - GetEntityCoords(PlayerPedId()))
				if (dst <= 1.0) and (not v.metadata.plant.growing.canRecup) then
					ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ranger le pot")
					if (IsControlJustPressed(0,51)) then
						ESX.Game.DeleteObject(v.id)
						table.remove(objects_pot, k)
						LaboratoryUtils.Events:toServer("giveWeedPot")
					end
				end
				if (dst <= 5.0) then
					if (radiusActive) then
						DrawMarker(6, vector3(v.position.coords.x, v.position.coords.y, v.position.coords.z - 1.10), 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 7.5, 1.0, 7.5, 255, 255, 255, 150, false, false)
					end
					ESX.Game.Utils.DrawText3D(v.position.coords, ("Planté : %s~n~Eau : %s (%s s)~n~Lumière : %s~n~Ventilateur : %s"):format(v.metadata.plant.state and "~g~Oui~s~" or "~r~Non~s~", v.metadata.plant.ressources.water.state and "~g~Oui~s~" or "~r~Non~s~", v.metadata.plant.ressources.water.timer, v.metadata.plant.ressources.light and "~g~Oui~s~" or "~r~Non~s~", v.metadata.plant.ressources.fan and "~g~Oui~s~" or "~r~Non~s~"))
				end
				if (v.metadata.plant.growing.canRecup) and (dst <= 1.5) then
					ESX.Game.Utils.DrawText3D(vector3(v.position.coords.x, v.position.coords.y, v.position.coords.z + 0.5), "Appuyez sur [~b~E~s~] pour récuper la Weed")
					if (IsControlJustPressed(0,51)) then
						v.metadata.plant.growing.canRecup = false
						v.metadata.plant.state = false
						v.metadata.plant.growing.step = 0
						ESX.Game.DeleteObject(v.id)
						ESX.Game.SpawnObject("bkr_prop_weed_01_small_01c", vector3(v.position.coords.x, v.position.coords.y, v.position.coords.z), function(objId)
							PlaceObjectOnGroundProperly(objId)
							objects_pot[k].id = objId
							SetEntityHeading(v.position.heading)
							FreezeEntityPosition(objId, true)
						end)
						LaboratoryUtils.Events:toServer("giveWeedBag")
					end
				end
			end
		end

		Citizen.Wait(interval)
	end
end)