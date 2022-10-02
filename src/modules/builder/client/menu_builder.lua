---@author Dezel

local info = {
    gangName,
    laboratoryName,
    laboratoryType = "illegal_craft",
    laboratoryDrugs = "meth",
    laboratoryPosition,
    laboratoryPermission,
}
local faction = nil
local index = {
    type = 1,
    drugs = 1
}

function LaboratoryMenu:builder()
    local main = RageUI.CreateMenu(CurrentLocales.MENU_BUILDER_TITLE, CurrentLocales.MENU_BUILDER_DESC);
    local permission = RageUI.CreateSubMenu(main, CurrentLocales.MENU_BUILDER_TITLE, CurrentLocales.MENU_BUILDER_DESC);
    RageUI.Visible(main, not RageUI.Visible(main))

    while main do

        Citizen.Wait(0)

        RageUI.IsVisible(main, function()

            RageUI.Button(CurrentLocales.MENU_BUILDER_BUTTON_GANG_NAME, nil, {RightLabel = LaboratoryUtils.Misc:valueOrDefine(info.gangName), LeftBadge = RageUI.BadgeStyle.Star}, true, {
                onSelected = function()
                    local name = LaboratoryUtils.Player:showKeyboard(CurrentLocales.MENU_BUILDER_BUTTON_GANG_NAME, nil, 30)
                    if (not name) then return end
                    if (not LaboratoryConfig.BlacklistFaction[name]) then
                        ESX.TriggerServerCallback("laboratory:doesFactionExist", function(exist)
                            if (exist) then
                                info.gangName = name
                                ESX.TriggerServerCallback("laboratory:getFactionInfo", function(info)
                                    faction = info
                                end, info.gangName)
                            else
                                ESX.ShowNotification("~r~"..CurrentLocales.NOTIFICATION_FACTION_NOT_EXIST)
                            end
                        end, name)
                    else
                        ESX.ShowNotification("~r~"..CurrentLocales.NOTIFICATION_BLACKLIST_FACTION)
                    end
                end
            })
            RageUI.Button(CurrentLocales.MENU_BUILDER_BUTTON_LABORATORY_NAME, CurrentLocales.MENU_BUILDER_OPTIONAL_FIELDS, {RightLabel = LaboratoryUtils.Misc:valueOrDefine(info.laboratoryName), LeftBadge = RageUI.BadgeStyle.Star}, true, {
                onSelected = function()
                    local name = LaboratoryUtils.Player:showKeyboard(CurrentLocales.MENU_BUILDER_BUTTON_LABORATORY_NAME, nil, 30)
                    if (not name) then return end
                    if (not LaboratoryConfig.BlacklistName[name]) then
                        info.laboratoryName = name
                    else
                        ESX.ShowNotification("~r~"..CurrentLocales.NOTIFICATION_BLACKLIST_NAME)
                    end
                end
            })
            RageUI.List(CurrentLocales.MENU_BUILDER_BUTTON_LABORATORY_TYPE.MAIN, {
                { Name = CurrentLocales.MENU_BUILDER_BUTTON_LABORATORY_TYPE.ILLEGAL_CRAFT, type = "illegal_craft"},
                { Name = CurrentLocales.MENU_BUILDER_BUTTON_LABORATORY_TYPE.DRUGS_PRODUCTION, type = "drugs_production"}
            }, index.type, nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, {
                onListChange = function(Index, Value)
                    index.type = Index
                    info.laboratoryType = Value.type
                end
            })
            if (info.laboratoryType == "drugs_production") then
                RageUI.List(CurrentLocales.MENU_BUILDER_BUTTON_DRUGS_TYPE.MAIN, {
                    { Name = CurrentLocales.MENU_BUILDER_BUTTON_DRUGS_TYPE.METH, type = "meth"},
                    { Name = CurrentLocales.MENU_BUILDER_BUTTON_DRUGS_TYPE.COKE, type = "coke"},
                    { Name = CurrentLocales.MENU_BUILDER_BUTTON_DRUGS_TYPE.WEED, type = "weed"}
                }, index.drugs, nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, {
                    onListChange = function(Index, Value)
                        index.drugs = Index
                        info.laboratoryDrugs = Value.type
                    end
                })
            end
            RageUI.Button(CurrentLocales.MENU_BUILDER_BUTTON_ENTER_POSITION, nil, {RightLabel = info.laboratoryPosition and "~g~[Définie]" or "~r~[Non définie]", LeftBadge = RageUI.BadgeStyle.Star}, true, {
                onSelected = function()
                    info.laboratoryPosition = LaboratoryUtils.Player:getPosition()
                end
            })

            RageUI.Line()

            if (faction) then
                RageUI.Button((CurrentLocales.MENU_BUILDER_BUTTON_MANAGE_PERMS):format(#faction.grade), nil, {RightLabel = "→", LeftBadge = RageUI.BadgeStyle.Star}, faction and true or false, {}, permission)
            end

            RageUI.Line()

            RageUI.Button(CurrentLocales.MENU_BUILDER_BUTTON_CREATE_LABORATORY, nil, LaboratoryUtils.Misc:getCreateStyle(), true, {
                onSelected = function()
                    if (not info.gangName or not info.laboratoryType or not info.laboratoryDrugs or not info.laboratoryPosition) then
                        return (ESX.ShowNotification("~r~"..CurrentLocales.NOTIFICATION_INCOMPLETE_FIELDS))
                    end
                    LaboratoryUtils.Events:toServer("createlaboratory", info, faction.grade)
                end
            })

        end)
        RageUI.IsVisible(permission, function()

            for _, v in pairs(faction.grade) do
                RageUI.Checkbox(("[~r~%s~s~] %s (%s)"):format(v.grade, v.label, v.name), nil, v.canEnter, {}, {
                    onSelected = function(Index)
                        v.canEnter = Index
                    end
                })
            end

        end)

        if not RageUI.Visible(main) and not RageUI.Visible(permission) then
            main = RMenu:DeleteType('main', true)
            permission = RMenu:DeleteType('permission', true)
        end
    end
end