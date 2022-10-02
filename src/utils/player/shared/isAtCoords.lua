---@author Dezel

function LaboratoryUtils.Player:isAtCoords(playerPed, coords, range)
	local playerCoords = GetEntityCoords(playerPed)
	local dst = #(playerCoords - coords)
	if (dst > range) then
		return (false)
	end
	return (true)
end