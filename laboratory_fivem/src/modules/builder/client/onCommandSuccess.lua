--[[
    onCommandSuccess.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 20/08/2022 - 21:34:37
]]--
---@author Dezel

LaboratoryUtils.Events:register("laboratoryBuilder", function()
    LaboratoryMenu:builder()
end)