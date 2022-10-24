---@author Dezel

LaboratoryConfig.Labs = {}


--[[
	Main => Exit/Enter interaction
]]--
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
			},
			Resources = {
				{
					name = "methylamine",
					label = "Méthylamine",
					price = 25
				},
				{
					name = "gaz",
					label = "Gaz",
					price = 25
				},
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
				Timer = 15,
				Methylamine = {
					Time = 2000, -- 2 seconds
					Number = 1
				},
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
				onInteract = { heading = 170.00, coords = vector3(1005.81, -3200.38, -39.51)},
				Timer = 200,
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
				Timer = 120,
				Gaz = {
					Time = 3000, -- 2 seconds
					Number = 1
				},
				Bag = {
					BadPourcent = 2,
					MidPourcent = 5,
					MaxPourcent = 8
				}
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
			},
			MaxStep = 5
		},
		Battery = {
			Model = "prop_battery_02",
		},
		Fan = {
			Model = "bkr_prop_weed_fan_floor_01a"
		},
		Light = {
			Model = "prop_worklight_01a"
		},
	},
	WaterTime = 300,
	ChangeStepTime = 30,
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
			},
			Resources = {
				{
					name = "battery",
					label = "Batterie",
					price = 50
				},
				{
					name = "water_canister",
					label = "Bidon d'eau",
					price = 25
				},
				{
					name = "weed_fan",
					label = "Ventilateur",
					price = 150
				},
				{
					name = "weed_light",
					label = "Lampe",
					price = 60
				},
				{
					name = "weed_plant",
					label = "Plante de weed",
					price = 2
				},
				{
					name = "weed_pot",
					label = "Pot de weed",
					price = 40
				},
			}
		}
	}
}