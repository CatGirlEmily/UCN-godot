extends Node2D

var entering = false # used to prevent resetting overlay... idk if its still essential due to how many code changes it went through

# menu keybinds. F2 doesnt really work because im too lazy to reset all the global variables everytime its pressed
func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey && Input.is_action_pressed("ESC"): get_tree().quit()
	if event is InputEventKey && Input.is_action_pressed("F2"): get_tree().change_scene_to_file("res://scenes/menu.tscn")

# called from set_all_20 etc
func update_char():
	for i in range(50): get_node("charContainer").get_child(i).update_visuals()
	update_points()

# to update points when also called from updating single character ai
func update_points(): get_node("PointValueDisplay").update_point_value()

func _ready() -> void:
	# show() here because i dont feel like having big ass rectangle in editor
	$OVERLAY0.show()
	$OVERLAY.show() 
	$OVERLAY.modulate.a = 0

func _process(delta: float) -> void:
	$OVERLAY0.modulate.a -= delta * 1
	if entering:
		$OVERLAY.modulate.a += delta * 1
		if $OVERLAY.modulate.a >= 1.0:
			# delay to make the game feel more like ucn with slow clickteam loading
			await get_tree().create_timer(1).timeout 
			get_tree().change_scene_to_file("res://scenes/night.tscn")

func go(): # triggered on GO button press via signal
	entering = true
