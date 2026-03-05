extends Control

var digits = []
var scene := preload("res://scenes/digit.tscn")
var old_ai := []

func _ready() -> void:
	var max_points = 50 * global.max_ai * 10
	var max_digits = str(max_points).length()
	
	for i in range(max_digits):
		var s = scene.instantiate()
		s.position = Vector2(17 - (38 * i), 22)
		s.scale = Vector2(0.9, 0.9)
		s.visible = false
		add_child(s)
		digits.append(s)
		
	update()

func _process(_delta: float) -> void:
	if (old_ai != global.ai):
		update()
		old_ai = global.ai.duplicate()

func update():
	var score_str = str(_sum_points())
	var score_len = score_str.length()
	
	for i in range(digits.size()):
		if i < score_len:
			var digit_char = score_str[score_len - 1 - i]
			digits[i].texture = global.font_smooth[int(digit_char)]
			digits[i].visible = true
		else:
			digits[i].visible = false

func _sum_points():
	var sum := 0
	for i in range(50): sum += global.ai[i] * 10
	return sum
