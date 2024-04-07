extends Node2D

signal endLevel
signal canEnd
signal cannotEnd

var NextLevel=0
var achievments=1


func _on_popup_body_entered(body):
	if body.is_in_group("Player"):
		if NextLevel>=achievments:
			emit_signal("canEnd")
		else:
			emit_signal("cannotEnd")
	
		


func _on_exit_body_entered(body):
	if body.is_in_group("Player"):
		if NextLevel>=achievments:
			emit_signal("endLevel")


func _on_explore_objective_achievement_complete():
	NextLevel+=1
