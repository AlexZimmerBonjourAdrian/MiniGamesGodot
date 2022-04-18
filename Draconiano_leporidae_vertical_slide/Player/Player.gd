extends KinematicBody

export var max_speed = 12
export var max_speed_acceleration = 22
export var acceleration = 120
export var friction = 50
export var air_firction = 10
export var jump_impulse = 20
export var gravity = -40

export var mouse_sensitvity = .1
export var controller_sensitivity = 3

export (int, 0, 10) var push = 1

var velocity = Vector3.ZERO
var snap_vector = Vector3.ZERO

var weapon = []

onready var state_machine = $AnimationPlayer
var isrunning:bool = false

var can_slider = true
var is_sliding = false

var max_horizontal_speed = 60

onready var reach = $Head/Camera/Reach
onready var head = $Head
onready var muzzle = $Head/Hand/Muzzle
onready var touching_ground = $touching_ground
onready var camera = $Head/Camera
onready var bullet = preload("res://Bullet/Bullet_Prototype.tscn")

#TODO:maquina de esta
#var state = 0
#var  STATE_IDLE = 0
#var  STATE_MOVE = 1
#var  STATE_DASH = 2

#var snap = Vector3.DOWN

onready var weapon_manager = $Head/Camera/Camera/Weaponds

var direction = Vector3()



	

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().call_group("weapon", "get_type",self)
	get_tree().call_group("Enemys", "set_player",self)
#
func _unhandled_input(event):
	if event.is_action_pressed("click"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	if event.is_action_pressed("toggle_mouse_mode"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitvity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitvity))
	
	
			
func _physics_process(delta):
	#se devuelve un input vector
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
		
	in_on_leadge()
#	apply_movement(direction, delta)
	#Logica de Deslizarse
	check_sliding_logic(direction,delta)
	
	#aplica la friccion
	apply_friction(direction, delta)
	
	#aplica la gravedad
	apply_gravity(delta)
	
	#chequea los botones de salto
	jump()
#	shoot()

#	weapons manager process weapons
	process_weapons()
	
	# aplica los controlles de rotacion
	apply_controller_rotation()
	#corrige un error par poder girar la camara
	head.rotation.x = clamp(head.rotation.x, deg2rad(-75), deg2rad(75))
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector3.UP, true, 4, .785398, false)
	
#	esto es for que recorre y chequea los objetos que coliciona pudiendo chequear y actuar que se esta collisionando algo muy importante
#   En esto sse colicciona con objetos de mundo, como cajas,
#   esto tambien es usado para el sistema de pickup
	for idx in get_slide_count():
		var collision = get_slide_collision(idx)
		if collision.collider.is_in_group("bodies"):
			collision.collider.apply_central_impulse(-collision.normal * velocity.length() * push)
		if collision.collider.is_in_group("weapon"):
			if collision.collider.call("get_type") == "Pistol":
				collision.collider.queue_free()
			elif collision.collider.call("get_type") == "ShootGun":
				collision.collider.queue_free()
			elif collision.collider.call("get_type") == "MachineGun":
				collision.collider.queue_free()
			
	#asigna los controles de movimiento y setea las direcciones de forma sencilla 
func get_input_vector():
	var input_vector = Vector3.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	return input_vector.normalized() if input_vector.length() > 1 else input_vector
	
#devuelve la diression que se esta moviendo
func get_direction(input_vector):
	var direction = Vector3.ZERO
	direction = (input_vector.x * transform.basis.x) + (input_vector.z * transform.basis.z)
	return direction
	
#aplica el movimiento, dandole una velocidad, acelleracion y asignandole una velocidad maxima
func apply_movement(direction, delta):
	if direction != Vector3.ZERO :
		velocity.x = velocity.move_toward(direction * max_speed, acceleration * delta).x
		velocity.z = velocity.move_toward(direction * max_speed, acceleration * delta).z
	
	
#	update_Print(velocity.move_toward(direction * max_speed, acceleration * delta).x)
 #aplica friccion para poder detener al personaje
func apply_friction(direction, delta):
	if direction == Vector3.ZERO:
		if is_on_floor():
			velocity = velocity.move_toward(Vector3.ZERO, friction * delta)
		else:
			velocity.x = velocity.move_toward(Vector3.ZERO, air_firction * delta).x
			velocity.z = velocity.move_toward(Vector3.ZERO, air_firction * delta).z
			
	#aplicar gravedad ya que no es un rigidbody y se tiene que hacer manualmente	
func apply_gravity(delta):
	velocity.y += gravity * delta
	velocity.y = clamp(velocity.y, gravity, jump_impulse)
	
#actualiza el vector de velocidad si este es piso o no
func update_snap_vector():
	snap_vector = -get_floor_normal() if is_on_floor() else Vector3.DOWN
	
	#region de salto
func jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		snap_vector = Vector3.ZERO
		velocity.y = jump_impulse
	if Input.is_action_just_released("jump") and velocity.y > jump_impulse / 2:
		velocity.y = jump_impulse / 2

#rotacion de camara tanto para el mouse como para joypad
func apply_controller_rotation():
	var axis_vector = Vector2.ZERO
	axis_vector.x = Input.get_action_strength("look_right") - Input.get_action_strength("look_left")
	axis_vector.y = Input.get_action_strength("look_down") - Input.get_action_strength("look_up")
	
	if InputEventJoypadMotion:
		rotate_y(deg2rad(-axis_vector.x) * controller_sensitivity)
		head.rotate_x(deg2rad(-axis_vector.y) * controller_sensitivity)


func update_Print(testprinter):
	$Control/Background/Print.text = String(testprinter)
#function Prototype para crear balas 
#Todo:Cambiar el tipo de disparo segun el arma

func run(direction, delta):
	if direction != Vector3.ZERO :
		velocity.x = velocity.move_toward(direction * max_speed_acceleration, acceleration * delta).x
		velocity.z = velocity.move_toward(direction * max_speed_acceleration, acceleration * delta).z
#func shoot():
#	if Input.is_action_just_pressed("click"):
#
##		if reach.is_colliding():
#		var b = bullet.instance()	
#		muzzle.add_child(b)
##		b.look_at(reach.get_collision_point(),Vector3.UP)
#		b.shoot = true
#		print("Disparo")

func check_sliding_logic(direction,delta):
#	update_Print(is_sliding)
	if(abs(acceleration)>(max_horizontal_speed -1) and touching_ground):
		if(!is_sliding): can_slider = true
	else:
		can_slider = false
		
	if(can_slider and Input.is_action_pressed("Slinding")):
		state_machine.play("Deslizarse")
		is_sliding = true
		can_slider = false
#		update_Print(is_sliding)
	if(is_sliding and !Input.is_action_pressed("Slinding")):
		state_machine.play_backwards("Deslizarse")
		is_sliding = false
		can_slider = true 
#		update_Print("can_slider" + can_slider)
	if(is_sliding and touching_ground):
#		update_Print("Entra en slider")
		move_and_slide(velocity,velocity)
		
		#	if(is_sliding and touching_ground):
	else:
		is_sliding = false	

# TODO: Terminar maquina de estado basica para control de player
#func setState(aState):
#	state = aState
#
#func StateMachine():
#
#	if(state == STATE_IDLE):
#		if(get_input_vector()):
#			setState(STATE_MOVE)
#	elif(state == STATE_MOVE):
#		get_input_vector()
#
var is_on_leadge = false
#var in_on_leadge() = false
onready var DetectionUp = $Head/Camera/DetectionUp
onready var DetectionDown = $Head/Camera/DetectionDown

	
func in_on_leadge():
		
#	update_Print("entra")
	if DetectionUp.is_colliding():
		update_Print("entra")
		is_on_leadge = true
		subir()
	elif DetectionDown.is_colliding():
#		update_Print("entra")
		is_on_leadge = true
		subir()
		
	
#	elif DetectionDown.get_collider()
		
func subir():
	if is_on_leadge == true:
		update_Print(DetectionDown.is_colliding())
		velocity.y += 60
#		velocity.z += Vector3.FORWARD.z
		is_on_leadge = false
#		update_Print("entra")

func process_weapons():
	if Input.is_action_just_pressed("Empty"):
		weapon_manager.change_weapon("Empty")
	if Input.is_action_just_pressed("Primary"):
		weapon_manager.change_weapon("Primary")
#	if Input.is_action_just_pressed("Secundary"):
#		weapon_manager.change_weapon("Secundary")
	
	
