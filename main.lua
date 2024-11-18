local function loadLibaries(_libariesList)
    for varName, libaryName in pairs(_libariesList) do
        _G[varName] = require(libaryName)
    end
end

local function loadAddons(_loveAddons)
    for _, addonFileName in ipairs(_loveAddons) do
        require(addonFileName)
    end
end

local function loadStates(_statesList)
    states = {}
    for stateName, stateFileName in pairs(_statesList) do
        states[stateName] = require(stateFileName)
    end
end

function love.graphics.getQuads(textureSource, ...)
    local function overload(quadSource, ...)
        if type(quadSource) == 'number' then
            return nil, quadSource, ...
        end

        return json.decode(love.filesystem.read(quadSource))
    end

    local texture = love.graphics.newImage(textureSource)
    local sparrow, quadWidth, quadHeight, quadPaddingX, quadPaddingY = overload(...)
    local quads = {}

    if sparrow then
        for _, quad in ipairs(sparrow.frames) do
            table.insert(quads, 
                love.graphics.newQuad(
                    quad.frame.x,
                    quad.frame.y,
                    quad.frame.w,
                    quad.frame.h,
                    texture
                )
            )
        end

        return texture, quads
    end

    for quadY = 0, texture:getHeight(), quadHeight + (quadPaddingY or 0) do
        for quadX = 0, texture:getWidth(), quadWidth + (quadPaddingX or 0) do
            table.insert(quads,
                love.graphics.newQuad(
                    quadX,
                    quadY,
                    quadWidth,
                    quadHeight,
                    texture
                )
            )
        end
    end
    
    return texture, quads
end

function love.load()
--&libares
    json = require("libaries/json")
    milk = json.decode(love.filesystem.read("source/helpers/milk.json"))
    loadLibaries(milk.libaries)
--&addons
    loadAddons(milk.addons)
--&strings
    --%strings
    system = love.system.getOS()
    --%booleans
    isMobile = (system == "Android" or system == "iOS")
    --&tables
    loadStates(milk.states)
--&assets
    --%font
--&body
--     if love.graphics.getWidth() > love.graphics.getHeight() then
--         love.graphics.getWidth, love.graphics.getHeight = love.graphics.getHeight, love.graphics.getWidth
--     end
    love.window.setFullscreen(isMobile)
    love.graphics.setDefaultFilter("nearest", "nearest") --better filter
    gamestate.registerEvents({"update", "textinput", "textedited", "keypressed", "touchpressed", "touchmoved", "touchreleased", "wheelmoved", "mousepressed", "mousemoved", "mousereleased"})
    gamestate.switch(states[milk.stateStart])
end

function love.draw()
    gamestate.current():draw()
    suit.draw()
end