---@author Dezel

LaboratoryConfig.Labs = {}


--[[
	Main => Exit/Enter interaction
]]--
LaboratoryConfig.Labs.Illegal_Craft = {
	Main = { position = vector3(992.32, -3097.78, -39.99), heading = 264.47},
	Interaction = {
		Exit = {
			position = vector3(992.32, -3097.78, -39.99),
			Blips = {
				id = 255,
				scale = 0.9,
				color = 5,
				alpha = 255,
				name = "Laboratoire | Sortie"
			},
		},
		Chest = {
			position = vector3(995.07, -3096.31, -39.99),
			Blips = {
				id = 587,
				scale = 0.7,
				color = 17,
				alpha = 255,
				name = "Laboratoire | Coffre"
			},
		},
		Computer = {
			position = vector3(994.62, -3099.92, -39.99),
			Blips = {
				id = 521,
				scale = 0.8,
				color = 3,
				alpha = 255,
				name = "Laboratoire | Ordinateur"
			},
		},
		Craft = {
			position = vector3(1026.89, -3101.45, -39.99),
			Blips = {
				id = 566,
				scale = 0.8,
				color = 1,
				alpha = 255,
				name = "Laboratoire | Établi"
			},
		}
	},
	BasicRessources = {
		{
			name = "wood",
			label = "Bois",
			price = 5,
		},
		{
			name = "metal",
			label = "Métal",
			price = 100,
		},
		{
			name = "iron",
			label = "Fer",
			price = 200
		},
		{
			name = "gunpowder",
			label = "Poudre à canon",
			price = 25
		},
	},
	Machine = {
		props_model = "bkr_prop_fakeid_papercutter",
		position = { coords = vector3(1027.78, -3101.38, -39.99), heading=90.70},
	},
	Craft = {
		{
			Category = "item",
			Material = {
				{ item_name = "wood", item_label = "Bois", amount = 10 },
				{ item_name = "iron", item_label = "Fer", amount = 2 },
			},
			Item = { name = "hand_pistol", label = "Poignet de pistolet"},
			craft_duration = 5000
		},
		{
			Category = "item",
			Material = {
				{ item_name = "metal", item_label = "Métal", amount = 5 },
			},
			Item = { name = "magazine_pistol", label = "Chargeur de pistolet" },
			craft_duration = 2500
		},
		{
			Category = "weapon",
			Material = {
				{ item_name = "magazine_pistol", item_label = "Chargeur de pistolet", amount = 1 },
				{ item_name = "hand_pistol", item_label = "Poignet de pistolet", amount = 1 },
				{ item_name = "iron", item_label = "Fer", amount = 10 },
				{ item_name = "gunpowder", item_label = "Poudre à canon", amount = 5 },
			},
			Item = { name = "weapon_pistol", label = "Pistolet" },
			craft_duration = 15000
		},
	}
}
LaboratoryConfig.Labs.Meth = {
	Main = { position = vector3(996.85, -3200.83, -37.39), heading = 270.0},
	Interaction = {
		Exit = {
			position = vector3(996.85, -3200.83, -37.39),
			Blips = {
				id = 255,
				scale = 0.9,
				color = 5,
				alpha = 255,
				name = "Laboratoire | Sortie"
			}
		},
		Chest = {
			position = vector3(997.79, -3200.40, -39.99),
			Blips = {
				id = 587,
				scale = 0.7,
				color = 17,
				alpha = 255,
				name = "Laboratoire | Coffre"
			}
		},
		Computer = {
			position = vector3(1001.91, -3194.92, -39.99),
			Blips = {
				id = 521,
				scale = 0.8,
				color = 3,
				alpha = 255,
				name = "Laboratoire | Ordinateur"
			}
		},
		Machine = {
			Furnace = {
				position = vector3(1002.58, -3198.83, -39.99),
				Blips = {
					id = 271,
					scale = 0.5,
					color = 5,
					alpha = 255,
					name = "Laboratoire | Four"
				},
				onInteract = { heading = 71.02, coords = vector3(1002.13, -3198.93, -39.99)},
				BasicPourcent = 80,
				Timer = 180
			},
			Treatment = {
				position = vector3(1005.81, -3200.38, -39.51),
				Blips = {
					id = 271,
					scale = 0.5,
					color = 5,
					alpha = 255,
					name = "Laboratoire | Traitement"
				},
				onInteract = { heading = 170.00, coords = vector3(1005.81, -3200.38, -39.51)}
			},
			Gaz = {
				position = vector3(1010.27, -3199.86, -39.99),
				Blips = {
					id = 271,
					scale = 0.5,
					color = 5,
					alpha = 255,
					name = "Laboratoire | Gaz"
				},
				onInteract = { heading = 0.0, coords = vector3(1010.27, -3199.86, -39.99)},
				Timer = 120
			},
		}
	}
}
LaboratoryConfig.Labs.Weed = {
	Main = { position = vector3(1066.37, -3183.52, -40.16), heading = 90.0},
	Objects = {
		Pot = {
			MainModel = "bkr_prop_weed_01_small_01c",
			Step = {
				"bkr_prop_weed_01_small_01b",
				"bkr_prop_weed_med_01a",
				"bkr_prop_weed_med_01b",
				"bkr_prop_weed_lrg_01a",
				"bkr_prop_weed_lrg_01b"
			}
		},
		Battery = {
			Model = "prop_battery_02"
		},
		Fan = {
			Model = "bkr_prop_weed_fan_floor_01a"
		},
		Light = {
			Model = "prop_worklight_01a"
		},
	},
	Interaction = {
		Exit = {
			position = vector3(1066.37, -3183.52, -40.16),
			Blips = {
				id = 255,
				scale = 0.9,
				color = 5,
				alpha = 255,
				name = "Laboratoire | Sortie"
			}
		},
		Chest = {
			position = vector3(1042.48, -3206.02, -38.84),
			Blips = {
				id = 587,
				scale = 0.7,
				color = 17,
				alpha = 255,
				name = "Laboratoire | Coffre"
			}
		},
		Computer = {
			position = vector3(1044.38, -3194.89, -39.15),
			Blips = {
				id = 521,
				scale = 0.8,
				color = 3,
				alpha = 255,
				name = "Laboratoire | Ordinateur"
			}
		}
	}
}

LaboratoryConfig.Labs.Chest = {

}