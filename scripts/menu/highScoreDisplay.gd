extends Control

func _ready() -> void:
	var x := 0
	for c in str(global.HIGH_SCORE).reverse():
		var cyferka := Sprite2D.new()
		cyferka.texture = global.font_smooth[int(c)]
		cyferka.position.x = x
		cyferka.scale = Vector2(0.85,0.85)
		add_child(cyferka)
		
		@warning_ignore("narrowing_conversion")
		x -= cyferka.texture.get_width() * cyferka.scale.x - 2
