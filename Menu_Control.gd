extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_Options_pressed():
	get_node("Option_Control").show()

func _on_Button_Ships_pressed():
	get_node("Ship_Control").show()

func _on_Button_Start_pressed():
	get_node("Map_Control").show()

func _on_Button_Buy_pressed():
	pass # Replace with function body.
