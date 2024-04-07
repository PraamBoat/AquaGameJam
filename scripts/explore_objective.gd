extends Node2D

signal AchievementComplete


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("AchievementComplete")
