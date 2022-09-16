--[[
    pot.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 09/09/2022 - 11:27:39
]]--
---@author Dezel

ESX.RegisterUsableItem("weed_pot", function(source)
	LaboratoryUtils.Events:toClient("useWeedPot", source)
end)

LaboratoryUtils.Events:register("removeWeedPot", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.removeInventoryItem("weed_pot", 1)
end)

LaboratoryUtils.Events:register("giveWeedPot", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.addInventoryItem("weed_pot", 1)
end)

LaboratoryUtils.Events:register("giveWeedBag", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.addInventoryItem("weed_bag", 4)
end)