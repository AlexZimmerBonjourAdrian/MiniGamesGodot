extends KinematicBody

#export var speed = 5
#
#var path = []
#var cur_path_idx = 0
#var velocity = Vector3.ZERO
#var threshold = .1
#
#onready var nav = get_parent()
##onready var nav
#
#func _physics_process(delta):
#	if path.size() > 0:
#		move_to_target()
#
#func move_to_target():
#	if global_transform.origin.distance_to(path[cur_path_idx]) < threshold:
#		path.remove(0)
#	else:
#		var direction = path[cur_path_idx] - global_transform.origin
#		velocity = direction.normalized() * speed
#		move_and_slide(velocity, Vector3.UP)
#
#func get_target_path(target_pos):
#	path = nav.get_simple_path(global_transform.origin, target_pos)


#var path = []
#var path_node = 0
#
#var speed = 1000
#var player = null
#onready var nav = get_parent()
#
#func _ready():
#	pass
#
#func _physics_process(delta):
#	if path_node < path.size():
#		var direction = (path[path_node]-global_transform.origin)
#		if direction.length() < 1:
#			path_node += 1	
#		else:
#			move_and_slide(direction.normalized() * speed, Vector3.UP)
#			move_to(player.global_transform.origin)
#
#func move_to(target_pos):
#	path = nav.get_simple_path(global_transform.origin, target_pos)
#	path_node = 0
#
##func _on_Timer_timeout():
##	move_to(player.global_transform.origin)
##
#
#func set_player(p):
#	player = p
#	if raycast.is_colliding():
#		var hit = raycast.get_collider()
#		if hit.is_in_group("Player"):
#			print("hit")

#enum {
#	IDLE,
#	ALERT,
#	STUNNED	
#}
#
#var state = IDLE
#
#var target
#
#const TURN_SPEED = -2
#
#var target_rotation = Vector3();
#
#onready var raycast = $RayCast
#onready var ap = $AnimationPlayer
#onready var eyes = $Eyes
#onready var shoottimer = $ShootTimer
#
#func _ready():
#	pass
#
#func _on_SightRange_body_entered(body):
#	if body.is_in_group("Player"):
#		state = ALERT
#		target = body
##		shoottimer.start()
#func _on_SightRange_body_exited(body):
#	state = IDLE
##	shoottimer.stop()
#
#func _process(delta):
#
#	match state:
#		IDLE:
#			ap.play("Idle")
#		ALERT:
#			ap.play("Alert")
#			eyes.look_at(target.global_transform.origin, Vector3.UP)
#
#

#
#
#




