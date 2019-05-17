extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var viewport
var MAIN
var ship

# Called when the node enters the scene tree for the first time.
func _ready():
	viewport = get_node("Viewport")
	viewport.size = Vector2(1920, 1080)
	viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	get_node("SpriteTexture").texture = viewport.get_texture()
	viewport.add_child(load("res://Asteroid_Shooter.tscn").instance())


func add_child_viewport(node):
	get_node("Viewport").add_child(node)


func set_ship(path):
	print(path)
	ship = load(path).instance()
	add_child_viewport(ship)


func  _process(delta):
	update_ship_life()
	if ship.is_dead():
		finish_level()


func update_ship_life():
	get_node("Label_ShipLife").text = str(viewport.get_children()[1].get_ship_life())


func finish_level():
	get_parent().level_finished()
	queue_free()