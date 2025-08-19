local Raindrop = {}
local global = require("global")
local GameObject = require("Object")

function Raindrop:new(position)
	local o = GameObject:new(position)
	setmetatable(o, self)
	self.__index = self
	table.insert(o.sprite, love.graphics.newImage("Assets/Raindrop.png"))
	o.velocity = Vector2D.zero()
	o.isActive = true
	return o
end

function Raindrop:Update(dt)
	if self.isActive then
		self.velocity.y = self.velocity.y + global.GRAVITY * dt
		self.position.y = self.position.y + self.velocity.y
		if self.position.y > 500.0 then
			self.isActive = false
		end
	end
end

function Raindrop:Draw()
	if self.isActive then
		love.graphics.setColor(1.0, 1.0, 1.0)
		love.graphics.draw(self.sprite[1], self.position.x, self.position.y)
	end
end

return Raindrop
