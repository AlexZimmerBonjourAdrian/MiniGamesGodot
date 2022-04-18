extends KinematicBody

export var speed = 5

var path = []
var cur_path_idx = 0
var velocity = Vector3.ZERO
var threshold = .1

enum {
	STATE_STAND,
	STATE_PATRULLA,
	STATE_FOLLOW,
	STATE_SHOOT_PLAYER,
	STATE_SCARE
}

export var state=STATE_FOLLOW

onready var nav = get_parent()

func _physics_process(delta):
	if path.size() > 0:
		move_to_target()
		
func move_to_target():
	setState(STATE_FOLLOW)
	
func get_target_path(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)

func setState(astate):
	state=astate
	match state:
		STATE_STAND:
			pass
		STATE_FOLLOW:
			if global_transform.origin.distance_to(path[cur_path_idx]) < threshold:
				path.remove(0)
			else:
				var direction = path[cur_path_idx] - global_transform.origin
				velocity = direction.normalized() * speed
				move_and_slide(velocity, Vector3.UP)
		STATE_PATRULLA:
			pass
		STATE_SHOOT_PLAYER:
			pass
		STATE_SCARE:
			pass


