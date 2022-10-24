---@author Dezel

local function loadObjects()
	for key,v in pairs(objects_pot) do
		ESX.Game.SpawnObject(LaboratoryConfig.Labs.Weed.Objects.Pot.Step[v.metadata.plant.growing.step] ~= 0 and LaboratoryConfig.Labs.Weed.Objects.Pot.Step[v.metadata.plant.growing.step] or LaboratoryConfig.Labs.Weed.Objects.Pot.MainModel, v.position.coords, function(objId)
			PlaceObjectOnGroundProperly(objId)
			objects_pot[key].id = objId
			SetEntityHeading(v.position.heading)
			FreezeEntityPosition(objId, true)
		end)
	end
	for key,v in pairs(objects_battery) do
		ESX.Game.SpawnObject(LaboratoryConfig.Labs.Weed.Objects.Battery.Model, v.position.coords, function(objId)
			PlaceObjectOnGroundProperly(objId)
			objects_battery[key].id = objId
			SetEntityHeading(v.position.heading)
			FreezeEntityPosition(objId, true)
		end)
	end
	for key,v in pairs(objects_fan) do
		ESX.Game.SpawnObject(LaboratoryConfig.Labs.Weed.Objects.Fan.Model, v.position.coords, function(objId)
			PlaceObjectOnGroundProperly(objId)
			objects_fan[key].id = objId
			SetEntityHeading(v.position.heading)
			FreezeEntityPosition(objId, true)
		end)
	end
	for key,v in pairs(objects_light) do
		ESX.Game.SpawnObject(LaboratoryConfig.Labs.Weed.Objects.Light.Model, v.position.coords, function(objId)
			PlaceObjectOnGroundProperly(objId)
			objects_light[key].id = objId
			SetEntityHeading(v.position.heading)
			FreezeEntityPosition(objId, true)
		end)
	end
end

local function unloadObjects()
	for _, v in pairs(objects_battery) do
		ESX.Game.DeleteObject(v.id)
	end
	for _, v in pairs(objects_fan) do
		ESX.Game.DeleteObject(v.id)
	end
	for _, v in pairs(objects_light) do
		ESX.Game.DeleteObject(v.id)
	end
	for _, v in pairs(objects_pot) do
		ESX.Game.DeleteObject(v.id)
	end
end

LaboratoryUtils.Events:register("successEnterLaboratory_type=drugs_production:drugs=weed", function(laboratory)
	LaboratoryModules.IsInLabs = true
	Citizen.CreateThread(function()
		LaboratoryUtils.Misc:transition(LaboratoryConfig.TimeTransition, function()
			SetEntityCoords(PlayerPedId(), LaboratoryConfig.Labs.Weed.Main.position)
			SetEntityHeading(PlayerPedId(), LaboratoryConfig.Labs.Weed.Main.heading)
			loadObjects()
		end)
		
		while (LaboratoryModules.IsInLabs) do
			--Exit interaction =>
			local dst = #(LaboratoryConfig.Labs.Weed.Interaction.Exit.position - GetEntityCoords(PlayerPedId()))
			DrawMarker(6, LaboratoryConfig.Labs.Weed.Interaction.Exit.position, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 150, false, false)
			if (dst <= 1.25) then
				ESX.ShowHelpNotification(CurrentLocales.NOTIFICATION_LABS_EXIT)
				if (IsControlJustPressed(0,51)) then
					unloadObjects()
					LaboratoryUtils.Misc:transition(1000, function()
						LaboratoryUtils.Events:toServer("exitLaboratory")
						SetEntityCoords(PlayerPedId(), vector3(laboratory.position.x, laboratory.position.y, laboratory.position.z-0.97))
					end)
					LaboratoryModules.IsInLabs = false
				end
			end

			--Chest interaction =>
			local dst = #(LaboratoryConfig.Labs.Weed.Interaction.Chest.position - GetEntityCoords(PlayerPedId()))
			DrawMarker(6, LaboratoryConfig.Labs.Weed.Interaction.Chest.position, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 150, false, false)
			if (dst <= 1.25) then
				ESX.ShowHelpNotification(CurrentLocales.NOTIFICATION_LABS_CHEST)
				if (IsControlJustPressed(0,51)) then
					LaboratoryMenu:chest(laboratory.id)
				end
			end

			--Computer interaction =>
			local dst = #(LaboratoryConfig.Labs.Weed.Interaction.Computer.position - GetEntityCoords(PlayerPedId()))
			DrawMarker(6, LaboratoryConfig.Labs.Weed.Interaction.Computer.position, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 150, false, false)
			if (dst <= 1.25) then
				ESX.ShowHelpNotification(CurrentLocales.NOTIFICATION_LABS_COMPUTER)
				if (IsControlJustPressed(0,51)) then
					LaboratoryMenu:computer(LaboratoryConfig.Labs.Meth.Interaction.Computer.Ressources, laboratory.id)
				end
			end

			Wait(0)
		end
	end)
end)