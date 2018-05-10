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

end

return screen
