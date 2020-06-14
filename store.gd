extends Node2D

var savegame = File.new() #file
var save_path = "user://savegame.save" #place of the file
var save_data

func store_orb_texture(orb_text):
	savegame.open(save_path, File.READ) #open the file
	save_data = savegame.get_var() #get the value
	savegame.close() # close the file
	save_data["orb"] = orb_text #data to save
	savegame.open(save_path, File.WRITE) #open file to write
	savegame.store_var(save_data) #store the data
	savegame.close() # close the file
	
func store_shield_texture(shield_text):
	savegame.open(save_path, File.READ) #open the file
	save_data = savegame.get_var() #get the value
	savegame.close() # close the file
	save_data["shield"] = shield_text #data to save
	savegame.open(save_path, File.WRITE) #open file to write
	savegame.store_var(save_data) #store the data
	savegame.close() # close the file

func _on_TextureButton_pressed():
	store_orb_texture("player_orb")

func _on_TextureButton2_pressed():
	store_orb_texture("orb2")


func _on_TextureButton3_pressed():
	store_orb_texture("orb3")


func _on_TextureButton4_pressed():
	store_orb_texture("orb4")


func _on_TextureButton5_pressed():
	store_orb_texture("orb5")


func _on_TextureButton6_pressed():
	store_orb_texture("orb6")


func _on_TextureButton7_pressed():
	store_orb_texture("orb7")


func _on_TextureButton8_pressed():
	store_orb_texture("orb8")


func _on_TextureButton9_pressed():
	store_orb_texture("orb9")


func _on_Button_pressed():
	get_tree().change_scene("res://menu.tscn")

func _on_next_button_pressed():
	$AnimationPlayer.play("swipe")

func _on_Button2_pressed():
	$AnimationPlayer.play_backwards("swipe")

func _on_shield1_pressed():
	store_shield_texture("shield")


func _on_shield2_pressed():
	store_shield_texture("shield2")


func _on_shield3_pressed():
	store_shield_texture("shield3")


func _on_shield4_pressed():
	store_shield_texture("shield1-des1")


func _on_shield5_pressed():
	store_shield_texture("shield1-des2")

func _on_shield6_pressed():
	store_shield_texture("shield1-des3")
	

func _on_shield7_pressed():
	store_shield_texture("shield1-des4")


func _on_shield8_pressed():
	store_shield_texture("shield1-des5")


func _on_shield9_pressed():
	store_shield_texture("shield1-des6")


func _on_shield10_pressed():
	store_shield_texture("shield1-des7")
	
