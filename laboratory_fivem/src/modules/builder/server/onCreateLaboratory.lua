--[[
    onCreateLaboratory.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 21/08/2022 - 14:23:40
]]--
---@author Dezel

LaboratoryUtils.Events:register("createlaboratory", function(info, grade)
    local _src <const> = source
    local metadata = {
        gang = info.gangName,
        type = info.laboratoryType,
        position = info.laboratoryPosition,
        name = info.laboratoryName,
        access = {},
        chest = {},
        machine = {}
    }
    for _, v in pairs(grade) do
        metadata.access[tostring(v.grade)] = v.canEnter
    end
    if (info.laboratoryType == "drugs_production") then
        metadata.drugs = info.laboratoryDrugs
    end
    MySQL.insert("INSERT INTO laboratory(metadata) VALUES(@metadata)", {
        ['@metadata'] = json.encode(metadata)
    }, function(metadataId)
        metadata.id = metadataId
        local labo = _Laboratory(metadata)
        if (labo) then
            LaboratoryUtils.Events:toClient("createSuccess", _src)
        end
    end)
end)