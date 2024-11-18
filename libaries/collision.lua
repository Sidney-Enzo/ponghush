local collision = {}

function collision.rectangleRectangle(_rectangle1, _rectangle2)
    return _rectangle1.x <= _rectangle2.x + _rectangle2.w and
    _rectangle1.y <= _rectangle2.y + _rectangle2.h and 
    _rectangle1.x + _rectangle1.w >= _rectangle2.x and 
    _rectangle1.y + _rectangle1.h >= _rectangle2.y
end

function collision.pointRectangle(_point, _rectangle)
    return _point.x <= _rectangle.x + _rectangle.w and
    _point.y <= _rectangle.y + _rectangle.h and 
    _point.x >= _rectangle.x and 
    _point.y >= _rectangle.y
end

function collision.circleRectangle(_circle, _rectangle)
    local distance = {}
    distance.x, distance.y = math.abs(_circle.x - _rectangle.x), math.abs(_circle.y - _rectangle.y)
    if distance.x > _rectangle.w * 0.5 + _circle.r then
        return false
    end
    if distance.y > _rectangle.h * 0.5 + _circle.r then
        return false
    end
    local circleDistanceSquare = (distance.x - _rectangle.w * 0.5) * (distance.x - _rectangle.w * 0.5) + (distance.y - _rectangle.h * 0.5) * (distance.y - _rectangle.h * 0.5) 
    return circleDistanceSquare <= _circle.r * _circle.r
end

return collision 