extends "res://Herarchy/PlayerGeneric.gd"



#export var mouse_sensitvity = .1
#export var controller_sensitivity = 3

export (int, 0, 10) var push = 1



var weapon = []

onready var state_machine = $AnimationPlayer






#onready var reach = $Head/Camera/Reach
onready var head = $Head
#onready var muzzle = $Head/Hand/Muzzle

onready var camera = $Head/Camera
onready var bullet = preload("res://Bullet/Bullet_Prototype.tscn")
onready var normal = $Head/Camera/Normal
onready var crosshair = $Head/Camera/Crosshair
#TODO:maquina de esta
var is_on_leadge = false
#var in_on_leadge() = false
onready var DetectionUp = $Head/Camera/DetectionUp
onready var DetectionDown = $Head/Camera/DetectionDown

#var snap = Vector3.DOWN




#direction = Vector3()	

func _ready():
	._ready()
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#	get_tree().call_group("weapon", "get_type",self)
#	get_tree().call_group("Enemy", "set_player",self)
	get_tree().call_group("weapon", "get_type",self)
	get_tree().call_group("Enemy", "set_player",self)
	weapon_manager = $Head/Camera/Weaponds
#	weapon_manager.change_weapon("Empty")
	Global.setPlayer(self)
	touching_ground = $touching_ground
#
func _unhandled_input(event):
	._unhandled_input(event)
#	if event.is_action_pressed("click"):
#		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#
#	if event.is_action_pressed("toggle_mouse_mode"):
#		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
#			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#		else:
#			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitvity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitvity))
	
	
			
func _physics_process(delta):
	._physics_process(delta)
	
	# aplica los controlles de rotacion
	apply_controller_rotation()
	#corrige un error par poder girar la camara
	head.rotation.x = clamp(head.rotation.x, deg2rad(-75), deg2rad(75))
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector3.UP, true, 4, .785398, false)
	
	in_on_leadge()
	
	process_weapons()
	
	check_sliding_logic(direction,delta)

	pickUp_functiion()
			
	#asigna los controles de movimiento y setea las direcciones de forma sencilla 

#devuelve la diression que se esta moviendo

	
#aplica el movimiento, dandole una velocidad, acelleracion y asignandole una velocidad maxima

	
#	update_Print(velocity.move_toward(direction * max_speed, acceleration * delta).x)
 #aplica friccion para poder detener al personaje

			
	#aplicar gravedad ya que no es un rigidbody y se tiene que hacer manualmente	

	
#actualiza el vector de velocidad si este es piso o no

	
	#region de salto


#rotacion de camara tanto para el mouse como para joypad
func apply_controller_rotation():
	var axis_vector = Vector2.ZERO
	axis_vector.x = Input.get_action_strength("look_right") - Input.get_action_strength("look_left")
	axis_vector.y = Input.get_action_strength("look_down") - Input.get_action_strength("look_up")
	
	if InputEventJoypadMotion:
		rotate_y(deg2rad(-axis_vector.x) * controller_sensitivity)
		head.rotate_x(deg2rad(-axis_vector.y) * controller_sensitivity)


#func update_Print(testprinter):
#	$Control/Background/Print.text = String(testprinter)
#function Prototype para crear balas 
#Todo:Cambiar el tipo de disparo segun el arma


#func shoot():
#	if Input.is_action_just_pressed("click"):
#
##		if reach.is_colliding():
#		var b = bullet.instance()	
#		muzzle.add_child(b)
##		b.look_at(reach.get_collision_point(),Vector3.UP)
#		b.shoot = true
#		print("Disparo")



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


	

#	elif DetectionDown.get_collider()
		
func subir():
	if is_on_leadge == true:
#		update_Print(DetectionDown.is_colliding())
		velocity.y += 60
#		velocity.z += Vector3.FORWARD.z
		is_on_leadge = false
#		update_Print("entra")

func process_weapons():
	if Input.is_action_just_pressed("Empty"):
		weapon_manager.change_weapon("Empty")
	
	if Input.is_action_just_pressed("Primary"):
		print("Estoy llamando al primer slot")
		weapon_manager.change_weapon("Primary")
		
	if Input.is_action_just_pressed("Secondary"):
		weapon_manager.change_weapon("Secondary")
	# Firing
	if Input.is_action_just_pressed("click"):
#		if(	!weapon_manager.current_weapon.unequip()):
			weapon_manager.fire()
			detection_enemy_shoot()
			
	elif Input.is_action_just_pressed("click") and Input.is_action_just_pressed("Iron_Crosshair"):
			weapon_manager.fireCrosshair()
			detection_enemy_shoot()		
#	if Input.is_action_just_released("click"):
#		weapon_manager.find_stop()
	
	# Reloading
	if Input.is_action_just_pressed("reload"):
		weapon_manager.reload()
	
	
func detection_enemy_shoot():
	if(normal.is_colliding()):
		var col = normal.get_collider()
		if(col.is_in_group("Enemy")):
			col.call("dead")
			
func setState(astate):
	state = astate
	match state:
		STATE_IDLE:
			pass
		STATE_MOVE:
			pass
		STATE_DASH:
			pass
		STATE_DYNG:
			pass
		STATE_DEAD:
			pass

#funciones de entrada y salida de estado 
#se usan cuando se pasan de estado sea se entra y se 
#setean o configuran cosas o se sale para modificar o 
#ejecutar cosas a la hora de salir de estos
#TODO:Esquematizar las funciones pero no implementarlas ahora
#TODO:Revisar si es viable para este vertical slide
#func state_entered(state):
#	match state:
#		STATE_IDLE:
#			pass
#		STATE_MOVE:
#			pass
#		STATE_DASH:
#			pass
#		STATE_DYNG:
#			pass
#		STATE_DEAD:
#			pass
			
#func state_exit(state):
#	match state:
#		STATE_IDLE:
#			pass
#		STATE_MOVE:
#			pass
#		STATE_DASH:
#			pass
#		STATE_DYNG:
#			pass
#		STATE_DEAD:
#			pass

#funcion de muerte	
#func dying():
#

func in_on_leadge():
		
#	update_Print("entra")
	if DetectionUp.is_colliding():
#		update_Print("entra")
		is_on_leadge = true
		subir()
	elif DetectionDown.is_colliding():
#		update_Print("entra")
		is_on_leadge = true
		subir()

func is_fallen():
	return is_on_floor()
	

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

func pickUp_functiion():
	#	esto es for que recorre y chequea los objetos que coliciona pudiendo chequear y actuar que se esta collisionando algo muy importante
#   En esto sse colicciona con objetos de mundo, como cajas,
#   esto tambien es usado para el sistema de pickup
	for idx in get_slide_count():
		var collision = get_slide_collision(idx)
#		if collision.collider.is_in_group("bodies"):
#			collision.collider.apply_central_impulse(-collision.normal * velocity.length() * push)
		if collision.collider.is_in_group("weapon"):
				var weapon_data = collision.collider.call("get_weapon_pickup_data")
				weapon_manager.add_weapon(weapon_data)
				collision.collider.queue_free()
#			elif collision.collider.call("get_type") == "ShootGun":
#				collision.collider.queue_free()
#			elif collision.collider.call("get_type") == "MachineGun":
#				collision.collider.queue_free()
