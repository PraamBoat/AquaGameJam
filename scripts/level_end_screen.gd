extends Control

var activeButton = 1
var levelOver=0
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _physics_process(delta):
	if levelOver == 1:
		if activeButton == 0:
			$TextureButton/Sprite2D.show()
			$TextureButton2/Sprite2D.hide()
		else:
			$TextureButton2/Sprite2D.show()
			$TextureButton/Sprite2D.hide()

func _input(event):
	if event.is_action_pressed("ui_left") and levelOver == 1:
		if activeButton>0:
			activeButton-=1
		else:
			activeButton=2
	elif event.is_action_pressed("ui_right") and levelOver == 1:
		if activeButton<2:
			activeButton+=1
		else:
			activeButton=0
	if event.is_action("ui_accept") and levelOver == 1:
		if activeButton == 0:
			get_tree().paused = false
			levelOver=0
			get_tree().change_scene_to_file("res://Scenes/main.tscn")
		elif activeButton == 1:
			get_tree().paused = false
			levelOver = 0
			get_tree().reload_current_scene()
		elif activeButton == 2:
			get_tree().paused = false
			levelOver=0
			get_tree().change_scene_to_file("res://scenes/level_screen.tscn")


func _on_texture_button_pressed():
	get_tree().paused = false
	levelOver = 0
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_texture_button_2_pressed():
	get_tree().paused = false
	levelOver = 0
	get_tree().reload_current_scene()
	

func _on_texture_button_3_pressed():
	get_tree().paused = false
	levelOver = 0
	get_tree().change_scene_to_file("res://scenes/level_screen.tscn")


func _on_level_timer_recording_done():
	show()
	$ColorRect/Label2.text="Time: %s" % Global.time_taken[0]
	$ColorRect/Label3.text="Water: %s" % Global.water
	levelOver = 1
	get_tree().paused = true
