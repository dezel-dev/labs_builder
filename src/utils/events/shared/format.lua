--[[
    format.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 20/08/2022 - 21:21:33
]]--
---@author Dezel

function LaboratoryUtils.Events:format(eventName)
    if (not eventName) then
        return
    end
    return (("%s:%s"):format("laboratory", GetHashKey(eventName)))
end