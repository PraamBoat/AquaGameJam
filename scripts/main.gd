extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$Player/Camera2D/PauseControl.show()
		get_tree().paused = true
