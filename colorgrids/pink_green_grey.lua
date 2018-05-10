-- https://html-color-codes.info/colors-from-image/
-- http://i49.tinypic.com/2ziqxbo.png

local colorgrid = require("colorgrid")
colorgrid:init(17, 8)

local function set(x, y, hex)
	colorgrid:setColor(x, y, colorgrid:convertHexToColor(hex))
end

-- Backbone
set(0, 4, "#757E7E")
set(1, 4, "#5F6163")
set(2, 4, "#433D46")
set(3, 4, "#413458")
set(4, 4, "#41514B")
set(5, 4, "#547B78")
set(6, 4, "#659BA5")
set(7, 4, "#95B3C7")
set(8, 4, "#C4DBDA")--turning point
set(9, 4, "#AFADBC")
set(10, 4, "#8F8A98")
set(11, 4, "#6E6B75")
set(12, 4, "#584755")
set(13, 4, "#7C6C7C")
set(14, 4, "#A19393")
set(15, 4, "#CEC7B0")
set(16, 4, "#F1EDD4")

-- Grey fork
set(0, 5, "#9EA7A4")
set(0, 6, "#C3CAC8")
set(0, 7, "#E1E9E9")

-- Green fork 1
set(2, 5, "#485F4C")
set(2, 6, "#5E8B59")
set(2, 7, "#88B16A")

-- Green fork 2
set(3, 3, "#4A5149")
set(3, 2, "#5E7955")
set(3, 1, "#89A567")
set(3, 0, "#BFC985")

-- Green fork 3
set(4, 5, "#5B765D")
set(4, 6, "#7A9E69")
set(4, 7, "#A9C57A")

-- Blue fork
set(6, 3, "#4B687D")
set(6, 2, "#413458")
set(6, 1, "#331D3C")

-- White stub
set(8, 3, "#E5F7FC")

-- Grey brown fork
set(12, 3, "#706867")
set(12, 2, "#8D8482")
set(12, 1, "#A8A493")
set(12, 0, "#C1C3AD")

-- Pink fork
set(12, 5, "#7F5080")
set(12, 6, "#C254A5")
set(12, 7, "#DB98AF")
