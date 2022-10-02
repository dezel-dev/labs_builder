---@author Dezel

ESX.RegisterServerCallback("getChestOfLabId", function(source, cb, labId)
	cb(LaboratoryModules:getById(labId).chest)
end)