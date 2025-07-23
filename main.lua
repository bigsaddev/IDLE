require("src.util")
local push = require("vendor.push")
local Field = require("src.field")

local font
local field
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

    field = Field:new(32, 64)
end

function love.update(dt)
    field:update(dt)
end

function love.draw()
    push:start()
    love.graphics.clear({0.33, 0.66, 0.33})
    field:draw()
    push:finish()
end

function love.mousepressed(x, y, button)
    if button == 1 then
        local virtualX, virtualY = push:toGame(x, y)
        -- Check if the click is within the field area
        if virtualX and virtualY then
            field:click(virtualX, virtualY)
        end
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end