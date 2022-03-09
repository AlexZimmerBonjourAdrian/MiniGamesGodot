extends RigidBody2D

var game_started : bool = false

func _input(event):
		if event.is_action_pressed("iniciar") and not game_started:
			linear_velocity = Vector2(50,-200)
			game_started = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
