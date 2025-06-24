extends State
#TODO: Fine-tune the friction


func _ready() -> void:
	walk_friction = 5
	gravity *= 3

func Enter():
	walk_vel = StateMachine.walk_vel
	grav_vel = StateMachine.grav_vel
	play_animation.rpc('Sliding', false)

func Exit():
	StateMachine.walk_vel = walk_vel
	StateMachine.grav_vel = grav_vel
	play_animation.rpc('Sliding', true)

func Update(_delta): # Transition condition is different for each state
	if Input.is_action_just_released("crouch"): # Length in m/s? 
		Transitioned.emit(self, 'Walking')
	player.velocity = _walk(_delta) + _gravity(_delta) + _jump(_delta)
	StateMachine.walk_vel = walk_vel
	StateMachine.grav_vel = grav_vel
	StateMachine.jump_vel = jump_vel

func _gravity(delta: float) -> Vector3:
	if $"../../floorRayCast3D".is_colliding(): 
		var collision_normal = $"../../floorRayCast3D".get_collision_normal()
		var target_speed = Vector3(0, -gravity, 0)
		#$"../../DebugLabel".text = str(target_speed.normalized().dot(collision_normal)) 
		target_speed = target_speed.slide(collision_normal)
		grav_vel = grav_vel.move_toward(target_speed, gravity * delta)
		#grav_vel = grav_vel.move_toward(Vector3.ZERO, 0.5 * gravity * delta)
	return grav_vel
