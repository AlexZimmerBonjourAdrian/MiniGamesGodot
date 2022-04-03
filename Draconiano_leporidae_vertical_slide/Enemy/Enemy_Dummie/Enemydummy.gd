extends KinematicBody

enum {
	IDLE,
	ALERT,
	STUNNED	
}

var state = IDLE

onready var raycast = $Armature/RayCast
onready var ap = $AnimationPlayer


func _ready():
	pass
	
func _process(delta):
	
	if raycast.is_colliding():
		state = ALERT
	elif (Input.is_action_pressed("click")):
		state = STUNNED
	else:
		state = IDLE
		
	match state:
		IDLE:
			ap.play("Idle")
		ALERT:
			ap.play("Alert")
		STUNNED:
			ap.play("Stunned")
	if state == IDLE:
		ap.play("Idle")
	elif state == ALERT:
		ap.play("Alert")
	elif state == STUNNED:
		ap.play("Stunned")	
