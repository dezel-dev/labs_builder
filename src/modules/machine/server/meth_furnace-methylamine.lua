--[[
    furnace-methylamine.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 03/09/2022 - 20:00:42
]]--
---@author Dezel

ESX.RegisterUsableItem("methylamine", function(source)
	LaboratoryUtils.Events:toClient("useItem:methylamine", source)
end)