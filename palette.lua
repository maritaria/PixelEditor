local palette = {}

local function fromHex(hex)
    hex = hex:gsub("#","")
    return {
		tonumber("0x"..hex:sub(1,2)) / 255,
		tonumber("0x"..hex:sub(3,4)) / 255,
		tonumber("0x"..hex:sub(5,6)) / 255
	}
end

-- https://html-color-codes.info/colors-from-image/
-- http://i.imgur.com/nj9T2aO.png

table.insert(palette, fromHex("#4D1F4D"))
table.insert(palette, fromHex("#A63A82"))
table.insert(palette, fromHex("#A64B4B"))
table.insert(palette, fromHex("#15788C"))
table.insert(palette, fromHex("#266EFF"))
table.insert(palette, fromHex("#283B73"))
table.insert(palette, fromHex("#341F34"))

table.insert(palette, fromHex("#FFBCA6"))
table.insert(palette, fromHex("#FF5983"))
table.insert(palette, fromHex("#F37C55"))
table.insert(palette, fromHex("#14CC80"))
table.insert(palette, fromHex("#00D5FF"))
table.insert(palette, fromHex("#8CB2FF"))
table.insert(palette, fromHex("#642DB3"))

table.insert(palette, fromHex("#FFFFFF"))
table.insert(palette, fromHex("#FFEECC"))
table.insert(palette, fromHex("#FFC34D"))
table.insert(palette, fromHex("#CBE545"))
table.insert(palette, fromHex("#80FFEA"))
table.insert(palette, fromHex("#DAEAF2"))
table.insert(palette, fromHex("#6F66CC"))

return palette
