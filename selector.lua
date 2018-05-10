local selector = {}

local palette = require("palette")
local colors = require("colors")

function selector:init(x, y)
	self.x = 1
	self.y = 1
end

function selector:setPos(x, y)
	self.x = x
	self.y = y
end

function selector:getPos()
	return self.x, self.y
end

function selector:getColor()
	return palette:getColor(self:getPos())
end

function selector:render(x, y)
	love.graphics.push()
	love.graphics.translate(x, y)

	for x = 1, palette.width do
		for y = 1, palette.height do
			local color = palette:getColor(x, y) or colors.transparent
			love.graphics.setColor(color)
			love.graphics.points({x, y})
		end
	end

	love.graphics.pop()
end

return selector
