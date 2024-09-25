extends Node

# Store the player's last location (checkpoint location)
var last_location = Vector2()  
var player

func _ready():
	player = get_parent().get_node("CharacterBody2D")  # Get the player node
	last_location = player.global_position  # Initialize with the player's starting position

# Optionally, add methods here to update the player's last location when they reach new checkpoints
