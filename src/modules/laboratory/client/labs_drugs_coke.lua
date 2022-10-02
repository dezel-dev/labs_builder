---@author Dezel

LaboratoryUtils.Events:register("successEnterLaboratory_type=drugs_production:drugs=coke", function(laboratory)
	LaboratoryModules.IsInLabs = true
end)