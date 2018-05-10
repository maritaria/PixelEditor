print(string.format("LOVE %s.%s.%s (%s)", love.getVersion()))

-- Modules
require("patches")
local colors = require("colors")
local screen = require("screen")
local colorgrid = require("colorgrid")
local palette = require("palette")

-- Settings
local backgroundColor = colors.darkgrey
local paletteRenderPos = { x = 1, y = 21 }

function love.load()
    love.graphics.setNewFont(12)
	colorgrid:init(5, 5)
	colorgrid:addColor({1,0,0})
	colorgrid:addColor({0,1,0})
	colorgrid:addColor({0,0,1})
	colorgrid:addColor({1,1,0})
	colorgrid:addColor({0,1,1})
	colorgrid:addColor({1,0,1})
	palette:init()
    screen:init()
    screen:draw(function(w, h)
        love.graphics.setColor(colors.red)
        love.graphics.rectangle("line", 1, 1, w - 2, h - 10)
    end)
    assert(love.graphics.getSupported("canvas"))
end

function love.update(dt)
    local shouldDraw = false
    local x, y = love.mouse.getPosition()
    x, y = screen:localize(x, y)
    if x > 1 and x < C.screenWidth - 2 and
    y > 1 and y < C.screenHeight - 10 then
        if love.mouse.isDown(1) then
            screen:draw(function(w, h)
                love.graphics.setBlendMode("replace")
                love.graphics.setColor(palette:getColor())
                love.graphics.points({x, y})
            end)
        elseif love.mouse.isDown(2) then
            screen:draw(function(w, h)
                love.graphics.setBlendMode("replace")
                love.graphics.setColor(colors.transparent)
                love.graphics.points({x, y})
            end)
        end
    end
	if love.keyboard.isDown("space") then
		backgroundColor = palette:getColor()
	end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end

function love.mousepressed(x, y, button)
	local x, y = screen:localize(x, y)
	local sx, sy = paletteRenderPos.x, paletteRenderPos.y
	if x > sx and x <= sx + colorgrid.width and y > sy and y <= sy + colorgrid.height then
		palette:setPos(x - sx, y - sy)
	end
end

function love.draw()
    love.graphics.clear(backgroundColor)
    screen:draw(function(w, h)
        love.graphics.setBlendMode("replace")
        palette:render(paletteRenderPos.x, paletteRenderPos.y)
    end)
    screen:renderToWindow()
end
