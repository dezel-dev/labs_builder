---@author Dezel

local selectedLab

function LaboratoryMenu:manage()

    local main = RageUI.CreateMenu(CurrentLocales.MENU_MANAGE_TITLE, CurrentLocales.MENU_MANAGE_DESC);
    local labs_details = RageUI.CreateSubMenu(main, CurrentLocales.MENU_MANAGE_TITLE, CurrentLocales.MENU_MANAGE_DESC);
    RageUI.Visible(main, not RageUI.Visible(main))

    while main do

        Citizen.Wait(0)

        RageUI.IsVisible(main, function()
            for _, v in pairs(LaboratoryClientList) do
                if (v.id) then
                    RageUI.Button((CurrentLocales.MENU_MANAGE_BUTTON_LIST_LABS):format(v.id), nil, {RightLabel = "~g~[Modifier]"}, true, {
                        onSelected = function()
                            selectedLab = v
                            RageUI.Visible(labs_details, true)
                        end
                    })
                end
            end
        end)

        RageUI.IsVisible(labs_details, function()
            RageUI.Separator(("↓ %s ↓"):format(CurrentLocales.MENU_MANAGE_BUTTON_LIST_LABS:format(selectedLab.id)))
            RageUI.Button(CurrentLocales.MENU_MANAGE_BUTTON_LABS_ACCESS_GANG, nil, {RightLabel = selectedLab.gang}, true, {})
            RageUI.Button(CurrentLocales.MENU_MANAGE_BUTTON_LABS_POSITION, nil, {RightLabel = CurrentLocales.MENU_MANAGE_BUTTON_LABS_POSITION_GOTO}, true, {
                onSelected = function()
                    SetEntityCoords(PlayerPedId(), selectedLab.position.x, selectedLab.position.y, selectedLab.position.z)
                end
            })
            RageUI.Button(CurrentLocales.MENU_MANAGE_BUTTON_LABS_DRUGS, nil, {RightLabel = selectedLab.drugs}, true, {})
            RageUI.Line()
            RageUI.Button(CurrentLocales.MENU_MANAGE_BUTTON_LABS_DELETE, nil, {RightBadge = RageUI.BadgeStyle.Alert}, true, {
                onSelected = function()
                    LaboratoryUtils.Events:toServer("deleteLabs", selectedLab.id)
                    for k, v in pairs(LaboratoryClientList) do
                        if (v.id == selectedLab.id) then
                            LaboratoryClientList[k] = nil
                        end
                    end
                    ESX.ShowNotification(CurrentLocales.NOTIFICATION_MANAGE_DELETE_SUCCESS)
                    RageUI.GoBack()
                end
            })
        end)

        if not RageUI.Visible(main) and not RageUI.Visible(labs_details) then
            main = RMenu:DeleteType('main', true)
            labs_details = RMenu:DeleteType('labs_details', true)
        end
    end
end