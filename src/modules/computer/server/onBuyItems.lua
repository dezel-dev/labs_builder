--[[
    onBuyItems.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 24/08/2022 - 10:58:48
]]--
---@author Dezel

LaboratoryUtils.Events:register("buy_items_type=in_chest", function(item, quantity, lab_id, price)
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local laboratory = LaboratoryModules:getById(lab_id)
	local total_price = quantity * price
	if (xPlayer.getMoney() < total_price) then
		return TriggerClientEvent("esx:showNotification", _src, CurrentLocales.NOTIFICATION_COMPUTER_NOT_ENOUGH_MONEY)
	end
	xPlayer.removeMoney(total_price)
	laboratory:chestAddItem(item, quantity)
	return TriggerClientEvent("esx:showNotification", _src, (CurrentLocales.NOTIFICATION_COMPUTER_SUCCESS_DELIVER_IN_CHEST):format(total_price))
end)

LaboratoryUtils.Events:register("buy_items_type=on_him", function(item, quantity, _, price)
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local total_price = quantity * price
	if (xPlayer.getMoney() < total_price) then
		return TriggerClientEvent("esx:showNotification", _src, CurrentLocales.NOTIFICATION_COMPUTER_NOT_ENOUGH_MONEY)
	end
	if (not xPlayer.canCarryItem(item.name, quantity)) then
		return TriggerClientEvent("esx:showNotification", _src, CurrentLocales.NOTIFICATION_CHEST_ERROR_LIMIT)
	end
 	xPlayer.removeMoney(total_price)
	xPlayer.addInventoryItem(item.name, quantity)
	return TriggerClientEvent("esx:showNotification", _src, (CurrentLocales.NOTIFICATION_COMPUTER_SUCCESS_DELIVER_ON_HIM):format(quantity, item.label, total_price))
end)