local options = {}

function options:enter()
    sfxSlider = {min = 0, value = lollipop.currentSave.user.audio.sfx, max = 1}
    mscSlider = {min = 0, value = lollipop.currentSave.user.audio.music, max = 1}
end

function options:draw()
    local currentFont = love.graphics.getFont()
    love.graphics.print("Audio", love.graphics.getWidth()/2, 16, 0, 1.5, 1.5, currentFont:getWidth("Audio")/2, 0)
    love.graphics.print("SFX", love.graphics.getWidth()/2 - 128, 128)
    love.graphics.print(math.floor(sfxSlider.value*100) .. "%", love.graphics.getWidth()/2 + 144, 160)
    love.graphics.print("MSC", love.graphics.getWidth()/2 - 128, 256)
    love.graphics.print(math.floor(mscSlider.value*100) .. "%", love.graphics.getWidth()/2 + 144, 288)
end

function options:update()
    suit.Slider(sfxSlider, {id = 'sfx'}, love.graphics.getWidth()/2 - 128, 160, 256, 32)
    suit.Slider(mscSlider, {id = 'msc'}, love.graphics.getWidth()/2 - 128, 288, 256, 32)
    if suit.Button("X", {id = 'backToMainMenu'}, love.graphics.getWidth() - 32, 0).hit then
        states.mainMenu:switchSubstate()
        lollipop.currentSave.user.audio.sfx = sfxSlider.value
        lollipop.currentSave.user.audio.music = mscSlider.value
        lollipop.saveCurrentSlot()
    end
end

return options