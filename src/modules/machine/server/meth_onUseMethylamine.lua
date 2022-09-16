--[[
    onUseMethylamine.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 04/09/2022 - 17:56:49
]]--
---@author Dezel

LaboratoryUtils.Events:register("useMethylamine", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	if (xPlayer.getInventoryItem("methylamine").count ~= 0) then
		xPlayer.removeInventoryItem("methylamine", 1)
	end
end)