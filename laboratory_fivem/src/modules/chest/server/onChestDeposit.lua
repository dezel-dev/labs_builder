--[[
    onChestDeposit.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 23/08/2022 - 15:31:09
]]--
---@author Dezel

LaboratoryUtils.Events:register("chestDeposit", function(labId, name, qty)
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local laboratory = LaboratoryModules:getById(labId)
	local item = xPlayer.getInventoryItem(name)
	if (tonumber(qty) > item.count) then
		return TriggerClientEvent("esx:showNotification", _src, CurrentLocales.NOTIFICATION_CHEST_INVALID_QTY)
	end
	laboratory:chestAddItem(item, qty)
	xPlayer.removeInventoryItem(name, qty)
	TriggerClientEvent("esx:showNotification", _src, (CurrentLocales.NOTIFICATION_CHEST_SUCCESS_DEPOSIT):format(qty, item.label))
end)