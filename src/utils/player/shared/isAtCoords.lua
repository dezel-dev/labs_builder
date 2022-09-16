--[[
    isAtCoords.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 22/08/2022 - 17:53:01
]]--
---@author Dezel

function LaboratoryUtils.Player:isAtCoords(playerPed, coords, range)
	local playerCoords = GetEntityCoords(playerPed)
	local dst = #(playerCoords - coords)
	if (dst > range) then
		return (false)
	end
	return (true)
end