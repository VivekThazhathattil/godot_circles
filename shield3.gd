extends RigidBody2D

func _ready():
	print("shield3 instanced")
	pass # Replace with function body.

func _custom_rotate():
	$"shield3-1/AnimationPlayer".play("rotate")
	$"shield3-2/AnimationPlayer".play("shield_rotate")
	
func _custom_rotate_backwards():
	$"shield3-1/AnimationPlayer".play_backwards("rotate")
	$"shield3-2/AnimationPlayer".play_backwards("shield_rotate")
