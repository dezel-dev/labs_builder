--[[
    marker.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 21/08/2022 - 21:36:52
]]--
---@author Dezel

Citizen.CreateThread(function()
    while not ESX.GetPlayerData().job do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    while (true) do
        local interval = 1000
        for _, v in pairs(LaboratoryClientList) do
            if (v.gang == ESX.PlayerData.job.name) then
                local position = vector3(v.position.x, v.position.y, v.position.z-0.97)
                local dst = #(position - LaboratoryUtils.Player:getPosition())
                if (dst <= 10.0) then
                    interval = 0
                    DrawMarker(6, position, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 150, false, false)
                    if (dst <= 1.25) then
                        ESX.ShowHelpNotification(CurrentLocales.NOTIFICATION_ENTER_IN_LABS)
                        if (IsControlJustPressed(0,51)) then
                            LaboratoryUtils.Events:toServer("playerEnterLaboratory", v.id)
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)