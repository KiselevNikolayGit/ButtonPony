print("! started animate.lua !")
rframe = 1
who = ""
a = {}
for i = 1, 5 do
  a[i] = love.graphics.newImage("anim/"..who..tostring(i)..".png")
  a[i] = job.paint(a[i], {rgb(91, 45, 52), rgb(132, 58, 66), rgb(182, 80, 80), rgb(221, 109, 97), rgb(232, 139, 123)})
  a[i]:setFilter("nearest")
end
b = {}
for i = 1, 5 do
  b[i] = love.graphics.newImage("anim/"..who..tostring(i)..".png")
  b[i] = job.paint(b[i], {rgb(24, 53, 43), rgb(33, 63, 51), rgb(52, 75, 58), rgb(97, 116, 77), rgb(133, 139, 98)})
  b[i]:setFilter("nearest")
end
c = {}
for i = 1, 5 do
  c[i] = love.graphics.newImage("/anim/"..who..tostring(i)..".png")
  c[i] = job.paint(c[i], {rgb(47, 67, 74), rgb(65, 91, 101), rgb(73, 105, 117), rgb(98, 128, 140), rgb(114, 140, 149)})
  c[i]:setFilter("nearest")
end
d = {}
for i = 1, 5 do
  d[i] = love.graphics.newImage("/anim/"..who..tostring(i)..".png")
  d[i] = job.paint(d[i], {rgb(39, 56, 80), rgb(48, 62, 85), rgb(62, 72, 93), rgb(78, 86, 107), rgb(97, 97, 111)})
  d[i]:setFilter("nearest")
end
e = {}
for i = 1, 5 do
  e[i] = love.graphics.newImage("/anim/"..who..tostring(i)..".png")
  e[i] = job.paint(e[i], {rgb(111, 54, 48), rgb(171, 102, 80), rgb(223, 132, 79), rgb(236, 156, 96), rgb(239, 182, 148)})
  e[i]:setFilter("nearest")
end

function love.update(dt)
  if rframe >= 6 then
    rframe = 1
  else
    rframe = rframe + (dt * 10)
  end
  frame = math.floor(rframe)
  if frame > 5 then
    frame = 5
  end
end

function love.draw()
  love.graphics.draw(a[frame], 10, 10, 0, 15, 15)
  love.graphics.draw(b[frame], 10, 10 + 15 * 15, 0, 15, 15)  
  love.graphics.draw(c[frame], 10 + 15 * 15, 10, 0, 15, 15)  
  love.graphics.draw(d[frame], 10 + 15 * 15, 10 + 15 * 15, 0, 15, 15)  
  love.graphics.draw(e[frame], 10 + 15 * 30, 10 + 15 * 15, 0, 15, 15)  
  love.graphics.print(tostring(frame))
end