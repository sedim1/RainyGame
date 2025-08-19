SW = 800
SH = 640

global = require("global")
GameObject = require("Object")
RainSpawner = require("RainSpawner")
Ant = require("Ant")
Vector2D = require("Vector2D")
player = nil
spawner = RainSpawner:new()

function love.load()
	love.window.setTitle("RainyDay")
	love.window.setMode(global.SW, global.SH, nil)
	background_image = love.graphics.newImage("Assets/background.png")
	player = Ant:new(Vector2D.newVector2(SW / 2.0, 400))
end

function love.update(dt)
	player:Update(dt)
	spawner:Update(dt)
end

function love.draw()
	love.graphics.draw(background_image, 0, 0)
	player:Draw()
	spawner:DrawRaindrops()
end
