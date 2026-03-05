extends Control

func _ready() -> void:
	$sci.button_pressed = global.showCharInfo
	$vfx.button_pressed = global.visualEffects

func _vfx(toggled_on: bool) -> void:
	global.visualEffects = toggled_on
