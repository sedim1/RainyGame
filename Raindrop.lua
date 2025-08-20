local Raindrop = {}
local global = require("global")
local CircleCollider = require("CircleCollider")
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
		if self.position.y > 420.0 or self:isHittingPlayer() then
			if self:isHittingPlayer() then
				global.player.isDead = true
			end
			self.isActive = false
		end
	end
end

function Raindrop:isHittingPlayer()
	local posX = self.position.x + self.sprite[1]:getWidth() / 2
	local posY = self.position.y + self.sprite[1]:getHeight() / 2
	local collider = CircleCollider.newCircleCollider(Vector2D.newVector2(posX, posY), 40)
	local playerCollider = global.player:GetCollider()
	return CircleCollider.circleToCircleCollision(collider, playerCollider) and global.player.isDead == false
end

function Raindrop:Draw()
	if self.isActive then
		love.graphics.setColor(1.0, 1.0, 1.0)
		love.graphics.draw(self.sprite[1], self.position.x, self.position.y)
	end
end

return Raindrop
