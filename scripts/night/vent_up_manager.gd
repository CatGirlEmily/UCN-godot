extends Sprite2D

@onready var open := preload("res://sprites/night/vent_up/open.png")
@onready var closed := preload("res://sprites/night/vent_up/closed.png")
@onready var anim := [
	preload("res://sprites/night/vent_up/0.png"),
	preload("res://sprites/night/vent_up/1.png"),
	preload("res://sprites/night/vent_up/2.png"),
	preload("res://sprites/night/vent_up/3.png"),
]
func _can_interact(): return night.VentUp == 0 or night.VentUp == 3
var Frame := -1

func _process(_delta: float) -> void:
	if night.VentUp == 0: texture = open # 0 -> open
	elif night.VentUp == 3: texture = closed # 3 -> closed
	elif night.VentUp == 1 or night.VentUp == 2: # 1/2 -> animation
		texture = anim[Frame]
		if night.VentUp == 1:
			Frame += 1
			if Frame >= anim.size(): Frame = -1; night.VentUp = 3
		elif night.VentUp == 2:
			Frame -= 1
			if Frame < 0: Frame = -1; night.VentUp = 0

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed(global.KEYBIND_VENT_UP) and _can_interact():
		SoundManager.play_doorFX()
		if night.VentUp == 3: night.VentUp = 2; Frame = anim.size()-1
		elif night.VentUp == 0: night.VentUp = 1; Frame = 0
