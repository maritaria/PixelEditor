-- https://html-color-codes.info/colors-from-image/
-- http://pixeljoint.com/forum/forum_posts.asp?TID=18845
-- https://opengameart.org/sites/default/files/forum-attachments/bright1-demo_0.png

local colorgrid = require("colorgrid")
colorgrid:init(13, 8)

local function set(x, y, hex)
	colorgrid:setColor(x, y, colorgrid:convertHexToColor(hex))
end

-- Blue bar
set(3, 0, "#94ECEA")
set(4, 0, "#20D2EF")
set(5, 0, "#1F90BC")
set(6, 0, "#204C84")
set(7, 0, "#134646")
set(8, 0, "#15212C")
-- Green bar
set(7, 0, "#134646")
set(7, 1, "#187655")
set(7, 2, "#1D933B")
set(7, 3, "#0DBC3A")
set(7, 4, "#81FB4B")
set(7, 5, "#F1F76F")
set(7, 6, "#F7F7AD")
-- Big bar
set(0, 5, "#2B213B")
set(1, 5, "#52294F")
set(2, 5, "#813530")
set(3, 5, "#D91818")
set(4, 5, "#EE6428")
set(5, 5, "#F29A3E")
set(6, 5, "#FAD54A")
set(7, 5, "#F1F76F")
set(8, 5, "#EEC48A")
set(9, 5, "#B98B55")
set(10, 5, "#806640")
set(11, 5, "#583016")
set(12, 5, "#2F2017")
-- Purple tip
set(2, 3, "#E9786A")
set(2, 4, "#C52E5C")
set(2, 5, "#813530")
-- Grey bottom bar
set(2, 7, "#000000")
set(3, 7, "#414653")
set(4, 7, "#78828E")
set(5, 7, "#B2AFA6")
set(6, 7, "#E2DFD4")
set(7, 7, "#FFFFFF")
