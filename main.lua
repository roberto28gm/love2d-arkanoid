VIRTUAL_WIDTH  = 640
VIRTUAL_HEIGHT = 360
scale = 1
offsetX = 0
offsetY = 0


local Pala = require("pala")
local Bloque = require("bloque")
local Bola = require("bola")

bloques = {}

function love.load()
    -- cambiar tamaño ventana
    love.window.setMode(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, { resizable = true })
    love.graphics.setDefaultFilter("nearest", "nearest")
    resize()
    

    
    -- instanciar la pala (player)
    pala = Pala.new()

    -- instanciar los bloques
    crearBloques(3, 10)

    -- instanciar bola
    bola = Bola.new(100, 100)
end


function love.update(dt)
    pala:update(dt)
    bola:update(dt)


    -- Controles de ventana
    if love.keyboard.isDown("escape")then
        love.window.close()
    end

    if love.keyboard.isDown("f")then
        love.window.setFullscreen(true, "desktop")
    end

    -- COLISIONES BOLA-PALA
    if rectsCollide(bola, pala) and bola.vy > 0 then
        -- centros
        local paddleCenter = pala.x + pala.w / 2
        local ballCenter   = bola.x + bola.w / 2

        -- distancia al centro (normalizada)
        local offset  = ballCenter - paddleCenter
        local percent = offset / (pala.w / 2)

        -- velocidad Arkanoid
        local speed = 220
        bola.vx = percent * speed
        bola.vy = -math.abs(bola.vy)

        -- recolocar para evitar vibraciones
        bola.y = pala.y - bola.h
    end

    -- COLISIONES BOLA-BLOQUE
    for _, bloque in ipairs(bloques) do
        if bloque.alive and rectsCollide(bola, bloque) then
            bloque.alive = false
            bola.vy = -bola.vy
            break
        end
    end


end


function love.draw()
    love.graphics.push()
    love.graphics.translate(offsetX, offsetY)
    love.graphics.scale(scale)

    -- dibujar marco de juego
    love.graphics.setLineWidth(4)
    love.graphics.rectangle("line", 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    -- dibujar pala
    pala:draw()
    
    -- dibujar tabla de bloques
    for _, bloque in ipairs(bloques) do
        bloque:draw()
    end

    -- dibujar bola
    bola:draw()

    love.graphics.pop()
    
end


function crearBloques(rows, cols)
    local startX, startY = 32, 32
    local spacing = 8
    local w, h = 32, 8

    for row = 1, rows do
        for col = 1, cols do
            local x = startX + (col - 1) * (w + spacing)
            local y = startY + (row - 1) * (h + spacing)
            table.insert(bloques, Bloque.new(x, y))
        end
    end

end


function resize()
    local w, h = love.graphics.getDimensions()

    scale = math.min(
        w / VIRTUAL_WIDTH,
        h / VIRTUAL_HEIGHT
    )

    offsetX = (w - VIRTUAL_WIDTH * scale) / 2
    offsetY = (h - VIRTUAL_HEIGHT * scale) / 2
end


function love.resize()
    resize()
end


-- COLISIONES
function rectsCollide(a, b)
    return a.x < b.x + b.w and
           a.x + a.w > b.x and
           a.y < b.y + b.h and
           a.y + a.h > b.y
end