---@author Dezel

LaboratoryClientList = {}
LaboratoryModules.IsInLabs = false

LaboratoryUtils.Events:register("refreshLaboratory", function(list)
    LaboratoryClientList = list
end)