extends KinematicBody

export var max_speed = 12
export var acceleration = 68
export var friction = 50
export var air_friction = 10
export var jump_impulse = 20
export var gravity = -40

export var mouse_sensivility = .1
export var controller_sensivility = 3

var velocity = Vector3.ZERO
var snap_vector = Vector3.ZERO

onready var head = $Head
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event.is_action_pressed("click"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if event.is_action_pressed("toggle_mouse_mode"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg2rad(-event.relative.x * mouse_sensivility ))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensivility))
func _physics_process(delta):
	 var input_vector = get_input_vector()
	 var direction = get_direction(input_vector)
	 apply_movement(direction, delta)
	 velocity = move_and_slide(velocity, Vector3.UP)

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
