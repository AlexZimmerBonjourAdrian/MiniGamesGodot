extends KinematicBody


const SPEED = 50
var inputVector = Vector3()
var velo = Vector3()

func _physics_process(delta):
	constant_move()
	
func constant_move():
	print("Entra")
	velo.z = move_toward(velo.z, inputVector.z * SPEED, 0.2)
