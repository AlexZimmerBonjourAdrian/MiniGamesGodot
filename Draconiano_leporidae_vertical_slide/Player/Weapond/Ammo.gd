extends Node

onready var camera = $Camera
onready var weapon_manager = $camera/Weapons

func process_weapons():
	
	if Input.is_action_just_pressed("Empty"):
		weapon_manager.change_weapon("Empty")
	if Input.is_action_just_pressed("primary"):
		weapon_manager.change_weapon("Primary")
	if Input.is_action_just_pressed("Secundary"):
		weapon_manager.change_weapon("secundary")
	
func _physics_process(delta):
	process_weapons()



