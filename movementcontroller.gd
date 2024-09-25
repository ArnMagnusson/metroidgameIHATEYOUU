extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

func _physics_process(delta):
	# Add the gravity. is on floor detects if its a flat surface on the button.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump, checks if on floor and if value is true jump gets activated
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# if in air and releases space, set velocity to 0
	if Input.is_action_just_released("ui_accept"):
		if velocity.y < -50:
			velocity.y = -50

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left_A", "Right_D")
	# print(Input.get_axis("left_A", "Right_D"))
	
	#Flip sprite, depending on direction
	# if its above 0 its moving right if below zero moving left
	if direction > 0:
		$AnimatedSprite2D.flip_h = false
	if direction < 0:
		$AnimatedSprite2D.flip_h = true

	# Play animation when moving
	if velocity.is_zero_approx():
		$AnimatedSprite2D.play("Walk")
	if direction == 0:
		$AnimatedSprite2D.play("Idle")
	
	#Direction = movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
