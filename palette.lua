local palette = {}

local colorgrid = require("colorgrid")

function palette:init(x, y)
	self.x = 1
	self.y = 1
end

function palette:setPos(x, y)
	self.x = x
	self.y = y
end

function palette:getPos()
	return self.x, self.y
end

function palette:getColor()
	return colorgrid:getColor(self:getPos())
end

function palette:render(x, y)
	love.graphics.push()
	love.graphics.translate(x, y)

	for x = 1, colorgrid.width do
		for y = 1, colorgrid.height do
			local color = colorgrid:getColor(x, y)
			love.graphics.setColor(color)
			love.graphics.points({x, y})
		end
	end

	love.graphics.pop()
end

return palette
