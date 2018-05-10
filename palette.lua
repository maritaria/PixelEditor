local palette = {}

function palette:init(width, height)
	assert(width * height > 0, "size cannot be zero")
	self.width = width
	self.height = height
	self.data = {}
end

function palette:convertHexToColor(hex)
    hex = hex:gsub("#","")
    return {
		tonumber("0x"..hex:sub(1,2)) / 255,
		tonumber("0x"..hex:sub(3,4)) / 255,
		tonumber("0x"..hex:sub(5,6)) / 255
	}
end

function palette:getDataPos(x, y)
	assert(x > 0 and x <= self.width)
	assert(y > 0 and y <= self.height)
	return (x + ((y - 1) * self.width))
end

function palette:addColor(color)
	table.insert(self.data, color)
end

function palette:setColor(x, y, color)
	self.data[self:getDataPos(x, y)] = color
end

function palette:getColor(x, y)
	return self.data[self:getDataPos(x, y)]
end

--[[
-- https://html-color-codes.info/colors-from-image/
-- http://i.imgur.com/nj9T2aO.png
palette:addColorHex("#4D1F4D")
palette:addColorHex("#A63A82")
palette:addColorHex("#A64B4B")
palette:addColorHex("#15788C")
palette:addColorHex("#266EFF")
palette:addColorHex("#283B73")
palette:addColorHex("#341F34")

palette:addColorHex("#FFBCA6")
palette:addColorHex("#FF5983")
palette:addColorHex("#F37C55")
palette:addColorHex("#14CC80")
palette:addColorHex("#00D5FF")
palette:addColorHex("#8CB2FF")
palette:addColorHex("#642DB3")

palette:addColorHex("#FFFFFF")
palette:addColorHex("#FFEECC")
palette:addColorHex("#FFC34D")
palette:addColorHex("#CBE545")
palette:addColorHex("#80FFEA")
palette:addColorHex("#DAEAF2")
palette:addColorHex("#6F66CC")
--]]

return palette
