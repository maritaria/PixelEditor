local colorgrid = {}

local colors = require("colors")

function colorgrid:init(width, height)
	assert(width * height > 0, "size cannot be zero")
	self.width = width
	self.height = height
	self.data = {}
end

function colorgrid:convertHexToColor(hex)
    hex = hex:gsub("#","")
    return {
		tonumber("0x"..hex:sub(1,2)) / 255,
		tonumber("0x"..hex:sub(3,4)) / 255,
		tonumber("0x"..hex:sub(5,6)) / 255
	}
end

function colorgrid:getDataPos(x, y)
	assert(x >= 0 and x < self.width, "x out of range")
	assert(y >= 0 and y < self.height, "y out of range")
	return 1 + (x + (y * self.width))
end

function colorgrid:addColor(color)
	table.insert(self.data, color)
end

function colorgrid:setColor(x, y, color)
	self.data[self:getDataPos(x, y)] = color
end

function colorgrid:getColor(x, y)
	return self.data[self:getDataPos(x, y)] or colors.transparent
end

return colorgrid
