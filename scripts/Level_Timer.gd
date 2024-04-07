extends Node2D

var time = 0;
var timer_on =false
signal recordingDone
# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text="0"
	timer_on=true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer_on:
		time+=delta
	var secs= fmod(time, 60)
	var mins =fmod(time, 60**2)/60
	var time_passed= "%02d : %02d" % [mins,secs]
	$Label.text= time_passed# + " : " + var2str[time]
	

func _on_level_exit_end_level():
	Global.time_taken[$Label.text]
	timer_on=false
	emit_signal("recordingDone")
	print($Label.text)



