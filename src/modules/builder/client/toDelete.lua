--[[
    toDelete.lua is owned by Dezel (c).  
    Do not take ownership of this file 
    without permission from the developers.

    Create at 23/08/2022 - 13:42:09
]]--
---@author Dezel

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	if(outline)then
		SetTextOutline()
	end
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width/2, y - height/2 + 0.005)
end

CreateThread(function()
	while (true) do
		SetTextFont(0) -- 0-4
		SetTextScale(0.4, 0.4) -- Size of text
		SetTextColour(255, 255, 255, 255) -- RGBA
		SetTextEntry("STRING")
		AddTextComponentString("~y~X : ~b~"..GetEntityCoords(PlayerPedId()).x) -- Main Text string
		DrawText( 0.75, 0.41) -- x,y of the screen

		SetTextFont(0) -- 0-4
		SetTextScale(0.4, 0.4) -- Size of text
		SetTextColour(255, 255, 255, 255) -- RGBA
		SetTextEntry("STRING")
		AddTextComponentString("~y~Y : ~b~"..GetEntityCoords(PlayerPedId()).y) -- Main Text string
		DrawText( 0.75, 0.44) -- x,y of the screen

		SetTextFont(0) -- 0-4
		SetTextScale(0.4, 0.4) -- Size of text
		SetTextColour(255, 255, 255, 255) -- RGBA
		SetTextEntry("STRING")
		AddTextComponentString("~y~Z : ~b~"..GetEntityCoords(PlayerPedId()).z) -- Main Text string
		DrawText( 0.75, 0.47) -- x,y of the screen

		SetTextFont(0) -- 0-4
		SetTextScale(0.4, 0.4) -- Size of text
		SetTextColour(255, 255, 255, 255) -- RGBA
		SetTextEntry("STRING")
		AddTextComponentString("~y~Heading : ~b~"..GetEntityHeading(PlayerPedId())) -- Main Text string
		DrawText( 0.75, 0.50) -- x,y of the screen

		Wait(0)
	end
end)