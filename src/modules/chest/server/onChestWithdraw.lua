---@author Dezel

LaboratoryUtils.Events:register("chestWithdraw", function(labId, name, qty)
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local laboratory = LaboratoryModules:getById(labId)
	local item = xPlayer.getInventoryItem(name)
	if (not xPlayer.canCarryItem(item.name, qty)) then
		return 	TriggerClientEvent("esx:showNotification", _src, CurrentLocales.NOTIFICATION_CHEST_ERROR_LIMIT)
	end
	local success = laboratory:chestRemoveItem(item, qty)
	if (success) then
		xPlayer.addInventoryItem(name, qty)
		TriggerClientEvent("esx:showNotification", _src, (CurrentLocales.NOTIFICATION_CHEST_SUCCESS_WITHDRAW):format(qty, item.label))
	end
end)