---@author Dezel

ESX.RegisterUsableItem("battery", function(source)
	LaboratoryUtils.Events:toClient("useWeedBattery", source)
end)

LaboratoryUtils.Events:register("removeWeedBattery", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.removeInventoryItem("battery", 1)
end)

LaboratoryUtils.Events:register("giveWeedBattery", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.addInventoryItem("battery", 1)
end)