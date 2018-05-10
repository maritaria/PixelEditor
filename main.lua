print(string.format("LOVE %s.%s.%s (%s)", love.getVersion()))

-- Modules
require("patches")
local colors = require("colors")
local screen = require("screen")
local colorgrid = require("colorgrid")
local canvas = require("canvas")
local palette = require("palette")
local splitter = require("splitter")

-- Settings
local backgroundColor = colors.darkgrey
local canvasBounds = { x = 0, y = 0, w = C.screenWidth, h = C.screenHeight - 10 }
local paletteRenderPos = { x = 0, y = canvasBounds.y + canvasBounds.h + 1 }
local cursorStart = 30

function love.load()
	love.graphics.setLineWidth(1)
	love.graphics.setLineStyle("rough")
	colorgrid:init(7, 7)
	require("colorgrids.basic_rainbow")
	palette:init(colorgrid)
    canvas:init(palette)
	splitter:init(palette)
end

function love.update(dt)
    canvas:update()
	if love.keyboard.isDown("space") then
		backgroundColor = palette:getColor("secondary")
	end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end

function love.mousepressed(x, y, button)
	palette:mousepressed(x, y, button)
	canvas:mousepressed(x, y, button)
end

function love.draw()
    love.graphics.clear(backgroundColor)
    canvas:render()
	palette:render()
	--Splitter
	splitter:render()
	--Draw grid
	love.graphics.setBlendMode("alpha")
	love.graphics.setColor(colors.red)
	love.graphics.translate(canvasBounds.x + 0.5, canvasBounds.y + 0.5)
	for x = 0, (canvasBounds.w - 1) * C.pixelSize, 4 * C.pixelSize do
		love.graphics.line(x, 0, x, canvasBounds.h * C.pixelSize - 1)
	end
	for y = 0, (canvasBounds.h - 1) * C.pixelSize, 4 * C.pixelSize do
		love.graphics.line(0, y, canvasBounds.w * C.pixelSize - 1, y)
	end

end
