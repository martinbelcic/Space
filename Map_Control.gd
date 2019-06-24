extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

var enabled_levels = [1, 0, 0, 0]

func _ready():
	get_node("Button_Level_2").disabled = true
	get_node("Button_Level_3").disabled = true
	get_node("Button_Level_4").disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_Back_pressed():
	self.hide()


func enable_level(level):
	if level <=4 and level > 0:
		get_node("Button_Level_"+str(level)).disabled = false