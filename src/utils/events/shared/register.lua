--[[
    register.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 20/08/2022 - 21:21:55
]]--
---@author Dezel

local eventsList = {}
function LaboratoryUtils.Events:register(eventName, ...)
    if (not eventName) then
        return
    end
    if (not eventsList[eventName]) then
        RegisterNetEvent(LaboratoryUtils.Events:format(eventName), ...)
        eventsList[eventName] = true
    end
end