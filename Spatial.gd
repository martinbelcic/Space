extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("ShipBody").rotate(Vector3(0,0,0))
	pass # Replace with function body.

func _process(delta):
	var ship = get_node("ShipBody")
	var canvas = get_node("ShipBody/CanvasShip/AnimationPlayer")
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
	ship.move_and_slide(Vector3(x,y,0))


func _on_CollisionCamera_body_entered(body):
	print("braulio me toca")
