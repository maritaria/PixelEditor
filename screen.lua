local screen = {}

function screen:init(width, height)
    self.canvas = love.graphics.newCanvas(width, height)
    self.canvas:setFilter("linear", "nearest")
    --will render the canvas at 0,0 stretched over the entire window
	self.transform = love.math.newTransform(0.5, 0.5, 0, C.pixelSize)

end

function screen:draw(work)
    -- Setup render defaults
	love.graphics.origin()
	love.graphics.translate(0.5, 0.5)
    love.graphics.setLineWidth(1)
    love.graphics.setLineStyle("rough")
    -- Perform render ops
    love.graphics.setCanvas(self.canvas)
    work(C.screenWidth, C.screenHeight)
	love.graphics.setCanvas()
end

function screen:renderToWindow()
	-- Reset transformations
	love.graphics.origin()
	love.graphics.setColor({1, 1, 1})
	love.graphics.setBlendMode("alpha")
	love.graphics.draw(self.canvas, self.transform)
end

function screen:localize(x, y)
	return math.floor(x / C.pixelSize), math.floor(y / C.pixelSize)
end

function screen:globalize(x, y)
	return x * C.pixelSize, y * C.pixelSize
end

return screen
