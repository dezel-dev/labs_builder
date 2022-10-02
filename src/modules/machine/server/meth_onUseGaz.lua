---@author Dezel

LaboratoryUtils.Events:register("useGaz", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	if (xPlayer.getInventoryItem("gaz").count ~= 0) then
		xPlayer.removeInventoryItem("gaz", 1)
	end
end)