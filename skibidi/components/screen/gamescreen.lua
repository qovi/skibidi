require("skibidi.components.ui")
require("skibidi.components.screenmanager")

local Game = {}
Game.__index = Game

function Game:new(ui)
    local state = {}
    setmetatable(state, self)

    state.ui = ui

    return state
end

function Game:enter()
end

function Game:update(dt)
end

function Game:draw()
    love.graphics.setBackgroundColor(0.03, 0.03, 0.03)
end

function Game:mousepressed(x, y, button)
end

function Game:mousereleased(x, y, button)
end

function Game:keypressed(key)
    if key == "escape" then
        game.screenmanager:switch("menu")
    end
end

function Game:keyreleased(key)
end

function Game:exit()
end

return Game
