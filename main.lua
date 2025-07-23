require("src.util")
local push = require("vendor.push")

local Crop = require("src.crop")

local font

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    font = love.graphics.newFont("assets/fonts/Tiny5.ttf", 8)
    love.graphics.setFont(font)

    push:setupScreen(Util.Dimensions.gameWidth, Util.Dimensions.gameHeight, Util.Dimensions.windowWidth, Util.Dimensions.windowHeight, {
        fullscreen = false,
        pixelperfect = true,
        resizable = false,
        highdpi = true,
    })

    gridSize = 6
    tileSize = 16
    crops = {}
    money = 0

    for x = 1, gridSize do
        crops[x] = {}
        for y = 1, gridSize do
            crops[x][y] = Crop:new(x, y)
        end
    end
end

function love.update(dt)
    for x = 1, gridSize do
        for y = 1, gridSize do
            crops[x][y]:update(dt)
        end
    end
end

function love.draw()
    push:start()
    love.graphics.clear({0.33, 0.33, 0.33})
    love.graphics.print("Money: $ " .. money, 0, Util.Dimensions.gameHeight-20)

    for x = 1, gridSize do
        for y = 1, gridSize do
            crops[x][y]:draw()
        end
    end

    push:finish()
end

function love.mousepressed(x, y, button)
    if button == 1 then
        -- Translate screen-space mouse to game-space using push
        local mx, my = push:toGame(x, y)
        if not mx or not my then return end  -- click was outside the game canvas

        local gx = math.floor(mx / tileSize) + 1
        local gy = math.floor(my / tileSize) + 1

        if gx >= 1 and gx <= gridSize and gy >= 1 and gy <= gridSize then
            local crop = crops[gx][gy]
            if crop.state == "empty" then
                crop:plant()
            elseif crop.state == "grown" then
                crop:harvest()
                money = money + 10
            end
        end
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end