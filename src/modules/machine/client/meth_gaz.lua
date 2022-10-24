---@author Dezel

LaboratoryMachine.Gaz = {Components = { GazLiquid = {}}}

LaboratoryMachine.Gaz.Components.GazLiquid.IsPouring = false
LaboratoryMachine.Gaz.Components.GazLiquid.PouringCooldown = false


LaboratoryMachine.Gaz.IsOnMachine = false
LaboratoryMachine.Gaz.IsMachineStart = false
LaboratoryMachine.Gaz.Timer = { remain = LaboratoryConfig.Labs.Meth.Interaction.Machine.Gaz.Timer }
LaboratoryMachine.Gaz.Transpose = { haveTo = false, pourcent = nil }

local metadata = {
	meth = { bar = 0.0, pourcent = nil },
	wash = false,
	gaz = { bar = 0.0, state = 0 },
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
	{
		position = { x = 0.88, y = 0.9},
		height = 0.0125,
		width = "gaz",
		text = CurrentLocales.MISC_LABS_METH_MACHINE_GAZ_LABEL,
		color1 = { r = 230, g = 96, b = 73, a = 180},
		color2 = { r = 255, g = 64, b = 31, a = 180},
	},
}

function LaboratoryMachine.Gaz:drawBar(startT, endT, r, g, b)
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

	X, Y = 0.88 - correction, 0.82 - correction

	Set_2dLayer(0)
	DrawSprite('timerbars', 'all_black_bg', X, Y, 0.2, 0.0325, 0.0, 255, 255, 255, 180)

	SetTextColour(255, 255, 255, 180)
	SetTextFont(0)
	SetTextScale(0.3, 0.3)
	SetTextCentre(true)
	SetTextEntry('STRING')
	AddTextComponentString(LaboratoryMachine.Gaz.Timer.remain == 0 and CurrentLocales.MISC_LABS_METH_MACHINE_FINISH_LABEL or LaboratoryMachine.Gaz.Timer.remain..CurrentLocales.MISC_LABS_METH_MACHINE_SECONDS_LABEL)
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
	AddTextComponentString(CurrentLocales.MISC_LABS_METH_MACHINE_FURNACE_POURCENT_LABEL)
	Set_2dLayer(3)
	DrawText(X - 0.045, Y - 0.012)
end
function LaboratoryMachine.Gaz:instructionnal()

	local scaleform = RequestScaleformMovie("instructional_buttons")

	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(1)
	end

	PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
	PushScaleformMovieFunctionParameterInt(200)
	PopScaleformMovieFunctionVoid()

	if (not LaboratoryMachine.Gaz.Transpose.haveTo) then
		PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
		PushScaleformMovieFunctionParameterInt(3)
		Button(GetControlInstructionalButton(2, 288, true))
		ButtonMessage(CurrentLocales.MISC_LABS_METH_MACHINE_START_LABEL)
		PopScaleformMovieFunctionVoid()
	else
		PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
		PushScaleformMovieFunctionParameterInt(3)
		Button(GetControlInstructionalButton(2, 288, true))
		ButtonMessage(CurrentLocales.MISC_LABS_METH_MACHINE_GAZ_RECEIVE_P_LABEL)
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

LaboratoryUtils.Events:register("useItem:gaz", function()
	if (LaboratoryModules.IsInLabs) then
		if (IsEntityAtCoord(PlayerPedId(), LaboratoryConfig.Labs.Meth.Interaction.Machine.Gaz.position, 5.0, 5.0, 5.0, 0, 1, 0)) then
			if (LaboratoryMachine.Gaz.Components.GazLiquid.PouringCooldown) then
				return (ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_WAIT_COOLDOWN))
			end
			if (LaboratoryMachine.Gaz.Components.GazLiquid.IsPouring) then
				return ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_TREATMENT_WAIT_POURING)
			end
			if (metadata.gaz.state == LaboratoryConfig.Labs.Meth.Interaction.Machine.Gaz.Gaz.Number or metadata.gaz.bar == 0.08235) then
				return ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_TREATMENT_GAZ_STOCK_FULL)
			end

			LaboratoryMachine.Gaz.Components.GazLiquid.PouringCooldown = true
			Citizen.SetTimeout(1000, function()
				LaboratoryMachine.Gaz.Components.GazLiquid.PouringCooldown = false
			end)

			LaboratoryMachine.Gaz.Components.GazLiquid.IsPouring = true
			Citizen.Wait(LaboratoryConfig.Labs.Meth.Interaction.Machine.Gaz.Gaz.Time)
			metadata.gaz.state = metadata.gaz.state + 1
			metadata.gaz.bar = metadata.gaz.bar + 0.08235 / LaboratoryConfig.Labs.Meth.Interaction.Machine.Gaz.Gaz.Number
			LaboratoryUtils.Events:toServer("useGaz")
			LaboratoryMachine.Gaz.Components.GazLiquid.IsPouring = false
		end
	end
end)

function LaboratoryMachine.Gaz:LoadMetadata(data)
	metadata.meth.pourcent = data.meth.pourcent
	metadata.meth.bar = 0.08235
	local buttons = LaboratoryMachine.Gaz:instructionnal()
	DrawScaleformMovieFullscreen(buttons)
end

-- Timer thread
Citizen.CreateThread(function()
	while (true) do
		Wait(1000)
		if (LaboratoryMachine.Gaz.IsMachineStart) then
			while (LaboratoryMachine.Gaz.Timer.remain ~= 0) do
				Wait( 1000 )
				LaboratoryMachine.Gaz.Timer.remain = LaboratoryMachine.Gaz.Timer.remain - 1
			end
			LaboratoryMachine.Gaz.IsMachineStart = false
			LaboratoryMachine.Gaz.IsMachineStart = false
			LaboratoryMachine.Gaz.Transpose.haveTo = true
			LaboratoryMachine.CanGaz = false
			local buttons = LaboratoryMachine.Gaz:instructionnal()
			DrawScaleformMovieFullscreen(buttons)
			metadata.wash = true
		end
	end
end)

function LaboratoryMenu.Machine:gaz(data)
	if (LaboratoryMachine.Gaz.IsOnMachine) then
		return
	end
	LaboratoryMachine.Gaz.IsOnMachine = true
	if (LaboratoryMachine.Gaz.IsOnMachine) then
		SetEntityHeading(PlayerPedId(), LaboratoryConfig.Labs.Meth.Interaction.Machine.Gaz.onInteract.heading)
		SetEntityCoords(PlayerPedId(), LaboratoryConfig.Labs.Meth.Interaction.Machine.Gaz.onInteract.coords)
		FreezeEntityPosition(PlayerPedId(), true)
	end
	-- Graphic Thread
	Citizen.CreateThread(function()
		local buttons = LaboratoryMachine.Gaz:instructionnal()
		while (LaboratoryMachine.Gaz.IsOnMachine) do
			LaboratoryMachine.Gaz:drawBar()
			DrawScaleformMovieFullscreen(buttons)

			Citizen.Wait(0)
		end
	end)

	-- Interaction Thread
	Citizen.CreateThread(function()

		while (LaboratoryMachine.Gaz.IsOnMachine) do
			-- Begin button
			if (IsControlJustPressed(2, 288)) then
				if (not LaboratoryMachine.Gaz.Transpose.haveTo) then
					if (LaboratoryMachine.CanGaz) then
						if (metadata.wash) then
							ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_WASH)
						else
							if (metadata.gaz.state ~= LaboratoryConfig.Labs.Meth.Interaction.Machine.Gaz.Gaz.Number) then
								ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_TREATMENT_PUT_GAZ)
							else
								if (metadata.meth.pourcent) then
									LaboratoryMachine.Gaz.IsMachineStart = true
								else
									ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_PUT_METH)
								end
							end
						end
					else
						ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_FURNACE_FINISH_OTHER_MACHINE)
					end
				else
					local bag
					if (metadata.meth.pourcent < 50) then
						bag = LaboratoryConfig.Labs.Meth.Interaction.Machine.Gaz.Bag.BadPourcent
					elseif (metadata.meth.pourcent < 75) then
						bag = LaboratoryConfig.Labs.Meth.Interaction.Machine.Gaz.Bag.MidPourcent
					elseif (metadata.meth.pourcent <= 100) then
						bag = LaboratoryConfig.Labs.Meth.Interaction.Machine.Gaz.Bag.MaxPourcent
					end

					metadata.meth.pourcent = nil
					metadata.meth.bar = 0.0
					LaboratoryUtils.Events:toServer("giveMethBag", bag)
					LaboratoryMachine.Gaz.Transpose.haveTo = false
					LaboratoryMachine.CanGaz = true
					LaboratoryMachine.CanTreat = true
					LaboratoryMachine.CanFurnace = true
				end
			end

			-- Cancel button
			if (IsControlJustPressed(0, 194)) then
				LaboratoryMachine.Gaz.IsOnMachine = false
				FreezeEntityPosition(PlayerPedId(), false)
			end

			-- Wash button
			if (IsControlJustPressed(0, 22)) then
				if (metadata.wash) then
					LaboratoryMachine.Gaz.Timer.remain = 10
					metadata.wash = false
				else
					ESX.ShowNotification(CurrentLocales.NOTIFICATION_LABS_METH_MACHINE_WASH)
				end
			end

			Citizen.Wait(0)
		end
	end)
end