UI = {}
UI.__index = UI

function UI:new()
    local ui = {}
    setmetatable(ui, self)

    ui.fonts = {
      medium = love.graphics.newFont(16),
      large = love.graphics.newFont(24)
    }

    return ui
end

function UI:draw()
end

function UI:update(dt)
end
