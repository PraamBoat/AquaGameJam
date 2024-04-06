extends Control

const MAX_WATER = 100
const STARTING_WATER = 100
var water = STARTING_WATER
var dead = false
@onready var player = get_parent().get_parent().get_parent().get_node("Player")
@onready var sprite = player.get_node("Sprite2D")

signal game_over

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "Health %s" % water
	$ProgressBar.value = water
	
func _physics_process(delta):
	if is_instance_valid(player):
		sprite.scale = Vector2($ProgressBar.value/1000,$ProgressBar.value/1000)

func _on_timer_timeout():
	$ProgressBar.value -= Global.passiveDrain
	$Label.text = "Health is %s" % $ProgressBar.value
	if ($ProgressBar.value <= 0):
		$Label.text = "Dead"
		emit_signal("game_over")

func _on_dog_hit():
	$ProgressBar.value -= 30
