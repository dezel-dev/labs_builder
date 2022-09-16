--[[
    peds.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 26/08/2022 - 12:18:47
]]--
---@author Dezel

LaboratoryConfig.Peds = {}

LaboratoryConfig.Peds.Seller = {
	Illegal_Craft = {
		Delay = 300000,
		Generic = {
			model = "...",
			Position = { coords = vector3(-215.81, -919.87, 28.29), heading = 0.0 },
		},
		Price = {
			{
				category = "weapon",
				name = "weapon_pistol",
				label = "Pistolet",
				price = 3200,
			},
			{
				category = "item",
				name = "hand_pistol",
				price = 730
			}
		}
	}
}