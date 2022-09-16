--[[
    menu.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 24/08/2022 - 10:39:11
]]--
---@author Dezel

local index = {
	list = 1,
	load = 0
}
local type = "in_chest"
local isConnectedToComputer = false

function LaboratoryMenu:computer(ressources, labId)

	local coords = GetEntityCoords(PlayerPedId())

	local main = RageUI.CreateMenu(CurrentLocales.MENU_COMPUTER_TITLE, CurrentLocales.MENU_COMPUTER_DESC);
	local buy = RageUI.CreateSubMenu(main, CurrentLocales.MENU_COMPUTER_TITLE, CurrentLocales.MENU_COMPUTER_DESC)

	RageUI.Visible(main, not RageUI.Visible(main))

	while main do

		local dst = #(coords - GetEntityCoords(PlayerPedId()))
		if (dst > LaboratoryConfig.Menu.ClosingDistance) then
			RageUI.CloseAll()
		end

		Citizen.Wait(0)

		RageUI.IsVisible(main, function()

			if index.load < 1.0 then
				index.load = index.load + 0.0020
			elseif (not isConnectedToComputer) then
				isConnectedToComputer = true
				PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)
			end

			RageUI.Separator(isConnectedToComputer and (CurrentLocales.MENU_COMPUTER_BUTTON_CONNECTED_AS):format(GetHashKey(GetPlayerName(PlayerId()))) or CurrentLocales.MENU_COMPUTER_BUTTON_CONNECTION_IN_PROGRESS)
			RageUI.Line()
			if (isConnectedToComputer) then
				RageUI.Button(CurrentLocales.MENU_COMPUTER_BUTTON_BUY_ITEMS, nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, {}, buy)
			end

		end, function()
			if (not isConnectedToComputer) then
				RageUI.PercentagePanel(index.load, CurrentLocales.MENU_COMPUTER_BUTTON_CONNECTION_IN_PROGRESS, nil, nil, {
					onProgressChange = function(Percentage)
						index.load = Percentage
					end,
				}, 3)
			end
		end)

		RageUI.IsVisible(buy, function()

			RageUI.List(CurrentLocales.MENU_COMPUTER_BUTTON_DELIVER, {
				{ Name = CurrentLocales.MENU_COMPUTER_BUTTON_DELIVER_IN_CHEST, type = "in_chest" },
				{ Name = CurrentLocales.MENU_COMPUTER_BUTTON_DELIVER_ON_PLAYER, type = "on_him" }
			}, index.list, nil, {}, true, {
				onListChange = function(Index, Item)
					index.list = Index
					type = Item.type
				end
			})

			RageUI.Line()

			for _, v in pairs(ressources) do
				RageUI.Button(v.label, nil, {RightLabel = ("~g~%s$"):format(v.price)}, true, {
					onSelected = function()
						local qty = tonumber(LaboratoryUtils.Player:showKeyboard(CurrentLocales.MENU_CHEST_KEYBOARD_INPUT_QUANTITY, nil, 2))
						if (not qty) or (qty == 0) then
							return ESX.ShowNotification(CurrentLocales.NOTIFICATION_CHEST_INVALID_QTY)
						end
						LaboratoryUtils.Events:toServer(("buy_items_type=%s"):format(type), v, qty, labId, v.price)
					end
				})
			end

		end)

		if not RageUI.Visible(main) and not RageUI.Visible(buy) then
			main = RMenu:DeleteType('main', true)
			buy = RMenu:DeleteType('buy', true)
		end
	end
end