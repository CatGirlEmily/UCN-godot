extends Control

func _ready() -> void:
	update_point_value()

func update_point_value():
	# clear previous existing digits
	for c in get_children(): c.queue_free()

	var x := 0
	for c in str(global.sum_points()).reverse():
		var cyferka := Sprite2D.new()
		cyferka.texture = global.font_smooth[int(c)]
		cyferka.position.x = x
		add_child(cyferka)
		
		x -= cyferka.texture.get_width() - 1
		
