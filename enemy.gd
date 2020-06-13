extends KinematicBody2D
var spawn_offset
var loc
var vel_mag
var vel_dir
var collided = false
var flag = 0
const is_powerup = 0

func _ready():
	randomize()
	loc = get_viewport().size
	#print("center location = " + str(loc))
	_set_spawn_location()
	_set_enemy_velocity()
	modulate = Color(randf(),randf(),randf(),1)
	
func _set_enemy_velocity():
	vel_mag = randi()%300 + 400
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
