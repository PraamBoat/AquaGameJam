extends CharacterBody2D

var speed = 300
var player_position
var target_position
@onready var player = get_parent().get_node("Player")

signal hit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_instance_valid(player):
		player_position = player.position
		target_position = (player_position - position).normalized()
		if position.distance_to(player_position) < 800:
			velocity = target_position * speed
			move_and_slide()


func _on_area_2d_body_entered(body):
	if (body == player):
		emit_signal("hit")
		queue_free()
