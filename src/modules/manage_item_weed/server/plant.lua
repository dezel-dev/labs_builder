---@author Dezel

ESX.RegisterUsableItem("weed_plant", function(source)
	LaboratoryUtils.Events:toClient("useWeedPlant", source)
end)

LaboratoryUtils.Events:register("removeWeedPlant", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.removeInventoryItem("weed_plant", 1)
end)