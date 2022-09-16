--[[
    onDoesFactionExist.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 21/08/2022 - 12:06:50
]]--
---@author Dezel

ESX.RegisterServerCallback("laboratory:doesFactionExist", function(_, cb, factionName)
    cb(LaboratoryMenu.Builder.FactionList[string.upper(factionName)] ~= nil)
end)