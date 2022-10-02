---@author Dezel

ESX.RegisterUsableItem("gaz", function(source)
	LaboratoryUtils.Events:toClient("useItem:gaz", source)
end)