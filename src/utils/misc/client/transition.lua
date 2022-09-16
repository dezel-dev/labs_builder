--[[
    transition.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 23/08/2022 - 13:30:59
]]--
---@author Dezel

function LaboratoryUtils.Misc:transition(time, func)
	DoScreenFadeOut(time)
	Wait(time)
	func()
	DoScreenFadeIn(time)
end