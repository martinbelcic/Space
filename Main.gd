extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text" 
var PORT = 4242
var PORT_AUX = 4241
onready var server_instance = get_node("Menu_Control/Server") 
var ship
var path_ship = "res://Ship_1.tscn"
var player
var level
var viewport_ships
var peer
var udp = PacketPeerUDP.new()
var udp_listen = PacketPeerUDP.new()
var not_connected = false
var naves = ["res://Ship_1.tscn","res://Ship_2.tscn","res://Ship_3.tscn"]
var naves_bloquadas = [0, 1, 1]
var naves_precios = [0, 50, 100]
var pos_naves_actual = 0
var path_nave_actual = naves[pos_naves_actual]
var path_nave_seleccionada = path_nave_actual
var playing = false
var limite = 4
var plata = 500
var client_network_address = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Menu_Control/Ship_Control/Label_Money").text = str(plata)
	get_node("Menu_Control").show()
	get_node("Menu_Control/Main_Control").show()
	get_node("Menu_Control/Map_Control").hide()
	get_node("Menu_Control/Option_Control").hide()
	get_node("Menu_Control/Ship_Control").hide()
	get_node("Menu_Control/Server").hide()
	get_node("Menu_Control/Finish_Control").hide()


#---------------------------------
# Funciones del Servidor
#---------------------------------
func _process(delta):
	if not_connected and client_network_address != "":
		udp.set_dest_address(client_network_address, PORT)
		udp.put_packet(".gitignore".to_ascii())
	elif udp_listen.is_listening() and udp_listen.get_available_packet_count() > 0:
		var packet = udp_listen.get_packet()
		if packet.get_string_from_ascii() == "no es un mega":
			var IP_aux = udp_listen.get_packet_ip()
			if IP_aux.is_valid_ip_address():
				client_network_address = IP_aux
				udp_listen.close()


func start_udp():
	udp_listen = PacketPeerUDP.new()
	udp_listen.listen(PORT_AUX)


func create_server():
	peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT, 1)
	get_tree().set_network_peer(peer)
	peer.connect("peer_connected", self, "_peer_connected")
	peer.connect("peer_disconnected", self, "_peer_disconnected")
	server_instance.show_label("Esperando")
	get_tree().multiplayer.connect("network_peer_packet",self,"_on_packet_received")
	start_udp()


func _peer_connected(id):
	#server_instance.change_Status("\nUser " + str(id) + " connected")
	#server_instance.change_user_count("Total Users:" + str(get_tree().get_network_connected_peers().size()))
	server_instance.show_label("Conectado")
	not_connected = false
	server_instance.hide_label("Esperando")
	register_player(id)
  

func _peer_disconnected(id):
  # text = text + "\nUser " + str(id) + " disconnected"
	not_connected = true
	if not playing:
		server_instance.show_label("Esperando")
		server_instance.hide_label("Conectado")
	else:
		playing = false
		level.queue_free()
		cerrar_todo()
		get_node("Menu_Control").show()
		get_node("Menu_Control/Main_Control").hide()
		get_node("Menu_Control/Map_Control").show()
		get_node("Menu_Control/Option_Control").hide()
		get_node("Menu_Control/Ship_Control").hide()
		get_node("Menu_Control/Server").hide()
		get_node("Menu_Control/Finish_Control").hide()


func _on_packet_received(id,packet):
	var cadena = packet.get_string_from_ascii()
	if cadena == "Ready":
		empezar(id)
	else:
		ship.moverse(cadena)


func register_player(id):
	player = id
	# print(id)
	rpc_id(id, "enable_button_ready")
	# get_tree().multiplayer.send_bytes("Enable_Start_Button".to_ascii())


remote func empezar(id):
	if id == player:
		level = load("res://Background_Level1.tscn").instance()
		add_child(level)
		ship = level.set_ship(path_nave_seleccionada)
		get_node("Menu_Control").hide()
		rpc_id(id, "can_send")
		playing = true


remote func mover_ship(id, acc):
	var cadena
	if id == player and playing:
		if acc.x < -10 or acc.x < -limite and acc.z >= -limite and acc.z <= limite:
		# Moviendose a la izquierda
			cadena = "Left"
		elif acc.x > 10 or acc.x > limite and acc.z >= -limite and acc.z <= limite:
			cadena = "Right"
		elif acc.z < -10 or acc.z < -limite and acc.x >= -limite and acc.x <= limite:
			cadena = "Down"
		elif acc.z > 10 or acc.z > limite and acc.x >= -limite and acc.x <= limite:
			cadena = "Up"
		else:
			cadena = "Nothing"
		ship.moverse(cadena)


func show_server():
	server_instance.show()
	if not get_tree().is_network_server():
		create_server()
		not_connected = true
	else:
		rpc_id(player, "enable_button_ready")


func cerrar_todo():
	peer.close_connection()
	udp.close()
	client_network_address = ""

#------------------------------------
#  Funciones de Control
#------------------------------------
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

#-------------------------------------
#  Niveles
#-------------------------------------
func _on_Button_Level_1_pressed():
	get_node("Menu_Control/Map_Control").hide()
	show_server()


func _on_Button_Ship_Cancel_pressed():
	mata_ship()
	path_nave_actual = naves[0]
	get_node("Menu_Control/Main_Control").show()


func _on_Button_Apply_pressed():
	get_node("Menu_Control/Main_Control").show()


func _on_Button_Map_Back_pressed():
	get_node("Menu_Control/Main_Control").show()


#--------------------------------------------------------------
#  Funciones de Menu Eleccion de Naves
#--------------------------------------------------------------
func inicia_ships():
	viewport_ships = get_node("Menu_Control/Ship_Control/Viewport")
	viewport_ships.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	get_node("Menu_Control/Ship_Control/Ship_Example").texture = viewport_ships.get_texture()
	carga_nave(pos_naves_actual)

func mata_ship():
	viewport_ships.get_children()[0].queue_free()

func carga_nave(pos):
	path_nave_actual = naves[pos]
	ship = load(path_nave_actual).instance()
	if (naves_bloquadas[pos] == 1):
		get_node("Menu_Control/Ship_Control/Sprite_Ship_Blocked").show()
	else:
		get_node("Menu_Control/Ship_Control/Sprite_Ship_Blocked").hide()
	get_node("Menu_Control/Ship_Control/Label_Ship_Precio").text = str(naves_precios[pos_naves_actual])
	if viewport_ships.get_child_count() > 0:
		viewport_ships.get_children()[0].queue_free()
	viewport_ships.add_child(ship)
	
func _on_Button_Next_pressed():
	pos_naves_actual += 1
	get_node("Menu_Control/Ship_Control/Button_Previous").disabled = false
	if pos_naves_actual == (naves.size() - 1):
		get_node("Menu_Control/Ship_Control/Button_Next").disabled = true
	elif pos_naves_actual > (naves.size() - 1):
		pos_naves_actual -= 1
	else :
		get_node("Menu_Control/Ship_Control/Button_Next").disabled = false
	carga_nave(pos_naves_actual)

func _on_Button_Previous_pressed():
	pos_naves_actual -= 1
	get_node("Menu_Control/Ship_Control/Button_Next").disabled = false
	if pos_naves_actual == 0:
		get_node("Menu_Control/Ship_Control/Button_Previous").disabled = true
	elif pos_naves_actual < 0:
		pos_naves_actual += 1
	else :
		get_node("Menu_Control/Ship_Control/Button_Previous").disabled = false
	carga_nave(pos_naves_actual)

func _on_Button_Ship_Apply_pressed():
	mata_ship()
	if (naves_bloquadas[pos_naves_actual] == 0):
		path_nave_seleccionada = path_nave_actual
	else:
		path_nave_seleccionada = naves[0]
	get_node("Menu_Control/Main_Control").show()

func _on_Button_Buy_pressed():
	naves_bloquadas[pos_naves_actual] = 0
	carga_nave(pos_naves_actual)

#--------------------------------------------------------------


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


func level_finished(gano=false):
	playing = false
	rpc_id(player, "finished")
	get_node("Menu_Control").show()
	get_node("Menu_Control/Main_Control").hide()
	get_node("Menu_Control/Map_Control").hide()
	get_node("Menu_Control/Option_Control").hide()
	get_node("Menu_Control/Ship_Control").hide()
	get_node("Menu_Control/Server").hide()
	get_node("Menu_Control/Finish_Control").show()
	get_node("Menu_Control/Finish_Control").set_label(gano)

func _on_Butto_Back_To_Map_pressed():
	get_node("Menu_Control/Map_Control").show()
