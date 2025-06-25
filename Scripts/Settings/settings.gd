extends Control

func _on_go_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main Menu/main_menu.tscn")


func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)




func _on_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)
