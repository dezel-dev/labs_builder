--[[
    getInventory.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 27/08/2022 - 18:10:12
]]--
---@author Dezel

function LaboratoryUtils.Player:getInventory()
	local playerInventory
	ESX.TriggerServerCallback("getPlayerInventory", function(inventory)
		playerInventory = inventory
	end)
	while (not playerInventory) do
		Wait(20)
	end
	return (playerInventory)
end