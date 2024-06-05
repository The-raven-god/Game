extends Area2D

@onready var collision = $CollisionShape2D

func _on_body_entered(body):
	if body is player:
		get_tree().change_scene_to_file("res://scenes/Niveles.tscn")
