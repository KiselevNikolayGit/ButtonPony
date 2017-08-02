-- Красные Корни
-- rgb(129, 34, 0)
-- Цветочный Горшок
-- rgb(159, 57, 12)
-- Мягкая Глина
-- rgb(199, 106, 54)
-- Красный Песок
-- rgb(211, 132, 83)
-- Мокрая Мята
-- rgb(39, 77, 65)
-- Сочный Кактус
-- rgb(58, 91, 73)
-- Молодой Лист
-- rgb(82, 118, 80)
-- Свежий Лист
-- rgb(100, 133, 89)
-- Десять Вечера
-- rgb(11, 51, 98)
-- Теплые Сумерки
-- rgb(33, 61, 110)
-- Ясный Звездопад
-- rgb(24, 76, 135)
-- Высокое Небо
-- rgb(33, 89, 153)
-- Терпкий Виноград
-- rgb(35, 33, 55)
-- Лист Базилика
-- rgb(56, 51, 73)
-- Сок Черники
-- rgb(60, 59, 91)
-- Цветущая Сирень
-- rgb(66, 65, 99)
-- Текучий Черный
-- rgb(11, 12, 7)
-- Стрелка Часов
-- rgb(25, 26, 21)
-- Тающий Лед
-- rgb(175, 179, 191)
-- Чистый Снег
-- rgb(205, 203, 207)

size = 100
love.window.setMode(size, size, {fullscreen = true})
w, h = love.window.getMode()
scale = h / size
trans = (w - (size * scale)) / 2

function love.graphics.fit()
  love.graphics.translate(trans, 0)
  love.graphics.scale(scale, scale)
end

function love.graphics.drawf(im, x, y, r, s)
  love.graphics.draw(im, size * x, size * y, r, s, s, im:getWidth() / 2, im:getHeight() / 2)
end

function rgb(...)
  local rngnb = {...}
  return rngnb
end

job = {}

function job.prepaint(x, y, r, g, b, a)
  brush = {r, g, b}
  if a > 0 then
    paper = (r + g + b) / 3
    how = (paper / 255) + 0.5
    what = how * 3
    what = math.floor(what)
    brush = job.c[what]
  end
  return brush[1], brush[2], brush[3], a
end

function job.paint(im, colors)
  imd = im:getData()
  job.c = colors
  imd:mapPixel(job.prepaint)
  im = love.graphics.newImage(imd)
  return im
end

function love.load()
  print("! started main.lua !")
  -- love.filesystem.load("animate.lua")()
  love.filesystem.load("demo.lua")()
end

function love.wheelmoved()
  love.event.quit()
end
