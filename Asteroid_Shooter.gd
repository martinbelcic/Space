extends Spatial

const DAMAGE = 15

var is_weapon_enabled = true

var bullet_scene = preload("Asteroid.tscn")
var ring_scene = preload("res://Ring.tscn")


func _ready():
	fire_weapon()

func _process(delta):
	var aux = randi()%100
	if aux <= 15 and aux > 10:
		fire_weapon()
	elif aux == 2:
		fire_rings()


func fire_weapon():
	var clone = bullet_scene.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)
	
	# clone.global_transform = self.global_transform
	clone.scale = Vector3(2, 2, 2)
	clone.ASTEROID_DAMAGE = DAMAGE


func fire_rings():
	var ring
	var scene_root = get_tree().root.get_children()[0]
	var x = randi()%10 - 5
	var y = randi()%10 - 5
	for x in range(3):
		ring = ring_scene.instance()
		scene_root.add_child(ring)
		ring.set_position(x, y)
		ring.scale = Vector3(4, 4, 4)