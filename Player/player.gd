extends CharacterBody2D

var axis : Vector2 = Vector2.ZERO
var death : bool=false

@export_category("config")
@export_group("Required References")
@export var gui : CanvasLayer

@export_group("Motion")
@export var speed :int = 110
@export var gravity : int = 16
@export var jump : int =368

func _process(delta):
	match death:
		true:
			death_ctrl()
		false:
			motion_ctrl()

func _input(event):
	if not death and is_on_floor() and event.is_action_pressed("ui_accept"):
		jump_ctrl(1)

func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	return axis.normalized()
	
func motion_ctrl() -> void:
		"""Movimiento"""
		if not get_axis().x == 0:
			$Sprite.scale.x = get_axis().x
		
		velocity.x = get_axis().x * speed
		velocity.y += gravity
		
		move_and_slide()
		
		"""Animaciones"""
		match is_on_floor():
			true:
				if not get_axis().x == 0:
					$Sprite.set_animation("run")
				else:
					$Sprite.set_animation("idle")
			false:
				if velocity.y < 0:
					$Sprite.set_animation("jump")
				else:
					$Sprite.set_animation("fall")

func death_ctrl() -> void:
	velocity.x = 0
	velocity.y += gravity
	move_and_slide()

func jump_ctrl(power : float) -> void:
	velocity.y = -jump * power
	$Audio/jump.play()

func damage_ctrl() -> void:
	death = true
	$Sprite.set_animation("death")
	
func _on_hit_point_body_entered(body):
	if body is enemy and velocity.y >= 0:
		$Audio/hit.play()
		body.damage_ctrl(1)
		jump_ctrl(0.75)

func _on_sprite_animation_finished():
	if $Sprite.animation == "death":
		gui.game_over()
