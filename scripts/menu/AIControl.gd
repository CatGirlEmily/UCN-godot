extends Control

# probably will be used for variable stating if the buttons should be visible
# (they can not be in challenges menu for example)
@onready var NODE_menu := get_parent()

func _process(delta: float) -> void:
	Util.showWhen(self, !NODE_menu.tabVisible)

func set_ai(SET: bool, value: int, random := false) -> void:
	if (!visible): return
	
	if (random):
		for i in range(50):
			if (randf() < global.radom_randomizer): 
				global.ai[i] = randi_range(1, global.max_ai)
			else: 
				global.ai[i] = 0
	else:
		for i in range(50):
			global.ai[i] = clamp(value if SET else global.ai[i] + value, 0, global.max_ai)
			
	SoundManager.play_blip()
