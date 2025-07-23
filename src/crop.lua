local Crop = {}
Crop.__index = Crop

local anim8 = require("vendor.anim8")

function Crop:new(x, y)
    local grid = anim8.newGrid(16, 16, 48, 16)
    local sprite = love.graphics.newImage("assets/crops.png")

    local animations = {
        empty = anim8.newAnimation(grid("1-1", 1), 1),
        growing = anim8.newAnimation(grid("2-2", 1), 1),
        grown = anim8.newAnimation(grid("3-3", 1), 1),
    }

    return setmetatable({
        x = x,
        y = y,
        state = "empty",
        growTime = 2,
        timer = 0,
        animations = animations,
        sprite = sprite,
        currentAnimation = animations.empty
    }, Crop)
end

function Crop:plant()
    if self.state == "empty" then
        self.state = "growing"
        self.timer = 0
    end
end

function Crop:update(dt)
    -- update animation regardless of state, future proofing for more frames lmao
    self.currentAnimation:update(dt)

    if self.state == "growing" then
        self.timer = self.timer + dt
        if self.timer >= self.growTime then
            self.state = "grown"
        end
    end
end

function Crop:harvest()
    if self.state == "grown" then
        self.state = "empty"
        self.timer = 0
    end
end

function Crop:draw(offsetX, offsetY)
    local px = offsetX + (self.x - 1) * 16
    local py = offsetY + (self.y - 1) * 16

    -- Set correct animation based on state
    if self.state == "empty" then
        self.currentAnimation = self.animations.empty
    elseif self.state == "growing" then
        self.currentAnimation = self.animations.growing
    elseif self.state == "grown" then
        self.currentAnimation = self.animations.grown
    end

    -- Draw current frame of the animation
    self.currentAnimation:draw(self.sprite, px, py)

    -- Draw growth bar if growing
    if self.state == "growing" then
        local progress = math.min(self.timer / self.growTime, 1)
        love.graphics.setColor(0, 1, 0)
        love.graphics.rectangle("fill", px + 1, py + 14, (14 * progress), 1)
    end

    -- Reset color
    love.graphics.setColor(1, 1, 1)
end

return Crop