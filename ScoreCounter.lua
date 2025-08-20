local ScoreCounter = {}
local Text_ttf = require("Text_ttf")

function ScoreCounter:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.score = 0
	o.last_time = 0.0
	o.text = Text_ttf:new("Assets/Fonts/Pixellari.ttf", 60)
	o.text2 = Text_ttf:new("Assets/Fonts/Pixellari.ttf", 62)
	o.text2:setColor(1.0, 1.0, 1.0)
	return o
end

function ScoreCounter:ResetCounter()
	self.score = 0
	self.last_time = love.timer.getTime()
	self.text:setText("SCORE: " .. tostring(self.score))
	self.text2:setText("SCORE: " .. tostring(self.score))
end

function ScoreCounter:Update()
	local current_time = love.timer.getTime()
	local elapsed_time = current_time - self.last_time
	if elapsed_time >= 1.0 and global.player.isDead == false then
		self.last_time = current_time
		self.score = self.score + 1
		local text_score = "SCORE: " .. tostring(self.score)
		self.text2:setText(text_score)
		self.text:setText(text_score)
	end
end

function ScoreCounter:Draw()
	local position = Vector2D.newVector2(global.SW / 3.0, 30)
	local position_2 = Vector2D.zero()
	position_2.x = position.x - 5.0
	position_2.y = position.y + 5.0
	self.text2:DrawText(position_2)
	self.text:DrawText(position)
end

return ScoreCounter
