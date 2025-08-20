local Ant = {}
local global = require("global")
local GameObject = require("Object")
local CircleCollider = require("CircleCollider")

function Ant:new(position)
	local o = GameObject:new(position)
	setmetatable(o, self)
	self.__index = self
	o.direction = 1
	o.speed = 800.0
	o.isDead = false
	o.deadSound = love.audio.newSource("Assets/hitHurt.wav", "stream")
	table.insert(o.sprite, love.graphics.newImage("Assets/Ant.png"))
	table.insert(o.sprite, love.graphics.newImage("Assets/Ant_left.png"))
	return o
end

function Ant:playDeadSound()
	self.deadSound:play()
end

function Ant:Move(dt)
	local centerPosX = self.position.x + self.sprite[1]:getWidth() * 0.5
	if love.keyboard.isDown("left") and centerPosX - 40 >= 0.0 then
		self.direction = 2
		self.position.x = self.position.x - self.speed * dt
	end
	if love.keyboard.isDown("right") and centerPosX + 40 < global.SW then
		self.direction = 1
		self.position.x = self.position.x + self.speed * dt
	end
end

function Ant:Reset(position)
	self.position = position
	self.direction = 1
	self.isDead = false
end

function Ant:GetCollider()
	local colliderPos = Vector2D.zero()
	local radius = 40.0
	colliderPos.x = self.position.x + self.sprite[1]:getWidth() * 0.5
	colliderPos.y = self.position.y + self.sprite[1]:getHeight() * 0.5
	return CircleCollider.newCircleCollider(colliderPos, radius)
end

function Ant:Update(dt)
	if self.isDead == false then
		self:Move(dt)
	end
end

function Ant:Draw()
	if self.isDead == false then
		love.graphics.setColor(0.8, 0.8, 0.8)
		love.graphics.draw(self.sprite[self.direction], self.position.x, self.position.y)
	end
end

return Ant
