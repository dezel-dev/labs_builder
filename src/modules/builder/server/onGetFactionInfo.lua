---@author Dezel

ESX.RegisterServerCallback("laboratory:getFactionInfo", function(_, cb, factionName)
    cb(LaboratoryMenu.Builder.FactionList[string.upper(factionName)])
end)