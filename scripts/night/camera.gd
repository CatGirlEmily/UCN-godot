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
	$realCameraTrigger.modulate.a = 0

func _process(delta: float) -> void:
	Util.showWhen(self, night.maskState != 1 and night.maskState != 3 and !night.mask)
	if running: frame_step()
	
	$cameraTrigger.modulate.a = 0.3 if night.camera else 1
	

	$animation.texture = TEXTURE_FRAMES[clamp(frame, 0, 8)]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(global.KEYBIND_CAMERA): _camera_trigger()

func frame_step():
	frame += direction
	print(frame)

	if frame < 0:
		frame = -1
		running = false
		$animation.hide()
		night.cameraState = 0
	elif frame > 8:
		frame = 9
		running = false
		night.camera = true
		night.cameraState = 3

func _camera_trigger() -> void:
	if running: return
	if not visible: return
	
	$animation.show()
	
	if night.camera:
		direction = -1
		night.cameraState = 2
		night.camera = false
	else:
		direction = 1
		night.cameraState = 1

	running = true
