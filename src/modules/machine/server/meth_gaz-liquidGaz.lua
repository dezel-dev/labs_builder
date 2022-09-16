--[[
    gaz-liquidGaz.lua is owned by Dezel (c).
    Do not take ownership of this file 
    without permission from the developers.

    Create at 08/09/2022 - 17:46:32
]]--
---@author Dezel

ESX.RegisterUsableItem("gaz", function(source)
	LaboratoryUtils.Events:toClient("useItem:gaz", source)
end)