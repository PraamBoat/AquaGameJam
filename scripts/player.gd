extends CharacterBody2D

const SPEED = 50.0
const MAX_SPEED = 200.0
const D_SPEED = 100.0
const DASH_SPEED = 350
const DAMP = 10.0

var h_direction
var v_direction
var dashing

var downPress = false
var upPress = false
var leftPress = false
var rightPress = false
var isPlaying = false

var splash = preload("res://sounds/splash.mp3")
var running = preload("res://sounds/running_water.mp3")

func _ready():
	$AudioStreamPlayer2D.stream = running

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

func _input(event):
	if event.is_action_pressed("ui_right") || event.is_action_pressed("ui_left"):
		$Sprite2D.rotation += Input.get_axis("ui_right", "ui_left") * 1
	if event.is_action_pressed("ui_up") && $Sprite2D.flip_v:
		$Sprite2D.flip_v = false;
	if event.is_action_pressed("ui_down") && !$Sprite2D.flip_v:
		$Sprite2D.flip_v = true;
	
	if event.is_action_pressed("ui_down"):
		downPress = true
		if (!isPlaying):
			$AudioStreamPlayer2D.play()
			isPlaying = true
	if event.is_action_pressed("ui_up"):
		upPress = true
		if (!isPlaying):
			$AudioStreamPlayer2D.play()
			isPlaying = true
	if event.is_action_pressed("ui_right"):
		rightPress = true
		if (!isPlaying):
			$AudioStreamPlayer2D.play()
			isPlaying = true
	if event.is_action_pressed("ui_left"):
		leftPress = true
		if (!isPlaying):
			$AudioStreamPlayer2D.play()
			isPlaying = true
	if event.is_action_released("ui_down"):
		downPress = false
	if event.is_action_released("ui_up"):
		upPress = false
	if event.is_action_released("ui_right"):
		rightPress = false
	if event.is_action_released("ui_left"):
		leftPress = false
	if event.is_action_released("ui_up") ||  event.is_action_released("ui_left") || event.is_action_released("ui_right") || event.is_action_released("ui_down"):
		if (!leftPress && !rightPress && !upPress && !downPress):
			$AudioStreamPlayer2D.stream_paused = true
			isPlaying = false
			
	if event.is_action_pressed("ui_run"):
		dashing = true
		$AudioStreamPlayer2D.stream = splash
		if (downPress || rightPress || upPress || downPress):
			$AudioStreamPlayer2D.play()
		Global.passiveDrain += 4
			
	if event.is_action_released("ui_run"):
		if abs(velocity.x) > MAX_SPEED:
			if velocity.x > 0:
				velocity.x = MAX_SPEED + 50
			else:
				velocity.x = -1 * MAX_SPEED + 50
		if abs(velocity.y) > MAX_SPEED:
			if velocity.y > 0:
				velocity.y = MAX_SPEED + 50
			else:
				velocity.y = -1 * MAX_SPEED - 50
		$AudioStreamPlayer2D.stream = running
		if (downPress || rightPress || upPress || downPress):
			$AudioStreamPlayer2D.play()
		dashing = false
		Global.passiveDrain -= 4

func _on_node_2d_game_over():
	queue_free()

func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()
	
func knockback(enemy_velocity):
	velocity.x += 6 * enemy_velocity.x
	velocity.y += 6 * enemy_velocity.y
