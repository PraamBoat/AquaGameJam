extends Node2D

var bgm = preload("res://sounds/We_Love_Water_Music.mp3")
var zap = preload("res://sounds/zap.mp3")

func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE
	$AudioStreamPlayer.stream = bgm
	$AudioStreamPlayer.play()
	Global.paused = false
	get_tree().paused = false
	Global.passiveDrain = 1

func _input(event):
	if event.is_action_pressed("ui_cancel") and not Global.paused:
		$Player/Camera2D/PauseControl.show()
		Global.paused = true
		get_tree().paused = true

func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()


func _on_area_2d_body_entered(body):
	if (body == $Player):
		$Player.knockback(-$Player.velocity)
		$SoundEffects.stream = zap
		$SoundEffects.play()


func _on_area_2d_2_body_entered(body):
	if (body == $Player):
		$Player.knockback(-$Player.velocity)
