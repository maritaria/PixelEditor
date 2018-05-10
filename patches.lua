assert(not love._patched)
love._patched = true

local rectangle = love.graphics.rectangle

function love.graphics.rectangle(mode, x, y, w, h, rx, ry, segments)
    if mode == "line" then
        rectangle(mode, x + 0.1, y, w - 1, h - 1, rx, ry, segments)
    else
        rectangle(mode, x, y, w, h, rx, ry, segments)
    end
end

local line = love.graphics.line
function love.graphics.line(x1, y1, x2, y2, ...)
	if type(x1) == "table" then
		return line(x1, y1, x2, y2, ...)
	end
	if #{...} > 0 then
		return line(x1, y1, x2, y2, ...)
	else
		return line(x1, y1, x2 + 0.1, y2 + 0.1)
	end
end
