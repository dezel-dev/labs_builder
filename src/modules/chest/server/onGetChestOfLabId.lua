--[[
    onGetChestOfLabId.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 23/08/2022 - 15:02:34
]]--
---@author Dezel

ESX.RegisterServerCallback("getChestOfLabId", function(source, cb, labId)
	cb(LaboratoryModules:getById(labId).chest)
end)