---@author Dezel

RegisterCommand("labs_manage", function(source, args)
	if (#args > 0) or (source == 0) then
		return
	end
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	if (xPlayer) then
		if (not LaboratoryConfig.CommandBuilderGroup[xPlayer.getGroup()]) then
			return (ESX.ShowNotification("~r~"..CurrentLocales.HAVE_NOT_ACCESS))
		end
		return LaboratoryUtils.Events:toClient("laboratoryManage", _src)
	end
	LaboratoryUtils.Misc:log(("%s try to execute \"%s\" while is not connected/registered"):format(GetPlayerName(_src), commandName))
end)