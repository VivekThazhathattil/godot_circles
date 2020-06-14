extends Node2D
var is_anim_backwards = false
var color_count = 0
#var Color_array = [Color(0.04,0.6,0.08,1),Color(0.96,0.26,0.21,1)]
var Color_array = [Color.green, Color.yellow, Color.red]
var tween_values = [0.0,1000.0]
const shield = preload("res://shield1.tscn")
var inst

func _ready():
	var scr_size = get_viewport().size
	#print(scr_size)
	inst = shield.instance()
	self.add_child(inst)
	modulate = Color_array[0]
	$orb.position = Vector2(scr_size.x/2,scr_size.y/2)
	$shield.position = Vector2(scr_size.x/2,scr_size.y/2)
#	$shield/AnimationPlayer.play("shield_rotate")
	$shield._custom_rotate()
	$orb/orb_rotate.play("rotate")
	pass

func _input(event):
	if event.is_action_pressed("tap"):
		if is_anim_backwards:
#			$shield/AnimationPlayer.play("shield_rotate")
			$shield._custom_rotate()
		else:
			$shield._custom_rotate_backwards()
#			$shield/AnimationPlayer.play_backwards("shield_rotate")
		is_anim_backwards = not is_anim_backwards

func _on_orb_body_entered(body):
	if body.is_powerup != 0:
		_enable_powerup(body.is_powerup)
		body.queue_free()
	elif color_count < 2:
		$"../sfx".set_stream($"..".sfx[1])
		$"../sfx".play()
		color_count += 1
		body.queue_free()
		$orb/AnimationPlayer.play("recoil")
		$Tween.interpolate_property(self, "modulate",
		Color_array[color_count-1], Color_array[color_count], 2,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($orb/AnimationPlayer, "animation_finished")
		$orb/AnimationPlayer.play("pulsate")
	else:
		$orb.queue_free()
		body.queue_free()
		get_parent()._show_game_finish()
		
func _on_enemy_shield_collision():
	$orb/orb_rotate.playback_speed = 3
	$shield/secondary_shield_anim.play("pulsate")
	yield($shield/secondary_shield_anim, "animation_finished")
	$orb/orb_rotate.playback_speed = 1
	
func _enable_powerup(num):
	if num == 1:
		$shield/AnimationPlayer.playback_speed = 5
		$orb/AnimationPlayer.stop()
		$orb/AnimationPlayer.play("color_pulse")
		$Timer.start(4)
		
func _on_Timer_timeout():
	$shield/AnimationPlayer.playback_speed = 1
	$orb/AnimationPlayer.play("pulsate")
