require("skibidi.components.ui")
require("skibidi.components.screenmanager")

local Game = {}
Game.__index = Game

function Game:new(ui)
    assert(ui, "ui parameter cannot be nil")
    assert(type(ui) == "table", "ui parameter must be a table")

    local state = {}
    setmetatable(state, self)

    state.ui = ui

    return state
end

function Game:enter()
    -- Assertions can be added here when game state is initialized
end

function Game:update(dt)
    assert(type(dt) == "number", "dt must be a number")
end

function Game:draw()
    assert(love.graphics, "love graphics module not available")
    love.graphics.setBackgroundColor(0.03, 0.03, 0.03)
end

function Game:mousepressed(x, y, button)
    assert(type(x) == "number", "x must be a number")
    assert(type(y) == "number", "y must be a number")
    assert(button, "button cannot be nil")
end

function Game:mousereleased(x, y, button)
    assert(type(x) == "number", "x must be a number")
    assert(type(y) == "number", "y must be a number")
    assert(button, "button cannot be nil")
end

function Game:keypressed(key)
    assert(key, "key cannot be nil")

    if key == "escape" then
        assert(game, "game object not initialized")
        assert(game.screenmanager, "screen manager not initialized")
        game.screenmanager:switch("menu")
    end
end

function Game:keyreleased(key)
    assert(key, "key cannot be nil")
end

function Game:exit()
end

return Game
