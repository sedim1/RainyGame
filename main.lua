SW = 800
SH = 640

global = require("global")
GameObject = require("Object")
RainSpawner = require("RainSpawner")
Ant = require("Ant")
Vector2D = require("Vector2D")
ScoreCounter = require("ScoreCounter")
spawner = RainSpawner:new()

function love.load()
	love.window.setTitle("RainyDay")
	love.window.setMode(global.SW, global.SH, nil)
	background_image = love.graphics.newImage("Assets/background.png")
	global.player = Ant:new(Vector2D.newVector2(SW / 2.0, 400))
	global.counter = ScoreCounter:new()
	global.counter:ResetCounter()
end

function love.update(dt)
	global.player:Update(dt)
	spawner:Update(dt)
	global.counter:Update()
end

function love.draw()
	love.graphics.setColor(1.0, 1.0, 1.0)
	love.graphics.draw(background_image, 0, 0)
	global.player:Draw()
	spawner:DrawRaindrops()
	global.counter:Draw()
end
