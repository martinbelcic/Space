extends Spatial

const DAMAGE = 15

var is_weapon_enabled = true

var bullet_scene = preload("Asteroid.tscn")


func _ready():
	print(translation)
	print("Shooter")
	fire_weapon()

func _process(delta):
	fire_weapon()


func fire_weapon():
    var clone = bullet_scene.instance()
    var scene_root = get_tree().root.get_children()[0]
    scene_root.add_child(clone)

    # clone.global_transform = self.global_transform
    clone.scale = Vector3(4, 4, 4)
    clone.ASTEROID_DAMAGE = DAMAGE
