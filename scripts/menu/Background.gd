extends Control

func _ready() -> void:
	$tile.modulate.a = 0.5

func _process(delta: float) -> void:
	$tile.position.x += 0.3
	if ($tile.position.x >= 0): $tile.position.x = -285
	
