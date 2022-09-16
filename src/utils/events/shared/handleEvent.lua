--[[
    handleEvent.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 20/08/2022 - 21:21:47
]]--
---@author Dezel

function LaboratoryUtils.Events:handleEvent(eventName, func)
    if (not eventName) then
        return
    end
    AddEventHandler(LaboratoryUtils.Events:format(eventName), func)
end