require("src.util")
local anim8 = require("vendor.anim8")

local image, animation

Player = {}
Player.__index = Player

function Player:new(x, y, w, h, imagePath)
    local obj = setmetatable({}, Player)
    image = love.graphics.newImage(imagePath)
    local g = anim8.newGrid(16, 16, image:getWidth(), image:getHeight())
    animation = anim8.newAnimation(g("1-4", 2), 0.3)
    obj.x = x
    obj.y = y
    obj.w = w
    obj.h = h
    obj.score = 1337
    return obj
end

function Player:draw(font)
    animation:draw(image, self.x, self.y)
    local scoreWidth = font:getWidth("Chris ist Doof") / 2
    love.graphics.print("Chris ist Doof", Util.Dimensions.gameWidth / 2 - scoreWidth, 0)
end

function Player:update(dt)
    animation:update(dt)
end

return Player