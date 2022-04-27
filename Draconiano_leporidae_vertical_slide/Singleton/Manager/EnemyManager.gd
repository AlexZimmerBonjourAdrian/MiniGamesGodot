extends Spatial

#TODO:Remplantear y soluccionar mas adelante
#Ver el tema del error de llamada de noexiste function

var enemy_1 = preload("res://LevelTest/levels/EnemyLevelsTest/EnemyPath.tscn")
var _EnemyList = []

onready var main = get_tree().current_scene

func instantiate_node(packed_scene, pos = null, parent = null):
	var clone = packed_scene.instance()

	var root = get_tree().root
	if parent == null:	
		parent = root.get_child(root.get_child_count()-1)

	parent.add_child(clone)

	if pos != null:
		clone.global_transform.origin = pos

	return clone

func _input(event):
	if (event.is_action_pressed("ui_accept")):
		spawn()

func spawn():
		var enemy = enemy_1.instance()
		_EnemyList.append(enemy)
		main.add_child(enemy)
		
