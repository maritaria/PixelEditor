local palette = {}

local screen = require("screen")
local colors = require("colors")
local colorgrid = require("colorgrid")

function palette:init(x, y)
	self.x = 0
	self.y = 0
	self.positions = {
		primary = { x = 0, y = 0 },
		secondary = { x = 0, y = 1 },
	}
	self.grid = colorgrid
	self.screen = screen:create(self.grid.width, self.grid.height, C.pixelSize)
	self.screen:setPos(x, y)
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
	return self.grid:getColor(self:getPos(label))
end

function palette:render()
	self.screen:workOnContext(function()
		for x = 0, self.grid.width - 1 do
			for y = 0, self.grid.height - 1 do
				local color = self.grid:getColor(x, y)
				love.graphics.setColor(color)
				love.graphics.points({ x, y })
			end
		end
	end)
	self.screen:render()
end

function palette:mousepressed(x, y, button)
	local x, y = self.screen:localize(x, y)

end

return palette
