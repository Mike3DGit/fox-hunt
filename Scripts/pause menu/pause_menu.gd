extends Control

func resume():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	visible = false
	get_tree().paused = false
	
func pause():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	visible = true
	get_tree().paused = true
	
func testEsc():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif  Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()
		

func _ready() -> void:
	visible = false


func _on_quit_pressed() -> void:
	get_tree().quit()


func _process(_delta: float) -> void:
	testEsc()


func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_resume_pressed() -> void:
	resume()

#func pauseMenu():
	#if paused:
		#pause_menu.hide()
		#Engine.time_scale = 1
	#else:
		#pause_menu.show()
		#Engine.time_scale = 0
