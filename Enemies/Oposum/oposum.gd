extends CharacterBody2D
class_name enemy

@export_category("config")

@export_group("Options")
@export var health: int=1
@export var score: int=100

@export_group("Motion")
@export var speed: int=16
@export var gravity: int=16

var direction := 1

func _process(delta):
	if health > 0:
		motion_ctrl()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	velocity.x = direction * speed
	move_and_slide()
	if direction > 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	
func damage_ctrl(damage : int) -> void:
	health -= damage
	if health <= 0:
		$Sprite.set_animation("death")
		$Collision.set_deferred("disable",true)
		gravity = 0
		Global.score += score

func _on_timer_timeout():
	direction *= -1


func _on_animated_sprite_2d_animation_finished():
	if $Sprite.animation == "death":
		queue_free()


func _on_area_hit_body_entered(body):
	if body is Player and health > 0:
		body.damage_ctrl()
