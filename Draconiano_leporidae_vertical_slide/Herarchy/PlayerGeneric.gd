extends KinematicBody

var Health = 100
export var max_speed = 12
export var max_speed_acceleration = 22
export var acceleration = 120
export var friction = 50
export var air_firction = 10
export var jump_impulse = 20
export var gravity = -40
var velocity = Vector3.ZERO
var snap_vector = Vector3.ZERO
export var mouse_sensitvity = .1
export var controller_sensitivity = 3

var can_slider = true
var is_sliding = false
var direction = Vector2.UP
var max_horizontal_speed = 60

var state = 0
var  STATE_IDLE = 0
var  STATE_MOVE = 1
var  STATE_DASH = 2
var  STATE_DYNG = 3
var  STATE_DEAD = 4
var touching_ground = null
var isrunning:bool = false
onready var weapon_manager = null




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
		
func _physics_process(delta):
	var input_vector = get_input_vector()
	#devuelve una direccion a la que se esta moviendo
	var direction = get_direction(input_vector)
	
	#Running Logic
	if Input.is_action_pressed("Run"):
#		state_machine.play("Run")
		isrunning = true
	elif Input.is_action_just_released("Run"):
#		state_machine.play("Idle")
		isrunning = false
	if isrunning:
		if(!is_sliding):
		#aplicar correr
			run(direction,delta)
	else:
		if(!is_sliding):
		#aplica la direccion
			apply_movement(direction, delta)
			
		
	
#	apply_movement(direction, delta)
	#Logica de Deslizarse
	
	
	#aplica la friccion
	apply_friction(direction, delta)
	
	#aplica la gravedad
	apply_gravity(delta)
	
	#chequea los botones de salto
	jump()
#	shoot()

#	weapons manager process weapons
	

func apply_movement(direction, delta):
	if direction != Vector3.ZERO :
		velocity.x = velocity.move_toward(direction * max_speed, acceleration * delta).x
		velocity.z = velocity.move_toward(direction * max_speed, acceleration * delta).z
	

func damage(damageResive):
	Health - damageResive
	print(Health)
	
func ActualHealth():
	print(Health)

func get_input_vector():
	var input_vector = Vector3.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	return input_vector.normalized() if input_vector.length() > 1 else input_vector
	
func get_direction(input_vector):
	var direction = Vector3.ZERO
	direction = (input_vector.x * transform.basis.x) + (input_vector.z * transform.basis.z)
	return direction
	
func run(direction, delta):
	if direction != Vector3.ZERO :
		velocity.x = velocity.move_toward(direction * max_speed_acceleration, acceleration * delta).x
		velocity.z = velocity.move_toward(direction * max_speed_acceleration, acceleration * delta).z
#salto	
func jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		snap_vector = Vector3.ZERO
		velocity.y = jump_impulse
	if Input.is_action_just_released("jump") and velocity.y > jump_impulse / 2:
		velocity.y = jump_impulse / 2		
#si esta o no en el suelo
func update_snap_vector():
	snap_vector = -get_floor_normal() if is_on_floor() else Vector3.DOWN

func apply_gravity(delta):
	velocity.y += gravity * delta
	velocity.y = clamp(velocity.y, gravity, jump_impulse)

func apply_friction(direction, delta):
	if direction == Vector3.ZERO:
		if is_on_floor():
			velocity = velocity.move_toward(Vector3.ZERO, friction * delta)
		else:
			velocity.x = velocity.move_toward(Vector3.ZERO, air_firction * delta).x
			velocity.z = velocity.move_toward(Vector3.ZERO, air_firction * delta).z

