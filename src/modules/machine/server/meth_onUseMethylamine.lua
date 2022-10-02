---@author Dezel

LaboratoryUtils.Events:register("useMethylamine", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	if (xPlayer.getInventoryItem("methylamine").count ~= 0) then
		xPlayer.removeInventoryItem("methylamine", 1)
	end
end)