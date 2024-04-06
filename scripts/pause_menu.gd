extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		hide()
		get_tree().paused = false

func _on_button_pressed():
	hide()
	get_tree().paused = false


func _on_button_2_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/title.tscn")
