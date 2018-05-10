local screen = require("screen")
local canvas = screen:createClass()

function canvas:init(palette)
	screen.init(self, C.screenWidth, C.canvasHeight)
	self.palette = palette
end

function canvas:getMouseActivatedColor()
	if love.mouse.isDown(1) then
		return self.palette:getColor("primary")
	elseif love.mouse.isDown(2) then
		return self.palette:getColor("secondary")
	end
end

function canvas:update()
	local x, y = love.mouse.getPosition()
	x, y = self:localize(x, y)
	if self:isInside(x, y) then
		local color = self:getMouseActivatedColor()
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
	if love.keyboard.isDown("lshift") then
		canvas:floodFill(x, y)
	end
end

function canvas:floodFill(x, y)
	local queue = {}
	local points = {}

	local data = self.canvas:newImageData()

	local fromColor = { data:getPixel(x, y) }
	local toColor = self:getMouseActivatedColor()

	local function shouldRecolor(x, y)
		local r, g, b, a = data:getPixel(x, y)
		return r == fromColor[1] and g == fromColor[2] and b == fromColor[3]
	end

	local function handleCell(x, y)
		if x < 0 or x >= self.width then return end
		if y < 0 or y >= self.height then return end
		if shouldRecolor(x, y) then
			table.insert(queue, 1, { x = x, y = y })
			data:setPixel(x, y, toColor[1], toColor[2], toColor[3])
			table.insert(points, { x, y })
		end
	end

	handleCell(x, y)

	while #queue > 0 do
		local pos = queue[1]
		table.remove(queue, 1)
		handleCell(pos.x - 1, pos.y)
		handleCell(pos.x + 1, pos.y)
		handleCell(pos.x, pos.y - 1)
		handleCell(pos.x, pos.y + 1)
	end
	self:workOnContext(function()
		love.graphics.setBlendMode("replace")
		love.graphics.setColor(toColor)
		love.graphics.points(points)
	end)
end

return canvas
