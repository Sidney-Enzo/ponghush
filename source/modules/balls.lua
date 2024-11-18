local balls = {} 

function love.audio.playAnyway(_source)
    if _source:isPlaying() then
        _source:seek(0)
        return
    end
    _source:play()
end

local function lerp(a, b, t) 
    return a + (b - a)*t
end

function balls:initialize(_type, _initialSpawnRateSeconds, _maxSpawnRateSeconds, _damage)
    self.list = {}

    self.type = _type

    self.damage = _damage

    self.spawnTimer = 0
    self.initialSpawnRate = _initialSpawnRateSeconds
    self.maxSpawnRate = _maxSpawnRateSeconds
end

function balls:draw()
    for i, ball in ipairs(self.list) do
        love.graphics.draw(assets.images[self.type], ball.x, ball.y, 0, 1, 1, 0, 0)
        --love.graphics.rectangle("line", ball:getArea())
    end
end

function balls:update(deltaTime)
    self.spawnTimer = self.spawnTimer + deltaTime
    if self.spawnTimer >= lerp(self.maxSpawnRate, self.initialSpawnRate, enemy.hp/enemy.maxHp) then
        balls:new(love.math.random(0, love.graphics.getWidth() - 16), 278, 16, 16, love.math.random(-200, 200), love.math.random(200, 400))
        self.spawnTimer = 0
    end
end

function balls:fixedUpdate(fixedDeltaTime)
    for i, ball in ipairs(self.list) do
        ball:update(fixedDeltaTime)
        --walls to prevent ball get out screen
        if ball.x < 0 then
            ball.x = 0
            ball.velocity.x = -ball.velocity.x
        elseif ball.x + ball.w > love.graphics.getWidth() then
            ball.x = love.graphics.getWidth() - ball.w
            ball.velocity.x = -ball.velocity.x
        end
        if ball:colliding(player.shield) then
            ball.velocity.y = -ball.velocity.y
            ball.y = player.shield.y - ball.h
            love.audio.playAnyway(assets.audios.pong)
        elseif ball:colliding(player.base) then --player hitbox
            table.remove(self.list, i) --delete ball
            if player.invencibility then return end

            player.hp = player.hp - self.damage
            if player.hp <= 0 then
                player.isAlive = false
            end
            player.invencibility = true
        elseif ball:colliding(enemy.base) then --enemy hitbox
            table.remove(self.list, i) --delete ball
            if enemy.invencibility then return end
            enemy.hp = enemy.hp - self.damage
            if enemy.hp <= 0 then
                enemy.isAlive = false
                lollipop.currentSave.game.levelsReacheds[levelNumber] = true
                lollipop.saveCurrentSlot()
            end
            enemy.invencibility = true
        elseif enemy.shield then
            if ball:colliding(enemy.shield) then 
                table.remove(self.list, i) --delete ball
                love.audio.playAnyway(assets.audios.pong)
            end
        end
    end
end

function balls:new(_x, _y, _w, _h, _vx, _vy) --its just a fake instance
    newBall = collider(_x, _y, _w, _h)
    newBall:setVelocity(_vx, _vy)
    table.insert(self.list, newBall)
end

function balls:reset()
    self.spawnTimer = 0
    self.list = {}
end

return balls