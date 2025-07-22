require("src.util")

require("src.player.player")
local push = require("vendor.push")

local font

local player = Player:new(50, 50, 50, 50, "assets/player.png")


function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    font = love.graphics.newFont("assets/fonts/Tiny5.ttf", 8)
    love.graphics.setFont(font)

    push:setupScreen(Util.Dimensions.gameWidth, Util.Dimensions.gameHeight, Util.Dimensions.windowWidth, Util.Dimensions.windowHeight, {
        fullscreen = false,
        pixelperfect = true,
        resizable = false,
    })
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    push:start()
    love.graphics.clear({0.33, 0.33, 0.33})
    player:draw(font)
    push:finish()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end