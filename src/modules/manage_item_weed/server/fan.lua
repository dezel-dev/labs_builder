---@author Dezel

ESX.RegisterUsableItem("weed_fan", function(source)
	LaboratoryUtils.Events:toClient("useWeedFan", source)
end)

LaboratoryUtils.Events:register("removeWeedFan", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.removeInventoryItem("weed_fan", 1)
end)

LaboratoryUtils.Events:register("giveWeedFan", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.addInventoryItem("weed_fan", 1)
end)