extends Control

@onready var left_open := preload("res://sprites/night/door/left_open.png")
@onready var left_closed := preload("res://sprites/night/door/left_closed.png")
@onready var left_anim := [
	preload("res://sprites/night/door/left_0.png"),
	preload("res://sprites/night/door/left_1.png"),
	preload("res://sprites/night/door/left_2.png"),
	preload("res://sprites/night/door/left_3.png"),
	preload("res://sprites/night/door/left_4.png"),
	preload("res://sprites/night/door/left_5.png"),
	preload("res://sprites/night/door/left_6.png"),
	preload("res://sprites/night/door/left_7.png"),
	preload("res://sprites/night/door/left_8.png")
]
@onready var right_anim := [
	preload("res://sprites/night/door/right_0.png"),
	preload("res://sprites/night/door/right_1.png"),
	preload("res://sprites/night/door/right_2.png"),
	preload("res://sprites/night/door/right_3.png"),
	preload("res://sprites/night/door/right_4.png"),
	preload("res://sprites/night/door/right_5.png"),
	preload("res://sprites/night/door/right_6.png"),
	preload("res://sprites/night/door/right_7.png"),
	preload("res://sprites/night/door/right_8.png")
]

@onready var right_open := preload("res://sprites/night/door/right_open.png")
@onready var right_closed := preload("res://sprites/night/door/right_closed.png")
@onready var Left := $Left
@onready var Right := $Right
func _can_interact(side: int): return side == 0 or side == 3
var leftFrame = -1
var rightFrame = -1

func _process(_delta: float) -> void:
	if night.DoorLeft == 0: Left.texture = left_open # 0 -> open
	elif night.DoorLeft == 3: Left.texture = left_closed # 3 -> closed
	elif night.DoorLeft == 1 or night.DoorLeft == 2: # 1/2 -> animation
		Left.texture = left_anim[leftFrame]
		if night.DoorLeft == 1:
			leftFrame += 1
			if leftFrame >= left_anim.size(): leftFrame = -1; night.DoorLeft = 3
		elif night.DoorLeft == 2:
			leftFrame -= 1
			if leftFrame < 0: leftFrame = -1; night.DoorLeft = 0
	
	# 1:1 same thing but with right door, i couldve done this with a function but nah
	if night.DoorRight == 0: Right.texture = right_open
	elif night.DoorRight == 3: Right.texture = right_closed
	elif night.DoorRight == 1 or night.DoorRight == 2:
		Right.texture = right_anim[rightFrame]
		if night.DoorRight == 1:
			rightFrame += 1
			if rightFrame >= right_anim.size(): rightFrame = -1; night.DoorRight = 3
		elif night.DoorRight == 2:
			rightFrame -= 1
			if rightFrame < 0: rightFrame = -1; night.DoorRight = 0

func _input(event: InputEvent) -> void:
	# left door logic
	if event is InputEventKey and event.is_action_pressed(global.KEYBIND_LEFT_DOOR) and _can_interact(night.DoorLeft):
		SoundManager.play_doorFX()
		if night.DoorLeft == 3: night.DoorLeft = 2; leftFrame = left_anim.size()-1
		elif night.DoorLeft == 0: night.DoorLeft = 1; leftFrame = 0
	# right door logic
	if event is InputEventKey and event.is_action_pressed(global.KEYBIND_RIGHT_DOOR) and _can_interact(night.DoorRight):
		SoundManager.play_doorFX()
		if night.DoorRight == 3: night.DoorRight = 2; rightFrame = right_anim.size()-1
		elif night.DoorRight == 0: night.DoorRight = 1; rightFrame = 0
