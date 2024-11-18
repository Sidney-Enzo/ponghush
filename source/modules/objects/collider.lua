local collider = {}
collider.__index = collider

local function _new(_x, _y, _w, _h)
    local self = setmetatable({
        x = _x,
        y = _y,
        w = _w,
        h = _h,
        velocity = {
            x = 0,
            y = 0
        }
    }, collider)
    return self
end

function collider:setVelocity(_vx, _vy)
    self.velocity.x = _vx
    self.velocity.y = _vy
end

function collider:update(deltaTime)
    self.x = self.x + self.velocity.x*deltaTime
    self.y = self.y + self.velocity.y*deltaTime
end

function collider:colliding(_collider2)
    return self.x + self.w >= _collider2.x and self.y + self.h >= _collider2.y and self.x <= _collider2.x + _collider2.w and self.y <= _collider2.y + _collider2.h
end

function collider:getPosition()
    return self.x, self.y
end

function collider:getArea()
    return self.x, self.y, self.w, self.h
end

return setmetatable(collider, {
    __call = function(_, ...)
        return _new(...)
    end
})