local screen = require("screen")
local colors = require("colors")
local splitter = screen:createClass()

function splitter:init(palette)
    screen.init(self, C.screenWidth, 1)
    self:setPos(0, C.canvasHeight)
	self.palette = palette
end

function splitter:render()
    self:workOnContext(function()
        -- Draw splitter
        love.graphics.setBlendMode("replace")
        love.graphics.clear(colors.white)
        -- Draw selected colors
        local cursorStart = C.screenWidth / 2
        love.graphics.setColor(self.palette:getColor("primary"))
        love.graphics.line(cursorStart - 5, 0, cursorStart - 2, 0)
        love.graphics.setColor(self.palette:getColor("secondary"))
        love.graphics.line(cursorStart + 2, 0, cursorStart + 5, 0)
    end)
    screen.render(self)
end

return splitter
