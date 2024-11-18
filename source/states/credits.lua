local credits = {} 

function credits:enter()
    
end

function credits:draw()
    currentFont = love.graphics.getFont()
    love.graphics.print("Created by Foxy", love.graphics.getWidth()/2, 16, 0, 1, 1, currentFont:getWidth("Create by Foxy")/2, 0)
end

function credits:update(deltaTime)
    if suit.Button("X", {id = 'backToMainMenu'}, love.graphics.getWidth() - 32, 0).hit then
        gamestate.switch(states.mainMenu)
    end
end

return credits