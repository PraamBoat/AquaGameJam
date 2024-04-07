extends CharacterBody2D

var speed = 150
var size = 25
var player_position
var target_position
@onready var player = get_parent().get_node("Player")
var HIT_TEXT = "Did you know that insects were the first type of animal to go on land after the ocean formed?"
var EAT_TEXT = "Cool Bug Fact: Did you know that most insects can walk on water?"

signal hit
signal eat

func _ready():
	$Label.text = "%s" % size

func _process(delta):
	if is_instance_valid(player):
		player_position = player.position
		target_position = (player_position - position).normalized()
		if position.distance_to(player_position) < 700:
			velocity = target_position * speed
			move_and_slide()


func _on_area_2d_body_entered(body):
	if (body == player):
		if (size < Global.player_size):
			player.get_node("Camera2D").get_node("PopUp").get_node("RichTextLabel").text = EAT_TEXT
			player.get_node("Camera2D").get_node("PopUp").get_node("ColorRect").get_node("TextureRect").texture = load("res://images/blobby.png")
			#player.get_node("Camera2D").get_node("PopUp").get_node("ColorRect").get_node("TextureRect").scale = Vector2(0.1, 0.1)
			emit_signal("eat")
			queue_free()
		else:
			player.get_node("Camera2D").get_node("PopUp").get_node("RichTextLabel").text = HIT_TEXT
			player.get_node("Camera2D").get_node("PopUp").get_node("ColorRect").get_node("TextureRect").texture = load("res://images/insect.png")
			player.knockback(velocity)
			#player.get_node("Camera2D").get_node("PopUp").get_node("ColorRect").get_node("TextureRect").scale = Vector2(0.1, 0.1)
			emit_signal("hit")
			#queue_free()
