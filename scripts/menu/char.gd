extends Control

# i did not add $numbers to onready because, uh - idk
var index := -1
var click_delay := 0
@onready var help := $HelpLabel
@onready var icon := $char
@onready var outline := $outline
@onready var menu := get_parent().get_parent()
@onready var outline_t := [
	preload("res://sprites/menu/outline.png"),
	preload("res://sprites/menu/outline_hover.png")
]
var rect = Rect2()

func setup(i):
	# index of animatronic. for example freddy is first so 0, phone guy is last so 49
	index = i
	icon.texture = load(global.spr_char[i])
	outline.texture = outline_t[0] # set outline to default in case its not for some reason
	update_visuals()
	modulate.a = 0.8
	# rect is thing used for detecting if mouse is hovering over
	rect.position = global_position
	rect.size = get_size()
	
	$HelpLabel/info.text = global.help_text[i]
	help.hide()

func _numbers():
	# clear previous existing digits
	for c in $numbers.get_children(): c.queue_free()
	
	var x := 0
	for c in str(global.ai[index]).reverse():		
		var cyferka := Sprite2D.new()
		cyferka.texture = global.font_bit[int(c)]
		cyferka.position.x = x
		$numbers.add_child(cyferka)
		
		x -= cyferka.texture.get_width() - 1



func update_visuals():
	# make opacity low if disabled
	icon.modulate = Color(0.9,0.9,0.9) if global.ai[index] > 0 else Color(0.2,0.2,0.2)
	if global.ai[index] == 0: $numbers.modulate.a = 0.3
	else: $numbers.modulate.a = 1
	
	_numbers()

func _process(_delta: float) -> void:
	# delay so holding isnt registered every frame. registers every 3 frames, unless using scroll
	click_delay += 1
	
	# check if mouse is on character, change outline if yes, return if no
	if (rect.has_point(get_global_mouse_position())):
		outline.texture = outline_t[1]
		if global.showCharInfo: help.show()
	else: 
		outline.texture = outline_t[0]; 
		help.hide()
		return
	
	if click_delay < 2: return
	
	# had to separate scroll wheel and coresponding mouse buttons because i wanted to make scroll have no delay
	if Input.is_action_pressed("MOUSE_LEFT"): modify_ai(1)
	elif Input.is_action_just_released("MOUSE_UP"): modify_ai(2, true, false)
	elif Input.is_action_pressed("MOUSE_RIGHT"): modify_ai(-1)
	elif Input.is_action_just_released("MOUSE_DOWN"): modify_ai(-2, true, false)
	elif Input.is_action_pressed("MOUSE_MIDDLE"): modify_ai(global.max_ai, false)
	
# modify_ai(int i, ? bool b = true, ? bool b2 = true)
# i -> number to add, can be negative
# b -> true if should add, false if the value is fixed
# b2 -> should add delay
func modify_ai(i: int, b: bool = true, b2: bool = true):
	var i2 = global.ai[index]
	if b: global.ai[index] = clamp(global.ai[index] + i, 0, global.max_ai)
	else: global.ai[index] = i
	if i2 == global.ai[index]: return
	SoundManager.play_click2()
	update_visuals()
	menu.update_points()
	if b2: click_delay = 0
	
