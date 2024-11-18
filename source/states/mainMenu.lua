local mainMenu = {} 

function mainMenu:enter()
    levelSelect = require 'source/states/substates/levelSelector'
    options = require 'source/states/substates/options'

    substate = nil

    love.graphics.setFont(assets.fonts.pongGame)
    love.graphics.setBackgroundColor(0, 0, 0, 1)
end

function mainMenu:draw()
    if substate then
        substate:draw()
    else
        love.graphics.print(translation.mainMenu.title, love.graphics.getWidth()/2, 256, 0, 2, 2,  assets.fonts.pongGame:getWidth(translation.mainMenu.title)/2, 0)
    end
end

function mainMenu:update(deltaTime)
    if substate then
        substate:update(deltaTime)
    else
        if suit.Button(translation.mainMenu.play, { id = "play", font = assets.fonts.pongGame}, love.graphics.getWidth()/2 - 128, 336, 256, 64).hit then
            mainMenu:switchSubstate(levelSelect)
        elseif suit.Button(translation.mainMenu.options, { id = "options", font = assets.fonts.pongGame }, love.graphics.getWidth()/2 - 128, 400, 256, 64).hit then
            mainMenu:switchSubstate(options)
        elseif suit.Button(translation.mainMenu.credits, { id = "credits", font = assets.fonts.pongGame }, love.graphics.getWidth()/2 - 128, 464, 256, 64).hit then
            gamestate.switch(states.credits)
        elseif suit.Button(translation.mainMenu.quit, { id = "quit", font = assets.fonts.pongGame }, love.graphics.getWidth()/2 - 128, 528, 256, 64).hit then
            love.event.quit()
        end
    end
end

function mainMenu:switchSubstate(_substate)
    substate = _substate
    if not substate then
        return
    end
    if substate.enter then
        substate:enter()
    end
end

return mainMenu