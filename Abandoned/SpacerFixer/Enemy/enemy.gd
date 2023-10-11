extends CharacterBody3D

var spd = randf_range(20,50)

func _physics_process(delta):
	set_velocity(Vector3(0,0,spd))
	move_and_slide()
	if transform.origin.z > 10:
	  queue_free()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
