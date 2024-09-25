extends Area2D

var checkpoint_manager
var player

func _ready():
	# Ensure you are accessing the correct nodes in the scene tree
	checkpoint_manager = get_parent().get_node("checkpointmanager")
	player = get_parent().get_node("CharacterBody2D")

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("YOU DIED NOOB!")
		killplayer()

func killplayer():
	if checkpoint_manager != null and player != null:
		# Respawn the player at the last checkpoint location
		player.global_position = checkpoint_manager.last_location
		print("Player respawned at ", checkpoint_manager.last_location)
	else:
		if checkpoint_manager == null:
			print("Checkpoint Manager not found.")
		if player == null:
			print("Player not found.")
