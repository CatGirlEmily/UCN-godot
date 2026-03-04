extends Control

@onready var NODE_menu := get_parent()
@onready var outline_t := [load("res://sprites/menu/tab/office/outline1.png"),load("res://sprites/menu/tab/office/outline2.png")]
var outline_timer := 0
const score_req := [0,2000,5000,8000]
var tabType := -1

func _ready() -> void:
	$buttons.show()
	$TAB.hide()
	$officeTab.hide()

func _process(_delta: float) -> void:
	if (tabType == 1): _office_loop()

func on_tab(entry: bool):
	if (entry):
		$TAB.show()
		$buttons.hide()
		NODE_menu.tabVisible = true
	else:
		$TAB.hide()
		$officeTab.hide()
		$buttons.show()
		NODE_menu.tabVisible = false
		

######################## office tab #########################
func _office_tab() -> void:
	outline_timer = 0
	on_tab(true)
	$officeTab.show()
	$officeTab/OUTLINE.position.y = (global.office * 240) + 126
	tabType = 1
	
	Util.showWhen($"officeTab/2000", global.HIGH_SCORE < 2000)
	Util.showWhen($"officeTab/5000", global.HIGH_SCORE < 5000)
	Util.showWhen($"officeTab/8000", global.HIGH_SCORE < 8000)
	
	if (global.HIGH_SCORE < 2000): $"officeTab/1".modulate.a = 0.4
	else: $"officeTab/1".modulate.a = 1
	if (global.HIGH_SCORE < 5000): $"officeTab/2".modulate.a = 0.4
	else: $"officeTab/2".modulate.a = 1
	if (global.HIGH_SCORE < 8000): $"officeTab/3".modulate.a = 0.4
	else: $"officeTab/3".modulate.a = 1
	
func _office_loop() -> void:
	outline_timer += 1
	if (outline_timer % 60 == 0): $officeTab/OUTLINE.texture = outline_t[0]
	if (outline_timer % 60 == 30): $officeTab/OUTLINE.texture = outline_t[1]

func _pick_office(office: int) -> void:
	if (global.HIGH_SCORE < score_req[office]): return
	global.office = office
	$officeTab/OUTLINE.position.y = (global.office * 240) + 126
	SoundManager.play_blip()

func _OK() -> void:
	on_tab(false)
###################### power ups #############################
func _powerups_tab() -> void:
	on_tab(true)



##################### challenges #############################
func _challenge_tab() -> void:
	on_tab(true)
