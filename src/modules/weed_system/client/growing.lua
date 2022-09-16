--[[
    growing.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 09/09/2022 - 20:37:53
]]--
---@author Dezel

function LaboratoryWeed:changeStep(step_number, obj, pos, key)
	ESX.Game.DeleteObject(obj)
	ESX.Game.SpawnObject(LaboratoryConfig.Labs.Weed.Objects.Pot.Step[step_number], vector3(pos.coords.x, pos.coords.y, pos.coords.z-1.0), function(objId)
		PlaceObjectOnGroundProperly(objId)
		objects_pot[key].id = objId
		SetEntityHeading(pos.heading)
		FreezeEntityPosition(objId, true)
	end)
end
--Growing system
Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		if (LaboratoryModules.IsInLabs) then
			interval = 0
			for k, v in pairs(objects_pot) do
				if (v.metadata.plant.state) and (v.metadata.plant.ressources.light) and (v.metadata.plant.ressources.fan) and (v.metadata.plant.ressources.battery) and (v.metadata.plant.ressources.water.state) then
					v.metadata.plant.growing.state = true
				else
					v.metadata.plant.growing.state = false
				end
			end
		end

		Citizen.Wait(interval)
	end
end)
Citizen.CreateThread(function()
	while (true) do
		for k, v in pairs(objects_pot) do
			if (v.metadata.plant.growing.state) and (v.metadata.plant.state) and (not v.metadata.plant.growing.canRecup) then
				v.metadata.plant.growing.timer = v.metadata.plant.growing.timer - 1
				if (v.metadata.plant.growing.timer == 0) then
					v.metadata.plant.growing.timer = 3
					if (v.metadata.plant.growing.step ~= 4) then
						v.metadata.plant.growing.step = v.metadata.plant.growing.step+1
						LaboratoryWeed:changeStep(v.metadata.plant.growing.step+1, v.id, v.position, k)
					end
					if (v.metadata.plant.growing.step == 4) then
						v.metadata.plant.growing.canRecup = true
						v.metadata.plant.growing.state = false
					end
				end
			end
		end

		Citizen.Wait(1000)
	end
end)

--Light system
Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		if (LaboratoryModules.IsInLabs) then
			interval = 250
			for k, v in pairs(objects_pot) do
				local obj = GetClosestObjectOfType(v.position.coords, 2.5, GetHashKey("prop_worklight_01a"), false)
				if (obj ~= 0) then
					v.metadata.plant.ressources.light = true
				else
					v.metadata.plant.ressources.light = false
				end
			end
		end

		Citizen.Wait(interval)
	end
end)

--Battery system
Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		if (LaboratoryModules.IsInLabs) then
			interval = 250
			for k, v in pairs(objects_pot) do
				local obj = GetClosestObjectOfType(v.position.coords, 5.0, GetHashKey("prop_battery_02"), false)
				if (obj ~= 0) then
					v.metadata.plant.ressources.battery = true
				else
					v.metadata.plant.ressources.battery = false
				end
			end
		end

		Citizen.Wait(interval)
	end
end)

--Fan system
Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		if (LaboratoryModules.IsInLabs) then
			interval = 250
			for k, v in pairs(objects_pot) do
				local obj = GetClosestObjectOfType(v.position.coords, 5.0, GetHashKey("bkr_prop_weed_fan_floor_01a"), false)
				if (obj ~= 0) then
					v.metadata.plant.ressources.fan = true
				else
					v.metadata.plant.ressources.fan = false
				end
			end
		end

		Citizen.Wait(interval)
	end
end)