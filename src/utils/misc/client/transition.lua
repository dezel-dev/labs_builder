---@author Dezel

function LaboratoryUtils.Misc:transition(time, func)
	DoScreenFadeOut(time)
	Wait(time)
	func()
	DoScreenFadeIn(time)
end