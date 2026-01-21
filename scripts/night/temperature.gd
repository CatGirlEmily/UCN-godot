extends Control

func _ready() -> void:
	$degree.modulate.a = 0.5

func _process(_delta: float) -> void:
	# due to many sources of changing temperature, ive put it all in global night file
	night.calculate_temperature()
	
	# if below 100 hide hundreds. flashing starts at 101
	if night.temperature <= 99:
		$cen.hide()
		$dec.show()
		$sin.show()
	if night.temperature == 100 and night.nightFrame % 30 == 0: $cen.show()
	
	# change sprites to matching numbers
	$sin.texture = global.font_battery[night.temperature%10]
	$dec.texture = global.font_battery[(night.temperature/10) % 10]
	$cen.texture = global.font_battery[night.temperature/100]
	
	# colors and flashing
	lewackaideologia()
	

	

func lewackaideologia():
	if night.temperature >= 100: modulate = Color(1,0,0,1)
	else: modulate = Color(1,1,1,1); $degree.modulate.a = 0.5; return
	
	if night.nightFrame % 30 == 0: show()
	elif night.nightFrame % 30 == 15: hide()
