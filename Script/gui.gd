extends CanvasLayer

func _process(delta):
	$MarginContainer/Label.text = "SCORE: " + str(Global.score)

func game_over() -> void:
	print("Playing game over sound")
	$GameOver/Sound.play()

	var rect_node = $GameOver
	rect_node.modulate = Color(1, 1, 1, 0.8)

func _on_restart_pressed():
	get_tree().reload_current_scene()

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")


