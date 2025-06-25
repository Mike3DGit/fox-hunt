extends State

func Physics_Update(_delta):
	player.velocity = _walk(_delta) + _gravity(_delta) + _jump(_delta)
	StateMachine.walk_vel = walk_vel
	StateMachine.grav_vel = grav_vel
	StateMachine.jump_vel = jump_vel


func check_transitions():
	# Sliding at an angle
	if player.is_on_floor_only() and $"../../floorRayCast3D".is_colliding() and Input.is_action_pressed("crouch"):
		var collision_normal = $"../../floorRayCast3D".get_collision_normal()
		$"../../DebugLabel".text = str(Vector3.UP.dot(collision_normal)) 
		if Vector3.UP.dot(collision_normal) < 0.707:  # 1.0 - 0 deg, .707 - 45 deg, 0.259 - 75 deg, 0 - 90 deg, 
			Transitioned.emit(self, 'Sliding')
	
	if Input.get_vector("ui_left", "ui_right", "string_throttle_input", "ui_down") != Vector2.ZERO:
		Transitioned.emit(self, 'Walking')
	if Input.is_action_pressed("crouch"):
		Transitioned.emit(self, 'Crouching')
	if player.is_on_floor() and Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, 'Jumping')
	if !player.is_on_floor():
		Transitioned.emit(self, 'Jumping')
