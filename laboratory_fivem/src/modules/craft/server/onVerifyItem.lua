--[[
    onVerifyItem.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 26/08/2022 - 11:02:29
]]--
---@author Dezel

ESX.RegisterServerCallback("craft:verifyItem", function(source, cb, items)
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local canCraft = true
	for _, v in pairs(items) do
		local item = xPlayer.getInventoryItem(v.item_name)
		if (item.count < v.amount) and (canCraft) then
			canCraft = false
		end
	end
	cb(canCraft)
end)