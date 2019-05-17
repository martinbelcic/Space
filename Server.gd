extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	hide_label("Conectado")
	hide_label("Esperando")

func change_Status(string):
	get_node("Panel/LabelStatus").text = string


func change_user_count(string):
	get_node("Panel/LabelUserCount").text = string


func morir():
	queue_free()


func show_label(cadena):
	get_node(cadena).show()


func hide_label(cadena):
	get_node(cadena).hide()

func _on_Button_Volver_pressed():
	hide()
