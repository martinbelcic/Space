extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var ship = get_node("ShipBody")
onready var canvas = get_node("ShipBody/CanvasShip/AnimationPlayer")
var estado
var estado_anterior = ""
onready var camera = get_node("Camera")
# Called when the node enters the scene tree for the first time.
func _ready():
	print(ship.translation)
	print(get_viewport().size)
	#asi puedo cambiar la posicion de las paredes
	# get_node("AreaCamera/CollisionCameraUp").global_translate(camera.project_position(Vector2(get_viewport().size.x/2, 0)))
	# get_node("AreaCamera/CollisionCameraDown").global_translate(camera.project_position(Vector2(get_viewport().size.x/2, get_viewport().size.y*2)))
	# get_node("AreaCamera/CollisionCameraLeft").global_translate(camera.project_position(Vector2(0, get_viewport().size.y/2)))
	# get_node("AreaCamera/CollisionCameraRight").global_translate(camera.project_position(Vector2(get_viewport().size.x, get_viewport().size.y/2)))

"""
func _process(delta):
	var x = 0
	var y = 0
	var sensitivity = 2
	if Input.is_action_pressed("ui_left"):
		x = -sensitivity
		canvas.play("MoveLeft")
	if Input.is_action_pressed("ui_right"):
		x = sensitivity
		canvas.play("MoveRight")
	if Input.is_action_pressed("ui_up"):
		y = sensitivity
		canvas.play("MoveUp")
	if Input.is_action_pressed("ui_down"):
		y = -sensitivity
		canvas.play("MoveDown")
		
	ship.move_and_slide(Vector3(x,y,0))


func moverse(movimiento):
	var x = 0
	var y = 0
	var sensitivity = 2
	if movimiento == "Up":
		y = sensitivity
		estado = "MoveUp"
	elif movimiento == "Down":
		y = -sensitivity
		estado = "MoveDown"
	elif movimiento == "Left":
		x = -sensitivity
		estado = "MoveLeft"
	elif movimiento == "Right":
		x = sensitivity
		estado = "MoveRight"
	else: 
		estado = "Straight"
	
	ship.move_and_slide(Vector3(x,y,0))
	
	if estado != estado_anterior:
		if estado == "Straight" and estado_anterior != "":
			canvas.play_backwards(estado_anterior)
		elif estado != "Straight":
			canvas.play(estado)
	
	print(estado_anterior + " " + estado)
	estado_anterior = estado
	estado = ""
"""

func get_ship_life():
	return ship.SHIP_LIFE


func is_dead():
	return ship.SHIP_LIFE <= 0