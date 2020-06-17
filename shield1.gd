extends RigidBody2D

var shield_texture = preload("res://sprites/shield1-des7.png")

func _ready():
	$shield.set_texture(shield_texture)
	self.set_angular_velocity(10)

func _custom_rotate():
#	$AnimationPlayer.play("shield_rotate")
	pass
func _custom_rotate_backwards():
#	$AnimationPlayer.play_backwards("shield_rotate")
	pass
