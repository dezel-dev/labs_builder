--[[
    onFinishCraft.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 26/08/2022 - 11:17:47
]]--
---@author Dezel

LaboratoryUtils.Events:register("craft:finishcraft_category=item", function(material, item_name)
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	print(item_name)
	for _, v in pairs(material) do
		xPlayer.removeInventoryItem(v.item_name, v.amount)
	end
	xPlayer.addInventoryItem(item_name, 1)
end)

LaboratoryUtils.Events:register("craft:finishcraft_category=weapon", function(material, weapon_name)
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	print(item_name)
	for _, v in pairs(material) do
		xPlayer.removeInventoryItem(v.item_name, v.amount)
	end
	xPlayer.addInventoryItem(item_name, 1)
	xPlayer.addWeapon(weapon_name, 0)
end)