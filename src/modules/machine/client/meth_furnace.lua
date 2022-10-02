---@author Dezel

LaboratoryMachine.Furnace = { Components = { Methylamine = {} } }
LaboratoryMachine.Furnace.Components.Methylamine.IsPouring = false
LaboratoryMachine.Furnace.Components.Methylamine.PouringCooldown = false

LaboratoryMachine.Furnace.IsOnMachine = false
LaboratoryMachine.Furnace.IsMachineStart = false
LaboratoryMachine.Furnace.Timer = { remain = LaboratoryConfig.Labs.Meth.Interaction.Machine.Furnace.Timer }
LaboratoryMachine.Furnace.Transpose = { haveTo = false, pourcent = nil }

local metadata = {
	temperature = { bar = 0.0, mode = "hot", state = "bad" },
	methylamine = { bar = 0.0, state = 0 },
	wash = false,
	pourcent = LaboratoryConfig.Labs.Meth.Interaction.Machine.Furnace.BasicPourcent
}
local bar = {
	{
		position = { x = 0.88, y = 0.94 },
		height = 0.0125,
		width = "temperature",
		text = CurrentLocales.MISC_LABS_METH_MACHINE_FURNACE_TEMPERATURE_LABEL,
		color1 = { r = 217, g = 204, b = 0, a = 180},
		color2 = { r = 213, g = 178, b = 0, a = 180},
	},
	{
		position = { x = 0.88, y = 0.9},
		height = 0.0125,
		width = "methylamine",
		text = CurrentLocales.MISC_LABS_METH_MACHINE_FURNACE_METHYLAMINE_LABEL,
		color1 = { r = 91, g = 0, b = 161, a = 180},
		color2 = { r = 143, g = 0, b = 255, a = 180},
	},
}

-- MAX = 0.08235
LaboratoryUtils.Events:register("useItem:methylamine", function()
	if (LaboratoryModules.IsInLabs) then
		if (IsEntityAtCoord(PlayerPedId(), LaboratoryConfig.Labs.Meth.Interaction.Machine.Furnace.position, 5.0, 5.0, 5.0, 0, 1, 0)) then
			if (LaboratoryMachine.Furnace.Components.Methylamine.PouringCooldown) then
				return (ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_FURNACE_WAIT))
			end
			if (LaboratoryMachine.Furnace.Components.Methylamine.IsPouring) then
				return ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_FURNACE_WAIT_POURING)
			end
			if (metadata.methylamine.state == 3 or metadata.methylamine.bar == 0.08235) then
				return ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_FURNACE_METHYLAMINE_STOCK_FULL)
			end

			LaboratoryMachine.Furnace.Components.Methylamine.PouringCooldown = true
			Citizen.SetTimeout(1000, function()
				LaboratoryMachine.Furnace.Components.Methylamine.PouringCooldown = false
			end)

			LaboratoryMachine.Furnace.Components.Methylamine.IsPouring = true
			TriggerEvent("InteractSound_CL:PlayOnOne", "methylamine", 0.5)
			Citizen.Wait(2230)
			metadata.methylamine.state = metadata.methylamine.state + 1
			metadata.methylamine.bar = metadata.methylamine.bar + 0.02745
			LaboratoryUtils.Events:toServer("useMethylamine")
			LaboratoryMachine.Furnace.Components.Methylamine.IsPouring = false
		end
	end
end)

function ButtonMessage(text)
	BeginTextCommandScaleformString("STRING")
	AddTextComponentScaleform(text)
	EndTextCommandScaleformString()
end
function Button(ControlButton)
	N_0xe83a3e3557a56640(ControlButton)
end

function LaboratoryMachine.Furnace:drawBar(startT, endT, r, g, b)
	local correction = ((1.0 - math.round(GetSafeZoneSize(), 2)) * 100) * 0.005

	if not HasStreamedTextureDictLoaded('timerbars') then
		RequestStreamedTextureDict('timerbars')
		while not HasStreamedTextureDictLoaded('timerbars') do
			Citizen.Wait(0)
		end
	end


	for _,v in pairs(bar) do
		W = metadata[v.width].bar
		X, Y = v.position.x - correction, v.position.y - correction

		Set_2dLayer(0)
		DrawSprite('timerbars', 'all_black_bg', X, Y, 0.2, 0.0325, 0.0, 255, 255, 255, 180)

		Set_2dLayer(1)
		DrawRect(X + 0.035, Y, 0.085, 0.0125, v.color1.r, v.color1.g, v.color1.b, v.color1.a)

		Set_2dLayer(2)
		DrawRect(X - 0.02 + (W / 2) + 0.0135, Y, W, v.height - 0.003, v.color2.r, v.color2.g, v.color2.b, v.color2.a)

		SetTextColour(255, 255, 255, 180)
		SetTextFont(0)
		SetTextScale(0.3, 0.3)
		SetTextCentre(true)
		SetTextEntry('STRING')
		AddTextComponentString(v.text)
		Set_2dLayer(3)
		DrawText(X - 0.045, Y - 0.012)
	end

	X, Y = 0.88 - correction, 0.86 - correction

	Set_2dLayer(0)
	DrawSprite('timerbars', 'all_black_bg', X, Y, 0.2, 0.0325, 0.0, 255, 255, 255, 180)

	SetTextColour(255, 255, 255, 180)
	SetTextFont(0)
	SetTextScale(0.3, 0.3)
	SetTextCentre(true)
	SetTextEntry('STRING')
	AddTextComponentString(LaboratoryMachine.Furnace.Timer.remain == 0 and CurrentLocales.MISC_LABS_METH_MACHINE_FURNACE_FINISH_LABEL or LaboratoryMachine.Furnace.Timer.remain.." "..CurrentLocales.MISC_LABS_METH_MACHINE_FURNACE_SECONDS_LABEL)
	Set_2dLayer(3)
	DrawText(X + 0.045, Y - 0.012)

	SetTextColour(255, 255, 255, 180)
	SetTextFont(0)
	SetTextScale(0.3, 0.3)
	SetTextCentre(true)
	SetTextEntry('STRING')
	AddTextComponentString(CurrentLocales.MISC_LABS_METH_MACHINE_FURNACE_TIME_REMAINING_LABEL)
	Set_2dLayer(3)
	DrawText(X - 0.045, Y - 0.012)
end
function LaboratoryMachine.Furnace:instructionnal()

	local scaleform = RequestScaleformMovie("instructional_buttons")

	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(1)
	end

	PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
	PushScaleformMovieFunctionParameterInt(200)
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(4)
	Button(GetControlInstructionalButton(0, 190, true))
	ButtonMessage(CurrentLocales.MISC_LABS_METH_MACHINE_FURNACE_HEAT_LABEL)
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(3)
	Button(GetControlInstructionalButton(0, 189, true))
	ButtonMessage(CurrentLocales.MISC_LABS_METH_MACHINE_FURNACE_CHILL_LABEL)
	PopScaleformMovieFunctionVoid()

	if (not LaboratoryMachine.Furnace.Transpose.haveTo) then
		PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
		PushScaleformMovieFunctionParameterInt(5)
		Button(GetControlInstructionalButton(2, 288, true))
		ButtonMessage(CurrentLocales.MISC_LABS_METH_MACHINE_FURNACE_START_LABEL)
		PopScaleformMovieFunctionVoid()
	else
		PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
		PushScaleformMovieFunctionParameterInt(5)
		Button(GetControlInstructionalButton(2, 288, true))
		ButtonMessage(CurrentLocales.MISC_LABS_METH_MACHINE_FURNACE_TRANSPOSE_METH_LABEL)
		PopScaleformMovieFunctionVoid()
	end

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(2)
	Button(GetControlInstructionalButton(0, 194, true))
	ButtonMessage(CurrentLocales.MISC_LABS_METH_MACHINE_FURNACE_CANCEL_METH_LABEL)
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(1)
	Button(GetControlInstructionalButton(0, 22, true))
	ButtonMessage(CurrentLocales.MISC_LABS_METH_MACHINE_FURNACE_WASH_METH_LABEL)
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(80)
	PopScaleformMovieFunctionVoid()

	return scaleform
end

-- Timer thread
Citizen.CreateThread(function()
	while (true) do
		Wait(1000)
		if (LaboratoryMachine.Furnace.IsMachineStart) then
			while (LaboratoryMachine.Furnace.Timer.remain ~= 0) do
				Wait( 1000 )
				LaboratoryMachine.Furnace.Timer.remain = LaboratoryMachine.Furnace.Timer.remain - 1
			end
			metadata.wash = true
			LaboratoryMachine.Furnace.IsMachineStart = false
			TriggerEvent("InteractSound_CL:PlayOnOne", "finish_sound_effect", 0.5)
			LaboratoryMachine.Furnace.Transpose.haveTo = true
			LaboratoryMachine.Furnace.Transpose.pourcent = metadata.pourcent
			local buttons = LaboratoryMachine.Furnace:instructionnal()
			DrawScaleformMovieFullscreen(buttons)
			metadata.methylamine.state = 0
			metadata.methylamine.bar = 0.0
			metadata.temperature.bar = 0.0
			metadata.pourcent = LaboratoryConfig.Labs.Meth.Interaction.Machine.Furnace.BasicPourcent
		end
	end
end)
-- Hot/Cold Thread
Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		if (LaboratoryMachine.Furnace.IsMachineStart) then
			interval = 1
			while (metadata.temperature.mode == "hot" and LaboratoryMachine.Furnace.IsMachineStart) do
				metadata.temperature.bar = metadata.temperature.bar + 0.00125
				Wait(500)
			end
			while (metadata.temperature.mode == "cold" and LaboratoryMachine.Furnace.IsMachineStart) do
				metadata.temperature.bar = metadata.temperature.bar - 0.00125
				Wait(500)
			end
		end
		Wait(interval)
	end
end)
Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		if (LaboratoryMachine.Furnace.IsMachineStart) then
			interval = 1
			if (metadata.temperature.bar < 0.02) then
				metadata.temperature.state = "bad"
			end
			if (metadata.temperature.bar > 0.075) then
				metadata.temperature.state = "bad"
			end
			if (metadata.temperature.bar < 0.075) and (metadata.temperature.bar > 0.02) then
				metadata.temperature.state = "good"
			end
		end
		Wait(interval)
	end
end)
-- Pourcent Thread
Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		if (LaboratoryMachine.Furnace.IsMachineStart) then
			interval = 1
			while (metadata.temperature.state == "good" and LaboratoryMachine.Furnace.IsMachineStart) do
				metadata.pourcent = metadata.pourcent+2
				Wait(500)
			end
			while (metadata.temperature.state == "bad" and LaboratoryMachine.Furnace.IsMachineStart) do
				metadata.pourcent = metadata.pourcent-1
				Wait(500)
			end
		end
		Wait(interval)
	end
end)

function LaboratoryMenu.Machine:furnace(data)
	if (LaboratoryMachine.Furnace.IsOnMachine) then
		return
	end
	LaboratoryMachine.Furnace.IsOnMachine = true
	if (LaboratoryMachine.Furnace.IsOnMachine) then
		SetEntityHeading(PlayerPedId(), LaboratoryConfig.Labs.Meth.Interaction.Machine.Furnace.onInteract.heading)
		SetEntityCoords(PlayerPedId(), LaboratoryConfig.Labs.Meth.Interaction.Machine.Furnace.onInteract.coords)
		FreezeEntityPosition(PlayerPedId(), true)
	end
	-- Graphic Thread
	Citizen.CreateThread(function()
		local buttons = LaboratoryMachine.Furnace:instructionnal()
		while (LaboratoryMachine.Furnace.IsOnMachine) do
			LaboratoryMachine.Furnace:drawBar()
			DrawScaleformMovieFullscreen(buttons)

			Citizen.Wait(0)
		end
	end)

	-- Interaction Thread
	Citizen.CreateThread(function()

		while (LaboratoryMachine.Furnace.IsOnMachine) do
			-- Begin button
			if (IsControlJustPressed(2, 288)) then

				if (not LaboratoryMachine.Furnace.Transpose.haveTo) then
					if (LaboratoryMachine.CanFurnace) then
						if (metadata.wash) then
							ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_WASH)
						else
							if (metadata.methylamine.state ~= 3) then
								ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_PUT_METHYLAMINE)
							else
								TriggerEvent("InteractSound_CL:PlayWithinDistance", LaboratoryConfig.Labs.Meth.Interaction.Machine.Furnace.position, 2.5, "furnace", 0.5)
								LaboratoryMachine.Furnace.IsMachineStart = true
							end
						end
					else
						ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_FURNACE_FINISH_OTHER_MACHINE)
					end
				else
					LaboratoryMachine.Treatment.LoadMetadata(metadata)
					local buttons = LaboratoryMachine.Furnace:instructionnal()
					DrawScaleformMovieFullscreen(buttons)
					LaboratoryMachine.Furnace.Transpose.haveTo = false
					LaboratoryMachine.CanFurnace = false
				end
			end

			-- Cancel button
			if (IsControlJustPressed(0, 194)) then
				LaboratoryMachine.Furnace.IsOnMachine = false
				FreezeEntityPosition(PlayerPedId(), false)
			end

			-- Wash button
			if (IsControlJustPressed(0, 22)) then
				if (metadata.wash) then
					LaboratoryMachine.Furnace.Timer.remain = LaboratoryConfig.Labs.Meth.Interaction.Machine.Furnace.Timer
					metadata.wash = false
				else
					--ESX.ShowNotification("~r~Vous n'avez pas a nettoyé la machine!")
				end
			end

			-- Hot button
			if (IsControlJustPressed(0, 190)) then
				if (metadata.temperature.mode == "cold") then
					metadata.temperature.mode = "hot"
				end
			end

			-- Cold button
			if (IsControlJustPressed(0, 189)) then
				if (metadata.temperature.mode == "hot") then
					metadata.temperature.mode = "cold"
				end
			end

			Citizen.Wait(0)
		end
	end)
end
FreezeEntityPosition(PlayerPedId(), false)