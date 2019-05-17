extends Spatial

var ASTEROID_SPEED = 70
var ASTEROID_DAMAGE = 15

const KILL_TIMER = 4
var timer = 0

var hit_something = false

func _ready():
	var x = randi()%40 - 20
	var y = randi()%40 - 20
	set_translation(Vector3(x, y, -100))


func _physics_process(delta):
	var forward_dir = global_transform.basis.z.normalized()
	global_translate(forward_dir * ASTEROID_SPEED * delta)
	
	if translation.z > 0:
		morir()
    #timer += delta
    #if timer >= KILL_TIMER:
     #   queue_free()


func morir():
	queue_free()


func _on_Area_body_entered(body):
	if hit_something == false:
		if body is KinematicBody and body.is_in_group("Ship"):
			body.asteroid_hit(ASTEROID_DAMAGE, global_transform)
			hit_something = true
			queue_free()
