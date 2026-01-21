extends Control

const s = Vector2(0.4,0.4)

func _ready() -> void:
	var minutes: int = global.BEST_TIME / 600
	var seconds: int = (global.BEST_TIME/10) % 60
	var tenth_of_a_second: int = global.BEST_TIME % 10
	var s_dec: int = seconds / 10
	var s_sin: int = seconds % 10
	
	var t = Sprite2D.new()
	t.texture = global.font_smooth[tenth_of_a_second]
	t.scale = s
	add_child(t)
	
	var dot = Sprite2D.new()
	dot.texture = global.font_smooth[10]
	dot.scale = s
	dot.position.x -= 15
	add_child(dot)
	
	var s1 = Sprite2D.new()
	s1.texture = global.font_smooth[s_sin]
	s1.scale = s
	s1.position.x -= 30
	add_child(s1)
	
	var s2 = Sprite2D.new()
	s2.texture = global.font_smooth[s_dec]
	s2.scale = s
	s2.position.x -= 48
	add_child(s2)
	
	var c1 = Sprite2D.new()
	c1.texture = global.font_smooth[10]
	c1.scale = s
	c1.position.x -= 63
	add_child(c1)
	
	var c2 = Sprite2D.new()
	c2.texture = global.font_smooth[10]
	c2.scale = s
	c2.position.x -= 63
	c2.position.y -= 12
	add_child(c2)
	
	var m = Sprite2D.new()
	m.texture = global.font_smooth[minutes]
	m.scale = s
	m.position.x -= 78
	add_child(m)
	
