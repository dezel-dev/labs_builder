--[[
    toClient.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 20/08/2022 - 21:20:55
]]--
---@author Dezel

function LaboratoryUtils.Events:toClient(eventName, targetId, ...)
    if (not eventName) or (not targetId) then
        return (LaboratoryUtils.Misc:log(("You have missed targetId for the event : %s"):format(eventName)))
    end
    TriggerClientEvent(LaboratoryUtils.Events:format(eventName), targetId, ...)
end