local GameObject = {}
local Vector2 = require("Vector2D")

--Constructor
function GameObject:new(position)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.position = position or Vector2.zero()
	o.sprite = {}
	return o
end

function GameObject:Update(dt) end

function GameObject:Draw() end

return GameObject
