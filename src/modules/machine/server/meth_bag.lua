--[[
    meth_bag.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 09/09/2022 - 10:09:33
]]--
---@author Dezel

LaboratoryUtils.Events:register("giveMethBag", function(amount)
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.addInventoryItem("meth_bag", amount)
end)