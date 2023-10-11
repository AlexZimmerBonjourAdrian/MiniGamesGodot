extends CharacterBody3D

const MAXSPEED = 30
const ACCELERATION = 0.75
var inputVector = Vector3()
var velo = Vector3()
var cooldown = 0
const COOLDOWN = 3
@onready var guns = [$Gun1]
@onready var main = get_tree().current_scene
var Bullet = load("res://Elements/Bullet.tscn")

func _physics_process(delta):
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	inputVector = inputVector.normalized()
	velo.x = move_toward(velo.x, inputVector.x * MAXSPEED, ACCELERATION)
	velo.y = move_toward(velo.y, inputVector.y * MAXSPEED, ACCELERATION)
	rotation_degrees.z = velo.x * -2
	rotation_degrees.x = velo.y / 2
	rotation_degrees.y = -velo.x / 2
	set_velocity(velo)
	move_and_slide()
	transform.origin.x = clamp(transform.origin.x, -15,15)
	transform.origin.y = clamp(transform.origin.y, -10,10)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#shooting
	if Input.is_action_just_pressed("ui_accept") and cooldown == 0:
		cooldown = COOLDOWN * delta
		for i in guns:
			var bullet = Bullet.instantiate()
			var position = i.global_transform
			main.add_child(bullet)
			bullet.transform = position
			bullet.velo = bullet.transform.basis.z * -600
# Called when the node enters the scene tree for the first time.
	if cooldown > 0:
		cooldown -= delta
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
