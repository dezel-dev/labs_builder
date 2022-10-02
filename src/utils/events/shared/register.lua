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