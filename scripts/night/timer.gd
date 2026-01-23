extends Control

func _ready() -> void:
	$"1-xam".show()

func _process(delta: float) -> void:	
	if night.nightHour >= 1: $"1-xam".hide()
	else: $"1-xam".show()
	
	$"2-am".texture = global.font_timer[night.nightHour] if night.nightHour > 0 else global.font_timer[2]
	
	$"a".texture = global.font_timmer[night.nightSecond/60]
	$"aa".texture = global.font_timmer[(night.nightSecond%60)/10]
	$"aaa".texture = global.font_timmer[(night.nightSecond%60%10)]
	$"aaaa".texture = global.font_timmer[(night.nightTenth)]
	
