extends Area2D

var checkpoint_manager
var player

func _ready():
	pass

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("YOU DIED NOOB!")
		killplayer()

func killplayer():
	pass
