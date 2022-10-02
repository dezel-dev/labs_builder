---@author Dezel

ESX.RegisterServerCallback("laboratory:doesFactionExist", function(_, cb, factionName)
    cb(LaboratoryMenu.Builder.FactionList[string.upper(factionName)] ~= nil)
end)