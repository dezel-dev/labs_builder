---@author Dezel

LaboratoryUtils.Events:register("exitLaboratory", function()
	local _src <const> = source
	LaboratoryUtils.Instance:basic(_src)
end)