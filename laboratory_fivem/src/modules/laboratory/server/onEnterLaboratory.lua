--[[
    onEnterLaboratory.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 21/08/2022 - 22:07:56
]]--
---@author Dezel

LaboratoryUtils.Events:register("playerEnterLaboratory", function(laboratoryId)
    local _src <const> = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local laboratory = LaboratoryModules:getById(laboratoryId)

    if (xPlayer.getJob().name ~= laboratory.gang) then
        return
    end
    if (not LaboratoryUtils.Player:isAtCoords(GetPlayerPed(_src), vector3(laboratory.position.x, laboratory.position.y, laboratory.position.z-0.97), 1.25)) then
        return
    end
    if (not laboratory:haveGradeAccess(xPlayer.getJob().grade)) then
        return LaboratoryUtils.Events:toClient("esx:showNotification", _src, CurrentLocales.NOTIFICATION_DONT_HAVE_GRADE)
    end
    laboratory.isUsed = true
    LaboratoryUtils.Instance:set(_src, laboratory.instance)
    LaboratoryUtils.Events:toClient(("successEnterLaboratory_type=%s:drugs=%s"):format(laboratory.type, laboratory.drugs or "none"), _src, laboratory)
end)