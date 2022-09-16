--[[
    en.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 20/08/2022 - 21:05:12
]]--
---@author Dezel

LaboratoryLocales['fr'] = {


    --[[
        Builder Locales :
    --]]

    -- Notifications →
    NOTIFICATION_HAVE_NOT_ACCESS = "Vous n'avez pas accès à cette commande!",
    NOTIFICATION_BUILDER_BAD_CODE = "Le code est mauvais (Le code doit être fait que de chiffres!)",
    NOTIFICATION_FACTION_NOT_EXIST = "Le gang n'existe pas!",
    NOTIFICATION_INCOMPLETE_FIELDS = "Des champs obligatoires sont incomplets!",
    NOTIFICATION_ON_CREATE_SUCCESS = "Le laboratoire a été crée avec succès!",
    NOTIFICATION_BLACKLIST_FACTION = "Ce gang est blacklist!",
    NOTIFICATION_BLACKLIST_NAME = "Ce nom est blacklist!",

    -- Menu Details →
    MENU_BUILDER_TITLE = "Laboratoire",
    MENU_BUILDER_DESC = "Créez des laboratoires!",
    MENU_BUILDER_OPTIONAL_FIELDS = "Ce champs est optionnel",

    -- Menu Buttons →
    MENU_BUILDER_BUTTON_GANG_NAME = "Nom du gang",
    MENU_BUILDER_BUTTON_LABORATORY_NAME = "Nom du laboratoire",
    MENU_BUILDER_BUTTON_LABORATORY_TYPE = {
        MAIN = "Type du laboratoire",
        ILLEGAL_CRAFT = "Crafts illégaux",
        DRUGS_PRODUCTION = "Prod. drogues",
    },
    MENU_BUILDER_BUTTON_DRUGS_TYPE = {
        MAIN = "Type de drogue",
        METH = "Methamphétamine",
        COKE = "Cocaîne",
        WEED = "Weed"
    },
    MENU_BUILDER_BUTTON_ENTER_POSITION = "Entrée du laboratoire",
    MENU_BUILDER_BUTTON_MANAGE_PERMS = "Gestions permissions (~r~%s~s~)", -- %s = Number of grade in the faction
    MENU_BUILDER_BUTTON_CREATE_LABORATORY = "Créer le laboratoire",

    ---------------------------------------------------------------------

    --[[
        Chest Locales :
    --]]

    -- Notifications →
    NOTIFICATION_CHEST_INVALID_QTY = "~r~Quantité invalide!",
    NOTIFICATION_CHEST_SUCCESS_DEPOSIT = "Vous avez bien déposé ~g~x%s~s~ %s dans le coffre du laboratoire", -- 1st %s = The quantity, 2nd %s = Item name
    NOTIFICATION_CHEST_ERROR_LIMIT = "~r~Vous n'avez pas assez de place sur vous!",
    NOTIFICATION_CHEST_SUCCESS_WITHDRAW = "Vous avez bien retiré ~g~x%s~s~ %s dans le coffre du laboratoire", -- 1st %s = The quantity, 2nd %s = Item name


    -- Menu Details →
    MENU_CHEST_TITLE = "Coffre",
    MENU_CHEST_DESC = "Coffre du laboratoire",
    MENU_CHEST_KEYBOARD_INPUT_QUANTITY = "Quantité",

    -- Menu Buttons →
    MENU_CHEST_BUTTON_DEPOSIT_OBJECTS = "Déposer des objets",

    ---------------------------------------------------------------------

    --[[
        Computer Locales :
    --]]

    -- Notifications →
    NOTIFICATION_COMPUTER_NOT_ENOUGH_MONEY = "~r~Vous n'avez pas assez d'argent sur vous!",
    NOTIFICATION_COMPUTER_SUCCESS_DELIVER_IN_CHEST = "Les objets ont été livré dans le coffre ! (~g~%s$~s~)", -- %s = Total price
    NOTIFICATION_COMPUTER_SUCCESS_DELIVER_ON_HIM = "Vous avez reçu ~g~x%s %s ~s~pour ~g~%s$", -- 1st %s = Quantity, 2nd %s = Item Name, 3rd %s = Total price


    -- Menu Details →
    MENU_COMPUTER_TITLE = "Ordinateur",
    MENU_COMPUTER_DESC = "Ordinateur du laboratoire",

    -- Menu Buttons →
    MENU_COMPUTER_BUTTON_CONNECTED_AS = "Connecté en tant que ~r~#%s", -- %s = Code of the player
    MENU_COMPUTER_BUTTON_CONNECTION_IN_PROGRESS = "~r~Connexion en cours...",
    MENU_COMPUTER_BUTTON_DELIVER = "Livraison",
    MENU_COMPUTER_BUTTON_DELIVER_IN_CHEST = "Dans le coffre",
    MENU_COMPUTER_BUTTON_DELIVER_ON_PLAYER = "Sur vous",
    MENU_COMPUTER_BUTTON_BUY_ITEMS = "Achat de provisions",

    ---------------------------------------------------------------------

    --[[
        Craft Locales :
    --]]

    -- Notifications →
    NOTIFICATION_CRAFT_ESTABLISHED_DOESNT_HAVE_ITEMS = "~r~Vous n'avez pas les matériaux nécessaires!",
    NOTIFICATION_CRAFT_ESTABLISHED_CRAFT_SUCCESS = "Vous avez ~g~reçu ~s~%s", -- %s = Item name
    NOTIFICATION_CRAFT_SELL_ON_SELL_ITEMS = "Vous avez vendu vos items pour un total de ~g~%s$", -- %s = Price the player receive
    NOTIFICATION_CRAFT_INTERACT_WITH_CRAFT = "Appuyez sur ~INPUT_CONTEXT~ pour intéragir.";

    -- Menu Details →
    MENU_CRAFT_ESTABLISHED_TITLE = "Craft",
    MENU_CRAFT_SELL_TITLE = "Acheteur",
    MENU_CRAFT_ESTABLISHED_DESC = "Établi",
    MENU_CRAFT_SELL_DESC = "Acheteur d'objets",

    -- Menu Buttons →
    MENU_CRAFT_ESTABLISHED_BUTTON_DESC_CRAFT_INFORMATION = "Informations : ~n~~r~Duréee : ~s~%s secondes ~n~~r~Catégorie : ~s~%s", -- 1st %s = Time of the craft, 2nd %s = Category of the craft
    MENU_CRAFT_ESTABLISHED_BUTTON_DESC_CRAFT_CATEGORY_WEAPON = "Arme",
    MENU_CRAFT_ESTABLISHED_BUTTON_DESC_CRAFT_CATEGORY_ITEM = "Accessoire",
    MENU_CRAFT_ESTABLISHED_BUTTON_CRAFT_ITEM = "Craft l'item",
    MENU_CRAFT_SELL_BUTTON_SELECT_ALL = "Tout sélectionner",
    MENU_CRAFT_SELL_BUTTON_SELL = "Vendre (%s$)", -- %s = Price the player will receive

    ---------------------------------------------------------------------

    --[[
        Global Labs Locales :
    --]]

    -- Notifications →
    NOTIFICATION_LABS_EXIT = "Appuyez sur ~INPUT_CONTEXT~ pour sortir du laboratoire",
    NOTIFICATION_LABS_CHEST = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre du laboratoire",
    NOTIFICATION_LABS_COMPUTER = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir l'ordinateur",
    NOTIFICATION_ENTER_IN_LABS = "Appuyez sur ~INPUT_CONTEXT~ pour entrer dans le laboratoire",
    NOTIFICATION_DONT_HAVE_GRADE = "~r~Vous n'avez pas le grade nécessaire!",

    -- Menu Details →

    -- Menu Buttons →

    ---------------------------------------------------------------------

    --[[
        Meth Labs Locales :
    --]]

    -- Notifications →
    NOTIFICATION_LABS_METH_MACHINE_FURNACE = "Appuyez sur ~INPUT_CONTEXT~ pour intéragir la machine",
    NOTIFICATION_LABS_METH_MACHINE_TREATMENT = "Appuyez sur ~INPUT_CONTEXT~ pour intéragir la machine",
    NOTIFICATION_LABS_METH_MACHINE_GAZ = "Appuyez sur ~INPUT_CONTEXT~ pour intéragir la machine",
    NOTIFICATION_LABS_METH_MACHINE_FURNACE_WAIT_COOLDOWN = "~r~Patientez avant de faire cela!",
    NOTIFICATION_LABS_METH_MACHINE_FURNACE_WAIT_POURING = "~r~Attendez que la methylamine sur la machine soit totalement verser!",
    NOTIFICATION_LABS_METH_MACHINE_FURNACE_METHYLAMINE_STOCK_FULL = "~r~Stock de methylamine plein!",
    NOTIFICATION_LABS_METH_MACHINE_WASH = "~r~Veuillez nettoyer la machine!",
    NOTIFICATION_LABS_METH_MACHINE_FURNACE_PUT_METHYLAMINE = "~r~Veuillez mettre de la méthylamine!",
    NOTIFICATION_LABS_METH_MACHINE_FURNACE_FINISH_OTHER_MACHINE = "~r~Veuillez terminer la Meth dans les autres machines avant d'en commencer une autre!",


    -- Menu Details →

    -- Menu Buttons →

    -- Misc
    MISC_LABS_METH_MACHINE_FURNACE_TEMPERATURE_LABEL = "Température",
    MISC_LABS_METH_MACHINE_FURNACE_METHYLAMINE_LABEL = "Méthylamine",
    MISC_LABS_METH_MACHINE_FURNACE_FINISH_LABEL = "Fini",
    MISC_LABS_METH_MACHINE_FURNACE_SECONDS_LABEL = "secondes",
    MISC_LABS_METH_MACHINE_FURNACE_TIME_REMAINING_LABEL = "Temps restant :",
    MISC_LABS_METH_MACHINE_FURNACE_HEAT_LABEL = "Chauffer",
    MISC_LABS_METH_MACHINE_FURNACE_CHILL_LABEL = "Refroidir",
    MISC_LABS_METH_MACHINE_FURNACE_START_LABEL = "Refroidir",
    MISC_LABS_METH_MACHINE_FURNACE_TRANSPOSE_METH_LABEL = "Transposer la meth",
    MISC_LABS_METH_MACHINE_FURNACE_CANCEL_METH_LABEL = "Annuler",
    MISC_LABS_METH_MACHINE_FURNACE_WASH_METH_LABEL = "Nettoyer",
    MISC_LABS_METH_MACHINE_FURNACE_POURCENT_LABEL = "Pourcent : ",
    MISC_LABS_METH_MACHINE_FURNACE_NONE_METH = "Pourcent : ",
}