extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var canvas = get_node("AsteroidBody/CanvasAsteroid/AnimationPlayer")
	#canvas.play("movimiento")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var asteroid = get_node("AsteroidBody")
	asteroid.move_and_slide(Vector3(0,0,15))
