require("skibidi.components.ui")
require("skibidi.components.screenmanager")

local Menu = {}
Menu.__index = Menu

function Menu:new(ui)
    assert(ui, "ui parameter cannot be nil")
    assert(type(ui) == "table", "ui parameter must be a table")

    local state = {}
    setmetatable(state, self)

    state.ui = ui
    state.backgroundIndex = 1
    state.backgroundImages = {
        "assets/lukas.png",
        "assets/mathias.png",
        "assets/orizi.png"
    }

    -- Validate that the image files exist
    for i, path in ipairs(state.backgroundImages) do
        local success = love.filesystem.getInfo(path) ~= nil
        assert(success, "background image not found: " .. path)
    end

    local success, img = pcall(love.graphics.newImage, state.backgroundImages[state.backgroundIndex])
    assert(success and img, "failed to load background image: " .. state.backgroundImages[state.backgroundIndex])
    state.background = img

    state.hoverButton = nil
    state.hoverAlpha = 0
    state.hoverSpeed = 5

    state.buttons = {
        {
            text = "Start Game",
            x = 20,
            y = 0,
            width = 200,
            height = 50,
            hover = 0,
            action = function()
              assert(game, "game object not initialized")
              assert(game.screenmanager, "screen manager not initialized")
              game.screenmanager:switch("game")
            end
        },
        {
            text = "Change Background",
            x = 20,
            y = 0,
            width = 200,
            height = 50,
            hover = 0,
            action = function()
                assert(state.backgroundImages, "background images not initialized")
                assert(#state.backgroundImages > 0, "no background images available")

                state.backgroundIndex = state.backgroundIndex % #state.backgroundImages + 1
                local success, img = pcall(love.graphics.newImage, state.backgroundImages[state.backgroundIndex])
                assert(success and img, "failed to load background image: " .. state.backgroundImages[state.backgroundIndex])
                state.background = img

                local success, iconData = pcall(love.image.newImageData, state.backgroundImages[state.backgroundIndex])
                assert(success and iconData, "failed to load icon image data")
                love.window.setIcon(iconData)
            end
        }
    }

    state:updateButtonPositions()

    return state
end

function Menu:getCurrentBackgroundPath()
    return self.backgroundImages[self.backgroundIndex]
end

function Menu:updateButtonPositions()
    local screenHeight = love.graphics.getHeight()
    local screenWidth = love.graphics.getWidth()
    local padding = 20
    local spacing = 10

    local currentY = screenHeight - padding

    for i = #self.buttons, 1, -1 do
        local button = self.buttons[i]
        if button.x == 20 then
            currentY = currentY - button.height
            button.y = currentY
            currentY = currentY - spacing
        else
            button.y = self.buttons[2].y
        end
    end
end

function Menu:update(dt)
    self:updateButtonPositions()

    local mx, my = love.mouse.getPosition()
    local hoveredButton = nil

    for _, button in ipairs(self.buttons) do
        if mx >= button.x and mx <= button.x + button.width and
           my >= button.y and my <= button.y + button.height then
            hoveredButton = button
        end

        if button == hoveredButton then
            button.hover = math.min(button.hover + dt * self.hoverSpeed, 1)
        else
            button.hover = math.max(button.hover - dt * self.hoverSpeed, 0)
        end
    end
end

function Menu:mousepressed(x, y, button)
    self.clickedButton = nil

    for _, btn in ipairs(self.buttons) do
        if x >= btn.x and x <= btn.x + btn.width and
           y >= btn.y and y <= btn.y + btn.height then
            self.clickedButton = btn
            break
        end
    end
end

function Menu:mousereleased(x, y, button)
    if self.clickedButton then
        if x >= self.clickedButton.x and x <= self.clickedButton.x + self.clickedButton.width and
           y >= self.clickedButton.y and y <= self.clickedButton.y + self.clickedButton.height then
            if self.clickedButton.action then
                self.clickedButton.action()
            end
        end
        self.clickedButton = nil
    end
end

function Menu:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.background, 0, 0, 0,
    love.graphics.getWidth() / self.background:getWidth(),
    love.graphics.getHeight() / self.background:getHeight())

  if self.ui and self.ui.fonts.large then
    love.graphics.setFont(self.ui.fonts.large)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(game.title, 0, 100, love.graphics.getWidth(), 'center')
  end

  for _, button in ipairs(self.buttons) do
    love.graphics.setFont(self.ui.fonts.medium)

    local textWidth = self.ui.fonts.medium:getWidth(button.text)
    local textX = (button.x or 0) + ((button.width or 0) - textWidth) / 2

    love.graphics.setColor(1, 1, 1)

    love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)

    if button.hover > 0 then
        love.graphics.setColor(0.7, 0.9, 1, button.hover * 0.5)
        love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)

        local growAmount = button.hover * 5
        love.graphics.setColor(0.7, 0.9, 1, button.hover * 0.7)
        love.graphics.rectangle("line",
            button.x - growAmount,
            button.y - growAmount,
            button.width + growAmount * 2,
            button.height + growAmount * 2)
    end

    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("line", button.x, button.y, button.width, button.height)

    love.graphics.setColor(0, 0, 0)
    local textScale = 1 + (button.hover * 0.1)
    local scaledTextWidth = textWidth * textScale
    local scaledTextHeight = self.ui.fonts.medium:getHeight() * textScale
    local textY = button.y + (button.height - scaledTextHeight) / 2

    local adjustedTextX = button.x + (button.width - scaledTextWidth) / 2

    love.graphics.push()
    love.graphics.translate(textX, textY)
    love.graphics.scale(textScale, textScale)
    love.graphics.translate(-textX + (adjustedTextX - textX)/textScale, 0)
    love.graphics.print(button.text, textX, 0)
    love.graphics.pop()
  end
end

return Menu
