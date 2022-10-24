---@author Dezel

LaboratoryMachine.Treatment = {}

LaboratoryMachine.Treatment.IsOnMachine = false
LaboratoryMachine.Treatment.IsMachineStart = false
LaboratoryMachine.Treatment.Timer = { remain = LaboratoryConfig.Labs.Meth.Interaction.Machine.Treatment.Timer }
LaboratoryMachine.Treatment.Transpose = { haveTo = false, pourcent = nil }

local metadata = {
	meth = { bar = 0.0, pourcent = nil},
	wash = false
}
local bar2 = {
	{
		position = { x = 0.88, y = 0.94 },
		height = 0.0125,
		width = "meth",
		text = CurrentLocales.MISC_LABS_METH_MACHINE_METH_LABEL,
		color1 = { r = 155, g = 231, b = 145, a = 180},
		color2 = { r = 185, g = 252, b = 176, a = 180},
	},
}

function LaboratoryMachine.Treatment:drawBar(startT, endT, r, g, b)
	local correction = ((1.0 - math.round(GetSafeZoneSize(), 2)) * 100) * 0.005

	if not HasStreamedTextureDictLoaded('timerbars') then
		RequestStreamedTextureDict('timerbars')
		while not HasStreamedTextureDictLoaded('timerbars') do
			Citizen.Wait(0)
		end
	end

	for _,v in pairs(bar2) do
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

	X, Y = 0.88 - correction, 0.90 - correction

	Set_2dLayer(0)
	DrawSprite('timerbars', 'all_black_bg', X, Y, 0.2, 0.0325, 0.0, 255, 255, 255, 180)

	SetTextColour(255, 255, 255, 180)
	SetTextFont(0)
	SetTextScale(0.3, 0.3)
	SetTextCentre(true)
	SetTextEntry('STRING')
	AddTextComponentString(LaboratoryMachine.Treatment.Timer.remain == 0 and CurrentLocales.MISC_LABS_METH_MACHINE_FINISH_LABEL or LaboratoryMachine.Treatment.Timer.remain..CurrentLocales.MISC_LABS_METH_MACHINE_SECONDS_LABEL)
	Set_2dLayer(3)
	DrawText(X + 0.045, Y - 0.012)

	SetTextColour(255, 255, 255, 180)
	SetTextFont(0)
	SetTextScale(0.3, 0.3)
	SetTextCentre(true)
	SetTextEntry('STRING')
	AddTextComponentString(CurrentLocales.MISC_LABS_METH_MACHINE_TIME_REMAINING_LABEL)
	Set_2dLayer(3)
	DrawText(X - 0.045, Y - 0.012)

	X, Y = 0.88 - correction, 0.86 - correction

	Set_2dLayer(0)
	DrawSprite('timerbars', 'all_black_bg', X, Y, 0.2, 0.0325, 0.0, 255, 255, 255, 180)

	SetTextColour(255, 255, 255, 180)
	SetTextFont(0)
	SetTextScale(0.3, 0.3)
	SetTextCentre(true)
	SetTextEntry('STRING')
	AddTextComponentString(not metadata.meth.pourcent and CurrentLocales.MISC_LABS_METH_MACHINE_NONE_METH or metadata.meth.pourcent.."%")
	Set_2dLayer(3)
	DrawText(X + 0.045, Y - 0.012)

	SetTextColour(255, 255, 255, 180)
	SetTextFont(0)
	SetTextScale(0.3, 0.3)
	SetTextCentre(true)
	SetTextEntry('STRING')
	AddTextComponentString(CurrentLocales.MISC_LABS_METH_MACHINE_POURCENT_LABEL)
	Set_2dLayer(3)
	DrawText(X - 0.045, Y - 0.012)
end
function LaboratoryMachine.Treatment:instructionnal()

	local scaleform = RequestScaleformMovie("instructional_buttons")

	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(1)
	end

	PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
	PushScaleformMovieFunctionParameterInt(200)
	PopScaleformMovieFunctionVoid()

	if (not LaboratoryMachine.Treatment.Transpose.haveTo) then
		PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
		PushScaleformMovieFunctionParameterInt(3)
		Button(GetControlInstructionalButton(2, 288, true))
		ButtonMessage(CurrentLocales.MISC_LABS_METH_MACHINE_START_LABEL)
		PopScaleformMovieFunctionVoid()
	else
		PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
		PushScaleformMovieFunctionParameterInt(3)
		Button(GetControlInstructionalButton(2, 288, true))
		ButtonMessage(CurrentLocales.MISC_LABS_METH_MACHINE_TRANSPOSE_METH_LABEL)
		PopScaleformMovieFunctionVoid()
	end

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(2)
	Button(GetControlInstructionalButton(0, 194, true))
	ButtonMessage(CurrentLocales.MISC_LABS_METH_MACHINE_CANCEL_METH_LABEL)
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(1)
	Button(GetControlInstructionalButton(0, 22, true))
	ButtonMessage(CurrentLocales.MISC_LABS_METH_MACHINE_WASH_METH_LABEL)
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
function LaboratoryMachine.Treatment.LoadMetadata(data, pourcent)
	metadata.meth.pourcent = pourcent
	metadata.meth.bar = 0.08235
	local buttons = LaboratoryMachine.Treatment:instructionnal()
	DrawScaleformMovieFullscreen(buttons)
end

-- Timer thread
Citizen.CreateThread(function()
	while (true) do
		Wait(1000)
		if (LaboratoryMachine.Treatment.IsMachineStart) then
			while (LaboratoryMachine.Treatment.Timer.remain ~= 0) do
				Wait( 1000 )
				LaboratoryMachine.Treatment.Timer.remain = LaboratoryMachine.Treatment.Timer.remain - 1
			end
			metadata.wash = true
			LaboratoryMachine.Treatment.IsMachineStart = false
			LaboratoryMachine.Treatment.Transpose.haveTo = true
			LaboratoryMachine.Treatment.Transpose.pourcent = metadata.meth.pourcent
			local buttons = LaboratoryMachine.Treatment:instructionnal()
			DrawScaleformMovieFullscreen(buttons)
		end
	end
end)

function LaboratoryMenu.Machine:treatment(data)
	if (LaboratoryMachine.Treatment.IsOnMachine) then
		return
	end
	LaboratoryMachine.Treatment.IsOnMachine = true
	if (LaboratoryMachine.Treatment.IsOnMachine) then
		SetEntityHeading(PlayerPedId(), LaboratoryConfig.Labs.Meth.Interaction.Machine.Treatment.onInteract.heading)
		SetEntityCoords(PlayerPedId(), LaboratoryConfig.Labs.Meth.Interaction.Machine.Treatment.onInteract.coords)
		FreezeEntityPosition(PlayerPedId(), true)
	end
	-- Graphic Thread
	Citizen.CreateThread(function()
		local buttons = LaboratoryMachine.Treatment:instructionnal()
		while (LaboratoryMachine.Treatment.IsOnMachine) do
			LaboratoryMachine.Treatment:drawBar()
			DrawScaleformMovieFullscreen(buttons)

			Citizen.Wait(0)
		end
	end)

	-- Interaction Thread
	Citizen.CreateThread(function()

		while (LaboratoryMachine.Treatment.IsOnMachine) do
			-- Begin button
			if (IsControlJustPressed(2, 288)) then
				if (not LaboratoryMachine.Treatment.Transpose.haveTo) then
					if (LaboratoryMachine.CanTreat) then
						if (metadata.wash) then
							ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_WASH)
						else
							if (not metadata.meth.pourcent) then
								ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_PUT_METH)
							else
								TriggerEvent("InteractSound_CL:PlayWithinDistance", LaboratoryConfig.Labs.Meth.Interaction.Machine.Treatment.position, 2.5, "furnace", 0.5)
								LaboratoryMachine.Treatment.IsMachineStart = true
							end
						end
					end
				else
					LaboratoryMachine.Gaz:LoadMetadata(metadata)
					LaboratoryMachine.Treatment.Transpose.haveTo = false
					LaboratoryMachine.CanTreat = false
					metadata.meth.pourcent = nil
					metadata.meth.bar = 0.0
				end
			end

			-- Cancel button
			if (IsControlJustPressed(0, 194)) then
				LaboratoryMachine.Treatment.IsOnMachine = false
				FreezeEntityPosition(PlayerPedId(), false)
			end

			-- Wash button
			if (IsControlJustPressed(0, 22)) then
				if (metadata.wash) then
					LaboratoryMachine.Treatment.Timer.remain = 180
					metadata.wash = false
				end
			end

			Citizen.Wait(0)
		end
	end)
end