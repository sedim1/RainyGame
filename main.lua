SW = 800
SH = 640

global = require("global")
GameObject = require("Object")
RainSpawner = require("RainSpawner")
Ant = require("Ant")
Text_ttf = require("Text_ttf")
Vector2D = require("Vector2D")
ScoreCounter = require("ScoreCounter")
spawner = RainSpawner:new()

function ResetGame()
	global.player:Reset(Vector2D.newVector2(SW / 2.0, 400))
	global.counter:ResetCounter()
	spawner:Reset()
	global.background_music:play()
end

function love.load()
	love.window.setTitle("RainyDay")
	love.window.setMode(global.SW, global.SH, nil)
	background_image = love.graphics.newImage("Assets/background.png")
	global.player = Ant:new(Vector2D.newVector2(SW / 2.0, 400))
	global.counter = ScoreCounter:new()
	global.counter:ResetCounter()
	reset_text = Text_ttf:new("Assets/Fonts/Pixellari.ttf", 30)
	reset_text.text = "PRESS R TO RESTART"
	global.background_music = love.audio.newSource("Assets/background_music.wav", "stream")
	ResetGame()
end

function love.update(dt)
	if not global.background_music:isPlaying() and not global.player.isDead then
		global.background_music:play()
	end
	global.player:Update(dt)
	spawner:Update(dt)
	global.counter:Update()
	if global.player.isDead then
		global.background_music:stop()
		if love.keyboard.isDown("r") then
			ResetGame()
		end
	end
end

function love.draw()
	love.graphics.setColor(0.8, 0.8, 0.8)
	love.graphics.draw(background_image, 0, 0)
	global.player:Draw()
	spawner:DrawRaindrops()
	global.counter:Draw()
	if global.player.isDead then
		reset_text:DrawText(Vector2D.newVector2(50, SH - 50))
	end
end
