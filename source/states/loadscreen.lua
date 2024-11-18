local loadscreen = {} 

local function initializeSaveSys()
    lollipop.currentSave.user = {
        language = "en-eua",
        audio = {
            sfx = 0.75,
            music = 0.75
        }
    }
    lollipop.currentSave.game = {
        levelsReacheds = {false, false, false} --eách index represent the level number
    }
    lollipop.initializeSlot("data") --choco's save system <3
end

local function drawLoadbar(_percentageCompleat, _x, _y, _w, _h)
    love.graphics.clear(0, 0, 0, 1)
    love.graphics.rectangle("fill", _x, _y, _w*_percentageCompleat, _h)
    love.graphics.rectangle("line", _x, _y, _w, _h)
    love.graphics.draw(orangeFoxIcon, love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, 4, 4, orangeFoxIcon:getWidth()/2, orangeFoxIcon:getHeight()/2)
    love.graphics.present()
end

local function loadAssets()
    collider = require("source/modules/objects/collider")
    player = require("source/modules/player")
    enemy = require("source/modules/enemy")
    balls = require("source/modules/balls")
    
    assets = {
        images = {},
        fonts = {},
        audios = {}
    }

    orangeFoxIcon = love.graphics.newImage('assets/images/orangeFox.png')
    local lovesource = json.decode(love.filesystem.read("source/helpers/lovesource.json"))
    local totalLoaded, totalToLoad = 0, #lovesource.images + #lovesource.fonts + #lovesource.audios
    local loadScreenBarX, loadScreenBarY = love.graphics.getWidth()/2 - 128, love.graphics.getHeight()/2 +64
    for i, image in ipairs(lovesource.images) do
        drawLoadbar(totalLoaded/totalToLoad, loadScreenBarX, loadScreenBarY, 256, 2)
        assets.images[image[1]] = love.graphics.newImage(image[2])
        totalLoaded = totalLoaded + 1
    end

    for i, font in ipairs(lovesource.fonts) do
        drawLoadbar(totalLoaded/totalToLoad, loadScreenBarX, loadScreenBarY, 256, 2)
        assets.fonts[font[1]] = love.graphics.newFont(font[2], font[3])
        totalLoaded = totalLoaded + 1
    end

    for i, audio in ipairs(lovesource.audios) do
        drawLoadbar(totalLoaded/totalToLoad, loadScreenBarX, loadScreenBarY, 256, 2)
        assets.audios[audio[1]] = love.audio.newSource(audio[2], audio[3])
        totalLoaded = totalLoaded + 1
    end
end

function loadscreen:enter()
    initializeSaveSys()
    loadAssets()

    translation = lip.load("source/translate/" .. lollipop.currentSave.user.language .. ".ini")

    suit.theme.color.normal = { bg = { 1, 1, 1, 0 }, fg = { 1, 1, 1, 1 } } --it remove the background
    suit.theme.color.hovered = { bg = { 0.25, 0.25, 0.25, 0.8 }, fg = { 1, 1, 1, 1 } }
    suit.theme.color.active = { bg = { 0.25, 0.25, 0.25, 0.8 }, fg = { 1, 1, 1, 1 } }

    gamestate.switch(states.mainMenu)
end

return loadscreen