extends CharacterBody2D

const SPEED = 50.0
const MAX_SPEED = 500.0
const D_SPEED = 100.0
const DASH_SPEED = 1000
const DAMP = 10.0
const BASE_SCALE = 0.075

var h_direction
var v_direction
var dashing

func _physics_process(delta):
	h_direction = Input.get_axis("ui_left", "ui_right")
	if h_direction && dashing && abs(velocity.x) < DASH_SPEED:
		velocity.x += h_direction * D_SPEED
	elif h_direction && abs(velocity.x) < MAX_SPEED:
		velocity.x += h_direction * SPEED
	elif abs(velocity.x) > 0:
		if velocity.x < 0:
			velocity.x += DAMP
		else:
			velocity.x -= DAMP
	
	v_direction = Input.get_axis("ui_up", "ui_down")
	if v_direction && dashing && abs(velocity.y) < DASH_SPEED:
		velocity.y += v_direction * D_SPEED
	elif v_direction && abs(velocity.y) < MAX_SPEED:
		velocity.y += v_direction * SPEED
	elif abs(velocity.y) > 0:
		if velocity.y < 0:
			velocity.y += DAMP
		else:
			velocity.y -= DAMP
	move_and_slide()

	if h_direction && v_direction:
		$Sprite2D.rotation -= 1 * h_direction * v_direction * delta
	elif h_direction:
		$Sprite2D.rotation += 1 * h_direction * delta
	#move_and_slide()

func _input(event):
	if event.is_action_pressed("ui_right") || event.is_action_pressed("ui_left"):
		$Sprite2D.rotation += Input.get_axis("ui_right", "ui_left") * 1

	if event.is_action_pressed("ui_up") && $Sprite2D.flip_v:
		$Sprite2D.flip_v = false;

	if event.is_action_pressed("ui_down") && !$Sprite2D.flip_v:
		$Sprite2D.flip_v = true;
		
	if event.is_action_pressed("ui_accept"):
		dashing = true
		Global.passiveDrain += 4
	if event.is_action_released("ui_accept"):
		if abs(velocity.x) > MAX_SPEED:
			velocity.x = MAX_SPEED
		if abs(velocity.y) > MAX_SPEED:
			velocity.y = MAX_SPEED
		dashing = false
		Global.passiveDrain -= 4
		

func _on_node_2d_game_over():
	queue_free()
