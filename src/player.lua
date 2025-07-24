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
}
Player.__index = Player

function Player:draw(font)
    local moneyTextWidth = font:getWidth(self.money .. "$")
    love.graphics.print(self.money .. "$", Util.Dimensions.gameWidth-moneyTextWidth, 0)
    love.graphics.print("Seeds: " .. self.seeds, 0, 0)
    self:Button()
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

function Player:isMouseOverBuy(mx, my)
    return mx >= self.buySeeds.x and mx <= self.buySeeds.x + self.buySeeds.w and
           my >= self.buySeeds.y and my <= self.buySeeds.y + self.buySeeds.h
end

return Player