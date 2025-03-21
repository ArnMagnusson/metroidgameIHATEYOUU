extends CharacterBody2D

#stats, contains speed, health and different variables
class_name GrassEnemy

const speed = 25
var is_enemy_chase: bool = false

var health = 1
var health_max = 1
var health_min = 0

var dead: bool = false
var taking_damage: bool = false
var damage_to_deal: = 1
var is_dealing_damage: bool = false

var dir: Vector2
const gravity = 900
var knockback_force = -20
var is_roaming: bool = true

var player: CharacterBody2D
var player_in_area = false

#movement, gravity, handling other functions
func _process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0
	player = Global.playerBody
	move(delta)
	handle_animation()
	move_and_slide()

#movement functions, knockback, chasing
func move(delta):
	if !dead:
		if !is_enemy_chase:
			velocity += dir * speed * delta
		elif is_enemy_chase and !taking_damage:
			var dir_to_player = position.direction_to(player.position) * speed
			velocity.x = dir_to_player.x
			dir.x = abs(velocity.x) / velocity.x
		elif taking_damage:
			var knockback_dir = position.direction_to(player.position) * knockback_force
			velocity.x = knockback_dir.x
		is_roaming = true
	elif dead:
		velocity.x = 0

#animation player
func handle_animation():
	var anim_sprite = $AnimatedSprite2D
	if !dead and !taking_damage and !is_dealing_damage:
		anim_sprite.play("walk")
		if dir.x == 1:
			anim_sprite.flip_h = true
		elif dir.x == -1:
			anim_sprite.flip_h = false
	elif !dead and taking_damage and !is_dealing_damage:
		anim_sprite.play("hurt")
		await get_tree().create_timer(0.66).timeout
		taking_damage = false
	elif dead and is_roaming:
		is_roaming = false
		anim_sprite.play("death")
		await get_tree().create_timer(1).timeout
		handle_death()

#death function, removes enemy when it dies
func handle_death():
	self.queue_free()

#choosing which direction to go
func _on_direction_timer_timeout() -> void:
	$DirectionTimer.wait_time = choose([1.5,2,2.5])
	if !is_enemy_chase:
		dir = choose([Vector2.RIGHT,Vector2.LEFT])
		velocity.x = 0

#choose function
func choose(array):
	array.shuffle()
	return array.front()

#take damage, do damage
func _on_hitbox_area_entered(area: Area2D) -> void:
	pass
