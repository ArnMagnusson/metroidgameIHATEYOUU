extends CanvasLayer

#make able to just say full:health.show() instead of $full_health
@onready var full_health = $full_health
@onready var two_hearts = $two_hearts
@onready var one_heart = $one_heart

var health = 3 #Max health sets at the start of the game. Works as a counter as well

func _ready():
	update_healthbar() # Ensure the correct sprite is shown at the start

func _process(_delta):
	_debug()  # For debug testing within the _process function

func _debug():
	if Input.is_action_just_pressed("Jump"):    
		print("Jump pressed, reducing health")
		health -= 1
		if health < 0:
			health = 0  # Prevent health from going below 0
		update_healthbar()
	
func update_healthbar():
	# Hide all at the start of the scene
	full_health.hide()
	two_hearts.hide()
	one_heart.hide()

	# Show the correct health sprite depending on how much health player has
	if health == 3:
		full_health.show()
	elif health == 2:
		two_hearts.show()
	elif health == 1:
		one_heart.show()
