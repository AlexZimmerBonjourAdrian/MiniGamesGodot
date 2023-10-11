extends Node3D

@onready var main = get_tree().current_scene
var Enemy = load("res://Enemy/enemy.tscn")

func spawn():
	var enemy = Enemy.instantiate()
	main.add_child(enemy)
	enemy.transform.origin = transform.origin + Vector3(randf_range(-15,15), randf_range(-10,10),0)
	
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	spawn()# Replace with function body.
