--[[
    getPosition.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 21/08/2022 - 12:50:23
]]--
---@author Dezel

function LaboratoryUtils.Player:getPosition()
    return (GetEntityCoords(PlayerPedId()))
end