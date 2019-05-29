extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var RING_SPEED = 70

# Called when the node enters the scene tree for the first time.
func _ready():
	var x = randi()%10 - 5
	var y = randi()%10 - 5
	set_translation(Vector3(x, y, -100))
	get_node("AnimationPlayer").play("Ring")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var forward_dir = global_transform.basis.z.normalized()
	global_translate(forward_dir * RING_SPEED * delta)
	
	if translation.z > 0:
		morir()
    #timer += delta
    #if timer >= KILL_TIMER:
     #   queue_free()


func morir():
	queue_free()


func _on_Area_body_entered(body):
	if body.is_in_group("Ship"):
		body.paso_por_anillo()
		queue_free()
