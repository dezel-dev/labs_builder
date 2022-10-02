---@author Dezel

function LaboratoryUtils.Player:getPosition()
    return (GetEntityCoords(PlayerPedId()))
end