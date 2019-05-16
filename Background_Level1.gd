extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var viewport
var asteroid = preload("res://Asteroid_1.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	viewport = get_node("Viewport")
	viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	get_node("SpriteTexture").texture = viewport.get_texture()
	create_asteroid()

func add_child_viewport(node):
	get_node("Viewport").add_child(node)

func create_asteroid():
	var clone = asteroid.instance()
	viewport.add_child(clone)
	print("Asteroide")
	#clone.set_global_transform(10) 