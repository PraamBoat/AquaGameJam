extends CharacterBody2D

var speed = 200
var size = 40
var player_position
var target_position
@onready var player = get_parent().get_node("Player")
var HIT_TEXT = "Rats are able to swim for 3 days straight."
var EAT_TEXT = "Rats can be flushed down a toilet and easily live."

signal hit
signal eat

func _ready():
	$Label.text = "%s" % size

func _process(delta):
	if is_instance_valid(player):
		player_position = player.position
		target_position = (player_position - position).normalized()
		if position.distance_to(player_position) < 500:
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
			player.get_node("Camera2D").get_node("PopUp").get_node("ColorRect").get_node("TextureRect").texture = load("res://images/rat.png")
			player.knockback(velocity)
			#player.get_node("Camera2D").get_node("PopUp").get_node("ColorRect").get_node("TextureRect").scale = Vector2(0.1, 0.1)
			emit_signal("hit")
			#queue_free()
