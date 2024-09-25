extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var direction = 1  # 1 for right, -1 for left
var is_chasing_player = false

# Reference to RayCast2D for player detection
@onready var ray_cast = $RayCast2D

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle basic patrol or chase behavior
	if is_chasing_player:
		velocity.x = direction * SPEED
	else:
		# Patrol logic: simple back-and-forth movement
		patrol()

	move_and_slide()

func patrol():
	# Change direction if colliding with wall or edge
	if is_on_wall() or not is_on_floor():
		direction *= -1

	velocity.x = direction * SPEED

# Function called when player is detected by raycast
func _on_ray_cast_2d_player_detected():
	is_chasing_player = true
	direction = sign(ray_cast.get_cast_to().x)
	pass

# Function called when player is no longer detected
func _on_ray_cast_2d_player_lost():
	is_chasing_player = false
