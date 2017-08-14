-- COPYRIGHT: KISELEV NIKOLAY
-- Licence: MIT
-- Bexolder
-- Version: 0.0.1.4

fur = {w = 1500, h = 750}
turnin = {0, 0}
if musicplay == nil then musicplay = true end

Source = love.audio.newSource("mus/PACEFULL_NIGHT.mp3", "static")
if musicplay then
	love.audio.play(Source)
else
	love.audio.stop(Source)
end

function love.arch(readyarch)
	if readyarch == nil then
		arch = {}
		arch[2] = love.draw
		love.draw = nil
		arch[6] = love.keypressed
		love.keypressed = nil
		arch[7] = love.keyreleased
		love.keyreleased = nil
		arch[10] = love.mousefocus
		love.mousefocus = nil
		arch[11] = love.mousemoved
		love.mousemoved = nil
		arch[12] = love.mousepressed
		love.mousepressed = nil
		arch[13] = love.mousereleased
		love.mousereleased = nil
		arch[14] = love.quit
		love.quit = nil
		arch[17] = love.textedited
		love.textedited = nil
		arch[18] = love.textinput
		love.textinput = nil
		arch[23] = love.update
		love.update = nil
		arch[25] = love.wheelmove
		love.wheelmove = nil
		return arch
	else
		love.draw = readyarch[2]
		love.keypressed = readyarch[6]
		love.keyreleased = readyarch[7]
		love.load = readyarch[8]
		love.mousefocus = readyarch[10]
		love.mousemoved = readyarch[11]
		love.mousepressed = readyarch[12]
		love.mousereleased = readyarch[13]
		love.quit = readyarch[14]
		love.textedited = readyarch[17]
		love.textinput = readyarch[18]
		love.update = readyarch[23]
		love.wheelmove = readyarch[25]
	end
end

function fixmou(x, y)
	local w, h = love.window.getMode()
	local nx = (x - (fortouch[1] * s)) / (fur.w * s)
	local ny = (y - (fortouch[2] * s)) / (fur.h * s)
	if nx >= 0 and nx <= 1 and ny >= 0 and ny <= 1 then
		return nx, ny
	else
		return 2, 2
	end
end

function hc(hex)
	hex = hex:gsub("#","")
	return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

function fit()
	local w, h = love.window.getMode()
	if w / fur.w < h / fur.h then
		s = w / fur.w
		t = {0, (h / s - fur.h) / 2}
	else
		s = h / fur.h
		t = {(w / s - fur.w) / 2, 0}
	end
	do --MESH
		backimg = love.graphics.newImage("bg.bmp")
		backimg:setWrap("repeat")
		backimg:setFilter("nearest")
		local w, h = love.window.getMode()
		local iw, ih = backimg:getDimensions()
		iw = (iw / s) * 3
		ih = (ih / s) * 3
		if w / fur.w < h / fur.h then
			side = t[2]
			fortouch = {0, side}
			meshp = {x1 = 0, y1 = -side, x2 = 0, y2 = fur.h}
			vertices = {
			{ -- top-left
				0, 0,
				0, 0,
				255, 255, 255},
			{ -- top-right
				fur.w, 0,
				fur.w / iw, 0,
				255, 255, 255},
			{ -- bottom-right
				fur.w, side,
				fur.w / iw, side / ih,
				255, 255, 255},
			{ -- bottom-left
				0, side,
				0, side / ih,
				255, 255, 255}
			}
		else
			side = t[1]
			fortouch = {side, 0}
			meshp = {x1 = -side, y1 = 0, x2 = fur.w, y2 = 0}
			vertices = {
			{ -- top-left
				0, 0,
				0, 0,
				255, 255, 255},
			{ -- top-right
				side, 0,
				side / iw, 0,
				255, 255, 255},
			{ -- bottom-right
				side, fur.h,
				side / iw, fur.h / ih,
				255, 255, 255},
			{ -- bottom-left
				0, fur.h,
				0, fur.h / ih,
				255, 255, 255}
			}
		end
		mesh = love.graphics.newMesh(vertices, "fan")
		mesh:setTexture(backimg)
		end
end

function love.graphics.paradraw(im, x, y, z)
	love.graphics.draw(im, x + turnin[1] * (z / 10), y + turnin[2] * (z / 10), 0, 1, 1, im:getWidth() / 2, im:getHeight() / 2)
end

love.window.setMode(2, 1, {fullscreen = true})
love.window.setTitle("Bexolder")
logo = love.graphics.newImage("lg.png")
love.window.setIcon(logo:getData())
fit()

love.graphics.setDefaultFilter("linear")
love.graphics.setBackgroundColor(hc("#000000"))
love.arch()
menc = {{hc("#8c9880")}, {hc("#8c9880")}, {hc("#8c9880")}}
if love.filesystem.exists("main.ttf") then
	aqua = {
		love.graphics.newFont("main.ttf", 170),
		love.graphics.newFont("main.ttf", 170 * 0.75),
		love.graphics.newFont("main.ttf", 170 * 0.5),
		love.graphics.newFont("main.ttf", 170 * 0.4),
		love.graphics.newFont("main.ttf", 40)
	}
end

mn = love.graphics.newImage("img/mn.png")
cl = love.graphics.newImage("img/cl.png")
fr = love.graphics.newImage("img/fr.png")
hm = love.graphics.newImage("img/hm.png")

function love.keypressed(key)
	if key == "3" then
		love.window.setMode(2, 1, {borderless = true, fullscreen = true})
		fit()
	elseif key == "5" then
		love.window.setMode(300, 300, {borderless = false, fullscreen = false})
		fit()
	elseif key == "4" then
		love.window.setMode(600, 300, {borderless = true, fullscreen = false})
		fit()
	elseif key == "escape" then
		pause()
	end
end

function love.mousepressed(x, y)
	x, y = fixmou(x, y)
	if x > 0.02 and x < 0.235 and y > 0.3 and y < 0.55 then
		ostart()
	elseif x > 0.02 and x < 0.15 and y > 0.55 and y < 0.7 then
		oelse()
	elseif x > 0.02 and x < 0.13 and y > 0.8 and y < 0.95 then
		oexit()
	end
end

function love.update(dt)
	x, y = fixmou(love.mouse.getX(), love.mouse.getY())
	if x ~= 2 and y ~= 2 then
		turnin = {(x - 0.5) * 15, (y - 0.5) * 10}
		if x > 0.02 and x < 0.235 and y > 0.3 and y < 0.55 then
			menc[1] = {hc("#d0d4c4")}
		else
			menc[1] = {hc("#8c9880")}
		end
		if x > 0.02 and x < 0.15 and y > 0.55 and y < 0.7 then
			menc[2] = {hc("#d0d4c4")}
		else
			menc[2] = {hc("#8c9880")}
		end
		if x > 0.02 and x < 0.13 and y > 0.8 and y < 0.95 then
			menc[3] = {hc("#d0d4c4")}
		else
			menc[3] = {hc("#8c9880")}
		end
	end
end

function ostart()
	love.filesystem.load("start.lua")()
end

function oelse()
	love.filesystem.load("else.lua")()
end

function oexit()
	love.event.quit()
end

function pause()
	local pausearch = love.arch()
	function love.keypressed(key)
		if key == "3" then
			love.window.setMode(2, 1, {borderless = true, fullscreen = true})
			fit()
		elseif key == "5" then
			love.window.setMode(300, 300, {borderless = false, fullscreen = false})
			fit()
		elseif key == "4" then
			love.window.setMode(600, 300, {borderless = true, fullscreen = false})
			fit()
		elseif key == "escape" then
			love.arch(pausearch)
		end
	end
	function love.mousepressed(x, y)
		x, y = fixmou(x, y)
		if x > 0.02 and x < 0.36 and y > 0.3 and y < 0.55 then
			love.arch(pausearch)
		elseif x > 0.02 and x < 0.15 and y > 0.55 and y < 0.7 then
			oelse()
		elseif x > 0.02 and x < 0.14 and y > 0.8 and y < 0.95 then
			love.filesystem.load("main.lua")()
		end
	end
	function love.update(dt)
		x, y = fixmou(love.mouse.getX(), love.mouse.getY())
		if x ~= 2 and y ~= 2 then
			turnin = {(x - 0.5) * 15, (y - 0.5) * 10}
			if x > 0.02 and x < 0.36 and y > 0.3 and y < 0.55 then
				menc[1] = {hc("#d0d4c4")}
			else
				menc[1] = {hc("#8c9880")}
			end
			if x > 0.02 and x < 0.15 and y > 0.55 and y < 0.7 then
				menc[2] = {hc("#d0d4c4")}
			else
				menc[2] = {hc("#8c9880")}
			end
			if x > 0.02 and x < 0.14 and y > 0.8 and y < 0.95 then
				menc[3] = {hc("#d0d4c4")}
			else
				menc[3] = {hc("#8c9880")}
			end
		end
	end
	function love.draw()
		love.graphics.scale(s, s)
		love.graphics.translate(t[1], t[2])
		love.graphics.setLineStyle("smooth")
		love.graphics.setLineWidth(1)
		love.graphics.setColor(hc("#303030"))
		love.graphics.paradraw(mn, 850, 500, -5)
		love.graphics.paradraw(cl, 1000, 350, -2)
		love.graphics.paradraw(fr, 1000, 525, 4)
		love.graphics.paradraw(hm, 700, 550, 7)
		love.graphics.setFont(aqua[1])
		love.graphics.setColor(hc("#d0d4c4"))
		love.graphics.print("Bexolder", 45 + turnin[1], 110 + turnin[2])
		love.graphics.setFont(aqua[2])
		love.graphics.setColor(menc[1])
		love.graphics.print("Continue", 46 + turnin[1], 300 + turnin[2])
		love.graphics.setFont(aqua[3])
		love.graphics.setColor(menc[2])	
		love.graphics.print("Else", 50 + turnin[1], 440 + turnin[2])
		love.graphics.setFont(aqua[4])
		love.graphics.setColor(menc[3])	
		love.graphics.print("Menu", 50 + turnin[1], 620 + turnin[2])
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(mesh, meshp.x1, meshp.y1)
		love.graphics.draw(mesh, meshp.x2, meshp.y2)
	end
end

function love.draw()
	love.graphics.scale(s, s)
	love.graphics.translate(t[1], t[2])
	love.graphics.setLineStyle("smooth")
	love.graphics.setLineWidth(1)
	love.graphics.setColor(hc("#506844"))
	love.graphics.paradraw(mn, 850, 500, -5)
	love.graphics.setColor(hc("#c4c8c4"))
	love.graphics.paradraw(cl, 1000, 350, -2)
	love.graphics.setColor(hc("#285438"))	
	love.graphics.paradraw(fr, 1000, 525, 4)
	love.graphics.setColor(hc("#c4bca8"))
	love.graphics.paradraw(hm, 700, 550, 7)
	love.graphics.setFont(aqua[1])
	love.graphics.setColor(hc("#d0d4c4"))
	love.graphics.print("Bexolder", 45 + turnin[1], 110 + turnin[2])
	love.graphics.setFont(aqua[2])
	love.graphics.setColor(menc[1])
	love.graphics.print("Start", 46 + turnin[1], 300 + turnin[2])
	love.graphics.setFont(aqua[3])
	love.graphics.setColor(menc[2])	
	love.graphics.print("Else", 50 + turnin[1], 440 + turnin[2])
	love.graphics.setFont(aqua[4])
	love.graphics.setColor(menc[3])	
	love.graphics.print("Exit", 50 + turnin[1], 620 + turnin[2])
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(mesh, meshp.x1, meshp.y1)
	love.graphics.draw(mesh, meshp.x2, meshp.y2)
end