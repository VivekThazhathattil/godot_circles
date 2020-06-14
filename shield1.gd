extends RigidBody2D

var shield_texture = preload("res://sprites/shield1-des7.png")

func _ready():
	$shield.set_texture(shield_texture)
	pass # Replace with function body.

func _custom_rotate():
	$AnimationPlayer.play("shield_rotate")
	
func _custom_rotate_backwards():
	$AnimationPlayer.play_backwards("shield_rotate")
