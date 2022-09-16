--[[
    drugs_meth.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 22/08/2022 - 19:42:45
]]--
---@author Dezel

LaboratoryMachine = {}
LaboratoryModules.Meth = {}

local activeBlips = {}

function LaboratoryModules.Meth:loadBlips()
	for _, v in pairs(LaboratoryConfig.Labs.Meth.Interaction) do
		if (v.Blips) then
			local blip = AddBlipForCoord(v.position)
			SetBlipScale(blip, v.Blips.scale)
			SetBlipSprite(blip, v.Blips.id)
			SetBlipColour(blip, v.Blips.color)
			SetBlipAlpha(blip, v.Blips.alpha)
			AddTextEntry(GetHashKey(v.Blips.name), v.Blips.name)
			BeginTextCommandSetBlipName(GetHashKey(v.Blips.name))
			SetBlipCategory(blip, 2)
			EndTextCommandSetBlipName(blip)
			table.insert(activeBlips, blip)
		end
	end
	for _, v in pairs(LaboratoryConfig.Labs.Meth.Interaction.Machine) do
		if (v.Blips) then
			local blip = AddBlipForCoord(v.position)
			SetBlipScale(blip, v.Blips.scale)
			SetBlipSprite(blip, v.Blips.id)
			SetBlipColour(blip, v.Blips.color)
			SetBlipAlpha(blip, v.Blips.alpha)
			AddTextEntry(GetHashKey(v.Blips.name), v.Blips.name)
			BeginTextCommandSetBlipName(GetHashKey(v.Blips.name))
			SetBlipCategory(blip, 2)
			EndTextCommandSetBlipName(blip)
			table.insert(activeBlips, blip)
		end
	end
end

LaboratoryUtils.Events:register("successEnterLaboratory_type=drugs_production:drugs=meth", function(laboratory)
	LaboratoryModules.IsInLabs = true
	Citizen.CreateThread(function()
		LaboratoryMachine[laboratory.id] = laboratory.machine
		LaboratoryUtils.Misc:transition(LaboratoryConfig.TimeTransition, function()
			LaboratoryModules.Meth:loadBlips()
			SetEntityCoords(PlayerPedId(), LaboratoryConfig.Labs.Meth.Main.position)
			SetEntityHeading(PlayerPedId(), LaboratoryConfig.Labs.Meth.Main.heading)
		end)

		while (LaboratoryModules.IsInLabs) do
			--Exit interaction =>
			local dst = #(LaboratoryConfig.Labs.Meth.Interaction.Exit.position - GetEntityCoords(PlayerPedId()))
			DrawMarker(6, LaboratoryConfig.Labs.Meth.Interaction.Exit.position, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 150, false, false)
			if (dst <= 1.25) then
				ESX.ShowHelpNotification(CurrentLocales.NOTIFICATION_LABS_METH_EXIT)
				if (IsControlJustPressed(0,51)) then
					LaboratoryUtils.Misc:transition(1000, function()
						for _, v in pairs(activeBlips) do
							RemoveBlip(v)
						end
						LaboratoryUtils.Events:toServer("exitLaboratory")
						SetEntityCoords(PlayerPedId(), vector3(laboratory.position.x, laboratory.position.y, laboratory.position.z-0.97))
					end)
					LaboratoryModules.IsInLabs = false
				end
			end

			--Chest interaction =>
			local dst = #(LaboratoryConfig.Labs.Meth.Interaction.Chest.position - GetEntityCoords(PlayerPedId()))
			DrawMarker(6, LaboratoryConfig.Labs.Meth.Interaction.Chest.position, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 150, false, false)
			if (dst <= 1.25) then
				ESX.ShowHelpNotification(CurrentLocales.NOTIFICATION_LABS_CHEST)
				if (IsControlJustPressed(0,51)) then
					LaboratoryMenu:chest(laboratory.id)
				end
			end

			--Computer interaction =>
			local dst = #(LaboratoryConfig.Labs.Meth.Interaction.Computer.position - GetEntityCoords(PlayerPedId()))
			DrawMarker(6, LaboratoryConfig.Labs.Meth.Interaction.Computer.position, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 150, false, false)
			if (dst <= 1.25) then
				ESX.ShowHelpNotification(CurrentLocales.NOTIFICATION_LABS_COMPUTER)
				if (IsControlJustPressed(0,51)) then
					LaboratoryMenu:computer({}, laboratory.id)
				end
			end

			--Furnace (1st machine) interaction =>
			local dst = #(LaboratoryConfig.Labs.Meth.Interaction.Machine.Furnace.position - GetEntityCoords(PlayerPedId()))
			DrawMarker(6, LaboratoryConfig.Labs.Meth.Interaction.Machine.Furnace.position, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 150, false, false)
			if (dst <= 1.25) then
				ESX.ShowHelpNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_FURNACE)
				if (IsControlJustPressed(0,51)) then
					LaboratoryMenu.Machine:furnace(LaboratoryMachine[laboratory.id].furnace)
				end
			end

			--Furnace (2nd machine) interaction =>
			local dst = #(LaboratoryConfig.Labs.Meth.Interaction.Machine.Treatment.position - GetEntityCoords(PlayerPedId()))
			DrawMarker(6, LaboratoryConfig.Labs.Meth.Interaction.Machine.Treatment.position, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 150, false, false)
			if (dst <= 1.25) then
				ESX.ShowHelpNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_TREATMENT)
				if (IsControlJustPressed(0,51)) then
					LaboratoryMenu.Machine:treatment()
				end
			end

			--Furnace (2nd machine) interaction =>
			local dst = #(LaboratoryConfig.Labs.Meth.Interaction.Machine.Gaz.position - GetEntityCoords(PlayerPedId()))
			DrawMarker(6, LaboratoryConfig.Labs.Meth.Interaction.Machine.Gaz.position, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 150, false, false)
			if (dst <= 1.25) then
				ESX.ShowHelpNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_GAZ)
				if (IsControlJustPressed(0,51)) then
					LaboratoryMenu.Machine:gaz()
				end
			end

			Wait(0)
		end
	end)
end)