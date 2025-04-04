UI = {}
UI.__index = UI

function UI:new()
    local ui = {}
    setmetatable(ui, self)

    ui.fonts = {
      medium = love.graphics.newFont(16),
      large = love.graphics.newFont(24)
    }

    assert(ui.fonts.medium, "failed to load medium font")
    assert(ui.fonts.large, "failed to load large font")

    return ui
end

function UI:draw()
end

function UI:update(dt)
    assert(type(dt) == "number", "dt must be a number")
end
