extends Control

@onready var ai := global.ai
@onready var menu := get_parent()

func _ready():
	$"0".pressed.connect(_set_0)
	$"1".pressed.connect(_add_1)
	$"10".pressed.connect(_set_10)
	$"20".pressed.connect(_set_20)
	$"random".pressed.connect(_randomize)


	

func _set_0():
	for i in ai.size(): ai[i] = 0
	menu.update_char()
	SoundManager.play_click1()
	
func _add_1():
	for i in ai.size(): if ai[i] < global.max_ai: ai[i] += 1
	menu.update_char()
	SoundManager.play_click1()

func _set_10():
	for i in ai.size(): ai[i] = 10
	menu.update_char()
	SoundManager.play_click1()
	
func _set_20():
	for i in ai.size(): ai[i] = 20
	menu.update_char()
	SoundManager.play_click1()

func _randomize():
	for i in ai.size(): ai[i] = randi_range(0, global.max_ai)
	menu.update_char()
	SoundManager.play_click1()
