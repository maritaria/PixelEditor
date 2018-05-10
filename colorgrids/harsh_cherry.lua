-- https://html-color-codes.info/colors-from-image/
-- http://pixeljoint.com/forum/forum_posts.asp?TID=18845
-- https://opengameart.org/sites/default/files/forum-attachments/bright1-demo_0.png

local colorgrid = require("colorgrid")
colorgrid:init(3, 9)

local function set(x, y, hex)
	colorgrid:setColor(x, y, colorgrid:convertHexToColor(hex))
end

set(0, 0, "#101C28")
set(1, 0, "#1D3348")
set(2, 0, "#47617A")
set(0, 1, "#D6748B")
set(1, 1, "#FBB2C3")
set(2, 1, "#FFECF0")
set(0, 2, "#9D9D9D")
set(1, 2, "#434343")
set(2, 2, "#D6AA7B")
