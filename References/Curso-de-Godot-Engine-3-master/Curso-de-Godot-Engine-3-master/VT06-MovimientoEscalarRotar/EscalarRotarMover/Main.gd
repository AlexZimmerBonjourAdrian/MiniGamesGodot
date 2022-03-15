extends Node

var can_rotate = false
var can_scale = false
var can_move = false

const SPEED = 20

func _ready():
	pass
	
func _process(delta):
	if can_move:
		$icon.position.x += SPEED * delta * 10
	if can_scale:
		$icon.scale += Vector2(SPEED * delta, SPEED * delta)
	if can_rotate:
		get_node("icon").rotation += SPEED * delta
		set_rot()
		get_rot()

func _on_Mover_pressed():
	can_move = true

func _on_Escalar_pressed():
	can_scale = true

func _on_Rotar_pressed():
	can_rotate = true
