---@author Dezel

ESX.RegisterUsableItem("water_canister", function(source)
	LaboratoryUtils.Events:toClient("useWeedWater", source)
end)

LaboratoryUtils.Events:register("removeWeedWater", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.removeInventoryItem("water_canister", 1)
end)