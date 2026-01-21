extends Control

func _process(_delta: float) -> void:
	night.calculate_energy_usage()
	night.energy = max(night.energy - night.usage, 0)

	var percent := night.energy / 100

	# hide
	$cen.visible = percent >= 100
	$dec.visible = percent >= 10

	# change sprite to match
	$cen.texture = global.font_battery[percent / 100]
	$dec.texture = global.font_battery[(percent / 10) % 10]
	$sin.texture = global.font_battery[percent % 10]
	
	$UsageBar.size.x = min(34 * night.usage, 34 * 6)
