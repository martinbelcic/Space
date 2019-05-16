extends Button

func _on_ButtonSend_pressed():
  print("Sending data to client")
  var textToSend = get_parent().get_node("TextToSend").text
  get_tree().multiplayer.send_bytes(textToSend.to_ascii())

