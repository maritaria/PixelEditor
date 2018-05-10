local screen = require("screen")
local canvas = screen:createClass()

function canvas:init(palette)
	screen.init(self, C.screenWidth, C.canvasHeight)
	self.palette = palette
end

function canvas:getMouseActivatedColor()
	if love.mouse.isDown(1) then
		return self.palette:getPaintingColor("primary")
	elseif love.mouse.isDown(2) then
		return self.palette:getPaintingColor("secondary")
	end
end

function canvas:getMouseButtonColor(button)
	if button == 1 then
		return self.palette:getPaintingColor("primary")
	elseif button == 2 then
		return self.palette:getPaintingColor("secondary")
	end
end

function canvas:update()
	local x, y = love.mouse.getPosition()
	x, y = self:localize(x, y)
	if self:isInside(x, y) then
		local color = self:getMouseActivatedColor()
		if color then
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
		canvas:floodFill(x, y, button)
	end
end

function canvas:floodFill(x, y, button)
	local queue = {}
	local points = {}
	-- Get the pixel data from the current frame
	local data = self.canvas:newImageData()
	-- Get the color that is under the mouse
	local fromColor = { data:getPixel(x, y) }
	-- Get the color that has to be set to
	local toColor = self:getMouseButtonColor(button)
	-- Function to check if two color tables are equal
	local function colorEquals(a, b)
		return a[1] == b[1] and a[2] == b[2] and a[3] == b[3]
	end
	-- If the target color is the color of the pixel then already done
	if colorEquals(fromColor, toColor) then
		return
	end
	-- Function that checks if a given pixel matches the original pixel color
	local function shouldRecolor(x, y)
		local pixel = { data:getPixel(x, y) }
		return colorEquals(fromColor, pixel)
	end
	-- Function that performs the algo on a given cell
	local function handleCell(x, y)
		if x < 0 or x >= self.width then return end
		if y < 0 or y >= self.height then return end
		if shouldRecolor(x, y) then
			table.insert(queue, 1, { x = x, y = y })
			data:setPixel(x, y, toColor[1], toColor[2], toColor[3])
			table.insert(points, { x, y })
		end
	end
	-- Recolor the pixel under the position and queues it for neighbor testing
	handleCell(x, y)
	-- Keep going while there are pixels that have neighbors to be tested
	while #queue > 0 do
		assert(#queue < 1000 * 1000)
		-- Dequeue front item
		local pos = queue[1]
		table.remove(queue, 1)
		-- Handle neighbors
		handleCell(pos.x - 1, pos.y)
		handleCell(pos.x + 1, pos.y)
		handleCell(pos.x, pos.y - 1)
		handleCell(pos.x, pos.y + 1)
	end
	-- Draw all changed points on the screen
	self:workOnContext(function()
		love.graphics.setBlendMode("replace")
		love.graphics.setColor(toColor)
		love.graphics.points(points)
	end)
end

return canvas
