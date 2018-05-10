local screen = require("screen")
local colors = require("colors")
local colorgrid = require("colorgrid")

local palette = screen:createClass()

function palette:init(colorgrid)
	screen.init(self, colorgrid.width, colorgrid.height)
	self.grid = colorgrid
	self.cursors = {
		primary = { x = 0, y = 0 },
		secondary = { x = 0, y = 1 },
	}
end

function palette:setCursorPos(x, y, label)
	local pos = self.cursors[label]
	pos.x = x
	pos.y = y
end

function palette:getCursorPos(label)
	local pos = self.cursors[label]
	return pos.x, pos.y
end

function palette:getColor(label)
	return self.grid:getColor(self:getCursorPos(label))
end

function palette:render()
	self:workOnContext(function()
		for x = 0, self.grid.width - 1 do
			for y = 0, self.grid.height - 1 do
				local color = self.grid:getColor(x, y)
				love.graphics.setColor(color)
				love.graphics.points({ x, y })
			end
		end
	end)
	screen.render(self)
end

return palette
