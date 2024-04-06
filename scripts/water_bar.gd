extends Control

const MAX_WATER = 100
const STARTING_WATER = 20
var water = STARTING_WATER
var dead = false
@onready var player = get_parent().get_parent().get_parent().get_node("Player")
@onready var sprite = player.get_node("Sprite2D")
@onready var hitbox = player.get_node("CollisionShape2D")

var sploosh = preload("res://sounds/water_woosh.mp3")
var splash = preload("res://sounds/splash.mp3")

signal game_over
signal show_popup

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "Health %s" % water
	$ProgressBar.value = water
	
func _physics_process(delta):
	if is_instance_valid(player):
		sprite.scale = Vector2($ProgressBar.value/1000,$ProgressBar.value/1000)
		hitbox.scale = Vector2($ProgressBar.value/1000,$ProgressBar.value/1000)
		Global.player_size = $ProgressBar.value

func _on_timer_timeout():
	$ProgressBar.value -= Global.passiveDrain
	$Label.text = "Health is %s" % $ProgressBar.value
	if ($ProgressBar.value <= 0):
		$Label.text = "Dead"
		emit_signal("game_over")

func _on_water_droplet_collect():
	$ProgressBar.value += 30


func _on_water_zone_not_water():
	$Timer.start()


func _on_water_zone_water():
	$Timer.stop()

func _on_dog_hit():
	$ProgressBar.value -= 30
	$Label.text = "Health is %s" % $ProgressBar.value
	$AudioStreamPlayer.stream = splash
	$AudioStreamPlayer.play()
	emit_signal("show_popup")
	
func _on_insect_hit():
	$ProgressBar.value -= 15
	$Label.text = "Health is %s" % $ProgressBar.value
	$AudioStreamPlayer.stream = splash
	$AudioStreamPlayer.play()
	emit_signal("show_popup")


func _on_insect_eat():
	$ProgressBar.value += 15
	$Label.text = "Health is %s" % $ProgressBar.value
	$AudioStreamPlayer.stream = sploosh
	$AudioStreamPlayer.play()
	emit_signal("show_popup")


func _on_dog_eat():
	$ProgressBar.value += 50
	$Label.text = "Health is %s" % $ProgressBar.value
	$AudioStreamPlayer.stream = sploosh
	$AudioStreamPlayer.play()
	emit_signal("show_popup")
