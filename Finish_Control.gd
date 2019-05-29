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


func _on_Butto_Back_To_Map_pressed():
	self.hide()


func set_label(estado=false):
	if estado:
		get_node("Label_Status").text = "You Won!!!"
	else:
		get_node("Label_Status").text = "You Lost!"
