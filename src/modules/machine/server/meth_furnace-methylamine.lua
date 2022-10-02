---@author Dezel

ESX.RegisterUsableItem("methylamine", function(source)
	LaboratoryUtils.Events:toClient("useItem:methylamine", source)
end)