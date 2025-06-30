extends CharacterBody3D


var is_chatting = false

var player
var player_in_chat_zone = false

func _ready() -> void:
	randomize()
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("chat"):
		$Dialogue.start()
		is_chatting = true
		print("Im chatting with the NPC")


func _on_chat_detection_area_body_entered(body: Node3D) -> void:
	if body.has_method("player"):
		player = body
		player_in_chat_zone = true


func _on_chat_detection_area_body_exited(body: Node3D) -> void:
	if body.has_method("player"):
		player_in_chat_zone = false


func _on_dialogue_dialogue_finished() -> void:
	is_chatting = false
