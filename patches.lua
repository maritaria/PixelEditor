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
