print(string.format("LOVE %s.%s.%s (%s)", love.getVersion()))

require("patches")
local colors = require("colors")
local screen = require("screen")

function love.load()
    love.graphics.setNewFont(12)
    screen:init()
    screen:draw(function(w, h)
        love.graphics.setColor(colors.red)
        love.graphics.rectangle("line", 1, 1, w - 2, h - 10)
    end)
    assert(love.graphics.getSupported("canvas"))
end

local palettePos = { 2, 23 }
local palette = require("palette")
local paletteIndex = 1
local function activeColor()
    local color = palette[paletteIndex]
    color = { color[1], color[2], color[3] }
	if love.keyboard.isDown("lshift") then
		color[1] = color[1] + (1 - color[1]) * 0.2
		color[2] = color[2] + (1 - color[2]) * 0.2
		color[3] = color[3] + (1 - color[3]) * 0.2
	end
    return color
end

local backgroundColor = colors.darkgrey

function love.update(dt)
    local shouldDraw = false
    local x, y = love.mouse.getPosition()
    x, y = screen:localize(x, y)
    if x > 1 and x < C.screenWidth - 2 and
    y > 1 and y < C.screenHeight - 10 then
        if love.mouse.isDown(1) then
            screen:draw(function(w, h)
                love.graphics.setBlendMode("replace")
                love.graphics.setColor(activeColor())
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
		backgroundColor = activeColor()
	end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end

function love.wheelmoved(x, y)
    if y > 0 then
        --Scrolled up
        if love.keyboard.isDown("lshift") then
            paletteIndex = paletteIndex - 7
        else
            paletteIndex = paletteIndex - 1
        end
    elseif y < 0 then
        --Scrolled down
        if love.keyboard.isDown("lshift") then
            paletteIndex = paletteIndex + 7
        else
            paletteIndex = paletteIndex + 1
        end
    end
    while paletteIndex < 1 do
        paletteIndex = paletteIndex + #palette
    end
    while paletteIndex > #palette do
        paletteIndex = paletteIndex - #palette
    end
end

function love.filedropped( file )
    print("file dropped: " .. file:getFilename())
end
function love.draw()
    love.graphics.clear(backgroundColor)
    screen:draw(function(w, h)
        love.graphics.setBlendMode("replace")
        love.graphics.setColor(activeColor())
        love.graphics.points(palettePos[1] - 1, palettePos[2])
        love.graphics.setColor(colors.transparent)
        love.graphics.line(
            palettePos[1] + 1, palettePos[2] - 1,
            palettePos[1] + 1, palettePos[2] + 2
        )
        love.graphics.line(
            palettePos[1] + 2, palettePos[2] - 1,
            palettePos[1] + 9, palettePos[2] - 1
        )
        love.graphics.line(
            palettePos[1] + 9, palettePos[2] - 1,
            palettePos[1] + 9, palettePos[2] + 2
        )
        love.graphics.line(
            palettePos[1] + 2, palettePos[2] + 3,
            palettePos[1] + 9, palettePos[2] + 3
        )
        local pos = { palettePos[1] + 2, palettePos[2]}
        for i = 1, #palette do
            love.graphics.setColor(palette[i])
            love.graphics.points(pos)
            if i == paletteIndex then
                love.graphics.setColor(colors.white)
                love.graphics.points(palettePos[1] + 1, pos[2])
                love.graphics.points(palettePos[1] + 9, pos[2])
                love.graphics.points(pos[1], palettePos[2] - 1)
                love.graphics.points(pos[1], palettePos[2] + 3)
            end
            --Find next pos
            pos[1] = pos[1] + 1
            if pos[1] > palettePos[1] + 8 then
                pos[1] = palettePos[1] + 2
                pos[2] = pos[2] + 1
            end
        end

    end)
    screen:renderToWindow()
end
