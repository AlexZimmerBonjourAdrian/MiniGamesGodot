extends KinematicBody


var velocity = Vector3.ZERO
var threshold = .1
var is_dead = false
var player = null
export var gravity = -40
var target

const TURN_SPEED=2



export var speed = 5

func _physics_process(delta):
	apply_gravity(delta)



func get_player():
		target = player


func apply_gravity(delta):
	velocity.y += gravity * delta
	velocity.y = clamp(velocity.y, gravity, 10)

