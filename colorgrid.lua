local colorgrid = {}

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
	assert(x > 0 and x <= self.width)
	assert(y > 0 and y <= self.height)
	return (x + ((y - 1) * self.width))
end

function colorgrid:addColor(color)
	table.insert(self.data, color)
end

function colorgrid:setColor(x, y, color)
	self.data[self:getDataPos(x, y)] = color
end

function colorgrid:getColor(x, y)
	return self.data[self:getDataPos(x, y)]
end

--[[
-- https://html-color-codes.info/colors-from-image/
-- http://i.imgur.com/nj9T2aO.png
colorgrid:addColorHex("#4D1F4D")
colorgrid:addColorHex("#A63A82")
colorgrid:addColorHex("#A64B4B")
colorgrid:addColorHex("#15788C")
colorgrid:addColorHex("#266EFF")
colorgrid:addColorHex("#283B73")
colorgrid:addColorHex("#341F34")

colorgrid:addColorHex("#FFBCA6")
colorgrid:addColorHex("#FF5983")
colorgrid:addColorHex("#F37C55")
colorgrid:addColorHex("#14CC80")
colorgrid:addColorHex("#00D5FF")
colorgrid:addColorHex("#8CB2FF")
colorgrid:addColorHex("#642DB3")

colorgrid:addColorHex("#FFFFFF")
colorgrid:addColorHex("#FFEECC")
colorgrid:addColorHex("#FFC34D")
colorgrid:addColorHex("#CBE545")
colorgrid:addColorHex("#80FFEA")
colorgrid:addColorHex("#DAEAF2")
colorgrid:addColorHex("#6F66CC")
--]]

return colorgrid
