extends Node

# doors
# 0 -> open
# 1 -> closing
# 2 -> opening
# 3 -> closed
var DoorLeft := 0
var DoorRight := 0
var VentUp := 0
var VentRight := 0
var fan := false
var fCoin := 0
var temperature := 60
var energy := global.default_energy # avoiding floating point errors
var usage := 0
var camera := false

var officeScrollNode = null

var nightFrame := 0

func _process(delta: float) -> void:
	nightFrame += 1

func calculate_energy_usage():
	usage = 0
	
	if night.fan: usage += 1
	if shouldDrain(night.DoorLeft): usage += 1
	if shouldDrain(night.DoorRight): usage += 1
	if shouldDrain(night.VentRight): usage += 1
	if shouldDrain(night.VentUp): usage += 1

func shouldDrain(door):
	return door == 3 or door == 1


func calculate_temperature():
	if nightFrame % 60 == 0 and not fan:
		temperature = min(temperature+1, 120)
	if nightFrame % 20 == 0 and fan:
		temperature = max(temperature-1, 60)

func reset():
	DoorLeft = 0
	DoorRight = 0
	VentUp = 0
	VentRight = 0
	fan = false
	camera = false
	
	fCoin = 0 if not global.POWERUP_3_COINS else 3
	temperature = 60 if not global.POWERUP_FRIGID else 50
	energy = global.default_energy if not global.POWERUP_BATTERY else global.default_energy+100
	nightFrame = 0
	
	if officeScrollNode: officeScrollNode.position.x = 0
