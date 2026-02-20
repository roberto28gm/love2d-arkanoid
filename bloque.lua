local Bloque = {}
Bloque.__index = Bloque

function Bloque.new(x, y)
    local self = setmetatable({}, Bloque)
    self.x = x
    self.y = y
    self.w = 32
    self.h = 8
    self.alive = true
    self.sprite = love.graphics.newImage("sprites/bloque1.png")
    return self
end

function Bloque:update(dt)

end

function Bloque:draw()
    if not self.alive then 
        return 
    end
    
    love.graphics.draw(self.sprite, self.x, self.y)
end

return Bloque