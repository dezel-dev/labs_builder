---@author Dezel

LaboratoryUtils.Events:register("giveMethBag", function(amount)
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.addInventoryItem("meth_bag", amount)
end)