--[[
    menu.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 25/08/2022 - 11:55:40
]]--
---@author Dezel

local currentItem = nil
local isInCraft = false

function LaboratoryMenu:craft()

	local coords = GetEntityCoords(PlayerPedId())
	FreezeEntityPosition(PlayerPedId(), true)
	SetEntityHeading(PlayerPedId(), -LaboratoryConfig.Labs.Illegal_Craft.Machine.position.heading)
	SetEntityCoords(PlayerPedId(), LaboratoryConfig.Labs.Illegal_Craft.Interaction.Craft.position)

	local main = RageUI.CreateMenu(CurrentLocales.MENU_CRAFT_ESTABLISHED_TITLE, CurrentLocales.MENU_CRAFT_ESTABLISHED_DESC);
	main.Closed = function()
		FreezeEntityPosition(PlayerPedId(), false)
	end
	local craft = RageUI.CreateSubMenu(main, CurrentLocales.MENU_CRAFT_ESTABLISHED_TITLE, CurrentLocales.MENU_CRAFT_ESTABLISHED_DESC)

	RageUI.Visible(main, not RageUI.Visible(main))

	while main do

		local dst = #(coords - GetEntityCoords(PlayerPedId()))
		if (dst > LaboratoryConfig.Menu.ClosingDistance) then
			RageUI.CloseAll()
		end

		Citizen.Wait(0)

		RageUI.IsVisible(main, function()

			for _, v in pairs(LaboratoryConfig.Labs.Illegal_Craft.Craft) do
				RageUI.Button("~y~→ ~s~"..v.Item.label, (CurrentLocales.MENU_CRAFT_ESTABLISHED_BUTTON_DESC_CRAFT_INFORMATION):format(v.craft_duration/1000, v.Category == "item" and CurrentLocales.MENU_CRAFT_ESTABLISHED_BUTTON_DESC_CRAFT_CATEGORY_ITEM or CurrentLocales.MENU_CRAFT_ESTABLISHED_BUTTON_DESC_CRAFT_CATEGORY_WEAPON), {}, true, {
					onSelected = function()
						currentItem = {
							label = v.Item.label,
							name = v.Item.name,
							duration = v.craft_duration,
							material = v.Material,
							category = v.Category
						}
					end
				}, craft)
			end

		end)

		RageUI.IsVisible(craft, function()

			if (currentItem) then

				for _, v in pairs(currentItem.material) do
					RageUI.Button(("[~r~x%s~s~] %s"):format(v.amount, v.item_label), nil, {}, true, {})
				end

				RageUI.Line()

				RageUI.Button(CurrentLocales.MENU_CRAFT_ESTABLISHED_BUTTON_CRAFT_ITEM, nil, LaboratoryUtils.Misc:getCreateStyle(), not isInCraft, {
					onSelected = function()
						ESX.TriggerServerCallback("craft:verifyItem", function(haveItems)
							if (haveItems) then
								FreezeEntityPosition(PlayerPedId(), true)
								TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_HAMMERING")
								isInCraft = true
								Wait(currentItem.duration)
								isInCraft = false
								FreezeEntityPosition(PlayerPedId(), false)
								ClearPedTasksImmediately(PlayerPedId())
								LaboratoryUtils.Events:toServer(("craft:finishcraft_category=%s"):format(currentItem.category), currentItem.material, currentItem.name)
								ESX.ShowNotification((CurrentLocales.NOTIFICATION_CRAFT_ESTABLISHED_CRAFT_SUCCESS):format(currentItem.label))
							else
								ESX.ShowNotification(CurrentLocales.NOTIFICATION_CRAFT_ESTABLISHED_DOESNT_HAVE_ITEMS)
							end
						end, currentItem.material)
					end
				})

			end

		end)

		if not RageUI.Visible(main) and not RageUI.Visible(craft) then
			main = RMenu:DeleteType('main', true)
			craft = RMenu:DeleteType('craft', true)
		end
	end
end