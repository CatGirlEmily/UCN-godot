extends Sprite2D

var fanFrame = 0

@onready var fan = [
	preload("res://sprites/menu/fan/0.png"),
	preload("res://sprites/menu/fan/1.png"),
	preload("res://sprites/menu/fan/2.png"),
	preload("res://sprites/menu/fan/3.png")
]

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed(global.KEYBIND_FAN):
		night.fan = !night.fan
		SoundManager.play_blip()
		Util.playWhen($Fan, night.fan)
		

func _process(delta: float) -> void:
	if night.fan:
		texture = fan[fanFrame]
		fanFrame += 1
		if fanFrame >= 4: fanFrame = 0
		
