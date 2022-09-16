--[[
    drugs_meth.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 22/08/2022 - 19:42:45
]]--
---@author Dezel

LaboratoryUtils.Events:register("successEnterLaboratory_type=drugs_production:drugs=coke", function(laboratory)
	LaboratoryModules.IsInLabs = true
end)