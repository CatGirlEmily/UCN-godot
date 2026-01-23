extends Control

const TEXTURE_FRAMES = [
	preload("res://sprites/night/maskAnim/0.png"),
	preload("res://sprites/night/maskAnim/1.png"),
	preload("res://sprites/night/maskAnim/2.png"),
	preload("res://sprites/night/maskAnim/3.png"),
	preload("res://sprites/night/maskAnim/4.png"),
	preload("res://sprites/night/maskAnim/5.png"),
	preload("res://sprites/night/maskAnim/6.png"),
]

var frame := -1
var running := false
var direction := 1

func _ready() -> void:
	$animation.hide()
	$realMaskTrigger.modulate.a = 0

func _process(delta: float) -> void:
	Util.showWhen(self, night.cameraState != 1 and night.cameraState != 3 and !night.camera)
	if running: frame_step()
	

	$animation.texture = TEXTURE_FRAMES[clamp(frame, 0, 6)]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(global.KEYBIND_MASK): _mask_trigger()

func frame_step():
	frame += direction
	print(frame)

	if frame < 0:
		frame = -1
		running = false
		$animation.hide()
		night.maskState = 0
	elif frame > 6:
		frame = 7
		running = false
		night.mask = true
		night.maskState = 3

func _mask_trigger() -> void:
	if running: return
	if not visible: return
	
	$animation.show()
	
	
	
	
	
	
	
	
	
	
	
	
	if night.mask:
		direction = -1
		night.maskState = 2
		night.mask = false
	else:
		direction = 1
		night.maskState = 1

	running = true
