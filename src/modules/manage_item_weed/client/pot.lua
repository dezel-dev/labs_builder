---@author Dezel

local radiusActive = false
objects_pot = {}

RegisterCommand("radius_pot", function()
	radiusActive = not radiusActive
end)

LaboratoryUtils.Events:register("useWeedPot", function()
	if (not LaboratoryModules.IsInLabs) then
		return
	end
	local coords = vector3(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z - .97)
	ESX.Game.SpawnObject(LaboratoryConfig.Labs.Weed.Objects.Pot.MainModel, coords, function(objId)
		local object_metadata = {
			position = { coords = GetEntityCoords(PlayerPedId()), heading = -GetEntityHeading(PlayerPedId())},
			id = objId,
			metadata = { plant = { state = false, growing = { state = false, timer = LaboratoryConfig.Labs.Weed.ChangeStepTime, canRecup = false, step = 0}, ressources = { water = { state = false, timer = LaboratoryConfig.Labs.Weed.WaterTime }, light = false, fan = false, battery = false } } }
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
					ESX.ShowHelpNotification(CurrentLocales.NOTIFICATION_LABS_WEED_PUT_AWAY_POT)
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
					ESX.Game.Utils.DrawText3D(v.position.coords, ("%s : %s~n~%s : %s (%s s)~n~%s : %s~n~%s : %s"):format(
							CurrentLocales.LABEL_LABS_WEED_PLANTED,
							v.metadata.plant.state and "~g~"..CurrentLocales.LABEL_LABS_WEED_YES.."~s~" or "~r~"..CurrentLocales.LABEL_LABS_WEED_NO.."~s~",
							CurrentLocales.LABEL_LABS_WEED_WATER,
							v.metadata.plant.ressources.water.state and "~g~"..CurrentLocales.LABEL_LABS_WEED_YES.."~s~" or "~r~"..CurrentLocales.LABEL_LABS_WEED_NO.."~s~",
							v.metadata.plant.ressources.water.timer,
							CurrentLocales.LABEL_LABS_WEED_LIGHT,
							v.metadata.plant.ressources.light and "~g~"..CurrentLocales.LABEL_LABS_WEED_YES.."~s~" or "~r~"..CurrentLocales.LABEL_LABS_WEED_NO.."~s~",
							CurrentLocales.LABEL_LABS_WEED_FAN,
							v.metadata.plant.ressources.fan and "~g~"..CurrentLocales.LABEL_LABS_WEED_YES.."~s~" or "~r~"..CurrentLocales.LABEL_LABS_WEED_NO.."~s~"
					))
				end
				if (v.metadata.plant.growing.canRecup) and (dst <= 1.5) then
					ESX.Game.Utils.DrawText3D(vector3(v.position.coords.x, v.position.coords.y, v.position.coords.z + 0.5), "Appuyez sur [~b~E~s~] pour récuper la Weed")
					if (IsControlJustPressed(0,51)) then
						v.metadata.plant.growing.canRecup = false
						v.metadata.plant.state = false
						v.metadata.plant.growing.step = 0
						ESX.Game.DeleteObject(v.id)
						ESX.Game.SpawnObject(LaboratoryConfig.Labs.Weed.Objects.Pot.MainModel, vector3(v.position.coords.x, v.position.coords.y, v.position.coords.z), function(objId)
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