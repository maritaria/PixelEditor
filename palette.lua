local screen = require("screen")
local colors = require("colors")
local colorgrid = require("colorgrid")

local palette = screen:createClass()

function palette:init(colorgrid)
	screen.init(self, colorgrid.width, colorgrid.height)
	self:setPos(0, C.canvasHeight + 1)
	self.grid = colorgrid
	self.cursors = {
		primary = { x = 0, y = 0 },
		secondary = { x = 0, y = 1 },
		background = { x = 0, y = 1 },
		grid = { x = 1, y = 0 },
	}
end

function palette:setCursorPos(label, x, y)
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

function palette:getPaintingColor(label)
	if label == "background" then
		return colors.transparent
	end
	if label == "secondary" then
		if self.cursors.secondary.x == self.cursors.background.x and
			self.cursors.secondary.y == self.cursors.background.y then
			return colors.transparent
		end
	end
	return self:getColor(label)
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

function palette:onMousePressed(x, y, button)
	if button == 1 then
		-- Left click a cell
		self:setCursorPos("primary", x, y)
	elseif button == 2 then
		-- Right click a cell
		self:setCursorPos("secondary", x, y)
	elseif button == 3 then
		-- Mouse wheel click
		self:setCursorPos("grid", x, y)
	end
end

return palette
