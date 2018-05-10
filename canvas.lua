local screen = require("screen")
local canvas = screen:createClass()

function canvas:init(palette)
	screen.init(self, C.screenWidth, C.canvasHeight)
	self.palette = palette
end

function canvas:update()
	local x, y = love.mouse.getPosition()
	x, y = self:localize(x, y)
	if self:isInside(x, y) then
		local color
		if love.mouse.isDown(1) then
			color = self.palette:getColor("primary")
		elseif love.mouse.isDown(2) then
			color = self.palette:getColor("secondary")
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
end

function canvas:onMousePressed(x, y, button)
end

function canvas:onMouseMoved(x, y, button)
end

function canvas:onMouseReleased(x, y, button)
end

return canvas
