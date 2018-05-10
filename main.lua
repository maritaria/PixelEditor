print(string.format("LOVE %s.%s.%s (%s)", love.getVersion()))

-- Modules
require("patches")
local colors = require("colors")
local screen = require("screen")
local colorgrid = require("colorgrid")
local palette = require("palette")

-- Settings
local backgroundColor = colors.darkgrey
local canvasBounds = { x = 0, y = 0, w = C.screenWidth, h = C.screenHeight - 10 }
local paletteRenderPos = { x = 0, y = canvasBounds.y + canvasBounds.h + 1 }
local cursorStart = 30

local canvas = screen:createClass()

function love.load()
	love.graphics.setLineWidth(1)
	love.graphics.setLineStyle("rough")
	colorgrid:init(7, 7)
    canvas:init(C.screenWidth, C.screenHeight, C.pixelSize)
	require("palettes.basic_rainbow")
	palette:init(colorgrid)
	palette:setPos(paletteRenderPos.x, paletteRenderPos.y)
end

function love.update(dt)
    local shouldDraw = false
    local x, y = love.mouse.getPosition()
    x, y = canvas:localize(x, y)
    if x >= canvasBounds.x and x - canvasBounds.x < canvasBounds.w and
    y >= canvasBounds.y and y - canvasBounds.y < canvasBounds.h then
		local color
        if love.mouse.isDown(1) then
			color = palette:getColor("primary")
        elseif love.mouse.isDown(2) then
			color = palette:getColor("secondary")
        end
		if color then
			-- if drawing with the background, use eraser instead
			if color == backgroundColor then
				color = colors.transparent
			end
            canvas:workOnContext(function(w, h)
                love.graphics.setBlendMode("replace")
                love.graphics.setColor(color)
                love.graphics.points({x, y})
            end)
		end
    end
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
end

function love.draw()
    love.graphics.clear(backgroundColor)
    canvas:workOnContext(function()
		-- Draw splitter
        love.graphics.setBlendMode("replace")
		love.graphics.setColor(colors.white)
		local splitter = canvasBounds.y + canvasBounds.h
		love.graphics.line(0, splitter, C.screenWidth-1, splitter)
		-- Draw selected colors
		love.graphics.setColor(palette:getColor("primary"))
		love.graphics.line(cursorStart, splitter, cursorStart + 1, splitter)
		love.graphics.setColor(palette:getColor("secondary"))
		love.graphics.line(cursorStart + 3, splitter, cursorStart + 4, splitter)
    end)
    canvas:render()
	palette:render()
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
