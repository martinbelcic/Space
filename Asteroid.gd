extends Spatial

var ASTEROID_SPEED = 70
var ASTEROID_DAMAGE = 15

const KILL_TIMER = 4
var timer = 0

var hit_something = false

func _ready():
    $Area.connect("body_entered", self, "collided")


func _physics_process(delta):
    var forward_dir = global_transform.basis.z.normalized()
    global_translate(forward_dir * ASTEROID_SPEED * delta)

    #timer += delta
    #if timer >= KILL_TIMER:
     #   queue_free()


func collided(body):
    if hit_something == false:
        if body.has_method("asteroid_hit"):
            body.asteroid_hit(ASTEROID_DAMAGE, global_transform)

    hit_something = true
    queue_free()