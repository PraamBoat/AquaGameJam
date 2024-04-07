extends Control

const MAX_WATER = 100
const STARTING_WATER = 20
var water = STARTING_WATER
var dead = false
@onready var player = get_parent().get_parent().get_parent().get_node("Player")
@onready var sprite = player.get_node("Sprite2D")
@onready var hitbox = player.get_node("CollisionShape2D")

var loops

var sploosh = preload("res://sounds/water_woosh.mp3")
var splash = preload("res://sounds/splash.mp3")

signal game_over
signal show_popup

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "%s" % water
	$TextureProgressBar.value = water
	$AnimationPlayer.play("active")
	loops = 0
	
func _physics_process(delta):
	if is_instance_valid(player):
		sprite.scale = Vector2($TextureProgressBar.value/800,$TextureProgressBar.value/800)
		hitbox.scale = Vector2($TextureProgressBar.value/75,$TextureProgressBar.value/75)
		Global.player_size = $TextureProgressBar.value
	$Label.text = "%s" % $TextureProgressBar.value
	if ($TextureProgressBar.value <= 0):
		emit_signal("game_over")

func _input(event):
	if event.is_action_pressed("ui_copy"):
		$TextureProgressBar.value += 10

func _on_timer_timeout():
	$TextureProgressBar.value -= Global.passiveDrain
	#$Label.text = "%s" % $TextureProgressBar.value
	#if ($TextureProgressBar.value <= 0):
	#	emit_signal("game_over")

func _on_water_droplet_collect():
	$TextureProgressBar.value += 30


func _on_water_zone_not_water():
	$Timer.start()


func _on_water_zone_water():
	$Timer.stop()

func _on_dog_hit():
	$TextureProgressBar.value -= 10
	#$Label.text = "%s" % $TextureProgressBar.value
	$AudioStreamPlayer.stream = splash
	$AudioStreamPlayer.play()
	loops = 0
	$AnimationPlayer.play("damage")
	emit_signal("show_popup")
	
func _on_insect_hit():
	$TextureProgressBar.value -= 5
	#$Label.text = "%s" % $TextureProgressBar.value
	$AudioStreamPlayer.stream = splash
	$AudioStreamPlayer.play()
	loops = 0
	$AnimationPlayer.play("damage")
	emit_signal("show_popup")


func _on_insect_eat():
	$TextureProgressBar.value += 15
	#$Label.text = "%s" % $TextureProgressBar.value
	$AudioStreamPlayer.stream = sploosh
	$AudioStreamPlayer.play()
	emit_signal("show_popup")

func _on_dog_eat():
	$TextureProgressBar.value += 50
	#$Label.text = "%s" % $TextureProgressBar.value
	$AudioStreamPlayer.stream = sploosh
	$AudioStreamPlayer.play()
	emit_signal("show_popup")


func _on_water_zone_2_not_water():
	$Timer.start()


func _on_water_zone_2_water():
	$Timer.stop()


func _on_water_zone_3_not_water():
	$Timer.start()


func _on_water_zone_3_water():
	$Timer.stop()


func _on_water_zone_4_not_water():
	$Timer.start()


func _on_water_zone_4_water():
	$Timer.stop()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "damage":
		if loops == 4:
			$AnimationPlayer.play("active")
		else:
			loops+=1
			$AnimationPlayer.play("damage")


func _on_rat_eat():
	$TextureProgressBar.value += 20
	#$Label.text = "%s" % $TextureProgressBar.value
	$AudioStreamPlayer.stream = sploosh
	$AudioStreamPlayer.play()
	emit_signal("show_popup")


func _on_rat_hit():
	$TextureProgressBar.value -= 10
	#$Label.text = "%s" % $TextureProgressBar.value
	$AudioStreamPlayer.stream = splash
	$AudioStreamPlayer.play()
	loops = 0
	$AnimationPlayer.play("damage")
	emit_signal("show_popup")


func _on_water_zone_5_not_water():
	$Timer.start()


func _on_water_zone_5_water():
	$Timer.stop()
