extends "res://PlayerGeneric.gd"

var plane_data = load("res://ScriptableObject/Plane.tres")
var guard_data = load("res://ScriptableObject/Guardian.tres")
var battleloid_data = load("res://ScriptableObject/Battleloid.tres")

onready var guns = [$Gun0, $Gun1]
#onready var missile = [$Missile1, $Missile2]

enum {
	STATE_PLANE = 1,
	STATE_GUARDIAN = 2,
	STATE_ROBOT = 3
}

var state = 0

func _ready():
	setState(STATE_PLANE)

onready var main = get_tree().current_scene
var Bullet = load("res://Bullet.tscn")
var Missile = load("res://Weapon/Rocket/Rocket.tscn")

func _physics_process(delta):
	match state:
		STATE_PLANE:
			playerControllerPlane()
			shoot(delta)
		STATE_GUARDIAN:
			playerControllerGuardian()
			shoot(delta)
		STATE_ROBOT:
			playerControllerRobot(delta)
			shoot(delta)
			
	changeForm()
#	Shooting missile
#	if Input.is_action_pressed("ShootRocket") and cooldown <= 0:
#		cooldown = COOLDOWN * delta
#		for j in missile:
#			var missile = Missile.instance()
#			main.add_child(missile)
#			missile.transform = j.global_transform
#			missile.velo = missile.transform.basis.z * -600
#
	
#	dash aplication to input
#	if(Input.is_action_just_pressed("dash")):
#		velo.x = move_toward(velo.x, inputVector.x * (MAXSPEED + dash_speed), ACCELERATION * Aceleration_Multi )
#		velo.y = move_toward(velo.y, inputVector.y *(MAXSPEED + dash_speed), ACCELERATION * Aceleration_Multi )
		

#func impulseDash():
#	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") * dash_speed
#	inputVector.y = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")  * dash_speed
#	inputVector



func playerControllerPlane():
	#	constant_move()
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	inputVector = inputVector.normalized()
	velo.x = move_toward(velo.x, inputVector.x * MAXSPEED, ACCELERATION)
	velo.y = move_toward(velo.y, inputVector.y * MAXSPEED, ACCELERATION)
	rotation_degrees.z = velo.x * -2
	rotation_degrees.x = velo.y / 2
	rotation_degrees.y = -velo.x / 2
	move_and_slide(velo)
	transform.origin.x = clamp(transform.origin.x, -15, 15)
	transform.origin.y = clamp(transform.origin.y, -10, 10)

func shoot(delta):
	#shooting gun
	if Input.is_action_pressed("ui_accept") and cooldown <= 0:
		cooldown = COOLDOWN * delta
		for i in guns:
			var bullet = Bullet.instance()
			main.add_child(bullet)
			bullet.transform = i.global_transform
			bullet.velo = bullet.transform.basis.z * -600
			
	#cooldown
	if cooldown > 0:
		cooldown -= delta

#func guardianControllerModel():
	
	
func shootMissile():
	pass
#	if Input.is_action_pressed("ShootRocket"):
#		for i in guns:
#			var bullet = Bullet.instance()
func playerControllerGuardian():

	print("Entra en modo Guardian")
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	inputVector = inputVector.normalized()
	velo.x = move_toward(velo.x, inputVector.x * guard_data.MAXSPEED, guard_data.ACCELERATION)
	velo.y = move_toward(velo.y, inputVector.y * guard_data.MAXSPEED, guard_data.ACCELERATION)
	rotation_degrees.z = velo.x * -2
	rotation_degrees.x = velo.y * 1.5
	rotation_degrees.y = -velo.x * 2
	move_and_slide(velo)
	transform.origin.x = clamp(transform.origin.x, -15, 15)
	transform.origin.y = clamp(transform.origin.y, -10, 10)
	
	
func playerControllerRobot(delta):
	print("Entra en modo Batteloid")
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	inputVector = inputVector.normalized()
	velo.x = move_toward(velo.x, inputVector.x * battleloid_data.MAXSPEED, battleloid_data.ACCELERATION)
	velo.y = move_toward(velo.y, inputVector.y * battleloid_data.MAXSPEED, battleloid_data.ACCELERATION)
#	rotation_degrees.z = get_viewport().get_viewport().get_mouse_position().x *-2
#	rotation_degrees.x = get_viewport().get_viewport().get_mouse_position().y * 2
#	rotation_degrees.y = -get_viewport().get_viewport().get_mouse_position().y +  battleloid_data.turn_speed
	
	move_and_slide(velo)
#	aimToMouse()
	transform.origin.x = clamp(transform.origin.x, -15, 15)
	transform.origin.y = clamp(transform.origin.y, -10, 10)
	rotation_degrees.z = clamp(rotation_degrees.z, -120, 120)
	rotation_degrees.x = clamp(rotation_degrees.x, -120, 120)
	rotation_degrees.y = clamp(rotation_degrees.y, -120, 120)
	
	
func setState(aState):
	state=aState

func changeForm():
	if(Input.is_action_just_pressed("Plane_Form")):
		setState(STATE_PLANE)
	elif Input.is_action_just_pressed("Guard_Form"):
		setState(STATE_GUARDIAN)
	elif Input.is_action_just_pressed("Battleloid_Form"):
		setState(STATE_ROBOT)
	
	
#func aimToMouse():
	
