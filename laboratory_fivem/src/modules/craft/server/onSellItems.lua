--[[
    onSellItems.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 27/08/2022 - 11:42:44
]]--
---@author Dezel

LaboratoryUtils.Events:register("sell_items", function(items)
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	for _,v in pairs(items) do
		if (v.isSelected) then
			if (v.category == "item") then
				if (xPlayer.getInventoryItem(v.name).count ~= 0) then
					xPlayer.removeInventoryItem(v.name, v.amount)
					xPlayer.addMoney(v.price*v.amount)
				end
			end
			if (v.category == "weapon") then
				if (xPlayer.hasWeapon(v.name)) then
					xPlayer.removeWeapon(v.name)
					xPlayer.addMoney(v.price*v.amount)
				end
			end
		end
	end
end)