extends Area2D

var score: int = 100

func spawn_feedback():
	var scene_to_spawn = preload("res://Pickups/Feedback/feedback.tscn")
	var new_scene_instance = scene_to_spawn.instantiate()
	get_tree().current_scene.add_child(new_scene_instance)
	new_scene_instance.global_position = global_position


func _on_body_entered(body):
	spawn_feedback()
	$Sound.play()
	queue_free()
	Global.score += score
