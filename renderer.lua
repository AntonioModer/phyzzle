
-- An example/debug renderer.

local Renderer = {
  -- camera position
  x = 0,
  y = 0,
}

-- Create a new renderer.
-- A renderer needs a map.
function Renderer:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o:init()
  return o
end

function Renderer:init()
end

function Renderer:draw()
  -- camera
  love.graphics.push()
  love.graphics.translate(-self.x, -self.y)

  -- zones
  for x = 0, self.map.zw - 1 do
    for y = 0, self.map.zh - 1 do

      -- entities
      for k, entity in pairs(self.map.zones[x][y]) do
        if entity.static then
          love.graphics.setColor(100,  100, 100)
        else
          love.graphics.setColor(255, 255, 255)
        end

        love.graphics.rectangle('line', entity.x, entity.y, entity.w, entity.h)
      end

      -- zone
      love.graphics.setColor(200, 100, 100)
      love.graphics.rectangle('line', x * self.map.zs, y * self.map.zs,
        self.map.zs, self.map.zs)

      -- zone stats
      local entityCount = 0

      for k, v in pairs(self.map.zones[x][y]) do
        entityCount = entityCount + 1
      end

      love.graphics.print(x .. ',' .. y, x * self.map.zs + 5, y * self.map.zs + 5)
      love.graphics.print(entityCount, x * self.map.zs + 5, y * self.map.zs + 20)
    end
  end

  love.graphics.pop()

  -- self.map summary
  love.graphics.setColor(255, 255, 255)
  love.graphics.print('zones: ' .. self.map.zw * self.map.zh, 5, 5)
  love.graphics.print('entities: ' .. self.map.entitiesCount, 5, 20)
  love.graphics.print('updaters: ' .. self.map.updatersCount, 5, 35)
end

return Renderer