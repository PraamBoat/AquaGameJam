extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = 5
	hide()

func _on_timer_timeout():
	$AnimationPlayer.play("slide_out")


func _on_water_droplet_collect():
	show()
	$AnimationPlayer.play("slide_in")


func _on_animation_player_animation_finished(anim_name):
	$Timer.start()
