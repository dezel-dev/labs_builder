--[[
    toInternal.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 20/08/2022 - 21:21:37
]]--
---@author Dezel

function LaboratoryUtils.Events:toInternal(eventName, ...)
    if (not eventName) then
        return
    end
    TriggerEvent(LaboratoryUtils.Events:format(eventName), ...)
end