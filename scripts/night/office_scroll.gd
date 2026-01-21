extends Control

@onready var leftTrigger = get_parent().get_node("scrollTrigger").get_child(0)
@onready var rightTrigger = get_parent().get_node("scrollTrigger").get_child(1)
var scrollLeftRect = Rect2()
var scrollRightRect = Rect2()

var scrollSpeed := 50.0
var minX := -580.0
var maxX := 0.0

func _ready() -> void:
	scrollLeftRect.position = leftTrigger.get_global_position()
	scrollLeftRect.size = leftTrigger.get_size()
	scrollRightRect.position = rightTrigger.get_global_position()
	scrollRightRect.size = rightTrigger.get_size()
	
	night.officeScrollNode = self

# ported scale behavior from mamm0n night via chatgpt
func _process(_delta: float) -> void:
	if night.nightFrame < 30: return
	
	var mouse_pos = get_global_mouse_position()
	var viewport_size = get_viewport_rect().size
	var screen_center = viewport_size.x * 0.5
	
	# scroll left
	if scrollLeftRect.has_point(mouse_pos):
		var distance = screen_center - mouse_pos.x
		var speed = scrollSpeed * pow(distance / screen_center, 2)
		position.x = clamp(position.x - speed, minX, maxX)
	
	# scroll right
	if scrollRightRect.has_point(mouse_pos):
		var distance = mouse_pos.x - screen_center
		var speed = scrollSpeed * pow(distance / screen_center, 2)
		position.x = clamp(position.x + speed, minX, maxX)
