extends TextureButton


func _on_toggled(toggled_on: bool) -> void:
	SoundManager.play_click1()
	global.showCharInfo = toggled_on
