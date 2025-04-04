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
	self.ui = UI:new()

  self.screenmanager:add("menu", Menu:new(self.ui))
  self.screenmanager:add("game", Game:new(self.ui))

  self.screenmanager:switch("menu")

  love.window.setTitle(self.title)
  love.window.setIcon(love.image.newImageData("assets/lukas.png"))
  love.window.setMode(self.width, self.height, {
    fullscreen = false,
    resizable = true,
    borderless = false,
    usedpiscale = true
  })
end

function game:update(dt)
  self.screenmanager:update(dt)
  self.ui:update(dt)
end

function game:draw()
  self.screenmanager:draw()
  self.ui:draw()
end

function game:keypressed(key)
  self.screenmanager:keypressed(key)
end

function game:keyreleased(key)
  self.screenmanager:keyreleased(key)
end

function game:mousepressed(x, y, button)
  self.screenmanager:mousepressed(x, y, button)
end

function game:mousereleased(x, y, button)
  self.screenmanager:mousereleased(x, y, button)
end
