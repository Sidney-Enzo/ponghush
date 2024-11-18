return {
    name = "Pong hush",
    developer = "Fox studio",
    output = "./build",
    version = "0.0.2",
    love = "11.5",
    ignore = {
        "make.cmd",
        "build.lua",
        "CHANGELOG"
    },
    icon = "assets/images/icon.png",
    identifier = "com.foxStudio.pongHush", 
    libs = { 
        all = {"LICENSE"}
    },
    platforms = {"windows", "linux", "macos"} 
}