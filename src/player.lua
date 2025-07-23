local Player = {
    money = 0,
}
Player.__index = Player

function Player:draw(font)
    local moneyTextWidth = font:getWidth(self.money .. "$")
    love.graphics.print(self.money .. "$", Util.Dimensions.gameWidth-moneyTextWidth, 0)
end

return Player