print("! demo is start !")

time = 1
frame = 1

back = love.graphics.newImage("/im/ata.png")
back = job.paint(back, {rgb(129, 34, 0), rgb(159, 57, 12), rgb(199, 106, 54), rgb(211, 132, 83)})
back:setFilter("nearest")

function love.update(dt)
	time = time + dt * 7
	if time <= 5 then
		frame = math.floor(time)
	else
		frame = math.floor(time)
		time = 1
	end		
end

function love.keypressed(key, scancode, isrepeat)
	--
end

function love.mousepressed(x, y, button, isTouch)
	--
end

function love.draw()
	love.graphics.fit()
	love.graphics.draw(back)
	love.graphics.setColor(255, 255, 255)
end