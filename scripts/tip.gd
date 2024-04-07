extends Control

var show_time = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = show_time
	hide()

func _on_timer_timeout():
	$AnimationPlayer.play("slide_out")


func _on_water_droplet_collect():
	$RichTextLabel.text = "Watch out for critters! They’ll make you lose water and knock you back. If you get enough water, you can get back at them!"
	usual()

func _on_animation_player_animation_finished(anim_name):
	$Timer.paused = false
	$Timer.start()

func usual():
	show()
	$Timer.paused = true
	$Timer.wait_time = show_time
	$AnimationPlayer.play("slide_in")

func _on_water_droplet_3_collect():
	$RichTextLabel.text = "This is Blobby. He loses water when he’s not in it. Collect water droplets to gain small amounts of water."
	usual()
