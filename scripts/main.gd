extends Node2D

var bgm = preload("res://sounds/We_Love_Water_Music.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE
	$AudioStreamPlayer.stream = bgm
	$AudioStreamPlayer.play()

#func _input(event):
	#if event.is_action_pressed("ui_cancel") and not get_tree().paused:
	#	$Player/Camera2D/PauseControl.show()
	#	get_tree().paused = true

func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
