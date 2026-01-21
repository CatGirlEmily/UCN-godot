extends Control

const TEXTURE_FRAMES = [
	preload("res://sprites/night/pullAnim/0.png"),
	preload("res://sprites/night/pullAnim/1.png"),
	preload("res://sprites/night/pullAnim/2.png"),
	preload("res://sprites/night/pullAnim/3.png"),
	preload("res://sprites/night/pullAnim/4.png"),
	preload("res://sprites/night/pullAnim/5.png"),
	preload("res://sprites/night/pullAnim/6.png"),
	preload("res://sprites/night/pullAnim/7.png"),
	preload("res://sprites/night/pullAnim/8.png"),
]

var frame := -1
var running := false
var direction := 1

func _ready() -> void:
	$animation.hide()

func _process(delta: float) -> void:
	if not running: return

	frame += direction

	if frame < 0:
		frame = -1
		running = false
		$animation.hide()
		night.camera = false
	elif frame > 8:
		frame = 9
		running = false
		$animation.hide()
		night.camera = true

	$animation.texture = TEXTURE_FRAMES[clamp(frame, 0, 8)]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("S"): _camera_trigger()


func _camera_trigger() -> void:
	if running: return
	$animation.show()
	
	if night.camera:
		frame = 8
		direction = -1
	else:
		frame = 0
		direction = 1

	running = true
