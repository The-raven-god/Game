extends CharacterBody2D
class_name enemy

@export_category("Config")
@export_group("Options")
@export var health : int = 1
@export var score: int = 100

@export_group("Motion")
@export var speed : int = 16
@export var gravity : int = 16
var timer = 0
var change_time = 3 
var direction : int = 1

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = direction * speed
	move_and_slide()

	$Sprite.flip_h = direction < 0  # Asegúrate de que la dirección se refleje correctamente

	timer += delta
	if timer > change_time:
		direction *= -1
		timer = 0

func motion_ctrl() -> void:
	velocity.x = direction * speed
	velocity.y += gravity
	move_and_slide()
	
func _process(_delta):
	if health > 0:
		motion_ctrl()

func damage_ctrl(damage : int) -> void:
	health -= damage
	if health <= 0:
		$Sprite.set_animation("death")
		$Collision.set_deferred("disable", true)
		gravity = 0
		Global.score += score

func _on_sprite_animation_finished():
	if $Sprite.animation == "death":
		queue_free()

func _on_area_hit_body_entered(body):
	if body and body is player and health > 0:
		body.damage_ctrl()







