extends TextureButton

var nightscene := preload("res://scenes/night.tscn")
@onready var NODE_menu := get_parent()

func _pressed() -> void:
	if (NODE_menu.entering): return
	global.saveData()
	NODE_menu.entering = true
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_packed(nightscene)
	
