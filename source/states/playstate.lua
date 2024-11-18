local playstate = {} 

function playstate:enter()
    pause = require 'source/states/substates/pause'

    pauseIcons, pauseQuads = love.graphics.getQuads('assets/images/icons.png', 'assets/images/icons.json')
    viewCamera = camera.new()
    isPaused = false
    substate = nil
    amountDeltaTime = 0
end

function playstate:draw()
    viewCamera:attach()
    local currentFont = love.graphics.getFont()
    if not player.isAlive then
        love.graphics.print(translation.game.gameOver, love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, 2, 2, currentFont:getWidth(translation.game.gameOver)/2, currentFont:getHeight(" ")/2)
    elseif not enemy.isAlive then
        love.graphics.print(translation.game.win, love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, 2, 2, currentFont:getWidth(translation.game.win)/2, currentFont:getHeight(" ")/2)
    else
        player:draw()
        enemy:draw()
        balls:draw()
    end
    viewCamera:detach()
    if substate then
        love.graphics.setColor(0, 0, 0, 0.75)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(1, 1, 1, 1) -- when theres some substate it will cover the entire screen with a transparent black rectangle
        substate:draw()
    end
end

function playstate:update(deltaTime)
    if substate then
        substate:update(deltaTime)
        return
    end
    if player.isAlive and enemy.isAlive then
        player:update(deltaTime)
        enemy:update(deltaTime)
        balls:update(deltaTime)

        --physics shit
        local fixedDeltaTime = 1/60 -- how many times update per second
        amountDeltaTime = amountDeltaTime + deltaTime --basicaly a timer with a different name
        while amountDeltaTime >= fixedDeltaTime do
            enemy:fixedUpdate(fixedDeltaTime)
            balls:fixedUpdate(fixedDeltaTime)
            amountDeltaTime = amountDeltaTime - fixedDeltaTime
        end
        
        if suit.Button("||", {id = "pause"}, love.graphics.getWidth() - 32, 0, 32, 32).hit then
            playstate:switchSubstate(pause)
        end
    else
        if suit.Button(translation.game.restart, {id = "restart"}, love.graphics.getWidth()/2 - 256, love.graphics.getHeight()/2 + 32, 256, 32).hit then
            player:reset()
            enemy:reset()
            balls:reset()
            gamestate.switch(states.playstate)
        elseif suit.Button(translation.game.mainMenu, {id = "main_menu"}, love.graphics.getWidth()/2, love.graphics.getHeight()/2 + 32, 256, 32).hit then
            gamestate.switch(states.mainMenu)
        end
    end
end

function playstate:touchmoved(id, x, y, dx, dy, pressure)
    if player.isAlive or enemy.isAlive then
        player:touchmoved(id, x, y, dx, dy, pressure)
    end
end

function playstate:switchSubstate(_substate)
    substate = _substate
    if not substate then
        return
    end
    if substate.enter then
        substate:enter()
    end
end

return playstate