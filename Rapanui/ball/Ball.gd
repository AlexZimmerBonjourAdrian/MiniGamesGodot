extends RigidBody2D

var game_started : bool = false

func _input(event):
	if event.is_action_pressed("iniciar") and not game_started:
			linear_velocity = Vector2(50,-200)
			game_started = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var bodies_colliding = get_colliding_bodies()
	for body in bodies_colliding:
		if body.is_in_group("gr_blocks"):
			body.queue_free()
			if body.get_parent().get_child_count() == 1:
				print("GANA")
				queue_free()
		elif body.get_name() == "border_bot":
			print("PIERDE")
			queue_free()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
