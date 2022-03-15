extends RigidBody2D

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		self.apply_impulse(Vector2(0, 0), Vector2(5, 0))
	elif Input.is_action_pressed("ui_left"):
		self.apply_impulse(Vector2(0, 0), Vector2(-5, 0))
	if Input.is_action_pressed("ui_up"):
		self.apply_impulse(Vector2(0, 0), Vector2(0, -5))
	elif Input.is_action_pressed("ui_down"):
		self.apply_impulse(Vector2(0, 0), Vector2(0, 5))