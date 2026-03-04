extends Node2D

const slot := preload("res://scenes/animatronic.tscn")

var tabVisible := false

func _ready() -> void:
	_setup_char()

func _setup_char():
	var offset := Vector2(23, 30)
	
	for i in range(50):
		var s = slot.instantiate()
		add_child(s)
		var col = i % 10
		var row = i / 10
		s.position = Vector2((s.get_child(0).get_size().x+10) * col, (s.get_child(0).get_size().y+5) * row) + offset

		s.setup(i)	
