extends "res://Herarchy/EnemyGeneric.gd"



onready var eyes = $Eyes

onready var raycast = $Eyes/RayCast
onready var nav = get_parent()
#var target_pos = null

enum {
	STATE_STAND,
	STATE_PATRULLA,
	STATE_FOLLOW,
	STATE_SHOOT_PLAYER,
	STATE_SCARE,
	STATE_DEAD
}
export var state= STATE_STAND
var path = []
var cur_path_idx = 0

func get_target_path(target_pos_func):
#	target_pos = target_pos_func
	if(target_pos_func != null):
		print("Entra en el nav")
		path = nav.get_simple_path(global_transform.origin, target_pos_func)
#	else:
#		get_player()
#		path = nav.get_simple_path(global_transform.origin, target.global_transform.origin)
#func process():
#	global_transform.origin.distance_to(path[cur_path_idx])
#func _process(delta):
#	if(state==STATE_FOLLOW):
##		if path.size() > 0:
#		move_to_target()
#	if (state==STATE_SHOOT_PLAYER):
#		setState(STATE_SHOOT_PLAYER)
#
func _physics_process(delta):
	._physics_process(delta)
func move_to_target():
	setState(STATE_FOLLOW)
	
	
func setState(astate):
	state=astate
	match state:
		STATE_STAND:
			update_Print("Estado Stand")
		STATE_FOLLOW:
#				update_print("Estado seguir")
#				print(global_transform.origin.distance_to(path[cur_path_idx]))
			
				if(path.size() > 0):
					if global_transform.origin.distance_to(path[cur_path_idx]) < threshold:
						path.remove(0)
						
					else:
						var direction = path[cur_path_idx] - global_transform.origin
						velocity = direction.normalized() * speed
						move_and_slide(velocity, Vector3.UP)
					
						if(player.is_fallen() == false):
							setState(STATE_SHOOT_PLAYER)
						elif(global_transform.origin.distance_to(path[cur_path_idx]) < .06):
							setState(STATE_SHOOT_PLAYER)
					
					
		STATE_PATRULLA:
			pass
		STATE_SHOOT_PLAYER:
#			var direction = path[cur_path_idx] - global_transform.origin
#			var dir = direction.normalized()
#			update_ExtraData("Estado_seguir")
#			print(global_transform.origin.distance_to(path[cur_path_idx]))
#			if(not(path[cur_path_idx] <= .0)):
			if(path.size() > 0):
				if(global_transform.origin.distance_to(path[cur_path_idx]) > .06 ):
					setState(STATE_FOLLOW)
				print(global_transform.origin.distance_to(path[cur_path_idx]))
#				update_Print()
				
				
#			elif(player.is_fallen() == false): 
				get_player()
#			update_Print(global_transform.origin.direction_to())
#			var dir = direction.normalized()
				eyes.look_at(target.global_transform.origin, Vector3.UP)
				rotate_y(deg2rad(eyes.rotation.y * TURN_SPEED))
				rotate_z(deg2rad(eyes.rotation.z * TURN_SPEED))
			
#			update_Print(global_transform.origin.distance_to(path[cur_path_idx]))
#			update_ExtraData("Estado disparar")
			
		STATE_SCARE:
				pass
			
			
		STATE_DEAD:
#			supdate_Print("Estoy Muerto")
#			visible = false
			queue_free()
			
func dead():
	update_Print("Estoy Muerto")
	setState(STATE_DEAD)

func _on_ShootTimer_timeout():
	if raycast.is_colliding():
		var hit = raycast.get_collider()
		if hit.is_in_group("Player"):
			print("Hit")

func set_player(p):
	player = p
func update_ExtraData(ExtraData):
	$Control/Background/ExtraData.text = String(ExtraData)
func update_Print(testprinter):
	$Control/Background/Print.text = String(testprinter)
#	$Control/Background/ExtraData.text = String(extradata)
#function Prototype para crear balas 
#Todo:Cambiar el tipo de disparo segun el arma
func _on_Area_body_entered(body):
	 # Replace with function body.
	if body.is_in_group("Player"):
		setState(STATE_SHOOT_PLAYER)

