extends State

# audio 
@onready var step_emitter = $"../../AudioStreamPlayer3D"
var step_sounds : Dictionary
var floorMaterial : String
const stepSoundTimer = 0.3
var currentStepSoundTimer = stepSoundTimer

func _ready() -> void:
	var randomizers = Global.get_all_resources_in_folder("res://Scenes/PlayerPrefab/Sounds/")
	for item in randomizers:
		var material = item.get_slice('_',0)
		step_sounds[material] = randomizers[item]

func Enter():
	walk_vel = StateMachine.walk_vel
	grav_vel = StateMachine.grav_vel
	jump_vel = StateMachine.jump_vel

func Exit():
	StateMachine.walk_vel = walk_vel
	StateMachine.grav_vel = grav_vel
	StateMachine.jump_vel = jump_vel

func Physics_Update(_delta): # Transition condition is different for each state
	# Transition to sliding
	player.velocity = _walk(_delta) + _gravity(_delta) + _jump(_delta)
	StateMachine.walk_vel = walk_vel
	StateMachine.grav_vel = grav_vel
	StateMachine.jump_vel = jump_vel
	walking_sound.rpc(_delta)

func check_transitions() -> void:
	if player.is_on_floor() and Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, 'Jumping')
	if !player.is_on_floor():
		Transitioned.emit(self, 'Jumping')
	
	
	if (Input.is_action_pressed("crouch") and player.velocity.length() > 10): 
		Transitioned.emit(self, 'Sliding')
	if Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") == Vector2.ZERO:
		Transitioned.emit(self, 'Idle')
	if Input.is_action_pressed("crouch"):
		Transitioned.emit(self, 'Crouching')
	if Input.is_action_pressed("sprint"):
		Transitioned.emit(self, 'Sprinting')

@rpc("authority","call_local")
func walking_sound(delta):
	if currentStepSoundTimer <= 0:
		step_emitter.play()
		currentStepSoundTimer = stepSoundTimer
	else:
		currentStepSoundTimer -= delta
	if $"../../floorRayCast3D".is_colliding():
		var floorNode = $"../../floorRayCast3D".get_collider()
		if "SurfaceType" in floorNode:
			if floorMaterial == floorNode.SurfaceType: return
			step_emitter.stream = step_sounds[floorNode.SurfaceType]
			floorMaterial = floorNode.SurfaceType
		else:
			floorMaterial = 'wood'
