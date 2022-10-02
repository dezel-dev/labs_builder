---@author Dezel

function LaboratoryUtils.Events:toServer(eventName, ...)
    if (not eventName) then
        return
    end
    TriggerServerEvent(LaboratoryUtils.Events:format(eventName), ...)
end