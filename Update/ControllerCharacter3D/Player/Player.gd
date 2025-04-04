extends CharacterBody3D

@export var max_speed = 12
@export var acceleration = 60
@export var friction = 50
@export var air_firction = 10
@export var jump_impulse = 20
@export var gravity = -40

@export var mouse_sensitvity = .1
@export var controller_sensitivity = 3

var push = 1

#var velocity = Vector3.ZERO
var snap_vector = Vector3.ZERO

@onready var head = $Head

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _unhandled_input(event):
	if event.is_action_pressed("click"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	if event.is_action_pressed("ui_text_toggle_insert_mode"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitvity))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitvity))
			
			
func _physics_process(delta):
	var input_vector = get_input_vector()
	var direction = get_direction(input_vector)
	apply_movement(direction, delta)
	apply_friction(direction, delta)
	apply_gravity(delta)
	jump()
#	apply_controller_rotation()
	head.rotation.x = clamp(head.rotation.x, deg_to_rad(-75), deg_to_rad(75))
	set_velocity(velocity)
	# TODOConverter3To4 looks that snap in Godot 4 is float, not vector like in Godot 3 - previous value `snap_vector`
	set_up_direction(Vector3.UP)
	set_floor_stop_on_slope_enabled(true)
	set_max_slides(4)
	set_floor_max_angle(.785398)
	# TODOConverter3To4 infinite_inertia were removed in Godot 4 - previous value `false`
	move_and_slide()
	velocity = velocity
	
	for idx in get_slide_collision_count():
		var collision = get_slide_collision(idx)
#		if collision.collider.is_in_group("bodies"):
#			collision.collider.apply_central_impulse(-collision.normal * velocity.length() * push)
		
	
func get_input_vector():
	var input_vector = Vector3.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	return input_vector.normalized() if input_vector.length() > 1 else input_vector
	
	
func get_direction(input_vector):
	var direction = Vector3.ZERO
	direction = (input_vector.x * transform.basis.x) + (input_vector.z * transform.basis.z)
	return direction
	
	
func apply_movement(direction, delta):
	if direction != Vector3.ZERO:
		velocity.x = velocity.move_toward(direction * max_speed, acceleration * delta).x
		velocity.z = velocity.move_toward(direction * max_speed, acceleration * delta).z
		
		
func apply_friction(direction, delta):
	if direction == Vector3.ZERO:
		if is_on_floor():
			velocity = velocity.move_toward(Vector3.ZERO, friction * delta)
		else:
			velocity.x = velocity.move_toward(Vector3.ZERO, air_firction * delta).x
			velocity.z = velocity.move_toward(Vector3.ZERO, air_firction * delta).z
			
			
func apply_gravity(delta):
	velocity.y += gravity * delta
	velocity.y = clamp(velocity.y, gravity, jump_impulse)
	
	
func update_snap_vector():
	snap_vector = -get_floor_normal() if is_on_floor() else Vector3.DOWN
	
	
func jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		snap_vector = Vector3.ZERO
		velocity.y = jump_impulse
	if Input.is_action_just_released("jump") and velocity.y > jump_impulse / 2:
		velocity.y = jump_impulse / 2


#func apply_controller_rotation():
#	var axis_vector = Vector2.ZERO
#	axis_vector.x = Input.get_action_strength("look_right") - Input.get_action_strength("look_left")
#	axis_vector.y = Input.get_action_strength("look_down") - Input.get_action_strength("look_up")
#
#	if InputEventJoypadMotion:
#		rotate_y(deg_to_rad(-axis_vector.x) * controller_sensitivity)
#		head.rotate_x(deg_to_rad(-axis_vector.y) * controller_sensitivity)
#
#
