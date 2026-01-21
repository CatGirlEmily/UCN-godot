extends Control

var slot := preload("res://scenes/animatronic.tscn")

# adds 50 animatronics to grid with math

func _ready() -> void:
	for i in range(50):
		var s = slot.instantiate()
		add_child(s)
		var col = i % 10
		@warning_ignore("integer_division")
		var row = i / 10
		s.position = Vector2((s.get_child(0).get_size().x+10) * col, (s.get_child(0).get_size().y+5) * row)

		s.setup(i)
