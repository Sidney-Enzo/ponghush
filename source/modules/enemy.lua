local enemy = {} 

function enemy:initialize(_name, _hp, _hasShield, _shieldSpeed)
    self.base = collider(0, 0, love.graphics.getWidth(), 256)
    if _hasShield then
        self.shield = collider(love.graphics.getWidth()/2 - 32, 272, 64, 8)
        self.shield.velocity.x = _shieldSpeed
    end 
    self.image = assets.images[_name]
    self.maxHp = _hp
    self.hp = self.maxHp
    self.isAlive = true
    self.invencibility = false
    self.invencibilityTimer = 0
    self.invencibilityDuration = 0.75
    self.invencibilityEffectTimer = 0
    self.invencibilitInvisible = false
end

function enemy:draw()
    love.graphics.setColor(self.invencibilitInvisible and {1, 1, 1, 0.5} or {1, 1, 1, 1})
    love.graphics.draw(self.image, 0, 0, 0, love.graphics.getWidth()/self.image:getWidth(), 256/self.image:getHeight(), 0, 0)
    love.graphics.setColor(1, 1, 1, 1)

    --love.graphics.rectangle("line", self.base:getArea())
    if self.shield then
        love.graphics.draw(assets.images.enemyShield, self.shield.x, self.shield.y, 0, 1, 1, 0, 0)
        --love.graphics.rectangle("line", self.shield:getArea())
    end
    love.graphics.print("HP: " .. self.hp .. "/" .. self.maxHp, 16, 16)
end

function enemy:update(deltaTime)
    if self.invencibility then
        self.invencibilityEffectTimer = self.invencibilityEffectTimer + deltaTime
        if self.invencibilityEffectTimer >= 0.33 then
            self.invencibilitInvisible = not self.invencibilitInvisible
            self.invencibilityEffectTimer = 0
        end
        self.invencibilityTimer = self.invencibilityTimer + deltaTime
        if self.invencibilityTimer >= self.invencibilityDuration then
            self.invencibilityTimer = 0
            self.invencibility = false
            self.invencibilitInvisible = false
        end
    end
end

function enemy:fixedUpdate(fixedDeltaTime)
    if self.shield then
        self.shield:update(fixedDeltaTime)
        if self.shield.x < 0 then
            self.shield.x = 0
            self.shield.velocity.x = -self.shield.velocity.x
        elseif self.shield.x + self.shield.w > love.graphics.getWidth() then
            self.shield.x = love.graphics.getWidth() - self.shield.w
            self.shield.velocity.x = -self.shield.velocity.x
        end
    end
end

function enemy:reset()
    self.hp = self.maxHp
    self.isAlive = true
end

return enemy