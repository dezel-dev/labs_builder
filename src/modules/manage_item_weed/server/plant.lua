--[[
    pot.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 09/09/2022 - 11:27:39
]]--
---@author Dezel

ESX.RegisterUsableItem("weed_plant", function(source)
	LaboratoryUtils.Events:toClient("useWeedPlant", source)
end)

LaboratoryUtils.Events:register("removeWeedPlant", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.removeInventoryItem("weed_plant", 1)
end)