---@author Dezel

local commandName <const> = LaboratoryConfig.CommandBuilderName
local commandGroup <const> = LaboratoryConfig.CommandBuilderGroup

RegisterCommand(commandName, function(source, args)
    if (#args > 0) or (source == 0) then
        return
    end
    local _src <const> = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    if (xPlayer) then
        if (not commandGroup[xPlayer.getGroup()]) then
            return (ESX.ShowNotification("~r~"..CurrentLocales.HAVE_NOT_ACCESS))
        end
        return LaboratoryUtils.Events:toClient("laboratoryBuilder", _src)
    end
    LaboratoryUtils.Misc:log(("%s try to execute \"%s\" while is not connected/registered"):format(GetPlayerName(_src), commandName))
end)