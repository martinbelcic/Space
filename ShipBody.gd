extends KinematicBody

# Declare member variables here. Examples:
onready var canvas = get_node("CanvasShip/AnimationPlayer")
var estado
var estado_anterior = ""
var SHIP_LIFE = 165

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("ShipBody").rotate(Vector3(0,0,0))
	pass # Replace with function body.

func _process(delta):
	var x = 0
	var y = 0
	var sensitivity = 2
	if Input.is_action_pressed("ui_left"):
		x = -sensitivity
		canvas.play("MoveLeft")
	if Input.is_action_pressed("ui_right"):
		x = sensitivity
	if Input.is_action_pressed("ui_up"):
		y = sensitivity
	if Input.is_action_pressed("ui_down"):	
		y = -sensitivity
	move_and_slide(Vector3(x,y,0))


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
	
	move_and_slide(Vector3(x,y,0))
	
	if estado != estado_anterior:
		if estado == "Straight" and estado_anterior != "":
			canvas.play_backwards(estado_anterior)
		elif estado != "Straight":
			canvas.play(estado)
	
	print(estado_anterior + " " + estado)
	estado_anterior = estado
	estado = ""


func _on_CollisionCamera_body_entered(body):
	print("braulio me toca")


func asteroid_hit(damage, asteroid_global_transform):
	SHIP_LIFE -= damage