extends CharacterBody2D

var speed = 300
var size = 50
var player_position
var target_position
@onready var player = get_parent().get_node("Player")
var HIT_TEXT = "Hit by dog lmao. -30% water cause he's a thirsty boy"
var EAT_TEXT = "Dogs are 50% to 70% water content. Very yummy!"
var seen = false
var originalPosition

signal hit
signal eat

func _ready():
	originalPosition = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_instance_valid(player):
		player_position = player.position
		target_position = (player_position - position).normalized()
		if position.distance_to(player_position) < 500:
			velocity = target_position * speed
			move_and_slide()
		else:
			target_position = (originalPosition - position).normalized()
			if position.distance_to(target_position) > 100:
				velocity = target_position * speed
				move_and_slide()

func _on_area_2d_body_entered(body):
	if (body == player):
		if (size < Global.player_size):
			player.get_node("Camera2D").get_node("PopUp").get_node("ColorRect").get_node("Label").text = EAT_TEXT
			player.get_node("Camera2D").get_node("PopUp").get_node("ColorRect").get_node("TextureRect").texture = load("res://images/blobby.png")
			#player.get_node("Camera2D").get_node("PopUp").get_node("ColorRect").get_node("TextureRect").scale = Vector2(0.05, 0.05)
			emit_signal("eat")
			queue_free()
		else:
			player.get_node("Camera2D").get_node("PopUp").get_node("ColorRect").get_node("Label").text = HIT_TEXT
			player.get_node("Camera2D").get_node("PopUp").get_node("ColorRect").get_node("TextureRect").texture = load("res://images/rabid_dog.png")
			#player.get_node("Camera2D").get_node("PopUp").get_node("ColorRect").get_node("TextureRect").scale = Vector2(0.05, 0.05)
			player.knockback(velocity)
			emit_signal("hit")
			#queue_free()
