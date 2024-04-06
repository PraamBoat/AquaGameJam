extends CharacterBody2D

const SPEED = 300.0

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var h_direction = Input.get_axis("ui_left", "ui_right")
	if h_direction:
		velocity.x = h_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var v_direction = Input.get_axis("ui_up", "ui_down")
	if v_direction:
		velocity.y = v_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()


func _on_node_2d_game_over():
	queue_free()
