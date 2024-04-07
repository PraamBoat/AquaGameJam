extends CharacterBody2D

var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = randi_range(250, 700)
	z_index = -2
	velocity.x = speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide()
	if position.x > 1300:
		queue_free()
