extends Control

var bubble = preload("res://scenes/bubble.tscn")
var bgm = preload("res://sounds/We_Love_Title_Screens.mp3")
var selecting = false

func _ready():
	$AnimationPlayer.play("bound")
	$Timer.wait_time = 0.1
	$Timer.start()
	$AudioStreamPlayer.stream = bgm
	$AudioStreamPlayer.play()

func _input(event):
	if event.is_action_pressed("ui_accept") && not selecting:
		$AnimationPlayer2.play("fly_in")
		selecting = true
		#get_tree().change_scene_to_file("res://scenes/level_screen.tscn")
	elif event.is_action_pressed("ui_cancel") && selecting:
		$AnimationPlayer2.play("fly_out")
		selecting = false

func _on_texture_button_pressed():
	if not selecting:
		$AnimationPlayer2.play("fly_in")
		selecting = true
	#get_tree().change_scene_to_file("res://Scenes/level_screen.tscn")


func _on_timer_timeout():
	var bub = bubble.instantiate()
	add_child(bub)
	bub.position.y = randi_range(0, 640)
	$Timer.wait_time = randf_range(0.05, 0.5)
	$Timer.start()


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()


func _on_level_1_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_level_2_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_level_3_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_back_button_pressed():
	$AnimationPlayer2.play("fly_out")
	selecting = false
