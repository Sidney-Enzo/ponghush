function love.conf(t)
    --% Window
    t.window.height = 780
    t.window.width = 426
    t.window.minwidth = 1
    t.window.minheight = 1
    t.window.title = "pongRush"
    t.window.icon = "icon.png"
    t.window.x = nil
    t.window.y = nil
    t.window.display = 1
    t.window.borderless = false
    t.window.resizable = false
    --t.window.fullscreen = true
    t.window.depth = 16 

    --% Debug
    --t.console = true
    --t.version = "11.4"

    --% Storage
    t.externalstorage = true
    t.identity  = "com.orangeFox.pongRush"

    --% Modules
    t.modules.audio = true
    t.modules.data = true
    t.modules.event = true
    t.modules.font = true
    t.modules.graphics = true
    t.modules.image = true
    t.modules.joystick = true
    t.modules.keyboard = true
    t.modules.math = true
    t.modules.mouse = true
    t.modules.physics = true
    t.modules.sound = true
    t.modules.system = true
    t.modules.thread = true
    t.modules.timer = true
    t.modules.touch = true
    t.modules.video = true
    t.modules.window = true
end