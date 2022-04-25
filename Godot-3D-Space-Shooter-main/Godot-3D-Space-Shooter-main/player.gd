extends KinematicBody

const MAXSPEED = 30
const ACCELERATION = 0.75
var inputVector = Vector3()
var velo = Vector3()
var cooldown = 0
const COOLDOWN = 8
var dash_speed = 60
var Aceleration_Multi = 5

onready var guns = [$Gun0, $Gun1]
#onready var missile = [$Missile1, $Missile2]

onready var main = get_tree().current_scene
var Bullet = load("res://Bullet.tscn")
var Missile = load("res://Weapon/Rocket/Rocket.tscn")

func _physics_process(delta):
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
	
#	Shooting missile
#	if Input.is_action_pressed("ShootRocket") and cooldown <= 0:
#		cooldown = COOLDOWN * delta
#		for j in missile:
#			var missile = Missile.instance()
#			main.add_child(missile)
#			missile.transform = j.global_transform
#			missile.velo = missile.transform.basis.z * -600
#
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
#	dash aplication to input
#	if(Input.is_action_just_pressed("dash")):
#		velo.x = move_toward(velo.x, inputVector.x * (MAXSPEED + dash_speed), ACCELERATION * Aceleration_Multi )
#		velo.y = move_toward(velo.y, inputVector.y *(MAXSPEED + dash_speed), ACCELERATION * Aceleration_Multi )
		

#func impulseDash():
#	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") * dash_speed
#	inputVector.y = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")  * dash_speed
#	inputVector
