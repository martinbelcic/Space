extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var viewport
var MAIN
var ship
var MULT = 15 # esta porqueria sirve para hacer chanchadas con la vida
var FINISH_SCORE = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	viewport = get_node("Viewport")
	viewport.size = Vector2(1920, 1080)
	viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	get_node("SpriteTexture").texture = viewport.get_texture()
	viewport.add_child(load("res://Asteroid_Shooter.tscn").instance())
	get_node("Timer").set_wait_time(60)
	get_node("Timer").set_one_shot(true)
	get_node("Timer").start()

func get_ship():
	return ship.get_children()[0]


func add_child_viewport(node):
	get_node("Viewport").add_child(node)


func set_ship(path):
	ship = load(path).instance()
	add_child_viewport(ship)
	return ship.get_children()[0]


func  _process(delta):
	if ship.is_dead() or get_node("Timer").time_left <= 0:
		finish_level()
	elif ship.get_score() >= FINISH_SCORE:
		finish_level(true)
	else:
		update_ship_life()
		update_time_label()
		update_score()


func update_ship_life():
	var life = viewport.get_children()[1].get_ship_life()
	get_node("Label_ShipLife").text = str(life)
	for x in get_node("Health_Bar_Table").get_child_count():
		var hijo_actual = get_node("Health_Bar_Table").get_children()[x]
		if life >= (x+1)*MULT:
			hijo_actual.show()
		else:
			hijo_actual.hide()


func update_time_label():
	get_node("Label_Time").text = str(get_node("Timer").time_left)


func update_score():
	get_node("Label_Score").text = str(ship.get_score())


func finish_level(gano=false):
	get_parent().level_finished(gano)
	queue_free()

func set_rings(cant):
	FINISH_SCORE = cant