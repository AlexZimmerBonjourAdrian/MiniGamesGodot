extends RigidBody

var dropped = false

func _process(delta):
	if dropped == true:
		apply_impulse(transform.basis.z, -transform.basis.z * 10)
		dropped = false
		
func get_type() -> String: 
	return "MachineGun"
