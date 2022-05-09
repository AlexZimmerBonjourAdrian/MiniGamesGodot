extends Spatial

onready var main = get_tree().current_scene
var Enemy = load("res://Enemy.tscn")
var Enemy_1 = load("res://Enemy/Enemy_1.tscn")
var Enemy_2 = load("res://Enemy/Enemy_2.tscn")
var Enemy_3 = load("res://Enemy/Enemy_3.tscn")
var Enemy_4 = load("res://Enemy/Enemy_4.tscn")
var Enemy_5 = load("res://Enemy/Enemy_5.tscn")
func spawn():
	var enemy = Enemy.instance()
	main.add_child(enemy)
	enemy.transform.origin = transform.origin + Vector3(rand_range(-15,15), rand_range(-10,10), 0)
	
	
	
func _on_Timer_timeout():
	spawn()

func SpawnRandom():
	var rand = rand_range(0,4)
	if(rand == 0):
		var enemy = Enemy_1.instance()
		main.add_child(enemy)
		enemy.transform.origin = transform.origin + Vector3(rand_range(-15,15), rand_range(-10,10), 0)
	elif(rand == 1):
		var enemy = Enemy_2.instance()
		add_child(enemy)
		enemy.transform.origin = transform.origin + Vector3(rand_range(-15,15), rand_range(-10,10), 0)
	elif(rand == 2):
		var enemy = Enemy_3.instance()
		add_child(enemy)
		enemy.transform.origin = transform.origin + Vector3(rand_range(-15,15), rand_range(-10,10), 0)
	elif(rand == 3):
		var enemy = Enemy_4.instance()
		add_child(enemy)
		enemy.transform.origin = transform.origin + Vector3(rand_range(-15,15), rand_range(-10,10), 0)
	elif(rand == 4):
		var enemy = Enemy_5.instance()
		add_child(enemy)
		enemy.transform.origin = transform.origin + Vector3(rand_range(-15,15), rand_range(-10,10), 0)
func _on_SpawnSpecialEnemy_timeout():
		SpawnRandom()
