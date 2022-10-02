---@author Dezel

--To delete!
RegisterCommand("e", function()
	SetEntityCoords(PlayerPedId(), -220.48809814453129,-935.2060546875,29.28839302062988)
end)

local activeBlips = {}
local activeObj = {}

function LaboratoryModules.Craft:loadCraftBlips()
	for _, v in pairs(LaboratoryConfig.Labs.Illegal_Craft.Interaction) do
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
function LaboratoryModules.Craft:unloadCraftBlips()
	for _, v in pairs(activeBlips) do
		RemoveBlip(v)
	end
end
function LaboratoryModules.Craft:loadMachine()
	ESX.Game.SpawnLocalObject(LaboratoryConfig.Labs.Illegal_Craft.Machine.props_model, LaboratoryConfig.Labs.Illegal_Craft.Machine.position.coords, function(obj)
		SetEntityHeading(obj, LaboratoryConfig.Labs.Illegal_Craft.Machine.position.heading)
		FreezeEntityPosition(obj, true)
		table.insert(activeObj, obj)
	end)
end
function LaboratoryModules.Craft:unloadMachine()
	for _, v in pairs(activeObj) do
		ESX.Game.DeleteObject(v)
	end
end

LaboratoryUtils.Events:register("successEnterLaboratory_type=illegal_craft:drugs=none", function(laboratory)
	LaboratoryModules.IsInLabs = true
	Citizen.CreateThread(function()
		LaboratoryUtils.Misc:transition(LaboratoryConfig.TimeTransition, function()
			SetEntityCoords(PlayerPedId(), LaboratoryConfig.Labs.Illegal_Craft.Main.position)
			SetEntityHeading(PlayerPedId(), LaboratoryConfig.Labs.Illegal_Craft.Main.heading)
			LaboratoryModules.Craft:loadCraftBlips()
			LaboratoryModules.Craft:loadMachine()
		end)
		while (LaboratoryModules.IsInLabs) do
			--Exit interaction =>
			local dst = #(LaboratoryConfig.Labs.Illegal_Craft.Interaction.Exit.position - GetEntityCoords(PlayerPedId()))
			DrawMarker(6, LaboratoryConfig.Labs.Illegal_Craft.Interaction.Exit.position, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 150, false, false)
			if (dst <= 1.25) then
				ESX.ShowHelpNotification(CurrentLocales.NOTIFICATION_LABS_EXIT)
				if (IsControlJustPressed(0,51)) then
					LaboratoryUtils.Misc:transition(1000, function()
						LaboratoryModules.Craft:unloadCraftBlips()
						LaboratoryModules.Craft:unloadMachine()
						LaboratoryUtils.Events:toServer("exitLaboratory")
						SetEntityCoords(PlayerPedId(), vector3(laboratory.position.x, laboratory.position.y, laboratory.position.z-0.97))
					end)
					LaboratoryModules.IsInLabs = false
				end
			end

			--Chest interaction =>
			local dst = #(LaboratoryConfig.Labs.Illegal_Craft.Interaction.Chest.position - GetEntityCoords(PlayerPedId()))
			DrawMarker(6, LaboratoryConfig.Labs.Illegal_Craft.Interaction.Chest.position, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 150, false, false)
			if (dst <= 1.25) then
				ESX.ShowHelpNotification(CurrentLocales.NOTIFICATION_LABS_CHEST)
				if (IsControlJustPressed(0,51)) then
					LaboratoryMenu:chest(laboratory.id)
				end
			end

			--Computer interaction =>
			local dst = #(LaboratoryConfig.Labs.Illegal_Craft.Interaction.Computer.position - GetEntityCoords(PlayerPedId()))
			DrawMarker(6, LaboratoryConfig.Labs.Illegal_Craft.Interaction.Computer.position, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 150, false, false)
			if (dst <= 1.25) then
				ESX.ShowHelpNotification(CurrentLocales.NOTIFICATION_LABS_COMPUTER)
				if (IsControlJustPressed(0,51)) then
					LaboratoryMenu:computer(LaboratoryConfig.Labs.Illegal_Craft.BasicRessources, laboratory.id)
				end
			end

			--Craft interaction =>
			local dst = #(LaboratoryConfig.Labs.Illegal_Craft.Interaction.Craft.position - GetEntityCoords(PlayerPedId()))
			DrawMarker(6, LaboratoryConfig.Labs.Illegal_Craft.Interaction.Craft.position, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 150, false, false)
			if (dst <= 1.25) then
				ESX.ShowHelpNotification(CurrentLocales.NOTIFICATION_CRAFT_INTERACT_WITH_CRAFT)
				if (IsControlJustPressed(0,51)) then
					LaboratoryMenu:craft()
				end
			end

			Wait(0)
		end
	end)
end)