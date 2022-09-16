--[[
    valueOrDefine.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 20/08/2022 - 21:54:18
]]--
---@author Dezel

function LaboratoryUtils.Misc:valueOrDefine(value)
    return (value and value or "~r~Non définie")
end