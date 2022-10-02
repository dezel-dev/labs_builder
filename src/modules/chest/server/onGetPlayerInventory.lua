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