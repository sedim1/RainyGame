local Ant = {}
local global = require("global")
local GameObject = require("Object")

function Ant:new(position)
	local o = GameObject:new(position)
	setmetatable(o, self)
	self.__index = self
	o.direction = 1
	o.speed = 800.0
	table.insert(o.sprite, love.graphics.newImage("Assets/Ant.png"))
	table.insert(o.sprite, love.graphics.newImage("Assets/Ant_left.png"))
	return o
end

function Ant:Move(dt)
	if love.keyboard.isDown("left") and self.position.x >= 0.0 then
		self.direction = 2
		self.position.x = self.position.x - self.speed * dt
	end
	if love.keyboard.isDown("right") and self.position.x < global.SW - self.sprite[self.direction]:getWidth() then
		self.direction = 1
		self.position.x = self.position.x + self.speed * dt
	end
end

function Ant:Update(dt)
	self:Move(dt)
end

function Ant:Draw()
	love.graphics.setColor(1.0, 1.0, 1.0)
	love.graphics.draw(self.sprite[self.direction], self.position.x, self.position.y)
end

return Ant
