extends Control

@onready var NODE_menu := get_parent()

func _ready() -> void:
	$buttons.show()
	$TAB.hide()

func on_tab(entry: bool):
	if (entry):
		$TAB.show()
		$buttons.hide()
		NODE_menu.tabVisible = true
	else:
		$TAB.hide()
		$buttons.show()
		NODE_menu.tabVisible = false

func _office_tab() -> void:
	on_tab(true)
func _challenge_tab() -> void:
	on_tab(true)
func _powerups_tab() -> void:
	on_tab(true)
