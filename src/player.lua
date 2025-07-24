local Player = {
    money = 0,
    seeds = 1,
    buySeeds = {
        x = 32,
        y = 66,
        w = 64,
        h = 8,
    },
    level = 1,
    experience = 0,
    seedImage = love.graphics.newImage("assets/seed.png")
}
Player.__index = Player
Player.seedImage:setFilter("nearest", "nearest")

-- XP Formula = (self.level * 100)

function Player:draw(font)
    local moneyTextWidth = font:getWidth(self.money .. "$")
    love.graphics.print(self.money .. "$", Util.Dimensions.gameWidth-moneyTextWidth, 0)
    love.graphics.draw(self.seedImage, 0, 0)
    love.graphics.print(self.seeds, 10, 0)
    self:Button()
    self:XPBar(font)
end

function Player:update(dt)
    if self.experience >= self.level * 100 then
        self.experience = self.experience - self.level * 100
        self.level = self.level + 1
    end
end

function Player:Button()
    love.graphics.rectangle("fill", self.buySeeds.x, self.buySeeds.y, self.buySeeds.w, self.buySeeds.h)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Buy Seed", 48, 65)
    love.graphics.rectangle("line", self.buySeeds.x, self.buySeeds.y, self.buySeeds.w, self.buySeeds.h)
    love.graphics.setColor(1, 1, 1)
end

function Player:buy()
    if self.money >= 10 then
        self.money = self.money - 10
        self.seeds = self.seeds + 1
    end
end

function Player:XPBar(font)
    local percent = self.experience / (self.level * 100) * 100
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("fill", 0, Util.Dimensions.gameHeight - 8, Util.Dimensions.gameWidth, 8)
    love.graphics.setColor(0, 1, 0)
    local xpWidth = (self.experience / (self.level * 100)) * Util.Dimensions.gameWidth
    love.graphics.rectangle("fill", 0, Util.Dimensions.gameHeight - 8, xpWidth, 8)
    love.graphics.setColor(1, 1, 1)
    local levelWidth = font:getWidth("Level: " .. self.level) / 2
    love.graphics.print("Level: " .. self.level, Util.Dimensions.gameWidth / 2 - levelWidth, Util.Dimensions.gameHeight - 8)
    love.graphics.print(percent .. "%", 1, Util.Dimensions.gameHeight - 8)
end

function Player:isMouseOverBuy(mx, my)
    return mx >= self.buySeeds.x and mx <= self.buySeeds.x + self.buySeeds.w and
           my >= self.buySeeds.y and my <= self.buySeeds.y + self.buySeeds.h
end

return Player