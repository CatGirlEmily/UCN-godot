extends Node

func play(path: String, vol: int = -10, loop: bool = false, shouldFree: bool = true):
	var sound := AudioStreamPlayer.new()
	sound.stream = load(path)
	sound.volume_db = vol
	#sound.loopin = loop
	add_child(sound)
	sound.play()
	if shouldFree:
		await sound.finished
		sound.queue_free()

func forceStop(player):
	player.stop()

func play_click1(): play("res://sounds/click1.wav")
func play_click2(): play("res://sounds/click2.wav")
func play_doorFX(): play("res://sounds/doorFX.wav")
func play_blip(): play("res://sounds/blip.wav")
