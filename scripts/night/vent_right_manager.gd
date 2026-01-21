extends Sprite2D

@onready var open := preload("res://sprites/night/vent_right/open.png")
@onready var closed := preload("res://sprites/night/vent_right/closed.png")
@onready var anim := [
	preload("res://sprites/night/vent_right/0.png"),
	preload("res://sprites/night/vent_right/1.png"),
	preload("res://sprites/night/vent_right/2.png"),
	preload("res://sprites/night/vent_right/3.png"),
]
func _can_interact(): return night.VentRight == 0 or night.VentRight == 3
var Frame := -1

func _process(_delta: float) -> void:
	if night.VentRight == 0: texture = open # 0 -> open
	elif night.VentRight == 3: texture = closed # 3 -> closed
	elif night.VentRight == 1 or night.VentRight == 2: # 1/2 -> animation
		texture = anim[Frame]
		if night.VentRight == 1:
			Frame += 1
			if Frame >= anim.size(): Frame = -1; night.VentRight = 3
		elif night.VentRight == 2:
			Frame -= 1
			if Frame < 0: Frame = -1; night.VentRight = 0

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed(global.KEYBIND_VENT_RIGHT) and _can_interact():
		SoundManager.play_doorFX()
		if night.VentRight == 3: night.VentRight = 2; Frame = anim.size()-1
		elif night.VentRight == 0: night.VentRight = 1; Frame = 0
