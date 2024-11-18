local player = {} 

function player:initialize(_imageKey, _hp)
    self.shield = collider(love.graphics.getWidth()/2 - 32, 560, 64, 8)
    self.base = collider(0, love.graphics.getHeight() - 200, love.graphics.getWidth(), 200)

    self.image = assets.images[_imageKey]

    self.maxHp = _hp
    self.hp = self.maxHp
    self.isAlive = true

    self.invencibility = false
    self.invencibilityTimer = 0
    self.invencibilityDuration = 1.5
    self.invencibilityEffectTimer = 0
    self.invencibilitInvisible = false
end

function player:draw()
    local currentFont = love.graphics.getFont()
    love.graphics.draw(assets.images.shield, self.shield.x, self.shield.y, 0, 1, 1, 0, 0)
    love.graphics.setColor(self.invencibilitInvisible and {1, 1, 1, 0.5} or {1, 1, 1, 1})
    if self.image then
        love.graphics.draw(self.image, self.base.x, self.base.y, 0, love.graphics.getWidth()/assets.images.castle:getWidth(), 256/assets.images.castle:getHeight(), 0, 0)
    end
    love.graphics.setColor(1, 1, 1, 1)
    --debug things
    --love.graphics.rectangle("line", self.shield:getArea())
    --love.graphics.rectangle("line", self.base:getArea())
    love.graphics.print("HP: " .. self.hp .. "/" .. self.maxHp, 16, love.graphics.getHeight() - currentFont:getHeight(" ") - 16)
end

function player:update(deltaTime)
    if self.invencibility then
        --juice
        self.invencibilityEffectTimer = self.invencibilityEffectTimer + deltaTime
        if self.invencibilityEffectTimer >= 0.33 then
            self.invencibilitInvisible = not self.invencibilitInvisible
            self.invencibilityEffectTimer = 0
        end
        self.invencibilityTimer = self.invencibilityTimer + deltaTime
        if self.invencibilityTimer >= self.invencibilityDuration then
            self.invencibilityTimer = 0
            self.invencibility = false --well i won't you hitting my enemy 16456466556 times ar once 
            self.invencibilitInvisible  = false
        end
    end
    if love.keyboard.isDown('a', 'left') then
        self.shield.x = self.shield.x - 600*deltaTime
    elseif love.keyboard.isDown('d', 'right') then
        self.shield.x = self.shield.x + 600*deltaTime
    end
    --if its otside screen back to screen
    if self.shield.x < 0 then
        self.shield.x = 0
    elseif self.shield.x + self.shield.w > love.graphics.getWidth() then
        self.shield.x = love.graphics.getWidth() - self.shield.w 
    end
end

function player:touchmoved(id, x, y, dx, dy, pressure)
    self.shield.x = self.shield.x + dx
    --if its otside screen back to screen
    if self.shield.x < 0 then
        self.shield.x = 0
    elseif self.shield.x + self.shield.w > love.graphics.getWidth() then
        self.shield.x = love.graphics.getWidth() - self.shield.w 
    end
end

function player:reset()
    self.hp = self.maxHp
    self.isAlive = true
end

return player