extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text" 
var PORT = 4242
onready var server_instance = get_node("Menu_Control/Server") 
var ship
var path_ship = "res://Ship.tscn"
var player
var level
var viewport_ships
var peer
var udp = PacketPeerUDP.new()
var not_connected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	if not_connected:
		udp.set_dest_address("255.255.255.255", PORT)
		udp.put_packet(".gitignore".to_ascii())


func create_server():
	peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT, 1)
	get_tree().set_network_peer(peer)

	peer.connect("peer_connected", self, "_peer_connected")
	peer.connect("peer_disconnected", self, "_peer_disconnected")
	server_instance.show_label("Esperando")
	get_tree().multiplayer.connect("network_peer_packet",self,"_on_packet_received")


func _peer_connected(id):
	#server_instance.change_Status("\nUser " + str(id) + " connected")
	#server_instance.change_user_count("Total Users:" + str(get_tree().get_network_connected_peers().size()))
	server_instance.show_label("Conectado")
	not_connected = false
	server_instance.hide_label("Esperando")
	register_player(id)
  

func _peer_disconnected(id):
  # text = text + "\nUser " + str(id) + " disconnected"
	server_instance.show_label("Esperando")
	not_connected = true
	server_instance.hide_label("Conectado")
	# server_instance.change_user_count("Total Users:" + str(get_tree().get_network_connected_peers().size()))


func _on_packet_received(id,packet):
	var cadena = packet.get_string_from_ascii()
	if cadena == "Ready":
		empezar(id)
	else:
		ship.moverse(cadena)


func register_player(id):
	player = id
	print(id)
	# rpc_id(id, "enable_button_ready")
	get_tree().multiplayer.send_bytes("Enable_Start_Button".to_ascii())


remote func empezar(id):
	if id == player:
		level = load("res://Background_Level1.tscn").instance()
		add_child(level)
		# ship = load("res://Ship.tscn").instance()
		# level.add_child_viewport(ship)
		level.set_ship(path_ship)
		server_instance.morir()
		get_node("Menu_Control").hide()


func _on_Button_Options_pressed():
	get_node("Menu_Control/Option_Control").show()
	get_node("Menu_Control/Main_Control").hide()


func _on_Button_Ships_pressed():
	get_node("Menu_Control/Main_Control").hide()
	get_node("Menu_Control/Ship_Control").show()
	inicia_ships()


func _on_Button_Start_pressed():
	get_node("Menu_Control/Map_Control").show()
	get_node("Menu_Control/Main_Control").hide()


func _on_Button_Buy_pressed():
	get_node("Panel").hide()


func _on_Button_Level_1_pressed():
	get_node("Menu_Control/Map_Control").hide()
	show_server()


func show_server():
	server_instance.show()
	create_server()
	not_connected = true


func _on_Button_Cancel_pressed():
	get_node("Menu_Control/Main_Control").show()


func _on_Button_Ship_Cancel_pressed():
	get_node("Menu_Control/Main_Control").show()


func _on_Button_Apply_pressed():
	get_node("Menu_Control/Main_Control").show()


func _on_Button_Map_Back_pressed():
	get_node("Menu_Control/Main_Control").show()


func inicia_ships():
	viewport_ships = get_node("Menu_Control/Ship_Control/Viewport")
	viewport_ships.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	get_node("Menu_Control/Ship_Control/Ship_Example").texture = viewport_ships.get_texture()
	ship = load("res://Ship.tscn").instance()
	viewport_ships.add_child(ship)


func _on_Button_Next_pressed():
	pass


func _on_Button_Ship_Apply_pressed():
	get_node("Menu_Control/Main_Control").show()


func cerrar_todo():
	peer.close_connection()
	udp.close()
	server_instance.morir()


func _on_Button_Volver_pressed():
	get_node("Menu_Control/Map_Control").show()
	cerrar_todo()


func _on_Button_Level_Aux_pressed():
	level = load("res://Background_Level1.tscn").instance()
	add_child(level)
	# ship = load("res://Ship.tscn").instance()
	# level.add_child_viewport(ship)
	level.set_ship(path_ship)
	# server_instance.morir()
	get_node("Menu_Control").hide()


func level_finished():
	get_node("Menu_Control").show()
	get_node("Menu_Control/Main_Control").hide()
	get_node("Menu_Control/Map_Control").hide()
	get_node("Menu_Control/Option_Control").hide()
	get_node("Menu_Control/Ship_Control").hide()
	show_server()