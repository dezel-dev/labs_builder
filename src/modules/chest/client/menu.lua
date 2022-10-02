---@author Dezel

local chestItems = nil
playerInventory = nil
local canDeposit = true
local canWithdraw = true

local function getChest(labId)
	ESX.TriggerServerCallback("getChestOfLabId", function(chest)
		chestItems = chest
	end, labId)
end

function getInventory()
	ESX.TriggerServerCallback("getPlayerInventory", function(inventory)
		playerInventory = inventory
	end)
end

function LaboratoryMenu:chest(labId)
	getChest(labId)
	local coords = GetEntityCoords(PlayerPedId())
	local main = RageUI.CreateMenu(CurrentLocales.MENU_CHEST_TITLE, CurrentLocales.MENU_CHEST_DESC);
	local deposit = RageUI.CreateSubMenu(main, CurrentLocales.MENU_CHEST_TITLE, CurrentLocales.MENU_CHEST_DESC);
	RageUI.Visible(main, not RageUI.Visible(main))

	while main do

		local dst = #(coords - GetEntityCoords(PlayerPedId()))
		if (dst > LaboratoryConfig.Menu.ClosingDistance) then
			RageUI.CloseAll()
		end

		Citizen.Wait(0)

		RageUI.IsVisible(main, function()
			RageUI.Button(CurrentLocales.MENU_CHEST_BUTTON_DEPOSIT_OBJECTS, nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, {
				onSelected = function()
					getInventory()
				end
			}, deposit)
			RageUI.Line()
			if (chestItems) then
				for _, v in pairs(chestItems) do
					if (v.amount ~= 0) then
						RageUI.Button(("[~r~x%s~s~] %s"):format(v.amount, v.label), nil, {}, canWithdraw, {
							onSelected = function()
								local qty = tonumber(LaboratoryUtils.Player:showKeyboard(CurrentLocales.MENU_CHEST_KEYBOARD_INPUT_QUANTITY, nil, 2))
								if (not qty) then
									return
								end
								LaboratoryUtils.Events:toServer("chestWithdraw", labId, v.name, qty)
								getInventory()
								getChest(labId)
								canWithdraw = false
								SetTimeout(1000,function()
									canWithdraw = true
								end)
							end
						})
					end
				end
			end
		end)

		RageUI.IsVisible(deposit, function()
			if (playerInventory) then
				for _, v in pairs(playerInventory) do
					RageUI.Button(("[~r~x%s~s~] %s"):format(v.count, v.label), nil, {}, canDeposit, {
						onSelected = function()
							local qty = tonumber(LaboratoryUtils.Player:showKeyboard(CurrentLocales.MENU_CHEST_KEYBOARD_INPUT_QUANTITY, nil, 2))
							if (not qty) then
								return
							end
							LaboratoryUtils.Events:toServer("chestDeposit", labId, v.name, qty)
							getInventory()
							getChest(labId)
							canDeposit = false
							SetTimeout(1000,function()
								canDeposit = true
							end)
						end
					})
				end
			end
		end)

		if not RageUI.Visible(main) and not RageUI.Visible(deposit) then
			main = RMenu:DeleteType('main', true)
			deposit = RMenu:DeleteType('deposit', true)
		end
	end
end