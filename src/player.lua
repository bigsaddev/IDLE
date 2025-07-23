local Player = {
    money = 0,
}
Player.__index = Player

function Player:draw()
    love.graphics.print(self.money, 2, 2)
end

return Player