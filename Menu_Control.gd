extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_Options_pressed():
	get_node("Option_Control").show()


func _on_Button_Ships_pressed():
	pass # Replace with function body.


func _on_Button_Map_pressed():
	get_node("Map_Control").show()


func _on_Button_Start_pressed():
	pass # Replace with function body.
