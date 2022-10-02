---@author Dezel

function LaboratoryUtils.Events:format(eventName)
    if (not eventName) then
        return
    end
    return (("%s:%s"):format("laboratory", GetHashKey(eventName)))
end