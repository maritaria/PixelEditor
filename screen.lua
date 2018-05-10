local screen = {}

function screen:createClass()
	local instance = {}
	setmetatable(instance, { __index = self })
	return instance
end

function screen:create(...)
	local instance = self:createClass()
	instance:init(...)
	return instance
end

function screen:init(width, height)
	self.width = width
	self.height = height
    self.canvas = love.graphics.newCanvas(width, height)
    self.canvas:setFilter("linear", "nearest")
    --will render the canvas at 0,0 stretched over the entire window
	self.workTransform = love.math.newTransform(0.5, 0.5)
	self:setPos(0, 0)
end

function screen:setPos(x, y)
	self.position = { x = x, y = y }
	self.renderTransform = love.math.newTransform(0.5, 0.5, 0, C.pixelSize)
	self.renderTransform:translate(x, y)
end

function screen:workOnContext(work)
    -- Setup render context
	love.graphics.push()
	love.graphics.origin()
	love.graphics.applyTransform(self.workTransform)
    -- Perform render ops
    love.graphics.setCanvas(self.canvas)
    work()
	-- Tear down context
	love.graphics.setCanvas()
	love.graphics.pop()
end

function screen:render()
	-- Reset transformations
	love.graphics.push()
	love.graphics.origin()
	love.graphics.setColor({1, 1, 1})
	love.graphics.setBlendMode("alpha")
	-- Render to screen
	love.graphics.draw(self.canvas, self.renderTransform)
	-- Tear down stuff
	love.graphics.pop()
end

function screen:localize(x, y)
	local x, y = x / C.pixelSize, y / C.pixelSize
	return math.floor(x - self.position.x), math.floor(y - self.position.y)
end

function screen:globalize(x, y)
	return (x + self.position.x) * C.pixelSize, (y + self.position.y) * C.pixelSize
end

-- Tests if the global coordinate x, y is inside the screen
function screen:isInside(x, y)
	local x, y = self:localize(x, y)
	return x >= 0 and x < self.width and y >= 0 and y < self.height
end

function screen:mousepressed(x, y, button)
	if self:isInside(x, y) then
		self:onMousePressed(x, y, button)
	end
end

function screen:onMousePressed(x, y, button) end

function screen:mousemoved(x, y, dx, dy)
	if self:isInside(x, y) then
		self:onMouseMoved(x, y, button)
	end
end

function screen:onMouseMoved(x, y, button) end

function screen:mousereleased(x, y, button)
	if self:isInside(x, y) then
		self:onMouseReleased(x, y, button)
	end
end

function screen:onMouseReleased(x, y, button) end

return screen
