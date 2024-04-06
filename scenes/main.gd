extends Node2D

const MAX_WATER = 300
const STARTING_WATER = 100
var water = STARTING_WATER

# Called when the node enters the scene tree for the first time.
func _ready():
	$Node2D/Label.text = "Health %s" % water
	$Node2D/TextureProgressBar.max_value = MAX_WATER
	$Node2D/TextureProgressBar.value = water

func _on_timer_timeout():
	$Node2D/TextureProgressBar.value -= 10
	$Node2D/Label.text = "Clear"
	if ($Node2D/TextureProgressBar.value <= 0):
		$CharacterBody2D.queue_free()
	
