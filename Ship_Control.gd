extends Control

var money
var texture_ship
var textures = [create_texture_ship("icon.png")]

# Called when the node enters the scene tree for the first time.
func _ready():
	texture_ship = get_node("Panel/TextureRect_Ship")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_Back_pressed():
	self.hide()

func _on_Button_Buy_pressed():
	pass # Replace with function body.

#cambiar esto a un nodo y que vayan pasando las escenas
func _on_Button_Next_pressed():
	var element = textures.pop_front(textures)
	textures.push_back(element)
	texture_ship.set_texture(element)

func _on_Button_Previous_pressed():
	var element = textures.pop_back(textures)
	textures.push_front(element)
	texture_ship.set_texture(element)

func create_texture_ship(nombre):
	var new_texture = TextureRect.new()
	new_texture.set_texture(nombre)
	return new_texture