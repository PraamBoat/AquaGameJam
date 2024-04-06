extends Control

var text_to_show = "Glory to Aka-Chan"
var show_time = 2.5


func _ready():
	$ColorRect/Label.text = text_to_show
	hide()

func _on_timer_timeout():
	hide()

func _on_water_bar_show_popup():
	show()
	$AnimationPlayer.play("slide_in")


func _on_animation_player_animation_finished(anim_name):
	$Timer.start(show_time)
