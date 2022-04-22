extends KinematicBody

export var speed = 5

var path = []
var cur_path_idx = 0
var velocity = Vector3.ZERO
var threshold = .1
var is_dead = false
var player = null



enum {
	STATE_STAND,
	STATE_PATRULLA,
	STATE_FOLLOW,
	STATE_SHOOT_PLAYER,
	STATE_SCARE,
	STATE_DEAD
}

var target

const TURN_SPEED=2

export var state=STATE_STAND

onready var nav = get_parent()

onready var eyes = $Eyes

onready var raycast = $Eyes/RayCast


#func process():
#	global_transform.origin.distance_to(path[cur_path_idx])
func _physics_process(delta):
	if(state==STATE_FOLLOW):
		if path.size() > 0:
			move_to_target()
	if (state==STATE_SHOOT_PLAYER):
		setState(STATE_SHOOT_PLAYER)
	
func move_to_target():
		setState(STATE_FOLLOW)
	
func get_target_path(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)

func get_player():
		target = player
	
#func detected():
		
func setState(astate):
	state=astate
	match state:
		STATE_STAND:
			update_Print("Estado Stand")
		STATE_FOLLOW:
			if global_transform.origin.distance_to(path[cur_path_idx]) < threshold:
				path.remove(0)
				
			else:
				var direction = path[cur_path_idx] - global_transform.origin
				velocity = direction.normalized() * speed
				move_and_slide(velocity, Vector3.UP)
				update_Print("Seguir player")
				if(global_transform.origin.distance_to(path[cur_path_idx]) < .05):
					setState(STATE_SHOOT_PLAYER)
		STATE_PATRULLA:
			pass
		STATE_SHOOT_PLAYER:
#			var direction = path[cur_path_idx] - global_transform.origin
#			var dir = direction.normalized()
#			update_Print("Shoot Player", direction)
			if(global_transform.origin.distance_to(path[cur_path_idx]) > .02):
				setState(STATE_FOLLOW)
			else: 
				get_player()
				update_Print("Disparar player")
#			var dir = direction.normalized()
				eyes.look_at(target.global_transform.origin, Vector3.UP)
				rotate_y(deg2rad(eyes.rotation.y * TURN_SPEED))
			
			
		STATE_SCARE:
				pass
			
			
		STATE_DEAD:
#			supdate_Print("Estoy Muerto")
#			visible = false
			queue_free()
			
func dead():
	update_Print("Estoy Muerto")
	setState(STATE_DEAD)

func _on_Area_body_entered(body):
	 # Replace with function body.
	if body.is_in_group("Player"):
		setState(STATE_FOLLOW)


func _on_ShootTimer_timeout():
	if raycast.is_colliding():
		var hit = raycast.get_collider()
		if hit.is_in_group("Player"):
			print("Hit")

func set_player(p):
	player = p
func update_Print(testprinter):
	$Control/Background/Print.text = String(testprinter)
#	$Control/Background/ExtraData.text = String(extradata)
#function Prototype para crear balas 
#Todo:Cambiar el tipo de disparo segun el arma
