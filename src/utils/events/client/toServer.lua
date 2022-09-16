--[[
    toServer.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 20/08/2022 - 21:19:18
]]--
---@author Dezel

function LaboratoryUtils.Events:toServer(eventName, ...)
    if (not eventName) then
        return
    end
    TriggerServerEvent(LaboratoryUtils.Events:format(eventName), ...)
end