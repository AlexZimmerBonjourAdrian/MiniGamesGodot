extends CharacterBody3D


var velo = Vector3()

func _physics_process(delta):
	set_velocity(velo)
	move_and_slide()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body.is_in_group("Enemys"):
		body.queue_free()
