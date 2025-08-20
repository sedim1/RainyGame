local Vector2 = { x = 0.0, y = 0.0 }

function Vector2.newVector2(x, y)
	return { x = x, y = y }
end

function Vector2.zero()
	return { x = 0.0, y = 0.0 }
end

function Vector2.DistanceBetween(A, B)
	local distX = A.x - B.x
	local distY = A.y - B.y
	local distance = math.sqrt((distX * distX) + (distY * distY))
	return distance
end

return Vector2
