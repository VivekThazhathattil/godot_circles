extends Label

var count = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _increment_score():
	count += 1
	text = str(count)
	
func _reset_score():
	count = 0
	text = str(count)
