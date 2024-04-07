extends Control

var activeButton = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	process_mode = Node.PROCESS_MODE_ALWAYS


func _physics_process(delta):
	if get_tree().paused:
		if activeButton == 0:
			$Button/ColorRect.show()
			$Button2/ColorRect.hide()
		else:
			$Button2/ColorRect.show()
			$Button/ColorRect.hide()

func _input(event):
	if event.is_action_pressed("ui_cancel") and get_tree().paused:
		hide()
		get_tree().paused = false
	elif event.is_action_pressed("ui_cancel") and not get_tree().paused:
		show()
		get_tree().paused = true
	if event.is_action_pressed("ui_up") and get_tree().paused:
		activeButton = 0
	elif event.is_action_pressed("ui_down") and get_tree().paused:
		activeButton = 1
	if event.is_action("ui_accept") and get_tree().paused:
		if activeButton == 0:
			hide()
			get_tree().paused = false
		elif activeButton == 1:
			get_tree().paused = false
			get_tree().change_scene_to_file("res://Scenes/title.tscn")

func _on_button_pressed():
	hide()
	get_tree().paused = false


func _on_button_2_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/title.tscn")
