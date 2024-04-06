extends Node2D

signal Water
signal NotWater

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("Water")


func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		emit_signal("NotWater")
