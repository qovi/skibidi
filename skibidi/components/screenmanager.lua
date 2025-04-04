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
  self.states[name] = state
  print("Added state: " .. name)
end

function screenmanager:switch(name)
  if not self or not self.states then
    error("screenmanager or states table is nil")
  end
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
  if self.current and self.current.keypressed then
    self.current:keypressed(key)
  end
end

function screenmanager:keyreleased(key)
  if self.current and self.current.keyreleased then
    self.current:keyreleased(key)
  end
end

function screenmanager:mousepressed(worldX, worldY, button, screenX, screenY)
  if self.current and self.current.mousepressed then
    self.current:mousepressed(worldX, worldY, button, screenX, screenY)
  end
end

function screenmanager:mousereleased(worldX, worldY, button, screenX, screenY)
  if self.current and self.current.mousereleased then
    self.current:mousereleased(worldX, worldY, button, screenX, screenY)
  end
end

return screenmanager
