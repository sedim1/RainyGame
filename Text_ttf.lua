local Text_ttf = {}

--Class of a basic text fon object
function Text_ttf:new(font_path, size)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.font = love.graphics.newFont(font_path, size)
	o.text = ""
	o.color = { r = 0.0, g = 0.0, b = 0.0 }
	return o
end

function Text_ttf:setText(new_text)
	self.text = new_text
end

function Text_ttf:setColor(r, g, b)
	self.color.r = r
	self.color.g = g
	self.color.b = b
end

--Draw text on screen
function Text_ttf:DrawText(position)
	love.graphics.setColor(self.color.r, self.color.g, self.color.b)
	love.graphics.setFont(self.font)
	love.graphics.print(self.text, position.x, position.y)
end

return Text_ttf
