---@author Dezel

function LaboratoryUtils.Events:handleEvent(eventName, func)
    if (not eventName) then
        return
    end
    AddEventHandler(LaboratoryUtils.Events:format(eventName), func)
end