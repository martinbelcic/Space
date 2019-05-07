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


func _on_Button_Keyboard_pressed():
	self.hide()


func _on_Button_Joystick_pressed():
	self.hide()


func _on_Button_Celular_pressed():
	self.hide()


func _on_Button_Apply_pressed():
	self.hide()


func _on_Button_Cancel_pressed():
	self.hide()
