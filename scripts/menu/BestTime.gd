extends Control



func _ready() -> void:
	@warning_ignore_start("integer_division")
	
	var minutes: int = global.BEST_TIME / 600
	var seconds: int = (global.BEST_TIME/10) % 60
	var tenth_of_a_second: int = global.BEST_TIME % 10
	var s_dec: int = seconds / 10
	var s_sin: int = seconds % 10
	
	$tenth.texture = global.font_timmer[tenth_of_a_second]
	$sec.texture = global.font_timmer[s_sin]
	$dec.texture = global.font_timmer[s_dec]
	$min.texture = global.font_timmer[minutes]
