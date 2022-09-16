--[[
    getLocales.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 20/08/2022 - 21:44:32
]]--
---@author Dezel

function LaboratoryUtils.Misc:getLocales()
    return (LaboratoryLocales[LaboratoryConfig.Locales])
end