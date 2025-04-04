screenmanager = {}
screenmanager.__index = screenmanager

function screenmanager:new()
  local manager = {}
  setmetatable(manager, self)

  manager.states = {}
  manager.current = nil

  return manager
end

function screenmanager:add(name, state)
  assert(type(name) == "string", "screen name must be a string")
  assert(state, "screen state cannot be nil")
  assert(type(state) == "table", "screen state must be a table")

  self.states[name] = state
end

function screenmanager:switch(name)
  assert(type(name) == "string", "screen name must be a string")
  assert(self.states[name], "unknown screen " .. name)

  if self.current and self.current.exit then
    self.current:exit()
  end

  self.current = self.states[name]

  if self.current.enter then
    self.current:enter()
  end
end

function screenmanager:update(dt)
  assert(type(dt) == "number", "dt must be a number")

  if self.current and self.current.update then
    self.current:update(dt)
  end
end

function screenmanager:draw()
  if self.current and self.current.draw then
    self.current:draw()
  end
end

function screenmanager:keypressed(key)
  assert(key, "key cannot be nil")

  if self.current and self.current.keypressed then
    self.current:keypressed(key)
  end
end

function screenmanager:keyreleased(key)
  assert(key, "key cannot be nil")

  if self.current and self.current.keyreleased then
    self.current:keyreleased(key)
  end
end

function screenmanager:mousepressed(worldX, worldY, button, screenX, screenY)
  assert(type(worldX) == "number", "worldX must be a number")
  assert(type(worldY) == "number", "worldY must be a number")
  assert(button, "button cannot be nil")

  if self.current and self.current.mousepressed then
    self.current:mousepressed(worldX, worldY, button, screenX, screenY)
  end
end

function screenmanager:mousereleased(worldX, worldY, button, screenX, screenY)
  assert(type(worldX) == "number", "worldX must be a number")
  assert(type(worldY) == "number", "worldY must be a number")
  assert(button, "button cannot be nil")

  if self.current and self.current.mousereleased then
    self.current:mousereleased(worldX, worldY, button, screenX, screenY)
  end
end

return screenmanager
