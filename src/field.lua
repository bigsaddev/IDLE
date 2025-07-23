local Crop = require ("src.crop")
local player = require("src.player")

local Field = {}
Field.__index = Field

function Field:new(x, y)
    local instance = setmetatable({}, Field)
    instance.x = x
    instance.y = y
    instance.crops = {}
    instance.tileSize = 16
    instance.gridSize = 4
    instance.money = 0
    
    for i = 1, instance.gridSize do
        instance.crops[i] = {}
        for j = 1, instance.gridSize do
            instance.crops[i][j] = Crop:new(i, j)
        end
    end
    return instance
end

function Field:update(dt)
    for x = 1, self.gridSize do
        for y = 1, self.gridSize do
            self.crops[x][y]:update(dt)
        end
    end
end

function Field:draw()
    for x = 1, self.gridSize do
        for y = 1, self.gridSize do
            self.crops[x][y]:draw(self.x, self.y)
        end
    end
end

function Field:click(mx, my)
    -- Convert mouse position to field-local coordinates
    local localX = mx - self.x
    local localY = my - self.y

    -- Which tile was clicked?
    local tileX = math.floor(localX / self.tileSize) + 1
    local tileY = math.floor(localY / self.tileSize) + 1

    -- Check if within field bounds
    if tileX >= 1 and tileX <= self.gridSize and tileY >= 1 and tileY <= self.gridSize then
        local crop = self.crops[tileX][tileY]

        if crop.state == "empty" and player.seeds >= 1 then
            player.seeds = player.seeds - 1
            crop:plant()
        elseif crop.state == "grown" then
            crop:harvest()
        end
    end
end


return Field