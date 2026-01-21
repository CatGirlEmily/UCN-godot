extends Node

var quitTime := 0.0
var ai := [] # i could not figure out how to map / fill all 50 places with 0
var spr_char := []
const max_ai := 20
const default_energy = 10000
const font_bit := [
	preload("res://sprites/font/bit/0.png"),
	preload("res://sprites/font/bit/1.png"),
	preload("res://sprites/font/bit/2.png"),
	preload("res://sprites/font/bit/3.png"),
	preload("res://sprites/font/bit/4.png"),
	preload("res://sprites/font/bit/5.png"),
	preload("res://sprites/font/bit/6.png"),
	preload("res://sprites/font/bit/7.png"),
	preload("res://sprites/font/bit/8.png"),
	preload("res://sprites/font/bit/9.png")	
]
const font_smooth := [
	preload("res://sprites/font/smooth/0.png"),
	preload("res://sprites/font/smooth/1.png"),
	preload("res://sprites/font/smooth/2.png"),
	preload("res://sprites/font/smooth/3.png"),
	preload("res://sprites/font/smooth/4.png"),
	preload("res://sprites/font/smooth/5.png"),
	preload("res://sprites/font/smooth/6.png"),
	preload("res://sprites/font/smooth/7.png"),
	preload("res://sprites/font/smooth/8.png"),
	preload("res://sprites/font/smooth/9.png"),
	preload("res://sprites/font/smooth/10.png")
]
const font_battery := [
	preload("res://sprites/font/battery/0.png"),
	preload("res://sprites/font/battery/1.png"),
	preload("res://sprites/font/battery/2.png"),
	preload("res://sprites/font/battery/3.png"),
	preload("res://sprites/font/battery/4.png"),
	preload("res://sprites/font/battery/5.png"),
	preload("res://sprites/font/battery/6.png"),
	preload("res://sprites/font/battery/7.png"),
	preload("res://sprites/font/battery/8.png"),
	preload("res://sprites/font/battery/9.png")
]
const help_text = [
	"Freddy help text",
	"Bonnie help text",
	"Chica help text",
	"Foxy help text",
	"Toy Freddy help text",
	"toy bonie",
	"toy chika",
	"toy mangul",
	"balun boj",
	"jj joker",
	"withered chika",
	"withered boni",
	"pupet",
	"golden fredi",
	"springtrap",
	"phanjtom mangul",
	"phantom fredi",
	"phantom bb",
	"nightmare freddy",
	"nightmare boni",
	"nightmare fredber",
	"nightmare",
	"jackochika",
	"nightmare mangl",
	"nightmarine kurwa zasrana",
	"nightmare bb",
	"old man",
	"bejbi",
	"balora <3",
	"femboy foxy",
	"ennard",
	"trasz gang",
	"helpi",
	"shayy",
	"mrhipo",
	"pigpatch",
	"fredcostam",
	"orville",
	"rockstar fredy",
	"rokstrar boni",
	"rokstar chika",
	"rokstar foxy",
	"musik man",
	"el chip",
	"slut",
	"molten fred",
	"scrap bejbi",
	"afton",
	"lefty",
	"phone guy"
]

var HIGH_SCORE = randi_range(0, max_ai*10*50)
var BEST_TIME = randi_range(0,2700)

var POWERUP_FRIGID := false
var POWERUP_3_COINS := false
var POWERUP_DD_REPEL := false
var POWERUP_BATTERY := false


var showCharInfo = false
var visualEffects = false
var office = 3
var windowType = Input.MOUSE_MODE_CONFINED

var KEYBIND_LEFT_DOOR := "A"
var KEYBIND_RIGHT_DOOR := "D"
var KEYBIND_VENT_UP := "W"
var KEYBIND_VENT_RIGHT := "F"
var KEYBIND_FAN := "SPACE"
var KEYBIND_CAMERA := "S"


func _ready() -> void:
	_map()
	Input.set_mouse_mode(windowType)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ESC"): get_tree().quit() # dev
	if event.is_action_pressed("F1") and night.nightFrame >= 1: night.reset() # dev
	if event.is_action_pressed("F2"): night.reset(); get_tree().change_scene_to_file("res://scenes/menu.tscn")
	

func _map() -> void: # assigns 0 to every ai[] entry, and coresponding texture to it
	ai.resize(50)
	spr_char.resize(50)
	for i in range(50):
		ai[i] = 0
		spr_char[i] = "res://sprites/menu/char/%d.png" % i

func sum_points():
	var a = 0
	for i in ai.size(): a += ai[i] * 10
	return a
