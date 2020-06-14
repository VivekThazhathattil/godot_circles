extends KinematicBody2D
var spawn_offset
var loc
var vel_mag
var vel_dir
var collided = false
var flag = 0
const is_powerup = 0
var vel_sizer = 1

func _ready():
	randomize()
	loc = get_viewport().size
	#print("center location = " + str(loc))
	_set_spawn_location()
	_sequential_modulator($"../score_hud".count)
	_set_enemy_velocity()
	
func _set_enemy_velocity():
	vel_mag = (randi()%300 + 400) * vel_sizer
	vel_dir = _get_velocity_direction()
	#print("vel_mag = " + str(vel_mag))
	
func _get_velocity_direction():
	var temp_dir = Vector2(loc.x/2 - position.x, loc.y/2 - position.y)
	#print("normalized velocity_dir = " + str(temp_dir.normalized()))
	return temp_dir.normalized()
	
func _process(delta):
	collided = move_and_collide(vel_mag*vel_dir*delta)
	if collided and flag == 0:
		flag = 1
		vel_dir = -vel_dir
		get_parent()._update_score()
		$".."._on_collided()
	
func _set_spawn_location():
	var dir_flag = randi()%4
	if(dir_flag == 0):
		spawn_offset = Vector2(-10,randi()%int(loc.y))
	elif(dir_flag == 1):
		spawn_offset = Vector2(randi()%int(loc.x),-10)
	elif(dir_flag == 1):
		spawn_offset = Vector2(loc.x+10,randi()%int(loc.y))
	else:
		spawn_offset = Vector2(randi()%int(loc.x),int(loc.y)+10)
	#print("spawn_offset = "+ str(spawn_offset))
	position = spawn_offset

func _on_VisibilityNotifier2D_screen_exited():
	#print("object exited screen")	
	self.queue_free()

func _change_direction():
	vel_dir = -vel_dir

func _sequential_modulator(_key):
		if _key < 1: 
			modulate = Color(1,1,1,1)
		elif _key < 3: 
			modulate = Color(rand_range(0.66,1),0,0,1)
		elif _key < 6: 
			modulate = Color(0,rand_range(0.66,1),0,1)
		elif _key < 10: 
			modulate = Color(0,0,rand_range(0.66,1),1)
		elif _key < 15: 
			modulate = Color(rand_range(0.66,1),rand_range(0.66,1),0,1)
		elif _key < 21: 
			modulate = Color(rand_range(0.66,1), 0, rand_range(0.66,1),1)
		elif _key < 28: 
			modulate = Color(0, rand_range(0.66,1), rand_range(0.66,1),1)
			
		elif _key < 40:
			if _key == 28:
				_play_sound()
			self.scale = Vector2(2.5,2.5)
			modulate = Color(randf(),randf(),randf(),1)
		
		elif _key < 60:
			if _key == 40:
				_play_sound()
			self.scale = Vector2(2,2)
			modulate = Color(randf(),randf(),randf(),1)
			
		elif _key < 80:
			if _key == 60:
				_play_sound()
			self.scale = Vector2(1,1)
			modulate = Color(randf(),randf(),randf(),1)
			
		elif _key < 100:
			if _key == 80:
				_play_sound()
			var rand_size = rand_range(0.5,3)
			self.scale = Vector2(rand_size,rand_size)
			modulate = Color(randf(),randf(),randf(),1)
			
		else:
			if _key == 100:
				_play_sound()
			var rand_size = rand_range(0.8,1.2)
			self.scale = Vector2(rand_size,rand_size)
			modulate = Color(randf(),randf(),randf(),1)
			vel_sizer += float(_key)/1000
			
func _play_sound():
	$"../sfx".set_stream($"..".sfx[2])
	$"../sfx".play()
		
