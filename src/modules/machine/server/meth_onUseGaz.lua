--[[
    onUseMethylamine.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 04/09/2022 - 17:56:49
]]--
---@author Dezel

LaboratoryUtils.Events:register("useGaz", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	if (xPlayer.getInventoryItem("gaz").count ~= 0) then
		xPlayer.removeInventoryItem("gaz", 1)
	end
end)