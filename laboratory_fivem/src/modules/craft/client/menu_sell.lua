--[[
    menu_sell.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 26/08/2022 - 12:40:52
]]--
---@author Dezel

local items = {}
local price = 0

LaboratoryMenu.Sell = {}
function LaboratoryMenu.Sell:getItems()
	CreateThread(function()
		local playerInv = LaboratoryUtils.Player:getInventory()
		local playerItems = {}
		for _, d in pairs(LaboratoryConfig.Peds.Seller.Illegal_Craft.Price) do
			if (d.category == "item") then
				for _, v in pairs(playerInv) do
					if (d.name == v.name) then
						playerItems[d.name] = {
							name = d.name,
							label = v.label,
							amount = v.count,
							price = d.price,
							isSelected = true,
							category = d.category,
						}
					end
				end
			end
			if (d.category == "weapon") then
				if (HasPedGotWeapon(PlayerPedId(), GetHashKey(d.name))) then
					playerItems[d.name] = {
						name = d.name,
						label = d.label,
						amount = 1,
						price = d.price,
						isSelected = true,
						category = d.category,
					}
				end
			end
		end
		items = playerItems
		LaboratoryMenu.Sell:getPrice()
	end)
end
function LaboratoryMenu.Sell:getPrice()
	local money = 0
	for _,v in pairs(items) do
		if (v.isSelected) then
			money = money + v.price * v.amount
		end
	end
	price = money
end

--Create menu function
function LaboratoryMenu:sell()

	LaboratoryMenu.Sell:getItems()
	local coords = GetEntityCoords(PlayerPedId())
	local main = RageUI.CreateMenu(CurrentLocales.MENU_CRAFT_ESTABLISHED_DESC, CurrentLocales.MENU_CRAFT_SELL_DESC);
	RageUI.Visible(main, not RageUI.Visible(main))

	while main do

		local dst = #(coords - GetEntityCoords(PlayerPedId()))
		if (dst > LaboratoryConfig.Menu.ClosingDistance) then
			RageUI.CloseAll()
		end

		Citizen.Wait(0)

		RageUI.IsVisible(main, function()

			RageUI.Button(CurrentLocales.MENU_CRAFT_SELL_BUTTON_SELECT_ALL, nil, {}, true, {
				onSelected = function()
					for _, v in pairs(items) do
						v.isSelected = true
					end
					LaboratoryMenu.Sell:getPrice()
				end
			})

			RageUI.Line()

			for _,v in pairs(items) do
				RageUI.Checkbox(("[~r~x%s~s~] %s"):format(v.amount, v.label), nil, v.isSelected, {}, {
					onSelected = function(Index)
						v.isSelected = Index
						LaboratoryMenu.Sell:getPrice()
					end
				})
			end

			RageUI.Line()

			RageUI.Button((CurrentLocales.MENU_CRAFT_SELL_BUTTON_SELL):format(price), nil, LaboratoryUtils.Misc:getCreateStyle(), true, {
				onSelected = function()
					if (price == 0) then
						return
					end
					LaboratoryUtils.Events:toServer("sell_items", items)
					ESX.ShowNotification((CurrentLocales.NOTIFICATION_CRAFT_SELL_ON_SELL_ITEMS):format(price))
					LaboratoryMenu.Sell:getItems()
				end
			})

		end)

		if not RageUI.Visible(main) then
			main = RMenu:DeleteType('main', true)
		end
	end
end