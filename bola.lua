VIRTUAL_WIDTH  = 640
VIRTUAL_HEIGHT = 360

local Bola = {}
Bola.__index = Bola

function Bola.new(x, y)
    local self = setmetatable({}, Bola)
    self.x = x
    self.y = y
    self.w = 13
    self.h = 13
    self.r = 13 -- radio, no influye al ser un cuadrado
    self.vx = 200
    self.vy = 200
    self.sprite = love.graphics.newImage("sprites/bola.png")
    return self
end

function Bola:update(dt)
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
    ColisionesMuros(self)
    
end

function ColisionesMuros(self)
-- pared izquierda
    if self.x < 0 then
        self.x = 0
        self.vx = -self.vx
    end

    -- pared derecha
    if self.x > VIRTUAL_WIDTH - self.r then
        self.x = VIRTUAL_WIDTH - self.r
        self.vx = -self.vx
    end

    -- techo
    if self.y < 0 then
        self.y = 0
        self.vy = -self.vy
    end

    -- suelo, a modo de pruebas
    if self.y + self.r > VIRTUAL_HEIGHT then
        self.y = VIRTUAL_HEIGHT - self.r
        self.vy = -self.vy
    end
end

function Bola:draw()
    love.graphics.draw(self.sprite, self.x, self.y, self.r)
end

return Bola