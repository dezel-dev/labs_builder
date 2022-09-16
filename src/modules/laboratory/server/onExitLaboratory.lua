--[[
    onExitLaboratory.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 23/08/2022 - 14:37:11
]]--
---@author Dezel

LaboratoryUtils.Events:register("exitLaboratory", function()
	local _src <const> = source
	LaboratoryUtils.Instance:basic(_src)
end)