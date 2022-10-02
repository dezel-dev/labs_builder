---@author Dezel

function LaboratoryUtils.Events:toInternal(eventName, ...)
    if (not eventName) then
        return
    end
    TriggerEvent(LaboratoryUtils.Events:format(eventName), ...)
end