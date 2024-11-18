local pause = {}

function pause:draw()
    love.graphics.draw(pauseIcons, pauseQuads[1], love.graphics.getWidth()/2 - 64, love.graphics.getHeight()/2 - 64, 0, 4, 4)
    love.graphics.draw(pauseIcons, pauseQuads[3], love.graphics.getWidth()/2 + 80, love.graphics.getHeight()/2 - 32, 0, 2, 2)
    love.graphics.draw(pauseIcons, pauseQuads[4], love.graphics.getWidth()/2 - 144, love.graphics.getHeight()/2 - 32, 0, 2, 2)
end

function pause:update(deltaTime)
    if suit.Button("", {id="unpause"}, love.graphics.getWidth()/2 - 64, love.graphics.getHeight()/2 - 64, 128, 128).hit then
        isPaused = false
    elseif suit.Button("", {id = "backtomenu"}, love.graphics.getWidth()/2 + 80, love.graphics.getHeight()/2 - 32, 64, 64).hit then
        gamestate.switch(states.mainMenu)
    elseif suit.Button("", {id = "options"}, love.graphics.getWidth()/2 - 144, love.graphics.getHeight()/2 - 32, 64, 64).hit then
        states.playstate:switchSubstate(options)
    end
end

return pause