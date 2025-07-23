local Crop = {}
Crop.__index = Crop

function Crop:new(x, y) 
    return setmetatable({
        x = x,
        y = y,
        state = "empty",
        growTime = 2,
        timer = 0,
    }, Crop)
end

function Crop:plant()
    if self.state == "empty" then
        self.state = "growing"
        self.timer = 0
    end
end

function Crop:update(dt)
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

    if self.state == "empty" then
        love.graphics.setColor(0.4, 0.25, 0)
    elseif self.state == "growing" then
        love.graphics.setColor(0.75, 0.75, 0)
    elseif self.state == "grown" then
        love.graphics.setColor(0.5, 0.9, 0.5)
    end

    love.graphics.rectangle("fill", px, py, 16, 16)

    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("line", px, py, 16, 16)

    if self.state == "growing" then
        local progress = math.min(self.timer / self.growTime, 1)
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", px + 1, py + 14, (14 * progress), 1)
    end
end

return Crop