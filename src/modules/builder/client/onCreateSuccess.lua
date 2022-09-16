--[[
    onCreateSuccess.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 21/08/2022 - 16:08:13
]]--
---@author Dezel

LaboratoryUtils.Events:register("createSuccess", function()
    RageUI.CloseAll()
    ESX.ShowNotification("~g~"..CurrentLocales.NOTIFICATION_ON_CREATE_SUCCESS)
end)