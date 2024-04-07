extends Control

var activeButton = 0
var gameOver = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _physics_process(delta):
	if gameOver == 1:
		if activeButton == 0:
			$TextureButton/Sprite2D.show()
			$TextureButton2/Sprite2D.hide()
		else:
			$TextureButton2/Sprite2D.show()
			$TextureButton/Sprite2D.hide()

func _input(event):
	if event.is_action_pressed("ui_left") and gameOver == 1:
		activeButton = 0
	elif event.is_action_pressed("ui_right") and gameOver == 1:
		activeButton = 1
	if event.is_action("ui_accept") and gameOver == 1:
		if activeButton == 0:
			get_tree().paused = false
			gameOver = 0
			get_tree().reload_current_scene()
		elif activeButton == 1:
			get_tree().paused = false
			get_tree().change_scene_to_file("res://scenes/title.tscn")

func _on_water_bar_game_over():
	show()
	gameOver = 1
	get_tree().paused = true
	

func _on_texture_button_2_pressed():
	get_tree().paused = false
	gameOver = 0
	get_tree().change_scene_to_file("res://scenes/title.tscn")


func _on_texture_button_pressed():
	get_tree().paused = false
	gameOver = 0
	get_tree().reload_current_scene()
