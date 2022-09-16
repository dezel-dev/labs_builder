--[[
    _main.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 21/08/2022 - 21:43:48
]]--
---@author Dezel

LaboratoryClientList = {}
LaboratoryModules.IsInLabs = false

LaboratoryUtils.Events:register("refreshLaboratory", function(list)
    LaboratoryClientList = list
end)