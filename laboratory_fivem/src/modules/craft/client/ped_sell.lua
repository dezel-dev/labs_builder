--[[
    ped_sell.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 25/08/2022 - 19:43:37
]]--
---@author Dezel

local coords = LaboratoryConfig.Peds.Seller.Illegal_Craft.Generic.Position.coords
--Create ped
local function loadPed()
	CreateThread(function()
		local model = GetHashKey(LaboratoryConfig.Peds.Seller.Illegal_Craft.Generic.model)
		RequestModel(model)
		while (not HasModelLoaded(model)) do
			Wait(20)
		end
		ped = CreatePed(4, model, coords, LaboratoryConfig.Peds.Seller.Illegal_Craft.Generic.Position.heading, false, false)
		FreezeEntityPosition(ped, true)
		TaskSetBlockingOfNonTemporaryEvents(ped, true)
		SetEntityInvincible(ped, true)
	end)
end

--Interaction for sell the objects
Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		local dst = #(coords - GetEntityCoords(PlayerPedId()))
		if (dst <= 1.5) then
			interval = 0
			ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour intéragir.")
			if (IsControlJustPressed(0,51)) then
				LaboratoryMenu:sell()
			end
		end

		Wait(interval)
	end
end)

AddEventHandler("esx:playerLoaded", loadPed)
loadPed()