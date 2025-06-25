extends Control



func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Level 1/level_1.tscn")


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Credits/credits.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Settings_menu/settings_menu.tscn")
