-- COPYRIGHT: KISELEV NIKOLAY
-- Licence: MIT
-- BUTTONPONY
-- Version: 0.0.2.1

fur = {w = 1500, h = 750}
if musicplay == nil then musicplay = true end

anima = 0
frame = 1
colors = {
	{226, 145, 145},
	{153, 221, 146},
	{147, 216, 185},
	{148, 196, 211},
	{148, 154, 206},
	{179, 148, 204},
	{204, 150, 177},
	{204, 164, 153},
	{223, 229, 146},
	{255, 165, 96},
	{107, 255, 99},
	{101, 255, 204},
	{101, 196, 255},
	{101, 107, 255},
	{173, 101, 255},
	{255, 101, 244},
	{255, 101, 132},
	{255, 101, 101}
}

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
		iw = (iw / s) * 100
		ih = (ih / s) * 100
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
	love.graphics.draw(im, x, y, 0, fur.w / 60, fur.h / 30, im:getWidth() / 2, im:getHeight() / 2)
end

love.window.setMode(2, 1, {fullscreen = true})
love.window.setTitle("ButtonPony")
logo = love.graphics.newImage("bg.bmp")
love.window.setIcon(logo:getData())
fit()

love.graphics.setDefaultFilter("nearest")
love.graphics.setBackgroundColor(0, 0, 0)
menc = {{0, 0, 0}, {0, 0, 0}}
if love.filesystem.exists("main.ttf") then
	aqua = {
		love.graphics.newFont("main.ttf", 170),
		love.graphics.newFont("main.ttf", 170 * 0.75),
		love.graphics.newFont("main.ttf", 170 * 0.5),
		love.graphics.newFont("main.ttf", 170 * 0.4),
		love.graphics.newFont("main.ttf", 40)
	}
end

pn = {}
pn[1] = love.graphics.newImage("img/pn1.bmp")
pn[2] = love.graphics.newImage("img/pn2.bmp")
pn.y = 600
back = love.graphics.newImage("img/sky.bmp")
door = love.graphics.newImage("img/door.bmp")

function love.wheelmoved()
	oexit()
end

function love.mousepressed(x, y)
	x, y = fixmou(x, y)
	if x > 0.02 and x < 0.235 and y > 0.3 and y < 0.55 then
		ostart()
	elseif x > 0.02 and x < 0.13 and y > 0.8 and y < 0.95 then
		oexit()
	end
end

function love.update(dt)
end

function ostart()
	love.mousepressed = otou
	function love.update(dt)
		if sec == nil or sec > 0.2 then
			sec = 0
			if pn.y < 600 then
				pn.y = 600
				frame = 1
			else
				pn.y = 550
				frame = 2
			end
		else sec = sec + dt end
		if nsec == nil or nsec > 0.01 then
			nsec = 0
			anima = anima + 80
		else nsec = nsec + dt end
		if anima > 655 then
			frame = 0
			if anima > 700 then
				love.update = oupdate
				oload()
			end
		end
	end
end

function oexit()
	love.event.quit()
end

function love.draw()
	love.graphics.scale(s, s)
	love.graphics.translate(t[1], t[2])
	love.graphics.setLineStyle("smooth")
	love.graphics.setLineWidth(1)
	love.graphics.setColor(255, 255, 255)
	if anima < 700 then
		love.graphics.paradraw(back, 750 - anima, 375)
		love.graphics.setColor(colors[16])
		if frame ~= 0 then love.graphics.paradraw(pn[frame], 750, pn.y) end
		love.graphics.setColor(colors[8])
		love.graphics.paradraw(door, 1400 - anima, 375)
		love.graphics.setFont(aqua[1])
		love.graphics.setColor(0, 0, 0)
		love.graphics.print("Не Домашний Пони", 45 - anima, 110, 0, 0.42, 0.8)
		love.graphics.setFont(aqua[2])
		love.graphics.setColor(menc[1])
		love.graphics.print("Начать", 46 - anima, 300, 0, 0.4, 0.8)
		love.graphics.setFont(aqua[4])
		love.graphics.setColor(menc[2])	
		love.graphics.print("Уйти", 50 - anima, 620, 0, 0.4, 1)
	else ostartdraw() end
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(mesh, meshp.x1, meshp.y1)
	love.graphics.draw(mesh, meshp.x2, meshp.y2)
end

-- SOMEBODY WATCHING ME!! --
-- SOMEBODY WATCHING ME!! --
-- SOMEBODY WATCHING ME!! --
-- SOMEBODY WATCHING ME!! --
-- SOMEBODY WATCHING ME!! --

function oload()
	love.graphics.setBackgroundColor(30, 30, 30)
	love.physics.setMeter(fur.h * 0.4)
	frame = 1
	move = 0
	w = love.physics.newWorld(0, love.physics.getMeter() * 9.868464)
	edges = {}
		edges[1] = {}
			edges[1].b = love.physics.newBody(w, 0, 0, "static")
			edges[1].s = love.physics.newEdgeShape(0, 0, fur.w, 0)
			edges[1].f = love.physics.newFixture(edges[1].b, edges[1].s)
		edges[2] = {}
			edges[2].b = love.physics.newBody(w, 0, 0, "static")
			edges[2].s = love.physics.newEdgeShape(0, fur.h, fur.w, fur.h)
			edges[2].f = love.physics.newFixture(edges[2].b, edges[2].s)
	pony = {}
		pony.b = love.physics.newBody(w, 350, 350, "dynamic")
		pony.s = love.physics.newPolygonShape(-160, 90, -160, -0, 80, -140, 130, -140, 90, 130, 160, -0, -115, 130)
		pony.f = love.physics.newFixture(pony.b, pony.s, 1)
end

function otou(x, y)
	x, y = fixmou(x, y)
	if x > 0.5 then
		--
	else --
	end
end

function oupdate(dt)
	w:update(dt)
	----------
	if sec == nil or sec > 0.2 then
		sec = 0
		if frame ~= 1 then
			frame = 1
		else
			frame = 2
		end
	else
		sec = sec + dt
	end
	----------
	if droptime == nil or droptime > 3 then
		droptime = 0
		-- drop meble
	else droptime = droptime + dt end
	move = move + dt
end

function ostartdraw()
	love.graphics.setColor(colors[16])
	love.graphics.paradraw(pn[frame], pony.b:getX(), pony.b:getY())
end