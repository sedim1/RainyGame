local RainSpawner = {}
local Raindrop = require("Raindrop")

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
	local newPosition = Vector2D.newVector2(love.math.random(0, SW), -200)
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

return RainSpawner
