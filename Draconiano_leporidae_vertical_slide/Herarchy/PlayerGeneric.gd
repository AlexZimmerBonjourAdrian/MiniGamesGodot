extends KinematicBody

var Health = 100
export var max_speed = 12
export var max_speed_acceleration = 22
export var acceleration = 120
export var friction = 50
export var air_firction = 10
export var jump_impulse = 20
export var gravity = -40

export var mouse_sensitvity = .1
export var controller_sensitivity = 3

var can_slider = true
var is_sliding = false

var max_horizontal_speed = 60

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
	#se devuelve un input vector
	var input_vector = get_input_vector()
	#devuelve una direccion a la que se esta moviendo
	var direction = get_direction(input_vector)
	
func damage(damageResive):
	Health - damageResive
	print(Health)
	
func ActualHealth():
	print(Health)

