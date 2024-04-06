extends Control

const MAX_WATER = 300
const STARTING_WATER = 100
var water = STARTING_WATER

signal game_over

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "Health %s" % water
	$ProgressBar.value = water

func _on_timer_timeout():
	$ProgressBar.value -= 10
	$Label.text = "Health is %s" % $ProgressBar.value
	if ($ProgressBar.value <= 0):
		$Label.text = "Dead"
		emit_signal("game_over")
