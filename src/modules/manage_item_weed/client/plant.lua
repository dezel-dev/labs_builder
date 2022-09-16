--[[
    pot.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 09/09/2022 - 11:27:39
]]--
---@author Dezel

LaboratoryUtils.Events:register("useWeedPlant", function()
	if (not LaboratoryModules.IsInLabs) then
		--return
	end
	local coords = GetEntityCoords(PlayerPedId())
	for _, v in pairs(objects_pot) do
		local dst = #(v.position.coords - coords)
		if (dst <= 1.0) then
			if (not v.metadata.plant.state) then
				ESX.ShowNotification("~g~Vous avez planté une graine!")
				LaboratoryUtils.Events:toServer("removeWeedPlant")
				v.metadata.plant.state = true
			else
				ESX.ShowNotification("~r~Une plante est déjà mise!")
			end
			return
		end
	end
end)