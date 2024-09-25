extends Node

var last_location = Vector2()  # Define the variable to store the player's position
var player

func _ready():
	# Attempt to get the player node
	player = $"../../CharacterBody2D"
	if player:  # Check if player node was found
		last_location = player.global_position  # Store the player's starting position
	else:
		print("Error: Player node not found!")
