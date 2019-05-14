extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var texture = "res://Textures/new_imagetexture.tres"

func apply_texture(mesh_instance_node, texture_path):
    var texture = SpatialMaterial.new()
    var image = Image.new()
    image.load(texture_path)
    texture.create_from_image(image)
    if mesh_instance_node.material_override:
        mesh_instance_node.material_override.albedo_texture = texture  

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("ShipBody/CanvasShip").material_override = load("res://Textures/Texture_1.tres")
	#get_node("ShipBody").rotate(Vector3(0,0,0))
	pass

func _process(delta):
	var ship = get_node("ShipBody")
	var canvas = get_node("ShipBody/CanvasShip/AnimationPlayer")
	var x = 0
	var y = 0
	var sensitivity = 2
	if Input.is_action_pressed("ui_left"):
		x = -sensitivity
		canvas.play("MoveL")
	elif Input.is_action_pressed("ui_right"):
		x = sensitivity
		canvas.play("MoveR")
	elif Input.is_action_pressed("ui_up"):
		y = sensitivity
		#canvas.play("MoveU")
	elif Input.is_action_pressed("ui_down"):	
		y = -sensitivity
		#canvas.play("MoveD")
	ship.move_and_slide(Vector3(x,y,0))
