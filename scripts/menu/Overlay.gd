extends ColorRect

@onready var NODE_menu := get_parent()

func _ready() -> void:
	show()
	
func _process(_delta: float) -> void:
	modulate.a = clamp(modulate.a + (0.015 if NODE_menu.entering else -0.02), 0, 1)


func _on_go_pressed() -> void:
	modulate.a = 0
	NODE_menu.entering = true
	mouse_filter = Control.MOUSE_FILTER_STOP
