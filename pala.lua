VIRTUAL_WIDTH  = 640
VIRTUAL_HEIGHT = 360
local Pala = {}
Pala.__index = Pala



function Pala.new()
    local self = setmetatable({}, Pala)
    self.x = 320
    self.y = 360 -32
    self.w = 32
    self.h = 8
    self.speed = 500
    self.sprite = love.graphics.newImage("sprites/pala.png")
    return self
end

function Pala:update(dt)
    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        if self.x >= 0 then
            self.x = self.x - self.speed * dt
        end
    end

    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        if self.x <= VIRTUAL_WIDTH - 32 then
            self.x = self.x + self.speed * dt
        end
    end

end

function Pala:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end

return Pala