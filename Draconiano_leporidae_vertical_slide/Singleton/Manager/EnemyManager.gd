extends Node

var enemy_1 = preload("res://LevelTest/levels/EnemyLevelsTest/EnemyPath.tscn")
var EnemyList = []


func instantiate_node(packed_scene, pos = null, parent = null):
	var clone = packed_scene.instance()
	
	var root = get_tree().root
	if parent == null:	
		parent = root.get_child(root.get_child_count()-1)
	
	parent.add_child(clone)
	
	if pos != null:
		clone.global_transform.origin = pos
		
	return clone

func _ready():
	Global.node_creation_parent = self

func _exit_tree():
	Global.node_creation_parent = null	



func spawn():
	pass
