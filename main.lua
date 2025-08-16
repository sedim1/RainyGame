--Objects definitions
Vector2D = { x = 0.0, y = 0.0 }
function Vector2D:new(x, y)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.x = x or 0.0
	o.y = y or 0.0
	return o
end

CircleCollider = { position = Vector2D:new(0.0, 0.0), radius = 0.0 }
function CircleCollider:new(position, radius)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.radius = radius or 0
	o.position = position or Vector2D:new(0.0, 0.0)
	return o
end

function CircleToCircleCollision(c1, c2)
	local distX = c1.position.x - c2.position.x
	local distY = c1.position.y - c2.position.y
	local distance = math.sqrt((distX * distX) + (distY * distY))
	local total_radius = c1.radius + c2.radius
	if distance <= total_radius then
		return true
	end
	return false
end

Raindrop = {
	position = Vector2D:new(0.0, 0.0),
	isActive = true,
	velocity = Vector2D:new(0.0, 0.0),
	collider = CircleCollider:new(Vector2D:new(0.0, 0.0), 0.0),
}

function Raindrop:new(position)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.position = position or Vector2D:new(0.0, 0.0)
	o.velocity = Vector2D:new(0.0, 0.0)
	o.collider = CircleCollider:new(o.position, 48)
	o.isActive = true
	return o
end

function Raindrop:Update(dt)
	if self.isActive then
		self.velocity.y = self.velocity.y + GRAVITY * dt
		self.position.y = self.position.y + self.velocity.y
		self.collider.position = self.position

		local playerHit = CircleToCircleCollision(self.collider, player.collider) and not player.isdead

		if self.position.y > 500.0 or playerHit then
			self.isActive = false
			if playerHit then
				player.isdead = true
			end
		end
	end
end

function Raindrop:Draw()
	if self.isActive then
		love.graphics.setColor(0.0, 0.0, 1.0)
		love.graphics.circle("fill", self.position.x, self.position.y, self.collider.radius)
	end
end

RainSpawner = { raindrops = {}, last_spawn = 0.0, frequency_spawn = 0.0 }
function RainSpawner:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	self.frequency_spawn = 0.25
	self.last_spawn = 0.0
	self.raindrops = {}
	return o
end

function RainSpawner:DeleteInactiveRaindrops()
	for i, object in pairs(self.raindrops) do
		if not object.isActive then
			table.remove(self.raindrops, i)
		end
	end
end

function RainSpawner:DrawRaindrops()
	for _, raindrop in ipairs(self.raindrops) do
		if raindrop ~= nil then
			raindrop:Draw()
		end
	end
end

function RainSpawner:SpawnRaindrop()
	newPosition = Vector2D:new(love.math.random(0, SW), -50)
	table.insert(self.raindrops, Raindrop:new(newPosition))
end

function RainSpawner:Update(dt)
	--Delete first all raindrops that are inactive
	self:DeleteInactiveRaindrops()
	--Spawn more objects if needed
	local current_time = love.timer.getTime()
	if current_time - self.last_spawn > self.frequency_spawn then
		self.last_spawn = current_time
		self:SpawnRaindrop()
	end
	--Process all active raindrops
	for _, raindrop in ipairs(self.raindrops) do
		if raindrop ~= nil then
			raindrop:Update(dt)
		end
	end
	--print(#self.raindrops)
end

Ant = {
	position = Vector2D:new(0.0, 0.0),
	isdead = false,
	speed = 0.0,
	collider = CircleCollider:new(Vector2D:new(0.0, 0.0), 0.0),
}
function Ant:new(position)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.position = position or Vector2D:new(0.0, 0.0)
	o.speed = 800.0
	o.isdead = false
	o.collider = CircleCollider:new(o.position, 32)
	return o
end

function Ant:Update(dt)
	if not self.isdead then
		self:Move(dt)
		self.collider.position = self.position
	end
end

function Ant:Move(dt)
	if love.keyboard.isDown("left") and self.position.x >= 0.0 then
		self.position.x = self.position.x - self.speed * dt
	end
	if love.keyboard.isDown("right") and self.position.x < SW then
		self.position.x = self.position.x + self.speed * dt
	end
end

function Ant:Draw()
	if not self.isdead then
		love.graphics.setColor(1.0, 0.0, 0.0)
		love.graphics.circle("fill", self.position.x, self.position.y, self.collider.radius)
	end
end

-- global variables
SW = 800
SH = 640
GRAVITY = 9.81
player = Ant:new(Vector2D:new(400, 500))
spawner = RainSpawner:new()

--Main Code
function love.load()
	love.window.setTitle("Rainy Day")
	love.window.setMode(SW, SH, nil)
end

function love.update(dt)
	player:Update(dt)
	spawner:Update(dt)
end

function love.draw()
	player:Draw()
	spawner:DrawRaindrops()
end
