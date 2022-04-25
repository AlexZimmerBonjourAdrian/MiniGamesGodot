extends Spatial

var enemy_1 = preload("res://Enemy/Enemy_1.tscn")
var	enemy_2 = preload("res://Enemy/Enemy_2.tscn")
var enemy_3 = preload("res://Enemy/Enemy_3.tscn")
var enemy_4 = preload("res://Enemy/Enemy_4.tscn")
var enemy_5 = preload("res://Enemy/Enemy_5.tscn")

var _EnemyList = []
onready var main = get_tree().current_scene
func _ready():
	pass

	
func _process(delta):
	for i in _EnemyList:
		if (_EnemyList[i] == null ):
			_EnemyList.remove(i)
func spawn():
			var enemy = enemy_1.instance()
			_EnemyList.append(enemy)
			main.add_child(enemy)
			enemy.transform.origin = transform.origin + Vector3(rand_range(-15,15), rand_range(-10,10), 0)
