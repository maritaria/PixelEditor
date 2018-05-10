local palette = {}

local colors = require("colors")
local colorgrid = require("colorgrid")

function palette:init(x, y)
	self.x = 0
	self.y = 0
	self.positions = {
		primary = { x = 0, y = 0 },
		secondary = { x = 0, y = 1 },
	}
end

function palette:setPos(x, y, label)
	local pos = self.positions[label]
	pos.x = x
	pos.y = y
end

function palette:getPos(label)
	local pos = self.positions[label]
	return pos.x, pos.y
end

function palette:getColor(label)
	return colorgrid:getColor(self:getPos(label))
end

function palette:render(x, y)
	love.graphics.push()
	love.graphics.translate(x, y)

	for x = 0, colorgrid.width - 1 do
		for y = 0, colorgrid.height - 1 do
			local color = colorgrid:getColor(x, y)
			love.graphics.setColor(color)
			love.graphics.points({ x, y })
		end
	end

	love.graphics.pop()
end

return palette
