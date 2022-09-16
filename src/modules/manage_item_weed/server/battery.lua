--[[
    pot.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 09/09/2022 - 11:27:39
]]--
---@author Dezel

ESX.RegisterUsableItem("battery", function(source)
	LaboratoryUtils.Events:toClient("useWeedBattery", source)
end)

LaboratoryUtils.Events:register("removeWeedBattery", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.removeInventoryItem("battery", 1)
end)

LaboratoryUtils.Events:register("giveWeedBattery", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.addInventoryItem("battery", 1)
end)