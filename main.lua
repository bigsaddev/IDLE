require("src.util")
local push = require("vendor.push")
local Field = require("src.field")
local player = require("src.player")

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

    field = Field:new(0, 0)
end

function love.update(dt)
    field:update(dt)
end

function love.draw()
    push:start()
    love.graphics.clear({0.184, 0.141, 0.259})
    field:draw()
    player:draw(font)
    push:finish()
end

function love.mousepressed(x, y, button)
    local virtualX, virtualY = push:toGame(x, y)
    if button == 1 then
        -- Check if the click is within the field area
        if virtualX and virtualY then
            field:click(virtualX, virtualY)
        end
        if player:isMouseOverBuy(virtualX, virtualY) then
            player:buy()
        end
    end

end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end