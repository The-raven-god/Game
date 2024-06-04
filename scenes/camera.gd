extends Camera2D

@export_category("Config")
@export_category("Required References")
@export var player: CharacterBody2D

func _ready():
	if player == null:
		player = get_node("res://Player/player.tscn")

func _process(delta):
	if player != null:
		global_position = player.global_position
	else:
		print("Player is not assigned or could not be found")
		global_position = global_position


