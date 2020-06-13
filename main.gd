extends Node2D
const enemy = preload("res://enemy.tscn")
const powerup = preload("res://powerup.tscn")
var inst
var powerup_inst
var sfx = []

var savegame = File.new() #file
var save_path = "user://savegame.save" #place of the file
var save_data = {"highscore": 0} #variable to store data

func save(high_score):    
	save_data["highscore"] = high_score #data to save   
	savegame.open(save_path, File.WRITE) #open file to write
	savegame.store_var(save_data) #store the data
	savegame.close() # close the file

func read_savegame():
   savegame.open(save_path, File.READ) #open the file
   save_data = savegame.get_var() #get the value
   savegame.close() #close the file
   return save_data["highscore"] #return the value

func _ready():
	$score_hud._reset_score()
	sfx.append(preload("res://assets/hit.wav"))
	sfx.append(preload("res://assets/orb_enter.ogg"))
	pass
	
func _on_Timer_timeout():
	randomize()
	inst = enemy.instance()
	self.add_child(inst)
	if $Timer.wait_time > 0.5:
		$Timer.wait_time -= 0.05
#		print("wait_time = " + str($Timer.wait_time))
	
func _update_score():
#	print("called _update_score")
	$score_hud._increment_score()

func _show_game_finish():
#	print("game finished")
	if read_savegame() < $score_hud.count:
		save($score_hud.count)
	$restart_button.visible = true
	get_tree().paused = true

func _on_restart_button_pressed():
#	print("restart button pressed")
	get_tree().paused = false
	get_tree().change_scene("res://menu.tscn")
	
func _on_collided():
	$sfx.set_stream(sfx[0])
	$sfx.pitch_scale = rand_range(1.0,1.5)
	$sfx.play()
	$player._on_enemy_shield_collision()

func _on_powerup_timer_timeout():
	randomize()
	print("powerup started")
	powerup_inst = powerup.instance()
	self.add_child(powerup_inst)
	$powerup_timer.wait_time = randi()%10 + 10
