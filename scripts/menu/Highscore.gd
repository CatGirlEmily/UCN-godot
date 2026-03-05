extends Control

var scene := preload("res://scenes/digit.tscn")

func _ready() -> void:
	var hs := str(global.HIGH_SCORE)
	
	for i in range(hs.length()):
		var s = scene.instantiate()
		s.texture = global.font_smooth[int(hs[hs.length() -1 - i])]
		
		s.position = Vector2(17,24)
		s.scale = Vector2(0.8,0.8)
		
		s.position.x -= 33 * i
		
		add_child(s)
