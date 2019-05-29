extends Spatial

const DAMAGE = 15

var is_weapon_enabled = true

var bullet_scene = preload("Asteroid.tscn")
var ring_scene = preload("res://Ring.tscn")


func _ready():
	print(translation)
	print("Shooter")
	fire_weapon()

func _process(delta):
	if randi()%10 == 5:
		fire_weapon()


func fire_weapon():
	var clone = bullet_scene.instance()
	var ring = ring_scene.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)
	scene_root.add_child(ring)
	
	# clone.global_transform = self.global_transform
	clone.scale = Vector3(4, 4, 4)
	clone.ASTEROID_DAMAGE = DAMAGE
	ring.scale = Vector3(4, 4, 4)
