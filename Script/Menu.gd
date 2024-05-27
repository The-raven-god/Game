extends Control

func _ready():
	$Butones/Start.grab_focus()
	
func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/Niveles.tscn")
	
func _on_exit_pressed():
	get_tree().quit()


