extends CharacterBody2D
class_name enemy

@export_category("Config")
@export_group("Options")
@export var health : int = 1
@export var score: int = 100

@export_group("Motion")
@export var speed : int = 16
@export var gravity : int = 16

var direction := 1

func _process(delta):
	if health > 0:
		motion_ctrl()

func motion_ctrl() -> void:
	$Sprite.scale.x = direction
	
	if not $Sprite/RayGround.is_colliding() or is_on_wall():
		direction *= -1
		
	velocity.x =direction * speed
	velocity.y += gravity
	move_and_slide()

func damage_ctrl(damage : int) -> void:
	health -= damage
	if health <= 0:
		$Sprite.set_animation("death")
		$Collision.set_deferred("disable",true)
		gravity = 0
		Global.score += score

func _on_sprite_animation_finished():
	if $Sprite.animation == "death":
		queue_free()
		
func _on_area_hit_body_entered(body):
	if body is player and health > 0:
		body.damage_crtl()



