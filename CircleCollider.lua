local Vector2D = require("Vector2D")

local CircleCollider = { position = Vector2D.zero(), radius = 0.0 }

function CircleCollider.newCircleCollider(position, radius)
	return { position = position, radius = radius }
end

function CircleCollider.circleToCircleCollision(c1, c2)
	local distance = Vector2D.DistanceBetween(c1.position, c2.position)
	if distance <= c1.radius + c2.radius then
		return true
	else
		return false
	end
end

return CircleCollider
