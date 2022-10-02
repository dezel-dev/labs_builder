---@author Dezel

LaboratoryUtils.Events:register("createSuccess", function()
    RageUI.CloseAll()
    ESX.ShowNotification("~g~"..CurrentLocales.NOTIFICATION_ON_CREATE_SUCCESS)
end)