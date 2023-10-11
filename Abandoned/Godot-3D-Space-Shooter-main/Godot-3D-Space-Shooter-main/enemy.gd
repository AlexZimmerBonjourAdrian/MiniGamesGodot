extends CharacterBody3D

var spd = randf_range(20,50)

func _physics_process(delta):
	set_velocity(Vector3(0,0,spd))
	move_and_slide()
	if transform.origin.z > 10:
		queue_free()
