extends Node2D
var savegame = File.new() #file
var save_path = "user://savegame.save" #place of the file
var save_data = {"highscore": 0, "orb": "player_orb", "shield": "shield", "stars": 0} #variable to store data

func _ready():
	if not savegame.file_exists(save_path):
		create_save()
	$score.text = "BEST : " + str(read_highscore())
	$container/TextureButton.text = "  "+str(read_stars())
	print(get_res_loc())

func _on_play_button2_pressed():
	get_tree().change_scene("res://main.tscn")

func create_save():
   savegame.open(save_path, File.WRITE)
   savegame.store_var(save_data)
   savegame.close()

func read_highscore():
   savegame.open(save_path, File.READ) #open the file
   save_data = savegame.get_var() #get the value
   savegame.close() #close the file
   return save_data["highscore"] #return the value

func read_stars():
   savegame.open(save_path, File.READ) #open the file
   save_data = savegame.get_var() #get the value
   savegame.close() #close the file
   return save_data["stars"] #return the value

func get_res_loc():
   savegame.open(save_path, File.READ) #open the file
   save_data = savegame.get_var() #get the value
   savegame.close() #close the file
   return save_data["orb"] #return the value

func _on_exit_pressed():
	get_tree().quit()


func _on_standings_pressed():
	get_tree().change_scene("res://store.tscn")


func _on_TextureButton_pressed():
	pass # Replace with function body.
