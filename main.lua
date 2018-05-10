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

function love.load()
    love.graphics.setNewFont(12)
	colorgrid:init(7, 7)
	-- https://html-color-codes.info/colors-from-image/
	-- http://i.imgur.com/nj9T2aO.png
	colorgrid:addColor(colorgrid:convertHexToColor("#4D1F4D"))
	colorgrid:addColor(colorgrid:convertHexToColor("#A63A82"))
	colorgrid:addColor(colorgrid:convertHexToColor("#A64B4B"))
	colorgrid:addColor(colorgrid:convertHexToColor("#15788C"))
	colorgrid:addColor(colorgrid:convertHexToColor("#266EFF"))
	colorgrid:addColor(colorgrid:convertHexToColor("#283B73"))
	colorgrid:addColor(colorgrid:convertHexToColor("#341F34"))

	colorgrid:addColor(colorgrid:convertHexToColor("#FFBCA6"))
	colorgrid:addColor(colorgrid:convertHexToColor("#FF5983"))
	colorgrid:addColor(colorgrid:convertHexToColor("#F37C55"))
	colorgrid:addColor(colorgrid:convertHexToColor("#14CC80"))
	colorgrid:addColor(colorgrid:convertHexToColor("#00D5FF"))
	colorgrid:addColor(colorgrid:convertHexToColor("#8CB2FF"))
	colorgrid:addColor(colorgrid:convertHexToColor("#642DB3"))

	colorgrid:addColor(colorgrid:convertHexToColor("#FFFFFF"))
	colorgrid:addColor(colorgrid:convertHexToColor("#FFEECC"))
	colorgrid:addColor(colorgrid:convertHexToColor("#FFC34D"))
	colorgrid:addColor(colorgrid:convertHexToColor("#CBE545"))
	colorgrid:addColor(colorgrid:convertHexToColor("#80FFEA"))
	colorgrid:addColor(colorgrid:convertHexToColor("#DAEAF2"))
	colorgrid:addColor(colorgrid:convertHexToColor("#6F66CC"))

	colorgrid:addColor({ 1, 1, 1 })
	colorgrid:addColor({ 0.8, 0.8, 0.8 })
	colorgrid:addColor({ 0.6, 0.6, 0.6 })
	colorgrid:addColor({ 0.4, 0.4, 0.4 })
	colorgrid:addColor({ 0.2, 0.2, 0.2 })
	colorgrid:addColor({ 0, 0, 0 })

	palette:init()
    screen:init()
    screen:draw(function(w, h)
        love.graphics.setColor(colors.red)
        love.graphics.rectangle("line", canvasBounds.x, canvasBounds.y, canvasBounds.w, canvasBounds.h)
    end)
    assert(love.graphics.getSupported("canvas"))
end

function love.update(dt)
    local shouldDraw = false
    local x, y = love.mouse.getPosition()
    x, y = screen:localize(x, y)
    if x >= canvasBounds.x and x - canvasBounds.x < canvasBounds.w and
    y >= canvasBounds.y and y - canvasBounds.y < canvasBounds.h then
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
	if x >= sx and x - sx < colorgrid.width and
	y >= sy and y - sy < colorgrid.height then
		palette:setPos(x - sx, y - sy)
	end
end

function love.draw()
    love.graphics.clear(backgroundColor)
    screen:draw(function(w, h)
        love.graphics.setBlendMode("replace")
		love.graphics.setColor(colors.white)
		local splitter = canvasBounds.y + canvasBounds.h
		love.graphics.line(0, splitter, C.screenWidth, splitter)
        palette:render(paletteRenderPos.x, paletteRenderPos.y)
    end)
    screen:renderToWindow()
end
