require("skibidi.components.ui")

-- screen stuff
require("skibidi.components.screenmanager")
Menu = require("skibidi.components.screen.menuscreen")
Game = require("skibidi.components.screen.gamescreen")
game = {}

function game:load()
	self.width = 1000
	self.height = 700
  self.title = "Skibidi"

	local types = {
		"default",
		"tank",
		"fighter",
		"speed"
	}

  self.screenmanager = screenmanager:new()
  assert(self.screenmanager, "failed to create screen manager")

	self.ui = UI:new()
  assert(self.ui, "failed to create UI")

  self.screenmanager:add("menu", Menu:new(self.ui))
  self.screenmanager:add("game", Game:new(self.ui))

  self.screenmanager:switch("menu")

  assert(love.window, "love window module not available")
  love.window.setTitle(self.title)

  local success, iconData = pcall(love.image.newImageData, "assets/lukas.png")
  assert(success and iconData, "failed to load icon image")
  love.window.setIcon(iconData)

  local success, err = love.window.setMode(self.width, self.height, {
    fullscreen = false,
    resizable = true,
    borderless = false,
    usedpiscale = true
  })
  assert(success, "failed to set window mode: " .. (err or "unknown error"))
end

function game:update(dt)
  assert(type(dt) == "number", "dt must be a number")
  assert(self.screenmanager, "screen manager not initialized")
  assert(self.ui, "ui not initialized")

  self.screenmanager:update(dt)
  self.ui:update(dt)
end

function game:draw()
  assert(self.screenmanager, "screen manager not initialized")
  assert(self.ui, "ui not initialized")

  self.screenmanager:draw()
  self.ui:draw()
end

function game:keypressed(key)
  assert(key, "key cannot be nil")
  assert(self.screenmanager, "screen manager not initialized")

  self.screenmanager:keypressed(key)
end

function game:keyreleased(key)
  assert(key, "key cannot be nil")
  assert(self.screenmanager, "screen manager not initialized")

  self.screenmanager:keyreleased(key)
end

function game:mousepressed(x, y, button)
  assert(type(x) == "number", "x must be a number")
  assert(type(y) == "number", "y must be a number")
  assert(button, "button cannot be nil")
  assert(self.screenmanager, "screen manager not initialized")

  self.screenmanager:mousepressed(x, y, button)
end

function game:mousereleased(x, y, button)
  assert(type(x) == "number", "x must be a number")
  assert(type(y) == "number", "y must be a number")
  assert(button, "button cannot be nil")
  assert(self.screenmanager, "screen manager not initialized")

  self.screenmanager:mousereleased(x, y, button)
end
