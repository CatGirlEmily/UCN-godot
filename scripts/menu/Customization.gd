extends Control

const challengeNames := [
	"ch1",
	"ch2",
	"ch3",
	"ch4",
	"ch5",
	"ch6",
	"ch7",
	"ch8",
	"ch9",
	"ch10",
	"ch11",
	"ch12",
	"ch13",
	"ch14",
	"ch15",
	"ch16",
]

@onready var NODE_menu := get_parent()
@onready var labelSetting := load("res://other_res/challengeLabel.tres")
@onready var outline_t := [load("res://sprites/menu/tab/office/outline1.png"),load("res://sprites/menu/tab/office/outline2.png")]
@onready var outline_t2 := [load("res://sprites/menu/tab/powerups/outline1.png"),load("res://sprites/menu/tab/powerups/outline2.png")]
@onready var ch_t := [load("res://sprites/menu/tab/challenges/challenge.png"), load("res://sprites/menu/tab/challenges/challenge_sel.png")]
var outline_timer := 0
const score_req := [0,2000,5000,8000]
var tabType := -1
var challenge_nodes = []
var old_challenge

func _ready() -> void:
	$buttons.show()
	$TAB.hide()
	$officeTab.hide()
	$powerupsTab.hide()
	$challengesTab.hide()

func _process(_delta: float) -> void:
	if (tabType == 1): _office_loop()
	if (tabType == 2): _powerups_loop()
	if (tabType == 3): _challenges_loop()
	

func on_tab(entry: bool):
	if (entry):
		$TAB.show()
		$buttons.hide()
		NODE_menu.tabVisible = true
	else:
		$TAB.hide()
		$officeTab.hide()
		$powerupsTab.hide()
		$challengesTab.hide()
		$buttons.show()
		NODE_menu.tabVisible = false
######################## office tab #########################
func _office_OK() -> void:
	on_tab(false)
	
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
###################### power ups #############################
func _powerups_tab() -> void:
	on_tab(true)
	outline_timer = 0
	$powerupsTab.show()
	tabType = 2
	_update_active()
	
func _powerups_loop():
	outline_timer += 1
	
	if (outline_timer % 60 == 0):
		$powerupsTab/OUTLINE0.texture = outline_t2[0]
		$powerupsTab/OUTLINE1.texture = outline_t2[0]
		$powerupsTab/OUTLINE2.texture = outline_t2[0]
		$powerupsTab/OUTLINE3.texture = outline_t2[0]
	elif (outline_timer % 60 == 30):
		$powerupsTab/OUTLINE0.texture = outline_t2[1]
		$powerupsTab/OUTLINE1.texture = outline_t2[1]
		$powerupsTab/OUTLINE2.texture = outline_t2[1]
		$powerupsTab/OUTLINE3.texture = outline_t2[1]


func _update_active():
	$powerupsTab/OUTLINE0.visible = global.POWERUP_FRIGID
	$powerupsTab/OUTLINE1.visible = global.POWERUP_3_COINS
	$powerupsTab/OUTLINE2.visible = global.POWERUP_BATTERY
	$powerupsTab/OUTLINE3.visible = global.POWERUP_DD_REPEL
	

func _pick_powerup(pu: int) -> void:
	match pu:
		0: global.POWERUP_FRIGID = !global.POWERUP_FRIGID
		1: global.POWERUP_3_COINS = !global.POWERUP_3_COINS
		2: global.POWERUP_BATTERY = !global.POWERUP_BATTERY
		3: global.POWERUP_DD_REPEL = !global.POWERUP_DD_REPEL
	
	_update_active()
	SoundManager.play_blip()
	
##################### challenges #############################
func _challenge_tab() -> void:
	NODE_menu.canChangeAI = false
	$challengesTab.show()
	tabType = 3
	global.selectedChallenge = 0
	old_challenge = -1
	
	if challenge_nodes.is_empty(): _setup_challenges()
	on_tab(true)

func _challenges_loop() -> void:
	if old_challenge == global.selectedChallenge: return
	
	if (old_challenge >= 0):
		challenge_nodes[old_challenge].texture_normal = ch_t[0]
	challenge_nodes[global.selectedChallenge].texture_normal = ch_t[1]
	old_challenge = global.selectedChallenge

func _setup_challenges() -> void:
	# lambda here doesnt work. i dont know why either.
	for i in range(16):
		# button
		var ch := TextureButton.new()
		ch.texture_normal = ch_t[0]
		ch.position = Vector2(7,12)
		ch.position.y += i * 54
		ch.action_mode = BaseButton.ACTION_MODE_BUTTON_PRESS
		ch.pressed.connect(_ch_select.bind(i))
		$TAB.add_child(ch)
		
		# label
		var lb = Label.new()
		lb.position = ch.position
		lb.position += Vector2(23,15)
		lb.text = challengeNames[i]
		lb.label_settings = labelSetting
		lb.mouse_filter = Control.MOUSE_FILTER_IGNORE
		lb.modulate.a = 0.9
		$TAB.add_child(lb)
		
		# append to the list
		challenge_nodes.append(ch)

func _ch_select(id: int) -> void:
	print("WORKS ", id)
	#	global.selectedChallenge = id

func _ch_cancel() -> void:
	NODE_menu.canChangeAI = true
	on_tab(false)
