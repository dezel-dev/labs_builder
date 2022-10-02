---@author Dezel

function LaboratoryUtils.Misc:valueOrDefine(value)
    return (value and value or "~r~Non définie")
end