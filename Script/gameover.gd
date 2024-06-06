extends Control

func _ready():
	$Center/RichTextLabel.text = "[center][wave]GAME OVER\nSCORE: " + str(Global.score)

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://scenes/Niveles.tscn")

func _on_exit_pressed():
	get_tree().quit()
