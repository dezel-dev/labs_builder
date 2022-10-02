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