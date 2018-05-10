C = {}
C.pixelSize = 12
C.screenWidth = 80
C.screenHeight = 60

function love.conf(t)
    t.identity = "TinyScreen"
    t.version = "11.0"
    t.console = true

    t.window.resizable = false
    t.window.width = C.pixelSize * C.screenWidth
    t.window.height = C.pixelSize * C.screenHeight
end
