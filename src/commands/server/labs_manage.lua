--[[
    labs_manage.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 26/08/2022 - 11:35:11
]]--
---@author Dezel

RegisterCommand("labs_manage", function(source, args)
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