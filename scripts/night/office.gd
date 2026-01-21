extends Sprite2D

@onready var office_texture = [
	preload("res://sprites/night/office/0.png"),
	preload("res://sprites/night/office/1.png"),
	preload("res://sprites/night/office/2.png"),
	preload("res://sprites/night/office/3.png")
]

func _ready() -> void:
	texture = office_texture[global.office]
