--[[
    onGetPlayerInventory.lua is owned by Dezel (c).
    Do not take ownership of this file 
    without permission from the developers.

    Create at 23/08/2022 - 15:18:12
]]--
---@author Dezel

ESX.RegisterServerCallback("getPlayerInventory", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local inventory = {}
	for _, v in pairs(xPlayer.getInventory()) do
		if (v.count >= 1) then
			table.insert(inventory, {
				name = v.name,
				count = v.count,
				label = v.label
			})
		end
	end
	cb(inventory)
end)