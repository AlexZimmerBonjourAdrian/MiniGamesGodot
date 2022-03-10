extends Node2D

var spawn_position = null

var Enemy = preload("res://enemy/Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_position = $SpawnPosition.get_children()
	pass # Replace with function body.
	
func spawn_enemy():
	var enemy = Enemy.instance()
	add_child(enemy)
