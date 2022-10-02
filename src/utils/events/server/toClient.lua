---@author Dezel

function LaboratoryUtils.Events:toClient(eventName, targetId, ...)
    if (not eventName) or (not targetId) then
        return (LaboratoryUtils.Misc:log(("You have missed targetId for the event : %s"):format(eventName)))
    end
    TriggerClientEvent(LaboratoryUtils.Events:format(eventName), targetId, ...)
end