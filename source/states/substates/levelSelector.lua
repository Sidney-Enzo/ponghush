local levelSelector = {} 

function levelSelector:enter()
    
end

function levelSelector:draw()
    local currentFont = love.graphics.getFont()
    
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(assets.images.level1Icon, love.graphics.getWidth()/2 - 112, love.graphics.getHeight()/2, 0, 1, 1, 0, 0)
    love.graphics.print("1", love.graphics.getWidth()/2 - 80, love.graphics.getHeight()/2 + 32, 0, 1, 1, currentFont:getWidth("1")/2, currentFont:getHeight(" ")/2)
    if lollipop.currentSave.game.levelsReacheds[1] then
        love.graphics.setColor(1, 1, 1, 1)
    else
        love.graphics.setColor(1, 1, 1, 0.25)
    end
    love.graphics.draw(assets.images.level2Icon, love.graphics.getWidth()/2 - 32, love.graphics.getHeight()/2, 0, 1, 1, 0, 0)
    love.graphics.print("2", love.graphics.getWidth()/2, love.graphics.getHeight()/2 + 32, 0, 1, 1, currentFont:getWidth("2")/2, currentFont:getHeight(" ")/2)
    if lollipop.currentSave.game.levelsReacheds[2] then
        love.graphics.setColor(1, 1, 1, 1)
    else
        love.graphics.setColor(1, 1, 1, 0.25)
    end
    love.graphics.draw(assets.images.level3Icon, love.graphics.getWidth()/2 + 48, love.graphics.getHeight()/2, 0, 1, 1, 0, 0)
    love.graphics.print("3", love.graphics.getWidth()/2 + 80, love.graphics.getHeight()/2 + 32, 0, 1, 1, currentFont:getWidth("3")/2, currentFont:getHeight(" ")/2)
    love.graphics.setColor(1, 1, 1, 1)
end

function levelSelector:update(deltaTime)
    if suit.Button("X", {id = 'backToMainMenu'}, love.graphics.getWidth() - 32, 0).hit then
        gamestate.switch(states.mainMenu)
    end

    if suit.Button("", {id = "level1"}, love.graphics.getWidth()/2 - 112, love.graphics.getHeight()/2, 64, 64).hit then
        player:initialize("castle", 30)
        enemy:initialize("catapults", 100, false, 200)
        balls:initialize("fireball", 1, 0.5, 5)
        love.graphics.setBackgroundColor(52/255, 102/255, 38/255, 1)
        levelNumber = 1
        gamestate.switch(states.playstate)
    elseif suit.Button("", {id = "level2"}, love.graphics.getWidth()/2 - 32, love.graphics.getHeight()/2, 64, 64).hit and lollipop.currentSave.game.levelsReacheds[1] then
        player:initialize("", 30)
        enemy:initialize("baseballGuy", 150, true, 200)
        balls:initialize("ball", 0.75, 0.4, 5)
        love.graphics.setBackgroundColor(140/255, 129/255, 77/255, 1)
        levelNumber = 2
        gamestate.switch(states.playstate)
    elseif suit.Button("", {id = "level3"}, love.graphics.getWidth()/2 + 48, love.graphics.getHeight()/2, 64, 64).hit and lollipop.currentSave.game.levelsReacheds[2] then
        player:initialize("city", 30)
        enemy:initialize("ovn", 250, false, 200)
        balls:initialize("shot", 0.5, 0.35, 5)
        levelNumber = 3
        gamestate.switch(states.playstate)
    end
end

return levelSelector