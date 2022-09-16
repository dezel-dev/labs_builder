--[[
    pot.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 09/09/2022 - 11:27:39
]]--
---@author Dezel

ESX.RegisterUsableItem("weed_light", function(source)
	LaboratoryUtils.Events:toClient("useWeedLight", source)
end)

LaboratoryUtils.Events:register("removeWeedLight", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.removeInventoryItem("weed_light", 1)
end)

LaboratoryUtils.Events:register("giveWeedLight", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.addInventoryItem("weed_light", 1)
end)