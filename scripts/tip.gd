extends Control

var show_time = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = show_time
	hide()

func _on_timer_timeout():
	#$AnimationPlayer.play("slide_out")
	hide()


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
	$RichTextLabel.text = "This is Blobby. He loses water when he’s not in it. Collect water droplets to gain small amounts of water.\nYou can sprint using Shift or A, but be careful, you lose more water when sprinting!"
	usual()


func _on_explore_objective_achievement_complete():
	$RichTextLabel.text = "The average family can waste 180 gallons per week, or 9,400 gallons of water annually, from household leaks. That's equivalent to the amount of water needed to wash more than 300 loads of laundry."
	usual()


func _on_level_exit_cannot_end():
	$RichTextLabel.text = "Sorry, please explore more to exit the level. Try collecting more bubbles around the house."
	usual()


func _on_level_exit_can_end():
	$RichTextLabel.text = "Congrats, enter the sink to end the level."
	usual()
